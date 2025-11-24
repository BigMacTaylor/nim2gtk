# https://gstreamer.freedesktop.org/documentation/tutorials/basic/hello-world.html?gi-language=c
# nim c gstExample_03.nim

import nim2gtk/[gtk, gst, glib]
import nim2gtk/[gdk, gobject, gio]

# Structure to contain all our information,
# so we can pass it around.
type CustomData = object
  playbin: Element
  slider: Scale
  sinkWidgetVal: Value
  sliderSigID: culong
  state: State
  duration: uint64

proc onMessage(bus: Bus, msg: Message, data: CustomData) =
  # Callback function to handle messages from the GStreamer bus.
  let typ = msg.getType()

  if typ == {gst.MessageFlag.error}:
    var err: ptr glib.Error
    var debug_info: string
    msg.parseError(err, debug_info)
    echo "Error received from element " & $msg.getType() & ": " & $err.message & "\n"
    stderr.write("Debugging information: " & debug_info & "\n")
    discard gst.setState(data.playbin, gst.State.ready)
  if typ == {gst.MessageFlag.eos}:
    stdout.write("End-Of-Stream reached.\n")
    discard gst.setState(data.playbin, gst.State.ready)
  else:
    discard

proc onPlay(btn: Button, data: CustomData) =
  discard gst.setState(data.playbin, gst.State.playing)

proc onPause(btn: Button, data: CustomData) =
  discard gst.setState(data.playbin, gst.State.paused)

proc onStop(btn: Button, data: CustomData) =
  discard gst.setState(data.playbin, gst.State.ready)

proc refreshUI(data: CustomData): gboolean {.cdecl.} =
  # TODO Fixme
  let current: int64 = -1

  echo data.duration
  var timeDur: int64 = 0
  echo timeDur
  #if queryDuration(data.playbin, Format.time, timeDur):
  # echo "true"
  echo timeDur

  # We don't want to update anything unless we are PAUSED or PLAYING
  if data.state.ord < gst.State.paused.ord:
    return gboolean(1)
  #[
  # If we didn't know it yet, query the stream duration
  if queryDuration(data.playbin, Format.time, cast[var int64](data.duration)):
    # Set the range of the slider to the clip duration, in SECONDS */
    setRange(cast [Range](data.slider), cdouble(0), cdouble(cast[var int64](data.duration) div SECOND));
  else:
    echo "Could not query current duration.\n"
]#
  return gboolean(1)

proc closeEvent(window: ApplicationWindow, event: gdk.Event, app: Application): bool =
  quit(app)

proc onSlider(slider: Scale, data: CustomData) =
  let value: cdouble = getValue(cast[Range](data.slider))
  let seekPos: int64 = int64(value) * SECOND div 2
  let flags = SeekFlags.flush.ord or SeekFlags.keyUnit.ord
  discard seekSimple(data.playbin, Format.time, cast[SeekFlags](flags), seekPos)

proc createUI(app: Application, data: var CustomData) =
  let window = newApplicationWindow(app)
  window.title = "nimplayer"
  window.defaultSize = (640, 480)
  window.connect("delete-event", closeEvent, app)

  let playButton =
    gtk.newButtonFromIconName("media-playback-start", IconSize.smallToolbar.ord)
  playButton.connect("clicked", onPlay, data)
  let pauseButton =
    gtk.newButtonFromIconName("media-playback-pause", IconSize.smallToolbar.ord)
  pauseButton.connect("clicked", onPause, data)
  let stopButton =
    gtk.newButtonFromIconName("media-playback-stop", IconSize.smallToolbar.ord)
  stopButton.connect("clicked", onStop, data)

  data.slider = newScaleWithRange(Orientation.horizontal, 0, 100, 1)
  setDrawValue(data.slider, false)
  data.sliderSigID = data.slider.connect("value-changed", onSlider, data)

  let controlBox = newBox(Orientation.horizontal)
  controlBox.packStart(playButton, false, false, 2)
  controlBox.packStart(pauseButton, false, false, 2)
  controlBox.packStart(stopButton, false, false, 2)
  controlBox.packStart(data.slider, true, true, 2)

  let widgetObj = getObject(data.sinkWidgetVal)
  let sinkWidget: Widget = cast[Widget](widgetObj)

  let videoBox = newBox(Orientation.horizontal)
  videoBox.packStart(sinkWidget, true, true, 0)

  let mainBox = newBox(Orientation.vertical)
  mainBox.packStart(videoBox, true, true, 0)
  mainBox.packStart(controlBox, false, false, 0)

  window.add(mainBox)
  window.showAll()

proc destroyNotify(data: pointer) {.cdecl.} =
  echo "destroyNotify"

proc appActivate(app: Application) =
  var data: CustomData
  var ret: StateChangeReturn
  var bus: Bus
  var gtkglsink, videosink: Element

  # Initialize GStreamer
  gst.init()

  # Initialize data
  #data.duration = CLOCK_TIME_NONE;
  data.duration = 0

  # Create the elements
  data.playbin = make("playbin", "playbin")
  videosink = make("glsinkbin", "glsinkbin")
  gtkglsink = make("gtkglsink", "gtkglsink")

  # Here we create the GTK Sink element which will provide us with a GTK widget where
  # GStreamer will render the video at and we can add to our UI.
  # Try to create the OpenGL version of the video sink, and fallback if that fails
  if not videosink.isNil and not gtkglsink.isNil:
    echo "Successfully created GTK GL Sink"
    videosink.setProperty("sink", newValue(gtkglsink))
    # The gtkglsink creates the gtk widget for us. This is accessible through
    # a property. So we get it and use it later in our gui.
    gtkglsink.getProperty("widget", data.sinkWidgetVal)
  else:
    echo "Could not create gtkglsink, falling back to gtksink.\n"
    videosink = make("gtksink", "gtksink")
    videosink.getProperty("widget", data.sinkWidgetVal)

  assert not data.playbin.isNil and not videosink.isNil, "Could not create all elements"

  # Set the URI to play
  let uriVal =
    newValue("https://gstreamer.freedesktop.org/media/sintel_trailer-480p.webm")
  data.playbin.setProperty("uri", uriVal)

  # Set the video-sink
  data.playbin.setProperty("video-sink", newValue(videosink))

  # Create the GUI
  app.createUI(data)

  # Instruct the bus to emit signals for each received message
  bus = gst.getBus(data.playbin)
  bus.addSignalWatch()
  bus.connect("message", onMessage, data)

  # Start playing
  ret = gst.setState(data.playbin, gst.State.playing)
  if ret == failure:
    echo "Unable to set the pipeline to the playing state.\n"
    data.playbin.unref()
    videosink.unref()
    return

  # Register a function that GLib will call every second
  discard timeoutAddSeconds(0, 1, cast[SourceFunc](refreshUI), data.addr, destroyNotify)

proc main() =
  let app = newApplication("org.gtk.example")

  connect(app, "activate", appActivate)
  discard app.run()

when isMainModule:
  main()

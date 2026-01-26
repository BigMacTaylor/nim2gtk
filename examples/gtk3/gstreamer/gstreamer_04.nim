# https://gstreamer.freedesktop.org/documentation/tutorials/basic/toolkit-integration.html?gi-language=c
# GUI toolkit integration example
# nim c gstreamer_04.nim

import nim2gtk/[gtk, gst, glib]
import nim2gtk/[gdk, gobject, gio]

# Structure to contain all our information, so we can pass it to callbacks
type CustomData = ref object
  playbin: Element
  slider: Scale
  sinkWidgetVal: Value
  sliderSigID: culong
  state: State
  duration: int64

# This function is called when the PLAY button is clicked
proc onPlay(btn: Button, data: CustomData) =
  discard gst.setState(data.playbin, gst.State.playing)

# This function is called when the PAUSE button is clicked
proc onPause(btn: Button, data: CustomData) =
  discard gst.setState(data.playbin, gst.State.paused)

# This function is called when the STOP button is clicked
proc onStop(btn: Button, data: CustomData) =
  discard gst.setState(data.playbin, gst.State.ready)

# This function is called when the main window is closed
proc closeEvent(window: ApplicationWindow, event: gdk.Event, data: CustomData): bool =
  discard gst.setState(data.playbin, gst.State.ready)
  close(window)

# This function is called when the slider changes its position.
# We perform a seek to the new position here.
proc onSlider(slider: Scale, data: CustomData) =
  let value: cdouble = getValue(cast[Range](data.slider))
  let seekPos: int64 = int64(value) * SECOND
  let flags = cast[SeekFlags](SeekFlags.flush.ord or SeekFlags.keyUnit.ord)
  discard seekSimple(data.playbin, Format.time, flags, seekPos)

# This function creates all the GTK widgets that compose our application,
# and registers the callbacks
proc createUI(app: Application, data: CustomData) =
  # The uppermost window can only hold one child widget directly
  let window = newApplicationWindow(app)
  window.title = "Gst Example"
  window.defaultSize = (640, 480)
  window.connect("delete-event", closeEvent, data)

  # Main windows child, a VBox to hold all other widgets
  let mainBox = newBox(Orientation.vertical)

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

  # HBox to hold the buttons and the slider
  let controlBox = newBox(Orientation.horizontal)
  controlBox.packStart(playButton, false, false, 2)
  controlBox.packStart(pauseButton, false, false, 2)
  controlBox.packStart(stopButton, false, false, 2)
  controlBox.packStart(data.slider, true, true, 2)

  # Get the sink widget from value
  let widgetObj = getObject(data.sinkWidgetVal)
  let sinkWidget: Widget = cast[Widget](widgetObj)

  # HBox to hold the video sink widget
  let videoBox = newBox(Orientation.horizontal)
  videoBox.packStart(sinkWidget, true, true, 0)

  # Pack mainBox,  (Widget; expand; fill; padding)
  mainBox.packStart(videoBox, true, true, 0)
  mainBox.packStart(controlBox, false, false, 0)

  window.add(mainBox)
  window.showAll()

# This function is called periodically to refresh the GUI
proc refreshUI(data: CustomData): gboolean {.cdecl.} =
  # We don't want to update anything unless we are PAUSED or PLAYING
  if data.state.ord < gst.State.paused.ord:
    return gboolean(1)

  assert not data.playbin.isNil, "Error, no playback element"

  var pos: int64 = -1
  var adj = getAdjustment(data.slider)

  # If we didn't know it yet, query the stream duration
  if data.duration == -1:
    if queryDuration(data.playbin, Format.time, data.duration):
      # Set the range of the slider to the clip duration, in SECONDS
      adj.setUpper(cdouble(data.duration div SECOND))
      #setRange(cast [Range](data.slider), cdouble(0), cdouble(cast[var int64](data.duration) div SECOND));
    else:
      echo "Could not query current duration.\n"

  if queryPosition(data.playbin, Format.time, pos):
    # Block the "value-changed" signal, so the onSlider function is not called
    # (which would trigger a seek the user has not requested)
    signalHandlerBlock(data.slider, data.sliderSigID)

    # Set the position of the slider to the current pipeline position, in SECONDS
    adj.setValue(cdouble(pos div SECOND))

    # Re-enable the signal
    signalHandlerUnblock(data.slider, data.sliderSigID)

  return gboolean(1)

# Callback function to handle messages from the GStreamer bus.
proc onMessage(bus: Bus, msg: Message, data: CustomData) =
  let typ = msg.getType()

  # Print error details on the screen
  if typ == {gst.MessageFlag.error}:
    var err: ptr glib.Error
    var debug_info: string
    msg.parseError(err, debug_info)
    echo "Error received from element " & $msg.getType() & ": " & $err.message & "\n"
    stderr.write("Debugging information: " & debug_info & "\n")

    # Set the pipeline to READY (which stops playback)
    discard gst.setState(data.playbin, gst.State.ready)

  # This function is called when an End-Of-Stream message is posted on the bus.
  if typ == {gst.MessageFlag.eos}:
    stdout.write("End-Of-Stream reached.\n")
    discard gst.setState(data.playbin, gst.State.ready)

  # This function is called when the pipeline changes state. We use it to
  # keep track of the current state.
  if typ == {gst.MessageFlag.stateChanged}:
    var old, new, pending: State
    msg.parseStateChanged(old, new, pending)
    data.state = new

proc destroyNotify(data: pointer) {.cdecl.} =
  echo "destroyNotify"

proc appActivate(app: Application) =
  var data = new(CustomData)
  var ret: StateChangeReturn
  var bus: Bus
  var gtkglsink, videosink: Element

  # Initialize GStreamer
  gst.init()

  # Initialize data
  data.duration = -1

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
  discard timeoutAddSeconds(
    0, 1, cast[SourceFunc](refreshUI), cast[pointer](data), destroyNotify
  )

proc main() =
  let app = newApplication("org.gtk.example")

  connect(app, "activate", appActivate)
  discard app.run()

when isMainModule:
  main()

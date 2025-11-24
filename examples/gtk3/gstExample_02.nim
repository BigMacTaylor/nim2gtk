# https://gstreamer.freedesktop.org/documentation/tutorials/basic/hello-world.html?gi-language=c
# nim c gstExample_02.nim

import nim2gtk/[glib, gst, gobject]

proc onBusMessage(bus: gst.Bus, msg: gst.Message, data: glib.MainLoop): bool =
  ## Callback function to handle messages from the GStreamer bus.
  let typ = msg.getType()

  if typ == {gst.MessageFlag.error}:
    var err: ptr glib.Error
    var debug_info: string
    msg.parseError(err, debug_info)
    echo "Error received from element " & $msg.getType() & ": " & $err.message & "\n"
    stderr.write("Debugging information: " & debug_info & "\n")
    data.quit()
  if typ == {gst.MessageFlag.eos}:
    stdout.write("End-Of-Stream reached.\n")
    data.quit()
  else:
    discard

  return true

proc main() =
  ## Main function for the audio player.

  # Initialize GStreamer
  gst.init()

  # Create the playbin element
  let pipeline = make("playbin", "audio-player")
  #let pipeline = gst.parseLaunch("playbin uri=https://www.freedesktop.org/software/gstreamer-sdk/data/media/sintel_trailer-480p.webm")
  if pipeline.isNil():
    stderr.write("Not all elements could be created. Is 'playbin' installed?\n")
    return

  # Set the URI to play (replace with your audio file path or URL)
  let value = newValue("https://dl11.webmfiles.org/big-buck-bunny_trailer-.webm")
  pipeline.setProperty("uri", value)
  value.unset()

  # Start playing
  echo "Starting playback. Press Ctrl+C to exit.\n"
  discard gst.setState(pipeline, gst.State.playing)

  # Create a GLib Main Loop to handle events (like errors and EOS)
  let mainLoop = glib.newMainLoop(nil, false)
  let prior: int = 0
  let bus = gst.getBus(pipeline)
  bus.addWatch(prior, onBusMessage, mainLoop)
  bus.unref()

  # Run the main loop
  mainLoop.run()

  # Free resources
  echo "Stopping playback and cleaning up."
  discard gst.setState(pipeline, gst.State.null)

main()

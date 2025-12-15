# https://gitlab.freedesktop.org/gstreamer/gst-docs/blob/d2469972f06bc2ef2936fd8ab4b708a862f3d220/examples/tutorials/basic-tutorial-3.c
# Working with dynamic pipelines example
# nim c gstExample_03.nim

import nim2gtk/[gtk, gst, gobject, glib]
from strutils import startsWith, `%`

# Structure to contain all our information, so we can pass it to callbacks
type CustomData = ref object
  pipeline: gst.Element
  source: gst.Element
  convert: gst.Element
  sink: gst.Element

# This function will be called by the pad-added signal
proc padAdded(src: gst.Element, newPad: gst.Pad, data: CustomData) =
  var
    sink_pad: gst.Pad = gst.get_static_pad(data.convert, "sink")
    ret: gst.PadLinkReturn
    new_pad_caps: gst.Caps
    new_pad_struct: gst.Structure
    new_pad_type: string

  echo ("Received new pad $1 from $2:\n" % [getName(newPad), getName(src)])

  block gotoExit:
    # If our converter is already linked, we have nothing to do here
    if gst.is_linked(sink_pad):
      echo "We are already linked. Ignoring.\n"
      break gotoExit

    # Check the new pad's type
    new_pad_caps = gst.get_current_caps(newPad)
    new_pad_struct = gst.get_structure(new_pad_caps, 0)
    new_pad_type = gst.get_name(new_pad_struct)
    if not startsWith(new_pad_type, "audio/x-raw"):
      echo ("It has type $1 which is not raw audio. Ignoring.\n" % [new_pad_type])
      break gotoExit

    # Attempt the link
    ret = gst.link(new_pad, sink_pad)
    if ret < gst.PadLinkReturn.ok:
      echo ("Type is $1 but link failed.\n" % [new_pad_type])
    else:
      echo ("Link succeeded (type $1).\n" % [new_pad_type])

  #exit:
  if new_pad_caps != nil:
    discard

proc main(): int =
  var
    data = new(CustomData)
    bus: gst.Bus
    msg: gst.Message
    ret: gst.StateChangeReturn

  # Initialize GStreamer
  gst.init()

  # Create the elements
  data.source = gst.make("uridecodebin", "source") # gst_element_factory_make
  data.convert = gst.make("audioconvert", "convert")
  data.sink = gst.make("autoaudiosink", "sink")

  # Create the empty pipeline
  data.pipeline = gst.newPipeline("test-pipeline")

  # Check if the elements are empty
  if (
    data.pipeline == nil or data.source == nil or data.convert == nil or data.sink == nil
  ):
    echo "Not all elements could be created.\n"
    return -1

  # Build the pipeline 
  # 1. Add the elements
  discard gst.add(gst.Bin(data.pipeline), data.source)
  discard gst.add(gst.Bin(data.pipeline), data.convert)
  discard gst.add(gst.Bin(data.pipeline), data.sink)

  # 2. Link elements
  if not link(data.convert, data.sink):
    echo "Elements could not be linked.\n"
    return -1

  # Set the URI to play
  let uri = newValue("https://dl11.webmfiles.org/big-buck-bunny_trailer-.webm")
  #let uri = newValue("https://www.freedesktop.org/software/gstreamer-sdk/data/media/sintel_trailer-480p.webm")
  setProperty(data.source, "uri", uri)

  # Connect to the pad-added signal
  connect(data.source, "pad-added", padAdded, data)

  # Start playing
  ret = gst.set_state(data.pipeline, gst.State.playing)
  if ret == StateChangeReturn.failure: # GST_STATE_CHANGE_FAILURE:
    echo "Unable to set the pipeline to the playing state.\n"
    return -1

  # Listen to the bus
  bus = gst.getBus(data.pipeline)
  while true:
    msg = gst.timedPopFiltered(
      bus,
      gst.Clock_Time_None,
      {MessageFlag.stateChanged, MessageFlag.error, MessageFlag.eos},
    )

    # Parse message
    if (msg != nil):
      var err: ptr glib.Error
      var debug_info: string
      var typ: gst.MessageType = msg.getType

      if gst.MessageFlag.error in typ:
        gst.parse_error(msg, err, debug_info)
        echo "Error received from element " & getName(msg.impl.src) & ": " & $err.message
        echo "Debugging information: ", if debug_info.len > 0: debug_info else: "none"
        clear_error(addr err)
        break
      elif gst.MessageFlag.eos in typ:
        echo "End-Of-Stream reached.\n"
        break
      elif gst.MessageFlag.stateChanged in typ:
        # We are only interested in state-changed messages from the pipeline
        if getName(msg.impl.src) == "test-pipeline":
          var old_state, new_state, pending_state: gst.State
          gst.parse_state_changed(msg, old_state, new_state, pending_state)
          echo (
            "Pipeline state changed from $1 to $2:\n" %
            [state_get_name(old_state), state_get_name(new_state)]
          )
      else:
        # We should not reach here
        echo "Unexpected message received.\n"
        break

  # Free resources
  discard gst.set_state(data.pipeline, gst.State.null)
  return 0

discard main()

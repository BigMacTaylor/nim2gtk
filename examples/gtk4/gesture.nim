import nim2gtk/[gtk4, gobject, gio]
import std/with

# Called function has the sender of the signal as the first argument
proc onClick(b: Button) =
  echo "hello world"

proc onGesture(self: GestureClick, nPress: int, x: cdouble, y: cdouble) =
  echo "hello gestures ", nPress, " ", x, " ", y

proc appActivate(app: Application) =
  let
    window = newApplicationWindow(app)
    button = newButton()
    gesture = newGestureClick()

  gesture.button = 3 # rigth click
  gesture.connect("pressed", onGesture)

  button.addController(gesture)

  with button:
    label = "Click Me"
    marginTop = 10
    marginBottom = 10
    marginStart = 10
    marginEnd = 10
    connect("clicked", onClick)

  with window:
    title = "Gesture Example"
    resizable = false
    child = button
    show

proc main() =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard run(app)

main()

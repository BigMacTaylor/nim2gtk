# nim c button.nim
import nim2gtk/[gtk4, gobject, gio]
import std/with

# Called function has the sender of the signal as the first argument
proc onClick(btn: Button) =
  echo "Button clicked!"

proc appActivate(app: Application) =
  let
    window = newApplicationWindow(app)
    button = newButton()

  with button:
    label = "Click Me"
    marginTop = 10
    marginBottom = 10
    marginStart = 10
    marginEnd = 10
    connect("clicked", onClick)

  with window:
    title = "Button Example"
    child = button
    defaultSize = (200, 200)
    show

proc main() =
  let app = newApplication("org.gtk.example.button")
  app.connect("activate", appActivate)
  discard run(app)

main()

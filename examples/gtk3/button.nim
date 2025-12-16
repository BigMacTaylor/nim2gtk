# nim c button.nim
import nim2gtk/[gtk, glib, gobject, gio]

# Called function has the sender of the signal as the first argument
proc onClick(button: Button) =
  button.label = utf8Strreverse(button.label, -1)

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GNOME Button"
  window.defaultSize = (250, 50)

  let button = newButton("Click Me")
  button.connect("clicked", onClick)

  window.add(button)
  window.showAll()

proc main() =
  let app = newApplication("org.gtk.example.button")
  app.connect("activate", appActivate)
  discard run(app)

main()

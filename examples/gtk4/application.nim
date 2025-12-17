# application.nim -- minimal application style example
# nim c application.nim
import nim2gtk/[gtk4, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTK4 APP"
  window.defaultSize = (200, 200)

  let label = newLabel("Hello World!")
  window.setChild(label)

  show(window)

proc main() =
  let app = newApplication("org.gtk.example.app")
  app.connect("activate", appActivate)
  discard run(app)

main()

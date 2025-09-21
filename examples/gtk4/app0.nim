# app0.nim -- minimal application style example
# nim c app0.nim
import nim2gtk/[gtk4, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTK4 APP"
  window.defaultSize = (200, 200)
  show(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()

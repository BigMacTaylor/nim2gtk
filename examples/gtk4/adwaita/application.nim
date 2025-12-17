import nim2gtk/[gtk4, gobject, gio, adw]
import std/with

proc appActivate(app: adw.Application) =
  let
    window = adw.newApplicationWindow(app)
    label = newLabel("on adwaita ApplicationWindow bottom corners are rounded")

    header = adw.newHeaderBar()
    mainBox = newBox(Orientation.vertical, 0)

  with mainBox:
    append header
    append label

  with label:
    text = "on adwaita ApplicationWindow bottom corners are rounded"
    marginTop = 10
    marginBottom = 10
    marginStart = 10
    marginEnd = 10

  with window:
    title = "Adwaita ApplicationWindow"
    content = mainBox
    show

proc initAdw(app: adw.Application) =
  adw.init()

proc main() =
  let app = adw.newApplication("org.gtk.example", {})
  app.connect("startup", initAdw)
  app.connect("activate", appActivate)
  discard run(app)

main()

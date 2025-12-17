# nim c headerbar.nim
import nim2gtk/[gtk4, gobject, gio]
import std/with

proc onClick(b: Button) =
  echo "Button clicked!"

proc appActivate(app: Application) =
  let
    window = newApplicationWindow(app)
    button1 = newButton()
    button2 = newButton()
    headerBar = newHeaderBar()

  with button1:
    label = "Start"
    connect("clicked", onClick)

  with button2:
    label = "End"
    connect("clicked", onClick)

  with headerBar:
    packStart button1
    packEnd button2

  with window:
    title = "HeaderBar"
    setTitlebar headerBar
    show

proc main() =
  let app = newApplication("org.gtk.example.headerbar")
  app.connect("activate", appActivate)
  discard run(app)

main()

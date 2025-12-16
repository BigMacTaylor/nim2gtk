# nim c headerbar.nim
import nim2gtk/[gtk, gobject, gio]

proc onClick(b: Button) =
  echo "Button clicked!"

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "HeaderBar"

  let button1 = newButton()
  button1.label = "Start"
  button1.connect("clicked", onClick)

  let button2 = newButton()
  button2.label = "End"
  button2.connect("clicked", onClick)

  let headerBar = newHeaderBar()
  headerBar.packStart(button1)
  headerBar.packEnd(button2)

  window.setTitlebar(headerBar)
  window.showAll()

proc main() =
  let app = newApplication("org.gtk.example.headerbar")
  app.connect("activate", appActivate)
  discard run(app)

main()

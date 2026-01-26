# nim c textview.nim
import nim2gtk/[gtk, gobject, gio]

const text = "This is an editable TextView.\nYou can type multiple lines here."

proc appActivate(app: Application) =
  let win = newApplicationWindow(app)
  win.title = "TextView Example"
  win.defaultSize = (500, 300)

  let scrollBox = newScrolledWindow()

  let view = newTextView()
  view.buffer.setText(text, -1)

  scrollBox.add(view)
  win.add(scrollBox)
  win.showAll()

proc main() =
  let app = newApplication("org.gtk.example.textview")
  app.connect("activate", appActivate)
  discard run(app)

main()

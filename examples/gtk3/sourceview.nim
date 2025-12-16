# minimal sourceview example
# nim c sourceview.nim
# ./sourceview sourceview.nim
import nim2gtk/[gtk, gobject, gio, gtksource]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTKSourceView"
  window.defaultSize = (800, 600)

  let scrollBox = newScrolledWindow()

  let view = newView()
  view.setShowLineNumbers(true)

  scrollBox.add(view)
  window.add(scrollBox)
  window.showAll()

proc main() =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard run(app)

main()

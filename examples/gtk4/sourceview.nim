# minimal sourceview-5 example
# nim c sourceview.nim
# ./sourceview sourceview.nim
import nim2gtk/[gtk4, gobject, gio, gtksource5]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTKSourceView"
  window.defaultSize = (800, 600)

  let scrollBox = newScrolledWindow()

  let view = newView()
  view.setShowLineNumbers(true)

  scrollBox.setChild(view)
  window.setChild(scrollBox)
  window.show()

proc main() =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard run(app)

main()

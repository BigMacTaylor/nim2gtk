# nim c notebook.nim
import nim2gtk/[gtk, gobject, gio]

proc appActivate(app: Application) =
  let win = newApplicationWindow(app)
  win.title = "Notebook (Tabs) Example"
  win.defaultSize = (420, 220)

  let nb = newNotebook()
  let page1 = newLabel("Page 1 content")
  let page2 = newLabel("Page 2 content")

  discard nb.appendPage(page1, newLabel("Tab 1"))
  discard nb.appendPage(page2, newLabel("Tab 2"))

  win.add(nb)
  win.showAll()

proc main() =
  let app = newApplication("org.gtk.example.notebook")
  app.connect("activate", appActivate)
  discard run(app)

main()

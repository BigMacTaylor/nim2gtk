# nim c menu.nim
import nim2gtk/[gtk, glib, gobject, gio]

proc onNew(action: SimpleAction, parameter: Variant, app: Application) =
  echo "New action"

proc onQuit(action: SimpleAction, parameter: Variant, app: Application) =
  quit(app)

proc appStartup(app: Application) =
  echo "appStartup"

  # Create the actions for whole app
  let new = newSimpleAction("new")
  connect(new, "activate", onNew, app)
  app.addAction(new)
  app.setAccelsForAction("app.new", "<Control>N")

  let quit = newSimpleAction("quit")
  connect(quit, "activate", onQuit, app)
  app.addAction(quit)
  app.setAccelsForAction("app.quit", "<Control>Q")

proc appActivate(app: Application) =
  let win = newApplicationWindow(app)
  win.title = "Menu Example"
  win.defaultSize = (480, 160)

  # Main menu, root of all other menus
  let menu = gio.newMenu()

  # Create submenu
  let fileMenu = gio.newMenu()
  # And put Items in it
  let newItem = newMenuItem("New", "app.new")
  let quitItem = newMenuItem("Quit", "app.quit")
  fileMenu.appendItem(newItem)
  fileMenu.appendItem(quitItem)

  # Rinse and repeat
  let editMenu = gio.newMenu()
  let copyItem = newMenuItem("Copy", "app.copy")
  let cutItem = newMenuItem("Cut", "app.cut")
  let pasteItem = newMenuItem("Paste", "app.paste")
  editMenu.appendItem(copyItem)
  editMenu.appendItem(cutItem)
  editMenu.appendItem(pasteItem)

  let helpMenu = gio.newMenu()
  let helpItem = newMenuItem("Help", "app.help")
  let aboutItem = newMenuItem("About", "app.about")
  helpMenu.appendItem(helpItem)
  helpMenu.appendItem(aboutItem)

  # Add submenus to the main menu
  menu.appendSubMenu("File", fileMenu)
  menu.appendSubMenu("Edit", editMenu)
  menu.appendSubMenu("Help", helpMenu)

  # Add main menu to app
  app.setMenuBar(menu)

  let label = newLabel("GIO menu example")

  win.add(label)
  win.showAll()

proc main() =
  let app = newApplication("org.gtk.example.menu")
  app.connect("startup", appStartup)
  app.connect("activate", appActivate)
  discard run(app)

main()

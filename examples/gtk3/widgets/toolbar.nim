# nim c toolbar.nim
import nim2gtk/[gtk, gobject, gio]

proc toolbarAction(b: ToolButton) =
  echo $b.label & " button pressed"

proc appActivate(app: Application) =
  let win = newApplicationWindow(app)
  win.title = "Toolbar Example"
  win.defaultSize = (480, 160)

  let box = newBox(Orientation.vertical, 6)

  # Create toolbar
  let toolbar = newToolbar()

  # Create buttons
  let newBtn = newToolButton()
  newBtn.iconName = "document-new"
  newBtn.label = "New"
  newBtn.connect("clicked", toolbarAction)
  # Insert item into the toolbar at position.
  toolbar.insert(newBtn, 1)

  let copyBtn = newToolButton()
  copyBtn.iconName = "edit-copy"
  copyBtn.label = "Copy"
  copyBtn.connect("clicked", toolbarAction)
  toolbar.insert(copyBtn, 2)

  let pasteBtn = newToolButton()
  pasteBtn.iconName = "edit-paste"
  pasteBtn.label = "Paste"
  pasteBtn.connect("clicked", toolbarAction)
  # If pos is negative, the item is appended to the end of the toolbar.
  toolbar.insert(pasteBtn, -1)

  let label = newLabel("Toolbar example")

  box.add(toolbar)
  box.packStart(label, true, true, 0)
  win.add(box)
  win.showAll()

proc main() =
  let app = newApplication("org.gtk.example.toolbar")
  app.connect("activate", appActivate)
  discard run(app)

main()

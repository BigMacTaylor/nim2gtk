# nim c listbox.nim
import nim2gtk/[gtk, gobject, gio]

proc onActivate(lb: ListBox, row: ListBoxRow) =
  let lbl = cast[Label](row.getChild())
  echo "Activated: ", lbl.text

proc appActivate(app: Application) =
  let win = newApplicationWindow(app)
  win.title = "ListBox Example"
  win.defaultSize = (360, 240)

  let box = newBox(Orientation.vertical, 8)
  box.setMargin(12)

  let listbox = newListBox()
  for name in @["Apple", "Banana", "Cherry", "Date", "Elderberry"]:
    let row = newListBoxRow()
    let label = newLabel(name)
    row.add(label)
    listbox.add(row)

  listbox.connect("row-activated", onActivate)

  box.add(listbox)
  win.add(box)
  win.showAll()

proc main() =
  let app = newApplication("org.gtk.example.listbox")
  app.connect("activate", appActivate)
  discard run(app)

main()

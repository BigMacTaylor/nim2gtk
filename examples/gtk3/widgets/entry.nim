# nim c entry.nim
import nim2gtk/[gtk, gdk, gobject, gio]

proc activate(e: Entry) =
  echo "You entered: ", e.buffer.text
  e.progressPulse
  # use this if we know the exact progress state in %
  #entry.setProgressFraction(0.7)

proc iconPress(e: Entry, p: EntryIconPosition, v: Event) =
  echo "You clicked: ", p
  discard e.buffer.deleteText(0, -1) # delete all

proc onEntryChanged(entry: Entry, lbl: Label) =
  # copy entry text into label as the user types
  lbl.label = entry.text

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Entry Example"
  window.defaultSize = (420, 120)

  let vbox = newBox(Orientation.vertical, 8)
  vbox.setMargin(12)

  let label = newLabel("Type in the entry above")

  let entry = newEntry()
  entry.setMargin(10)
  entry.setProgressPulseStep(0.2)
  entry.setPlaceholderText("Enter text")
  entry.setIconFromIconName(EntryIconPosition.secondary, "edit-clear")
  entry.setIconActivatable(EntryIconPosition.secondary, true)
  entry.connect("activate", activate)
  entry.connect("icon-press", iconPress)
  entry.connect("changed", onEntryChanged, label)

  vbox.add(entry)
  vbox.add(label)

  window.add(vbox)
  window.showAll()

proc main() =
  let app = newApplication("org.gtk.example.entry")
  app.connect("activate", appActivate)
  discard run(app)

main()

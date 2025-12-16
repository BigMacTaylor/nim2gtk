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

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)

  let entry = newEntry()
  entry.setMargin(10)
  entry.setProgressPulseStep(0.2)
  entry.setPlaceholderText("Enter some text")
  entry.setIconFromIconName(EntryIconPosition.secondary, "edit-clear")
  entry.setIconActivatable(EntryIconPosition.secondary, true)
  entry.connect("activate", activate)
  entry.connect("icon-press", iconPress)

  window.add(entry)
  window.showAll()

proc main() =
  let app = newApplication("org.gtk.example.entry")
  app.connect("activate", appActivate)
  discard run(app)

main()

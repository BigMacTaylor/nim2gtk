# nim c entry.nim
import nim2gtk/[gtk4, gobject, gio]
import std/with

proc activate(e: Entry) =
  echo "You entered: ", e.buffer.text
  e.progressPulse
  # use this if we know the exact progress state in %
  #entry.setProgressFraction(0.7)

proc iconPress(e: Entry, p: EntryIconPosition) =
  echo "You clicked: ", p
  discard e.buffer.deleteText(0, -1) # delete all

proc appActivate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    entry = newEntry()

  with entry:
    marginStart = 10
    marginEnd = 10
    marginTop = 10
    marginBottom = 10
    setProgressPulseStep(0.2)
    setPlaceholderText("Enter some text")
    setIconFromIconName(EntryIconPosition.secondary, "edit-clear")
    setIconActivatable(EntryIconPosition.secondary, true)
    connect("activate", activate)
    connect("icon-press", iconPress)

  with window:
    child = entry
    show

proc main() =
  let app = newApplication("org.gtk.example.entry")
  app.connect("activate", appActivate)
  discard run(app)

main()

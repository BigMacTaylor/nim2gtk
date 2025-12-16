# nim c dialog.nim
import nim2gtk/[gtk, gobject, gio]

proc onResponse(d: Dialog, id: int) =
  echo "response: ", ResponseType(id)
  d.destroy

proc openDialog(btn: Button, win: ApplicationWindow) =
  let dialog = newDialog()
  dialog.title = "New Dialog Window"
  dialog.setModal(true)
  dialog.setTransientFor(win)

  let contentArea = dialog.getContentArea
  let msg = newLabel("Do you like Nim and GTK?")
  contentArea.add(msg)
  discard dialog.addButton("Yes", ResponseType.yes.ord)
  discard dialog.addButton("No", ResponseType.no.ord)
  dialog.connect("response", onResponse)
  dialog.showAll()

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Application Main Window"

  let button = newButton("Open Dialog")
  button.connect("clicked", openDialog, window)

  window.add(button)
  window.showAll()

proc main() =
  let app = newApplication("org.gtk.example.dialog")
  app.connect("activate", appActivate)
  discard run(app)

main()

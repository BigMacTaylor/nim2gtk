import nim2gtk/[gtk, gobject, gio, glib]

proc onResponse(dialog: Dialog, responseId: int) =
  echo "Dialog response: ", responseId
  dialog.destroy() # Destroy the dialog after closing

proc openDialog(button: Button, window: ApplicationWindow) =
  # Create a dialog
  let dialog = newDialog()
  dialog.title = "New Dialog Window"
  dialog.setModal(true)
  setTransientFor(dialog, window)

  # Get the content area and add a label
  let contentArea = getContentArea(dialog)
  let label = newLabel("\nThis is a simple Gtk dialog example.\n")
  contentArea.add(label)

  # Add buttons to the dialog with response ID
  discard dialog.addButton("no", 1)
  discard dialog.addButton("cancel", 2)
  discard dialog.addButton("yes", 3)

  # Connect the "response" signal to our handler
  dialog.connect("response", onResponse)

  # Show the dialog
  dialog.showAll()
  discard dialog.run()

proc appActivate(app: Application) =
  # Create a new window (parent for the dialog)
  let window = newApplicationWindow(app)
  window.title = "Dialog Example"
  window.defaultSize = (300, 200)

  let button = newButton("Open Dialog")
  button.connect("clicked", openDialog, window)

  window.add(button)

  # Show the main window
  window.showAll()

proc main() =
  let app = newApplication("org.gtk.msgBox")
  connect(app, "activate", appActivate)
  discard app.run()

main()

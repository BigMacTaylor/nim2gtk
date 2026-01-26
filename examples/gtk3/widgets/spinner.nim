# nim c spinner.nim
import nim2gtk/[gtk, glib, gobject, gio]

proc onChange(t: ToggleButton, spinner: Spinner) =
  if t.getActive():
    spinner.start()
    t.setLabel("Stop")
  else:
    spinner.stop()
    t.setLabel("Start")

proc appActivate(app: Application) =
  let win = newApplicationWindow(app)
  win.title = "Spinner Example"
  win.defaultSize = (360, 140)

  let box = newBox(Orientation.vertical, 8)
  box.setMargin(12)

  let spinner = newSpinner()
  spinner.stop()

  let button = newToggleButton("Start")
  button.connect("toggled", onChange, spinner)
  button.active = false

  #sw.connect("notify::active", onChange, spinner)

  box.add(button)
  box.add(spinner)
  win.add(box)
  win.showAll()

proc main() =
  let app = newApplication("org.gtk.example.spinner")
  app.connect("activate", appActivate)
  discard run(app)

main()

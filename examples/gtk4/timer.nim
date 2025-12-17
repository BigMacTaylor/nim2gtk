import nim2gtk/[gtk4, glib, gobject, gio]
import std/with

var button: Button
var countdown = 0

proc updateGUI(b: Button): bool =
  countdown.inc()
  echo countdown
  if countdown <= 60:
    b.label = $countdown
    echo b.label
    return SOURCE_CONTINUE
  else:
    return SOURCE_REMOVE

proc onClick(b: Button) =
  countdown = 1
  b.label = "1"
  discard timeoutAdd(100, updateGUI, b)

proc appActivate(app: gtk4.Application) =
  let window = newApplicationWindow(app)

  button = newButton("Click Me")
  button.connect("clicked", onClick)

  with window:
    title = "Timer"
    child = button
    defaultSize = (250, 50)
    show

proc main() =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()

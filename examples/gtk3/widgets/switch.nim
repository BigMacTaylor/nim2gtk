# nim c switch_.nim
import nim2gtk/[gtk, gobject, gio]

proc onChange(sw: Switch, state: ParamSpec, s: string) =
  if sw.getActive():
    echo s & "is on"
  else:
    echo s & "is off"

proc appActivate(app: Application) =
  let win = newApplicationWindow(app)
  win.title = "Switch Example"
  win.defaultSize = (360, 140)

  let box = newBox(Orientation.horizontal, 6)
  box.homogeneous = true
  box.setMargin(24)

  let sw_1 = newSwitch()
  sw_1.connect("notify::active", onChange, "switch 1 ")
  sw_1.active = false
  sw_1.halign = Align.center
  box.add(sw_1)

  let sw_2 = newSwitch()
  sw_2.connect("notify::active", onChange, "switch 2 ")
  sw_2.active = true
  sw_2.halign = Align.center
  box.add(sw_2)

  win.add(box)
  win.showAll()

proc main() =
  let app = newApplication("org.gtk.example.switch")
  app.connect("activate", appActivate)
  discard run(app)

main()

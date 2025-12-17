##  https://github.com/GNOME/gtk/blob/gtk-3-24/tests/testspinbutton.c
##  gcc `pkg-config gtk+-3.0 --cflags` spinbutton.c -o spinbutton `pkg-config --libs gtk+-3.0`

import nim2gtk/[gtk4, gobject, gio]

proc valueChanged(s: SpinButton) =
  echo "value changed: ", s.getValue, " (", s.getValueAsInt, ")"

proc appActivate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    # value, lower, upper, stepIncrement, pageIncrement, pageSize
    adj1 = newAdjustment(50.0, 0.0, 100.0, 1.0, 10.0, 0.0)
    adj2 = newAdjustment(
      value = 0,
      lower = 0,
      upper = 10.0,
      stepIncrement = 0.01,
      pageIncrement = 1.0,
      pageSize = 0.0,
    )

  let
    b1 = newSpinButton(adj1, 5.0, 0)
    b2 = newSpinButton(adj2, 0.0, 2)

  b1.connect("value-changed", valueChanged)
  b2.connect("value-changed", valueChanged)

  let box = newBox(Orientation.horizontal, 25)

  box.append(b1)
  box.append(b2)
  window.setChild(box)
  window.show

proc main() =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  let status = app.run
  quit(status)

main()

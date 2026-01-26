# counter.nim -- simple counter app demonstrating Button + Label updates
# nim c counter.nim
import nim2gtk/[gtk, gobject, gio]
import std/strutils

proc onClick(button: Button, lbl: Label) =
  # increment numeric value shown in the label each click
  let cur = parseInt(lbl.label)
  lbl.label = $(cur + 1)

proc appActivate(app: Application) =
  let
    window = newApplicationWindow(app)
    vbox = newBox(Orientation.vertical, 8)
    label = newLabel("0")
    button = newButton("Increment")

  window.title = "Counter"
  window.defaultSize = (240, 80)

  vbox.setMargin(12)
  vbox.setHalign(gtk.Align.center)
  vbox.setValign(gtk.Align.center)

  vbox.add(label)
  vbox.add(button)

  # connect the button and pass the label as an argument to callback
  button.connect("clicked", onClick, label)

  window.add(vbox)
  window.showAll()

proc main() =
  let app = newApplication("org.nim.example.counter")
  app.connect("activate", appActivate)
  discard run(app)

main()

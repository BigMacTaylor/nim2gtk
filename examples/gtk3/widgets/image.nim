# nim c image.nim
import nim2gtk/[gtk, gobject, gio]

proc appActivate(app: Application) =
  let win = newApplicationWindow(app)
  win.title = "Image Example"
  win.defaultSize = (420, 300)

  let box = newBox(Orientation.vertical, 8)
  box.setMargin(12)

  # Load an image from a file (adjust path as needed)
  let img = newImageFromFile("./nim-logo.png")
  let lbl = newLabel("Image below (nim-logo.png)")

  box.add(lbl)
  box.add(img)
  win.add(box)
  win.showAll()

proc main() =
  let app = newApplication("org.gtk.example.image")
  app.connect("activate", appActivate)
  discard run(app)

main()

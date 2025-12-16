# nim c grid.nim
import nim2gtk/[gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Grid Example"

  # Create grid
  let grid = newGrid()
  grid.rowSpacing = 10
  grid.columnSpacing = 10
  grid.setMargin(10)
  grid.halign = Align.center

  # Create buttons
  let button1 = newButton("Button 1")
  let button2 = newButton("Button 2")
  let button3 = newButton("Button 3")

  # Attach widgets to the grid
  # attach(widget, column, row, width, height)
  grid.attach(button1, 0, 0, 1, 1)
  grid.attach(button2, 1, 0, 1, 1)
  grid.attach(button3, 0, 1, 2, 1)

  window.add(grid)
  window.showAll()

proc main() =
  let app = newApplication("org.gtk.example.grid")
  app.connect("activate", appActivate)
  discard run(app)

main()

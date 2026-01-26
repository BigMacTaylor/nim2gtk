# Simple window example, however for real apps
# it is reccomended to use GtkApplicationWindow instead.
# nim c window.nim
import nim2gtk/[gtk, gobject]

proc quit(w: Window) =
  mainQuit()
  echo "Bye..."

proc main() =
  gtk.init()
  let window = newWindow()
  window.title = "Basic Window"
  window.defaultSize = (400, 200)
  window.connect("destroy", quit)

  let label = newLabel("This is a simple top-level window.")

  window.add(label)
  window.showAll
  gtk.main()

main()

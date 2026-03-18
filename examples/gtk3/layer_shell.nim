# Simple gtk-layer-shell example
# nim c layer_shell.nim
import nim2gtk/[gtk, gtklayershell, gio, gobject]

# Called function has the sender of the signal as the first argument
proc onClick(widget: Button) =
  echo "Button clicked!"

proc appActivate(app: gtk.Application) =
  # Create a normal GTK window
  let window = newApplicationWindow(app)

  # Before the window is first realized, set it up to be a layer surface.
  initLayerShell(window)

  # Order below normal windows (e.g. for a wallpaper or a dock that goes below)
  setLayer(window, Layer.top)

  # Push other windows out of the way (e.g. for a panel)
  autoExclusiveZoneEnable(window)

  # Margins (gaps around the window's edges)
  setLayerShellMargin(window, Edge.bottom, 5) # 0 is default

  # Anchors: pin the window to specific edges of the output
  # Example: top, left, and right (like a top bar)
  setAnchor(window, Edge.top, false)
  setAnchor(window, Edge.left, true)
  setAnchor(window, Edge.right, true)
  setAnchor(window, Edge.bottom, true)

  # Create widgets for the window
  let mainBox = newBox(Orientation.horizontal, 5)
  mainBox.setHexpand(true) # Stretch horizontally

  let appIcon = newImage()
  appIcon.setFromIconName("utilities-terminal-symbolic", IconSize.dialog.ord)

  let appBtn = newButton()
  appBtn.add(appIcon)
  appBtn.setRelief(ReliefStyle.none) # Looks like a plain icon
  appBtn.connect("clicked", onClick)

  # Add more icons (Clock, Volume, etc.)

  let label = newLabel("GTK4 Layer Shell example in Nim!")
  label.setMarkup("<span font_desc=\"20.0\">GTK Layer Shell example in Nim!</span>")
  label.halign = Align.center

  # Pack main box (Widget; expand; fill; padding)
  mainBox.packStart(appBtn, false, false, 0)
  mainBox.packStart(label, true, false, 6)

  window.add(mainBox)
  window.showAll()

proc main() =
  let app = newApplication("org.gtk.example.layershell")
  app.connect("activate", appActivate)
  discard run(app)

main()

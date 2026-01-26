# nim c label.nim
import nim2gtk/[gtk, glib, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Label Examples"
  window.defaultSize = (300, 200)

  let mainBox = newBox(Orientation.vertical, 10)

  let label_1 = newLabel("Simple label")

  let label_2 = newLabel("Selectable label")
  label_2.selectable = true

  # Label With Mnemonic
  # If placed in a button, pressing Alt+p activates it
  let label_3 = newLabelWithMnemonic("_Print")

  let label_4 = newLabel()
  label_4.set_markup("This is <span foreground='blue'>blue</span> and <b>bold</b>.")

  let label_5 = newLabel("This is a very very long label to demonstrate line wrapping.")
  label_5.lineWrap = true

  let label_6 = newLabel("Label with CSS")
  let cssProvider = newCssProvider()
  let data = "label {color: yellow; font-weight: bold ; background: blue;}"
  #discard cssProvider.loadFromPath("doesnotexist")
  discard cssProvider.loadFromData(data)
  let styleContext = label_6.getStyleContext
  assert styleContext != nil
  addProvider(styleContext, cssProvider, STYLE_PROVIDER_PRIORITY_USER)

  mainBox.add(label_1)
  mainBox.add(label_2)
  mainBox.add(label_3)
  mainBox.add(label_4)
  mainBox.add(label_5)
  mainBox.add(label_6)

  window.add(mainBox)
  showAll(window)

proc main() =
  let app = newApplication("org.gtk.example.label")
  app.connect("activate", appActivate)
  discard run(app)

main()

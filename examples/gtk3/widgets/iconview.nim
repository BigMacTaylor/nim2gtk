# nim c iconview.nim
import nim2gtk/[gtk, glib, gobject, gio, gdkpixbuf]

const icons = @["edit-cut", "edit-paste", "edit-copy"]

proc main() =
  gtk.init()

  let window = newWindow()
  window.title = "IconView Example"
  window.defaultSize = (300, 300)

  # Create a GtkListStore with two columns: Pixbuf and String
  var types: array[2, GType]
  types[0] = gdkpixbuf.gdk_pixbuf_get_type() # Pixbuf column
  types[1] = typeFromName("gchararray") # String column
  let store = newListStore(2, addr types[0])

  # Create the IconView and configure it to use the ListStore columns
  let iconview = newIconView()
  iconview.setModel(store)
  iconview.setPixbufColumn(0)
  iconview.setTextColumn(1)

  # Populate the store with themed icons (as Pixbufs) and a label
  var iter: TreeIter
  for icon in icons:
    let theme = getDefaultIconTheme()
    # loadIcon(name, size, flags) -> gdkpixbuf.Pixbuf
    let pix: gdkpixbuf.Pixbuf = theme.loadIcon(icon, 64, cast[IconLookupFlags](0))
    store.append(iter)

    var val: Value
    discard
      init(val, g_object_get_type()) # ensure value is initialized (will be overwritten)

    val = newValue(pix) # set Pixbuf object into Value
    store.setValue(iter, 0, val)
    val.unset

    val = newValue("Label") # set text label into Value
    store.setValue(iter, 1, val)
    val.unset

  window.add(iconview)

  connect(window, "destroy", gtk.mainQuit)
  window.showAll()
  gtk.main()

main()

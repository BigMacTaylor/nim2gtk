import nim2gtk/[glib, gobject, gtk]
import nim2gtk/gio except ListStore

const GroceryList = [(true, 1, "Paper Towels"), (true, 2, "Bread"),
                         (false, 1, "Butter"), (true, 1, "Milk"), (false, 3, "Chips"),
                         (true, 4, "Soda")]

##  Add three columns to the GtkTreeView. All three of the columns will be
##  displayed as text, although one is a gboolean value and another is an integer.
proc setupTreeView(treeview: TreeView) =
  var renderer: CellRendererText
  var column: TreeViewColumn
  
  ##  Create a new GtkCellRendererText, add it to the tree view column and
  ##  append the column to the tree view.
  
  for i, t in ["Buy", "Count", "Product"]:
    renderer = newCellRendererText()
    column = newTreeViewColumn()
    column.title = t
    column.packStart(renderer, true)
    column.addAttribute(renderer, "text", i)
    discard treeview.appendColumn(column)

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Grocery List"
  window.borderWidth = 10
  window.position = WindowPosition.center
  window.setSizeRequest(250, 175)
  let treeview = newTreeView()
  setupTreeView(treeview)
  
  ##  Create a new tree model with three columns, as string, gint and guint.
  ## store = gtk_list_store_new(, G_TYPE_BOOLEAN, G_TYPE_INT, G_TYPE_STRING)
  var h = [typeFromName("gboolean"), typeFromName("gint"), typeFromName("gchararray")]
  #let store = newListStore(3, h[0]) # cast due to bug in gtk.nim
  let store = newListStore(3, addr h[0])


  ##  Add all of the products to the GtkListStore.
  for el in GroceryList:
    var val: Value
    var iter: TreeIter
    var gtype: GType
    let buy = el[0]
    let quantity = el[1]
    let product = el[2]
    store.append(iter)
    
    gtype = typeFromName("gboolean")
    discard init(val, gtype)
    setBoolean(val, buy)
    store.setValue(iter, 0, val)
    
    gtype = typeFromName("gint")
    val.unset
    discard init(val, gtype)
    setint(val, quantity)
    store.setValue(iter, 1, val)
    
    gtype = typeFromName("gchararray")
    val.unset
    discard init(val, gtype)
    setString(val, product)
    store.setValue(iter, 2, val)
  
  let scrolled_win = newScrolledWindow()
  scrolled_win.setPolicy(PolicyType.automatic, PolicyType.automatic)
  scrolled_win.add(treeview)
  window.add(scrolled_win)
  treeview.setModel(store)
  showAll(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()
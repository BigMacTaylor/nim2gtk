import nim2gtk/[gtk, glib, gobject, gio]

proc onSearchTextChanged(entry: SearchEntry) =
  let searchText = entry.getText()
  echo "Search text changed: " & searchText

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.setTitle("Gintro Search Bar Example")
  window.setDefaultSize(400, 300)

  let vbox = newBox(Orientation.vertical, 0)
  window.add(vbox)

  let searchBar = newSearchBar()
  searchBar.setShowCloseButton(true)
  vbox.packStart(searchBar, false, false, 0)

  let searchEntry = newSearchEntry()
  searchBar.connectEntry(searchEntry) # Connect the search entry to the search bar
  vbox.packStart(searchEntry, false, false, 0)

  # Connect the search-changed signal for reactive search
  searchEntry.connect("search-changed", onSearchTextChanged)

  let label = newLabel("Content goes here...")
  vbox.packStart(label, true, true, 0)

  window.showAll()

proc main() =
  let app = newApplication("org.gtk.searchBar")
  app.connect("activate", appActivate)
  discard app.run()

when isMainModule:
  main()

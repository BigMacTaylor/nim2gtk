import nim2gtk/[gtk4, gobject, gio, pango, adw, glib, gdk4]
import std/with

type EntryAndWindow = ref object
  entry: Entry
  window: adw.ApplicationWindow
  popover: Popover

proc changeTitle(btn: Button, entryAndWindow: EntryAndWindow) =
  entryAndWindow.window.title = entryAndWindow.entry.text.cstring
  entryAndWindow.entry.text = ""
  entryAndWindow.popover.popdown()

proc appActivate(app: adw.Application) =
  let
    window = adw.newApplicationWindow(app)
    header = adw.newHeaderBar()
    mainBox = newBox(Orientation.vertical, 0)

    menuButton = newMenuButton()
    popover = newPopover()

    entry = newEntry()
    enterTextButton = newButtonFromIconName("folder-new-symbolic")
    enterTextButton2 = newButtonFromIconName("document-new-symbolic")
    entryWithBtnBox = newBox(Orientation.horizontal, 0)

  with entryWithBtnBox:
    append entry
    append enterTextButton
    append enterTextButton2
    setCssClasses("linked")

  enterTextButton.connect(
    "clicked",
    changeTitle,
    EntryAndWindow(entry: entry, window: window, popover: popover),
  )

  popover.child = entryWithBtnBox
  menuButton.popover = popover
  header.packStart(menuButton)

  with mainBox:
    append header
  # header
  with window:
    content = mainBox
    title = "popup test"
    defaultSize = (100, 300)
    show()

proc initAdw(app: adw.Application) =
  adw.init()

proc main() =
  let app = adw.newApplication("org.gtk.example", {})
  app.connect("startup", initAdw)
  app.connect("activate", appActivate)
  discard run(app)

main()

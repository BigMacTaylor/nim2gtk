# nim c about_dialog.nim
import nim2gtk/[gtk, gobject, gio]

proc showAbout(b: Button) =
  let dlg = newAboutDialog()
  dlg.programName = "nim2gtk Example"
  dlg.version = "0.1"
  dlg.logoIconName = "help-about"
  dlg.comments = "About dialog example for nim2gtk"
  dlg.authors = @["Mac Taylor", "Contributors"]
  dlg.website = "https://github.com/BigMacTaylor/nim2gtk"
  dlg.websiteLabel = "nim2gtk"
  discard dlg.run()
  dlg.destroy()

proc appActivate(app: Application) =
  let win = newApplicationWindow(app)
  win.title = "AboutDialog Example"
  win.defaultSize = (320, 120)

  let btn = newButton("About")
  btn.connect("clicked", showAbout)

  win.add(btn)
  win.showAll()

proc main() =
  let app = newApplication("org.gtk.example.about")
  app.connect("activate", appActivate)
  discard run(app)

main()

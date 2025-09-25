# https://vincent.bernat.im/en/blog/2017-write-own-terminal
import nim2gtk/[gtk4, glib, gobject, gio, vte_gtk4]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTK4 & Nim"
  window.defaultSize = (600, 200)
  let terminal = newTerminal()
  let environ = getEnviron()
  let command = environ.environGetenv("SHELL")
  var pid = 0
  echo terminal.spawnSync({}, nil, [command], [], {SpawnFlag.leaveDescriptorsOpen}, nil, nil, pid, nil)
  window.setChild(terminal) # add() for GTK3
  show(window) # showAll() for GTK3

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()
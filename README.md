# High level GTK3/4 bindings for Nim 2.0

CAUTION These bindings are for personal use, and have not been tested thoroughly.
Use at own risk!

Built using [gintro](https://github.com/StefanSalewski/gintro/) by Stefan Salewski.
On Ubuntu 24.04 with Nim 2.2.4



## 1 Install
```bash
nimble install https://github.com/BigMacTaylor/nim2gtk.git
```


## 2 Import nim2gtk in the project
[[app0.nim]]
[source,nim]
.app0.nim
```nim
# app0.nim -- minimal application style example
# nim c app0.nim
import nim2gtk/[gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTK3 APP"
  window.defaultSize = (200, 200)
  showAll(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()
```


## 3 Compile
```bash
nim c app0.nim
```

Thats it!


## Other Good GUI Libraries

* https://github.com/simonkrauter/NiGui.git
* https://github.com/neroist/uing.git
* https://github.com/can-lehmann/owlkettle.git

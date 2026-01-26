# High level GTK3/4 bindings for Nim 2.0

CAUTION These bindings are for personal use, and have not been tested thoroughly.
Use at own risk!

Built using [gintro](https://github.com/StefanSalewski/gintro/) by Stefan Salewski.
On Ubuntu 24.04 with Nim 2.2.4


## Requirements
- Nim (recommended >= 2.2.4)
- nim2gtk depends on glib/gobject/gtk system libraries and sometimes optional components like WebKitGTK or gtksourceview if you use those examples.


## 1 Install
```bash
nimble install https://github.com/BigMacTaylor/nim2gtk.git
```

## 2 Import
### Basic usage
Typical import for GTK3 examples:

```nim
import nim2gtk/[gtk, gobject, gio]
```
Some examples require additional modules:

- `glib` — main loop utilities, idle/timers
- `gtk4` — if you target GTK4 (most examples here use GTK3)
- `webkit2` — WebKitGTK bindings (for browser widgets)
- `gtksource` — for source view (syntax editor)
- `handy` — libhandy widgets (keypad, adaptive widgets)
- `nice` — libnice examples (networking) — legacy

### Minimal example
Application-style (recommended for most apps)

application.nim
```nim
# application.nim -- minimal application style example
# nim c application.nim
import nim2gtk/[gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTK3 APP"
  window.defaultSize = (200, 200)
  window.showAll()

proc main() =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard run(app)

main()
```


## 3 Compile
Compile and run:

```bash
nim c application.nim
./application
```

Thats it!


## Other Good GUI Libraries

* https://github.com/simonkrauter/NiGui.git
* https://github.com/neroist/uing.git
* https://github.com/can-lehmann/owlkettle.git

# dependencies:
# xlib-2.0
# freetype2-2.0
# GLib-2.0
# Gdk-3.0
# HarfBuzz-0.0
# GModule-2.0
# Gtk-3.0
# cairo-1.0
# GObject-2.0
# Pango-1.0
# Gio-2.0
# Atk-1.0
# GdkPixbuf-2.0
# immediate dependencies:
# Gtk-3.0
# libraries:
# libgtk-layer-shell.so.0
{.warning[UnusedImport]: off.}
import xlib, freetype2, glib, gdk, harfbuzz, gmodule, gtk, cairo, gobject, pango, gio, atk, gdkpixbuf
const Lib = "libgtk-layer-shell.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  Edge* {.size: sizeof(cint), pure.} = enum
    left = 0
    right = 1
    top = 2
    bottom = 3
    entryNumber = 4

type
  KeyboardMode* {.size: sizeof(cint), pure.} = enum
    none = 0
    exclusive = 1
    onDemand = 2
    entryNumber = 3

type
  Layer* {.size: sizeof(cint), pure.} = enum
    background = 0
    bottom = 1
    top = 2
    overlay = 3
    entryNumber = 4

proc gtk_layer_auto_exclusive_zone_enable(window: ptr gtk.Window00) {.
    importc, libprag.}

proc autoExclusiveZoneEnable*(window: gtk.Window) =
  gtk_layer_auto_exclusive_zone_enable(cast[ptr gtk.Window00](window.impl))

proc gtk_layer_auto_exclusive_zone_is_enabled(window: ptr gtk.Window00): gboolean {.
    importc, libprag.}

proc autoExclusiveZoneIsEnabled*(window: gtk.Window): bool =
  toBool(gtk_layer_auto_exclusive_zone_is_enabled(cast[ptr gtk.Window00](window.impl)))

proc gtk_layer_get_anchor(window: ptr gtk.Window00; edge: Edge): gboolean {.
    importc, libprag.}

proc getAnchor*(window: gtk.Window; edge: Edge): bool =
  toBool(gtk_layer_get_anchor(cast[ptr gtk.Window00](window.impl), edge))

proc gtk_layer_get_exclusive_zone(window: ptr gtk.Window00): int32 {.
    importc, libprag.}

proc getExclusiveZone*(window: gtk.Window): int =
  int(gtk_layer_get_exclusive_zone(cast[ptr gtk.Window00](window.impl)))

proc exclusiveZone*(window: gtk.Window): int =
  int(gtk_layer_get_exclusive_zone(cast[ptr gtk.Window00](window.impl)))

proc gtk_layer_get_keyboard_interactivity(window: ptr gtk.Window00): gboolean {.
    importc, libprag.}

proc getKeyboardInteractivity*(window: gtk.Window): bool =
  toBool(gtk_layer_get_keyboard_interactivity(cast[ptr gtk.Window00](window.impl)))

proc keyboardInteractivity*(window: gtk.Window): bool =
  toBool(gtk_layer_get_keyboard_interactivity(cast[ptr gtk.Window00](window.impl)))

proc gtk_layer_get_keyboard_mode(window: ptr gtk.Window00): KeyboardMode {.
    importc, libprag.}

proc getKeyboardMode*(window: gtk.Window): KeyboardMode =
  gtk_layer_get_keyboard_mode(cast[ptr gtk.Window00](window.impl))

proc keyboardMode*(window: gtk.Window): KeyboardMode =
  gtk_layer_get_keyboard_mode(cast[ptr gtk.Window00](window.impl))

proc gtk_layer_get_layer(window: ptr gtk.Window00): Layer {.
    importc, libprag.}

proc getLayer*(window: gtk.Window): Layer =
  gtk_layer_get_layer(cast[ptr gtk.Window00](window.impl))

proc layer*(window: gtk.Window): Layer =
  gtk_layer_get_layer(cast[ptr gtk.Window00](window.impl))

proc gtk_layer_get_major_version(): uint32 {.
    importc, libprag.}

proc getMajorVersion*(): int =
  int(gtk_layer_get_major_version())

proc gtk_layer_get_margin(window: ptr gtk.Window00; edge: Edge): int32 {.
    importc, libprag.}

proc getMargin*(window: gtk.Window; edge: Edge): int =
  int(gtk_layer_get_margin(cast[ptr gtk.Window00](window.impl), edge))

proc gtk_layer_get_micro_version(): uint32 {.
    importc, libprag.}

proc getMicroVersion*(): int =
  int(gtk_layer_get_micro_version())

proc gtk_layer_get_minor_version(): uint32 {.
    importc, libprag.}

proc getMinorVersion*(): int =
  int(gtk_layer_get_minor_version())

proc gtk_layer_get_monitor(window: ptr gtk.Window00): ptr gdk.Monitor00 {.
    importc, libprag.}

proc getMonitor*(window: gtk.Window): gdk.Monitor =
  let gobj = gtk_layer_get_monitor(cast[ptr gtk.Window00](window.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc monitor*(window: gtk.Window): gdk.Monitor =
  let gobj = gtk_layer_get_monitor(cast[ptr gtk.Window00](window.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_layer_get_namespace(window: ptr gtk.Window00): cstring {.
    importc, libprag.}

proc getNamespace*(window: gtk.Window): string =
  result = $gtk_layer_get_namespace(cast[ptr gtk.Window00](window.impl))

proc namespace*(window: gtk.Window): string =
  result = $gtk_layer_get_namespace(cast[ptr gtk.Window00](window.impl))

proc gtk_layer_get_protocol_version(): uint32 {.
    importc, libprag.}

proc getProtocolVersion*(): int =
  int(gtk_layer_get_protocol_version())

proc gtk_layer_get_zwlr_layer_surface_v1(window: ptr gtk.Window00): pointer {.
    importc, libprag.}

proc getZwlrLayerSurfaceV1*(window: gtk.Window): pointer =
  gtk_layer_get_zwlr_layer_surface_v1(cast[ptr gtk.Window00](window.impl))

proc gtk_layer_init_for_window(window: ptr gtk.Window00) {.
    importc, libprag.}

proc initForWindow*(window: gtk.Window) =
  gtk_layer_init_for_window(cast[ptr gtk.Window00](window.impl))

proc gtk_layer_is_layer_window(window: ptr gtk.Window00): gboolean {.
    importc, libprag.}

proc isLayerWindow*(window: gtk.Window): bool =
  toBool(gtk_layer_is_layer_window(cast[ptr gtk.Window00](window.impl)))

proc gtk_layer_is_supported(): gboolean {.
    importc, libprag.}

proc isSupported*(): bool =
  toBool(gtk_layer_is_supported())

proc gtk_layer_set_anchor(window: ptr gtk.Window00; edge: Edge; anchorToEdge: gboolean) {.
    importc, libprag.}

proc setAnchor*(window: gtk.Window; edge: Edge; anchorToEdge: bool) =
  gtk_layer_set_anchor(cast[ptr gtk.Window00](window.impl), edge, gboolean(anchorToEdge))

proc gtk_layer_set_exclusive_zone(window: ptr gtk.Window00; exclusiveZone: int32) {.
    importc, libprag.}

proc setExclusiveZone*(window: gtk.Window; exclusiveZone: int) =
  gtk_layer_set_exclusive_zone(cast[ptr gtk.Window00](window.impl), int32(exclusiveZone))

proc `exclusiveZone=`*(window: gtk.Window; exclusiveZone: int) =
  gtk_layer_set_exclusive_zone(cast[ptr gtk.Window00](window.impl), int32(exclusiveZone))

proc gtk_layer_set_keyboard_interactivity(window: ptr gtk.Window00; interactivity: gboolean) {.
    importc, libprag.}

proc setKeyboardInteractivity*(window: gtk.Window; interactivity: bool) =
  gtk_layer_set_keyboard_interactivity(cast[ptr gtk.Window00](window.impl), gboolean(interactivity))

proc `keyboardInteractivity=`*(window: gtk.Window; interactivity: bool) =
  gtk_layer_set_keyboard_interactivity(cast[ptr gtk.Window00](window.impl), gboolean(interactivity))

proc gtk_layer_set_keyboard_mode(window: ptr gtk.Window00; mode: KeyboardMode) {.
    importc, libprag.}

proc setKeyboardMode*(window: gtk.Window; mode: KeyboardMode) =
  gtk_layer_set_keyboard_mode(cast[ptr gtk.Window00](window.impl), mode)

proc `keyboardMode=`*(window: gtk.Window; mode: KeyboardMode) =
  gtk_layer_set_keyboard_mode(cast[ptr gtk.Window00](window.impl), mode)

proc gtk_layer_set_layer(window: ptr gtk.Window00; layer: Layer) {.
    importc, libprag.}

proc setLayer*(window: gtk.Window; layer: Layer) =
  gtk_layer_set_layer(cast[ptr gtk.Window00](window.impl), layer)

proc `layer=`*(window: gtk.Window; layer: Layer) =
  gtk_layer_set_layer(cast[ptr gtk.Window00](window.impl), layer)

proc gtk_layer_set_margin(window: ptr gtk.Window00; edge: Edge; marginSize: int32) {.
    importc, libprag.}

proc setMargin*(window: gtk.Window; edge: Edge; marginSize: int) =
  gtk_layer_set_margin(cast[ptr gtk.Window00](window.impl), edge, int32(marginSize))

proc gtk_layer_set_monitor(window: ptr gtk.Window00; monitor: ptr gdk.Monitor00) {.
    importc, libprag.}

proc setMonitor*(window: gtk.Window; monitor: gdk.Monitor) =
  gtk_layer_set_monitor(cast[ptr gtk.Window00](window.impl), cast[ptr gdk.Monitor00](monitor.impl))

proc `monitor=`*(window: gtk.Window; monitor: gdk.Monitor) =
  gtk_layer_set_monitor(cast[ptr gtk.Window00](window.impl), cast[ptr gdk.Monitor00](monitor.impl))

proc gtk_layer_set_namespace(window: ptr gtk.Window00; nameSpace: cstring) {.
    importc, libprag.}

proc setNamespace*(window: gtk.Window; nameSpace: cstring) =
  gtk_layer_set_namespace(cast[ptr gtk.Window00](window.impl), nameSpace)

proc `namespace=`*(window: gtk.Window; nameSpace: cstring) =
  gtk_layer_set_namespace(cast[ptr gtk.Window00](window.impl), nameSpace)
# === remaining symbols:

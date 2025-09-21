# dependencies:
# PangoCairo-1.0
# xlib-2.0
# freetype2-2.0
# GLib-2.0
# GdkPixbuf-2.0
# HarfBuzz-0.0
# GModule-2.0
# cairo-1.0
# GObject-2.0
# Pango-1.0
# Gdk-4.0
# Gio-2.0
# immediate dependencies:
# xlib-2.0
# Gdk-4.0
# libraries:
# libgtk-4.so.1
{.warning[UnusedImport]: off.}
import pangocairo, xlib, freetype2, glib, gdkpixbuf, harfbuzz, gmodule, cairo, gobject, pango, gdk4, gio
const Lib = "libgtk-4.so.1"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  X11AppLaunchContext* = ref object of gdk4.AppLaunchContext
  X11AppLaunchContext00* = object of gdk4.AppLaunchContext00

proc gdk_x11_app_launch_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11AppLaunchContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11DeviceManagerXI2* = ref object of gobject.Object
  X11DeviceManagerXI200* = object of gobject.Object00

proc gdk_x11_device_manager_xi2_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11DeviceManagerXI2()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11DeviceType* {.size: sizeof(cint), pure.} = enum
    logical = 0
    physical = 1
    floating = 2

type
  X11DeviceXI2* = ref object of gdk4.Device
  X11DeviceXI200* = object of gdk4.Device00

proc gdk_x11_device_xi2_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11DeviceXI2()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11Display* = ref object of gdk4.Display
  X11Display00* = object of gdk4.Display00

proc gdk_x11_display_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Display()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scXevent*(self: X11Display;  p: proc (self: ptr X11Display00; xevent: pointer; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "xevent", cast[GCallback](p), xdata, nil, cf)

proc gdk_x11_display_open(displayName: cstring): ptr gdk4.Display00 {.
    importc, libprag.}

proc open*(displayName: cstring = nil): gdk4.Display =
  let gobj = gdk_x11_display_open(displayName)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_x11_display_set_program_class(display: ptr gdk4.Display00; programClass: cstring) {.
    importc, libprag.}

proc setProgramClass*(display: gdk4.Display; programClass: cstring) =
  gdk_x11_display_set_program_class(cast[ptr gdk4.Display00](display.impl), programClass)

proc `programClass=`*(display: gdk4.Display; programClass: cstring) =
  gdk_x11_display_set_program_class(cast[ptr gdk4.Display00](display.impl), programClass)

proc gdk_x11_display_error_trap_pop(self: ptr X11Display00): int32 {.
    importc, libprag.}

proc errorTrapPop*(self: X11Display): int =
  int(gdk_x11_display_error_trap_pop(cast[ptr X11Display00](self.impl)))

proc gdk_x11_display_error_trap_pop_ignored(self: ptr X11Display00) {.
    importc, libprag.}

proc errorTrapPopIgnored*(self: X11Display) =
  gdk_x11_display_error_trap_pop_ignored(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_error_trap_push(self: ptr X11Display00) {.
    importc, libprag.}

proc errorTrapPush*(self: X11Display) =
  gdk_x11_display_error_trap_push(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_get_default_group(self: ptr X11Display00): ptr gdk4.Surface00 {.
    importc, libprag.}

proc getDefaultGroup*(self: X11Display): gdk4.Surface =
  let gobj = gdk_x11_display_get_default_group(cast[ptr X11Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc defaultGroup*(self: X11Display): gdk4.Surface =
  let gobj = gdk_x11_display_get_default_group(cast[ptr X11Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_x11_display_get_egl_display(self: ptr X11Display00): pointer {.
    importc, libprag.}

proc getEglDisplay*(self: X11Display): pointer =
  gdk_x11_display_get_egl_display(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_get_egl_version(self: ptr X11Display00; major: var int32;
    minor: var int32): gboolean {.
    importc, libprag.}

proc getEglVersion*(self: X11Display; major: var int; minor: var int): bool =
  var major_00: int32
  var minor_00: int32
  result = toBool(gdk_x11_display_get_egl_version(cast[ptr X11Display00](self.impl), major_00, minor_00))
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)

proc gdk_x11_display_get_glx_version(self: ptr X11Display00; major: var int32;
    minor: var int32): gboolean {.
    importc, libprag.}

proc getGlxVersion*(self: X11Display; major: var int; minor: var int): bool =
  var major_00: int32
  var minor_00: int32
  result = toBool(gdk_x11_display_get_glx_version(cast[ptr X11Display00](self.impl), major_00, minor_00))
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)

proc gdk_x11_display_get_primary_monitor(self: ptr X11Display00): ptr gdk4.Monitor00 {.
    importc, libprag.}

proc getPrimaryMonitor*(self: X11Display): gdk4.Monitor =
  let gobj = gdk_x11_display_get_primary_monitor(cast[ptr X11Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc primaryMonitor*(self: X11Display): gdk4.Monitor =
  let gobj = gdk_x11_display_get_primary_monitor(cast[ptr X11Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_x11_display_get_startup_notification_id(self: ptr X11Display00): cstring {.
    importc, libprag.}

proc getStartupNotificationId*(self: X11Display): string =
  result = $gdk_x11_display_get_startup_notification_id(cast[ptr X11Display00](self.impl))

proc startupNotificationId*(self: X11Display): string =
  result = $gdk_x11_display_get_startup_notification_id(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_get_user_time(self: ptr X11Display00): uint32 {.
    importc, libprag.}

proc getUserTime*(self: X11Display): int =
  int(gdk_x11_display_get_user_time(cast[ptr X11Display00](self.impl)))

proc userTime*(self: X11Display): int =
  int(gdk_x11_display_get_user_time(cast[ptr X11Display00](self.impl)))

proc gdk_x11_display_get_xcursor(self: ptr X11Display00; cursor: ptr gdk4.Cursor00): uint64 {.
    importc, libprag.}

proc getXcursor*(self: X11Display; cursor: gdk4.Cursor): uint64 =
  gdk_x11_display_get_xcursor(cast[ptr X11Display00](self.impl), cast[ptr gdk4.Cursor00](cursor.impl))

proc gdk_x11_display_get_xdisplay(self: ptr X11Display00): ptr xlib.Display00 {.
    importc, libprag.}

proc getXdisplay*(self: X11Display): xlib.Display =
  new(result)
  result.impl = gdk_x11_display_get_xdisplay(cast[ptr X11Display00](self.impl))
  result.ignoreFinalizer = true

proc xdisplay*(self: X11Display): xlib.Display =
  new(result)
  result.impl = gdk_x11_display_get_xdisplay(cast[ptr X11Display00](self.impl))
  result.ignoreFinalizer = true

proc gdk_x11_display_get_xrootwindow(self: ptr X11Display00): uint64 {.
    importc, libprag.}

proc getXrootwindow*(self: X11Display): uint64 =
  gdk_x11_display_get_xrootwindow(cast[ptr X11Display00](self.impl))

proc xrootwindow*(self: X11Display): uint64 =
  gdk_x11_display_get_xrootwindow(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_get_xscreen(self: ptr X11Display00): ptr xlib.Screen00 {.
    importc, libprag.}

proc getXscreen*(self: X11Display): xlib.Screen =
  new(result)
  result.impl = gdk_x11_display_get_xscreen(cast[ptr X11Display00](self.impl))
  result.ignoreFinalizer = true

proc xscreen*(self: X11Display): xlib.Screen =
  new(result)
  result.impl = gdk_x11_display_get_xscreen(cast[ptr X11Display00](self.impl))
  result.ignoreFinalizer = true

proc gdk_x11_display_grab(self: ptr X11Display00) {.
    importc, libprag.}

proc grab*(self: X11Display) =
  gdk_x11_display_grab(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_set_cursor_theme(self: ptr X11Display00; theme: cstring;
    size: int32) {.
    importc, libprag.}

proc setCursorTheme*(self: X11Display; theme: cstring = nil;
    size: int) =
  gdk_x11_display_set_cursor_theme(cast[ptr X11Display00](self.impl), theme, int32(size))

proc gdk_x11_display_set_startup_notification_id(self: ptr X11Display00;
    startupId: cstring) {.
    importc, libprag.}

proc setStartupNotificationId*(self: X11Display; startupId: cstring) =
  gdk_x11_display_set_startup_notification_id(cast[ptr X11Display00](self.impl), startupId)

proc `startupNotificationId=`*(self: X11Display; startupId: cstring) =
  gdk_x11_display_set_startup_notification_id(cast[ptr X11Display00](self.impl), startupId)

proc gdk_x11_display_set_surface_scale(self: ptr X11Display00; scale: int32) {.
    importc, libprag.}

proc setSurfaceScale*(self: X11Display; scale: int) =
  gdk_x11_display_set_surface_scale(cast[ptr X11Display00](self.impl), int32(scale))

proc `surfaceScale=`*(self: X11Display; scale: int) =
  gdk_x11_display_set_surface_scale(cast[ptr X11Display00](self.impl), int32(scale))

proc gdk_x11_display_string_to_compound_text(self: ptr X11Display00; str: cstring;
    encoding: var cstring; format: var int32; ctext: var ptr uint8; length: var int32): int32 {.
    importc, libprag.}

proc stringToCompoundText*(self: X11Display; str: cstring;
    encoding: var string; format: var int; ctext: var (seq[uint8] | string);
    length: var int): int =
  var ctext_00: ptr uint8
  var format_00: int32
  var encoding_00: cstring
  var length_00: int32
  result = int(gdk_x11_display_string_to_compound_text(cast[ptr X11Display00](self.impl), str, encoding_00, format_00, ctext_00, length_00))
  ctext.setLen(length)
  copyMem(unsafeaddr ctext[0], ctext_00, length.int * sizeof(ctext[0]))
  cogfree(ctext_00)
  if format.addr != nil:
    format = int(format_00)
  if encoding.addr != nil:
    encoding = $(encoding_00)
  if length.addr != nil:
    length = int(length_00)

proc gdk_x11_display_text_property_to_text_list(self: ptr X11Display00; encoding: cstring;
    format: int32; text: ptr uint8; length: int32; list: cstring): int32 {.
    importc, libprag.}

proc textPropertyToTextList*(self: X11Display; encoding: cstring;
    format: int; text: ptr uint8; length: int; list: cstring): int =
  int(gdk_x11_display_text_property_to_text_list(cast[ptr X11Display00](self.impl), encoding, int32(format), text, int32(length), list))

proc gdk_x11_display_ungrab(self: ptr X11Display00) {.
    importc, libprag.}

proc ungrab*(self: X11Display) =
  gdk_x11_display_ungrab(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_utf8_to_compound_text(self: ptr X11Display00; str: cstring;
    encoding: var cstring; format: var int32; ctext: var ptr uint8; length: var int32): gboolean {.
    importc, libprag.}

proc utf8ToCompoundText*(self: X11Display; str: cstring;
    encoding: var string; format: var int; ctext: var (seq[uint8] | string);
    length: var int): bool =
  var ctext_00: ptr uint8
  var format_00: int32
  var encoding_00: cstring
  var length_00: int32
  result = toBool(gdk_x11_display_utf8_to_compound_text(cast[ptr X11Display00](self.impl), str, encoding_00, format_00, ctext_00, length_00))
  ctext.setLen(length)
  copyMem(unsafeaddr ctext[0], ctext_00, length.int * sizeof(ctext[0]))
  cogfree(ctext_00)
  if format.addr != nil:
    format = int(format_00)
  if encoding.addr != nil:
    encoding = $(encoding_00)
  if length.addr != nil:
    length = int(length_00)

type
  X11Screen* = ref object of gobject.Object
  X11Screen00* = object of gobject.Object00

proc gdk_x11_screen_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Screen()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scWindowManagerChanged*(self: X11Screen;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "window-manager-changed", cast[GCallback](p), xdata, nil, cf)

proc gdk_x11_screen_get_current_desktop(self: ptr X11Screen00): uint32 {.
    importc, libprag.}

proc getCurrentDesktop*(self: X11Screen): int =
  int(gdk_x11_screen_get_current_desktop(cast[ptr X11Screen00](self.impl)))

proc currentDesktop*(self: X11Screen): int =
  int(gdk_x11_screen_get_current_desktop(cast[ptr X11Screen00](self.impl)))

proc gdk_x11_screen_get_monitor_output(self: ptr X11Screen00; monitorNum: int32): uint64 {.
    importc, libprag.}

proc getMonitorOutput*(self: X11Screen; monitorNum: int): uint64 =
  gdk_x11_screen_get_monitor_output(cast[ptr X11Screen00](self.impl), int32(monitorNum))

proc gdk_x11_screen_get_number_of_desktops(self: ptr X11Screen00): uint32 {.
    importc, libprag.}

proc getNumberOfDesktops*(self: X11Screen): int =
  int(gdk_x11_screen_get_number_of_desktops(cast[ptr X11Screen00](self.impl)))

proc numberOfDesktops*(self: X11Screen): int =
  int(gdk_x11_screen_get_number_of_desktops(cast[ptr X11Screen00](self.impl)))

proc gdk_x11_screen_get_screen_number(self: ptr X11Screen00): int32 {.
    importc, libprag.}

proc getScreenNumber*(self: X11Screen): int =
  int(gdk_x11_screen_get_screen_number(cast[ptr X11Screen00](self.impl)))

proc screenNumber*(self: X11Screen): int =
  int(gdk_x11_screen_get_screen_number(cast[ptr X11Screen00](self.impl)))

proc gdk_x11_screen_get_window_manager_name(self: ptr X11Screen00): cstring {.
    importc, libprag.}

proc getWindowManagerName*(self: X11Screen): string =
  result = $gdk_x11_screen_get_window_manager_name(cast[ptr X11Screen00](self.impl))

proc windowManagerName*(self: X11Screen): string =
  result = $gdk_x11_screen_get_window_manager_name(cast[ptr X11Screen00](self.impl))

proc gdk_x11_screen_get_xscreen(self: ptr X11Screen00): ptr xlib.Screen00 {.
    importc, libprag.}

proc getXscreen*(self: X11Screen): xlib.Screen =
  new(result)
  result.impl = gdk_x11_screen_get_xscreen(cast[ptr X11Screen00](self.impl))
  result.ignoreFinalizer = true

proc xscreen*(self: X11Screen): xlib.Screen =
  new(result)
  result.impl = gdk_x11_screen_get_xscreen(cast[ptr X11Screen00](self.impl))
  result.ignoreFinalizer = true

proc gdk_x11_screen_supports_net_wm_hint(self: ptr X11Screen00; propertyName: cstring): gboolean {.
    importc, libprag.}

proc supportsNetWmHint*(self: X11Screen; propertyName: cstring): bool =
  toBool(gdk_x11_screen_supports_net_wm_hint(cast[ptr X11Screen00](self.impl), propertyName))

proc gdk_x11_display_get_screen(self: ptr X11Display00): ptr X11Screen00 {.
    importc, libprag.}

proc getScreen*(self: X11Display): X11Screen =
  let gobj = gdk_x11_display_get_screen(cast[ptr X11Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkx114.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc screen*(self: X11Display): X11Screen =
  let gobj = gdk_x11_display_get_screen(cast[ptr X11Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkx114.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  X11Drag* = ref object of gdk4.Drag
  X11Drag00* = object of gdk4.Drag00

proc gdk_x11_drag_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Drag()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11GLContext* = ref object of gdk4.GLContext
  X11GLContext00* = object of gdk4.GLContext00

proc gdk_x11_gl_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11GLContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11Monitor* = ref object of gdk4.Monitor
  X11Monitor00* = object of gdk4.Monitor00

proc gdk_x11_monitor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Monitor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_x11_monitor_get_output(self: ptr X11Monitor00): uint64 {.
    importc, libprag.}

proc getOutput*(self: X11Monitor): uint64 =
  gdk_x11_monitor_get_output(cast[ptr X11Monitor00](self.impl))

proc output*(self: X11Monitor): uint64 =
  gdk_x11_monitor_get_output(cast[ptr X11Monitor00](self.impl))

proc gdk_x11_monitor_get_workarea(self: ptr X11Monitor00; workarea: var gdk4.Rectangle) {.
    importc, libprag.}

proc getWorkarea*(self: X11Monitor; workarea: var gdk4.Rectangle) =
  gdk_x11_monitor_get_workarea(cast[ptr X11Monitor00](self.impl), workarea)

proc getWorkarea*(self: X11Monitor): gdk4.Rectangle =
  gdk_x11_monitor_get_workarea(cast[ptr X11Monitor00](self.impl), result)

type
  X11Surface* = ref object of gdk4.Surface
  X11Surface00* = object of gdk4.Surface00

proc gdk_x11_surface_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Surface()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_x11_surface_lookup_for_display(display: ptr X11Display00; window: uint64): ptr X11Surface00 {.
    importc, libprag.}

proc lookupForDisplay*(display: X11Display; window: uint64): X11Surface =
  let gobj = gdk_x11_surface_lookup_for_display(cast[ptr X11Display00](display.impl), window)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkx114.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_x11_surface_get_desktop(self: ptr X11Surface00): uint32 {.
    importc, libprag.}

proc getDesktop*(self: X11Surface): int =
  int(gdk_x11_surface_get_desktop(cast[ptr X11Surface00](self.impl)))

proc desktop*(self: X11Surface): int =
  int(gdk_x11_surface_get_desktop(cast[ptr X11Surface00](self.impl)))

proc gdk_x11_surface_get_group(self: ptr X11Surface00): ptr gdk4.Surface00 {.
    importc, libprag.}

proc getGroup*(self: X11Surface): gdk4.Surface =
  let gobj = gdk_x11_surface_get_group(cast[ptr X11Surface00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc group*(self: X11Surface): gdk4.Surface =
  let gobj = gdk_x11_surface_get_group(cast[ptr X11Surface00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_x11_surface_get_xid(self: ptr X11Surface00): uint64 {.
    importc, libprag.}

proc getXid*(self: X11Surface): uint64 =
  gdk_x11_surface_get_xid(cast[ptr X11Surface00](self.impl))

proc xid*(self: X11Surface): uint64 =
  gdk_x11_surface_get_xid(cast[ptr X11Surface00](self.impl))

proc gdk_x11_surface_move_to_current_desktop(self: ptr X11Surface00) {.
    importc, libprag.}

proc moveToCurrentDesktop*(self: X11Surface) =
  gdk_x11_surface_move_to_current_desktop(cast[ptr X11Surface00](self.impl))

proc gdk_x11_surface_move_to_desktop(self: ptr X11Surface00; desktop: uint32) {.
    importc, libprag.}

proc moveToDesktop*(self: X11Surface; desktop: int) =
  gdk_x11_surface_move_to_desktop(cast[ptr X11Surface00](self.impl), uint32(desktop))

proc gdk_x11_surface_set_frame_sync_enabled(self: ptr X11Surface00; frameSyncEnabled: gboolean) {.
    importc, libprag.}

proc setFrameSyncEnabled*(self: X11Surface; frameSyncEnabled: bool = true) =
  gdk_x11_surface_set_frame_sync_enabled(cast[ptr X11Surface00](self.impl), gboolean(frameSyncEnabled))

proc `frameSyncEnabled=`*(self: X11Surface; frameSyncEnabled: bool) =
  gdk_x11_surface_set_frame_sync_enabled(cast[ptr X11Surface00](self.impl), gboolean(frameSyncEnabled))

proc gdk_x11_surface_set_group(self: ptr X11Surface00; leader: ptr gdk4.Surface00) {.
    importc, libprag.}

proc setGroup*(self: X11Surface; leader: gdk4.Surface) =
  gdk_x11_surface_set_group(cast[ptr X11Surface00](self.impl), cast[ptr gdk4.Surface00](leader.impl))

proc `group=`*(self: X11Surface; leader: gdk4.Surface) =
  gdk_x11_surface_set_group(cast[ptr X11Surface00](self.impl), cast[ptr gdk4.Surface00](leader.impl))

proc gdk_x11_surface_set_skip_pager_hint(self: ptr X11Surface00; skipsPager: gboolean) {.
    importc, libprag.}

proc setSkipPagerHint*(self: X11Surface; skipsPager: bool = true) =
  gdk_x11_surface_set_skip_pager_hint(cast[ptr X11Surface00](self.impl), gboolean(skipsPager))

proc `skipPagerHint=`*(self: X11Surface; skipsPager: bool) =
  gdk_x11_surface_set_skip_pager_hint(cast[ptr X11Surface00](self.impl), gboolean(skipsPager))

proc gdk_x11_surface_set_skip_taskbar_hint(self: ptr X11Surface00; skipsTaskbar: gboolean) {.
    importc, libprag.}

proc setSkipTaskbarHint*(self: X11Surface; skipsTaskbar: bool = true) =
  gdk_x11_surface_set_skip_taskbar_hint(cast[ptr X11Surface00](self.impl), gboolean(skipsTaskbar))

proc `skipTaskbarHint=`*(self: X11Surface; skipsTaskbar: bool) =
  gdk_x11_surface_set_skip_taskbar_hint(cast[ptr X11Surface00](self.impl), gboolean(skipsTaskbar))

proc gdk_x11_surface_set_theme_variant(self: ptr X11Surface00; variant: cstring) {.
    importc, libprag.}

proc setThemeVariant*(self: X11Surface; variant: cstring) =
  gdk_x11_surface_set_theme_variant(cast[ptr X11Surface00](self.impl), variant)

proc `themeVariant=`*(self: X11Surface; variant: cstring) =
  gdk_x11_surface_set_theme_variant(cast[ptr X11Surface00](self.impl), variant)

proc gdk_x11_surface_set_urgency_hint(self: ptr X11Surface00; urgent: gboolean) {.
    importc, libprag.}

proc setUrgencyHint*(self: X11Surface; urgent: bool = true) =
  gdk_x11_surface_set_urgency_hint(cast[ptr X11Surface00](self.impl), gboolean(urgent))

proc `urgencyHint=`*(self: X11Surface; urgent: bool) =
  gdk_x11_surface_set_urgency_hint(cast[ptr X11Surface00](self.impl), gboolean(urgent))

proc gdk_x11_surface_set_user_time(self: ptr X11Surface00; timestamp: uint32) {.
    importc, libprag.}

proc setUserTime*(self: X11Surface; timestamp: int) =
  gdk_x11_surface_set_user_time(cast[ptr X11Surface00](self.impl), uint32(timestamp))

proc `userTime=`*(self: X11Surface; timestamp: int) =
  gdk_x11_surface_set_user_time(cast[ptr X11Surface00](self.impl), uint32(timestamp))

proc gdk_x11_surface_set_utf8_property(self: ptr X11Surface00; name: cstring;
    value: cstring) {.
    importc, libprag.}

proc setUtf8Property*(self: X11Surface; name: cstring; value: cstring = nil) =
  gdk_x11_surface_set_utf8_property(cast[ptr X11Surface00](self.impl), name, value)

proc gdk_x11_device_get_id(device: ptr X11DeviceXI200): int32 {.
    importc, libprag.}

proc x11DeviceGetId*(device: X11DeviceXI2): int =
  int(gdk_x11_device_get_id(cast[ptr X11DeviceXI200](device.impl)))

proc gdk_x11_device_manager_lookup(deviceManager: ptr X11DeviceManagerXI200;
    deviceId: int32): ptr X11DeviceXI200 {.
    importc, libprag.}

proc x11DeviceManagerLookup*(deviceManager: X11DeviceManagerXI2; deviceId: int): X11DeviceXI2 =
  let gobj = gdk_x11_device_manager_lookup(cast[ptr X11DeviceManagerXI200](deviceManager.impl), int32(deviceId))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkx114.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc x11FreeCompoundText*(ctext: ptr uint8) {.
    importc: "gdk_x11_free_compound_text", libprag.}

proc x11FreeTextList*(list: cstring) {.
    importc: "gdk_x11_free_text_list", libprag.}

proc gdk_x11_get_server_time(surface: ptr X11Surface00): uint32 {.
    importc, libprag.}

proc x11GetServerTime*(surface: X11Surface): int =
  int(gdk_x11_get_server_time(cast[ptr X11Surface00](surface.impl)))

proc gdk_x11_get_xatom_by_name_for_display(display: ptr X11Display00; atomName: cstring): uint64 {.
    importc, libprag.}

proc x11GetXatomByNameForDisplay*(display: X11Display; atomName: cstring): uint64 =
  gdk_x11_get_xatom_by_name_for_display(cast[ptr X11Display00](display.impl), atomName)

proc gdk_x11_get_xatom_name_for_display(display: ptr X11Display00; xatom: uint64): cstring {.
    importc, libprag.}

proc x11GetXatomNameForDisplay*(display: X11Display; xatom: uint64): string =
  result = $gdk_x11_get_xatom_name_for_display(cast[ptr X11Display00](display.impl), xatom)

proc gdk_x11_lookup_xdisplay(xdisplay: ptr xlib.Display00): ptr X11Display00 {.
    importc, libprag.}

proc x11LookupXdisplay*(xdisplay: xlib.Display): X11Display =
  let gobj = gdk_x11_lookup_xdisplay(cast[ptr xlib.Display00](xdisplay.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkx114.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc x11SetSmClientId*(smClientId: cstring) {.
    importc: "gdk_x11_set_sm_client_id", libprag.}
# === remaining symbols:

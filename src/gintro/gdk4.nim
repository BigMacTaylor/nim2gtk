# dependencies:
# PangoCairo-1.0
# freetype2-2.0
# GLib-2.0
# GdkPixbuf-2.0
# HarfBuzz-0.0
# GModule-2.0
# cairo-1.0
# GObject-2.0
# Pango-1.0
# Gio-2.0
# immediate dependencies:
# cairo-1.0
# PangoCairo-1.0
# Pango-1.0
# Gio-2.0
# GdkPixbuf-2.0
# libraries:
# libgtk-4.so.1
{.warning[UnusedImport]: off.}
import pangocairo, freetype2, glib, gdkpixbuf, harfbuzz, gmodule, cairo, gobject, pango, gio
const Lib = "libgtk-4.so.1"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const ACTION_ALL* = 7'i32

type
  AnchorHints* {.size: sizeof(cint), pure.} = enum
    flipX = 1
    flipY = 2
    flip = 3
    slideX = 4
    slideY = 8
    slide = 12
    resizeX = 16
    resizeY = 32
    resize = 48

type
  AppLaunchContext* = ref object of gio.AppLaunchContext
  AppLaunchContext00* = object of gio.AppLaunchContext00

proc gdk_app_launch_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AppLaunchContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_app_launch_context_set_desktop(self: ptr AppLaunchContext00; desktop: int32) {.
    importc, libprag.}

proc setDesktop*(self: AppLaunchContext; desktop: int) =
  gdk_app_launch_context_set_desktop(cast[ptr AppLaunchContext00](self.impl), int32(desktop))

proc `desktop=`*(self: AppLaunchContext; desktop: int) =
  gdk_app_launch_context_set_desktop(cast[ptr AppLaunchContext00](self.impl), int32(desktop))

proc gdk_app_launch_context_set_icon(self: ptr AppLaunchContext00; icon: ptr gio.Icon00) {.
    importc, libprag.}

proc setIcon*(self: AppLaunchContext; icon: gio.Icon = nil) =
  gdk_app_launch_context_set_icon(cast[ptr AppLaunchContext00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc `icon=`*(self: AppLaunchContext; icon: gio.Icon = nil) =
  gdk_app_launch_context_set_icon(cast[ptr AppLaunchContext00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc gdk_app_launch_context_set_icon_name(self: ptr AppLaunchContext00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: AppLaunchContext; iconName: cstring = nil) =
  gdk_app_launch_context_set_icon_name(cast[ptr AppLaunchContext00](self.impl), iconName)

proc `iconName=`*(self: AppLaunchContext; iconName: cstring = nil) =
  gdk_app_launch_context_set_icon_name(cast[ptr AppLaunchContext00](self.impl), iconName)

proc gdk_app_launch_context_set_timestamp(self: ptr AppLaunchContext00; timestamp: uint32) {.
    importc, libprag.}

proc setTimestamp*(self: AppLaunchContext; timestamp: int) =
  gdk_app_launch_context_set_timestamp(cast[ptr AppLaunchContext00](self.impl), uint32(timestamp))

proc `timestamp=`*(self: AppLaunchContext; timestamp: int) =
  gdk_app_launch_context_set_timestamp(cast[ptr AppLaunchContext00](self.impl), uint32(timestamp))

type
  DeviceTool* = ref object of gobject.Object
  DeviceTool00* = object of gobject.Object00

proc gdk_device_tool_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DeviceTool()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_device_tool_get_hardware_id(self: ptr DeviceTool00): uint64 {.
    importc, libprag.}

proc getHardwareId*(self: DeviceTool): uint64 =
  gdk_device_tool_get_hardware_id(cast[ptr DeviceTool00](self.impl))

proc hardwareId*(self: DeviceTool): uint64 =
  gdk_device_tool_get_hardware_id(cast[ptr DeviceTool00](self.impl))

proc gdk_device_tool_get_serial(self: ptr DeviceTool00): uint64 {.
    importc, libprag.}

proc getSerial*(self: DeviceTool): uint64 =
  gdk_device_tool_get_serial(cast[ptr DeviceTool00](self.impl))

proc serial*(self: DeviceTool): uint64 =
  gdk_device_tool_get_serial(cast[ptr DeviceTool00](self.impl))

type
  Device* = ref object of gobject.Object
  Device00* = object of gobject.Object00

proc gdk_device_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Device()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChanged*(self: Device;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc scToolChanged*(self: Device;  p: proc (self: ptr Device00; tool: ptr DeviceTool00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "tool-changed", cast[GCallback](p), xdata, nil, cf)

proc gdk_device_get_caps_lock_state(self: ptr Device00): gboolean {.
    importc, libprag.}

proc getCapsLockState*(self: Device): bool =
  toBool(gdk_device_get_caps_lock_state(cast[ptr Device00](self.impl)))

proc capsLockState*(self: Device): bool =
  toBool(gdk_device_get_caps_lock_state(cast[ptr Device00](self.impl)))

proc gdk_device_get_device_tool(self: ptr Device00): ptr DeviceTool00 {.
    importc, libprag.}

proc getDeviceTool*(self: Device): DeviceTool =
  let gobj = gdk_device_get_device_tool(cast[ptr Device00](self.impl))
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

proc deviceTool*(self: Device): DeviceTool =
  let gobj = gdk_device_get_device_tool(cast[ptr Device00](self.impl))
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

proc gdk_device_get_direction(self: ptr Device00): pango.Direction {.
    importc, libprag.}

proc getDirection*(self: Device): pango.Direction =
  gdk_device_get_direction(cast[ptr Device00](self.impl))

proc direction*(self: Device): pango.Direction =
  gdk_device_get_direction(cast[ptr Device00](self.impl))

proc gdk_device_get_has_cursor(self: ptr Device00): gboolean {.
    importc, libprag.}

proc getHasCursor*(self: Device): bool =
  toBool(gdk_device_get_has_cursor(cast[ptr Device00](self.impl)))

proc hasCursor*(self: Device): bool =
  toBool(gdk_device_get_has_cursor(cast[ptr Device00](self.impl)))

proc gdk_device_get_name(self: ptr Device00): cstring {.
    importc, libprag.}

proc getName*(self: Device): string =
  result = $gdk_device_get_name(cast[ptr Device00](self.impl))

proc name*(self: Device): string =
  result = $gdk_device_get_name(cast[ptr Device00](self.impl))

proc gdk_device_get_num_lock_state(self: ptr Device00): gboolean {.
    importc, libprag.}

proc getNumLockState*(self: Device): bool =
  toBool(gdk_device_get_num_lock_state(cast[ptr Device00](self.impl)))

proc numLockState*(self: Device): bool =
  toBool(gdk_device_get_num_lock_state(cast[ptr Device00](self.impl)))

proc gdk_device_get_num_touches(self: ptr Device00): uint32 {.
    importc, libprag.}

proc getNumTouches*(self: Device): int =
  int(gdk_device_get_num_touches(cast[ptr Device00](self.impl)))

proc numTouches*(self: Device): int =
  int(gdk_device_get_num_touches(cast[ptr Device00](self.impl)))

proc gdk_device_get_product_id(self: ptr Device00): cstring {.
    importc, libprag.}

proc getProductId*(self: Device): string =
  let resul0 = gdk_device_get_product_id(cast[ptr Device00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc productId*(self: Device): string =
  let resul0 = gdk_device_get_product_id(cast[ptr Device00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_device_get_scroll_lock_state(self: ptr Device00): gboolean {.
    importc, libprag.}

proc getScrollLockState*(self: Device): bool =
  toBool(gdk_device_get_scroll_lock_state(cast[ptr Device00](self.impl)))

proc scrollLockState*(self: Device): bool =
  toBool(gdk_device_get_scroll_lock_state(cast[ptr Device00](self.impl)))

proc gdk_device_get_timestamp(self: ptr Device00): uint32 {.
    importc, libprag.}

proc getTimestamp*(self: Device): int =
  int(gdk_device_get_timestamp(cast[ptr Device00](self.impl)))

proc timestamp*(self: Device): int =
  int(gdk_device_get_timestamp(cast[ptr Device00](self.impl)))

proc gdk_device_get_vendor_id(self: ptr Device00): cstring {.
    importc, libprag.}

proc getVendorId*(self: Device): string =
  let resul0 = gdk_device_get_vendor_id(cast[ptr Device00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc vendorId*(self: Device): string =
  let resul0 = gdk_device_get_vendor_id(cast[ptr Device00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_device_has_bidi_layouts(self: ptr Device00): gboolean {.
    importc, libprag.}

proc hasBidiLayouts*(self: Device): bool =
  toBool(gdk_device_has_bidi_layouts(cast[ptr Device00](self.impl)))

type
  Seat* = ref object of gobject.Object
  Seat00* = object of gobject.Object00

proc gdk_seat_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Seat()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDeviceAdded*(self: Seat;  p: proc (self: ptr Seat00; device: ptr Device00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "device-added", cast[GCallback](p), xdata, nil, cf)

proc scDeviceRemoved*(self: Seat;  p: proc (self: ptr Seat00; device: ptr Device00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "device-removed", cast[GCallback](p), xdata, nil, cf)

proc scToolAdded*(self: Seat;  p: proc (self: ptr Seat00; tool: ptr DeviceTool00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "tool-added", cast[GCallback](p), xdata, nil, cf)

proc scToolRemoved*(self: Seat;  p: proc (self: ptr Seat00; tool: ptr DeviceTool00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "tool-removed", cast[GCallback](p), xdata, nil, cf)

proc gdk_seat_get_keyboard(self: ptr Seat00): ptr Device00 {.
    importc, libprag.}

proc getKeyboard*(self: Seat): Device =
  let gobj = gdk_seat_get_keyboard(cast[ptr Seat00](self.impl))
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

proc keyboard*(self: Seat): Device =
  let gobj = gdk_seat_get_keyboard(cast[ptr Seat00](self.impl))
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

proc gdk_seat_get_pointer(self: ptr Seat00): ptr Device00 {.
    importc, libprag.}

proc getPointer*(self: Seat): Device =
  let gobj = gdk_seat_get_pointer(cast[ptr Seat00](self.impl))
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

proc gdk_seat_get_tools(self: ptr Seat00): ptr glib.List {.
    importc, libprag.}

proc getTools*(self: Seat): seq[DeviceTool] =
  let resul0 = gdk_seat_get_tools(cast[ptr Seat00](self.impl))
  result = glistObjects2seq(DeviceTool, resul0, false)
  g_list_free(resul0)

proc tools*(self: Seat): seq[DeviceTool] =
  let resul0 = gdk_seat_get_tools(cast[ptr Seat00](self.impl))
  result = glistObjects2seq(DeviceTool, resul0, false)
  g_list_free(resul0)

type
  Display* = ref object of gobject.Object
  Display00* = object of gobject.Object00

proc gdk_display_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Display()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scClosed*(self: Display;  p: proc (self: ptr Display00; isError: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cf)

proc scOpened*(self: Display;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "opened", cast[GCallback](p), xdata, nil, cf)

proc scSeatAdded*(self: Display;  p: proc (self: ptr Display00; seat: ptr Seat00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "seat-added", cast[GCallback](p), xdata, nil, cf)

proc scSeatRemoved*(self: Display;  p: proc (self: ptr Display00; seat: ptr Seat00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "seat-removed", cast[GCallback](p), xdata, nil, cf)

proc scSettingChanged*(self: Display;  p: proc (self: ptr Display00; setting: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "setting-changed", cast[GCallback](p), xdata, nil, cf)

proc gdk_display_get_default(): ptr Display00 {.
    importc, libprag.}

proc getDefaultDisplay*(): Display =
  let gobj = gdk_display_get_default()
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

proc gdk_display_open(displayName: cstring): ptr Display00 {.
    importc, libprag.}

proc open*(displayName: cstring = nil): Display =
  let gobj = gdk_display_open(displayName)
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

proc gdk_display_beep(self: ptr Display00) {.
    importc, libprag.}

proc beep*(self: Display) =
  gdk_display_beep(cast[ptr Display00](self.impl))

proc gdk_display_close(self: ptr Display00) {.
    importc, libprag.}

proc close*(self: Display) =
  gdk_display_close(cast[ptr Display00](self.impl))

proc gdk_display_device_is_grabbed(self: ptr Display00; device: ptr Device00): gboolean {.
    importc, libprag.}

proc deviceIsGrabbed*(self: Display; device: Device): bool =
  toBool(gdk_display_device_is_grabbed(cast[ptr Display00](self.impl), cast[ptr Device00](device.impl)))

proc gdk_display_flush(self: ptr Display00) {.
    importc, libprag.}

proc flush*(self: Display) =
  gdk_display_flush(cast[ptr Display00](self.impl))

proc gdk_display_get_app_launch_context(self: ptr Display00): ptr AppLaunchContext00 {.
    importc, libprag.}

proc getAppLaunchContext*(self: Display): AppLaunchContext =
  let gobj = gdk_display_get_app_launch_context(cast[ptr Display00](self.impl))
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

proc appLaunchContext*(self: Display): AppLaunchContext =
  let gobj = gdk_display_get_app_launch_context(cast[ptr Display00](self.impl))
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

proc gdk_display_get_default_seat(self: ptr Display00): ptr Seat00 {.
    importc, libprag.}

proc getDefaultSeat*(self: Display): Seat =
  let gobj = gdk_display_get_default_seat(cast[ptr Display00](self.impl))
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

proc defaultSeat*(self: Display): Seat =
  let gobj = gdk_display_get_default_seat(cast[ptr Display00](self.impl))
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

proc gdk_display_get_monitors(self: ptr Display00): ptr gio.ListModel00 {.
    importc, libprag.}

proc getMonitors*(self: Display): gio.ListModel =
  let gobj = gdk_display_get_monitors(cast[ptr Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc monitors*(self: Display): gio.ListModel =
  let gobj = gdk_display_get_monitors(cast[ptr Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_get_name(self: ptr Display00): cstring {.
    importc, libprag.}

proc getName*(self: Display): string =
  result = $gdk_display_get_name(cast[ptr Display00](self.impl))

proc name*(self: Display): string =
  result = $gdk_display_get_name(cast[ptr Display00](self.impl))

proc gdk_display_get_setting(self: ptr Display00; name: cstring; value: gobject.Value): gboolean {.
    importc, libprag.}

proc getSetting*(self: Display; name: cstring; value: gobject.Value): bool =
  toBool(gdk_display_get_setting(cast[ptr Display00](self.impl), name, value))

proc gdk_display_get_startup_notification_id(self: ptr Display00): cstring {.
    importc, libprag.}

proc getStartupNotificationId*(self: Display): string =
  let resul0 = gdk_display_get_startup_notification_id(cast[ptr Display00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc startupNotificationId*(self: Display): string =
  let resul0 = gdk_display_get_startup_notification_id(cast[ptr Display00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_display_is_closed(self: ptr Display00): gboolean {.
    importc, libprag.}

proc isClosed*(self: Display): bool =
  toBool(gdk_display_is_closed(cast[ptr Display00](self.impl)))

proc gdk_display_is_composited(self: ptr Display00): gboolean {.
    importc, libprag.}

proc isComposited*(self: Display): bool =
  toBool(gdk_display_is_composited(cast[ptr Display00](self.impl)))

proc gdk_display_is_rgba(self: ptr Display00): gboolean {.
    importc, libprag.}

proc isRgba*(self: Display): bool =
  toBool(gdk_display_is_rgba(cast[ptr Display00](self.impl)))

proc gdk_display_list_seats(self: ptr Display00): ptr glib.List {.
    importc, libprag.}

proc listSeats*(self: Display): seq[Seat] =
  let resul0 = gdk_display_list_seats(cast[ptr Display00](self.impl))
  result = glistObjects2seq(Seat, resul0, false)
  g_list_free(resul0)

proc gdk_display_notify_startup_complete(self: ptr Display00; startupId: cstring) {.
    importc, libprag.}

proc notifyStartupComplete*(self: Display; startupId: cstring) =
  gdk_display_notify_startup_complete(cast[ptr Display00](self.impl), startupId)

proc gdk_display_prepare_gl(self: ptr Display00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc prepareGl*(self: Display): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_display_prepare_gl(cast[ptr Display00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_display_supports_input_shapes(self: ptr Display00): gboolean {.
    importc, libprag.}

proc supportsInputShapes*(self: Display): bool =
  toBool(gdk_display_supports_input_shapes(cast[ptr Display00](self.impl)))

proc gdk_display_supports_shadow_width(self: ptr Display00): gboolean {.
    importc, libprag.}

proc supportsShadowWidth*(self: Display): bool =
  toBool(gdk_display_supports_shadow_width(cast[ptr Display00](self.impl)))

proc gdk_display_sync(self: ptr Display00) {.
    importc, libprag.}

proc sync*(self: Display) =
  gdk_display_sync(cast[ptr Display00](self.impl))

proc gdk_app_launch_context_get_display(self: ptr AppLaunchContext00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: AppLaunchContext): Display =
  let gobj = gdk_app_launch_context_get_display(cast[ptr AppLaunchContext00](self.impl))
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

proc display*(self: AppLaunchContext): Display =
  let gobj = gdk_app_launch_context_get_display(cast[ptr AppLaunchContext00](self.impl))
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

proc gdk_device_get_display(self: ptr Device00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Device): Display =
  let gobj = gdk_device_get_display(cast[ptr Device00](self.impl))
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

proc display*(self: Device): Display =
  let gobj = gdk_device_get_display(cast[ptr Device00](self.impl))
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

proc gdk_device_get_seat(self: ptr Device00): ptr Seat00 {.
    importc, libprag.}

proc getSeat*(self: Device): Seat =
  let gobj = gdk_device_get_seat(cast[ptr Device00](self.impl))
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

proc seat*(self: Device): Seat =
  let gobj = gdk_device_get_seat(cast[ptr Device00](self.impl))
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

proc gdk_seat_get_display(self: ptr Seat00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Seat): Display =
  let gobj = gdk_seat_get_display(cast[ptr Seat00](self.impl))
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

proc display*(self: Seat): Display =
  let gobj = gdk_seat_get_display(cast[ptr Seat00](self.impl))
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

type
  AxisFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    x = 1
    y = 2
    deltaX = 3
    deltaY = 4
    pressure = 5
    xtilt = 6
    ytilt = 7
    wheel = 8
    distance = 9
    rotation = 10
    slider = 11

  AxisFlags* = set[AxisFlag]

proc gdk_device_tool_get_axes(self: ptr DeviceTool00): AxisFlags {.
    importc, libprag.}

proc getAxes*(self: DeviceTool): AxisFlags =
  gdk_device_tool_get_axes(cast[ptr DeviceTool00](self.impl))

proc axes*(self: DeviceTool): AxisFlags =
  gdk_device_tool_get_axes(cast[ptr DeviceTool00](self.impl))

type
  DeviceToolType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    pen = 1
    eraser = 2
    brush = 3
    pencil = 4
    airbrush = 5
    mouse = 6
    lens = 7

proc gdk_device_tool_get_tool_type(self: ptr DeviceTool00): DeviceToolType {.
    importc, libprag.}

proc getToolType*(self: DeviceTool): DeviceToolType =
  gdk_device_tool_get_tool_type(cast[ptr DeviceTool00](self.impl))

proc toolType*(self: DeviceTool): DeviceToolType =
  gdk_device_tool_get_tool_type(cast[ptr DeviceTool00](self.impl))

type
  InputSource* {.size: sizeof(cint), pure.} = enum
    mouse = 0
    pen = 1
    keyboard = 2
    touchscreen = 3
    touchpad = 4
    trackpoint = 5
    tabletPad = 6

proc gdk_device_get_source(self: ptr Device00): InputSource {.
    importc, libprag.}

proc getSource*(self: Device): InputSource =
  gdk_device_get_source(cast[ptr Device00](self.impl))

proc source*(self: Device): InputSource =
  gdk_device_get_source(cast[ptr Device00](self.impl))

type
  SeatCapabilities* {.size: sizeof(cint), pure.} = enum
    none = 0
    pointer = 1
    touch = 2
    tabletStylus = 4
    allPointing = 7
    keyboard = 8
    tabletPad = 16
    all = 31

proc gdk_seat_get_capabilities(self: ptr Seat00): SeatCapabilities {.
    importc, libprag.}

proc getCapabilities*(self: Seat): SeatCapabilities =
  gdk_seat_get_capabilities(cast[ptr Seat00](self.impl))

proc capabilities*(self: Seat): SeatCapabilities =
  gdk_seat_get_capabilities(cast[ptr Seat00](self.impl))

proc gdk_seat_get_devices(self: ptr Seat00; capabilities: SeatCapabilities): ptr glib.List {.
    importc, libprag.}

proc getDevices*(self: Seat; capabilities: SeatCapabilities): seq[Device] =
  let resul0 = gdk_seat_get_devices(cast[ptr Seat00](self.impl), capabilities)
  result = glistObjects2seq(Device, resul0, false)
  g_list_free(resul0)

type
  DrawContext* = ref object of gobject.Object
  DrawContext00* = object of gobject.Object00

proc gdk_draw_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DrawContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_draw_context_begin_frame(self: ptr DrawContext00; region: ptr cairo.Region00) {.
    importc, libprag.}

proc beginFrame*(self: DrawContext; region: cairo.Region) =
  gdk_draw_context_begin_frame(cast[ptr DrawContext00](self.impl), cast[ptr cairo.Region00](region.impl))

proc gdk_draw_context_end_frame(self: ptr DrawContext00) {.
    importc, libprag.}

proc endFrame*(self: DrawContext) =
  gdk_draw_context_end_frame(cast[ptr DrawContext00](self.impl))

proc gdk_draw_context_get_display(self: ptr DrawContext00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: DrawContext): Display =
  let gobj = gdk_draw_context_get_display(cast[ptr DrawContext00](self.impl))
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

proc display*(self: DrawContext): Display =
  let gobj = gdk_draw_context_get_display(cast[ptr DrawContext00](self.impl))
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

proc gdk_draw_context_get_frame_region(self: ptr DrawContext00): ptr cairo.Region00 {.
    importc, libprag.}

proc getFrameRegion*(self: DrawContext): cairo.Region =
  let impl0 = gdk_draw_context_get_frame_region(cast[ptr DrawContext00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_region_get_type(), impl0))

proc frameRegion*(self: DrawContext): cairo.Region =
  let impl0 = gdk_draw_context_get_frame_region(cast[ptr DrawContext00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_region_get_type(), impl0))

proc gdk_draw_context_is_in_frame(self: ptr DrawContext00): gboolean {.
    importc, libprag.}

proc isInFrame*(self: DrawContext): bool =
  toBool(gdk_draw_context_is_in_frame(cast[ptr DrawContext00](self.impl)))

type
  GLContext* = ref object of DrawContext
  GLContext00* = object of DrawContext00

proc gdk_gl_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc clearCurrent*() {.
    importc: "gdk_gl_context_clear_current", libprag.}

proc gdk_gl_context_get_current(): ptr GLContext00 {.
    importc, libprag.}

proc getCurrentGLContext*(): GLContext =
  let gobj = gdk_gl_context_get_current()
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

proc gdk_gl_context_get_debug_enabled(self: ptr GLContext00): gboolean {.
    importc, libprag.}

proc getDebugEnabled*(self: GLContext): bool =
  toBool(gdk_gl_context_get_debug_enabled(cast[ptr GLContext00](self.impl)))

proc debugEnabled*(self: GLContext): bool =
  toBool(gdk_gl_context_get_debug_enabled(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_get_display(self: ptr GLContext00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: GLContext): Display =
  let gobj = gdk_gl_context_get_display(cast[ptr GLContext00](self.impl))
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

proc display*(self: GLContext): Display =
  let gobj = gdk_gl_context_get_display(cast[ptr GLContext00](self.impl))
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

proc gdk_gl_context_get_forward_compatible(self: ptr GLContext00): gboolean {.
    importc, libprag.}

proc getForwardCompatible*(self: GLContext): bool =
  toBool(gdk_gl_context_get_forward_compatible(cast[ptr GLContext00](self.impl)))

proc forwardCompatible*(self: GLContext): bool =
  toBool(gdk_gl_context_get_forward_compatible(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_get_required_version(self: ptr GLContext00; major: var int32;
    minor: var int32) {.
    importc, libprag.}

proc getRequiredVersion*(self: GLContext; major: var int;
    minor: var int) =
  var major_00: int32
  var minor_00: int32
  gdk_gl_context_get_required_version(cast[ptr GLContext00](self.impl), major_00, minor_00)
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)

proc gdk_gl_context_get_shared_context(self: ptr GLContext00): ptr GLContext00 {.
    importc, libprag.}

proc getSharedContext*(self: GLContext): GLContext =
  let gobj = gdk_gl_context_get_shared_context(cast[ptr GLContext00](self.impl))
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

proc sharedContext*(self: GLContext): GLContext =
  let gobj = gdk_gl_context_get_shared_context(cast[ptr GLContext00](self.impl))
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

proc gdk_gl_context_get_use_es(self: ptr GLContext00): gboolean {.
    importc, libprag.}

proc getUseEs*(self: GLContext): bool =
  toBool(gdk_gl_context_get_use_es(cast[ptr GLContext00](self.impl)))

proc useEs*(self: GLContext): bool =
  toBool(gdk_gl_context_get_use_es(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_get_version(self: ptr GLContext00; major: var int32;
    minor: var int32) {.
    importc, libprag.}

proc getVersion*(self: GLContext; major: var int; minor: var int) =
  var major_00: int32
  var minor_00: int32
  gdk_gl_context_get_version(cast[ptr GLContext00](self.impl), major_00, minor_00)
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)

proc gdk_gl_context_is_legacy(self: ptr GLContext00): gboolean {.
    importc, libprag.}

proc isLegacy*(self: GLContext): bool =
  toBool(gdk_gl_context_is_legacy(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_is_shared(self: ptr GLContext00; other: ptr GLContext00): gboolean {.
    importc, libprag.}

proc isShared*(self: GLContext; other: GLContext): bool =
  toBool(gdk_gl_context_is_shared(cast[ptr GLContext00](self.impl), cast[ptr GLContext00](other.impl)))

proc gdk_gl_context_make_current(self: ptr GLContext00) {.
    importc, libprag.}

proc makeCurrent*(self: GLContext) =
  gdk_gl_context_make_current(cast[ptr GLContext00](self.impl))

proc gdk_gl_context_realize(self: ptr GLContext00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc realize*(self: GLContext): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_gl_context_realize(cast[ptr GLContext00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_gl_context_set_debug_enabled(self: ptr GLContext00; enabled: gboolean) {.
    importc, libprag.}

proc setDebugEnabled*(self: GLContext; enabled: bool = true) =
  gdk_gl_context_set_debug_enabled(cast[ptr GLContext00](self.impl), gboolean(enabled))

proc `debugEnabled=`*(self: GLContext; enabled: bool) =
  gdk_gl_context_set_debug_enabled(cast[ptr GLContext00](self.impl), gboolean(enabled))

proc gdk_gl_context_set_forward_compatible(self: ptr GLContext00; compatible: gboolean) {.
    importc, libprag.}

proc setForwardCompatible*(self: GLContext; compatible: bool = true) =
  gdk_gl_context_set_forward_compatible(cast[ptr GLContext00](self.impl), gboolean(compatible))

proc `forwardCompatible=`*(self: GLContext; compatible: bool) =
  gdk_gl_context_set_forward_compatible(cast[ptr GLContext00](self.impl), gboolean(compatible))

proc gdk_gl_context_set_required_version(self: ptr GLContext00; major: int32;
    minor: int32) {.
    importc, libprag.}

proc setRequiredVersion*(self: GLContext; major: int; minor: int) =
  gdk_gl_context_set_required_version(cast[ptr GLContext00](self.impl), int32(major), int32(minor))

proc gdk_gl_context_set_use_es(self: ptr GLContext00; useEs: int32) {.
    importc, libprag.}

proc setUseEs*(self: GLContext; useEs: int) =
  gdk_gl_context_set_use_es(cast[ptr GLContext00](self.impl), int32(useEs))

proc `useEs=`*(self: GLContext; useEs: int) =
  gdk_gl_context_set_use_es(cast[ptr GLContext00](self.impl), int32(useEs))

proc gdk_display_create_gl_context(self: ptr Display00; error: ptr ptr glib.Error = nil): ptr GLContext00 {.
    importc, libprag.}

proc createGlContext*(self: Display): GLContext =
  var gerror: ptr glib.Error
  let gobj = gdk_display_create_gl_context(cast[ptr Display00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

type
  GLAPI* {.size: sizeof(cint), pure.} = enum
    gl = 1
    gles = 2

proc gdk_gl_context_get_allowed_apis(self: ptr GLContext00): GLAPI {.
    importc, libprag.}

proc getAllowedApis*(self: GLContext): GLAPI =
  gdk_gl_context_get_allowed_apis(cast[ptr GLContext00](self.impl))

proc allowedApis*(self: GLContext): GLAPI =
  gdk_gl_context_get_allowed_apis(cast[ptr GLContext00](self.impl))

proc gdk_gl_context_get_api(self: ptr GLContext00): GLAPI {.
    importc, libprag.}

proc getApi*(self: GLContext): GLAPI =
  gdk_gl_context_get_api(cast[ptr GLContext00](self.impl))

proc api*(self: GLContext): GLAPI =
  gdk_gl_context_get_api(cast[ptr GLContext00](self.impl))

proc gdk_gl_context_set_allowed_apis(self: ptr GLContext00; apis: GLAPI) {.
    importc, libprag.}

proc setAllowedApis*(self: GLContext; apis: GLAPI) =
  gdk_gl_context_set_allowed_apis(cast[ptr GLContext00](self.impl), apis)

proc `allowedApis=`*(self: GLContext; apis: GLAPI) =
  gdk_gl_context_set_allowed_apis(cast[ptr GLContext00](self.impl), apis)

type
  DmabufFormats00* {.pure.} = object
  DmabufFormats* = ref object
    impl*: ptr DmabufFormats00
    ignoreFinalizer*: bool

proc gdk_dmabuf_formats_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkDmabufFormats*(self: DmabufFormats) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_dmabuf_formats_get_type(), cast[ptr DmabufFormats00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DmabufFormats()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_dmabuf_formats_get_type(), cast[ptr DmabufFormats00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DmabufFormats) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkDmabufFormats)

proc gdk_dmabuf_formats_unref(self: ptr DmabufFormats00) {.
    importc, libprag.}

proc unref*(self: DmabufFormats) =
  gdk_dmabuf_formats_unref(cast[ptr DmabufFormats00](self.impl))

proc finalizerunref*(self: DmabufFormats) =
  if not self.ignoreFinalizer:
    gdk_dmabuf_formats_unref(cast[ptr DmabufFormats00](self.impl))

proc gdk_dmabuf_formats_equal(self: ptr DmabufFormats00; formats2: ptr DmabufFormats00): gboolean {.
    importc, libprag.}

proc equal*(self: DmabufFormats; formats2: DmabufFormats = nil): bool =
  toBool(gdk_dmabuf_formats_equal(cast[ptr DmabufFormats00](self.impl), if formats2.isNil: nil else: cast[ptr DmabufFormats00](formats2.impl)))

proc gdk_dmabuf_formats_get_format(self: ptr DmabufFormats00; idx: uint64;
    fourcc: var uint32; modifier: var uint64) {.
    importc, libprag.}

proc getFormat*(self: DmabufFormats; idx: uint64; fourcc: var int;
    modifier: var uint64) =
  var fourcc_00: uint32
  gdk_dmabuf_formats_get_format(cast[ptr DmabufFormats00](self.impl), idx, fourcc_00, modifier)
  if fourcc.addr != nil:
    fourcc = int(fourcc_00)

proc gdk_dmabuf_formats_get_n_formats(self: ptr DmabufFormats00): uint64 {.
    importc, libprag.}

proc getNFormats*(self: DmabufFormats): uint64 =
  gdk_dmabuf_formats_get_n_formats(cast[ptr DmabufFormats00](self.impl))

proc nFormats*(self: DmabufFormats): uint64 =
  gdk_dmabuf_formats_get_n_formats(cast[ptr DmabufFormats00](self.impl))

proc gdk_dmabuf_formats_ref(self: ptr DmabufFormats00): ptr DmabufFormats00 {.
    importc, libprag.}

proc `ref`*(self: DmabufFormats): DmabufFormats =
  fnew(result, gBoxedFreeGdkDmabufFormats)
  result.impl = gdk_dmabuf_formats_ref(cast[ptr DmabufFormats00](self.impl))

proc gdk_dmabuf_formats_contains(self: ptr DmabufFormats00; fourcc: uint32;
    modifier: uint64): gboolean {.
    importc, libprag.}

proc contains*(self: DmabufFormats; fourcc: int; modifier: uint64): bool =
  toBool(gdk_dmabuf_formats_contains(cast[ptr DmabufFormats00](self.impl), uint32(fourcc), modifier))

proc gdk_display_get_dmabuf_formats(self: ptr Display00): ptr DmabufFormats00 {.
    importc, libprag.}

proc getDmabufFormats*(self: Display): DmabufFormats =
  fnew(result, gBoxedFreeGdkDmabufFormats)
  result.impl = gdk_display_get_dmabuf_formats(cast[ptr Display00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_dmabuf_formats_get_type(), result.impl))

proc dmabufFormats*(self: Display): DmabufFormats =
  fnew(result, gBoxedFreeGdkDmabufFormats)
  result.impl = gdk_display_get_dmabuf_formats(cast[ptr Display00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_dmabuf_formats_get_type(), result.impl))

type
  Monitor* = ref object of gobject.Object
  Monitor00* = object of gobject.Object00

proc gdk_monitor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Monitor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scInvalidate*(self: Monitor;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "invalidate", cast[GCallback](p), xdata, nil, cf)

proc gdk_monitor_get_connector(self: ptr Monitor00): cstring {.
    importc, libprag.}

proc getConnector*(self: Monitor): string =
  let resul0 = gdk_monitor_get_connector(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc connector*(self: Monitor): string =
  let resul0 = gdk_monitor_get_connector(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_monitor_get_description(self: ptr Monitor00): cstring {.
    importc, libprag.}

proc getDescription*(self: Monitor): string =
  let resul0 = gdk_monitor_get_description(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc description*(self: Monitor): string =
  let resul0 = gdk_monitor_get_description(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_monitor_get_display(self: ptr Monitor00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Monitor): Display =
  let gobj = gdk_monitor_get_display(cast[ptr Monitor00](self.impl))
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

proc display*(self: Monitor): Display =
  let gobj = gdk_monitor_get_display(cast[ptr Monitor00](self.impl))
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

proc gdk_monitor_get_height_mm(self: ptr Monitor00): int32 {.
    importc, libprag.}

proc getHeightMm*(self: Monitor): int =
  int(gdk_monitor_get_height_mm(cast[ptr Monitor00](self.impl)))

proc heightMm*(self: Monitor): int =
  int(gdk_monitor_get_height_mm(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_get_manufacturer(self: ptr Monitor00): cstring {.
    importc, libprag.}

proc getManufacturer*(self: Monitor): string =
  let resul0 = gdk_monitor_get_manufacturer(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc manufacturer*(self: Monitor): string =
  let resul0 = gdk_monitor_get_manufacturer(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_monitor_get_model(self: ptr Monitor00): cstring {.
    importc, libprag.}

proc getModel*(self: Monitor): string =
  let resul0 = gdk_monitor_get_model(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc model*(self: Monitor): string =
  let resul0 = gdk_monitor_get_model(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_monitor_get_refresh_rate(self: ptr Monitor00): int32 {.
    importc, libprag.}

proc getRefreshRate*(self: Monitor): int =
  int(gdk_monitor_get_refresh_rate(cast[ptr Monitor00](self.impl)))

proc refreshRate*(self: Monitor): int =
  int(gdk_monitor_get_refresh_rate(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_get_scale(self: ptr Monitor00): cdouble {.
    importc, libprag.}

proc getScale*(self: Monitor): cdouble =
  gdk_monitor_get_scale(cast[ptr Monitor00](self.impl))

proc scale*(self: Monitor): cdouble =
  gdk_monitor_get_scale(cast[ptr Monitor00](self.impl))

proc gdk_monitor_get_scale_factor(self: ptr Monitor00): int32 {.
    importc, libprag.}

proc getScaleFactor*(self: Monitor): int =
  int(gdk_monitor_get_scale_factor(cast[ptr Monitor00](self.impl)))

proc scaleFactor*(self: Monitor): int =
  int(gdk_monitor_get_scale_factor(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_get_width_mm(self: ptr Monitor00): int32 {.
    importc, libprag.}

proc getWidthMm*(self: Monitor): int =
  int(gdk_monitor_get_width_mm(cast[ptr Monitor00](self.impl)))

proc widthMm*(self: Monitor): int =
  int(gdk_monitor_get_width_mm(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_is_valid(self: ptr Monitor00): gboolean {.
    importc, libprag.}

proc isValid*(self: Monitor): bool =
  toBool(gdk_monitor_is_valid(cast[ptr Monitor00](self.impl)))

type
  Rectangle* {.pure, byRef.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32

proc gdk_rectangle_get_type*(): GType {.importc, libprag.}

proc gdk_rectangle_contains_point(self: Rectangle; x: int32; y: int32): gboolean {.
    importc, libprag.}

proc containsPoint*(self: Rectangle; x: int; y: int): bool =
  toBool(gdk_rectangle_contains_point(self, int32(x), int32(y)))

proc gdk_rectangle_equal(self: Rectangle; rect2: Rectangle): gboolean {.
    importc, libprag.}

proc equal*(self: Rectangle; rect2: Rectangle): bool =
  toBool(gdk_rectangle_equal(self, rect2))

proc gdk_rectangle_intersect(self: Rectangle; src2: Rectangle; dest: var Rectangle): gboolean {.
    importc, libprag.}

proc intersect*(self: Rectangle; src2: Rectangle; dest: var Rectangle = cast[var Rectangle](nil)): bool =
  toBool(gdk_rectangle_intersect(self, src2, dest))

proc gdk_rectangle_union(self: Rectangle; src2: Rectangle; dest: var Rectangle) {.
    importc, libprag.}

proc union*(self: Rectangle; src2: Rectangle; dest: var Rectangle) =
  gdk_rectangle_union(self, src2, dest)

proc gdk_monitor_get_geometry(self: ptr Monitor00; geometry: var Rectangle) {.
    importc, libprag.}

proc getGeometry*(self: Monitor; geometry: var Rectangle) =
  gdk_monitor_get_geometry(cast[ptr Monitor00](self.impl), geometry)

proc getGeometry*(self: Monitor): Rectangle =
  gdk_monitor_get_geometry(cast[ptr Monitor00](self.impl), result)

type
  SubpixelLayout* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    none = 1
    horizontalRgb = 2
    horizontalBgr = 3
    verticalRgb = 4
    verticalBgr = 5

proc gdk_monitor_get_subpixel_layout(self: ptr Monitor00): SubpixelLayout {.
    importc, libprag.}

proc getSubpixelLayout*(self: Monitor): SubpixelLayout =
  gdk_monitor_get_subpixel_layout(cast[ptr Monitor00](self.impl))

proc subpixelLayout*(self: Monitor): SubpixelLayout =
  gdk_monitor_get_subpixel_layout(cast[ptr Monitor00](self.impl))

type
  Clipboard* = ref object of gobject.Object
  Clipboard00* = object of gobject.Object00

proc gdk_clipboard_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Clipboard()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChanged*(self: Clipboard;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc gdk_clipboard_get_display(self: ptr Clipboard00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Clipboard): Display =
  let gobj = gdk_clipboard_get_display(cast[ptr Clipboard00](self.impl))
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

proc display*(self: Clipboard): Display =
  let gobj = gdk_clipboard_get_display(cast[ptr Clipboard00](self.impl))
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

proc gdk_clipboard_is_local(self: ptr Clipboard00): gboolean {.
    importc, libprag.}

proc isLocal*(self: Clipboard): bool =
  toBool(gdk_clipboard_is_local(cast[ptr Clipboard00](self.impl)))

proc gdk_clipboard_read_async(self: ptr Clipboard00; mimeTypes: ptr cstring;
    ioPriority: int32; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc readAsync*(self: Clipboard; mimeTypes: openArray[string];
    ioPriority: int; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gdk_clipboard_read_async(cast[ptr Clipboard00](self.impl), seq2CstringArray(mimeTypes, fs469n23), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_clipboard_read_finish(self: ptr Clipboard00; resu: ptr gio.AsyncResult00;
    outMimeType: var cstring; error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc readFinish*(self: Clipboard; resu: gio.AsyncResult; outMimeType: var string = cast[var string](nil)): gio.InputStream =
  var gerror: ptr glib.Error
  var outMimeType_00: cstring
  let gobj = gdk_clipboard_read_finish(cast[ptr Clipboard00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), outMimeType_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  if outMimeType.addr != nil:
    outMimeType = $(outMimeType_00)

proc gdk_clipboard_read_text_async(self: ptr Clipboard00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc readTextAsync*(self: Clipboard; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  gdk_clipboard_read_text_async(cast[ptr Clipboard00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_clipboard_read_text_finish(self: ptr Clipboard00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc readTextFinish*(self: Clipboard; resu: gio.AsyncResult): string =
  var gerror: ptr glib.Error
  let resul0 = gdk_clipboard_read_text_finish(cast[ptr Clipboard00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gdk_clipboard_read_texture_async(self: ptr Clipboard00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc readTextureAsync*(self: Clipboard; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  gdk_clipboard_read_texture_async(cast[ptr Clipboard00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_clipboard_read_value_async(self: ptr Clipboard00; `type`: GType;
    ioPriority: int32; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc readValueAsync*(self: Clipboard; `type`: GType; ioPriority: int;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  gdk_clipboard_read_value_async(cast[ptr Clipboard00](self.impl), `type`, int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_clipboard_read_value_finish(self: ptr Clipboard00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr gobject.Value {.
    importc, libprag.}

proc readValueFinish*(self: Clipboard; resu: gio.AsyncResult): ptr gobject.Value =
  var gerror: ptr glib.Error
  let resul0 = gdk_clipboard_read_value_finish(cast[ptr Clipboard00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc gdk_clipboard_set_value(self: ptr Clipboard00; value: gobject.Value) {.
    importc, libprag.}

proc set*(self: Clipboard; value: gobject.Value) =
  gdk_clipboard_set_value(cast[ptr Clipboard00](self.impl), value)

proc gdk_clipboard_store_async(self: ptr Clipboard00; ioPriority: int32;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc storeAsync*(self: Clipboard; ioPriority: int; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  gdk_clipboard_store_async(cast[ptr Clipboard00](self.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_clipboard_store_finish(self: ptr Clipboard00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc storeFinish*(self: Clipboard; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_clipboard_store_finish(cast[ptr Clipboard00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_display_get_clipboard(self: ptr Display00): ptr Clipboard00 {.
    importc, libprag.}

proc getClipboard*(self: Display): Clipboard =
  let gobj = gdk_display_get_clipboard(cast[ptr Display00](self.impl))
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

proc clipboard*(self: Display): Clipboard =
  let gobj = gdk_display_get_clipboard(cast[ptr Display00](self.impl))
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

proc gdk_display_get_primary_clipboard(self: ptr Display00): ptr Clipboard00 {.
    importc, libprag.}

proc getPrimaryClipboard*(self: Display): Clipboard =
  let gobj = gdk_display_get_primary_clipboard(cast[ptr Display00](self.impl))
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

proc primaryClipboard*(self: Display): Clipboard =
  let gobj = gdk_display_get_primary_clipboard(cast[ptr Display00](self.impl))
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

type
  ContentFormats00* {.pure.} = object
  ContentFormats* = ref object
    impl*: ptr ContentFormats00
    ignoreFinalizer*: bool

proc gdk_content_formats_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkContentFormats*(self: ContentFormats) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_content_formats_get_type(), cast[ptr ContentFormats00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContentFormats()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_content_formats_get_type(), cast[ptr ContentFormats00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ContentFormats) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkContentFormats)

proc gdk_content_formats_unref(self: ptr ContentFormats00) {.
    importc, libprag.}

proc unref*(self: ContentFormats) =
  gdk_content_formats_unref(cast[ptr ContentFormats00](self.impl))

proc finalizerunref*(self: ContentFormats) =
  if not self.ignoreFinalizer:
    gdk_content_formats_unref(cast[ptr ContentFormats00](self.impl))

proc gdk_content_formats_new_for_gtype(`type`: GType): ptr ContentFormats00 {.
    importc, libprag.}

proc newContentFormatsForGtype*(`type`: GType): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_new_for_gtype(`type`)

proc newContentFormatsForGtype*(tdesc: typedesc; `type`: GType): tdesc =
  assert(result is ContentFormats)
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_new_for_gtype(`type`)

proc initContentFormatsForGtype*[T](result: var T; `type`: GType) {.deprecated.} =
  assert(result is ContentFormats)
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_new_for_gtype(`type`)

proc gdk_content_formats_contain_gtype(self: ptr ContentFormats00; `type`: GType): gboolean {.
    importc, libprag.}

proc containGtype*(self: ContentFormats; `type`: GType): bool =
  toBool(gdk_content_formats_contain_gtype(cast[ptr ContentFormats00](self.impl), `type`))

proc gdk_content_formats_contain_mime_type(self: ptr ContentFormats00; mimeType: cstring): gboolean {.
    importc, libprag.}

proc containMimeType*(self: ContentFormats; mimeType: cstring): bool =
  toBool(gdk_content_formats_contain_mime_type(cast[ptr ContentFormats00](self.impl), mimeType))

proc gdk_content_formats_get_gtypes(self: ptr ContentFormats00; nGtypes: var uint64): ptr GType {.
    importc, libprag.}

proc getGtypes*(self: ContentFormats; nGtypes: var uint64 = cast[var uint64](nil)): ptr GType =
  gdk_content_formats_get_gtypes(cast[ptr ContentFormats00](self.impl), nGtypes)

proc gdk_content_formats_get_mime_types(self: ptr ContentFormats00; nMimeTypes: var uint64): ptr cstring {.
    importc, libprag.}

proc getMimeTypes*(self: ContentFormats; nMimeTypes: var uint64 = cast[var uint64](nil)): seq[string] =
  let resul0 = gdk_content_formats_get_mime_types(cast[ptr ContentFormats00](self.impl), nMimeTypes)
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc gdk_content_formats_match(self: ptr ContentFormats00; second: ptr ContentFormats00): gboolean {.
    importc, libprag.}

proc match*(self: ContentFormats; second: ContentFormats): bool =
  toBool(gdk_content_formats_match(cast[ptr ContentFormats00](self.impl), cast[ptr ContentFormats00](second.impl)))

proc gdk_content_formats_match_gtype(self: ptr ContentFormats00; second: ptr ContentFormats00): GType {.
    importc, libprag.}

proc matchGtype*(self: ContentFormats; second: ContentFormats): GType =
  gdk_content_formats_match_gtype(cast[ptr ContentFormats00](self.impl), cast[ptr ContentFormats00](second.impl))

proc gdk_content_formats_match_mime_type(self: ptr ContentFormats00; second: ptr ContentFormats00): cstring {.
    importc, libprag.}

proc matchMimeType*(self: ContentFormats; second: ContentFormats): string =
  let resul0 = gdk_content_formats_match_mime_type(cast[ptr ContentFormats00](self.impl), cast[ptr ContentFormats00](second.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_content_formats_print(self: ptr ContentFormats00; string: glib.String) {.
    importc, libprag.}

proc print*(self: ContentFormats; string: glib.String) =
  gdk_content_formats_print(cast[ptr ContentFormats00](self.impl), string)

proc gdk_content_formats_ref(self: ptr ContentFormats00): ptr ContentFormats00 {.
    importc, libprag.}

proc `ref`*(self: ContentFormats): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_ref(cast[ptr ContentFormats00](self.impl))

proc gdk_content_formats_to_string(self: ptr ContentFormats00): cstring {.
    importc, libprag.}

proc toString*(self: ContentFormats): string =
  let resul0 = gdk_content_formats_to_string(cast[ptr ContentFormats00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_content_formats_union(self: ptr ContentFormats00; second: ptr ContentFormats00): ptr ContentFormats00 {.
    importc, libprag.}

proc union*(self: ContentFormats; second: ContentFormats): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_union(cast[ptr ContentFormats00](g_boxed_copy(gdk_content_formats_get_type(), self.impl)), cast[ptr ContentFormats00](second.impl))

proc gdk_content_formats_union_deserialize_gtypes(self: ptr ContentFormats00): ptr ContentFormats00 {.
    importc, libprag.}

proc unionDeserializeGtypes*(self: ContentFormats): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_union_deserialize_gtypes(cast[ptr ContentFormats00](g_boxed_copy(gdk_content_formats_get_type(), self.impl)))

proc gdk_content_formats_union_deserialize_mime_types(self: ptr ContentFormats00): ptr ContentFormats00 {.
    importc, libprag.}

proc unionDeserializeMimeTypes*(self: ContentFormats): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_union_deserialize_mime_types(cast[ptr ContentFormats00](g_boxed_copy(gdk_content_formats_get_type(), self.impl)))

proc gdk_content_formats_union_serialize_gtypes(self: ptr ContentFormats00): ptr ContentFormats00 {.
    importc, libprag.}

proc unionSerializeGtypes*(self: ContentFormats): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_union_serialize_gtypes(cast[ptr ContentFormats00](g_boxed_copy(gdk_content_formats_get_type(), self.impl)))

proc gdk_content_formats_union_serialize_mime_types(self: ptr ContentFormats00): ptr ContentFormats00 {.
    importc, libprag.}

proc unionSerializeMimeTypes*(self: ContentFormats): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_union_serialize_mime_types(cast[ptr ContentFormats00](g_boxed_copy(gdk_content_formats_get_type(), self.impl)))

proc gdk_content_formats_new(mimeTypes: ptr cstring; nMimeTypes: uint32): ptr ContentFormats00 {.
    importc, libprag.}

proc newContentFormats*(mimeTypes: openArray[string]; nMimeTypes: int): ContentFormats =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_new(seq2CstringArray(mimeTypes, fs469n23), uint32(nMimeTypes))

proc newContentFormats*(tdesc: typedesc; mimeTypes: openArray[string]; nMimeTypes: int): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is ContentFormats)
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_new(seq2CstringArray(mimeTypes, fs469n23), uint32(nMimeTypes))

proc initContentFormats*[T](result: var T; mimeTypes: openArray[string]; nMimeTypes: int) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is ContentFormats)
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_new(seq2CstringArray(mimeTypes, fs469n23), uint32(nMimeTypes))

proc gdk_content_formats_parse(string: cstring): ptr ContentFormats00 {.
    importc, libprag.}

proc parse*(string: cstring): ContentFormats =
  let impl0 = gdk_content_formats_parse(string)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = impl0

proc gdk_clipboard_get_formats(self: ptr Clipboard00): ptr ContentFormats00 {.
    importc, libprag.}

proc getFormats*(self: Clipboard): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_clipboard_get_formats(cast[ptr Clipboard00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_content_formats_get_type(), result.impl))

proc formats*(self: Clipboard): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_clipboard_get_formats(cast[ptr Clipboard00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_content_formats_get_type(), result.impl))

type
  Texture* = ref object of gobject.Object
  Texture00* = object of gobject.Object00

proc gdk_texture_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Texture()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_texture_new_for_pixbuf(pixbuf: ptr gdkpixbuf.Pixbuf00): ptr Texture00 {.
    importc, libprag.}

proc newTextureForPixbuf*(pixbuf: gdkpixbuf.Pixbuf): Texture =
  let gobj = gdk_texture_new_for_pixbuf(cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))
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

proc newTextureForPixbuf*(tdesc: typedesc; pixbuf: gdkpixbuf.Pixbuf): tdesc =
  assert(result is Texture)
  let gobj = gdk_texture_new_for_pixbuf(cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))
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

proc initTextureForPixbuf*[T](result: var T; pixbuf: gdkpixbuf.Pixbuf) {.deprecated.} =
  assert(result is Texture)
  let gobj = gdk_texture_new_for_pixbuf(cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))
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

proc gdk_texture_new_from_bytes(bytes: ptr glib.Bytes00; error: ptr ptr glib.Error = nil): ptr Texture00 {.
    importc, libprag.}

proc newTextureFromBytes*(bytes: glib.Bytes): Texture =
  var gerror: ptr glib.Error
  let gobj = gdk_texture_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newTextureFromBytes*(tdesc: typedesc; bytes: glib.Bytes): tdesc =
  var gerror: ptr glib.Error
  assert(result is Texture)
  let gobj = gdk_texture_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initTextureFromBytes*[T](result: var T; bytes: glib.Bytes) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Texture)
  let gobj = gdk_texture_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_texture_new_from_file(file: ptr gio.GFile00; error: ptr ptr glib.Error = nil): ptr Texture00 {.
    importc, libprag.}

proc newTextureFromFile*(file: gio.GFile): Texture =
  var gerror: ptr glib.Error
  let gobj = gdk_texture_new_from_file(cast[ptr gio.GFile00](file.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newTextureFromFile*(tdesc: typedesc; file: gio.GFile): tdesc =
  var gerror: ptr glib.Error
  assert(result is Texture)
  let gobj = gdk_texture_new_from_file(cast[ptr gio.GFile00](file.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initTextureFromFile*[T](result: var T; file: gio.GFile) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Texture)
  let gobj = gdk_texture_new_from_file(cast[ptr gio.GFile00](file.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_texture_new_from_filename(path: cstring; error: ptr ptr glib.Error = nil): ptr Texture00 {.
    importc, libprag.}

proc newTextureFromFilename*(path: cstring): Texture =
  var gerror: ptr glib.Error
  let gobj = gdk_texture_new_from_filename(path, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newTextureFromFilename*(tdesc: typedesc; path: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is Texture)
  let gobj = gdk_texture_new_from_filename(path, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initTextureFromFilename*[T](result: var T; path: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Texture)
  let gobj = gdk_texture_new_from_filename(path, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_texture_new_from_resource(resourcePath: cstring): ptr Texture00 {.
    importc, libprag.}

proc newTextureFromResource*(resourcePath: cstring): Texture =
  let gobj = gdk_texture_new_from_resource(resourcePath)
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

proc newTextureFromResource*(tdesc: typedesc; resourcePath: cstring): tdesc =
  assert(result is Texture)
  let gobj = gdk_texture_new_from_resource(resourcePath)
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

proc initTextureFromResource*[T](result: var T; resourcePath: cstring) {.deprecated.} =
  assert(result is Texture)
  let gobj = gdk_texture_new_from_resource(resourcePath)
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

proc gdk_texture_download(self: ptr Texture00; data: ptr uint8; stride: uint64) {.
    importc, libprag.}

proc download*(self: Texture; data: seq[uint8] | string; stride: uint64) =
  gdk_texture_download(cast[ptr Texture00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), stride)

proc gdk_texture_get_height(self: ptr Texture00): int32 {.
    importc, libprag.}

proc getHeight*(self: Texture): int =
  int(gdk_texture_get_height(cast[ptr Texture00](self.impl)))

proc height*(self: Texture): int =
  int(gdk_texture_get_height(cast[ptr Texture00](self.impl)))

proc gdk_texture_get_width(self: ptr Texture00): int32 {.
    importc, libprag.}

proc getWidth*(self: Texture): int =
  int(gdk_texture_get_width(cast[ptr Texture00](self.impl)))

proc width*(self: Texture): int =
  int(gdk_texture_get_width(cast[ptr Texture00](self.impl)))

proc gdk_texture_save_to_png(self: ptr Texture00; filename: cstring): gboolean {.
    importc, libprag.}

proc saveToPng*(self: Texture; filename: cstring): bool =
  toBool(gdk_texture_save_to_png(cast[ptr Texture00](self.impl), filename))

proc gdk_texture_save_to_png_bytes(self: ptr Texture00): ptr glib.Bytes00 {.
    importc, libprag.}

proc saveToPngBytes*(self: Texture): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gdk_texture_save_to_png_bytes(cast[ptr Texture00](self.impl))

proc gdk_texture_save_to_tiff(self: ptr Texture00; filename: cstring): gboolean {.
    importc, libprag.}

proc saveToTiff*(self: Texture; filename: cstring): bool =
  toBool(gdk_texture_save_to_tiff(cast[ptr Texture00](self.impl), filename))

proc gdk_texture_save_to_tiff_bytes(self: ptr Texture00): ptr glib.Bytes00 {.
    importc, libprag.}

proc saveToTiffBytes*(self: Texture): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gdk_texture_save_to_tiff_bytes(cast[ptr Texture00](self.impl))

proc gdk_clipboard_read_texture_finish(self: ptr Clipboard00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr Texture00 {.
    importc, libprag.}

proc readTextureFinish*(self: Clipboard; resu: gio.AsyncResult): Texture =
  var gerror: ptr glib.Error
  let gobj = gdk_clipboard_read_texture_finish(cast[ptr Clipboard00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

type
  MemoryFormat* {.size: sizeof(cint), pure.} = enum
    b8g8r8a8Premultiplied = 0
    a8r8g8b8Premultiplied = 1
    r8g8b8a8Premultiplied = 2
    b8g8r8a8 = 3
    a8r8g8b8 = 4
    r8g8b8a8 = 5
    a8b8g8r8 = 6
    r8g8b8 = 7
    b8g8r8 = 8
    r16g16b16 = 9
    r16g16b16a16Premultiplied = 10
    r16g16b16a16 = 11
    r16g16b16Float = 12
    r16g16b16a16FloatPremultiplied = 13
    r16g16b16a16Float = 14
    r32g32b32Float = 15
    r32g32b32a32FloatPremultiplied = 16
    r32g32b32a32Float = 17
    g8a8Premultiplied = 18
    g8a8 = 19
    g8 = 20
    g16a16Premultiplied = 21
    g16a16 = 22
    g16 = 23
    a8 = 24
    a16 = 25
    a16Float = 26
    a32Float = 27
    a8b8g8r8Premultiplied = 28
    b8g8r8x8 = 29
    x8r8g8b8 = 30
    r8g8b8x8 = 31
    x8b8g8r8 = 32
    nFormats = 33

proc gdk_texture_get_format(self: ptr Texture00): MemoryFormat {.
    importc, libprag.}

proc getFormat*(self: Texture): MemoryFormat =
  gdk_texture_get_format(cast[ptr Texture00](self.impl))

proc format*(self: Texture): MemoryFormat =
  gdk_texture_get_format(cast[ptr Texture00](self.impl))

type
  ContentProvider* = ref object of gobject.Object
  ContentProvider00* = object of gobject.Object00

proc gdk_content_provider_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContentProvider()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scContentChanged*(self: ContentProvider;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "content-changed", cast[GCallback](p), xdata, nil, cf)

proc gdk_content_provider_new_for_bytes(mimeType: cstring; bytes: ptr glib.Bytes00): ptr ContentProvider00 {.
    importc, libprag.}

proc newContentProviderForBytes*(mimeType: cstring; bytes: glib.Bytes): ContentProvider =
  let gobj = gdk_content_provider_new_for_bytes(mimeType, cast[ptr glib.Bytes00](bytes.impl))
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

proc newContentProviderForBytes*(tdesc: typedesc; mimeType: cstring; bytes: glib.Bytes): tdesc =
  assert(result is ContentProvider)
  let gobj = gdk_content_provider_new_for_bytes(mimeType, cast[ptr glib.Bytes00](bytes.impl))
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

proc initContentProviderForBytes*[T](result: var T; mimeType: cstring; bytes: glib.Bytes) {.deprecated.} =
  assert(result is ContentProvider)
  let gobj = gdk_content_provider_new_for_bytes(mimeType, cast[ptr glib.Bytes00](bytes.impl))
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

proc gdk_content_provider_new_for_value(value: gobject.Value): ptr ContentProvider00 {.
    importc, libprag.}

proc newContentProviderForValue*(value: gobject.Value): ContentProvider =
  let gobj = gdk_content_provider_new_for_value(value)
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

proc newContentProviderForValue*(tdesc: typedesc; value: gobject.Value): tdesc =
  assert(result is ContentProvider)
  let gobj = gdk_content_provider_new_for_value(value)
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

proc initContentProviderForValue*[T](result: var T; value: gobject.Value) {.deprecated.} =
  assert(result is ContentProvider)
  let gobj = gdk_content_provider_new_for_value(value)
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

proc gdk_content_provider_new_union(providers: ptr ptr ContentProvider00;
    nProviders: uint64): ptr ContentProvider00 {.
    importc, libprag.}

proc newContentProviderUnion*(providers: ptr ptr ContentProvider00;
    nProviders: uint64): ContentProvider =
  let gobj = gdk_content_provider_new_union(providers, nProviders)
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

proc newContentProviderUnion*(tdesc: typedesc; providers: ptr ptr ContentProvider00;
    nProviders: uint64): tdesc =
  assert(result is ContentProvider)
  let gobj = gdk_content_provider_new_union(providers, nProviders)
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

proc initContentProviderUnion*[T](result: var T; providers: ptr ptr ContentProvider00;
    nProviders: uint64) {.deprecated.} =
  assert(result is ContentProvider)
  let gobj = gdk_content_provider_new_union(providers, nProviders)
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

proc gdk_content_provider_content_changed(self: ptr ContentProvider00) {.
    importc, libprag.}

proc contentChanged*(self: ContentProvider) =
  gdk_content_provider_content_changed(cast[ptr ContentProvider00](self.impl))

proc gdk_content_provider_get_value(self: ptr ContentProvider00; value: var gobject.Value;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getValue*(self: ContentProvider; value: var gobject.Value): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_content_provider_get_value(cast[ptr ContentProvider00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_content_provider_ref_formats(self: ptr ContentProvider00): ptr ContentFormats00 {.
    importc, libprag.}

proc refFormats*(self: ContentProvider): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_provider_ref_formats(cast[ptr ContentProvider00](self.impl))

proc gdk_content_provider_ref_storable_formats(self: ptr ContentProvider00): ptr ContentFormats00 {.
    importc, libprag.}

proc refStorableFormats*(self: ContentProvider): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_provider_ref_storable_formats(cast[ptr ContentProvider00](self.impl))

proc gdk_content_provider_write_mime_type_async(self: ptr ContentProvider00;
    mimeType: cstring; stream: ptr gio.OutputStream00; ioPriority: int32; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc writeMimeTypeAsync*(self: ContentProvider; mimeType: cstring;
    stream: gio.OutputStream; ioPriority: int; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  gdk_content_provider_write_mime_type_async(cast[ptr ContentProvider00](self.impl), mimeType, cast[ptr gio.OutputStream00](stream.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_content_provider_write_mime_type_finish(self: ptr ContentProvider00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc writeMimeTypeFinish*(self: ContentProvider; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_content_provider_write_mime_type_finish(cast[ptr ContentProvider00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_clipboard_get_content(self: ptr Clipboard00): ptr ContentProvider00 {.
    importc, libprag.}

proc getContent*(self: Clipboard): ContentProvider =
  let gobj = gdk_clipboard_get_content(cast[ptr Clipboard00](self.impl))
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

proc content*(self: Clipboard): ContentProvider =
  let gobj = gdk_clipboard_get_content(cast[ptr Clipboard00](self.impl))
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

proc gdk_clipboard_set_content(self: ptr Clipboard00; provider: ptr ContentProvider00): gboolean {.
    importc, libprag.}

proc setContent*(self: Clipboard; provider: ContentProvider = nil): bool =
  toBool(gdk_clipboard_set_content(cast[ptr Clipboard00](self.impl), if provider.isNil: nil else: cast[ptr ContentProvider00](provider.impl)))

type
  KeymapKey* {.pure, byRef.} = object
    keycode*: uint32
    group*: int32
    level*: int32

proc seq2KeymapKeyArray(s: openarray[KeymapKey]; a: var cstringArray):  ptr KeymapKey =
  assert s.high < 256
  let x = cast[ptr UncheckedArray[ptr KeymapKey]](a)
  for i in 0 .. s.high:
    x[i] = unsafeaddr(s[i])
  return cast[ptr KeymapKey](x)

proc keymapKeyArrayToSeq(s: ptr KeymapKey; n: int):  seq[KeymapKey] =
  let a = cast[ptr UncheckedArray[ptr KeymapKey]](s)
  for i in 0 ..< n:
    result.add(a[i][])
  cogfree(s)



proc gdk_display_map_keycode(self: ptr Display00; keycode: uint32; keys: var ptr KeymapKey;
    keyvals: var ptr uint32; nEntries: var int32): gboolean {.
    importc, libprag.}

proc mapKeycode*(self: Display; keycode: int; keys: var seq[KeymapKey] = cast[var seq[KeymapKey]](nil);
    keyvals: var seq[uint32] = cast[var seq[uint32]](nil); nEntries: var int): bool =
  var nEntries_00: int32
  var keyvals_00: ptr uint32
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var keys_00 = seq2KeymapKeyArray(keys, fs469n23)
  result = toBool(gdk_display_map_keycode(cast[ptr Display00](self.impl), uint32(keycode), keys_00, keyvals_00, nEntries_00))
  if nEntries.addr != nil:
    nEntries = int(nEntries_00)
  keyvals.setLen(nEntries)
  copyMem(unsafeaddr keyvals[0], keyvals_00, nEntries.int * sizeof(keyvals[0]))
  cogfree(keyvals_00)
  keys = keymapKeyArrayToSeq(keys_00, nEntries)

proc gdk_display_map_keyval(self: ptr Display00; keyval: uint32; keys: var ptr KeymapKey;
    nKeys: var int32): gboolean {.
    importc, libprag.}

proc mapKeyval*(self: Display; keyval: int; keys: var seq[KeymapKey];
    nKeys: var int): bool =
  var nKeys_00: int32
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var keys_00 = seq2KeymapKeyArray(keys, fs469n23)
  result = toBool(gdk_display_map_keyval(cast[ptr Display00](self.impl), uint32(keyval), keys_00, nKeys_00))
  if nKeys.addr != nil:
    nKeys = int(nKeys_00)
  keys = keymapKeyArrayToSeq(keys_00, nKeys)

type
  Event* = ref object of RootRef
    impl*: ptr Event00
    ignoreFinalizer*: bool
  Event00*{.inheritable, pure.} = object

proc gdk_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr Event00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: Event) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Event()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

proc gdk_events_get_angle(self: ptr Event00; event2: ptr Event00; angle: var cdouble): gboolean {.
    importc, libprag.}

proc getAngle*(self: Event; event2: Event; angle: var cdouble): bool =
  toBool(gdk_events_get_angle(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), angle))

proc gdk_events_get_center(self: ptr Event00; event2: ptr Event00; x: var cdouble;
    y: var cdouble): gboolean {.
    importc, libprag.}

proc getCenter*(self: Event; event2: Event; x: var cdouble; y: var cdouble): bool =
  toBool(gdk_events_get_center(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), x, y))

proc gdk_events_get_distance(self: ptr Event00; event2: ptr Event00; distance: var cdouble): gboolean {.
    importc, libprag.}

proc getDistance*(self: Event; event2: Event; distance: var cdouble): bool =
  toBool(gdk_events_get_distance(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), distance))

proc gdk_event_get_axes(self: ptr Event00; axes: var ptr cdouble; nAxes: var uint32): gboolean {.
    importc, libprag.}

proc getAxes*(self: Event; axes: var ptr cdouble; nAxes: var int): bool =
  var nAxes_00: uint32
  result = toBool(gdk_event_get_axes(cast[ptr Event00](self.impl), axes, nAxes_00))
  if nAxes.addr != nil:
    nAxes = int(nAxes_00)

proc gdk_event_get_device(self: ptr Event00): ptr Device00 {.
    importc, libprag.}

proc getDevice*(self: Event): Device =
  let gobj = gdk_event_get_device(cast[ptr Event00](self.impl))
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

proc device*(self: Event): Device =
  let gobj = gdk_event_get_device(cast[ptr Event00](self.impl))
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

proc gdk_event_get_device_tool(self: ptr Event00): ptr DeviceTool00 {.
    importc, libprag.}

proc getDeviceTool*(self: Event): DeviceTool =
  let gobj = gdk_event_get_device_tool(cast[ptr Event00](self.impl))
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

proc deviceTool*(self: Event): DeviceTool =
  let gobj = gdk_event_get_device_tool(cast[ptr Event00](self.impl))
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

proc gdk_event_get_display(self: ptr Event00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Event): Display =
  let gobj = gdk_event_get_display(cast[ptr Event00](self.impl))
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

proc display*(self: Event): Display =
  let gobj = gdk_event_get_display(cast[ptr Event00](self.impl))
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

proc gdk_event_get_pointer_emulated(self: ptr Event00): gboolean {.
    importc, libprag.}

proc getPointerEmulated*(self: Event): bool =
  toBool(gdk_event_get_pointer_emulated(cast[ptr Event00](self.impl)))

proc pointerEmulated*(self: Event): bool =
  toBool(gdk_event_get_pointer_emulated(cast[ptr Event00](self.impl)))

proc gdk_event_get_position(self: ptr Event00; x: var cdouble; y: var cdouble): gboolean {.
    importc, libprag.}

proc getPosition*(self: Event; x: var cdouble; y: var cdouble): bool =
  toBool(gdk_event_get_position(cast[ptr Event00](self.impl), x, y))

proc gdk_event_get_seat(self: ptr Event00): ptr Seat00 {.
    importc, libprag.}

proc getSeat*(self: Event): Seat =
  let gobj = gdk_event_get_seat(cast[ptr Event00](self.impl))
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

proc seat*(self: Event): Seat =
  let gobj = gdk_event_get_seat(cast[ptr Event00](self.impl))
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

proc gdk_event_get_time(self: ptr Event00): uint32 {.
    importc, libprag.}

proc getTime*(self: Event): int =
  int(gdk_event_get_time(cast[ptr Event00](self.impl)))

proc time*(self: Event): int =
  int(gdk_event_get_time(cast[ptr Event00](self.impl)))

proc gdk_event_ref*(self: ptr Event00): ptr Event00 {.
    importc, libprag.}

proc `ref`*(self: Event): Event =
  fnew(result, generic_gdk_event_unref)
  result.impl = gdk_event_ref(cast[ptr Event00](self.impl))

proc gdk_event_triggers_context_menu(self: ptr Event00): gboolean {.
    importc, libprag.}

proc triggersContextMenu*(self: Event): bool =
  toBool(gdk_event_triggers_context_menu(cast[ptr Event00](self.impl)))

type
  Surface* = ref object of gobject.Object
  Surface00* = object of gobject.Object00

proc gdk_surface_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Surface()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scEnterMonitor*(self: Surface;  p: proc (self: ptr Surface00; monitor: ptr Monitor00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "enter-monitor", cast[GCallback](p), xdata, nil, cf)

proc scEvent*(self: Surface;  p: proc (self: ptr Surface00; event: ptr ptr Event00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "event", cast[GCallback](p), xdata, nil, cf)

proc scLayout*(self: Surface;  p: proc (self: ptr Surface00; width: int32; height: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "layout", cast[GCallback](p), xdata, nil, cf)

proc scLeaveMonitor*(self: Surface;  p: proc (self: ptr Surface00; monitor: ptr Monitor00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "leave-monitor", cast[GCallback](p), xdata, nil, cf)

proc scRender*(self: Surface;  p: proc (self: ptr Surface00; region: ptr cairo.Region00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "render", cast[GCallback](p), xdata, nil, cf)

proc gdk_surface_new_popup(parent: ptr Surface00; autohide: gboolean): ptr Surface00 {.
    importc, libprag.}

proc newSurfacePopup*(parent: Surface; autohide: bool): Surface =
  let gobj = gdk_surface_new_popup(cast[ptr Surface00](parent.impl), gboolean(autohide))
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

proc newSurfacePopup*(tdesc: typedesc; parent: Surface; autohide: bool): tdesc =
  assert(result is Surface)
  let gobj = gdk_surface_new_popup(cast[ptr Surface00](parent.impl), gboolean(autohide))
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

proc initSurfacePopup*[T](result: var T; parent: Surface; autohide: bool) {.deprecated.} =
  assert(result is Surface)
  let gobj = gdk_surface_new_popup(cast[ptr Surface00](parent.impl), gboolean(autohide))
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

proc gdk_surface_new_toplevel(display: ptr Display00): ptr Surface00 {.
    importc, libprag.}

proc newSurfaceToplevel*(display: Display): Surface =
  let gobj = gdk_surface_new_toplevel(cast[ptr Display00](display.impl))
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

proc newSurfaceToplevel*(tdesc: typedesc; display: Display): tdesc =
  assert(result is Surface)
  let gobj = gdk_surface_new_toplevel(cast[ptr Display00](display.impl))
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

proc initSurfaceToplevel*[T](result: var T; display: Display) {.deprecated.} =
  assert(result is Surface)
  let gobj = gdk_surface_new_toplevel(cast[ptr Display00](display.impl))
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

proc gdk_surface_beep(self: ptr Surface00) {.
    importc, libprag.}

proc beep*(self: Surface) =
  gdk_surface_beep(cast[ptr Surface00](self.impl))

proc gdk_surface_create_gl_context(self: ptr Surface00; error: ptr ptr glib.Error = nil): ptr GLContext00 {.
    importc, libprag.}

proc createGlContext*(self: Surface): GLContext =
  var gerror: ptr glib.Error
  let gobj = gdk_surface_create_gl_context(cast[ptr Surface00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_surface_create_similar_surface(self: ptr Surface00; content: cairo.Content;
    width: int32; height: int32): ptr cairo.Surface00 {.
    importc, libprag.}

proc createSimilarSurface*(self: Surface; content: cairo.Content;
    width: int; height: int): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = gdk_surface_create_similar_surface(cast[ptr Surface00](self.impl), content, int32(width), int32(height))

proc gdk_surface_destroy(self: ptr Surface00) {.
    importc, libprag.}

proc destroy*(self: Surface) =
  gdk_surface_destroy(cast[ptr Surface00](self.impl))

proc gdk_surface_get_display(self: ptr Surface00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Surface): Display =
  let gobj = gdk_surface_get_display(cast[ptr Surface00](self.impl))
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

proc display*(self: Surface): Display =
  let gobj = gdk_surface_get_display(cast[ptr Surface00](self.impl))
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

proc gdk_surface_get_height(self: ptr Surface00): int32 {.
    importc, libprag.}

proc getHeight*(self: Surface): int =
  int(gdk_surface_get_height(cast[ptr Surface00](self.impl)))

proc height*(self: Surface): int =
  int(gdk_surface_get_height(cast[ptr Surface00](self.impl)))

proc gdk_surface_get_mapped(self: ptr Surface00): gboolean {.
    importc, libprag.}

proc getMapped*(self: Surface): bool =
  toBool(gdk_surface_get_mapped(cast[ptr Surface00](self.impl)))

proc mapped*(self: Surface): bool =
  toBool(gdk_surface_get_mapped(cast[ptr Surface00](self.impl)))

proc gdk_surface_get_scale(self: ptr Surface00): cdouble {.
    importc, libprag.}

proc getScale*(self: Surface): cdouble =
  gdk_surface_get_scale(cast[ptr Surface00](self.impl))

proc scale*(self: Surface): cdouble =
  gdk_surface_get_scale(cast[ptr Surface00](self.impl))

proc gdk_surface_get_scale_factor(self: ptr Surface00): int32 {.
    importc, libprag.}

proc getScaleFactor*(self: Surface): int =
  int(gdk_surface_get_scale_factor(cast[ptr Surface00](self.impl)))

proc scaleFactor*(self: Surface): int =
  int(gdk_surface_get_scale_factor(cast[ptr Surface00](self.impl)))

proc gdk_surface_get_width(self: ptr Surface00): int32 {.
    importc, libprag.}

proc getWidth*(self: Surface): int =
  int(gdk_surface_get_width(cast[ptr Surface00](self.impl)))

proc width*(self: Surface): int =
  int(gdk_surface_get_width(cast[ptr Surface00](self.impl)))

proc gdk_surface_hide(self: ptr Surface00) {.
    importc, libprag.}

proc hide*(self: Surface) =
  gdk_surface_hide(cast[ptr Surface00](self.impl))

proc gdk_surface_is_destroyed(self: ptr Surface00): gboolean {.
    importc, libprag.}

proc isDestroyed*(self: Surface): bool =
  toBool(gdk_surface_is_destroyed(cast[ptr Surface00](self.impl)))

proc gdk_surface_queue_render(self: ptr Surface00) {.
    importc, libprag.}

proc queueRender*(self: Surface) =
  gdk_surface_queue_render(cast[ptr Surface00](self.impl))

proc gdk_surface_request_layout(self: ptr Surface00) {.
    importc, libprag.}

proc requestLayout*(self: Surface) =
  gdk_surface_request_layout(cast[ptr Surface00](self.impl))

proc gdk_surface_set_input_region(self: ptr Surface00; region: ptr cairo.Region00) {.
    importc, libprag.}

proc setInputRegion*(self: Surface; region: cairo.Region) =
  gdk_surface_set_input_region(cast[ptr Surface00](self.impl), cast[ptr cairo.Region00](region.impl))

proc `inputRegion=`*(self: Surface; region: cairo.Region) =
  gdk_surface_set_input_region(cast[ptr Surface00](self.impl), cast[ptr cairo.Region00](region.impl))

proc gdk_surface_set_opaque_region(self: ptr Surface00; region: ptr cairo.Region00) {.
    importc, libprag.}

proc setOpaqueRegion*(self: Surface; region: cairo.Region = nil) =
  gdk_surface_set_opaque_region(cast[ptr Surface00](self.impl), if region.isNil: nil else: cast[ptr cairo.Region00](region.impl))

proc `opaqueRegion=`*(self: Surface; region: cairo.Region = nil) =
  gdk_surface_set_opaque_region(cast[ptr Surface00](self.impl), if region.isNil: nil else: cast[ptr cairo.Region00](region.impl))

proc gdk_surface_translate_coordinates(self: ptr Surface00; to: ptr Surface00;
    x: var cdouble; y: var cdouble): gboolean {.
    importc, libprag.}

proc translateCoordinates*(self: Surface; to: Surface; x: var cdouble;
    y: var cdouble): bool =
  toBool(gdk_surface_translate_coordinates(cast[ptr Surface00](self.impl), cast[ptr Surface00](to.impl), x, y))

proc gdk_device_get_surface_at_position(self: ptr Device00; winX: var cdouble;
    winY: var cdouble): ptr Surface00 {.
    importc, libprag.}

proc getSurfaceAtPosition*(self: Device; winX: var cdouble = cast[var cdouble](nil);
    winY: var cdouble = cast[var cdouble](nil)): Surface =
  let gobj = gdk_device_get_surface_at_position(cast[ptr Device00](self.impl), winX, winY)
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

proc gdk_display_get_monitor_at_surface(self: ptr Display00; surface: ptr Surface00): ptr Monitor00 {.
    importc, libprag.}

proc getMonitorAtSurface*(self: Display; surface: Surface): Monitor =
  let gobj = gdk_display_get_monitor_at_surface(cast[ptr Display00](self.impl), cast[ptr Surface00](surface.impl))
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

proc gdk_display_put_event(self: ptr Display00; event: ptr Event00) {.
    importc, libprag.}

proc putEvent*(self: Display; event: Event) =
  gdk_display_put_event(cast[ptr Display00](self.impl), cast[ptr Event00](event.impl))

proc gdk_draw_context_get_surface(self: ptr DrawContext00): ptr Surface00 {.
    importc, libprag.}

proc getSurface*(self: DrawContext): Surface =
  let gobj = gdk_draw_context_get_surface(cast[ptr DrawContext00](self.impl))
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

proc surface*(self: DrawContext): Surface =
  let gobj = gdk_draw_context_get_surface(cast[ptr DrawContext00](self.impl))
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

proc gdk_gl_context_get_surface(self: ptr GLContext00): ptr Surface00 {.
    importc, libprag.}

proc getSurface*(self: GLContext): Surface =
  let gobj = gdk_gl_context_get_surface(cast[ptr GLContext00](self.impl))
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

proc surface*(self: GLContext): Surface =
  let gobj = gdk_gl_context_get_surface(cast[ptr GLContext00](self.impl))
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

proc gdk_event_get_surface(self: ptr Event00): ptr Surface00 {.
    importc, libprag.}

proc getSurface*(self: Event): Surface =
  let gobj = gdk_event_get_surface(cast[ptr Event00](self.impl))
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

proc surface*(self: Event): Surface =
  let gobj = gdk_event_get_surface(cast[ptr Event00](self.impl))
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

type
  AxisUse* {.size: sizeof(cint), pure.} = enum
    ignore = 0
    x = 1
    y = 2
    deltaX = 3
    deltaY = 4
    pressure = 5
    xtilt = 6
    ytilt = 7
    wheel = 8
    distance = 9
    rotation = 10
    slider = 11
    last = 12

proc gdk_event_get_axis(self: ptr Event00; axisUse: AxisUse; value: var cdouble): gboolean {.
    importc, libprag.}

proc getAxis*(self: Event; axisUse: AxisUse; value: var cdouble): bool =
  toBool(gdk_event_get_axis(cast[ptr Event00](self.impl), axisUse, value))

type
  EventSequence00* {.pure.} = object
  EventSequence* = ref object
    impl*: ptr EventSequence00
    ignoreFinalizer*: bool

proc gdk_event_sequence_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkEventSequence*(self: EventSequence) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_event_sequence_get_type(), cast[ptr EventSequence00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EventSequence()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_event_sequence_get_type(), cast[ptr EventSequence00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var EventSequence) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkEventSequence)

proc gdk_event_get_event_sequence(self: ptr Event00): ptr EventSequence00 {.
    importc, libprag.}

proc getEventSequence*(self: Event): EventSequence =
  fnew(result, gBoxedFreeGdkEventSequence)
  result.impl = gdk_event_get_event_sequence(cast[ptr Event00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_event_sequence_get_type(), result.impl))

proc eventSequence*(self: Event): EventSequence =
  fnew(result, gBoxedFreeGdkEventSequence)
  result.impl = gdk_event_get_event_sequence(cast[ptr Event00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_event_sequence_get_type(), result.impl))

type
  EventType* {.size: sizeof(cint), pure.} = enum
    delete = 0
    motionNotify = 1
    buttonPress = 2
    buttonRelease = 3
    keyPress = 4
    keyRelease = 5
    enterNotify = 6
    leaveNotify = 7
    focusChange = 8
    proximityIn = 9
    proximityOut = 10
    dragEnter = 11
    dragLeave = 12
    dragMotion = 13
    dropStart = 14
    scroll = 15
    grabBroken = 16
    touchBegin = 17
    touchUpdate = 18
    touchEnd = 19
    touchCancel = 20
    touchpadSwipe = 21
    touchpadPinch = 22
    padButtonPress = 23
    padButtonRelease = 24
    padRing = 25
    padStrip = 26
    padGroupMode = 27
    touchpadHold = 28
    eventLast = 29

proc gdk_event_get_event_type(self: ptr Event00): EventType {.
    importc, libprag.}

proc getEventType*(self: Event): EventType =
  gdk_event_get_event_type(cast[ptr Event00](self.impl))

proc eventType*(self: Event): EventType =
  gdk_event_get_event_type(cast[ptr Event00](self.impl))

type
  TimeCoord* {.pure, byRef.} = object
    time*: uint32
    flags*: AxisFlags
    axes*: array[12, cdouble]

proc gdk_event_get_history(self: ptr Event00; outNCoords: var uint32): ptr TimeCoord {.
    importc, libprag.}

proc getHistory*(self: Event; outNCoords: var int): ptr TimeCoord =
  var outNCoords_00: uint32
  let resul0 = gdk_event_get_history(cast[ptr Event00](self.impl), outNCoords_00)
  if resul0.isNil:
    return
  result = resul0
  if outNCoords.addr != nil:
    outNCoords = int(outNCoords_00)

type
  CairoContext* = ref object of DrawContext
  CairoContext00* = object of DrawContext00

proc gdk_cairo_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CairoContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_cairo_context_cairo_create(self: ptr CairoContext00): ptr cairo.Context00 {.
    importc, libprag.}

proc cairoCreate*(self: CairoContext): cairo.Context =
  let impl0 = gdk_cairo_context_cairo_create(cast[ptr CairoContext00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoContext)
  result.impl = impl0

proc gdk_surface_create_cairo_context(self: ptr Surface00): ptr CairoContext00 {.
    importc, libprag.}

proc createCairoContext*(self: Surface): CairoContext =
  let gobj = gdk_surface_create_cairo_context(cast[ptr Surface00](self.impl))
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

type
  VulkanContext* = ref object of DrawContext
  VulkanContext00* = object of DrawContext00

proc gdk_vulkan_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VulkanContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scImagesUpdated*(self: VulkanContext;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "images-updated", cast[GCallback](p), xdata, nil, cf)

proc gdk_surface_create_vulkan_context(self: ptr Surface00; error: ptr ptr glib.Error = nil): ptr VulkanContext00 {.
    importc, libprag.}

proc createVulkanContext*(self: Surface): VulkanContext =
  var gerror: ptr glib.Error
  let gobj = gdk_surface_create_vulkan_context(cast[ptr Surface00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

type
  FrameClock* = ref object of gobject.Object
  FrameClock00* = object of gobject.Object00

proc gdk_frame_clock_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FrameClock()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAfterPaint*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "after-paint", cast[GCallback](p), xdata, nil, cf)

proc scBeforePaint*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "before-paint", cast[GCallback](p), xdata, nil, cf)

proc scFlushEvents*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "flush-events", cast[GCallback](p), xdata, nil, cf)

proc scLayout*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "layout", cast[GCallback](p), xdata, nil, cf)

proc scPaint*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "paint", cast[GCallback](p), xdata, nil, cf)

proc scResumeEvents*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "resume-events", cast[GCallback](p), xdata, nil, cf)

proc scUpdate*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "update", cast[GCallback](p), xdata, nil, cf)

proc gdk_frame_clock_begin_updating(self: ptr FrameClock00) {.
    importc, libprag.}

proc beginUpdating*(self: FrameClock) =
  gdk_frame_clock_begin_updating(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_end_updating(self: ptr FrameClock00) {.
    importc, libprag.}

proc endUpdating*(self: FrameClock) =
  gdk_frame_clock_end_updating(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_fps(self: ptr FrameClock00): cdouble {.
    importc, libprag.}

proc getFps*(self: FrameClock): cdouble =
  gdk_frame_clock_get_fps(cast[ptr FrameClock00](self.impl))

proc fps*(self: FrameClock): cdouble =
  gdk_frame_clock_get_fps(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_frame_counter(self: ptr FrameClock00): int64 {.
    importc, libprag.}

proc getFrameCounter*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_counter(cast[ptr FrameClock00](self.impl))

proc frameCounter*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_counter(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_frame_time(self: ptr FrameClock00): int64 {.
    importc, libprag.}

proc getFrameTime*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_time(cast[ptr FrameClock00](self.impl))

proc frameTime*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_time(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_history_start(self: ptr FrameClock00): int64 {.
    importc, libprag.}

proc getHistoryStart*(self: FrameClock): int64 =
  gdk_frame_clock_get_history_start(cast[ptr FrameClock00](self.impl))

proc historyStart*(self: FrameClock): int64 =
  gdk_frame_clock_get_history_start(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_refresh_info(self: ptr FrameClock00; baseTime: int64;
    refreshIntervalReturn: var int64; presentationTimeReturn: var int64) {.
    importc, libprag.}

proc getRefreshInfo*(self: FrameClock; baseTime: int64;
    refreshIntervalReturn: var int64 = cast[var int64](nil); presentationTimeReturn: var int64) =
  gdk_frame_clock_get_refresh_info(cast[ptr FrameClock00](self.impl), baseTime, refreshIntervalReturn, presentationTimeReturn)

proc gdk_surface_get_frame_clock(self: ptr Surface00): ptr FrameClock00 {.
    importc, libprag.}

proc getFrameClock*(self: Surface): FrameClock =
  let gobj = gdk_surface_get_frame_clock(cast[ptr Surface00](self.impl))
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

proc frameClock*(self: Surface): FrameClock =
  let gobj = gdk_surface_get_frame_clock(cast[ptr Surface00](self.impl))
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

type
  FrameTimings00* {.pure.} = object
  FrameTimings* = ref object
    impl*: ptr FrameTimings00
    ignoreFinalizer*: bool

proc gdk_frame_timings_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkFrameTimings*(self: FrameTimings) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_frame_timings_get_type(), cast[ptr FrameTimings00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FrameTimings()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_frame_timings_get_type(), cast[ptr FrameTimings00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var FrameTimings) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkFrameTimings)

proc gdk_frame_timings_unref(self: ptr FrameTimings00) {.
    importc, libprag.}

proc unref*(self: FrameTimings) =
  gdk_frame_timings_unref(cast[ptr FrameTimings00](self.impl))

proc finalizerunref*(self: FrameTimings) =
  if not self.ignoreFinalizer:
    gdk_frame_timings_unref(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_frame_counter(self: ptr FrameTimings00): int64 {.
    importc, libprag.}

proc getFrameCounter*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_counter(cast[ptr FrameTimings00](self.impl))

proc frameCounter*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_counter(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_frame_time(self: ptr FrameTimings00): int64 {.
    importc, libprag.}

proc getFrameTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_time(cast[ptr FrameTimings00](self.impl))

proc frameTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_time(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_predicted_presentation_time(self: ptr FrameTimings00): int64 {.
    importc, libprag.}

proc getPredictedPresentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_predicted_presentation_time(cast[ptr FrameTimings00](self.impl))

proc predictedPresentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_predicted_presentation_time(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_presentation_time(self: ptr FrameTimings00): int64 {.
    importc, libprag.}

proc getPresentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_presentation_time(cast[ptr FrameTimings00](self.impl))

proc presentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_presentation_time(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_refresh_interval(self: ptr FrameTimings00): int64 {.
    importc, libprag.}

proc getRefreshInterval*(self: FrameTimings): int64 =
  gdk_frame_timings_get_refresh_interval(cast[ptr FrameTimings00](self.impl))

proc refreshInterval*(self: FrameTimings): int64 =
  gdk_frame_timings_get_refresh_interval(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_ref(self: ptr FrameTimings00): ptr FrameTimings00 {.
    importc, libprag.}

proc `ref`*(self: FrameTimings): FrameTimings =
  fnew(result, gBoxedFreeGdkFrameTimings)
  result.impl = gdk_frame_timings_ref(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_complete(self: ptr FrameTimings00): gboolean {.
    importc, libprag.}

proc getComplete*(self: FrameTimings): bool =
  toBool(gdk_frame_timings_get_complete(cast[ptr FrameTimings00](self.impl)))

proc complete*(self: FrameTimings): bool =
  toBool(gdk_frame_timings_get_complete(cast[ptr FrameTimings00](self.impl)))

proc gdk_frame_clock_get_current_timings(self: ptr FrameClock00): ptr FrameTimings00 {.
    importc, libprag.}

proc getCurrentTimings*(self: FrameClock): FrameTimings =
  let impl0 = gdk_frame_clock_get_current_timings(cast[ptr FrameClock00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkFrameTimings)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_frame_timings_get_type(), impl0))

proc currentTimings*(self: FrameClock): FrameTimings =
  let impl0 = gdk_frame_clock_get_current_timings(cast[ptr FrameClock00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkFrameTimings)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_frame_timings_get_type(), impl0))

proc gdk_frame_clock_get_timings(self: ptr FrameClock00; frameCounter: int64): ptr FrameTimings00 {.
    importc, libprag.}

proc getTimings*(self: FrameClock; frameCounter: int64): FrameTimings =
  let impl0 = gdk_frame_clock_get_timings(cast[ptr FrameClock00](self.impl), frameCounter)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkFrameTimings)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_frame_timings_get_type(), impl0))

type
  FrameClockPhaseFlag* {.size: sizeof(cint), pure.} = enum
    flushEvents = 0
    beforePaint = 1
    update = 2
    layout = 3
    paint = 4
    resumeEvents = 5
    afterPaint = 6

  FrameClockPhase* = set[FrameClockPhaseFlag]

const
  FrameClockPhaseNone* = FrameClockPhase({})
proc none*(t: typedesc[FrameClockPhase]): FrameClockPhase = FrameClockPhase({})

proc gdk_frame_clock_request_phase(self: ptr FrameClock00; phase: FrameClockPhase) {.
    importc, libprag.}

proc requestPhase*(self: FrameClock; phase: FrameClockPhase) =
  gdk_frame_clock_request_phase(cast[ptr FrameClock00](self.impl), phase)

type
  Cursor* = ref object of gobject.Object
  Cursor00* = object of gobject.Object00

proc gdk_cursor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Cursor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_cursor_new_from_name(name: cstring; fallback: ptr Cursor00): ptr Cursor00 {.
    importc, libprag.}

proc newCursorFromName*(name: cstring; fallback: Cursor = nil): Cursor =
  let gobj = gdk_cursor_new_from_name(name, if fallback.isNil: nil else: cast[ptr Cursor00](fallback.impl))
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

proc newCursorFromName*(tdesc: typedesc; name: cstring; fallback: Cursor = nil): tdesc =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_from_name(name, if fallback.isNil: nil else: cast[ptr Cursor00](fallback.impl))
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

proc initCursorFromName*[T](result: var T; name: cstring; fallback: Cursor = nil) {.deprecated.} =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_from_name(name, if fallback.isNil: nil else: cast[ptr Cursor00](fallback.impl))
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

proc gdk_cursor_new_from_texture(texture: ptr Texture00; hotspotX: int32;
    hotspotY: int32; fallback: ptr Cursor00): ptr Cursor00 {.
    importc, libprag.}

proc newCursorFromTexture*(texture: Texture; hotspotX: int; hotspotY: int;
    fallback: Cursor = nil): Cursor =
  let gobj = gdk_cursor_new_from_texture(cast[ptr Texture00](texture.impl), int32(hotspotX), int32(hotspotY), if fallback.isNil: nil else: cast[ptr Cursor00](fallback.impl))
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

proc newCursorFromTexture*(tdesc: typedesc; texture: Texture; hotspotX: int; hotspotY: int;
    fallback: Cursor = nil): tdesc =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_from_texture(cast[ptr Texture00](texture.impl), int32(hotspotX), int32(hotspotY), if fallback.isNil: nil else: cast[ptr Cursor00](fallback.impl))
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

proc initCursorFromTexture*[T](result: var T; texture: Texture; hotspotX: int; hotspotY: int;
    fallback: Cursor = nil) {.deprecated.} =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_from_texture(cast[ptr Texture00](texture.impl), int32(hotspotX), int32(hotspotY), if fallback.isNil: nil else: cast[ptr Cursor00](fallback.impl))
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

proc gdk_cursor_get_fallback(self: ptr Cursor00): ptr Cursor00 {.
    importc, libprag.}

proc getFallback*(self: Cursor): Cursor =
  let gobj = gdk_cursor_get_fallback(cast[ptr Cursor00](self.impl))
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

proc fallback*(self: Cursor): Cursor =
  let gobj = gdk_cursor_get_fallback(cast[ptr Cursor00](self.impl))
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

proc gdk_cursor_get_hotspot_x(self: ptr Cursor00): int32 {.
    importc, libprag.}

proc getHotspotX*(self: Cursor): int =
  int(gdk_cursor_get_hotspot_x(cast[ptr Cursor00](self.impl)))

proc hotspotX*(self: Cursor): int =
  int(gdk_cursor_get_hotspot_x(cast[ptr Cursor00](self.impl)))

proc gdk_cursor_get_hotspot_y(self: ptr Cursor00): int32 {.
    importc, libprag.}

proc getHotspotY*(self: Cursor): int =
  int(gdk_cursor_get_hotspot_y(cast[ptr Cursor00](self.impl)))

proc hotspotY*(self: Cursor): int =
  int(gdk_cursor_get_hotspot_y(cast[ptr Cursor00](self.impl)))

proc gdk_cursor_get_name(self: ptr Cursor00): cstring {.
    importc, libprag.}

proc getName*(self: Cursor): string =
  let resul0 = gdk_cursor_get_name(cast[ptr Cursor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc name*(self: Cursor): string =
  let resul0 = gdk_cursor_get_name(cast[ptr Cursor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_cursor_get_texture(self: ptr Cursor00): ptr Texture00 {.
    importc, libprag.}

proc getTexture*(self: Cursor): Texture =
  let gobj = gdk_cursor_get_texture(cast[ptr Cursor00](self.impl))
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

proc texture*(self: Cursor): Texture =
  let gobj = gdk_cursor_get_texture(cast[ptr Cursor00](self.impl))
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

proc gdk_surface_get_cursor(self: ptr Surface00): ptr Cursor00 {.
    importc, libprag.}

proc getCursor*(self: Surface): Cursor =
  let gobj = gdk_surface_get_cursor(cast[ptr Surface00](self.impl))
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

proc cursor*(self: Surface): Cursor =
  let gobj = gdk_surface_get_cursor(cast[ptr Surface00](self.impl))
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

proc gdk_surface_get_device_cursor(self: ptr Surface00; device: ptr Device00): ptr Cursor00 {.
    importc, libprag.}

proc getDeviceCursor*(self: Surface; device: Device): Cursor =
  let gobj = gdk_surface_get_device_cursor(cast[ptr Surface00](self.impl), cast[ptr Device00](device.impl))
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

proc gdk_surface_set_cursor(self: ptr Surface00; cursor: ptr Cursor00) {.
    importc, libprag.}

proc setCursor*(self: Surface; cursor: Cursor = nil) =
  gdk_surface_set_cursor(cast[ptr Surface00](self.impl), if cursor.isNil: nil else: cast[ptr Cursor00](cursor.impl))

proc `cursor=`*(self: Surface; cursor: Cursor = nil) =
  gdk_surface_set_cursor(cast[ptr Surface00](self.impl), if cursor.isNil: nil else: cast[ptr Cursor00](cursor.impl))

proc gdk_surface_set_device_cursor(self: ptr Surface00; device: ptr Device00;
    cursor: ptr Cursor00) {.
    importc, libprag.}

proc setDeviceCursor*(self: Surface; device: Device; cursor: Cursor) =
  gdk_surface_set_device_cursor(cast[ptr Surface00](self.impl), cast[ptr Device00](device.impl), cast[ptr Cursor00](cursor.impl))

type
  ModifierFlag* {.size: sizeof(cint), pure.} = enum
    shift = 0
    lock = 1
    control = 2
    alt = 3
    button1 = 8
    button2 = 9
    button3 = 10
    button4 = 11
    button5 = 12
    super = 26
    hyper = 27
    meta = 28

  ModifierType* = set[ModifierFlag]

const ModifierMask* = {ModifierFlag.shift .. ModifierFlag.button5, ModifierFlag.super .. ModifierFlag.meta}

proc gdk_device_get_modifier_state(self: ptr Device00): ModifierType {.
    importc, libprag.}

proc getModifierState*(self: Device): ModifierType =
  gdk_device_get_modifier_state(cast[ptr Device00](self.impl))

proc modifierState*(self: Device): ModifierType =
  gdk_device_get_modifier_state(cast[ptr Device00](self.impl))

proc gdk_display_translate_key(self: ptr Display00; keycode: uint32; state: ModifierType;
    group: int32; keyval: var uint32; effectiveGroup: var int32; level: var int32;
    consumed: var ModifierType): gboolean {.
    importc, libprag.}

proc translateKey*(self: Display; keycode: int; state: ModifierType;
    group: int; keyval: var int = cast[var int](nil); effectiveGroup: var int = cast[var int](nil);
    level: var int = cast[var int](nil); consumed: var ModifierType = cast[var ModifierType](nil)): bool =
  var effectiveGroup_00: int32
  var level_00: int32
  var keyval_00: uint32
  result = toBool(gdk_display_translate_key(cast[ptr Display00](self.impl), uint32(keycode), state, int32(group), keyval_00, effectiveGroup_00, level_00, consumed))
  if effectiveGroup.addr != nil:
    effectiveGroup = int(effectiveGroup_00)
  if level.addr != nil:
    level = int(level_00)
  if keyval.addr != nil:
    keyval = int(keyval_00)

proc gdk_event_get_modifier_state(self: ptr Event00): ModifierType {.
    importc, libprag.}

proc getModifierState*(self: Event): ModifierType =
  gdk_event_get_modifier_state(cast[ptr Event00](self.impl))

proc modifierState*(self: Event): ModifierType =
  gdk_event_get_modifier_state(cast[ptr Event00](self.impl))

proc gdk_surface_get_device_position(self: ptr Surface00; device: ptr Device00;
    x: var cdouble; y: var cdouble; mask: var ModifierType): gboolean {.
    importc, libprag.}

proc getDevicePosition*(self: Surface; device: Device; x: var cdouble = cast[var cdouble](nil);
    y: var cdouble = cast[var cdouble](nil); mask: var ModifierType = cast[var ModifierType](nil)): bool =
  toBool(gdk_surface_get_device_position(cast[ptr Surface00](self.impl), cast[ptr Device00](device.impl), x, y, mask))

const BUTTON_MIDDLE* = 2'i32

const BUTTON_PRIMARY* = 1'i32

const BUTTON_SECONDARY* = 3'i32

type
  ButtonEvent* = ref object of Event
  ButtonEvent00* = object of Event00

proc gdk_button_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr ButtonEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: ButtonEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ButtonEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

proc gdk_button_event_get_button(self: ptr ButtonEvent00): uint32 {.
    importc, libprag.}

proc getButton*(self: ButtonEvent): int =
  int(gdk_button_event_get_button(cast[ptr ButtonEvent00](self.impl)))

proc button*(self: ButtonEvent): int =
  int(gdk_button_event_get_button(cast[ptr ButtonEvent00](self.impl)))

const CURRENT_TIME* = 0'i32

type
  ContentDeserializer* = ref object of gobject.Object
  ContentDeserializer00* = object of gobject.Object00

proc gdk_content_deserializer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContentDeserializer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_content_deserializer_get_cancellable(self: ptr ContentDeserializer00): ptr gio.Cancellable00 {.
    importc, libprag.}

proc getCancellable*(self: ContentDeserializer): gio.Cancellable =
  let gobj = gdk_content_deserializer_get_cancellable(cast[ptr ContentDeserializer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc cancellable*(self: ContentDeserializer): gio.Cancellable =
  let gobj = gdk_content_deserializer_get_cancellable(cast[ptr ContentDeserializer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_content_deserializer_get_gtype(self: ptr ContentDeserializer00): GType {.
    importc, libprag.}

proc getGtype*(self: ContentDeserializer): GType =
  gdk_content_deserializer_get_gtype(cast[ptr ContentDeserializer00](self.impl))

proc gtype*(self: ContentDeserializer): GType =
  gdk_content_deserializer_get_gtype(cast[ptr ContentDeserializer00](self.impl))

proc gdk_content_deserializer_get_input_stream(self: ptr ContentDeserializer00): ptr gio.InputStream00 {.
    importc, libprag.}

proc getInputStream*(self: ContentDeserializer): gio.InputStream =
  let gobj = gdk_content_deserializer_get_input_stream(cast[ptr ContentDeserializer00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc inputStream*(self: ContentDeserializer): gio.InputStream =
  let gobj = gdk_content_deserializer_get_input_stream(cast[ptr ContentDeserializer00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_content_deserializer_get_mime_type(self: ptr ContentDeserializer00): cstring {.
    importc, libprag.}

proc getMimeType*(self: ContentDeserializer): string =
  result = $gdk_content_deserializer_get_mime_type(cast[ptr ContentDeserializer00](self.impl))

proc mimeType*(self: ContentDeserializer): string =
  result = $gdk_content_deserializer_get_mime_type(cast[ptr ContentDeserializer00](self.impl))

proc gdk_content_deserializer_get_priority(self: ptr ContentDeserializer00): int32 {.
    importc, libprag.}

proc getPriority*(self: ContentDeserializer): int =
  int(gdk_content_deserializer_get_priority(cast[ptr ContentDeserializer00](self.impl)))

proc priority*(self: ContentDeserializer): int =
  int(gdk_content_deserializer_get_priority(cast[ptr ContentDeserializer00](self.impl)))

proc gdk_content_deserializer_get_task_data(self: ptr ContentDeserializer00): pointer {.
    importc, libprag.}

proc getTaskData*(self: ContentDeserializer): pointer =
  gdk_content_deserializer_get_task_data(cast[ptr ContentDeserializer00](self.impl))

proc gdk_content_deserializer_get_user_data(self: ptr ContentDeserializer00): pointer {.
    importc, libprag.}

proc getUserData*(self: ContentDeserializer): pointer =
  gdk_content_deserializer_get_user_data(cast[ptr ContentDeserializer00](self.impl))

proc gdk_content_deserializer_get_value(self: ptr ContentDeserializer00): ptr gobject.Value {.
    importc, libprag.}

proc getValue*(self: ContentDeserializer): ptr gobject.Value =
  gdk_content_deserializer_get_value(cast[ptr ContentDeserializer00](self.impl))

proc value*(self: ContentDeserializer): ptr gobject.Value =
  gdk_content_deserializer_get_value(cast[ptr ContentDeserializer00](self.impl))

proc gdk_content_deserializer_return_error(self: ptr ContentDeserializer00;
    error: ptr glib.Error) {.
    importc, libprag.}

proc returnError*(self: ContentDeserializer; error: ptr glib.Error) =
  gdk_content_deserializer_return_error(cast[ptr ContentDeserializer00](self.impl), error)

proc gdk_content_deserializer_return_success(self: ptr ContentDeserializer00) {.
    importc, libprag.}

proc returnSuccess*(self: ContentDeserializer) =
  gdk_content_deserializer_return_success(cast[ptr ContentDeserializer00](self.impl))

proc gdk_content_deserializer_set_task_data(self: ptr ContentDeserializer00;
    data: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setTaskData*(self: ContentDeserializer; data: pointer;
    notify: DestroyNotify) =
  gdk_content_deserializer_set_task_data(cast[ptr ContentDeserializer00](self.impl), data, notify)

type
  ContentDeserializeFunc* = proc (deserializer: ptr ContentDeserializer00) {.cdecl.}

type
  ContentFormatsBuilder00* {.pure.} = object
  ContentFormatsBuilder* = ref object
    impl*: ptr ContentFormatsBuilder00
    ignoreFinalizer*: bool

proc gdk_content_formats_builder_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkContentFormatsBuilder*(self: ContentFormatsBuilder) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_content_formats_builder_get_type(), cast[ptr ContentFormatsBuilder00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContentFormatsBuilder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_content_formats_builder_get_type(), cast[ptr ContentFormatsBuilder00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ContentFormatsBuilder) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkContentFormatsBuilder)

proc gdk_content_formats_builder_unref(self: ptr ContentFormatsBuilder00) {.
    importc, libprag.}

proc unref*(self: ContentFormatsBuilder) =
  gdk_content_formats_builder_unref(cast[ptr ContentFormatsBuilder00](self.impl))

proc finalizerunref*(self: ContentFormatsBuilder) =
  if not self.ignoreFinalizer:
    gdk_content_formats_builder_unref(cast[ptr ContentFormatsBuilder00](self.impl))

proc gdk_content_formats_builder_add_formats(self: ptr ContentFormatsBuilder00;
    formats: ptr ContentFormats00) {.
    importc, libprag.}

proc addFormats*(self: ContentFormatsBuilder;
    formats: ContentFormats) =
  gdk_content_formats_builder_add_formats(cast[ptr ContentFormatsBuilder00](self.impl), cast[ptr ContentFormats00](formats.impl))

proc gdk_content_formats_builder_add_gtype(self: ptr ContentFormatsBuilder00;
    `type`: GType) {.
    importc, libprag.}

proc addGtype*(self: ContentFormatsBuilder; `type`: GType) =
  gdk_content_formats_builder_add_gtype(cast[ptr ContentFormatsBuilder00](self.impl), `type`)

proc gdk_content_formats_builder_add_mime_type(self: ptr ContentFormatsBuilder00;
    mimeType: cstring) {.
    importc, libprag.}

proc addMimeType*(self: ContentFormatsBuilder;
    mimeType: cstring) =
  gdk_content_formats_builder_add_mime_type(cast[ptr ContentFormatsBuilder00](self.impl), mimeType)

proc gdk_content_formats_builder_ref(self: ptr ContentFormatsBuilder00): ptr ContentFormatsBuilder00 {.
    importc, libprag.}

proc `ref`*(self: ContentFormatsBuilder): ContentFormatsBuilder =
  fnew(result, gBoxedFreeGdkContentFormatsBuilder)
  result.impl = gdk_content_formats_builder_ref(cast[ptr ContentFormatsBuilder00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_content_formats_builder_get_type(), result.impl))

proc gdk_content_formats_builder_to_formats(self: ptr ContentFormatsBuilder00): ptr ContentFormats00 {.
    importc, libprag.}

proc toFormats*(self: ContentFormatsBuilder): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_content_formats_builder_to_formats(cast[ptr ContentFormatsBuilder00](self.impl))

proc gdk_content_formats_builder_new(): ptr ContentFormatsBuilder00 {.
    importc, libprag.}

proc newContentFormatsBuilder*(): ContentFormatsBuilder =
  fnew(result, gBoxedFreeGdkContentFormatsBuilder)
  result.impl = gdk_content_formats_builder_new()

proc newContentFormatsBuilder*(tdesc: typedesc): tdesc =
  assert(result is ContentFormatsBuilder)
  fnew(result, gBoxedFreeGdkContentFormatsBuilder)
  result.impl = gdk_content_formats_builder_new()

proc initContentFormatsBuilder*[T](result: var T) {.deprecated.} =
  assert(result is ContentFormatsBuilder)
  fnew(result, gBoxedFreeGdkContentFormatsBuilder)
  result.impl = gdk_content_formats_builder_new()

type
  ContentSerializer* = ref object of gobject.Object
  ContentSerializer00* = object of gobject.Object00

proc gdk_content_serializer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContentSerializer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_content_serializer_get_cancellable(self: ptr ContentSerializer00): ptr gio.Cancellable00 {.
    importc, libprag.}

proc getCancellable*(self: ContentSerializer): gio.Cancellable =
  let gobj = gdk_content_serializer_get_cancellable(cast[ptr ContentSerializer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc cancellable*(self: ContentSerializer): gio.Cancellable =
  let gobj = gdk_content_serializer_get_cancellable(cast[ptr ContentSerializer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_content_serializer_get_gtype(self: ptr ContentSerializer00): GType {.
    importc, libprag.}

proc getGtype*(self: ContentSerializer): GType =
  gdk_content_serializer_get_gtype(cast[ptr ContentSerializer00](self.impl))

proc gtype*(self: ContentSerializer): GType =
  gdk_content_serializer_get_gtype(cast[ptr ContentSerializer00](self.impl))

proc gdk_content_serializer_get_mime_type(self: ptr ContentSerializer00): cstring {.
    importc, libprag.}

proc getMimeType*(self: ContentSerializer): string =
  result = $gdk_content_serializer_get_mime_type(cast[ptr ContentSerializer00](self.impl))

proc mimeType*(self: ContentSerializer): string =
  result = $gdk_content_serializer_get_mime_type(cast[ptr ContentSerializer00](self.impl))

proc gdk_content_serializer_get_output_stream(self: ptr ContentSerializer00): ptr gio.OutputStream00 {.
    importc, libprag.}

proc getOutputStream*(self: ContentSerializer): gio.OutputStream =
  let gobj = gdk_content_serializer_get_output_stream(cast[ptr ContentSerializer00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc outputStream*(self: ContentSerializer): gio.OutputStream =
  let gobj = gdk_content_serializer_get_output_stream(cast[ptr ContentSerializer00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_content_serializer_get_priority(self: ptr ContentSerializer00): int32 {.
    importc, libprag.}

proc getPriority*(self: ContentSerializer): int =
  int(gdk_content_serializer_get_priority(cast[ptr ContentSerializer00](self.impl)))

proc priority*(self: ContentSerializer): int =
  int(gdk_content_serializer_get_priority(cast[ptr ContentSerializer00](self.impl)))

proc gdk_content_serializer_get_task_data(self: ptr ContentSerializer00): pointer {.
    importc, libprag.}

proc getTaskData*(self: ContentSerializer): pointer =
  gdk_content_serializer_get_task_data(cast[ptr ContentSerializer00](self.impl))

proc gdk_content_serializer_get_user_data(self: ptr ContentSerializer00): pointer {.
    importc, libprag.}

proc getUserData*(self: ContentSerializer): pointer =
  gdk_content_serializer_get_user_data(cast[ptr ContentSerializer00](self.impl))

proc gdk_content_serializer_get_value(self: ptr ContentSerializer00): ptr gobject.Value {.
    importc, libprag.}

proc getValue*(self: ContentSerializer): ptr gobject.Value =
  gdk_content_serializer_get_value(cast[ptr ContentSerializer00](self.impl))

proc value*(self: ContentSerializer): ptr gobject.Value =
  gdk_content_serializer_get_value(cast[ptr ContentSerializer00](self.impl))

proc gdk_content_serializer_return_error(self: ptr ContentSerializer00; error: ptr glib.Error) {.
    importc, libprag.}

proc returnError*(self: ContentSerializer; error: ptr glib.Error) =
  gdk_content_serializer_return_error(cast[ptr ContentSerializer00](self.impl), error)

proc gdk_content_serializer_return_success(self: ptr ContentSerializer00) {.
    importc, libprag.}

proc returnSuccess*(self: ContentSerializer) =
  gdk_content_serializer_return_success(cast[ptr ContentSerializer00](self.impl))

proc gdk_content_serializer_set_task_data(self: ptr ContentSerializer00;
    data: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setTaskData*(self: ContentSerializer; data: pointer;
    notify: DestroyNotify) =
  gdk_content_serializer_set_task_data(cast[ptr ContentSerializer00](self.impl), data, notify)

type
  ContentSerializeFunc* = proc (serializer: ptr ContentSerializer00) {.cdecl.}

type
  CrossingEvent* = ref object of Event
  CrossingEvent00* = object of Event00

proc gdk_crossing_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr CrossingEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: CrossingEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CrossingEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

proc gdk_crossing_event_get_focus(self: ptr CrossingEvent00): gboolean {.
    importc, libprag.}

proc getFocus*(self: CrossingEvent): bool =
  toBool(gdk_crossing_event_get_focus(cast[ptr CrossingEvent00](self.impl)))

proc focus*(self: CrossingEvent): bool =
  toBool(gdk_crossing_event_get_focus(cast[ptr CrossingEvent00](self.impl)))

type
  NotifyType* {.size: sizeof(cint), pure.} = enum
    ancestor = 0
    virtual = 1
    inferior = 2
    nonlinear = 3
    nonlinearVirtual = 4
    unknown = 5

proc gdk_crossing_event_get_detail(self: ptr CrossingEvent00): NotifyType {.
    importc, libprag.}

proc getDetail*(self: CrossingEvent): NotifyType =
  gdk_crossing_event_get_detail(cast[ptr CrossingEvent00](self.impl))

proc detail*(self: CrossingEvent): NotifyType =
  gdk_crossing_event_get_detail(cast[ptr CrossingEvent00](self.impl))

type
  CrossingMode* {.size: sizeof(cint), pure.} = enum
    normal = 0
    grab = 1
    ungrab = 2
    gtkGrab = 3
    gtkUngrab = 4
    stateChanged = 5
    touchBegin = 6
    touchEnd = 7
    deviceSwitch = 8

proc gdk_crossing_event_get_mode(self: ptr CrossingEvent00): CrossingMode {.
    importc, libprag.}

proc getMode*(self: CrossingEvent): CrossingMode =
  gdk_crossing_event_get_mode(cast[ptr CrossingEvent00](self.impl))

proc mode*(self: CrossingEvent): CrossingMode =
  gdk_crossing_event_get_mode(cast[ptr CrossingEvent00](self.impl))

type
  DNDEvent* = ref object of Event
  DNDEvent00* = object of Event00

proc gdk_dnd_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr DNDEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: DNDEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DNDEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

type
  Drop* = ref object of gobject.Object
  Drop00* = object of gobject.Object00

proc gdk_drop_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Drop()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_drop_get_device(self: ptr Drop00): ptr Device00 {.
    importc, libprag.}

proc getDevice*(self: Drop): Device =
  let gobj = gdk_drop_get_device(cast[ptr Drop00](self.impl))
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

proc device*(self: Drop): Device =
  let gobj = gdk_drop_get_device(cast[ptr Drop00](self.impl))
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

proc gdk_drop_get_display(self: ptr Drop00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Drop): Display =
  let gobj = gdk_drop_get_display(cast[ptr Drop00](self.impl))
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

proc display*(self: Drop): Display =
  let gobj = gdk_drop_get_display(cast[ptr Drop00](self.impl))
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

proc gdk_drop_get_formats(self: ptr Drop00): ptr ContentFormats00 {.
    importc, libprag.}

proc getFormats*(self: Drop): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_drop_get_formats(cast[ptr Drop00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_content_formats_get_type(), result.impl))

proc formats*(self: Drop): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_drop_get_formats(cast[ptr Drop00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_content_formats_get_type(), result.impl))

proc gdk_drop_get_surface(self: ptr Drop00): ptr Surface00 {.
    importc, libprag.}

proc getSurface*(self: Drop): Surface =
  let gobj = gdk_drop_get_surface(cast[ptr Drop00](self.impl))
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

proc surface*(self: Drop): Surface =
  let gobj = gdk_drop_get_surface(cast[ptr Drop00](self.impl))
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

proc gdk_drop_read_async(self: ptr Drop00; mimeTypes: ptr cstring; ioPriority: int32;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc readAsync*(self: Drop; mimeTypes: openArray[string]; ioPriority: int;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gdk_drop_read_async(cast[ptr Drop00](self.impl), seq2CstringArray(mimeTypes, fs469n23), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_drop_read_finish(self: ptr Drop00; resu: ptr gio.AsyncResult00;
    outMimeType: var cstring; error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc readFinish*(self: Drop; resu: gio.AsyncResult; outMimeType: var string): gio.InputStream =
  var gerror: ptr glib.Error
  var outMimeType_00: cstring
  let gobj = gdk_drop_read_finish(cast[ptr Drop00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), outMimeType_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  if outMimeType.addr != nil:
    outMimeType = $(outMimeType_00)

proc gdk_drop_read_value_async(self: ptr Drop00; `type`: GType; ioPriority: int32;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc readValueAsync*(self: Drop; `type`: GType; ioPriority: int;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  gdk_drop_read_value_async(cast[ptr Drop00](self.impl), `type`, int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_drop_read_value_finish(self: ptr Drop00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr gobject.Value {.
    importc, libprag.}

proc readValueFinish*(self: Drop; resu: gio.AsyncResult): ptr gobject.Value =
  var gerror: ptr glib.Error
  let resul0 = gdk_drop_read_value_finish(cast[ptr Drop00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc gdk_dnd_event_get_drop(self: ptr DNDEvent00): ptr Drop00 {.
    importc, libprag.}

proc getDrop*(self: DNDEvent): Drop =
  let gobj = gdk_dnd_event_get_drop(cast[ptr DNDEvent00](self.impl))
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

proc drop*(self: DNDEvent): Drop =
  let gobj = gdk_dnd_event_get_drop(cast[ptr DNDEvent00](self.impl))
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

type
  DragCancelReason* {.size: sizeof(cint), pure.} = enum
    noTarget = 0
    userCancelled = 1
    error = 2

type
  Drag* = ref object of gobject.Object
  Drag00* = object of gobject.Object00

proc gdk_drag_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Drag()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCancel*(self: Drag;  p: proc (self: ptr Drag00; reason: DragCancelReason; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "cancel", cast[GCallback](p), xdata, nil, cf)

proc scDndFinished*(self: Drag;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "dnd-finished", cast[GCallback](p), xdata, nil, cf)

proc scDropPerformed*(self: Drag;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "drop-performed", cast[GCallback](p), xdata, nil, cf)

proc gdk_drag_drop_done(self: ptr Drag00; success: gboolean) {.
    importc, libprag.}

proc dropDone*(self: Drag; success: bool) =
  gdk_drag_drop_done(cast[ptr Drag00](self.impl), gboolean(success))

proc gdk_drag_get_content(self: ptr Drag00): ptr ContentProvider00 {.
    importc, libprag.}

proc getContent*(self: Drag): ContentProvider =
  let gobj = gdk_drag_get_content(cast[ptr Drag00](self.impl))
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

proc content*(self: Drag): ContentProvider =
  let gobj = gdk_drag_get_content(cast[ptr Drag00](self.impl))
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

proc gdk_drag_get_device(self: ptr Drag00): ptr Device00 {.
    importc, libprag.}

proc getDevice*(self: Drag): Device =
  let gobj = gdk_drag_get_device(cast[ptr Drag00](self.impl))
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

proc device*(self: Drag): Device =
  let gobj = gdk_drag_get_device(cast[ptr Drag00](self.impl))
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

proc gdk_drag_get_display(self: ptr Drag00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Drag): Display =
  let gobj = gdk_drag_get_display(cast[ptr Drag00](self.impl))
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

proc display*(self: Drag): Display =
  let gobj = gdk_drag_get_display(cast[ptr Drag00](self.impl))
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

proc gdk_drag_get_drag_surface(self: ptr Drag00): ptr Surface00 {.
    importc, libprag.}

proc getDragSurface*(self: Drag): Surface =
  let gobj = gdk_drag_get_drag_surface(cast[ptr Drag00](self.impl))
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

proc dragSurface*(self: Drag): Surface =
  let gobj = gdk_drag_get_drag_surface(cast[ptr Drag00](self.impl))
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

proc gdk_drag_get_formats(self: ptr Drag00): ptr ContentFormats00 {.
    importc, libprag.}

proc getFormats*(self: Drag): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_drag_get_formats(cast[ptr Drag00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_content_formats_get_type(), result.impl))

proc formats*(self: Drag): ContentFormats =
  fnew(result, gBoxedFreeGdkContentFormats)
  result.impl = gdk_drag_get_formats(cast[ptr Drag00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_content_formats_get_type(), result.impl))

proc gdk_drag_get_surface(self: ptr Drag00): ptr Surface00 {.
    importc, libprag.}

proc getSurface*(self: Drag): Surface =
  let gobj = gdk_drag_get_surface(cast[ptr Drag00](self.impl))
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

proc surface*(self: Drag): Surface =
  let gobj = gdk_drag_get_surface(cast[ptr Drag00](self.impl))
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

proc gdk_drag_set_hotspot(self: ptr Drag00; hotX: int32; hotY: int32) {.
    importc, libprag.}

proc setHotspot*(self: Drag; hotX: int; hotY: int) =
  gdk_drag_set_hotspot(cast[ptr Drag00](self.impl), int32(hotX), int32(hotY))

proc gdk_drop_get_drag(self: ptr Drop00): ptr Drag00 {.
    importc, libprag.}

proc getDrag*(self: Drop): Drag =
  let gobj = gdk_drop_get_drag(cast[ptr Drop00](self.impl))
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

proc drag*(self: Drop): Drag =
  let gobj = gdk_drop_get_drag(cast[ptr Drop00](self.impl))
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

type
  DragFlag* {.size: sizeof(cint), pure.} = enum
    copy = 0
    move = 1
    link = 2
    ask = 3

  DragAction* = set[DragFlag]

proc gdk_drag_action_is_unique(action: DragAction): gboolean {.
    importc, libprag.}

proc isUnique*(action: DragAction): bool =
  toBool(gdk_drag_action_is_unique(action))

proc gdk_drop_finish(self: ptr Drop00; action: DragAction) {.
    importc, libprag.}

proc finish*(self: Drop; action: DragAction) =
  gdk_drop_finish(cast[ptr Drop00](self.impl), action)

proc gdk_drop_get_actions(self: ptr Drop00): DragAction {.
    importc, libprag.}

proc getActions*(self: Drop): DragAction =
  gdk_drop_get_actions(cast[ptr Drop00](self.impl))

proc actions*(self: Drop): DragAction =
  gdk_drop_get_actions(cast[ptr Drop00](self.impl))

proc gdk_drop_status(self: ptr Drop00; actions: DragAction; preferred: DragAction) {.
    importc, libprag.}

proc status*(self: Drop; actions: DragAction; preferred: DragAction) =
  gdk_drop_status(cast[ptr Drop00](self.impl), actions, preferred)

proc gdk_drag_begin(surface: ptr Surface00; device: ptr Device00; content: ptr ContentProvider00;
    actions: DragAction; dx: cdouble; dy: cdouble): ptr Drag00 {.
    importc, libprag.}

proc begin*(surface: Surface; device: Device; content: ContentProvider;
    actions: DragAction; dx: cdouble; dy: cdouble): Drag =
  let gobj = gdk_drag_begin(cast[ptr Surface00](surface.impl), cast[ptr Device00](device.impl), cast[ptr ContentProvider00](content.impl), actions, dx, dy)
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

proc gdk_drag_get_actions(self: ptr Drag00): DragAction {.
    importc, libprag.}

proc getActions*(self: Drag): DragAction =
  gdk_drag_get_actions(cast[ptr Drag00](self.impl))

proc actions*(self: Drag): DragAction =
  gdk_drag_get_actions(cast[ptr Drag00](self.impl))

proc gdk_drag_get_selected_action(self: ptr Drag00): DragAction {.
    importc, libprag.}

proc getSelectedAction*(self: Drag): DragAction =
  gdk_drag_get_selected_action(cast[ptr Drag00](self.impl))

proc selectedAction*(self: Drag): DragAction =
  gdk_drag_get_selected_action(cast[ptr Drag00](self.impl))

type
  DeleteEvent* = ref object of Event
  DeleteEvent00* = object of Event00

proc gdk_delete_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr DeleteEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: DeleteEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DeleteEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

type
  DevicePad00* = object of gobject.Object00
  DevicePad* = ref object of gobject.Object

proc gdk_device_pad_get_group_n_modes(self: ptr DevicePad00; groupIdx: int32): int32 {.
    importc, libprag.}

proc getGroupNModes*(self: DevicePad; groupIdx: int): int =
  int(gdk_device_pad_get_group_n_modes(cast[ptr DevicePad00](self.impl), int32(groupIdx)))

proc gdk_device_pad_get_n_groups(self: ptr DevicePad00): int32 {.
    importc, libprag.}

proc getNGroups*(self: DevicePad): int =
  int(gdk_device_pad_get_n_groups(cast[ptr DevicePad00](self.impl)))

proc nGroups*(self: DevicePad): int =
  int(gdk_device_pad_get_n_groups(cast[ptr DevicePad00](self.impl)))

type
  DevicePadFeature* {.size: sizeof(cint), pure.} = enum
    button = 0
    ring = 1
    strip = 2

proc gdk_device_pad_get_feature_group(self: ptr DevicePad00; feature: DevicePadFeature;
    featureIdx: int32): int32 {.
    importc, libprag.}

proc getFeatureGroup*(self: DevicePad; feature: DevicePadFeature;
    featureIdx: int): int =
  int(gdk_device_pad_get_feature_group(cast[ptr DevicePad00](self.impl), feature, int32(featureIdx)))

proc gdk_device_pad_get_n_features(self: ptr DevicePad00; feature: DevicePadFeature): int32 {.
    importc, libprag.}

proc getNFeatures*(self: DevicePad; feature: DevicePadFeature): int =
  int(gdk_device_pad_get_n_features(cast[ptr DevicePad00](self.impl), feature))

type
  DisplayManager* = ref object of gobject.Object
  DisplayManager00* = object of gobject.Object00

proc gdk_display_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DisplayManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDisplayOpened*(self: DisplayManager;  p: proc (self: ptr DisplayManager00; display: ptr Display00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "display-opened", cast[GCallback](p), xdata, nil, cf)

proc gdk_display_manager_get(): ptr DisplayManager00 {.
    importc, libprag.}

proc getDisplayManager*(): DisplayManager =
  let gobj = gdk_display_manager_get()
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

proc gdk_display_manager_get_default_display(self: ptr DisplayManager00): ptr Display00 {.
    importc, libprag.}

proc getDefaultDisplay*(self: DisplayManager): Display =
  let gobj = gdk_display_manager_get_default_display(cast[ptr DisplayManager00](self.impl))
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

proc defaultDisplay*(self: DisplayManager): Display =
  let gobj = gdk_display_manager_get_default_display(cast[ptr DisplayManager00](self.impl))
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

proc gdk_display_manager_list_displays(self: ptr DisplayManager00): ptr glib.SList {.
    importc, libprag.}

proc listDisplays*(self: DisplayManager): seq[Display] =
  let resul0 = gdk_display_manager_list_displays(cast[ptr DisplayManager00](self.impl))
  result = gslistObjects2seq(Display, resul0, false)
  g_slist_free(resul0)

proc gdk_display_manager_open_display(self: ptr DisplayManager00; name: cstring): ptr Display00 {.
    importc, libprag.}

proc openDisplay*(self: DisplayManager; name: cstring = nil): Display =
  let gobj = gdk_display_manager_open_display(cast[ptr DisplayManager00](self.impl), name)
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

proc gdk_display_manager_set_default_display(self: ptr DisplayManager00;
    display: ptr Display00) {.
    importc, libprag.}

proc setDefaultDisplay*(self: DisplayManager; display: Display) =
  gdk_display_manager_set_default_display(cast[ptr DisplayManager00](self.impl), cast[ptr Display00](display.impl))

proc `defaultDisplay=`*(self: DisplayManager; display: Display) =
  gdk_display_manager_set_default_display(cast[ptr DisplayManager00](self.impl), cast[ptr Display00](display.impl))

type
  DmabufError* {.size: sizeof(cint), pure.} = enum
    notAvailable = 0
    unsupportedFormat = 1
    creationFailed = 2

type
  DmabufTexture* = ref object of Texture
  DmabufTexture00* = object of Texture00

proc gdk_dmabuf_texture_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DmabufTexture()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  DmabufTextureBuilder* = ref object of gobject.Object
  DmabufTextureBuilder00* = object of gobject.Object00

proc gdk_dmabuf_texture_builder_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DmabufTextureBuilder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_dmabuf_texture_builder_new(): ptr DmabufTextureBuilder00 {.
    importc, libprag.}

proc newDmabufTextureBuilder*(): DmabufTextureBuilder =
  let gobj = gdk_dmabuf_texture_builder_new()
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

proc newDmabufTextureBuilder*(tdesc: typedesc): tdesc =
  assert(result is DmabufTextureBuilder)
  let gobj = gdk_dmabuf_texture_builder_new()
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

proc initDmabufTextureBuilder*[T](result: var T) {.deprecated.} =
  assert(result is DmabufTextureBuilder)
  let gobj = gdk_dmabuf_texture_builder_new()
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

proc gdk_dmabuf_texture_builder_build(self: ptr DmabufTextureBuilder00; destroy: DestroyNotify;
    data: pointer; error: ptr ptr glib.Error = nil): ptr Texture00 {.
    importc, libprag.}

proc build*(self: DmabufTextureBuilder; destroy: DestroyNotify;
    data: pointer): Texture =
  var gerror: ptr glib.Error
  let gobj = gdk_dmabuf_texture_builder_build(cast[ptr DmabufTextureBuilder00](self.impl), destroy, data, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_dmabuf_texture_builder_get_display(self: ptr DmabufTextureBuilder00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: DmabufTextureBuilder): Display =
  let gobj = gdk_dmabuf_texture_builder_get_display(cast[ptr DmabufTextureBuilder00](self.impl))
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

proc display*(self: DmabufTextureBuilder): Display =
  let gobj = gdk_dmabuf_texture_builder_get_display(cast[ptr DmabufTextureBuilder00](self.impl))
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

proc gdk_dmabuf_texture_builder_get_fd(self: ptr DmabufTextureBuilder00;
    plane: uint32): int32 {.
    importc, libprag.}

proc getFd*(self: DmabufTextureBuilder; plane: int): int =
  int(gdk_dmabuf_texture_builder_get_fd(cast[ptr DmabufTextureBuilder00](self.impl), uint32(plane)))

proc gdk_dmabuf_texture_builder_get_fourcc(self: ptr DmabufTextureBuilder00): uint32 {.
    importc, libprag.}

proc getFourcc*(self: DmabufTextureBuilder): int =
  int(gdk_dmabuf_texture_builder_get_fourcc(cast[ptr DmabufTextureBuilder00](self.impl)))

proc fourcc*(self: DmabufTextureBuilder): int =
  int(gdk_dmabuf_texture_builder_get_fourcc(cast[ptr DmabufTextureBuilder00](self.impl)))

proc gdk_dmabuf_texture_builder_get_height(self: ptr DmabufTextureBuilder00): uint32 {.
    importc, libprag.}

proc getHeight*(self: DmabufTextureBuilder): int =
  int(gdk_dmabuf_texture_builder_get_height(cast[ptr DmabufTextureBuilder00](self.impl)))

proc height*(self: DmabufTextureBuilder): int =
  int(gdk_dmabuf_texture_builder_get_height(cast[ptr DmabufTextureBuilder00](self.impl)))

proc gdk_dmabuf_texture_builder_get_modifier(self: ptr DmabufTextureBuilder00): uint64 {.
    importc, libprag.}

proc getModifier*(self: DmabufTextureBuilder): uint64 =
  gdk_dmabuf_texture_builder_get_modifier(cast[ptr DmabufTextureBuilder00](self.impl))

proc modifier*(self: DmabufTextureBuilder): uint64 =
  gdk_dmabuf_texture_builder_get_modifier(cast[ptr DmabufTextureBuilder00](self.impl))

proc gdk_dmabuf_texture_builder_get_n_planes(self: ptr DmabufTextureBuilder00): uint32 {.
    importc, libprag.}

proc getNPlanes*(self: DmabufTextureBuilder): int =
  int(gdk_dmabuf_texture_builder_get_n_planes(cast[ptr DmabufTextureBuilder00](self.impl)))

proc nPlanes*(self: DmabufTextureBuilder): int =
  int(gdk_dmabuf_texture_builder_get_n_planes(cast[ptr DmabufTextureBuilder00](self.impl)))

proc gdk_dmabuf_texture_builder_get_offset(self: ptr DmabufTextureBuilder00;
    plane: uint32): uint32 {.
    importc, libprag.}

proc getOffset*(self: DmabufTextureBuilder; plane: int): int =
  int(gdk_dmabuf_texture_builder_get_offset(cast[ptr DmabufTextureBuilder00](self.impl), uint32(plane)))

proc gdk_dmabuf_texture_builder_get_premultiplied(self: ptr DmabufTextureBuilder00): gboolean {.
    importc, libprag.}

proc getPremultiplied*(self: DmabufTextureBuilder): bool =
  toBool(gdk_dmabuf_texture_builder_get_premultiplied(cast[ptr DmabufTextureBuilder00](self.impl)))

proc premultiplied*(self: DmabufTextureBuilder): bool =
  toBool(gdk_dmabuf_texture_builder_get_premultiplied(cast[ptr DmabufTextureBuilder00](self.impl)))

proc gdk_dmabuf_texture_builder_get_stride(self: ptr DmabufTextureBuilder00;
    plane: uint32): uint32 {.
    importc, libprag.}

proc getStride*(self: DmabufTextureBuilder; plane: int): int =
  int(gdk_dmabuf_texture_builder_get_stride(cast[ptr DmabufTextureBuilder00](self.impl), uint32(plane)))

proc gdk_dmabuf_texture_builder_get_update_region(self: ptr DmabufTextureBuilder00): ptr cairo.Region00 {.
    importc, libprag.}

proc getUpdateRegion*(self: DmabufTextureBuilder): cairo.Region =
  let impl0 = gdk_dmabuf_texture_builder_get_update_region(cast[ptr DmabufTextureBuilder00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_region_get_type(), impl0))

proc updateRegion*(self: DmabufTextureBuilder): cairo.Region =
  let impl0 = gdk_dmabuf_texture_builder_get_update_region(cast[ptr DmabufTextureBuilder00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_region_get_type(), impl0))

proc gdk_dmabuf_texture_builder_get_update_texture(self: ptr DmabufTextureBuilder00): ptr Texture00 {.
    importc, libprag.}

proc getUpdateTexture*(self: DmabufTextureBuilder): Texture =
  let gobj = gdk_dmabuf_texture_builder_get_update_texture(cast[ptr DmabufTextureBuilder00](self.impl))
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

proc updateTexture*(self: DmabufTextureBuilder): Texture =
  let gobj = gdk_dmabuf_texture_builder_get_update_texture(cast[ptr DmabufTextureBuilder00](self.impl))
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

proc gdk_dmabuf_texture_builder_get_width(self: ptr DmabufTextureBuilder00): uint32 {.
    importc, libprag.}

proc getWidth*(self: DmabufTextureBuilder): int =
  int(gdk_dmabuf_texture_builder_get_width(cast[ptr DmabufTextureBuilder00](self.impl)))

proc width*(self: DmabufTextureBuilder): int =
  int(gdk_dmabuf_texture_builder_get_width(cast[ptr DmabufTextureBuilder00](self.impl)))

proc gdk_dmabuf_texture_builder_set_display(self: ptr DmabufTextureBuilder00;
    display: ptr Display00) {.
    importc, libprag.}

proc setDisplay*(self: DmabufTextureBuilder; display: Display) =
  gdk_dmabuf_texture_builder_set_display(cast[ptr DmabufTextureBuilder00](self.impl), cast[ptr Display00](display.impl))

proc `display=`*(self: DmabufTextureBuilder; display: Display) =
  gdk_dmabuf_texture_builder_set_display(cast[ptr DmabufTextureBuilder00](self.impl), cast[ptr Display00](display.impl))

proc gdk_dmabuf_texture_builder_set_fd(self: ptr DmabufTextureBuilder00;
    plane: uint32; fd: int32) {.
    importc, libprag.}

proc setFd*(self: DmabufTextureBuilder; plane: int;
    fd: int) =
  gdk_dmabuf_texture_builder_set_fd(cast[ptr DmabufTextureBuilder00](self.impl), uint32(plane), int32(fd))

proc gdk_dmabuf_texture_builder_set_fourcc(self: ptr DmabufTextureBuilder00;
    fourcc: uint32) {.
    importc, libprag.}

proc setFourcc*(self: DmabufTextureBuilder; fourcc: int) =
  gdk_dmabuf_texture_builder_set_fourcc(cast[ptr DmabufTextureBuilder00](self.impl), uint32(fourcc))

proc `fourcc=`*(self: DmabufTextureBuilder; fourcc: int) =
  gdk_dmabuf_texture_builder_set_fourcc(cast[ptr DmabufTextureBuilder00](self.impl), uint32(fourcc))

proc gdk_dmabuf_texture_builder_set_height(self: ptr DmabufTextureBuilder00;
    height: uint32) {.
    importc, libprag.}

proc setHeight*(self: DmabufTextureBuilder; height: int) =
  gdk_dmabuf_texture_builder_set_height(cast[ptr DmabufTextureBuilder00](self.impl), uint32(height))

proc `height=`*(self: DmabufTextureBuilder; height: int) =
  gdk_dmabuf_texture_builder_set_height(cast[ptr DmabufTextureBuilder00](self.impl), uint32(height))

proc gdk_dmabuf_texture_builder_set_modifier(self: ptr DmabufTextureBuilder00;
    modifier: uint64) {.
    importc, libprag.}

proc setModifier*(self: DmabufTextureBuilder;
    modifier: uint64) =
  gdk_dmabuf_texture_builder_set_modifier(cast[ptr DmabufTextureBuilder00](self.impl), modifier)

proc `modifier=`*(self: DmabufTextureBuilder;
    modifier: uint64) =
  gdk_dmabuf_texture_builder_set_modifier(cast[ptr DmabufTextureBuilder00](self.impl), modifier)

proc gdk_dmabuf_texture_builder_set_n_planes(self: ptr DmabufTextureBuilder00;
    nPlanes: uint32) {.
    importc, libprag.}

proc setNPlanes*(self: DmabufTextureBuilder;
    nPlanes: int) =
  gdk_dmabuf_texture_builder_set_n_planes(cast[ptr DmabufTextureBuilder00](self.impl), uint32(nPlanes))

proc `nPlanes=`*(self: DmabufTextureBuilder;
    nPlanes: int) =
  gdk_dmabuf_texture_builder_set_n_planes(cast[ptr DmabufTextureBuilder00](self.impl), uint32(nPlanes))

proc gdk_dmabuf_texture_builder_set_offset(self: ptr DmabufTextureBuilder00;
    plane: uint32; offset: uint32) {.
    importc, libprag.}

proc setOffset*(self: DmabufTextureBuilder; plane: int;
    offset: int) =
  gdk_dmabuf_texture_builder_set_offset(cast[ptr DmabufTextureBuilder00](self.impl), uint32(plane), uint32(offset))

proc gdk_dmabuf_texture_builder_set_premultiplied(self: ptr DmabufTextureBuilder00;
    premultiplied: gboolean) {.
    importc, libprag.}

proc setPremultiplied*(self: DmabufTextureBuilder;
    premultiplied: bool = true) =
  gdk_dmabuf_texture_builder_set_premultiplied(cast[ptr DmabufTextureBuilder00](self.impl), gboolean(premultiplied))

proc `premultiplied=`*(self: DmabufTextureBuilder;
    premultiplied: bool) =
  gdk_dmabuf_texture_builder_set_premultiplied(cast[ptr DmabufTextureBuilder00](self.impl), gboolean(premultiplied))

proc gdk_dmabuf_texture_builder_set_stride(self: ptr DmabufTextureBuilder00;
    plane: uint32; stride: uint32) {.
    importc, libprag.}

proc setStride*(self: DmabufTextureBuilder; plane: int;
    stride: int) =
  gdk_dmabuf_texture_builder_set_stride(cast[ptr DmabufTextureBuilder00](self.impl), uint32(plane), uint32(stride))

proc gdk_dmabuf_texture_builder_set_update_region(self: ptr DmabufTextureBuilder00;
    region: ptr cairo.Region00) {.
    importc, libprag.}

proc setUpdateRegion*(self: DmabufTextureBuilder;
    region: cairo.Region = nil) =
  gdk_dmabuf_texture_builder_set_update_region(cast[ptr DmabufTextureBuilder00](self.impl), if region.isNil: nil else: cast[ptr cairo.Region00](region.impl))

proc `updateRegion=`*(self: DmabufTextureBuilder;
    region: cairo.Region = nil) =
  gdk_dmabuf_texture_builder_set_update_region(cast[ptr DmabufTextureBuilder00](self.impl), if region.isNil: nil else: cast[ptr cairo.Region00](region.impl))

proc gdk_dmabuf_texture_builder_set_update_texture(self: ptr DmabufTextureBuilder00;
    texture: ptr Texture00) {.
    importc, libprag.}

proc setUpdateTexture*(self: DmabufTextureBuilder;
    texture: Texture = nil) =
  gdk_dmabuf_texture_builder_set_update_texture(cast[ptr DmabufTextureBuilder00](self.impl), if texture.isNil: nil else: cast[ptr Texture00](texture.impl))

proc `updateTexture=`*(self: DmabufTextureBuilder;
    texture: Texture = nil) =
  gdk_dmabuf_texture_builder_set_update_texture(cast[ptr DmabufTextureBuilder00](self.impl), if texture.isNil: nil else: cast[ptr Texture00](texture.impl))

proc gdk_dmabuf_texture_builder_set_width(self: ptr DmabufTextureBuilder00;
    width: uint32) {.
    importc, libprag.}

proc setWidth*(self: DmabufTextureBuilder; width: int) =
  gdk_dmabuf_texture_builder_set_width(cast[ptr DmabufTextureBuilder00](self.impl), uint32(width))

proc `width=`*(self: DmabufTextureBuilder; width: int) =
  gdk_dmabuf_texture_builder_set_width(cast[ptr DmabufTextureBuilder00](self.impl), uint32(width))

type
  DragSurfaceSize00* {.pure.} = object
  DragSurfaceSize* = ref object
    impl*: ptr DragSurfaceSize00
    ignoreFinalizer*: bool

proc gdk_drag_surface_size_set_size(self: ptr DragSurfaceSize00; width: int32;
    height: int32) {.
    importc, libprag.}

proc setSize*(self: DragSurfaceSize; width: int; height: int) =
  gdk_drag_surface_size_set_size(cast[ptr DragSurfaceSize00](self.impl), int32(width), int32(height))

type
  DragSurface00* = object of gobject.Object00
  DragSurface* = ref object of gobject.Object

proc scComputeSize*(self: DragSurface;  p: proc (self: ptr DragSurface00; size: ptr ptr DragSurfaceSize00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "compute-size", cast[GCallback](p), xdata, nil, cf)

proc gdk_drag_surface_present(self: ptr DragSurface00; width: int32; height: int32): gboolean {.
    importc, libprag.}

proc present*(self: DragSurface; width: int; height: int): bool =
  toBool(gdk_drag_surface_present(cast[ptr DragSurface00](self.impl), int32(width), int32(height)))

const EVENT_PROPAGATE* = false

const EVENT_STOP* = true

type
  FileList00* {.pure.} = object
  FileList* = ref object
    impl*: ptr FileList00
    ignoreFinalizer*: bool

proc gdk_file_list_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkFileList*(self: FileList) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_file_list_get_type(), cast[ptr FileList00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FileList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_file_list_get_type(), cast[ptr FileList00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var FileList) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkFileList)

proc gdk_file_list_new_from_array(files: ptr ptr gio.GFile00; nFiles: uint64): ptr FileList00 {.
    importc, libprag.}

proc newFileListFromArray*(files: ptr ptr gio.GFile00; nFiles: uint64): FileList =
  fnew(result, gBoxedFreeGdkFileList)
  result.impl = gdk_file_list_new_from_array(files, nFiles)

proc newFileListFromArray*(tdesc: typedesc; files: ptr ptr gio.GFile00; nFiles: uint64): tdesc =
  assert(result is FileList)
  fnew(result, gBoxedFreeGdkFileList)
  result.impl = gdk_file_list_new_from_array(files, nFiles)

proc initFileListFromArray*[T](result: var T; files: ptr ptr gio.GFile00; nFiles: uint64) {.deprecated.} =
  assert(result is FileList)
  fnew(result, gBoxedFreeGdkFileList)
  result.impl = gdk_file_list_new_from_array(files, nFiles)

proc gdk_file_list_new_from_list(files: ptr glib.SList): ptr FileList00 {.
    importc, libprag.}

proc newFileListFromList*(files: seq[gio.GFile]): FileList =
  var tempResGL = seq2GSList(files)
  fnew(result, gBoxedFreeGdkFileList)
  result.impl = gdk_file_list_new_from_list(tempResGL)

proc newFileListFromList*(tdesc: typedesc; files: seq[gio.GFile]): tdesc =
  var tempResGL = seq2GSList(files)
  assert(result is FileList)
  fnew(result, gBoxedFreeGdkFileList)
  result.impl = gdk_file_list_new_from_list(tempResGL)

proc initFileListFromList*[T](result: var T; files: seq[gio.GFile]) {.deprecated.} =
  var tempResGL = seq2GSList(files)
  assert(result is FileList)
  fnew(result, gBoxedFreeGdkFileList)
  result.impl = gdk_file_list_new_from_list(tempResGL)

proc gdk_file_list_get_files(self: ptr FileList00): ptr glib.SList {.
    importc, libprag.}

proc getFiles*(self: FileList): seq[gio.GFile] =
  let resul0 = gdk_file_list_get_files(cast[ptr FileList00](self.impl))
  result = gslistObjects2seq(gio.GFile, resul0, false)
  g_slist_free(resul0)

proc files*(self: FileList): seq[gio.GFile] =
  let resul0 = gdk_file_list_get_files(cast[ptr FileList00](self.impl))
  result = gslistObjects2seq(gio.GFile, resul0, false)
  g_slist_free(resul0)

type
  FocusEvent* = ref object of Event
  FocusEvent00* = object of Event00

proc gdk_focus_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr FocusEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: FocusEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FocusEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

proc gdk_focus_event_get_in(self: ptr FocusEvent00): gboolean {.
    importc, libprag.}

proc getIn*(self: FocusEvent): bool =
  toBool(gdk_focus_event_get_in(cast[ptr FocusEvent00](self.impl)))

type
  FullscreenMode* {.size: sizeof(cint), pure.} = enum
    currentMonitor = 0
    allMonitors = 1

type
  GLError* {.size: sizeof(cint), pure.} = enum
    notAvailable = 0
    unsupportedFormat = 1
    unsupportedProfile = 2
    compilationFailed = 3
    linkFailed = 4

type
  GLTexture* = ref object of Texture
  GLTexture00* = object of Texture00

proc gdk_gl_texture_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLTexture()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_gl_texture_new(context: ptr GLContext00; id: uint32; width: int32;
    height: int32; destroy: DestroyNotify; data: pointer): ptr GLTexture00 {.
    importc, libprag.}

proc newGLTexture*(context: GLContext; id: int; width: int; height: int;
    destroy: DestroyNotify; data: pointer): GLTexture {.deprecated.}  =
  let gobj = gdk_gl_texture_new(cast[ptr GLContext00](context.impl), uint32(id), int32(width), int32(height), destroy, data)
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

proc newGLTexture*(tdesc: typedesc; context: GLContext; id: int; width: int; height: int;
    destroy: DestroyNotify; data: pointer): tdesc {.deprecated.}  =
  assert(result is GLTexture)
  let gobj = gdk_gl_texture_new(cast[ptr GLContext00](context.impl), uint32(id), int32(width), int32(height), destroy, data)
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

proc initGLTexture*[T](result: var T; context: GLContext; id: int; width: int; height: int;
    destroy: DestroyNotify; data: pointer) {.deprecated.} =
  assert(result is GLTexture)
  let gobj = gdk_gl_texture_new(cast[ptr GLContext00](context.impl), uint32(id), int32(width), int32(height), destroy, data)
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

proc gdk_gl_texture_release(self: ptr GLTexture00) {.
    importc, libprag.}

proc release*(self: GLTexture) =
  gdk_gl_texture_release(cast[ptr GLTexture00](self.impl))

type
  GLTextureBuilder* = ref object of gobject.Object
  GLTextureBuilder00* = object of gobject.Object00

proc gdk_gl_texture_builder_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLTextureBuilder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_gl_texture_builder_new(): ptr GLTextureBuilder00 {.
    importc, libprag.}

proc newGLTextureBuilder*(): GLTextureBuilder =
  let gobj = gdk_gl_texture_builder_new()
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

proc newGLTextureBuilder*(tdesc: typedesc): tdesc =
  assert(result is GLTextureBuilder)
  let gobj = gdk_gl_texture_builder_new()
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

proc initGLTextureBuilder*[T](result: var T) {.deprecated.} =
  assert(result is GLTextureBuilder)
  let gobj = gdk_gl_texture_builder_new()
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

proc gdk_gl_texture_builder_build(self: ptr GLTextureBuilder00; destroy: DestroyNotify;
    data: pointer): ptr Texture00 {.
    importc, libprag.}

proc build*(self: GLTextureBuilder; destroy: DestroyNotify;
    data: pointer): Texture =
  let gobj = gdk_gl_texture_builder_build(cast[ptr GLTextureBuilder00](self.impl), destroy, data)
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

proc gdk_gl_texture_builder_get_context(self: ptr GLTextureBuilder00): ptr GLContext00 {.
    importc, libprag.}

proc getContext*(self: GLTextureBuilder): GLContext =
  let gobj = gdk_gl_texture_builder_get_context(cast[ptr GLTextureBuilder00](self.impl))
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

proc context*(self: GLTextureBuilder): GLContext =
  let gobj = gdk_gl_texture_builder_get_context(cast[ptr GLTextureBuilder00](self.impl))
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

proc gdk_gl_texture_builder_get_format(self: ptr GLTextureBuilder00): MemoryFormat {.
    importc, libprag.}

proc getFormat*(self: GLTextureBuilder): MemoryFormat =
  gdk_gl_texture_builder_get_format(cast[ptr GLTextureBuilder00](self.impl))

proc format*(self: GLTextureBuilder): MemoryFormat =
  gdk_gl_texture_builder_get_format(cast[ptr GLTextureBuilder00](self.impl))

proc gdk_gl_texture_builder_get_has_mipmap(self: ptr GLTextureBuilder00): gboolean {.
    importc, libprag.}

proc getHasMipmap*(self: GLTextureBuilder): bool =
  toBool(gdk_gl_texture_builder_get_has_mipmap(cast[ptr GLTextureBuilder00](self.impl)))

proc hasMipmap*(self: GLTextureBuilder): bool =
  toBool(gdk_gl_texture_builder_get_has_mipmap(cast[ptr GLTextureBuilder00](self.impl)))

proc gdk_gl_texture_builder_get_height(self: ptr GLTextureBuilder00): int32 {.
    importc, libprag.}

proc getHeight*(self: GLTextureBuilder): int =
  int(gdk_gl_texture_builder_get_height(cast[ptr GLTextureBuilder00](self.impl)))

proc height*(self: GLTextureBuilder): int =
  int(gdk_gl_texture_builder_get_height(cast[ptr GLTextureBuilder00](self.impl)))

proc gdk_gl_texture_builder_get_id(self: ptr GLTextureBuilder00): uint32 {.
    importc, libprag.}

proc getId*(self: GLTextureBuilder): int =
  int(gdk_gl_texture_builder_get_id(cast[ptr GLTextureBuilder00](self.impl)))

proc id*(self: GLTextureBuilder): int =
  int(gdk_gl_texture_builder_get_id(cast[ptr GLTextureBuilder00](self.impl)))

proc gdk_gl_texture_builder_get_sync(self: ptr GLTextureBuilder00): pointer {.
    importc, libprag.}

proc getSync*(self: GLTextureBuilder): pointer =
  gdk_gl_texture_builder_get_sync(cast[ptr GLTextureBuilder00](self.impl))

proc gdk_gl_texture_builder_get_update_region(self: ptr GLTextureBuilder00): ptr cairo.Region00 {.
    importc, libprag.}

proc getUpdateRegion*(self: GLTextureBuilder): cairo.Region =
  let impl0 = gdk_gl_texture_builder_get_update_region(cast[ptr GLTextureBuilder00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_region_get_type(), impl0))

proc updateRegion*(self: GLTextureBuilder): cairo.Region =
  let impl0 = gdk_gl_texture_builder_get_update_region(cast[ptr GLTextureBuilder00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_region_get_type(), impl0))

proc gdk_gl_texture_builder_get_update_texture(self: ptr GLTextureBuilder00): ptr Texture00 {.
    importc, libprag.}

proc getUpdateTexture*(self: GLTextureBuilder): Texture =
  let gobj = gdk_gl_texture_builder_get_update_texture(cast[ptr GLTextureBuilder00](self.impl))
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

proc updateTexture*(self: GLTextureBuilder): Texture =
  let gobj = gdk_gl_texture_builder_get_update_texture(cast[ptr GLTextureBuilder00](self.impl))
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

proc gdk_gl_texture_builder_get_width(self: ptr GLTextureBuilder00): int32 {.
    importc, libprag.}

proc getWidth*(self: GLTextureBuilder): int =
  int(gdk_gl_texture_builder_get_width(cast[ptr GLTextureBuilder00](self.impl)))

proc width*(self: GLTextureBuilder): int =
  int(gdk_gl_texture_builder_get_width(cast[ptr GLTextureBuilder00](self.impl)))

proc gdk_gl_texture_builder_set_context(self: ptr GLTextureBuilder00; context: ptr GLContext00) {.
    importc, libprag.}

proc setContext*(self: GLTextureBuilder; context: GLContext = nil) =
  gdk_gl_texture_builder_set_context(cast[ptr GLTextureBuilder00](self.impl), if context.isNil: nil else: cast[ptr GLContext00](context.impl))

proc `context=`*(self: GLTextureBuilder; context: GLContext = nil) =
  gdk_gl_texture_builder_set_context(cast[ptr GLTextureBuilder00](self.impl), if context.isNil: nil else: cast[ptr GLContext00](context.impl))

proc gdk_gl_texture_builder_set_format(self: ptr GLTextureBuilder00; format: MemoryFormat) {.
    importc, libprag.}

proc setFormat*(self: GLTextureBuilder; format: MemoryFormat) =
  gdk_gl_texture_builder_set_format(cast[ptr GLTextureBuilder00](self.impl), format)

proc `format=`*(self: GLTextureBuilder; format: MemoryFormat) =
  gdk_gl_texture_builder_set_format(cast[ptr GLTextureBuilder00](self.impl), format)

proc gdk_gl_texture_builder_set_has_mipmap(self: ptr GLTextureBuilder00;
    hasMipmap: gboolean) {.
    importc, libprag.}

proc setHasMipmap*(self: GLTextureBuilder; hasMipmap: bool = true) =
  gdk_gl_texture_builder_set_has_mipmap(cast[ptr GLTextureBuilder00](self.impl), gboolean(hasMipmap))

proc `hasMipmap=`*(self: GLTextureBuilder; hasMipmap: bool) =
  gdk_gl_texture_builder_set_has_mipmap(cast[ptr GLTextureBuilder00](self.impl), gboolean(hasMipmap))

proc gdk_gl_texture_builder_set_height(self: ptr GLTextureBuilder00; height: int32) {.
    importc, libprag.}

proc setHeight*(self: GLTextureBuilder; height: int) =
  gdk_gl_texture_builder_set_height(cast[ptr GLTextureBuilder00](self.impl), int32(height))

proc `height=`*(self: GLTextureBuilder; height: int) =
  gdk_gl_texture_builder_set_height(cast[ptr GLTextureBuilder00](self.impl), int32(height))

proc gdk_gl_texture_builder_set_id(self: ptr GLTextureBuilder00; id: uint32) {.
    importc, libprag.}

proc setId*(self: GLTextureBuilder; id: int) =
  gdk_gl_texture_builder_set_id(cast[ptr GLTextureBuilder00](self.impl), uint32(id))

proc `id=`*(self: GLTextureBuilder; id: int) =
  gdk_gl_texture_builder_set_id(cast[ptr GLTextureBuilder00](self.impl), uint32(id))

proc gdk_gl_texture_builder_set_sync(self: ptr GLTextureBuilder00; sync: pointer) {.
    importc, libprag.}

proc setSync*(self: GLTextureBuilder; sync: pointer) =
  gdk_gl_texture_builder_set_sync(cast[ptr GLTextureBuilder00](self.impl), sync)

proc `sync=`*(self: GLTextureBuilder; sync: pointer) =
  gdk_gl_texture_builder_set_sync(cast[ptr GLTextureBuilder00](self.impl), sync)

proc gdk_gl_texture_builder_set_update_region(self: ptr GLTextureBuilder00;
    region: ptr cairo.Region00) {.
    importc, libprag.}

proc setUpdateRegion*(self: GLTextureBuilder; region: cairo.Region = nil) =
  gdk_gl_texture_builder_set_update_region(cast[ptr GLTextureBuilder00](self.impl), if region.isNil: nil else: cast[ptr cairo.Region00](region.impl))

proc `updateRegion=`*(self: GLTextureBuilder; region: cairo.Region = nil) =
  gdk_gl_texture_builder_set_update_region(cast[ptr GLTextureBuilder00](self.impl), if region.isNil: nil else: cast[ptr cairo.Region00](region.impl))

proc gdk_gl_texture_builder_set_update_texture(self: ptr GLTextureBuilder00;
    texture: ptr Texture00) {.
    importc, libprag.}

proc setUpdateTexture*(self: GLTextureBuilder; texture: Texture = nil) =
  gdk_gl_texture_builder_set_update_texture(cast[ptr GLTextureBuilder00](self.impl), if texture.isNil: nil else: cast[ptr Texture00](texture.impl))

proc `updateTexture=`*(self: GLTextureBuilder; texture: Texture = nil) =
  gdk_gl_texture_builder_set_update_texture(cast[ptr GLTextureBuilder00](self.impl), if texture.isNil: nil else: cast[ptr Texture00](texture.impl))

proc gdk_gl_texture_builder_set_width(self: ptr GLTextureBuilder00; width: int32) {.
    importc, libprag.}

proc setWidth*(self: GLTextureBuilder; width: int) =
  gdk_gl_texture_builder_set_width(cast[ptr GLTextureBuilder00](self.impl), int32(width))

proc `width=`*(self: GLTextureBuilder; width: int) =
  gdk_gl_texture_builder_set_width(cast[ptr GLTextureBuilder00](self.impl), int32(width))

type
  GrabBrokenEvent* = ref object of Event
  GrabBrokenEvent00* = object of Event00

proc gdk_grab_broken_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr GrabBrokenEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: GrabBrokenEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GrabBrokenEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

proc gdk_grab_broken_event_get_grab_surface(self: ptr GrabBrokenEvent00): ptr Surface00 {.
    importc, libprag.}

proc getGrabSurface*(self: GrabBrokenEvent): Surface =
  let gobj = gdk_grab_broken_event_get_grab_surface(cast[ptr GrabBrokenEvent00](self.impl))
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

proc grabSurface*(self: GrabBrokenEvent): Surface =
  let gobj = gdk_grab_broken_event_get_grab_surface(cast[ptr GrabBrokenEvent00](self.impl))
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

proc gdk_grab_broken_event_get_implicit(self: ptr GrabBrokenEvent00): gboolean {.
    importc, libprag.}

proc getImplicit*(self: GrabBrokenEvent): bool =
  toBool(gdk_grab_broken_event_get_implicit(cast[ptr GrabBrokenEvent00](self.impl)))

proc implicit*(self: GrabBrokenEvent): bool =
  toBool(gdk_grab_broken_event_get_implicit(cast[ptr GrabBrokenEvent00](self.impl)))

type
  Gravity* {.size: sizeof(cint), pure.} = enum
    northWest = 1
    north = 2
    northEast = 3
    west = 4
    center = 5
    east = 6
    southWest = 7
    south = 8
    southEast = 9
    `static` = 10

const KEY_0* = 48'i32

const KEY_1* = 49'i32

const KEY_2* = 50'i32

const KEY_3* = 51'i32

const KEY_3270_AltCursor* = 64784'i32

const KEY_3270_Attn* = 64782'i32

const KEY_3270_BackTab* = 64773'i32

const KEY_3270_ChangeScreen* = 64793'i32

const KEY_3270_Copy* = 64789'i32

const KEY_3270_CursorBlink* = 64783'i32

const KEY_3270_CursorSelect* = 64796'i32

const KEY_3270_DeleteWord* = 64794'i32

const KEY_3270_Duplicate* = 64769'i32

const KEY_3270_Enter* = 64798'i32

const KEY_3270_EraseEOF* = 64774'i32

const KEY_3270_EraseInput* = 64775'i32

const KEY_3270_ExSelect* = 64795'i32

const KEY_3270_FieldMark* = 64770'i32

const KEY_3270_Ident* = 64787'i32

const KEY_3270_Jump* = 64786'i32

const KEY_3270_KeyClick* = 64785'i32

const KEY_3270_Left2* = 64772'i32

const KEY_3270_PA1* = 64778'i32

const KEY_3270_PA2* = 64779'i32

const KEY_3270_PA3* = 64780'i32

const KEY_3270_Play* = 64790'i32

const KEY_3270_PrintScreen* = 64797'i32

const KEY_3270_Quit* = 64777'i32

const KEY_3270_Record* = 64792'i32

const KEY_3270_Reset* = 64776'i32

const KEY_3270_Right2* = 64771'i32

const KEY_3270_Rule* = 64788'i32

const KEY_3270_Setup* = 64791'i32

const KEY_3270_Test* = 64781'i32

const KEY_4* = 52'i32

const KEY_5* = 53'i32

const KEY_6* = 54'i32

const KEY_7* = 55'i32

const KEY_8* = 56'i32

const KEY_9* = 57'i32

const UKEY_A* = 65'i32

const UKEY_AE* = 198'i32

const UKEY_Aacute* = 193'i32

const UKEY_Abelowdot* = 16785056'i32

const UKEY_Abreve* = 451'i32

const UKEY_Abreveacute* = 16785070'i32

const UKEY_Abrevebelowdot* = 16785078'i32

const UKEY_Abrevegrave* = 16785072'i32

const UKEY_Abrevehook* = 16785074'i32

const UKEY_Abrevetilde* = 16785076'i32

const KEY_AccessX_Enable* = 65136'i32

const KEY_AccessX_Feedback_Enable* = 65137'i32

const UKEY_Acircumflex* = 194'i32

const UKEY_Acircumflexacute* = 16785060'i32

const UKEY_Acircumflexbelowdot* = 16785068'i32

const UKEY_Acircumflexgrave* = 16785062'i32

const UKEY_Acircumflexhook* = 16785064'i32

const UKEY_Acircumflextilde* = 16785066'i32

const KEY_AddFavorite* = 269025081'i32

const UKEY_Adiaeresis* = 196'i32

const UKEY_Agrave* = 192'i32

const UKEY_Ahook* = 16785058'i32

const KEY_Alt_L* = 65513'i32

const KEY_Alt_R* = 65514'i32

const UKEY_Amacron* = 960'i32

const UKEY_Aogonek* = 417'i32

const KEY_ApplicationLeft* = 269025104'i32

const KEY_ApplicationRight* = 269025105'i32

const KEY_Arabic_0* = 16778848'i32

const KEY_Arabic_1* = 16778849'i32

const KEY_Arabic_2* = 16778850'i32

const KEY_Arabic_3* = 16778851'i32

const KEY_Arabic_4* = 16778852'i32

const KEY_Arabic_5* = 16778853'i32

const KEY_Arabic_6* = 16778854'i32

const KEY_Arabic_7* = 16778855'i32

const KEY_Arabic_8* = 16778856'i32

const KEY_Arabic_9* = 16778857'i32

const KEY_Arabic_ain* = 1497'i32

const KEY_Arabic_alef* = 1479'i32

const KEY_Arabic_alefmaksura* = 1513'i32

const KEY_Arabic_beh* = 1480'i32

const KEY_Arabic_comma* = 1452'i32

const KEY_Arabic_dad* = 1494'i32

const KEY_Arabic_dal* = 1487'i32

const KEY_Arabic_damma* = 1519'i32

const KEY_Arabic_dammatan* = 1516'i32

const KEY_Arabic_ddal* = 16778888'i32

const KEY_Arabic_farsi_yeh* = 16778956'i32

const KEY_Arabic_fatha* = 1518'i32

const KEY_Arabic_fathatan* = 1515'i32

const KEY_Arabic_feh* = 1505'i32

const KEY_Arabic_fullstop* = 16778964'i32

const KEY_Arabic_gaf* = 16778927'i32

const KEY_Arabic_ghain* = 1498'i32

const KEY_Arabic_ha* = 1511'i32

const KEY_Arabic_hah* = 1485'i32

const KEY_Arabic_hamza* = 1473'i32

const KEY_Arabic_hamza_above* = 16778836'i32

const KEY_Arabic_hamza_below* = 16778837'i32

const KEY_Arabic_hamzaonalef* = 1475'i32

const KEY_Arabic_hamzaonwaw* = 1476'i32

const KEY_Arabic_hamzaonyeh* = 1478'i32

const KEY_Arabic_hamzaunderalef* = 1477'i32

const KEY_Arabic_heh* = 1511'i32

const KEY_Arabic_heh_doachashmee* = 16778942'i32

const KEY_Arabic_heh_goal* = 16778945'i32

const KEY_Arabic_jeem* = 1484'i32

const KEY_Arabic_jeh* = 16778904'i32

const KEY_Arabic_kaf* = 1507'i32

const KEY_Arabic_kasra* = 1520'i32

const KEY_Arabic_kasratan* = 1517'i32

const KEY_Arabic_keheh* = 16778921'i32

const KEY_Arabic_khah* = 1486'i32

const KEY_Arabic_lam* = 1508'i32

const KEY_Arabic_madda_above* = 16778835'i32

const KEY_Arabic_maddaonalef* = 1474'i32

const KEY_Arabic_meem* = 1509'i32

const KEY_Arabic_noon* = 1510'i32

const KEY_Arabic_noon_ghunna* = 16778938'i32

const KEY_Arabic_peh* = 16778878'i32

const KEY_Arabic_percent* = 16778858'i32

const KEY_Arabic_qaf* = 1506'i32

const KEY_Arabic_question_mark* = 1471'i32

const KEY_Arabic_ra* = 1489'i32

const KEY_Arabic_rreh* = 16778897'i32

const KEY_Arabic_sad* = 1493'i32

const KEY_Arabic_seen* = 1491'i32

const KEY_Arabic_semicolon* = 1467'i32

const KEY_Arabic_shadda* = 1521'i32

const KEY_Arabic_sheen* = 1492'i32

const KEY_Arabic_sukun* = 1522'i32

const KEY_Arabic_superscript_alef* = 16778864'i32

const KEY_Arabic_switch* = 65406'i32

const KEY_Arabic_tah* = 1495'i32

const KEY_Arabic_tatweel* = 1504'i32

const KEY_Arabic_tcheh* = 16778886'i32

const KEY_Arabic_teh* = 1482'i32

const KEY_Arabic_tehmarbuta* = 1481'i32

const KEY_Arabic_thal* = 1488'i32

const KEY_Arabic_theh* = 1483'i32

const KEY_Arabic_tteh* = 16778873'i32

const KEY_Arabic_veh* = 16778916'i32

const KEY_Arabic_waw* = 1512'i32

const KEY_Arabic_yeh* = 1514'i32

const KEY_Arabic_yeh_baree* = 16778962'i32

const KEY_Arabic_zah* = 1496'i32

const KEY_Arabic_zain* = 1490'i32

const UKEY_Aring* = 197'i32

const UKEY_Armenian_AT* = 16778552'i32

const UKEY_Armenian_AYB* = 16778545'i32

const UKEY_Armenian_BEN* = 16778546'i32

const UKEY_Armenian_CHA* = 16778569'i32

const UKEY_Armenian_DA* = 16778548'i32

const UKEY_Armenian_DZA* = 16778561'i32

const UKEY_Armenian_E* = 16778551'i32

const UKEY_Armenian_FE* = 16778582'i32

const UKEY_Armenian_GHAT* = 16778562'i32

const UKEY_Armenian_GIM* = 16778547'i32

const UKEY_Armenian_HI* = 16778565'i32

const UKEY_Armenian_HO* = 16778560'i32

const UKEY_Armenian_INI* = 16778555'i32

const UKEY_Armenian_JE* = 16778571'i32

const UKEY_Armenian_KE* = 16778580'i32

const UKEY_Armenian_KEN* = 16778559'i32

const UKEY_Armenian_KHE* = 16778557'i32

const UKEY_Armenian_LYUN* = 16778556'i32

const UKEY_Armenian_MEN* = 16778564'i32

const UKEY_Armenian_NU* = 16778566'i32

const UKEY_Armenian_O* = 16778581'i32

const UKEY_Armenian_PE* = 16778570'i32

const UKEY_Armenian_PYUR* = 16778579'i32

const UKEY_Armenian_RA* = 16778572'i32

const UKEY_Armenian_RE* = 16778576'i32

const UKEY_Armenian_SE* = 16778573'i32

const UKEY_Armenian_SHA* = 16778567'i32

const UKEY_Armenian_TCHE* = 16778563'i32

const UKEY_Armenian_TO* = 16778553'i32

const UKEY_Armenian_TSA* = 16778558'i32

const UKEY_Armenian_TSO* = 16778577'i32

const UKEY_Armenian_TYUN* = 16778575'i32

const UKEY_Armenian_VEV* = 16778574'i32

const UKEY_Armenian_VO* = 16778568'i32

const UKEY_Armenian_VYUN* = 16778578'i32

const UKEY_Armenian_YECH* = 16778549'i32

const UKEY_Armenian_ZA* = 16778550'i32

const UKEY_Armenian_ZHE* = 16778554'i32

const KEY_Armenian_accent* = 16778587'i32

const KEY_Armenian_amanak* = 16778588'i32

const KEY_Armenian_apostrophe* = 16778586'i32

const KEY_Armenian_at* = 16778600'i32

const KEY_Armenian_ayb* = 16778593'i32

const KEY_Armenian_ben* = 16778594'i32

const KEY_Armenian_but* = 16778589'i32

const KEY_Armenian_cha* = 16778617'i32

const KEY_Armenian_da* = 16778596'i32

const KEY_Armenian_dza* = 16778609'i32

const KEY_Armenian_e* = 16778599'i32

const KEY_Armenian_exclam* = 16778588'i32

const KEY_Armenian_fe* = 16778630'i32

const KEY_Armenian_full_stop* = 16778633'i32

const KEY_Armenian_ghat* = 16778610'i32

const KEY_Armenian_gim* = 16778595'i32

const KEY_Armenian_hi* = 16778613'i32

const KEY_Armenian_ho* = 16778608'i32

const KEY_Armenian_hyphen* = 16778634'i32

const KEY_Armenian_ini* = 16778603'i32

const KEY_Armenian_je* = 16778619'i32

const KEY_Armenian_ke* = 16778628'i32

const KEY_Armenian_ken* = 16778607'i32

const KEY_Armenian_khe* = 16778605'i32

const KEY_Armenian_ligature_ew* = 16778631'i32

const KEY_Armenian_lyun* = 16778604'i32

const KEY_Armenian_men* = 16778612'i32

const KEY_Armenian_nu* = 16778614'i32

const KEY_Armenian_o* = 16778629'i32

const KEY_Armenian_paruyk* = 16778590'i32

const KEY_Armenian_pe* = 16778618'i32

const KEY_Armenian_pyur* = 16778627'i32

const KEY_Armenian_question* = 16778590'i32

const KEY_Armenian_ra* = 16778620'i32

const KEY_Armenian_re* = 16778624'i32

const KEY_Armenian_se* = 16778621'i32

const KEY_Armenian_separation_mark* = 16778589'i32

const KEY_Armenian_sha* = 16778615'i32

const KEY_Armenian_shesht* = 16778587'i32

const KEY_Armenian_tche* = 16778611'i32

const KEY_Armenian_to* = 16778601'i32

const KEY_Armenian_tsa* = 16778606'i32

const KEY_Armenian_tso* = 16778625'i32

const KEY_Armenian_tyun* = 16778623'i32

const KEY_Armenian_verjaket* = 16778633'i32

const KEY_Armenian_vev* = 16778622'i32

const KEY_Armenian_vo* = 16778616'i32

const KEY_Armenian_vyun* = 16778626'i32

const KEY_Armenian_yech* = 16778597'i32

const KEY_Armenian_yentamna* = 16778634'i32

const KEY_Armenian_za* = 16778598'i32

const KEY_Armenian_zhe* = 16778602'i32

const UKEY_Atilde* = 195'i32

const KEY_AudibleBell_Enable* = 65146'i32

const KEY_AudioCycleTrack* = 269025179'i32

const KEY_AudioForward* = 269025175'i32

const KEY_AudioLowerVolume* = 269025041'i32

const KEY_AudioMedia* = 269025074'i32

const KEY_AudioMicMute* = 269025202'i32

const KEY_AudioMute* = 269025042'i32

const KEY_AudioNext* = 269025047'i32

const KEY_AudioPause* = 269025073'i32

const KEY_AudioPlay* = 269025044'i32

const KEY_AudioPreset* = 269025206'i32

const KEY_AudioPrev* = 269025046'i32

const KEY_AudioRaiseVolume* = 269025043'i32

const KEY_AudioRandomPlay* = 269025177'i32

const KEY_AudioRecord* = 269025052'i32

const KEY_AudioRepeat* = 269025176'i32

const KEY_AudioRewind* = 269025086'i32

const KEY_AudioStop* = 269025045'i32

const KEY_Away* = 269025165'i32

const UKEY_B* = 66'i32

const UKEY_Babovedot* = 16784898'i32

const KEY_Back* = 269025062'i32

const KEY_BackForward* = 269025087'i32

const KEY_BackSpace* = 65288'i32

const KEY_Battery* = 269025171'i32

const KEY_Begin* = 65368'i32

const KEY_Blue* = 269025190'i32

const KEY_Bluetooth* = 269025172'i32

const KEY_Book* = 269025106'i32

const KEY_BounceKeys_Enable* = 65140'i32

const KEY_Break* = 65387'i32

const KEY_BrightnessAdjust* = 269025083'i32

const UKEY_Byelorussian_SHORTU* = 1726'i32

const KEY_Byelorussian_shortu* = 1710'i32

const UKEY_C* = 67'i32

const KEY_CD* = 269025107'i32

const KEY_CH6* = 65186'i32

const KEY_C_H9* = 65189'i32

const KEY_C_h8* = 65188'i32

const UKEY_Cabovedot* = 709'i32

const UKEY_Cacute* = 454'i32

const KEY_Calculator* = 269025053'i32

const KEY_Calendar* = 269025056'i32

const KEY_Cancel* = 65385'i32

const KEY_Caps_Lock* = 65509'i32

const UKEY_Ccaron* = 456'i32

const UKEY_Ccedilla* = 199'i32

const UKEY_Ccircumflex* = 710'i32

const KEY_Ch5* = 65185'i32

const KEY_Clear* = 65291'i32

const KEY_ClearGrab* = 269024801'i32

const KEY_Close* = 269025110'i32

const KEY_Codeinput* = 65335'i32

const KEY_ColonSign* = 16785569'i32

const KEY_Community* = 269025085'i32

const KEY_ContrastAdjust* = 269025058'i32

const KEY_Control_L* = 65507'i32

const KEY_Control_R* = 65508'i32

const KEY_Copy* = 269025111'i32

const KEY_CruzeiroSign* = 16785570'i32

const KEY_Cut* = 269025112'i32

const KEY_CycleAngle* = 269025180'i32

const UKEY_Cyrillic_A* = 1761'i32

const UKEY_Cyrillic_BE* = 1762'i32

const UKEY_Cyrillic_CHE* = 1790'i32

const UKEY_Cyrillic_CHE_descender* = 16778422'i32

const UKEY_Cyrillic_CHE_vertstroke* = 16778424'i32

const UKEY_Cyrillic_DE* = 1764'i32

const UKEY_Cyrillic_DZHE* = 1727'i32

const UKEY_Cyrillic_E* = 1788'i32

const UKEY_Cyrillic_EF* = 1766'i32

const UKEY_Cyrillic_EL* = 1772'i32

const UKEY_Cyrillic_EM* = 1773'i32

const UKEY_Cyrillic_EN* = 1774'i32

const UKEY_Cyrillic_EN_descender* = 16778402'i32

const UKEY_Cyrillic_ER* = 1778'i32

const UKEY_Cyrillic_ES* = 1779'i32

const UKEY_Cyrillic_GHE* = 1767'i32

const UKEY_Cyrillic_GHE_bar* = 16778386'i32

const UKEY_Cyrillic_HA* = 1768'i32

const UKEY_Cyrillic_HARDSIGN* = 1791'i32

const UKEY_Cyrillic_HA_descender* = 16778418'i32

const UKEY_Cyrillic_I* = 1769'i32

const UKEY_Cyrillic_IE* = 1765'i32

const UKEY_Cyrillic_IO* = 1715'i32

const UKEY_Cyrillic_I_macron* = 16778466'i32

const UKEY_Cyrillic_JE* = 1720'i32

const UKEY_Cyrillic_KA* = 1771'i32

const UKEY_Cyrillic_KA_descender* = 16778394'i32

const UKEY_Cyrillic_KA_vertstroke* = 16778396'i32

const UKEY_Cyrillic_LJE* = 1721'i32

const UKEY_Cyrillic_NJE* = 1722'i32

const UKEY_Cyrillic_O* = 1775'i32

const UKEY_Cyrillic_O_bar* = 16778472'i32

const UKEY_Cyrillic_PE* = 1776'i32

const UKEY_Cyrillic_SCHWA* = 16778456'i32

const UKEY_Cyrillic_SHA* = 1787'i32

const UKEY_Cyrillic_SHCHA* = 1789'i32

const UKEY_Cyrillic_SHHA* = 16778426'i32

const UKEY_Cyrillic_SHORTI* = 1770'i32

const UKEY_Cyrillic_SOFTSIGN* = 1784'i32

const UKEY_Cyrillic_TE* = 1780'i32

const UKEY_Cyrillic_TSE* = 1763'i32

const UKEY_Cyrillic_U* = 1781'i32

const UKEY_Cyrillic_U_macron* = 16778478'i32

const UKEY_Cyrillic_U_straight* = 16778414'i32

const UKEY_Cyrillic_U_straight_bar* = 16778416'i32

const UKEY_Cyrillic_VE* = 1783'i32

const UKEY_Cyrillic_YA* = 1777'i32

const UKEY_Cyrillic_YERU* = 1785'i32

const UKEY_Cyrillic_YU* = 1760'i32

const UKEY_Cyrillic_ZE* = 1786'i32

const UKEY_Cyrillic_ZHE* = 1782'i32

const UKEY_Cyrillic_ZHE_descender* = 16778390'i32

const KEY_Cyrillic_a* = 1729'i32

const KEY_Cyrillic_be* = 1730'i32

const KEY_Cyrillic_che* = 1758'i32

const KEY_Cyrillic_che_descender* = 16778423'i32

const KEY_Cyrillic_che_vertstroke* = 16778425'i32

const KEY_Cyrillic_de* = 1732'i32

const KEY_Cyrillic_dzhe* = 1711'i32

const KEY_Cyrillic_e* = 1756'i32

const KEY_Cyrillic_ef* = 1734'i32

const KEY_Cyrillic_el* = 1740'i32

const KEY_Cyrillic_em* = 1741'i32

const KEY_Cyrillic_en* = 1742'i32

const KEY_Cyrillic_en_descender* = 16778403'i32

const KEY_Cyrillic_er* = 1746'i32

const KEY_Cyrillic_es* = 1747'i32

const KEY_Cyrillic_ghe* = 1735'i32

const KEY_Cyrillic_ghe_bar* = 16778387'i32

const KEY_Cyrillic_ha* = 1736'i32

const KEY_Cyrillic_ha_descender* = 16778419'i32

const KEY_Cyrillic_hardsign* = 1759'i32

const KEY_Cyrillic_i* = 1737'i32

const KEY_Cyrillic_i_macron* = 16778467'i32

const KEY_Cyrillic_ie* = 1733'i32

const KEY_Cyrillic_io* = 1699'i32

const KEY_Cyrillic_je* = 1704'i32

const KEY_Cyrillic_ka* = 1739'i32

const KEY_Cyrillic_ka_descender* = 16778395'i32

const KEY_Cyrillic_ka_vertstroke* = 16778397'i32

const KEY_Cyrillic_lje* = 1705'i32

const KEY_Cyrillic_nje* = 1706'i32

const KEY_Cyrillic_o* = 1743'i32

const KEY_Cyrillic_o_bar* = 16778473'i32

const KEY_Cyrillic_pe* = 1744'i32

const KEY_Cyrillic_schwa* = 16778457'i32

const KEY_Cyrillic_sha* = 1755'i32

const KEY_Cyrillic_shcha* = 1757'i32

const KEY_Cyrillic_shha* = 16778427'i32

const KEY_Cyrillic_shorti* = 1738'i32

const KEY_Cyrillic_softsign* = 1752'i32

const KEY_Cyrillic_te* = 1748'i32

const KEY_Cyrillic_tse* = 1731'i32

const KEY_Cyrillic_u* = 1749'i32

const KEY_Cyrillic_u_macron* = 16778479'i32

const KEY_Cyrillic_u_straight* = 16778415'i32

const KEY_Cyrillic_u_straight_bar* = 16778417'i32

const KEY_Cyrillic_ve* = 1751'i32

const KEY_Cyrillic_ya* = 1745'i32

const KEY_Cyrillic_yeru* = 1753'i32

const KEY_Cyrillic_yu* = 1728'i32

const KEY_Cyrillic_ze* = 1754'i32

const KEY_Cyrillic_zhe* = 1750'i32

const KEY_Cyrillic_zhe_descender* = 16778391'i32

const UKEY_D* = 68'i32

const KEY_DOS* = 269025114'i32

const UKEY_Dabovedot* = 16784906'i32

const UKEY_Dcaron* = 463'i32

const KEY_Delete* = 65535'i32

const KEY_Display* = 269025113'i32

const KEY_Documents* = 269025115'i32

const KEY_DongSign* = 16785579'i32

const KEY_Down* = 65364'i32

const UKEY_Dstroke* = 464'i32

const UKEY_E* = 69'i32

const UKEY_ENG* = 957'i32

const XKEY_ETH* = 208'i32

const UKEY_EZH* = 16777655'i32

const UKEY_Eabovedot* = 972'i32

const UKEY_Eacute* = 201'i32

const UKEY_Ebelowdot* = 16785080'i32

const UKEY_Ecaron* = 460'i32

const UKEY_Ecircumflex* = 202'i32

const UKEY_Ecircumflexacute* = 16785086'i32

const UKEY_Ecircumflexbelowdot* = 16785094'i32

const UKEY_Ecircumflexgrave* = 16785088'i32

const UKEY_Ecircumflexhook* = 16785090'i32

const UKEY_Ecircumflextilde* = 16785092'i32

const KEY_EcuSign* = 16785568'i32

const UKEY_Ediaeresis* = 203'i32

const UKEY_Egrave* = 200'i32

const UKEY_Ehook* = 16785082'i32

const KEY_Eisu_Shift* = 65327'i32

const KEY_Eisu_toggle* = 65328'i32

const KEY_Eject* = 269025068'i32

const UKEY_Emacron* = 938'i32

const KEY_End* = 65367'i32

const UKEY_Eogonek* = 458'i32

const KEY_Escape* = 65307'i32

const UKEY_Eth* = 208'i32

const UKEY_Etilde* = 16785084'i32

const KEY_EuroSign* = 8364'i32

const KEY_Excel* = 269025116'i32

const KEY_Execute* = 65378'i32

const KEY_Explorer* = 269025117'i32

const UKEY_F* = 70'i32

const KEY_F1* = 65470'i32

const KEY_F10* = 65479'i32

const KEY_F11* = 65480'i32

const KEY_F12* = 65481'i32

const KEY_F13* = 65482'i32

const KEY_F14* = 65483'i32

const KEY_F15* = 65484'i32

const KEY_F16* = 65485'i32

const KEY_F17* = 65486'i32

const KEY_F18* = 65487'i32

const KEY_F19* = 65488'i32

const KEY_F2* = 65471'i32

const KEY_F20* = 65489'i32

const KEY_F21* = 65490'i32

const KEY_F22* = 65491'i32

const KEY_F23* = 65492'i32

const KEY_F24* = 65493'i32

const KEY_F25* = 65494'i32

const KEY_F26* = 65495'i32

const KEY_F27* = 65496'i32

const KEY_F28* = 65497'i32

const KEY_F29* = 65498'i32

const KEY_F3* = 65472'i32

const KEY_F30* = 65499'i32

const KEY_F31* = 65500'i32

const KEY_F32* = 65501'i32

const KEY_F33* = 65502'i32

const KEY_F34* = 65503'i32

const KEY_F35* = 65504'i32

const KEY_F4* = 65473'i32

const KEY_F5* = 65474'i32

const KEY_F6* = 65475'i32

const KEY_F7* = 65476'i32

const KEY_F8* = 65477'i32

const KEY_F9* = 65478'i32

const KEY_FFrancSign* = 16785571'i32

const UKEY_Fabovedot* = 16784926'i32

const KEY_Farsi_0* = 16778992'i32

const KEY_Farsi_1* = 16778993'i32

const KEY_Farsi_2* = 16778994'i32

const KEY_Farsi_3* = 16778995'i32

const KEY_Farsi_4* = 16778996'i32

const KEY_Farsi_5* = 16778997'i32

const KEY_Farsi_6* = 16778998'i32

const KEY_Farsi_7* = 16778999'i32

const KEY_Farsi_8* = 16779000'i32

const KEY_Farsi_9* = 16779001'i32

const KEY_Farsi_yeh* = 16778956'i32

const KEY_Favorites* = 269025072'i32

const KEY_Finance* = 269025084'i32

const KEY_Find* = 65384'i32

const KEY_First_Virtual_Screen* = 65232'i32

const KEY_Forward* = 269025063'i32

const KEY_FrameBack* = 269025181'i32

const KEY_FrameForward* = 269025182'i32

const UKEY_G* = 71'i32

const UKEY_Gabovedot* = 725'i32

const KEY_Game* = 269025118'i32

const UKEY_Gbreve* = 683'i32

const UKEY_Gcaron* = 16777702'i32

const UKEY_Gcedilla* = 939'i32

const UKEY_Gcircumflex* = 728'i32

const KEY_Georgian_an* = 16781520'i32

const KEY_Georgian_ban* = 16781521'i32

const KEY_Georgian_can* = 16781546'i32

const KEY_Georgian_char* = 16781549'i32

const KEY_Georgian_chin* = 16781545'i32

const KEY_Georgian_cil* = 16781548'i32

const KEY_Georgian_don* = 16781523'i32

const KEY_Georgian_en* = 16781524'i32

const KEY_Georgian_fi* = 16781558'i32

const KEY_Georgian_gan* = 16781522'i32

const KEY_Georgian_ghan* = 16781542'i32

const KEY_Georgian_hae* = 16781552'i32

const KEY_Georgian_har* = 16781556'i32

const KEY_Georgian_he* = 16781553'i32

const KEY_Georgian_hie* = 16781554'i32

const KEY_Georgian_hoe* = 16781557'i32

const KEY_Georgian_in* = 16781528'i32

const KEY_Georgian_jhan* = 16781551'i32

const KEY_Georgian_jil* = 16781547'i32

const KEY_Georgian_kan* = 16781529'i32

const KEY_Georgian_khar* = 16781541'i32

const KEY_Georgian_las* = 16781530'i32

const KEY_Georgian_man* = 16781531'i32

const KEY_Georgian_nar* = 16781532'i32

const KEY_Georgian_on* = 16781533'i32

const KEY_Georgian_par* = 16781534'i32

const KEY_Georgian_phar* = 16781540'i32

const KEY_Georgian_qar* = 16781543'i32

const KEY_Georgian_rae* = 16781536'i32

const KEY_Georgian_san* = 16781537'i32

const KEY_Georgian_shin* = 16781544'i32

const KEY_Georgian_tan* = 16781527'i32

const KEY_Georgian_tar* = 16781538'i32

const KEY_Georgian_un* = 16781539'i32

const KEY_Georgian_vin* = 16781525'i32

const KEY_Georgian_we* = 16781555'i32

const KEY_Georgian_xan* = 16781550'i32

const KEY_Georgian_zen* = 16781526'i32

const KEY_Georgian_zhar* = 16781535'i32

const KEY_Go* = 269025119'i32

const UKEY_Greek_ALPHA* = 1985'i32

const UKEY_Greek_ALPHAaccent* = 1953'i32

const UKEY_Greek_BETA* = 1986'i32

const UKEY_Greek_CHI* = 2007'i32

const UKEY_Greek_DELTA* = 1988'i32

const UKEY_Greek_EPSILON* = 1989'i32

const UKEY_Greek_EPSILONaccent* = 1954'i32

const UKEY_Greek_ETA* = 1991'i32

const UKEY_Greek_ETAaccent* = 1955'i32

const UKEY_Greek_GAMMA* = 1987'i32

const UKEY_Greek_IOTA* = 1993'i32

const UKEY_Greek_IOTAaccent* = 1956'i32

const KEY_Greek_IOTAdiaeresis* = 1957'i32

const UKEY_Greek_IOTAdieresis* = 1957'i32

const UKEY_Greek_KAPPA* = 1994'i32

const UKEY_Greek_LAMBDA* = 1995'i32

const UKEY_Greek_LAMDA* = 1995'i32

const UKEY_Greek_MU* = 1996'i32

const UKEY_Greek_NU* = 1997'i32

const UKEY_Greek_OMEGA* = 2009'i32

const UKEY_Greek_OMEGAaccent* = 1963'i32

const UKEY_Greek_OMICRON* = 1999'i32

const UKEY_Greek_OMICRONaccent* = 1959'i32

const UKEY_Greek_PHI* = 2006'i32

const UKEY_Greek_PI* = 2000'i32

const UKEY_Greek_PSI* = 2008'i32

const UKEY_Greek_RHO* = 2001'i32

const UKEY_Greek_SIGMA* = 2002'i32

const UKEY_Greek_TAU* = 2004'i32

const UKEY_Greek_THETA* = 1992'i32

const UKEY_Greek_UPSILON* = 2005'i32

const UKEY_Greek_UPSILONaccent* = 1960'i32

const UKEY_Greek_UPSILONdieresis* = 1961'i32

const UKEY_Greek_XI* = 1998'i32

const UKEY_Greek_ZETA* = 1990'i32

const KEY_Greek_accentdieresis* = 1966'i32

const KEY_Greek_alpha* = 2017'i32

const KEY_Greek_alphaaccent* = 1969'i32

const KEY_Greek_beta* = 2018'i32

const KEY_Greek_chi* = 2039'i32

const KEY_Greek_delta* = 2020'i32

const KEY_Greek_epsilon* = 2021'i32

const KEY_Greek_epsilonaccent* = 1970'i32

const KEY_Greek_eta* = 2023'i32

const KEY_Greek_etaaccent* = 1971'i32

const KEY_Greek_finalsmallsigma* = 2035'i32

const KEY_Greek_gamma* = 2019'i32

const KEY_Greek_horizbar* = 1967'i32

const KEY_Greek_iota* = 2025'i32

const KEY_Greek_iotaaccent* = 1972'i32

const KEY_Greek_iotaaccentdieresis* = 1974'i32

const KEY_Greek_iotadieresis* = 1973'i32

const KEY_Greek_kappa* = 2026'i32

const KEY_Greek_lambda* = 2027'i32

const KEY_Greek_lamda* = 2027'i32

const KEY_Greek_mu* = 2028'i32

const KEY_Greek_nu* = 2029'i32

const KEY_Greek_omega* = 2041'i32

const KEY_Greek_omegaaccent* = 1979'i32

const KEY_Greek_omicron* = 2031'i32

const KEY_Greek_omicronaccent* = 1975'i32

const KEY_Greek_phi* = 2038'i32

const KEY_Greek_pi* = 2032'i32

const KEY_Greek_psi* = 2040'i32

const KEY_Greek_rho* = 2033'i32

const KEY_Greek_sigma* = 2034'i32

const KEY_Greek_switch* = 65406'i32

const KEY_Greek_tau* = 2036'i32

const KEY_Greek_theta* = 2024'i32

const KEY_Greek_upsilon* = 2037'i32

const KEY_Greek_upsilonaccent* = 1976'i32

const KEY_Greek_upsilonaccentdieresis* = 1978'i32

const KEY_Greek_upsilondieresis* = 1977'i32

const KEY_Greek_xi* = 2030'i32

const KEY_Greek_zeta* = 2022'i32

const KEY_Green* = 269025188'i32

const UKEY_H* = 72'i32

const KEY_Hangul* = 65329'i32

const KEY_Hangul_A* = 3775'i32

const KEY_Hangul_AE* = 3776'i32

const KEY_Hangul_AraeA* = 3830'i32

const KEY_Hangul_AraeAE* = 3831'i32

const KEY_Hangul_Banja* = 65337'i32

const KEY_Hangul_Cieuc* = 3770'i32

const KEY_Hangul_Codeinput* = 65335'i32

const KEY_Hangul_Dikeud* = 3751'i32

const KEY_Hangul_E* = 3780'i32

const KEY_Hangul_EO* = 3779'i32

const KEY_Hangul_EU* = 3793'i32

const KEY_Hangul_End* = 65331'i32

const KEY_Hangul_Hanja* = 65332'i32

const KEY_Hangul_Hieuh* = 3774'i32

const KEY_Hangul_I* = 3795'i32

const KEY_Hangul_Ieung* = 3767'i32

const KEY_Hangul_J_Cieuc* = 3818'i32

const KEY_Hangul_J_Dikeud* = 3802'i32

const KEY_Hangul_J_Hieuh* = 3822'i32

const KEY_Hangul_J_Ieung* = 3816'i32

const KEY_Hangul_J_Jieuj* = 3817'i32

const KEY_Hangul_J_Khieuq* = 3819'i32

const KEY_Hangul_J_Kiyeog* = 3796'i32

const KEY_Hangul_J_KiyeogSios* = 3798'i32

const KEY_Hangul_J_KkogjiDalrinIeung* = 3833'i32

const KEY_Hangul_J_Mieum* = 3811'i32

const KEY_Hangul_J_Nieun* = 3799'i32

const KEY_Hangul_J_NieunHieuh* = 3801'i32

const KEY_Hangul_J_NieunJieuj* = 3800'i32

const KEY_Hangul_J_PanSios* = 3832'i32

const KEY_Hangul_J_Phieuf* = 3821'i32

const KEY_Hangul_J_Pieub* = 3812'i32

const KEY_Hangul_J_PieubSios* = 3813'i32

const KEY_Hangul_J_Rieul* = 3803'i32

const KEY_Hangul_J_RieulHieuh* = 3810'i32

const KEY_Hangul_J_RieulKiyeog* = 3804'i32

const KEY_Hangul_J_RieulMieum* = 3805'i32

const KEY_Hangul_J_RieulPhieuf* = 3809'i32

const KEY_Hangul_J_RieulPieub* = 3806'i32

const KEY_Hangul_J_RieulSios* = 3807'i32

const KEY_Hangul_J_RieulTieut* = 3808'i32

const KEY_Hangul_J_Sios* = 3814'i32

const KEY_Hangul_J_SsangKiyeog* = 3797'i32

const KEY_Hangul_J_SsangSios* = 3815'i32

const KEY_Hangul_J_Tieut* = 3820'i32

const KEY_Hangul_J_YeorinHieuh* = 3834'i32

const KEY_Hangul_Jamo* = 65333'i32

const KEY_Hangul_Jeonja* = 65336'i32

const KEY_Hangul_Jieuj* = 3768'i32

const KEY_Hangul_Khieuq* = 3771'i32

const KEY_Hangul_Kiyeog* = 3745'i32

const KEY_Hangul_KiyeogSios* = 3747'i32

const KEY_Hangul_KkogjiDalrinIeung* = 3827'i32

const KEY_Hangul_Mieum* = 3761'i32

const KEY_Hangul_MultipleCandidate* = 65341'i32

const KEY_Hangul_Nieun* = 3748'i32

const KEY_Hangul_NieunHieuh* = 3750'i32

const KEY_Hangul_NieunJieuj* = 3749'i32

const KEY_Hangul_O* = 3783'i32

const KEY_Hangul_OE* = 3786'i32

const KEY_Hangul_PanSios* = 3826'i32

const KEY_Hangul_Phieuf* = 3773'i32

const KEY_Hangul_Pieub* = 3762'i32

const KEY_Hangul_PieubSios* = 3764'i32

const KEY_Hangul_PostHanja* = 65339'i32

const KEY_Hangul_PreHanja* = 65338'i32

const KEY_Hangul_PreviousCandidate* = 65342'i32

const KEY_Hangul_Rieul* = 3753'i32

const KEY_Hangul_RieulHieuh* = 3760'i32

const KEY_Hangul_RieulKiyeog* = 3754'i32

const KEY_Hangul_RieulMieum* = 3755'i32

const KEY_Hangul_RieulPhieuf* = 3759'i32

const KEY_Hangul_RieulPieub* = 3756'i32

const KEY_Hangul_RieulSios* = 3757'i32

const KEY_Hangul_RieulTieut* = 3758'i32

const KEY_Hangul_RieulYeorinHieuh* = 3823'i32

const KEY_Hangul_Romaja* = 65334'i32

const KEY_Hangul_SingleCandidate* = 65340'i32

const KEY_Hangul_Sios* = 3765'i32

const KEY_Hangul_Special* = 65343'i32

const KEY_Hangul_SsangDikeud* = 3752'i32

const KEY_Hangul_SsangJieuj* = 3769'i32

const KEY_Hangul_SsangKiyeog* = 3746'i32

const KEY_Hangul_SsangPieub* = 3763'i32

const KEY_Hangul_SsangSios* = 3766'i32

const KEY_Hangul_Start* = 65330'i32

const KEY_Hangul_SunkyeongeumMieum* = 3824'i32

const KEY_Hangul_SunkyeongeumPhieuf* = 3828'i32

const KEY_Hangul_SunkyeongeumPieub* = 3825'i32

const KEY_Hangul_Tieut* = 3772'i32

const KEY_Hangul_U* = 3788'i32

const KEY_Hangul_WA* = 3784'i32

const KEY_Hangul_WAE* = 3785'i32

const KEY_Hangul_WE* = 3790'i32

const KEY_Hangul_WEO* = 3789'i32

const KEY_Hangul_WI* = 3791'i32

const KEY_Hangul_YA* = 3777'i32

const KEY_Hangul_YAE* = 3778'i32

const KEY_Hangul_YE* = 3782'i32

const KEY_Hangul_YEO* = 3781'i32

const KEY_Hangul_YI* = 3794'i32

const KEY_Hangul_YO* = 3787'i32

const KEY_Hangul_YU* = 3792'i32

const KEY_Hangul_YeorinHieuh* = 3829'i32

const KEY_Hangul_switch* = 65406'i32

const KEY_Hankaku* = 65321'i32

const UKEY_Hcircumflex* = 678'i32

const KEY_Hebrew_switch* = 65406'i32

const KEY_Help* = 65386'i32

const KEY_Henkan* = 65315'i32

const KEY_Henkan_Mode* = 65315'i32

const KEY_Hibernate* = 269025192'i32

const KEY_Hiragana* = 65317'i32

const KEY_Hiragana_Katakana* = 65319'i32

const KEY_History* = 269025079'i32

const KEY_Home* = 65360'i32

const KEY_HomePage* = 269025048'i32

const KEY_HotLinks* = 269025082'i32

const UKEY_Hstroke* = 673'i32

const KEY_Hyper_L* = 65517'i32

const KEY_Hyper_R* = 65518'i32

const UKEY_I* = 73'i32

const KEY_ISO_Center_Object* = 65075'i32

const KEY_ISO_Continuous_Underline* = 65072'i32

const KEY_ISO_Discontinuous_Underline* = 65073'i32

const KEY_ISO_Emphasize* = 65074'i32

const KEY_ISO_Enter* = 65076'i32

const KEY_ISO_Fast_Cursor_Down* = 65071'i32

const KEY_ISO_Fast_Cursor_Left* = 65068'i32

const KEY_ISO_Fast_Cursor_Right* = 65069'i32

const KEY_ISO_Fast_Cursor_Up* = 65070'i32

const KEY_ISO_First_Group* = 65036'i32

const KEY_ISO_First_Group_Lock* = 65037'i32

const KEY_ISO_Group_Latch* = 65030'i32

const KEY_ISO_Group_Lock* = 65031'i32

const KEY_ISO_Group_Shift* = 65406'i32

const KEY_ISO_Last_Group* = 65038'i32

const KEY_ISO_Last_Group_Lock* = 65039'i32

const KEY_ISO_Left_Tab* = 65056'i32

const KEY_ISO_Level2_Latch* = 65026'i32

const KEY_ISO_Level3_Latch* = 65028'i32

const KEY_ISO_Level3_Lock* = 65029'i32

const KEY_ISO_Level3_Shift* = 65027'i32

const KEY_ISO_Level5_Latch* = 65042'i32

const KEY_ISO_Level5_Lock* = 65043'i32

const KEY_ISO_Level5_Shift* = 65041'i32

const KEY_ISO_Lock* = 65025'i32

const KEY_ISO_Move_Line_Down* = 65058'i32

const KEY_ISO_Move_Line_Up* = 65057'i32

const KEY_ISO_Next_Group* = 65032'i32

const KEY_ISO_Next_Group_Lock* = 65033'i32

const KEY_ISO_Partial_Line_Down* = 65060'i32

const KEY_ISO_Partial_Line_Up* = 65059'i32

const KEY_ISO_Partial_Space_Left* = 65061'i32

const KEY_ISO_Partial_Space_Right* = 65062'i32

const KEY_ISO_Prev_Group* = 65034'i32

const KEY_ISO_Prev_Group_Lock* = 65035'i32

const KEY_ISO_Release_Both_Margins* = 65067'i32

const KEY_ISO_Release_Margin_Left* = 65065'i32

const KEY_ISO_Release_Margin_Right* = 65066'i32

const KEY_ISO_Set_Margin_Left* = 65063'i32

const KEY_ISO_Set_Margin_Right* = 65064'i32

const KEY_Iabovedot* = 681'i32

const UKEY_Iacute* = 205'i32

const UKEY_Ibelowdot* = 16785098'i32

const UKEY_Ibreve* = 16777516'i32

const UKEY_Icircumflex* = 206'i32

const UKEY_Idiaeresis* = 207'i32

const UKEY_Igrave* = 204'i32

const UKEY_Ihook* = 16785096'i32

const UKEY_Imacron* = 975'i32

const KEY_Insert* = 65379'i32

const UKEY_Iogonek* = 967'i32

const UKEY_Itilde* = 933'i32

const UKEY_J* = 74'i32

const UKEY_Jcircumflex* = 684'i32

const UKEY_K* = 75'i32

const KEY_KP_0* = 65456'i32

const KEY_KP_1* = 65457'i32

const KEY_KP_2* = 65458'i32

const KEY_KP_3* = 65459'i32

const KEY_KP_4* = 65460'i32

const KEY_KP_5* = 65461'i32

const KEY_KP_6* = 65462'i32

const KEY_KP_7* = 65463'i32

const KEY_KP_8* = 65464'i32

const KEY_KP_9* = 65465'i32

const KEY_KP_Add* = 65451'i32

const KEY_KP_Begin* = 65437'i32

const KEY_KP_Decimal* = 65454'i32

const KEY_KP_Delete* = 65439'i32

const KEY_KP_Divide* = 65455'i32

const KEY_KP_Down* = 65433'i32

const KEY_KP_End* = 65436'i32

const KEY_KP_Enter* = 65421'i32

const KEY_KP_Equal* = 65469'i32

const KEY_KP_F1* = 65425'i32

const KEY_KP_F2* = 65426'i32

const KEY_KP_F3* = 65427'i32

const KEY_KP_F4* = 65428'i32

const KEY_KP_Home* = 65429'i32

const KEY_KP_Insert* = 65438'i32

const KEY_KP_Left* = 65430'i32

const KEY_KP_Multiply* = 65450'i32

const KEY_KP_Next* = 65435'i32

const KEY_KP_Page_Down* = 65435'i32

const KEY_KP_Page_Up* = 65434'i32

const KEY_KP_Prior* = 65434'i32

const KEY_KP_Right* = 65432'i32

const KEY_KP_Separator* = 65452'i32

const KEY_KP_Space* = 65408'i32

const KEY_KP_Subtract* = 65453'i32

const KEY_KP_Tab* = 65417'i32

const KEY_KP_Up* = 65431'i32

const KEY_Kana_Lock* = 65325'i32

const KEY_Kana_Shift* = 65326'i32

const KEY_Kanji* = 65313'i32

const KEY_Kanji_Bangou* = 65335'i32

const KEY_Katakana* = 65318'i32

const KEY_KbdBrightnessDown* = 269025030'i32

const KEY_KbdBrightnessUp* = 269025029'i32

const KEY_KbdLightOnOff* = 269025028'i32

const UKEY_Kcedilla* = 979'i32

const KEY_Keyboard* = 269025203'i32

const KEY_Korean_Won* = 3839'i32

const UKEY_L* = 76'i32

const KEY_L1* = 65480'i32

const KEY_L10* = 65489'i32

const KEY_L2* = 65481'i32

const KEY_L3* = 65482'i32

const KEY_L4* = 65483'i32

const KEY_L5* = 65484'i32

const KEY_L6* = 65485'i32

const KEY_L7* = 65486'i32

const KEY_L8* = 65487'i32

const KEY_L9* = 65488'i32

const UKEY_Lacute* = 453'i32

const KEY_Last_Virtual_Screen* = 65236'i32

const KEY_Launch0* = 269025088'i32

const KEY_Launch1* = 269025089'i32

const KEY_Launch2* = 269025090'i32

const KEY_Launch3* = 269025091'i32

const KEY_Launch4* = 269025092'i32

const KEY_Launch5* = 269025093'i32

const KEY_Launch6* = 269025094'i32

const KEY_Launch7* = 269025095'i32

const KEY_Launch8* = 269025096'i32

const KEY_Launch9* = 269025097'i32

const KEY_LaunchA* = 269025098'i32

const KEY_LaunchB* = 269025099'i32

const KEY_LaunchC* = 269025100'i32

const KEY_LaunchD* = 269025101'i32

const KEY_LaunchE* = 269025102'i32

const KEY_LaunchF* = 269025103'i32

const UKEY_Lbelowdot* = 16784950'i32

const UKEY_Lcaron* = 421'i32

const UKEY_Lcedilla* = 934'i32

const KEY_Left* = 65361'i32

const KEY_LightBulb* = 269025077'i32

const KEY_Linefeed* = 65290'i32

const KEY_LiraSign* = 16785572'i32

const KEY_LogGrabInfo* = 269024805'i32

const KEY_LogOff* = 269025121'i32

const KEY_LogWindowTree* = 269024804'i32

const UKEY_Lstroke* = 419'i32

const UKEY_M* = 77'i32

const UKEY_Mabovedot* = 16784960'i32

const UKEY_Macedonia_DSE* = 1717'i32

const UKEY_Macedonia_GJE* = 1714'i32

const UKEY_Macedonia_KJE* = 1724'i32

const KEY_Macedonia_dse* = 1701'i32

const KEY_Macedonia_gje* = 1698'i32

const KEY_Macedonia_kje* = 1708'i32

const KEY_Mae_Koho* = 65342'i32

const KEY_Mail* = 269025049'i32

const KEY_MailForward* = 269025168'i32

const KEY_Market* = 269025122'i32

const KEY_Massyo* = 65324'i32

const KEY_Meeting* = 269025123'i32

const KEY_Memo* = 269025054'i32

const KEY_Menu* = 65383'i32

const KEY_MenuKB* = 269025125'i32

const KEY_MenuPB* = 269025126'i32

const KEY_Messenger* = 269025166'i32

const KEY_Meta_L* = 65511'i32

const KEY_Meta_R* = 65512'i32

const KEY_MillSign* = 16785573'i32

const KEY_ModeLock* = 269025025'i32

const KEY_Mode_switch* = 65406'i32

const KEY_MonBrightnessDown* = 269025027'i32

const KEY_MonBrightnessUp* = 269025026'i32

const KEY_MouseKeys_Accel_Enable* = 65143'i32

const KEY_MouseKeys_Enable* = 65142'i32

const KEY_Muhenkan* = 65314'i32

const KEY_Multi_key* = 65312'i32

const KEY_MultipleCandidate* = 65341'i32

const KEY_Music* = 269025170'i32

const KEY_MyComputer* = 269025075'i32

const KEY_MySites* = 269025127'i32

const UKEY_N* = 78'i32

const UKEY_Nacute* = 465'i32

const KEY_NairaSign* = 16785574'i32

const UKEY_Ncaron* = 466'i32

const UKEY_Ncedilla* = 977'i32

const KEY_New* = 269025128'i32

const KEY_NewSheqelSign* = 16785578'i32

const KEY_News* = 269025129'i32

const KEY_Next* = 65366'i32

const KEY_Next_VMode* = 269024802'i32

const KEY_Next_Virtual_Screen* = 65234'i32

const UKEY_Ntilde* = 209'i32

const KEY_Num_Lock* = 65407'i32

const UKEY_O* = 79'i32

const UKEY_OE* = 5052'i32

const UKEY_Oacute* = 211'i32

const UKEY_Obarred* = 16777631'i32

const UKEY_Obelowdot* = 16785100'i32

const UKEY_Ocaron* = 16777681'i32

const UKEY_Ocircumflex* = 212'i32

const UKEY_Ocircumflexacute* = 16785104'i32

const UKEY_Ocircumflexbelowdot* = 16785112'i32

const UKEY_Ocircumflexgrave* = 16785106'i32

const UKEY_Ocircumflexhook* = 16785108'i32

const UKEY_Ocircumflextilde* = 16785110'i32

const UKEY_Odiaeresis* = 214'i32

const UKEY_Odoubleacute* = 469'i32

const KEY_OfficeHome* = 269025130'i32

const UKEY_Ograve* = 210'i32

const UKEY_Ohook* = 16785102'i32

const UKEY_Ohorn* = 16777632'i32

const UKEY_Ohornacute* = 16785114'i32

const UKEY_Ohornbelowdot* = 16785122'i32

const UKEY_Ohorngrave* = 16785116'i32

const UKEY_Ohornhook* = 16785118'i32

const UKEY_Ohorntilde* = 16785120'i32

const UKEY_Omacron* = 978'i32

const UKEY_Ooblique* = 216'i32

const KEY_Open* = 269025131'i32

const KEY_OpenURL* = 269025080'i32

const KEY_Option* = 269025132'i32

const UKEY_Oslash* = 216'i32

const UKEY_Otilde* = 213'i32

const KEY_Overlay1_Enable* = 65144'i32

const KEY_Overlay2_Enable* = 65145'i32

const UKEY_P* = 80'i32

const UKEY_Pabovedot* = 16784982'i32

const KEY_Page_Down* = 65366'i32

const KEY_Page_Up* = 65365'i32

const KEY_Paste* = 269025133'i32

const KEY_Pause* = 65299'i32

const KEY_PesetaSign* = 16785575'i32

const KEY_Phone* = 269025134'i32

const KEY_Pictures* = 269025169'i32

const KEY_Pointer_Accelerate* = 65274'i32

const KEY_Pointer_Button1* = 65257'i32

const KEY_Pointer_Button2* = 65258'i32

const KEY_Pointer_Button3* = 65259'i32

const KEY_Pointer_Button4* = 65260'i32

const KEY_Pointer_Button5* = 65261'i32

const KEY_Pointer_Button_Dflt* = 65256'i32

const KEY_Pointer_DblClick1* = 65263'i32

const KEY_Pointer_DblClick2* = 65264'i32

const KEY_Pointer_DblClick3* = 65265'i32

const KEY_Pointer_DblClick4* = 65266'i32

const KEY_Pointer_DblClick5* = 65267'i32

const KEY_Pointer_DblClick_Dflt* = 65262'i32

const KEY_Pointer_DfltBtnNext* = 65275'i32

const KEY_Pointer_DfltBtnPrev* = 65276'i32

const KEY_Pointer_Down* = 65251'i32

const KEY_Pointer_DownLeft* = 65254'i32

const KEY_Pointer_DownRight* = 65255'i32

const KEY_Pointer_Drag1* = 65269'i32

const KEY_Pointer_Drag2* = 65270'i32

const KEY_Pointer_Drag3* = 65271'i32

const KEY_Pointer_Drag4* = 65272'i32

const KEY_Pointer_Drag5* = 65277'i32

const KEY_Pointer_Drag_Dflt* = 65268'i32

const KEY_Pointer_EnableKeys* = 65273'i32

const KEY_Pointer_Left* = 65248'i32

const KEY_Pointer_Right* = 65249'i32

const KEY_Pointer_Up* = 65250'i32

const KEY_Pointer_UpLeft* = 65252'i32

const KEY_Pointer_UpRight* = 65253'i32

const KEY_PowerDown* = 269025057'i32

const KEY_PowerOff* = 269025066'i32

const KEY_Prev_VMode* = 269024803'i32

const KEY_Prev_Virtual_Screen* = 65233'i32

const KEY_PreviousCandidate* = 65342'i32

const KEY_Print* = 65377'i32

const KEY_Prior* = 65365'i32

const UKEY_Q* = 81'i32

const UKEY_R* = 82'i32

const KEY_R1* = 65490'i32

const KEY_R10* = 65499'i32

const KEY_R11* = 65500'i32

const KEY_R12* = 65501'i32

const KEY_R13* = 65502'i32

const KEY_R14* = 65503'i32

const KEY_R15* = 65504'i32

const KEY_R2* = 65491'i32

const KEY_R3* = 65492'i32

const KEY_R4* = 65493'i32

const KEY_R5* = 65494'i32

const KEY_R6* = 65495'i32

const KEY_R7* = 65496'i32

const KEY_R8* = 65497'i32

const KEY_R9* = 65498'i32

const KEY_RFKill* = 269025205'i32

const UKEY_Racute* = 448'i32

const UKEY_Rcaron* = 472'i32

const UKEY_Rcedilla* = 931'i32

const KEY_Red* = 269025187'i32

const KEY_Redo* = 65382'i32

const KEY_Refresh* = 269025065'i32

const KEY_Reload* = 269025139'i32

const KEY_RepeatKeys_Enable* = 65138'i32

const KEY_Reply* = 269025138'i32

const KEY_Return* = 65293'i32

const KEY_Right* = 65363'i32

const KEY_RockerDown* = 269025060'i32

const KEY_RockerEnter* = 269025061'i32

const KEY_RockerUp* = 269025059'i32

const KEY_Romaji* = 65316'i32

const KEY_RotateWindows* = 269025140'i32

const KEY_RotationKB* = 269025142'i32

const KEY_RotationPB* = 269025141'i32

const KEY_RupeeSign* = 16785576'i32

const UKEY_S* = 83'i32

const UKEY_SCHWA* = 16777615'i32

const UKEY_Sabovedot* = 16784992'i32

const UKEY_Sacute* = 422'i32

const KEY_Save* = 269025143'i32

const UKEY_Scaron* = 425'i32

const UKEY_Scedilla* = 426'i32

const UKEY_Scircumflex* = 734'i32

const KEY_ScreenSaver* = 269025069'i32

const KEY_ScrollClick* = 269025146'i32

const KEY_ScrollDown* = 269025145'i32

const KEY_ScrollUp* = 269025144'i32

const KEY_Scroll_Lock* = 65300'i32

const KEY_Search* = 269025051'i32

const KEY_Select* = 65376'i32

const KEY_SelectButton* = 269025184'i32

const KEY_Send* = 269025147'i32

const UKEY_Serbian_DJE* = 1713'i32

const UKEY_Serbian_DZE* = 1727'i32

const UKEY_Serbian_JE* = 1720'i32

const UKEY_Serbian_LJE* = 1721'i32

const UKEY_Serbian_NJE* = 1722'i32

const UKEY_Serbian_TSHE* = 1723'i32

const KEY_Serbian_dje* = 1697'i32

const KEY_Serbian_dze* = 1711'i32

const KEY_Serbian_je* = 1704'i32

const KEY_Serbian_lje* = 1705'i32

const KEY_Serbian_nje* = 1706'i32

const KEY_Serbian_tshe* = 1707'i32

const KEY_Shift_L* = 65505'i32

const KEY_Shift_Lock* = 65510'i32

const KEY_Shift_R* = 65506'i32

const KEY_Shop* = 269025078'i32

const KEY_SingleCandidate* = 65340'i32

const KEY_Sinh_a* = 16780677'i32

const KEY_Sinh_aa* = 16780678'i32

const KEY_Sinh_aa2* = 16780751'i32

const KEY_Sinh_ae* = 16780679'i32

const KEY_Sinh_ae2* = 16780752'i32

const KEY_Sinh_aee* = 16780680'i32

const KEY_Sinh_aee2* = 16780753'i32

const KEY_Sinh_ai* = 16780691'i32

const KEY_Sinh_ai2* = 16780763'i32

const KEY_Sinh_al* = 16780746'i32

const KEY_Sinh_au* = 16780694'i32

const KEY_Sinh_au2* = 16780766'i32

const KEY_Sinh_ba* = 16780726'i32

const KEY_Sinh_bha* = 16780727'i32

const KEY_Sinh_ca* = 16780704'i32

const KEY_Sinh_cha* = 16780705'i32

const KEY_Sinh_dda* = 16780713'i32

const KEY_Sinh_ddha* = 16780714'i32

const KEY_Sinh_dha* = 16780719'i32

const KEY_Sinh_dhha* = 16780720'i32

const KEY_Sinh_e* = 16780689'i32

const KEY_Sinh_e2* = 16780761'i32

const KEY_Sinh_ee* = 16780690'i32

const KEY_Sinh_ee2* = 16780762'i32

const KEY_Sinh_fa* = 16780742'i32

const KEY_Sinh_ga* = 16780700'i32

const KEY_Sinh_gha* = 16780701'i32

const KEY_Sinh_h2* = 16780675'i32

const KEY_Sinh_ha* = 16780740'i32

const KEY_Sinh_i* = 16780681'i32

const KEY_Sinh_i2* = 16780754'i32

const KEY_Sinh_ii* = 16780682'i32

const KEY_Sinh_ii2* = 16780755'i32

const KEY_Sinh_ja* = 16780706'i32

const KEY_Sinh_jha* = 16780707'i32

const KEY_Sinh_jnya* = 16780709'i32

const KEY_Sinh_ka* = 16780698'i32

const KEY_Sinh_kha* = 16780699'i32

const KEY_Sinh_kunddaliya* = 16780788'i32

const KEY_Sinh_la* = 16780733'i32

const KEY_Sinh_lla* = 16780741'i32

const KEY_Sinh_lu* = 16780687'i32

const KEY_Sinh_lu2* = 16780767'i32

const KEY_Sinh_luu* = 16780688'i32

const KEY_Sinh_luu2* = 16780787'i32

const KEY_Sinh_ma* = 16780728'i32

const KEY_Sinh_mba* = 16780729'i32

const KEY_Sinh_na* = 16780721'i32

const KEY_Sinh_ndda* = 16780716'i32

const KEY_Sinh_ndha* = 16780723'i32

const KEY_Sinh_ng* = 16780674'i32

const KEY_Sinh_ng2* = 16780702'i32

const KEY_Sinh_nga* = 16780703'i32

const KEY_Sinh_nja* = 16780710'i32

const KEY_Sinh_nna* = 16780715'i32

const KEY_Sinh_nya* = 16780708'i32

const KEY_Sinh_o* = 16780692'i32

const KEY_Sinh_o2* = 16780764'i32

const KEY_Sinh_oo* = 16780693'i32

const KEY_Sinh_oo2* = 16780765'i32

const KEY_Sinh_pa* = 16780724'i32

const KEY_Sinh_pha* = 16780725'i32

const KEY_Sinh_ra* = 16780731'i32

const KEY_Sinh_ri* = 16780685'i32

const KEY_Sinh_rii* = 16780686'i32

const KEY_Sinh_ru2* = 16780760'i32

const KEY_Sinh_ruu2* = 16780786'i32

const KEY_Sinh_sa* = 16780739'i32

const KEY_Sinh_sha* = 16780737'i32

const KEY_Sinh_ssha* = 16780738'i32

const KEY_Sinh_tha* = 16780717'i32

const KEY_Sinh_thha* = 16780718'i32

const KEY_Sinh_tta* = 16780711'i32

const KEY_Sinh_ttha* = 16780712'i32

const KEY_Sinh_u* = 16780683'i32

const KEY_Sinh_u2* = 16780756'i32

const KEY_Sinh_uu* = 16780684'i32

const KEY_Sinh_uu2* = 16780758'i32

const KEY_Sinh_va* = 16780736'i32

const KEY_Sinh_ya* = 16780730'i32

const KEY_Sleep* = 269025071'i32

const KEY_SlowKeys_Enable* = 65139'i32

const KEY_Spell* = 269025148'i32

const KEY_SplitScreen* = 269025149'i32

const KEY_Standby* = 269025040'i32

const KEY_Start* = 269025050'i32

const KEY_StickyKeys_Enable* = 65141'i32

const KEY_Stop* = 269025064'i32

const KEY_Subtitle* = 269025178'i32

const KEY_Super_L* = 65515'i32

const KEY_Super_R* = 65516'i32

const KEY_Support* = 269025150'i32

const KEY_Suspend* = 269025191'i32

const KEY_Switch_VT_1* = 269024769'i32

const KEY_Switch_VT_10* = 269024778'i32

const KEY_Switch_VT_11* = 269024779'i32

const KEY_Switch_VT_12* = 269024780'i32

const KEY_Switch_VT_2* = 269024770'i32

const KEY_Switch_VT_3* = 269024771'i32

const KEY_Switch_VT_4* = 269024772'i32

const KEY_Switch_VT_5* = 269024773'i32

const KEY_Switch_VT_6* = 269024774'i32

const KEY_Switch_VT_7* = 269024775'i32

const KEY_Switch_VT_8* = 269024776'i32

const KEY_Switch_VT_9* = 269024777'i32

const KEY_Sys_Req* = 65301'i32

const UKEY_T* = 84'i32

const XKEY_THORN* = 222'i32

const KEY_Tab* = 65289'i32

const UKEY_Tabovedot* = 16785002'i32

const KEY_TaskPane* = 269025151'i32

const UKEY_Tcaron* = 427'i32

const UKEY_Tcedilla* = 478'i32

const KEY_Terminal* = 269025152'i32

const KEY_Terminate_Server* = 65237'i32

const KEY_Thai_baht* = 3551'i32

const KEY_Thai_bobaimai* = 3514'i32

const KEY_Thai_chochan* = 3496'i32

const KEY_Thai_chochang* = 3498'i32

const KEY_Thai_choching* = 3497'i32

const KEY_Thai_chochoe* = 3500'i32

const KEY_Thai_dochada* = 3502'i32

const KEY_Thai_dodek* = 3508'i32

const KEY_Thai_fofa* = 3517'i32

const KEY_Thai_fofan* = 3519'i32

const KEY_Thai_hohip* = 3531'i32

const KEY_Thai_honokhuk* = 3534'i32

const KEY_Thai_khokhai* = 3490'i32

const KEY_Thai_khokhon* = 3493'i32

const KEY_Thai_khokhuat* = 3491'i32

const KEY_Thai_khokhwai* = 3492'i32

const KEY_Thai_khorakhang* = 3494'i32

const KEY_Thai_kokai* = 3489'i32

const KEY_Thai_lakkhangyao* = 3557'i32

const KEY_Thai_lekchet* = 3575'i32

const KEY_Thai_lekha* = 3573'i32

const KEY_Thai_lekhok* = 3574'i32

const KEY_Thai_lekkao* = 3577'i32

const KEY_Thai_leknung* = 3569'i32

const KEY_Thai_lekpaet* = 3576'i32

const KEY_Thai_leksam* = 3571'i32

const KEY_Thai_leksi* = 3572'i32

const KEY_Thai_leksong* = 3570'i32

const KEY_Thai_leksun* = 3568'i32

const KEY_Thai_lochula* = 3532'i32

const KEY_Thai_loling* = 3525'i32

const KEY_Thai_lu* = 3526'i32

const KEY_Thai_maichattawa* = 3563'i32

const KEY_Thai_maiek* = 3560'i32

const KEY_Thai_maihanakat* = 3537'i32

const KEY_Thai_maihanakat_maitho* = 3550'i32

const KEY_Thai_maitaikhu* = 3559'i32

const KEY_Thai_maitho* = 3561'i32

const KEY_Thai_maitri* = 3562'i32

const KEY_Thai_maiyamok* = 3558'i32

const KEY_Thai_moma* = 3521'i32

const KEY_Thai_ngongu* = 3495'i32

const KEY_Thai_nikhahit* = 3565'i32

const KEY_Thai_nonen* = 3507'i32

const KEY_Thai_nonu* = 3513'i32

const KEY_Thai_oang* = 3533'i32

const KEY_Thai_paiyannoi* = 3535'i32

const KEY_Thai_phinthu* = 3546'i32

const KEY_Thai_phophan* = 3518'i32

const KEY_Thai_phophung* = 3516'i32

const KEY_Thai_phosamphao* = 3520'i32

const KEY_Thai_popla* = 3515'i32

const KEY_Thai_rorua* = 3523'i32

const KEY_Thai_ru* = 3524'i32

const KEY_Thai_saraa* = 3536'i32

const KEY_Thai_saraaa* = 3538'i32

const KEY_Thai_saraae* = 3553'i32

const KEY_Thai_saraaimaimalai* = 3556'i32

const KEY_Thai_saraaimaimuan* = 3555'i32

const KEY_Thai_saraam* = 3539'i32

const KEY_Thai_sarae* = 3552'i32

const KEY_Thai_sarai* = 3540'i32

const KEY_Thai_saraii* = 3541'i32

const KEY_Thai_sarao* = 3554'i32

const KEY_Thai_sarau* = 3544'i32

const KEY_Thai_saraue* = 3542'i32

const KEY_Thai_sarauee* = 3543'i32

const KEY_Thai_sarauu* = 3545'i32

const KEY_Thai_sorusi* = 3529'i32

const KEY_Thai_sosala* = 3528'i32

const KEY_Thai_soso* = 3499'i32

const KEY_Thai_sosua* = 3530'i32

const KEY_Thai_thanthakhat* = 3564'i32

const KEY_Thai_thonangmontho* = 3505'i32

const KEY_Thai_thophuthao* = 3506'i32

const KEY_Thai_thothahan* = 3511'i32

const KEY_Thai_thothan* = 3504'i32

const KEY_Thai_thothong* = 3512'i32

const KEY_Thai_thothung* = 3510'i32

const KEY_Thai_topatak* = 3503'i32

const KEY_Thai_totao* = 3509'i32

const KEY_Thai_wowaen* = 3527'i32

const KEY_Thai_yoyak* = 3522'i32

const KEY_Thai_yoying* = 3501'i32

const UKEY_Thorn* = 222'i32

const KEY_Time* = 269025183'i32

const KEY_ToDoList* = 269025055'i32

const KEY_Tools* = 269025153'i32

const KEY_TopMenu* = 269025186'i32

const KEY_TouchpadOff* = 269025201'i32

const KEY_TouchpadOn* = 269025200'i32

const KEY_TouchpadToggle* = 269025193'i32

const KEY_Touroku* = 65323'i32

const KEY_Travel* = 269025154'i32

const UKEY_Tslash* = 940'i32

const UKEY_U* = 85'i32

const KEY_UWB* = 269025174'i32

const UKEY_Uacute* = 218'i32

const UKEY_Ubelowdot* = 16785124'i32

const UKEY_Ubreve* = 733'i32

const UKEY_Ucircumflex* = 219'i32

const UKEY_Udiaeresis* = 220'i32

const UKEY_Udoubleacute* = 475'i32

const UKEY_Ugrave* = 217'i32

const UKEY_Uhook* = 16785126'i32

const UKEY_Uhorn* = 16777647'i32

const UKEY_Uhornacute* = 16785128'i32

const UKEY_Uhornbelowdot* = 16785136'i32

const UKEY_Uhorngrave* = 16785130'i32

const UKEY_Uhornhook* = 16785132'i32

const UKEY_Uhorntilde* = 16785134'i32

const UKEY_Ukrainian_GHE_WITH_UPTURN* = 1725'i32

const UKEY_Ukrainian_I* = 1718'i32

const UKEY_Ukrainian_IE* = 1716'i32

const UKEY_Ukrainian_YI* = 1719'i32

const KEY_Ukrainian_ghe_with_upturn* = 1709'i32

const KEY_Ukrainian_i* = 1702'i32

const KEY_Ukrainian_ie* = 1700'i32

const KEY_Ukrainian_yi* = 1703'i32

const UKEY_Ukranian_I* = 1718'i32

const UKEY_Ukranian_JE* = 1716'i32

const UKEY_Ukranian_YI* = 1719'i32

const KEY_Ukranian_i* = 1702'i32

const KEY_Ukranian_je* = 1700'i32

const KEY_Ukranian_yi* = 1703'i32

const UKEY_Umacron* = 990'i32

const KEY_Undo* = 65381'i32

const KEY_Ungrab* = 269024800'i32

const UKEY_Uogonek* = 985'i32

const KEY_Up* = 65362'i32

const UKEY_Uring* = 473'i32

const KEY_User1KB* = 269025157'i32

const KEY_User2KB* = 269025158'i32

const KEY_UserPB* = 269025156'i32

const UKEY_Utilde* = 989'i32

const UKEY_V* = 86'i32

const KEY_VendorHome* = 269025076'i32

const KEY_Video* = 269025159'i32

const KEY_View* = 269025185'i32

const KEY_VoidSymbol* = 16777215'i32

const UKEY_W* = 87'i32

const KEY_WLAN* = 269025173'i32

const KEY_WWAN* = 269025204'i32

const KEY_WWW* = 269025070'i32

const UKEY_Wacute* = 16785026'i32

const KEY_WakeUp* = 269025067'i32

const UKEY_Wcircumflex* = 16777588'i32

const UKEY_Wdiaeresis* = 16785028'i32

const KEY_WebCam* = 269025167'i32

const UKEY_Wgrave* = 16785024'i32

const KEY_WheelButton* = 269025160'i32

const KEY_WindowClear* = 269025109'i32

const KEY_WonSign* = 16785577'i32

const KEY_Word* = 269025161'i32

const UKEY_X* = 88'i32

const UKEY_Xabovedot* = 16785034'i32

const KEY_Xfer* = 269025162'i32

const UKEY_Y* = 89'i32

const UKEY_Yacute* = 221'i32

const UKEY_Ybelowdot* = 16785140'i32

const UKEY_Ycircumflex* = 16777590'i32

const UKEY_Ydiaeresis* = 5054'i32

const KEY_Yellow* = 269025189'i32

const UKEY_Ygrave* = 16785138'i32

const UKEY_Yhook* = 16785142'i32

const UKEY_Ytilde* = 16785144'i32

const UKEY_Z* = 90'i32

const UKEY_Zabovedot* = 431'i32

const UKEY_Zacute* = 428'i32

const UKEY_Zcaron* = 430'i32

const KEY_Zen_Koho* = 65341'i32

const KEY_Zenkaku* = 65320'i32

const KEY_Zenkaku_Hankaku* = 65322'i32

const KEY_ZoomIn* = 269025163'i32

const KEY_ZoomOut* = 269025164'i32

const UKEY_Zstroke* = 16777653'i32

const KEY_a* = 97'i32

const KEY_aacute* = 225'i32

const KEY_abelowdot* = 16785057'i32

const KEY_abovedot* = 511'i32

const KEY_abreve* = 483'i32

const KEY_abreveacute* = 16785071'i32

const KEY_abrevebelowdot* = 16785079'i32

const KEY_abrevegrave* = 16785073'i32

const KEY_abrevehook* = 16785075'i32

const KEY_abrevetilde* = 16785077'i32

const KEY_acircumflex* = 226'i32

const KEY_acircumflexacute* = 16785061'i32

const KEY_acircumflexbelowdot* = 16785069'i32

const KEY_acircumflexgrave* = 16785063'i32

const KEY_acircumflexhook* = 16785065'i32

const KEY_acircumflextilde* = 16785067'i32

const KEY_acute* = 180'i32

const KEY_adiaeresis* = 228'i32

const KEY_ae* = 230'i32

const KEY_agrave* = 224'i32

const KEY_ahook* = 16785059'i32

const KEY_amacron* = 992'i32

const KEY_ampersand* = 38'i32

const KEY_aogonek* = 433'i32

const KEY_apostrophe* = 39'i32

const KEY_approxeq* = 16785992'i32

const KEY_approximate* = 2248'i32

const KEY_aring* = 229'i32

const KEY_asciicircum* = 94'i32

const KEY_asciitilde* = 126'i32

const KEY_asterisk* = 42'i32

const KEY_at* = 64'i32

const KEY_atilde* = 227'i32

const KEY_b* = 98'i32

const KEY_babovedot* = 16784899'i32

const KEY_backslash* = 92'i32

const KEY_ballotcross* = 2804'i32

const KEY_bar* = 124'i32

const KEY_because* = 16785973'i32

const KEY_blank* = 2527'i32

const KEY_botintegral* = 2213'i32

const KEY_botleftparens* = 2220'i32

const KEY_botleftsqbracket* = 2216'i32

const KEY_botleftsummation* = 2226'i32

const KEY_botrightparens* = 2222'i32

const KEY_botrightsqbracket* = 2218'i32

const KEY_botrightsummation* = 2230'i32

const KEY_bott* = 2550'i32

const KEY_botvertsummationconnector* = 2228'i32

const KEY_braceleft* = 123'i32

const KEY_braceright* = 125'i32

const KEY_bracketleft* = 91'i32

const KEY_bracketright* = 93'i32

const KEY_braille_blank* = 16787456'i32

const KEY_braille_dot_1* = 65521'i32

const KEY_braille_dot_10* = 65530'i32

const KEY_braille_dot_2* = 65522'i32

const KEY_braille_dot_3* = 65523'i32

const KEY_braille_dot_4* = 65524'i32

const KEY_braille_dot_5* = 65525'i32

const KEY_braille_dot_6* = 65526'i32

const KEY_braille_dot_7* = 65527'i32

const KEY_braille_dot_8* = 65528'i32

const KEY_braille_dot_9* = 65529'i32

const KEY_braille_dots_1* = 16787457'i32

const KEY_braille_dots_12* = 16787459'i32

const KEY_braille_dots_123* = 16787463'i32

const KEY_braille_dots_1234* = 16787471'i32

const KEY_braille_dots_12345* = 16787487'i32

const KEY_braille_dots_123456* = 16787519'i32

const KEY_braille_dots_1234567* = 16787583'i32

const KEY_braille_dots_12345678* = 16787711'i32

const KEY_braille_dots_1234568* = 16787647'i32

const KEY_braille_dots_123457* = 16787551'i32

const KEY_braille_dots_1234578* = 16787679'i32

const KEY_braille_dots_123458* = 16787615'i32

const KEY_braille_dots_12346* = 16787503'i32

const KEY_braille_dots_123467* = 16787567'i32

const KEY_braille_dots_1234678* = 16787695'i32

const KEY_braille_dots_123468* = 16787631'i32

const KEY_braille_dots_12347* = 16787535'i32

const KEY_braille_dots_123478* = 16787663'i32

const KEY_braille_dots_12348* = 16787599'i32

const KEY_braille_dots_1235* = 16787479'i32

const KEY_braille_dots_12356* = 16787511'i32

const KEY_braille_dots_123567* = 16787575'i32

const KEY_braille_dots_1235678* = 16787703'i32

const KEY_braille_dots_123568* = 16787639'i32

const KEY_braille_dots_12357* = 16787543'i32

const KEY_braille_dots_123578* = 16787671'i32

const KEY_braille_dots_12358* = 16787607'i32

const KEY_braille_dots_1236* = 16787495'i32

const KEY_braille_dots_12367* = 16787559'i32

const KEY_braille_dots_123678* = 16787687'i32

const KEY_braille_dots_12368* = 16787623'i32

const KEY_braille_dots_1237* = 16787527'i32

const KEY_braille_dots_12378* = 16787655'i32

const KEY_braille_dots_1238* = 16787591'i32

const KEY_braille_dots_124* = 16787467'i32

const KEY_braille_dots_1245* = 16787483'i32

const KEY_braille_dots_12456* = 16787515'i32

const KEY_braille_dots_124567* = 16787579'i32

const KEY_braille_dots_1245678* = 16787707'i32

const KEY_braille_dots_124568* = 16787643'i32

const KEY_braille_dots_12457* = 16787547'i32

const KEY_braille_dots_124578* = 16787675'i32

const KEY_braille_dots_12458* = 16787611'i32

const KEY_braille_dots_1246* = 16787499'i32

const KEY_braille_dots_12467* = 16787563'i32

const KEY_braille_dots_124678* = 16787691'i32

const KEY_braille_dots_12468* = 16787627'i32

const KEY_braille_dots_1247* = 16787531'i32

const KEY_braille_dots_12478* = 16787659'i32

const KEY_braille_dots_1248* = 16787595'i32

const KEY_braille_dots_125* = 16787475'i32

const KEY_braille_dots_1256* = 16787507'i32

const KEY_braille_dots_12567* = 16787571'i32

const KEY_braille_dots_125678* = 16787699'i32

const KEY_braille_dots_12568* = 16787635'i32

const KEY_braille_dots_1257* = 16787539'i32

const KEY_braille_dots_12578* = 16787667'i32

const KEY_braille_dots_1258* = 16787603'i32

const KEY_braille_dots_126* = 16787491'i32

const KEY_braille_dots_1267* = 16787555'i32

const KEY_braille_dots_12678* = 16787683'i32

const KEY_braille_dots_1268* = 16787619'i32

const KEY_braille_dots_127* = 16787523'i32

const KEY_braille_dots_1278* = 16787651'i32

const KEY_braille_dots_128* = 16787587'i32

const KEY_braille_dots_13* = 16787461'i32

const KEY_braille_dots_134* = 16787469'i32

const KEY_braille_dots_1345* = 16787485'i32

const KEY_braille_dots_13456* = 16787517'i32

const KEY_braille_dots_134567* = 16787581'i32

const KEY_braille_dots_1345678* = 16787709'i32

const KEY_braille_dots_134568* = 16787645'i32

const KEY_braille_dots_13457* = 16787549'i32

const KEY_braille_dots_134578* = 16787677'i32

const KEY_braille_dots_13458* = 16787613'i32

const KEY_braille_dots_1346* = 16787501'i32

const KEY_braille_dots_13467* = 16787565'i32

const KEY_braille_dots_134678* = 16787693'i32

const KEY_braille_dots_13468* = 16787629'i32

const KEY_braille_dots_1347* = 16787533'i32

const KEY_braille_dots_13478* = 16787661'i32

const KEY_braille_dots_1348* = 16787597'i32

const KEY_braille_dots_135* = 16787477'i32

const KEY_braille_dots_1356* = 16787509'i32

const KEY_braille_dots_13567* = 16787573'i32

const KEY_braille_dots_135678* = 16787701'i32

const KEY_braille_dots_13568* = 16787637'i32

const KEY_braille_dots_1357* = 16787541'i32

const KEY_braille_dots_13578* = 16787669'i32

const KEY_braille_dots_1358* = 16787605'i32

const KEY_braille_dots_136* = 16787493'i32

const KEY_braille_dots_1367* = 16787557'i32

const KEY_braille_dots_13678* = 16787685'i32

const KEY_braille_dots_1368* = 16787621'i32

const KEY_braille_dots_137* = 16787525'i32

const KEY_braille_dots_1378* = 16787653'i32

const KEY_braille_dots_138* = 16787589'i32

const KEY_braille_dots_14* = 16787465'i32

const KEY_braille_dots_145* = 16787481'i32

const KEY_braille_dots_1456* = 16787513'i32

const KEY_braille_dots_14567* = 16787577'i32

const KEY_braille_dots_145678* = 16787705'i32

const KEY_braille_dots_14568* = 16787641'i32

const KEY_braille_dots_1457* = 16787545'i32

const KEY_braille_dots_14578* = 16787673'i32

const KEY_braille_dots_1458* = 16787609'i32

const KEY_braille_dots_146* = 16787497'i32

const KEY_braille_dots_1467* = 16787561'i32

const KEY_braille_dots_14678* = 16787689'i32

const KEY_braille_dots_1468* = 16787625'i32

const KEY_braille_dots_147* = 16787529'i32

const KEY_braille_dots_1478* = 16787657'i32

const KEY_braille_dots_148* = 16787593'i32

const KEY_braille_dots_15* = 16787473'i32

const KEY_braille_dots_156* = 16787505'i32

const KEY_braille_dots_1567* = 16787569'i32

const KEY_braille_dots_15678* = 16787697'i32

const KEY_braille_dots_1568* = 16787633'i32

const KEY_braille_dots_157* = 16787537'i32

const KEY_braille_dots_1578* = 16787665'i32

const KEY_braille_dots_158* = 16787601'i32

const KEY_braille_dots_16* = 16787489'i32

const KEY_braille_dots_167* = 16787553'i32

const KEY_braille_dots_1678* = 16787681'i32

const KEY_braille_dots_168* = 16787617'i32

const KEY_braille_dots_17* = 16787521'i32

const KEY_braille_dots_178* = 16787649'i32

const KEY_braille_dots_18* = 16787585'i32

const KEY_braille_dots_2* = 16787458'i32

const KEY_braille_dots_23* = 16787462'i32

const KEY_braille_dots_234* = 16787470'i32

const KEY_braille_dots_2345* = 16787486'i32

const KEY_braille_dots_23456* = 16787518'i32

const KEY_braille_dots_234567* = 16787582'i32

const KEY_braille_dots_2345678* = 16787710'i32

const KEY_braille_dots_234568* = 16787646'i32

const KEY_braille_dots_23457* = 16787550'i32

const KEY_braille_dots_234578* = 16787678'i32

const KEY_braille_dots_23458* = 16787614'i32

const KEY_braille_dots_2346* = 16787502'i32

const KEY_braille_dots_23467* = 16787566'i32

const KEY_braille_dots_234678* = 16787694'i32

const KEY_braille_dots_23468* = 16787630'i32

const KEY_braille_dots_2347* = 16787534'i32

const KEY_braille_dots_23478* = 16787662'i32

const KEY_braille_dots_2348* = 16787598'i32

const KEY_braille_dots_235* = 16787478'i32

const KEY_braille_dots_2356* = 16787510'i32

const KEY_braille_dots_23567* = 16787574'i32

const KEY_braille_dots_235678* = 16787702'i32

const KEY_braille_dots_23568* = 16787638'i32

const KEY_braille_dots_2357* = 16787542'i32

const KEY_braille_dots_23578* = 16787670'i32

const KEY_braille_dots_2358* = 16787606'i32

const KEY_braille_dots_236* = 16787494'i32

const KEY_braille_dots_2367* = 16787558'i32

const KEY_braille_dots_23678* = 16787686'i32

const KEY_braille_dots_2368* = 16787622'i32

const KEY_braille_dots_237* = 16787526'i32

const KEY_braille_dots_2378* = 16787654'i32

const KEY_braille_dots_238* = 16787590'i32

const KEY_braille_dots_24* = 16787466'i32

const KEY_braille_dots_245* = 16787482'i32

const KEY_braille_dots_2456* = 16787514'i32

const KEY_braille_dots_24567* = 16787578'i32

const KEY_braille_dots_245678* = 16787706'i32

const KEY_braille_dots_24568* = 16787642'i32

const KEY_braille_dots_2457* = 16787546'i32

const KEY_braille_dots_24578* = 16787674'i32

const KEY_braille_dots_2458* = 16787610'i32

const KEY_braille_dots_246* = 16787498'i32

const KEY_braille_dots_2467* = 16787562'i32

const KEY_braille_dots_24678* = 16787690'i32

const KEY_braille_dots_2468* = 16787626'i32

const KEY_braille_dots_247* = 16787530'i32

const KEY_braille_dots_2478* = 16787658'i32

const KEY_braille_dots_248* = 16787594'i32

const KEY_braille_dots_25* = 16787474'i32

const KEY_braille_dots_256* = 16787506'i32

const KEY_braille_dots_2567* = 16787570'i32

const KEY_braille_dots_25678* = 16787698'i32

const KEY_braille_dots_2568* = 16787634'i32

const KEY_braille_dots_257* = 16787538'i32

const KEY_braille_dots_2578* = 16787666'i32

const KEY_braille_dots_258* = 16787602'i32

const KEY_braille_dots_26* = 16787490'i32

const KEY_braille_dots_267* = 16787554'i32

const KEY_braille_dots_2678* = 16787682'i32

const KEY_braille_dots_268* = 16787618'i32

const KEY_braille_dots_27* = 16787522'i32

const KEY_braille_dots_278* = 16787650'i32

const KEY_braille_dots_28* = 16787586'i32

const KEY_braille_dots_3* = 16787460'i32

const KEY_braille_dots_34* = 16787468'i32

const KEY_braille_dots_345* = 16787484'i32

const KEY_braille_dots_3456* = 16787516'i32

const KEY_braille_dots_34567* = 16787580'i32

const KEY_braille_dots_345678* = 16787708'i32

const KEY_braille_dots_34568* = 16787644'i32

const KEY_braille_dots_3457* = 16787548'i32

const KEY_braille_dots_34578* = 16787676'i32

const KEY_braille_dots_3458* = 16787612'i32

const KEY_braille_dots_346* = 16787500'i32

const KEY_braille_dots_3467* = 16787564'i32

const KEY_braille_dots_34678* = 16787692'i32

const KEY_braille_dots_3468* = 16787628'i32

const KEY_braille_dots_347* = 16787532'i32

const KEY_braille_dots_3478* = 16787660'i32

const KEY_braille_dots_348* = 16787596'i32

const KEY_braille_dots_35* = 16787476'i32

const KEY_braille_dots_356* = 16787508'i32

const KEY_braille_dots_3567* = 16787572'i32

const KEY_braille_dots_35678* = 16787700'i32

const KEY_braille_dots_3568* = 16787636'i32

const KEY_braille_dots_357* = 16787540'i32

const KEY_braille_dots_3578* = 16787668'i32

const KEY_braille_dots_358* = 16787604'i32

const KEY_braille_dots_36* = 16787492'i32

const KEY_braille_dots_367* = 16787556'i32

const KEY_braille_dots_3678* = 16787684'i32

const KEY_braille_dots_368* = 16787620'i32

const KEY_braille_dots_37* = 16787524'i32

const KEY_braille_dots_378* = 16787652'i32

const KEY_braille_dots_38* = 16787588'i32

const KEY_braille_dots_4* = 16787464'i32

const KEY_braille_dots_45* = 16787480'i32

const KEY_braille_dots_456* = 16787512'i32

const KEY_braille_dots_4567* = 16787576'i32

const KEY_braille_dots_45678* = 16787704'i32

const KEY_braille_dots_4568* = 16787640'i32

const KEY_braille_dots_457* = 16787544'i32

const KEY_braille_dots_4578* = 16787672'i32

const KEY_braille_dots_458* = 16787608'i32

const KEY_braille_dots_46* = 16787496'i32

const KEY_braille_dots_467* = 16787560'i32

const KEY_braille_dots_4678* = 16787688'i32

const KEY_braille_dots_468* = 16787624'i32

const KEY_braille_dots_47* = 16787528'i32

const KEY_braille_dots_478* = 16787656'i32

const KEY_braille_dots_48* = 16787592'i32

const KEY_braille_dots_5* = 16787472'i32

const KEY_braille_dots_56* = 16787504'i32

const KEY_braille_dots_567* = 16787568'i32

const KEY_braille_dots_5678* = 16787696'i32

const KEY_braille_dots_568* = 16787632'i32

const KEY_braille_dots_57* = 16787536'i32

const KEY_braille_dots_578* = 16787664'i32

const KEY_braille_dots_58* = 16787600'i32

const KEY_braille_dots_6* = 16787488'i32

const KEY_braille_dots_67* = 16787552'i32

const KEY_braille_dots_678* = 16787680'i32

const KEY_braille_dots_68* = 16787616'i32

const KEY_braille_dots_7* = 16787520'i32

const KEY_braille_dots_78* = 16787648'i32

const KEY_braille_dots_8* = 16787584'i32

const KEY_breve* = 418'i32

const KEY_brokenbar* = 166'i32

const KEY_c* = 99'i32

const KEY_cH7* = 65187'i32

const KEY_cabovedot* = 741'i32

const KEY_cacute* = 486'i32

const KEY_careof* = 2744'i32

const KEY_caret* = 2812'i32

const KEY_caron* = 439'i32

const KEY_ccaron* = 488'i32

const KEY_ccedilla* = 231'i32

const KEY_ccircumflex* = 742'i32

const KEY_cedilla* = 184'i32

const KEY_cent* = 162'i32

const KEY_ch4* = 65184'i32

const KEY_checkerboard* = 2529'i32

const KEY_checkmark* = 2803'i32

const KEY_circle* = 3023'i32

const KEY_club* = 2796'i32

const KEY_colon* = 58'i32

const KEY_comma* = 44'i32

const KEY_containsas* = 16785931'i32

const KEY_copyright* = 169'i32

const KEY_cr* = 2532'i32

const KEY_crossinglines* = 2542'i32

const KEY_cuberoot* = 16785947'i32

const KEY_currency* = 164'i32

const KEY_cursor* = 2815'i32

const KEY_d* = 100'i32

const KEY_dabovedot* = 16784907'i32

const KEY_dagger* = 2801'i32

const KEY_dcaron* = 495'i32

const UKEY_dead_A* = 65153'i32

const UKEY_dead_E* = 65155'i32

const UKEY_dead_I* = 65157'i32

const UKEY_dead_O* = 65159'i32

const UKEY_dead_U* = 65161'i32

const KEY_dead_a* = 65152'i32

const KEY_dead_abovecomma* = 65124'i32

const KEY_dead_abovedot* = 65110'i32

const KEY_dead_abovereversedcomma* = 65125'i32

const KEY_dead_abovering* = 65112'i32

const KEY_dead_aboveverticalline* = 65169'i32

const KEY_dead_acute* = 65105'i32

const KEY_dead_belowbreve* = 65131'i32

const KEY_dead_belowcircumflex* = 65129'i32

const KEY_dead_belowcomma* = 65134'i32

const KEY_dead_belowdiaeresis* = 65132'i32

const KEY_dead_belowdot* = 65120'i32

const KEY_dead_belowmacron* = 65128'i32

const KEY_dead_belowring* = 65127'i32

const KEY_dead_belowtilde* = 65130'i32

const KEY_dead_belowverticalline* = 65170'i32

const KEY_dead_breve* = 65109'i32

const KEY_dead_capital_schwa* = 65163'i32

const KEY_dead_caron* = 65114'i32

const KEY_dead_cedilla* = 65115'i32

const KEY_dead_circumflex* = 65106'i32

const KEY_dead_currency* = 65135'i32

const KEY_dead_dasia* = 65125'i32

const KEY_dead_diaeresis* = 65111'i32

const KEY_dead_doubleacute* = 65113'i32

const KEY_dead_doublegrave* = 65126'i32

const KEY_dead_e* = 65154'i32

const KEY_dead_grave* = 65104'i32

const KEY_dead_greek* = 65164'i32

const KEY_dead_hook* = 65121'i32

const KEY_dead_horn* = 65122'i32

const KEY_dead_i* = 65156'i32

const KEY_dead_invertedbreve* = 65133'i32

const KEY_dead_iota* = 65117'i32

const KEY_dead_longsolidusoverlay* = 65171'i32

const KEY_dead_lowline* = 65168'i32

const KEY_dead_macron* = 65108'i32

const KEY_dead_o* = 65158'i32

const KEY_dead_ogonek* = 65116'i32

const KEY_dead_perispomeni* = 65107'i32

const KEY_dead_psili* = 65124'i32

const KEY_dead_semivoiced_sound* = 65119'i32

const KEY_dead_small_schwa* = 65162'i32

const KEY_dead_stroke* = 65123'i32

const KEY_dead_tilde* = 65107'i32

const KEY_dead_u* = 65160'i32

const KEY_dead_voiced_sound* = 65118'i32

const KEY_decimalpoint* = 2749'i32

const KEY_degree* = 176'i32

const KEY_diaeresis* = 168'i32

const KEY_diamond* = 2797'i32

const KEY_digitspace* = 2725'i32

const KEY_dintegral* = 16785964'i32

const KEY_division* = 247'i32

const KEY_dollar* = 36'i32

const KEY_doubbaselinedot* = 2735'i32

const KEY_doubleacute* = 445'i32

const KEY_doubledagger* = 2802'i32

const KEY_doublelowquotemark* = 2814'i32

const KEY_downarrow* = 2302'i32

const KEY_downcaret* = 2984'i32

const KEY_downshoe* = 3030'i32

const KEY_downstile* = 3012'i32

const KEY_downtack* = 3010'i32

const KEY_dstroke* = 496'i32

const KEY_e* = 101'i32

const KEY_eabovedot* = 1004'i32

const KEY_eacute* = 233'i32

const KEY_ebelowdot* = 16785081'i32

const KEY_ecaron* = 492'i32

const KEY_ecircumflex* = 234'i32

const KEY_ecircumflexacute* = 16785087'i32

const KEY_ecircumflexbelowdot* = 16785095'i32

const KEY_ecircumflexgrave* = 16785089'i32

const KEY_ecircumflexhook* = 16785091'i32

const KEY_ecircumflextilde* = 16785093'i32

const KEY_ediaeresis* = 235'i32

const KEY_egrave* = 232'i32

const KEY_ehook* = 16785083'i32

const KEY_eightsubscript* = 16785544'i32

const KEY_eightsuperior* = 16785528'i32

const KEY_elementof* = 16785928'i32

const KEY_ellipsis* = 2734'i32

const KEY_em3space* = 2723'i32

const KEY_em4space* = 2724'i32

const KEY_emacron* = 954'i32

const KEY_emdash* = 2729'i32

const KEY_emfilledcircle* = 2782'i32

const KEY_emfilledrect* = 2783'i32

const KEY_emopencircle* = 2766'i32

const KEY_emopenrectangle* = 2767'i32

const KEY_emptyset* = 16785925'i32

const KEY_emspace* = 2721'i32

const KEY_endash* = 2730'i32

const KEY_enfilledcircbullet* = 2790'i32

const KEY_enfilledsqbullet* = 2791'i32

const KEY_eng* = 959'i32

const KEY_enopencircbullet* = 2784'i32

const KEY_enopensquarebullet* = 2785'i32

const KEY_enspace* = 2722'i32

const KEY_eogonek* = 490'i32

const KEY_equal* = 61'i32

const KEY_eth* = 240'i32

const KEY_etilde* = 16785085'i32

const KEY_exclam* = 33'i32

const KEY_exclamdown* = 161'i32

const KEY_ezh* = 16777874'i32

const KEY_f* = 102'i32

const KEY_fabovedot* = 16784927'i32

const KEY_femalesymbol* = 2808'i32

const KEY_ff* = 2531'i32

const KEY_figdash* = 2747'i32

const KEY_filledlefttribullet* = 2780'i32

const KEY_filledrectbullet* = 2779'i32

const KEY_filledrighttribullet* = 2781'i32

const KEY_filledtribulletdown* = 2793'i32

const KEY_filledtribulletup* = 2792'i32

const KEY_fiveeighths* = 2757'i32

const KEY_fivesixths* = 2743'i32

const KEY_fivesubscript* = 16785541'i32

const KEY_fivesuperior* = 16785525'i32

const KEY_fourfifths* = 2741'i32

const KEY_foursubscript* = 16785540'i32

const KEY_foursuperior* = 16785524'i32

const KEY_fourthroot* = 16785948'i32

const KEY_function* = 2294'i32

const KEY_g* = 103'i32

const KEY_gabovedot* = 757'i32

const KEY_gbreve* = 699'i32

const KEY_gcaron* = 16777703'i32

const KEY_gcedilla* = 955'i32

const KEY_gcircumflex* = 760'i32

const KEY_grave* = 96'i32

const KEY_greater* = 62'i32

const KEY_greaterthanequal* = 2238'i32

const KEY_guillemotleft* = 171'i32

const KEY_guillemotright* = 187'i32

const KEY_h* = 104'i32

const KEY_hairspace* = 2728'i32

const KEY_hcircumflex* = 694'i32

const KEY_heart* = 2798'i32

const KEY_hebrew_aleph* = 3296'i32

const KEY_hebrew_ayin* = 3314'i32

const KEY_hebrew_bet* = 3297'i32

const KEY_hebrew_beth* = 3297'i32

const KEY_hebrew_chet* = 3303'i32

const KEY_hebrew_dalet* = 3299'i32

const KEY_hebrew_daleth* = 3299'i32

const KEY_hebrew_doublelowline* = 3295'i32

const KEY_hebrew_finalkaph* = 3306'i32

const KEY_hebrew_finalmem* = 3309'i32

const KEY_hebrew_finalnun* = 3311'i32

const KEY_hebrew_finalpe* = 3315'i32

const KEY_hebrew_finalzade* = 3317'i32

const KEY_hebrew_finalzadi* = 3317'i32

const KEY_hebrew_gimel* = 3298'i32

const KEY_hebrew_gimmel* = 3298'i32

const KEY_hebrew_he* = 3300'i32

const KEY_hebrew_het* = 3303'i32

const KEY_hebrew_kaph* = 3307'i32

const KEY_hebrew_kuf* = 3319'i32

const KEY_hebrew_lamed* = 3308'i32

const KEY_hebrew_mem* = 3310'i32

const KEY_hebrew_nun* = 3312'i32

const KEY_hebrew_pe* = 3316'i32

const KEY_hebrew_qoph* = 3319'i32

const KEY_hebrew_resh* = 3320'i32

const KEY_hebrew_samech* = 3313'i32

const KEY_hebrew_samekh* = 3313'i32

const KEY_hebrew_shin* = 3321'i32

const KEY_hebrew_taf* = 3322'i32

const KEY_hebrew_taw* = 3322'i32

const KEY_hebrew_tet* = 3304'i32

const KEY_hebrew_teth* = 3304'i32

const KEY_hebrew_waw* = 3301'i32

const KEY_hebrew_yod* = 3305'i32

const KEY_hebrew_zade* = 3318'i32

const KEY_hebrew_zadi* = 3318'i32

const KEY_hebrew_zain* = 3302'i32

const KEY_hebrew_zayin* = 3302'i32

const KEY_hexagram* = 2778'i32

const KEY_horizconnector* = 2211'i32

const KEY_horizlinescan1* = 2543'i32

const KEY_horizlinescan3* = 2544'i32

const KEY_horizlinescan5* = 2545'i32

const KEY_horizlinescan7* = 2546'i32

const KEY_horizlinescan9* = 2547'i32

const KEY_hstroke* = 689'i32

const KEY_ht* = 2530'i32

const KEY_hyphen* = 173'i32

const KEY_i* = 105'i32

const KEY_iTouch* = 269025120'i32

const KEY_iacute* = 237'i32

const KEY_ibelowdot* = 16785099'i32

const KEY_ibreve* = 16777517'i32

const KEY_icircumflex* = 238'i32

const KEY_identical* = 2255'i32

const KEY_idiaeresis* = 239'i32

const KEY_idotless* = 697'i32

const KEY_ifonlyif* = 2253'i32

const KEY_igrave* = 236'i32

const KEY_ihook* = 16785097'i32

const KEY_imacron* = 1007'i32

const KEY_implies* = 2254'i32

const KEY_includedin* = 2266'i32

const KEY_includes* = 2267'i32

const KEY_infinity* = 2242'i32

const KEY_integral* = 2239'i32

const KEY_intersection* = 2268'i32

const KEY_iogonek* = 999'i32

const KEY_itilde* = 949'i32

const KEY_j* = 106'i32

const KEY_jcircumflex* = 700'i32

const KEY_jot* = 3018'i32

const KEY_k* = 107'i32

const UKEY_kana_A* = 1201'i32

const KEY_kana_CHI* = 1217'i32

const UKEY_kana_E* = 1204'i32

const KEY_kana_FU* = 1228'i32

const KEY_kana_HA* = 1226'i32

const KEY_kana_HE* = 1229'i32

const KEY_kana_HI* = 1227'i32

const KEY_kana_HO* = 1230'i32

const KEY_kana_HU* = 1228'i32

const UKEY_kana_I* = 1202'i32

const KEY_kana_KA* = 1206'i32

const KEY_kana_KE* = 1209'i32

const KEY_kana_KI* = 1207'i32

const KEY_kana_KO* = 1210'i32

const KEY_kana_KU* = 1208'i32

const KEY_kana_MA* = 1231'i32

const KEY_kana_ME* = 1234'i32

const KEY_kana_MI* = 1232'i32

const KEY_kana_MO* = 1235'i32

const KEY_kana_MU* = 1233'i32

const KEY_kana_N* = 1245'i32

const KEY_kana_NA* = 1221'i32

const KEY_kana_NE* = 1224'i32

const KEY_kana_NI* = 1222'i32

const KEY_kana_NO* = 1225'i32

const KEY_kana_NU* = 1223'i32

const UKEY_kana_O* = 1205'i32

const KEY_kana_RA* = 1239'i32

const KEY_kana_RE* = 1242'i32

const KEY_kana_RI* = 1240'i32

const KEY_kana_RO* = 1243'i32

const KEY_kana_RU* = 1241'i32

const KEY_kana_SA* = 1211'i32

const KEY_kana_SE* = 1214'i32

const KEY_kana_SHI* = 1212'i32

const KEY_kana_SO* = 1215'i32

const KEY_kana_SU* = 1213'i32

const KEY_kana_TA* = 1216'i32

const KEY_kana_TE* = 1219'i32

const KEY_kana_TI* = 1217'i32

const KEY_kana_TO* = 1220'i32

const UKEY_kana_TSU* = 1218'i32

const UKEY_kana_TU* = 1218'i32

const UKEY_kana_U* = 1203'i32

const KEY_kana_WA* = 1244'i32

const KEY_kana_WO* = 1190'i32

const UKEY_kana_YA* = 1236'i32

const UKEY_kana_YO* = 1238'i32

const UKEY_kana_YU* = 1237'i32

const KEY_kana_a* = 1191'i32

const KEY_kana_closingbracket* = 1187'i32

const KEY_kana_comma* = 1188'i32

const KEY_kana_conjunctive* = 1189'i32

const KEY_kana_e* = 1194'i32

const KEY_kana_fullstop* = 1185'i32

const KEY_kana_i* = 1192'i32

const KEY_kana_middledot* = 1189'i32

const KEY_kana_o* = 1195'i32

const KEY_kana_openingbracket* = 1186'i32

const KEY_kana_switch* = 65406'i32

const KEY_kana_tsu* = 1199'i32

const KEY_kana_tu* = 1199'i32

const KEY_kana_u* = 1193'i32

const KEY_kana_ya* = 1196'i32

const KEY_kana_yo* = 1198'i32

const KEY_kana_yu* = 1197'i32

const KEY_kappa* = 930'i32

const KEY_kcedilla* = 1011'i32

const KEY_kra* = 930'i32

const KEY_l* = 108'i32

const KEY_lacute* = 485'i32

const KEY_latincross* = 2777'i32

const KEY_lbelowdot* = 16784951'i32

const KEY_lcaron* = 437'i32

const KEY_lcedilla* = 950'i32

const KEY_leftanglebracket* = 2748'i32

const KEY_leftarrow* = 2299'i32

const KEY_leftcaret* = 2979'i32

const KEY_leftdoublequotemark* = 2770'i32

const KEY_leftmiddlecurlybrace* = 2223'i32

const KEY_leftopentriangle* = 2764'i32

const KEY_leftpointer* = 2794'i32

const KEY_leftradical* = 2209'i32

const KEY_leftshoe* = 3034'i32

const KEY_leftsinglequotemark* = 2768'i32

const KEY_leftt* = 2548'i32

const KEY_lefttack* = 3036'i32

const KEY_less* = 60'i32

const KEY_lessthanequal* = 2236'i32

const KEY_lf* = 2533'i32

const KEY_logicaland* = 2270'i32

const KEY_logicalor* = 2271'i32

const KEY_lowleftcorner* = 2541'i32

const KEY_lowrightcorner* = 2538'i32

const KEY_lstroke* = 435'i32

const KEY_m* = 109'i32

const KEY_mabovedot* = 16784961'i32

const KEY_macron* = 175'i32

const KEY_malesymbol* = 2807'i32

const KEY_maltesecross* = 2800'i32

const KEY_marker* = 2751'i32

const KEY_masculine* = 186'i32

const KEY_minus* = 45'i32

const KEY_minutes* = 2774'i32

const KEY_mu* = 181'i32

const KEY_multiply* = 215'i32

const KEY_musicalflat* = 2806'i32

const KEY_musicalsharp* = 2805'i32

const KEY_n* = 110'i32

const KEY_nabla* = 2245'i32

const KEY_nacute* = 497'i32

const KEY_ncaron* = 498'i32

const KEY_ncedilla* = 1009'i32

const KEY_ninesubscript* = 16785545'i32

const KEY_ninesuperior* = 16785529'i32

const KEY_nl* = 2536'i32

const KEY_nobreakspace* = 160'i32

const KEY_notapproxeq* = 16785991'i32

const KEY_notelementof* = 16785929'i32

const KEY_notequal* = 2237'i32

const KEY_notidentical* = 16786018'i32

const KEY_notsign* = 172'i32

const KEY_ntilde* = 241'i32

const KEY_numbersign* = 35'i32

const KEY_numerosign* = 1712'i32

const KEY_o* = 111'i32

const KEY_oacute* = 243'i32

const KEY_obarred* = 16777845'i32

const KEY_obelowdot* = 16785101'i32

const KEY_ocaron* = 16777682'i32

const KEY_ocircumflex* = 244'i32

const KEY_ocircumflexacute* = 16785105'i32

const KEY_ocircumflexbelowdot* = 16785113'i32

const KEY_ocircumflexgrave* = 16785107'i32

const KEY_ocircumflexhook* = 16785109'i32

const KEY_ocircumflextilde* = 16785111'i32

const KEY_odiaeresis* = 246'i32

const KEY_odoubleacute* = 501'i32

const KEY_oe* = 5053'i32

const KEY_ogonek* = 434'i32

const KEY_ograve* = 242'i32

const KEY_ohook* = 16785103'i32

const KEY_ohorn* = 16777633'i32

const KEY_ohornacute* = 16785115'i32

const KEY_ohornbelowdot* = 16785123'i32

const KEY_ohorngrave* = 16785117'i32

const KEY_ohornhook* = 16785119'i32

const KEY_ohorntilde* = 16785121'i32

const KEY_omacron* = 1010'i32

const KEY_oneeighth* = 2755'i32

const KEY_onefifth* = 2738'i32

const KEY_onehalf* = 189'i32

const KEY_onequarter* = 188'i32

const KEY_onesixth* = 2742'i32

const KEY_onesubscript* = 16785537'i32

const KEY_onesuperior* = 185'i32

const KEY_onethird* = 2736'i32

const KEY_ooblique* = 248'i32

const KEY_openrectbullet* = 2786'i32

const KEY_openstar* = 2789'i32

const KEY_opentribulletdown* = 2788'i32

const KEY_opentribulletup* = 2787'i32

const KEY_ordfeminine* = 170'i32

const KEY_oslash* = 248'i32

const KEY_otilde* = 245'i32

const KEY_overbar* = 3008'i32

const KEY_overline* = 1150'i32

const KEY_p* = 112'i32

const KEY_pabovedot* = 16784983'i32

const KEY_paragraph* = 182'i32

const KEY_parenleft* = 40'i32

const KEY_parenright* = 41'i32

const KEY_partdifferential* = 16785922'i32

const KEY_partialderivative* = 2287'i32

const KEY_percent* = 37'i32

const KEY_period* = 46'i32

const KEY_periodcentered* = 183'i32

const KEY_permille* = 2773'i32

const KEY_phonographcopyright* = 2811'i32

const KEY_plus* = 43'i32

const KEY_plusminus* = 177'i32

const KEY_prescription* = 2772'i32

const KEY_prolongedsound* = 1200'i32

const KEY_punctspace* = 2726'i32

const KEY_q* = 113'i32

const KEY_quad* = 3020'i32

const KEY_question* = 63'i32

const KEY_questiondown* = 191'i32

const KEY_quotedbl* = 34'i32

const KEY_quoteleft* = 96'i32

const KEY_quoteright* = 39'i32

const KEY_r* = 114'i32

const KEY_racute* = 480'i32

const KEY_radical* = 2262'i32

const KEY_rcaron* = 504'i32

const KEY_rcedilla* = 947'i32

const KEY_registered* = 174'i32

const KEY_rightanglebracket* = 2750'i32

const KEY_rightarrow* = 2301'i32

const KEY_rightcaret* = 2982'i32

const KEY_rightdoublequotemark* = 2771'i32

const KEY_rightmiddlecurlybrace* = 2224'i32

const KEY_rightmiddlesummation* = 2231'i32

const KEY_rightopentriangle* = 2765'i32

const KEY_rightpointer* = 2795'i32

const KEY_rightshoe* = 3032'i32

const KEY_rightsinglequotemark* = 2769'i32

const KEY_rightt* = 2549'i32

const KEY_righttack* = 3068'i32

const KEY_s* = 115'i32

const KEY_sabovedot* = 16784993'i32

const KEY_sacute* = 438'i32

const KEY_scaron* = 441'i32

const KEY_scedilla* = 442'i32

const KEY_schwa* = 16777817'i32

const KEY_scircumflex* = 766'i32

const KEY_script_switch* = 65406'i32

const KEY_seconds* = 2775'i32

const KEY_section* = 167'i32

const KEY_semicolon* = 59'i32

const KEY_semivoicedsound* = 1247'i32

const KEY_seveneighths* = 2758'i32

const KEY_sevensubscript* = 16785543'i32

const KEY_sevensuperior* = 16785527'i32

const KEY_signaturemark* = 2762'i32

const KEY_signifblank* = 2732'i32

const KEY_similarequal* = 2249'i32

const KEY_singlelowquotemark* = 2813'i32

const KEY_sixsubscript* = 16785542'i32

const KEY_sixsuperior* = 16785526'i32

const KEY_slash* = 47'i32

const KEY_soliddiamond* = 2528'i32

const KEY_space* = 32'i32

const KEY_squareroot* = 16785946'i32

const KEY_ssharp* = 223'i32

const KEY_sterling* = 163'i32

const KEY_stricteq* = 16786019'i32

const KEY_t* = 116'i32

const KEY_tabovedot* = 16785003'i32

const KEY_tcaron* = 443'i32

const KEY_tcedilla* = 510'i32

const KEY_telephone* = 2809'i32

const KEY_telephonerecorder* = 2810'i32

const KEY_therefore* = 2240'i32

const KEY_thinspace* = 2727'i32

const KEY_thorn* = 254'i32

const KEY_threeeighths* = 2756'i32

const KEY_threefifths* = 2740'i32

const KEY_threequarters* = 190'i32

const KEY_threesubscript* = 16785539'i32

const KEY_threesuperior* = 179'i32

const KEY_tintegral* = 16785965'i32

const KEY_topintegral* = 2212'i32

const KEY_topleftparens* = 2219'i32

const KEY_topleftradical* = 2210'i32

const KEY_topleftsqbracket* = 2215'i32

const KEY_topleftsummation* = 2225'i32

const KEY_toprightparens* = 2221'i32

const KEY_toprightsqbracket* = 2217'i32

const KEY_toprightsummation* = 2229'i32

const KEY_topt* = 2551'i32

const KEY_topvertsummationconnector* = 2227'i32

const KEY_trademark* = 2761'i32

const KEY_trademarkincircle* = 2763'i32

const KEY_tslash* = 956'i32

const KEY_twofifths* = 2739'i32

const KEY_twosubscript* = 16785538'i32

const KEY_twosuperior* = 178'i32

const KEY_twothirds* = 2737'i32

const KEY_u* = 117'i32

const KEY_uacute* = 250'i32

const KEY_ubelowdot* = 16785125'i32

const KEY_ubreve* = 765'i32

const KEY_ucircumflex* = 251'i32

const KEY_udiaeresis* = 252'i32

const KEY_udoubleacute* = 507'i32

const KEY_ugrave* = 249'i32

const KEY_uhook* = 16785127'i32

const KEY_uhorn* = 16777648'i32

const KEY_uhornacute* = 16785129'i32

const KEY_uhornbelowdot* = 16785137'i32

const KEY_uhorngrave* = 16785131'i32

const KEY_uhornhook* = 16785133'i32

const KEY_uhorntilde* = 16785135'i32

const KEY_umacron* = 1022'i32

const KEY_underbar* = 3014'i32

const KEY_underscore* = 95'i32

const KEY_union* = 2269'i32

const KEY_uogonek* = 1017'i32

const KEY_uparrow* = 2300'i32

const KEY_upcaret* = 2985'i32

const KEY_upleftcorner* = 2540'i32

const KEY_uprightcorner* = 2539'i32

const KEY_upshoe* = 3011'i32

const KEY_upstile* = 3027'i32

const KEY_uptack* = 3022'i32

const KEY_uring* = 505'i32

const KEY_utilde* = 1021'i32

const KEY_v* = 118'i32

const KEY_variation* = 2241'i32

const KEY_vertbar* = 2552'i32

const KEY_vertconnector* = 2214'i32

const KEY_voicedsound* = 1246'i32

const KEY_vt* = 2537'i32

const KEY_w* = 119'i32

const KEY_wacute* = 16785027'i32

const KEY_wcircumflex* = 16777589'i32

const KEY_wdiaeresis* = 16785029'i32

const KEY_wgrave* = 16785025'i32

const KEY_x* = 120'i32

const KEY_xabovedot* = 16785035'i32

const KEY_y* = 121'i32

const KEY_yacute* = 253'i32

const KEY_ybelowdot* = 16785141'i32

const KEY_ycircumflex* = 16777591'i32

const KEY_ydiaeresis* = 255'i32

const KEY_yen* = 165'i32

const KEY_ygrave* = 16785139'i32

const KEY_yhook* = 16785143'i32

const KEY_ytilde* = 16785145'i32

const KEY_z* = 122'i32

const KEY_zabovedot* = 447'i32

const KEY_zacute* = 444'i32

const KEY_zcaron* = 446'i32

const KEY_zerosubscript* = 16785536'i32

const KEY_zerosuperior* = 16785520'i32

const KEY_zstroke* = 16777654'i32

type
  KeyEvent* = ref object of Event
  KeyEvent00* = object of Event00

proc gdk_key_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr KeyEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: KeyEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(KeyEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

proc gdk_key_event_get_consumed_modifiers(self: ptr KeyEvent00): ModifierType {.
    importc, libprag.}

proc getConsumedModifiers*(self: KeyEvent): ModifierType =
  gdk_key_event_get_consumed_modifiers(cast[ptr KeyEvent00](self.impl))

proc consumedModifiers*(self: KeyEvent): ModifierType =
  gdk_key_event_get_consumed_modifiers(cast[ptr KeyEvent00](self.impl))

proc gdk_key_event_get_keycode(self: ptr KeyEvent00): uint32 {.
    importc, libprag.}

proc getKeycode*(self: KeyEvent): int =
  int(gdk_key_event_get_keycode(cast[ptr KeyEvent00](self.impl)))

proc keycode*(self: KeyEvent): int =
  int(gdk_key_event_get_keycode(cast[ptr KeyEvent00](self.impl)))

proc gdk_key_event_get_keyval(self: ptr KeyEvent00): uint32 {.
    importc, libprag.}

proc getKeyval*(self: KeyEvent): int =
  int(gdk_key_event_get_keyval(cast[ptr KeyEvent00](self.impl)))

proc keyval*(self: KeyEvent): int =
  int(gdk_key_event_get_keyval(cast[ptr KeyEvent00](self.impl)))

proc gdk_key_event_get_layout(self: ptr KeyEvent00): uint32 {.
    importc, libprag.}

proc getLayout*(self: KeyEvent): int =
  int(gdk_key_event_get_layout(cast[ptr KeyEvent00](self.impl)))

proc layout*(self: KeyEvent): int =
  int(gdk_key_event_get_layout(cast[ptr KeyEvent00](self.impl)))

proc gdk_key_event_get_level(self: ptr KeyEvent00): uint32 {.
    importc, libprag.}

proc getLevel*(self: KeyEvent): int =
  int(gdk_key_event_get_level(cast[ptr KeyEvent00](self.impl)))

proc level*(self: KeyEvent): int =
  int(gdk_key_event_get_level(cast[ptr KeyEvent00](self.impl)))

proc gdk_key_event_get_match(self: ptr KeyEvent00; keyval: var uint32; modifiers: var ModifierType): gboolean {.
    importc, libprag.}

proc getMatch*(self: KeyEvent; keyval: var int; modifiers: var ModifierType): bool =
  var keyval_00: uint32
  result = toBool(gdk_key_event_get_match(cast[ptr KeyEvent00](self.impl), keyval_00, modifiers))
  if keyval.addr != nil:
    keyval = int(keyval_00)

proc gdk_key_event_is_modifier(self: ptr KeyEvent00): gboolean {.
    importc, libprag.}

proc isModifier*(self: KeyEvent): bool =
  toBool(gdk_key_event_is_modifier(cast[ptr KeyEvent00](self.impl)))

type
  KeyMatch* {.size: sizeof(cint), pure.} = enum
    none = 0
    partial = 1
    exact = 2

proc gdk_key_event_matches(self: ptr KeyEvent00; keyval: uint32; modifiers: ModifierType): KeyMatch {.
    importc, libprag.}

proc matches*(self: KeyEvent; keyval: int; modifiers: ModifierType): KeyMatch =
  gdk_key_event_matches(cast[ptr KeyEvent00](self.impl), uint32(keyval), modifiers)


type
  MemoryTexture* = ref object of Texture
  MemoryTexture00* = object of Texture00

proc gdk_memory_texture_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MemoryTexture()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_memory_texture_new(width: int32; height: int32; format: MemoryFormat;
    bytes: ptr glib.Bytes00; stride: uint64): ptr MemoryTexture00 {.
    importc, libprag.}

proc newMemoryTexture*(width: int; height: int; format: MemoryFormat;
    bytes: glib.Bytes; stride: uint64): MemoryTexture =
  let gobj = gdk_memory_texture_new(int32(width), int32(height), format, cast[ptr glib.Bytes00](bytes.impl), stride)
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

proc newMemoryTexture*(tdesc: typedesc; width: int; height: int; format: MemoryFormat;
    bytes: glib.Bytes; stride: uint64): tdesc =
  assert(result is MemoryTexture)
  let gobj = gdk_memory_texture_new(int32(width), int32(height), format, cast[ptr glib.Bytes00](bytes.impl), stride)
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

proc initMemoryTexture*[T](result: var T; width: int; height: int; format: MemoryFormat;
    bytes: glib.Bytes; stride: uint64) {.deprecated.} =
  assert(result is MemoryTexture)
  let gobj = gdk_memory_texture_new(int32(width), int32(height), format, cast[ptr glib.Bytes00](bytes.impl), stride)
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

type
  MotionEvent* = ref object of Event
  MotionEvent00* = object of Event00

proc gdk_motion_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr MotionEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: MotionEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MotionEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

const PRIORITY_REDRAW* = 120'i32

type
  PadEvent* = ref object of Event
  PadEvent00* = object of Event00

proc gdk_pad_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr PadEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: PadEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PadEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

proc gdk_pad_event_get_axis_value(self: ptr PadEvent00; index: var uint32;
    value: var cdouble) {.
    importc, libprag.}

proc getAxisValue*(self: PadEvent; index: var int; value: var cdouble) =
  var index_00: uint32
  gdk_pad_event_get_axis_value(cast[ptr PadEvent00](self.impl), index_00, value)
  if index.addr != nil:
    index = int(index_00)

proc gdk_pad_event_get_button(self: ptr PadEvent00): uint32 {.
    importc, libprag.}

proc getButton*(self: PadEvent): int =
  int(gdk_pad_event_get_button(cast[ptr PadEvent00](self.impl)))

proc button*(self: PadEvent): int =
  int(gdk_pad_event_get_button(cast[ptr PadEvent00](self.impl)))

proc gdk_pad_event_get_group_mode(self: ptr PadEvent00; group: var uint32;
    mode: var uint32) {.
    importc, libprag.}

proc getGroupMode*(self: PadEvent; group: var int; mode: var int) =
  var group_00: uint32
  var mode_00: uint32
  gdk_pad_event_get_group_mode(cast[ptr PadEvent00](self.impl), group_00, mode_00)
  if group.addr != nil:
    group = int(group_00)
  if mode.addr != nil:
    mode = int(mode_00)

type
  Paintable00* = object of gobject.Object00
  Paintable* = ref object of gobject.Object

proc scInvalidateContents*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "invalidate-contents", cast[GCallback](p), xdata, nil, cf)

proc scInvalidateSize*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "invalidate-size", cast[GCallback](p), xdata, nil, cf)

proc gdk_paintable_new_empty(intrinsicWidth: int32; intrinsicHeight: int32): ptr Paintable00 {.
    importc, libprag.}

proc newPaintableEmpty*(intrinsicWidth: int; intrinsicHeight: int): Paintable =
  let gobj = gdk_paintable_new_empty(int32(intrinsicWidth), int32(intrinsicHeight))
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

proc gdk_paintable_compute_concrete_size(self: ptr Paintable00; specifiedWidth: cdouble;
    specifiedHeight: cdouble; defaultWidth: cdouble; defaultHeight: cdouble;
    concreteWidth: var cdouble; concreteHeight: var cdouble) {.
    importc, libprag.}

proc computeConcreteSize*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture;
    specifiedWidth: cdouble; specifiedHeight: cdouble; defaultWidth: cdouble;
    defaultHeight: cdouble; concreteWidth: var cdouble; concreteHeight: var cdouble) =
  gdk_paintable_compute_concrete_size(cast[ptr Paintable00](self.impl), specifiedWidth, specifiedHeight, defaultWidth, defaultHeight, concreteWidth, concreteHeight)

proc gdk_paintable_get_current_image(self: ptr Paintable00): ptr Paintable00 {.
    importc, libprag.}

proc getCurrentImage*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture): Paintable =
  let gobj = gdk_paintable_get_current_image(cast[ptr Paintable00](self.impl))
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

proc currentImage*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture): Paintable =
  let gobj = gdk_paintable_get_current_image(cast[ptr Paintable00](self.impl))
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

proc gdk_paintable_get_intrinsic_aspect_ratio(self: ptr Paintable00): cdouble {.
    importc, libprag.}

proc getIntrinsicAspectRatio*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture): cdouble =
  gdk_paintable_get_intrinsic_aspect_ratio(cast[ptr Paintable00](self.impl))

proc intrinsicAspectRatio*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture): cdouble =
  gdk_paintable_get_intrinsic_aspect_ratio(cast[ptr Paintable00](self.impl))

proc gdk_paintable_get_intrinsic_height(self: ptr Paintable00): int32 {.
    importc, libprag.}

proc getIntrinsicHeight*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture): int =
  int(gdk_paintable_get_intrinsic_height(cast[ptr Paintable00](self.impl)))

proc intrinsicHeight*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture): int =
  int(gdk_paintable_get_intrinsic_height(cast[ptr Paintable00](self.impl)))

proc gdk_paintable_get_intrinsic_width(self: ptr Paintable00): int32 {.
    importc, libprag.}

proc getIntrinsicWidth*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture): int =
  int(gdk_paintable_get_intrinsic_width(cast[ptr Paintable00](self.impl)))

proc intrinsicWidth*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture): int =
  int(gdk_paintable_get_intrinsic_width(cast[ptr Paintable00](self.impl)))

proc gdk_paintable_invalidate_contents(self: ptr Paintable00) {.
    importc, libprag.}

proc invalidateContents*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture) =
  gdk_paintable_invalidate_contents(cast[ptr Paintable00](self.impl))

proc gdk_paintable_invalidate_size(self: ptr Paintable00) {.
    importc, libprag.}

proc invalidateSize*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture) =
  gdk_paintable_invalidate_size(cast[ptr Paintable00](self.impl))

type
  PaintableFlag* {.size: sizeof(cint), pure.} = enum
    size = 0
    contents = 1

  PaintableFlags* = set[PaintableFlag]

proc gdk_paintable_get_flags(self: ptr Paintable00): PaintableFlags {.
    importc, libprag.}

proc getFlags*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture): PaintableFlags =
  gdk_paintable_get_flags(cast[ptr Paintable00](self.impl))

proc flags*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture): PaintableFlags =
  gdk_paintable_get_flags(cast[ptr Paintable00](self.impl))

type
  Snapshot* = ref object of gobject.Object
  Snapshot00* = object of gobject.Object00

proc gdk_snapshot_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Snapshot()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_paintable_snapshot(self: ptr Paintable00; snapshot: ptr Snapshot00;
    width: cdouble; height: cdouble) {.
    importc, libprag.}

proc snapshot*(self: Paintable | GLTexture | DmabufTexture | MemoryTexture | Texture;
    snapshot: Snapshot; width: cdouble; height: cdouble) =
  gdk_paintable_snapshot(cast[ptr Paintable00](self.impl), cast[ptr Snapshot00](snapshot.impl), width, height)

type
  Popup00* = object of gobject.Object00
  Popup* = ref object of gobject.Object

proc gdk_popup_get_autohide(self: ptr Popup00): gboolean {.
    importc, libprag.}

proc getAutohide*(self: Popup): bool =
  toBool(gdk_popup_get_autohide(cast[ptr Popup00](self.impl)))

proc autohide*(self: Popup): bool =
  toBool(gdk_popup_get_autohide(cast[ptr Popup00](self.impl)))

proc gdk_popup_get_parent(self: ptr Popup00): ptr Surface00 {.
    importc, libprag.}

proc getParent*(self: Popup): Surface =
  let gobj = gdk_popup_get_parent(cast[ptr Popup00](self.impl))
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

proc parent*(self: Popup): Surface =
  let gobj = gdk_popup_get_parent(cast[ptr Popup00](self.impl))
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

proc gdk_popup_get_position_x(self: ptr Popup00): int32 {.
    importc, libprag.}

proc getPositionX*(self: Popup): int =
  int(gdk_popup_get_position_x(cast[ptr Popup00](self.impl)))

proc positionX*(self: Popup): int =
  int(gdk_popup_get_position_x(cast[ptr Popup00](self.impl)))

proc gdk_popup_get_position_y(self: ptr Popup00): int32 {.
    importc, libprag.}

proc getPositionY*(self: Popup): int =
  int(gdk_popup_get_position_y(cast[ptr Popup00](self.impl)))

proc positionY*(self: Popup): int =
  int(gdk_popup_get_position_y(cast[ptr Popup00](self.impl)))

proc gdk_popup_get_rect_anchor(self: ptr Popup00): Gravity {.
    importc, libprag.}

proc getRectAnchor*(self: Popup): Gravity =
  gdk_popup_get_rect_anchor(cast[ptr Popup00](self.impl))

proc rectAnchor*(self: Popup): Gravity =
  gdk_popup_get_rect_anchor(cast[ptr Popup00](self.impl))

proc gdk_popup_get_surface_anchor(self: ptr Popup00): Gravity {.
    importc, libprag.}

proc getSurfaceAnchor*(self: Popup): Gravity =
  gdk_popup_get_surface_anchor(cast[ptr Popup00](self.impl))

proc surfaceAnchor*(self: Popup): Gravity =
  gdk_popup_get_surface_anchor(cast[ptr Popup00](self.impl))

type
  PopupLayout00* {.pure.} = object
  PopupLayout* = ref object
    impl*: ptr PopupLayout00
    ignoreFinalizer*: bool

proc gdk_popup_layout_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkPopupLayout*(self: PopupLayout) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_popup_layout_get_type(), cast[ptr PopupLayout00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PopupLayout()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_popup_layout_get_type(), cast[ptr PopupLayout00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PopupLayout) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkPopupLayout)

proc gdk_popup_layout_unref(self: ptr PopupLayout00) {.
    importc, libprag.}

proc unref*(self: PopupLayout) =
  gdk_popup_layout_unref(cast[ptr PopupLayout00](self.impl))

proc finalizerunref*(self: PopupLayout) =
  if not self.ignoreFinalizer:
    gdk_popup_layout_unref(cast[ptr PopupLayout00](self.impl))

proc gdk_popup_layout_copy(self: ptr PopupLayout00): ptr PopupLayout00 {.
    importc, libprag.}

proc copy*(self: PopupLayout): PopupLayout =
  fnew(result, gBoxedFreeGdkPopupLayout)
  result.impl = gdk_popup_layout_copy(cast[ptr PopupLayout00](self.impl))

proc gdk_popup_layout_equal(self: ptr PopupLayout00; other: ptr PopupLayout00): gboolean {.
    importc, libprag.}

proc equal*(self: PopupLayout; other: PopupLayout): bool =
  toBool(gdk_popup_layout_equal(cast[ptr PopupLayout00](self.impl), cast[ptr PopupLayout00](other.impl)))

proc gdk_popup_layout_get_anchor_hints(self: ptr PopupLayout00): AnchorHints {.
    importc, libprag.}

proc getAnchorHints*(self: PopupLayout): AnchorHints =
  gdk_popup_layout_get_anchor_hints(cast[ptr PopupLayout00](self.impl))

proc anchorHints*(self: PopupLayout): AnchorHints =
  gdk_popup_layout_get_anchor_hints(cast[ptr PopupLayout00](self.impl))

proc gdk_popup_layout_get_anchor_rect(self: ptr PopupLayout00): ptr Rectangle {.
    importc, libprag.}

proc getAnchorRect*(self: PopupLayout): ptr Rectangle =
  gdk_popup_layout_get_anchor_rect(cast[ptr PopupLayout00](self.impl))

proc anchorRect*(self: PopupLayout): ptr Rectangle =
  gdk_popup_layout_get_anchor_rect(cast[ptr PopupLayout00](self.impl))

proc gdk_popup_layout_get_offset(self: ptr PopupLayout00; dx: var int32;
    dy: var int32) {.
    importc, libprag.}

proc getOffset*(self: PopupLayout; dx: var int; dy: var int) =
  var dx_00: int32
  var dy_00: int32
  gdk_popup_layout_get_offset(cast[ptr PopupLayout00](self.impl), dx_00, dy_00)
  if dx.addr != nil:
    dx = int(dx_00)
  if dy.addr != nil:
    dy = int(dy_00)

proc gdk_popup_layout_get_rect_anchor(self: ptr PopupLayout00): Gravity {.
    importc, libprag.}

proc getRectAnchor*(self: PopupLayout): Gravity =
  gdk_popup_layout_get_rect_anchor(cast[ptr PopupLayout00](self.impl))

proc rectAnchor*(self: PopupLayout): Gravity =
  gdk_popup_layout_get_rect_anchor(cast[ptr PopupLayout00](self.impl))

proc gdk_popup_layout_get_shadow_width(self: ptr PopupLayout00; left: var int32;
    right: var int32; top: var int32; bottom: var int32) {.
    importc, libprag.}

proc getShadowWidth*(self: PopupLayout; left: var int;
    right: var int; top: var int; bottom: var int) =
  var left_00: int32
  var top_00: int32
  var bottom_00: int32
  var right_00: int32
  gdk_popup_layout_get_shadow_width(cast[ptr PopupLayout00](self.impl), left_00, right_00, top_00, bottom_00)
  if left.addr != nil:
    left = int(left_00)
  if top.addr != nil:
    top = int(top_00)
  if bottom.addr != nil:
    bottom = int(bottom_00)
  if right.addr != nil:
    right = int(right_00)

proc gdk_popup_layout_get_surface_anchor(self: ptr PopupLayout00): Gravity {.
    importc, libprag.}

proc getSurfaceAnchor*(self: PopupLayout): Gravity =
  gdk_popup_layout_get_surface_anchor(cast[ptr PopupLayout00](self.impl))

proc surfaceAnchor*(self: PopupLayout): Gravity =
  gdk_popup_layout_get_surface_anchor(cast[ptr PopupLayout00](self.impl))

proc gdk_popup_layout_ref(self: ptr PopupLayout00): ptr PopupLayout00 {.
    importc, libprag.}

proc `ref`*(self: PopupLayout): PopupLayout =
  fnew(result, gBoxedFreeGdkPopupLayout)
  result.impl = gdk_popup_layout_ref(cast[ptr PopupLayout00](self.impl))

proc gdk_popup_layout_set_anchor_hints(self: ptr PopupLayout00; anchorHints: AnchorHints) {.
    importc, libprag.}

proc setAnchorHints*(self: PopupLayout; anchorHints: AnchorHints) =
  gdk_popup_layout_set_anchor_hints(cast[ptr PopupLayout00](self.impl), anchorHints)

proc `anchorHints=`*(self: PopupLayout; anchorHints: AnchorHints) =
  gdk_popup_layout_set_anchor_hints(cast[ptr PopupLayout00](self.impl), anchorHints)

proc gdk_popup_layout_set_anchor_rect(self: ptr PopupLayout00; anchorRect: Rectangle) {.
    importc, libprag.}

proc setAnchorRect*(self: PopupLayout; anchorRect: Rectangle) =
  gdk_popup_layout_set_anchor_rect(cast[ptr PopupLayout00](self.impl), anchorRect)

proc `anchorRect=`*(self: PopupLayout; anchorRect: Rectangle) =
  gdk_popup_layout_set_anchor_rect(cast[ptr PopupLayout00](self.impl), anchorRect)

proc gdk_popup_layout_set_offset(self: ptr PopupLayout00; dx: int32; dy: int32) {.
    importc, libprag.}

proc setOffset*(self: PopupLayout; dx: int; dy: int) =
  gdk_popup_layout_set_offset(cast[ptr PopupLayout00](self.impl), int32(dx), int32(dy))

proc gdk_popup_layout_set_rect_anchor(self: ptr PopupLayout00; anchor: Gravity) {.
    importc, libprag.}

proc setRectAnchor*(self: PopupLayout; anchor: Gravity) =
  gdk_popup_layout_set_rect_anchor(cast[ptr PopupLayout00](self.impl), anchor)

proc `rectAnchor=`*(self: PopupLayout; anchor: Gravity) =
  gdk_popup_layout_set_rect_anchor(cast[ptr PopupLayout00](self.impl), anchor)

proc gdk_popup_layout_set_shadow_width(self: ptr PopupLayout00; left: int32;
    right: int32; top: int32; bottom: int32) {.
    importc, libprag.}

proc setShadowWidth*(self: PopupLayout; left: int; right: int;
    top: int; bottom: int) =
  gdk_popup_layout_set_shadow_width(cast[ptr PopupLayout00](self.impl), int32(left), int32(right), int32(top), int32(bottom))

proc gdk_popup_layout_set_surface_anchor(self: ptr PopupLayout00; anchor: Gravity) {.
    importc, libprag.}

proc setSurfaceAnchor*(self: PopupLayout; anchor: Gravity) =
  gdk_popup_layout_set_surface_anchor(cast[ptr PopupLayout00](self.impl), anchor)

proc `surfaceAnchor=`*(self: PopupLayout; anchor: Gravity) =
  gdk_popup_layout_set_surface_anchor(cast[ptr PopupLayout00](self.impl), anchor)

proc gdk_popup_layout_new(anchorRect: Rectangle; rectAnchor: Gravity; surfaceAnchor: Gravity): ptr PopupLayout00 {.
    importc, libprag.}

proc newPopupLayout*(anchorRect: Rectangle; rectAnchor: Gravity; surfaceAnchor: Gravity): PopupLayout =
  fnew(result, gBoxedFreeGdkPopupLayout)
  result.impl = gdk_popup_layout_new(anchorRect, rectAnchor, surfaceAnchor)

proc newPopupLayout*(tdesc: typedesc; anchorRect: Rectangle; rectAnchor: Gravity; surfaceAnchor: Gravity): tdesc =
  assert(result is PopupLayout)
  fnew(result, gBoxedFreeGdkPopupLayout)
  result.impl = gdk_popup_layout_new(anchorRect, rectAnchor, surfaceAnchor)

proc initPopupLayout*[T](result: var T; anchorRect: Rectangle; rectAnchor: Gravity; surfaceAnchor: Gravity) {.deprecated.} =
  assert(result is PopupLayout)
  fnew(result, gBoxedFreeGdkPopupLayout)
  result.impl = gdk_popup_layout_new(anchorRect, rectAnchor, surfaceAnchor)

proc gdk_popup_present(self: ptr Popup00; width: int32; height: int32; layout: ptr PopupLayout00): gboolean {.
    importc, libprag.}

proc present*(self: Popup; width: int; height: int; layout: PopupLayout): bool =
  toBool(gdk_popup_present(cast[ptr Popup00](self.impl), int32(width), int32(height), cast[ptr PopupLayout00](layout.impl)))

type
  ProximityEvent* = ref object of Event
  ProximityEvent00* = object of Event00

proc gdk_proximity_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr ProximityEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: ProximityEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ProximityEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

type
  RGBA* {.pure, byRef.} = object
    red*: cfloat
    green*: cfloat
    blue*: cfloat
    alpha*: cfloat

proc gdk_rgba_get_type*(): GType {.importc, libprag.}

proc gdk_rgba_free(self: RGBA) {.
    importc, libprag.}

proc free*(self: RGBA) =
  gdk_rgba_free(self)

proc gdk_rgba_equal(self: RGBA; p2: RGBA): gboolean {.
    importc, libprag.}

proc equal*(self: RGBA; p2: RGBA): bool =
  toBool(gdk_rgba_equal(self, p2))

proc gdk_rgba_copy(self: RGBA): ptr RGBA {.
    importc, libprag.}

proc copy*(self: RGBA): ptr RGBA =
  gdk_rgba_copy(self)

proc gdk_rgba_hash(self: RGBA): uint32 {.
    importc, libprag.}

proc hash*(self: RGBA): int =
  int(gdk_rgba_hash(self))

proc gdk_rgba_is_clear(self: RGBA): gboolean {.
    importc, libprag.}

proc isClear*(self: RGBA): bool =
  toBool(gdk_rgba_is_clear(self))

proc gdk_rgba_is_opaque(self: RGBA): gboolean {.
    importc, libprag.}

proc isOpaque*(self: RGBA): bool =
  toBool(gdk_rgba_is_opaque(self))

proc gdk_rgba_parse(self: RGBA; spec: cstring): gboolean {.
    importc, libprag.}

proc parse*(self: RGBA; spec: cstring): bool =
  toBool(gdk_rgba_parse(self, spec))

proc gdk_rgba_to_string(self: RGBA): cstring {.
    importc, libprag.}

proc toString*(self: RGBA): string =
  let resul0 = gdk_rgba_to_string(self)
  result = $resul0
  cogfree(resul0)

type
  ScrollDirection* {.size: sizeof(cint), pure.} = enum
    up = 0
    down = 1
    left = 2
    right = 3
    smooth = 4

type
  ScrollEvent* = ref object of Event
  ScrollEvent00* = object of Event00

proc gdk_scroll_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr ScrollEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: ScrollEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ScrollEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

proc gdk_scroll_event_get_deltas(self: ptr ScrollEvent00; deltaX: var cdouble;
    deltaY: var cdouble) {.
    importc, libprag.}

proc getDeltas*(self: ScrollEvent; deltaX: var cdouble;
    deltaY: var cdouble) =
  gdk_scroll_event_get_deltas(cast[ptr ScrollEvent00](self.impl), deltaX, deltaY)

proc gdk_scroll_event_get_direction(self: ptr ScrollEvent00): ScrollDirection {.
    importc, libprag.}

proc getDirection*(self: ScrollEvent): ScrollDirection =
  gdk_scroll_event_get_direction(cast[ptr ScrollEvent00](self.impl))

proc direction*(self: ScrollEvent): ScrollDirection =
  gdk_scroll_event_get_direction(cast[ptr ScrollEvent00](self.impl))

proc gdk_scroll_event_is_stop(self: ptr ScrollEvent00): gboolean {.
    importc, libprag.}

proc isStop*(self: ScrollEvent): bool =
  toBool(gdk_scroll_event_is_stop(cast[ptr ScrollEvent00](self.impl)))

type
  ScrollUnit* {.size: sizeof(cint), pure.} = enum
    wheel = 0
    surface = 1

proc gdk_scroll_event_get_unit(self: ptr ScrollEvent00): ScrollUnit {.
    importc, libprag.}

proc getUnit*(self: ScrollEvent): ScrollUnit =
  gdk_scroll_event_get_unit(cast[ptr ScrollEvent00](self.impl))

proc unit*(self: ScrollEvent): ScrollUnit =
  gdk_scroll_event_get_unit(cast[ptr ScrollEvent00](self.impl))

type
  SurfaceEdge* {.size: sizeof(cint), pure.} = enum
    northWest = 0
    north = 1
    northEast = 2
    west = 3
    east = 4
    southWest = 5
    south = 6
    southEast = 7

type
  TextureDownloader00* {.pure.} = object
  TextureDownloader* = ref object
    impl*: ptr TextureDownloader00
    ignoreFinalizer*: bool

proc gdk_texture_downloader_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkTextureDownloader*(self: TextureDownloader) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_texture_downloader_get_type(), cast[ptr TextureDownloader00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TextureDownloader()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_texture_downloader_get_type(), cast[ptr TextureDownloader00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var TextureDownloader) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkTextureDownloader)

proc gdk_texture_downloader_free(self: ptr TextureDownloader00) {.
    importc, libprag.}

proc free*(self: TextureDownloader) =
  gdk_texture_downloader_free(cast[ptr TextureDownloader00](self.impl))

proc finalizerfree*(self: TextureDownloader) =
  if not self.ignoreFinalizer:
    gdk_texture_downloader_free(cast[ptr TextureDownloader00](self.impl))

proc gdk_texture_downloader_copy(self: ptr TextureDownloader00): ptr TextureDownloader00 {.
    importc, libprag.}

proc copy*(self: TextureDownloader): TextureDownloader =
  fnew(result, gBoxedFreeGdkTextureDownloader)
  result.impl = gdk_texture_downloader_copy(cast[ptr TextureDownloader00](self.impl))

proc gdk_texture_downloader_download_bytes(self: ptr TextureDownloader00;
    outStride: var uint64): ptr glib.Bytes00 {.
    importc, libprag.}

proc downloadBytes*(self: TextureDownloader; outStride: var uint64): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gdk_texture_downloader_download_bytes(cast[ptr TextureDownloader00](self.impl), outStride)

proc gdk_texture_downloader_download_into(self: ptr TextureDownloader00;
    data: ptr uint8; stride: uint64) {.
    importc, libprag.}

proc downloadInto*(self: TextureDownloader; data: seq[uint8] | string;
    stride: uint64) =
  gdk_texture_downloader_download_into(cast[ptr TextureDownloader00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), stride)

proc gdk_texture_downloader_new(texture: ptr Texture00): ptr TextureDownloader00 {.
    importc, libprag.}

proc newTextureDownloader*(texture: Texture): TextureDownloader =
  fnew(result, gBoxedFreeGdkTextureDownloader)
  result.impl = gdk_texture_downloader_new(cast[ptr Texture00](texture.impl))

proc newTextureDownloader*(tdesc: typedesc; texture: Texture): tdesc =
  assert(result is TextureDownloader)
  fnew(result, gBoxedFreeGdkTextureDownloader)
  result.impl = gdk_texture_downloader_new(cast[ptr Texture00](texture.impl))

proc initTextureDownloader*[T](result: var T; texture: Texture) {.deprecated.} =
  assert(result is TextureDownloader)
  fnew(result, gBoxedFreeGdkTextureDownloader)
  result.impl = gdk_texture_downloader_new(cast[ptr Texture00](texture.impl))

proc gdk_texture_downloader_get_format(self: ptr TextureDownloader00): MemoryFormat {.
    importc, libprag.}

proc getFormat*(self: TextureDownloader): MemoryFormat =
  gdk_texture_downloader_get_format(cast[ptr TextureDownloader00](self.impl))

proc format*(self: TextureDownloader): MemoryFormat =
  gdk_texture_downloader_get_format(cast[ptr TextureDownloader00](self.impl))

proc gdk_texture_downloader_get_texture(self: ptr TextureDownloader00): ptr Texture00 {.
    importc, libprag.}

proc getTexture*(self: TextureDownloader): Texture =
  let gobj = gdk_texture_downloader_get_texture(cast[ptr TextureDownloader00](self.impl))
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

proc texture*(self: TextureDownloader): Texture =
  let gobj = gdk_texture_downloader_get_texture(cast[ptr TextureDownloader00](self.impl))
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

proc gdk_texture_downloader_set_format(self: ptr TextureDownloader00; format: MemoryFormat) {.
    importc, libprag.}

proc setFormat*(self: TextureDownloader; format: MemoryFormat) =
  gdk_texture_downloader_set_format(cast[ptr TextureDownloader00](self.impl), format)

proc `format=`*(self: TextureDownloader; format: MemoryFormat) =
  gdk_texture_downloader_set_format(cast[ptr TextureDownloader00](self.impl), format)

proc gdk_texture_downloader_set_texture(self: ptr TextureDownloader00; texture: ptr Texture00) {.
    importc, libprag.}

proc setTexture*(self: TextureDownloader; texture: Texture) =
  gdk_texture_downloader_set_texture(cast[ptr TextureDownloader00](self.impl), cast[ptr Texture00](texture.impl))

proc `texture=`*(self: TextureDownloader; texture: Texture) =
  gdk_texture_downloader_set_texture(cast[ptr TextureDownloader00](self.impl), cast[ptr Texture00](texture.impl))

type
  TextureError* {.size: sizeof(cint), pure.} = enum
    tooLarge = 0
    corruptImage = 1
    unsupportedContent = 2
    unsupportedFormat = 3

type
  TitlebarGesture* {.size: sizeof(cint), pure.} = enum
    doubleClick = 1
    rightClick = 2
    middleClick = 3

type
  ToplevelSize* {.pure, byRef.} = object

proc gdk_toplevel_size_get_bounds(self: ToplevelSize; boundsWidth: var int32;
    boundsHeight: var int32) {.
    importc, libprag.}

proc getBounds*(self: ToplevelSize; boundsWidth: var int;
    boundsHeight: var int) =
  var boundsWidth_00: int32
  var boundsHeight_00: int32
  gdk_toplevel_size_get_bounds(self, boundsWidth_00, boundsHeight_00)
  if boundsWidth.addr != nil:
    boundsWidth = int(boundsWidth_00)
  if boundsHeight.addr != nil:
    boundsHeight = int(boundsHeight_00)

proc gdk_toplevel_size_set_min_size(self: ToplevelSize; minWidth: int32;
    minHeight: int32) {.
    importc, libprag.}

proc setMinSize*(self: ToplevelSize; minWidth: int; minHeight: int) =
  gdk_toplevel_size_set_min_size(self, int32(minWidth), int32(minHeight))

proc gdk_toplevel_size_set_shadow_width(self: ToplevelSize; left: int32;
    right: int32; top: int32; bottom: int32) {.
    importc, libprag.}

proc setShadowWidth*(self: ToplevelSize; left: int; right: int;
    top: int; bottom: int) =
  gdk_toplevel_size_set_shadow_width(self, int32(left), int32(right), int32(top), int32(bottom))

proc gdk_toplevel_size_set_size(self: ToplevelSize; width: int32; height: int32) {.
    importc, libprag.}

proc setSize*(self: ToplevelSize; width: int; height: int) =
  gdk_toplevel_size_set_size(self, int32(width), int32(height))

type
  Toplevel00* = object of gobject.Object00
  Toplevel* = ref object of gobject.Object

proc scComputeSize*(self: Toplevel;  p: proc (self: ptr Toplevel00; size: ToplevelSize; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "compute-size", cast[GCallback](p), xdata, nil, cf)

proc gdk_toplevel_begin_move(self: ptr Toplevel00; device: ptr Device00;
    button: int32; x: cdouble; y: cdouble; timestamp: uint32) {.
    importc, libprag.}

proc beginMove*(self: Toplevel; device: Device; button: int;
    x: cdouble; y: cdouble; timestamp: int) =
  gdk_toplevel_begin_move(cast[ptr Toplevel00](self.impl), cast[ptr Device00](device.impl), int32(button), x, y, uint32(timestamp))

proc gdk_toplevel_begin_resize(self: ptr Toplevel00; edge: SurfaceEdge; device: ptr Device00;
    button: int32; x: cdouble; y: cdouble; timestamp: uint32) {.
    importc, libprag.}

proc beginResize*(self: Toplevel; edge: SurfaceEdge; device: Device = nil;
    button: int; x: cdouble; y: cdouble; timestamp: int) =
  gdk_toplevel_begin_resize(cast[ptr Toplevel00](self.impl), edge, if device.isNil: nil else: cast[ptr Device00](device.impl), int32(button), x, y, uint32(timestamp))

proc gdk_toplevel_focus(self: ptr Toplevel00; timestamp: uint32) {.
    importc, libprag.}

proc focus*(self: Toplevel; timestamp: int) =
  gdk_toplevel_focus(cast[ptr Toplevel00](self.impl), uint32(timestamp))

proc gdk_toplevel_inhibit_system_shortcuts(self: ptr Toplevel00; event: ptr Event00) {.
    importc, libprag.}

proc inhibitSystemShortcuts*(self: Toplevel; event: Event = nil) =
  gdk_toplevel_inhibit_system_shortcuts(cast[ptr Toplevel00](self.impl), if event.isNil: nil else: cast[ptr Event00](event.impl))

proc gdk_toplevel_lower(self: ptr Toplevel00): gboolean {.
    importc, libprag.}

proc lower*(self: Toplevel): bool =
  toBool(gdk_toplevel_lower(cast[ptr Toplevel00](self.impl)))

proc gdk_toplevel_minimize(self: ptr Toplevel00): gboolean {.
    importc, libprag.}

proc minimize*(self: Toplevel): bool =
  toBool(gdk_toplevel_minimize(cast[ptr Toplevel00](self.impl)))

proc gdk_toplevel_restore_system_shortcuts(self: ptr Toplevel00) {.
    importc, libprag.}

proc restoreSystemShortcuts*(self: Toplevel) =
  gdk_toplevel_restore_system_shortcuts(cast[ptr Toplevel00](self.impl))

proc gdk_toplevel_set_decorated(self: ptr Toplevel00; decorated: gboolean) {.
    importc, libprag.}

proc setDecorated*(self: Toplevel; decorated: bool = true) =
  gdk_toplevel_set_decorated(cast[ptr Toplevel00](self.impl), gboolean(decorated))

proc `decorated=`*(self: Toplevel; decorated: bool) =
  gdk_toplevel_set_decorated(cast[ptr Toplevel00](self.impl), gboolean(decorated))

proc gdk_toplevel_set_deletable(self: ptr Toplevel00; deletable: gboolean) {.
    importc, libprag.}

proc setDeletable*(self: Toplevel; deletable: bool = true) =
  gdk_toplevel_set_deletable(cast[ptr Toplevel00](self.impl), gboolean(deletable))

proc `deletable=`*(self: Toplevel; deletable: bool) =
  gdk_toplevel_set_deletable(cast[ptr Toplevel00](self.impl), gboolean(deletable))

proc gdk_toplevel_set_icon_list(self: ptr Toplevel00; surfaces: ptr glib.List) {.
    importc, libprag.}

proc setIconList*(self: Toplevel; surfaces: seq[Texture]) =
  var tempResGL = seq2GList(surfaces)
  gdk_toplevel_set_icon_list(cast[ptr Toplevel00](self.impl), tempResGL)
  g_list_free(tempResGL)

proc `iconList=`*(self: Toplevel; surfaces: seq[Texture]) =
  var tempResGL = seq2GList(surfaces)
  gdk_toplevel_set_icon_list(cast[ptr Toplevel00](self.impl), tempResGL)
  g_list_free(tempResGL)

proc gdk_toplevel_set_modal(self: ptr Toplevel00; modal: gboolean) {.
    importc, libprag.}

proc setModal*(self: Toplevel; modal: bool = true) =
  gdk_toplevel_set_modal(cast[ptr Toplevel00](self.impl), gboolean(modal))

proc `modal=`*(self: Toplevel; modal: bool) =
  gdk_toplevel_set_modal(cast[ptr Toplevel00](self.impl), gboolean(modal))

proc gdk_toplevel_set_startup_id(self: ptr Toplevel00; startupId: cstring) {.
    importc, libprag.}

proc setStartupId*(self: Toplevel; startupId: cstring) =
  gdk_toplevel_set_startup_id(cast[ptr Toplevel00](self.impl), startupId)

proc `startupId=`*(self: Toplevel; startupId: cstring) =
  gdk_toplevel_set_startup_id(cast[ptr Toplevel00](self.impl), startupId)

proc gdk_toplevel_set_title(self: ptr Toplevel00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: Toplevel; title: cstring) =
  gdk_toplevel_set_title(cast[ptr Toplevel00](self.impl), title)

proc `title=`*(self: Toplevel; title: cstring) =
  gdk_toplevel_set_title(cast[ptr Toplevel00](self.impl), title)

proc gdk_toplevel_set_transient_for(self: ptr Toplevel00; parent: ptr Surface00) {.
    importc, libprag.}

proc setTransientFor*(self: Toplevel; parent: Surface) =
  gdk_toplevel_set_transient_for(cast[ptr Toplevel00](self.impl), cast[ptr Surface00](parent.impl))

proc `transientFor=`*(self: Toplevel; parent: Surface) =
  gdk_toplevel_set_transient_for(cast[ptr Toplevel00](self.impl), cast[ptr Surface00](parent.impl))

proc gdk_toplevel_show_window_menu(self: ptr Toplevel00; event: ptr Event00): gboolean {.
    importc, libprag.}

proc showWindowMenu*(self: Toplevel; event: Event): bool =
  toBool(gdk_toplevel_show_window_menu(cast[ptr Toplevel00](self.impl), cast[ptr Event00](event.impl)))

proc gdk_toplevel_supports_edge_constraints(self: ptr Toplevel00): gboolean {.
    importc, libprag.}

proc supportsEdgeConstraints*(self: Toplevel): bool =
  toBool(gdk_toplevel_supports_edge_constraints(cast[ptr Toplevel00](self.impl)))

proc gdk_toplevel_titlebar_gesture(self: ptr Toplevel00; gesture: TitlebarGesture): gboolean {.
    importc, libprag.}

proc titlebarGesture*(self: Toplevel; gesture: TitlebarGesture): bool =
  toBool(gdk_toplevel_titlebar_gesture(cast[ptr Toplevel00](self.impl), gesture))

type
  ToplevelStateFlag* {.size: sizeof(cint), pure.} = enum
    minimized = 0
    maximized = 1
    sticky = 2
    fullscreen = 3
    above = 4
    below = 5
    focused = 6
    tiled = 7
    topTiled = 8
    topResizable = 9
    rightTiled = 10
    rightResizable = 11
    bottomTiled = 12
    bottomResizable = 13
    leftTiled = 14
    leftResizable = 15
    suspended = 16

  ToplevelState* = set[ToplevelStateFlag]

proc gdk_toplevel_get_state(self: ptr Toplevel00): ToplevelState {.
    importc, libprag.}

proc getState*(self: Toplevel): ToplevelState =
  gdk_toplevel_get_state(cast[ptr Toplevel00](self.impl))

proc state*(self: Toplevel): ToplevelState =
  gdk_toplevel_get_state(cast[ptr Toplevel00](self.impl))

type
  ToplevelLayout00* {.pure.} = object
  ToplevelLayout* = ref object
    impl*: ptr ToplevelLayout00
    ignoreFinalizer*: bool

proc gdk_toplevel_layout_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkToplevelLayout*(self: ToplevelLayout) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_toplevel_layout_get_type(), cast[ptr ToplevelLayout00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ToplevelLayout()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_toplevel_layout_get_type(), cast[ptr ToplevelLayout00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ToplevelLayout) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkToplevelLayout)

proc gdk_toplevel_layout_unref(self: ptr ToplevelLayout00) {.
    importc, libprag.}

proc unref*(self: ToplevelLayout) =
  gdk_toplevel_layout_unref(cast[ptr ToplevelLayout00](self.impl))

proc finalizerunref*(self: ToplevelLayout) =
  if not self.ignoreFinalizer:
    gdk_toplevel_layout_unref(cast[ptr ToplevelLayout00](self.impl))

proc gdk_toplevel_layout_copy(self: ptr ToplevelLayout00): ptr ToplevelLayout00 {.
    importc, libprag.}

proc copy*(self: ToplevelLayout): ToplevelLayout =
  fnew(result, gBoxedFreeGdkToplevelLayout)
  result.impl = gdk_toplevel_layout_copy(cast[ptr ToplevelLayout00](self.impl))

proc gdk_toplevel_layout_equal(self: ptr ToplevelLayout00; other: ptr ToplevelLayout00): gboolean {.
    importc, libprag.}

proc equal*(self: ToplevelLayout; other: ToplevelLayout): bool =
  toBool(gdk_toplevel_layout_equal(cast[ptr ToplevelLayout00](self.impl), cast[ptr ToplevelLayout00](other.impl)))

proc gdk_toplevel_layout_get_fullscreen(self: ptr ToplevelLayout00; fullscreen: var gboolean): gboolean {.
    importc, libprag.}

proc getFullscreen*(self: ToplevelLayout; fullscreen: var bool): bool =
  var fullscreen_00: gboolean
  result = toBool(gdk_toplevel_layout_get_fullscreen(cast[ptr ToplevelLayout00](self.impl), fullscreen_00))
  if fullscreen.addr != nil:
    fullscreen = toBool(fullscreen_00)

proc gdk_toplevel_layout_get_fullscreen_monitor(self: ptr ToplevelLayout00): ptr Monitor00 {.
    importc, libprag.}

proc getFullscreenMonitor*(self: ToplevelLayout): Monitor =
  let gobj = gdk_toplevel_layout_get_fullscreen_monitor(cast[ptr ToplevelLayout00](self.impl))
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

proc fullscreenMonitor*(self: ToplevelLayout): Monitor =
  let gobj = gdk_toplevel_layout_get_fullscreen_monitor(cast[ptr ToplevelLayout00](self.impl))
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

proc gdk_toplevel_layout_get_maximized(self: ptr ToplevelLayout00; maximized: var gboolean): gboolean {.
    importc, libprag.}

proc getMaximized*(self: ToplevelLayout; maximized: var bool): bool =
  var maximized_00: gboolean
  result = toBool(gdk_toplevel_layout_get_maximized(cast[ptr ToplevelLayout00](self.impl), maximized_00))
  if maximized.addr != nil:
    maximized = toBool(maximized_00)

proc gdk_toplevel_layout_get_resizable(self: ptr ToplevelLayout00): gboolean {.
    importc, libprag.}

proc getResizable*(self: ToplevelLayout): bool =
  toBool(gdk_toplevel_layout_get_resizable(cast[ptr ToplevelLayout00](self.impl)))

proc resizable*(self: ToplevelLayout): bool =
  toBool(gdk_toplevel_layout_get_resizable(cast[ptr ToplevelLayout00](self.impl)))

proc gdk_toplevel_layout_ref(self: ptr ToplevelLayout00): ptr ToplevelLayout00 {.
    importc, libprag.}

proc `ref`*(self: ToplevelLayout): ToplevelLayout =
  fnew(result, gBoxedFreeGdkToplevelLayout)
  result.impl = gdk_toplevel_layout_ref(cast[ptr ToplevelLayout00](self.impl))

proc gdk_toplevel_layout_set_fullscreen(self: ptr ToplevelLayout00; fullscreen: gboolean;
    monitor: ptr Monitor00) {.
    importc, libprag.}

proc setFullscreen*(self: ToplevelLayout; fullscreen: bool;
    monitor: Monitor = nil) =
  gdk_toplevel_layout_set_fullscreen(cast[ptr ToplevelLayout00](self.impl), gboolean(fullscreen), if monitor.isNil: nil else: cast[ptr Monitor00](monitor.impl))

proc gdk_toplevel_layout_set_maximized(self: ptr ToplevelLayout00; maximized: gboolean) {.
    importc, libprag.}

proc setMaximized*(self: ToplevelLayout; maximized: bool = true) =
  gdk_toplevel_layout_set_maximized(cast[ptr ToplevelLayout00](self.impl), gboolean(maximized))

proc `maximized=`*(self: ToplevelLayout; maximized: bool) =
  gdk_toplevel_layout_set_maximized(cast[ptr ToplevelLayout00](self.impl), gboolean(maximized))

proc gdk_toplevel_layout_set_resizable(self: ptr ToplevelLayout00; resizable: gboolean) {.
    importc, libprag.}

proc setResizable*(self: ToplevelLayout; resizable: bool = true) =
  gdk_toplevel_layout_set_resizable(cast[ptr ToplevelLayout00](self.impl), gboolean(resizable))

proc `resizable=`*(self: ToplevelLayout; resizable: bool) =
  gdk_toplevel_layout_set_resizable(cast[ptr ToplevelLayout00](self.impl), gboolean(resizable))

proc gdk_toplevel_layout_new(): ptr ToplevelLayout00 {.
    importc, libprag.}

proc newToplevelLayout*(): ToplevelLayout =
  fnew(result, gBoxedFreeGdkToplevelLayout)
  result.impl = gdk_toplevel_layout_new()

proc newToplevelLayout*(tdesc: typedesc): tdesc =
  assert(result is ToplevelLayout)
  fnew(result, gBoxedFreeGdkToplevelLayout)
  result.impl = gdk_toplevel_layout_new()

proc initToplevelLayout*[T](result: var T) {.deprecated.} =
  assert(result is ToplevelLayout)
  fnew(result, gBoxedFreeGdkToplevelLayout)
  result.impl = gdk_toplevel_layout_new()

proc gdk_toplevel_present(self: ptr Toplevel00; layout: ptr ToplevelLayout00) {.
    importc, libprag.}

proc present*(self: Toplevel; layout: ToplevelLayout) =
  gdk_toplevel_present(cast[ptr Toplevel00](self.impl), cast[ptr ToplevelLayout00](layout.impl))

type
  TouchEvent* = ref object of Event
  TouchEvent00* = object of Event00

proc gdk_touch_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr TouchEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: TouchEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TouchEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

proc gdk_touch_event_get_emulating_pointer(self: ptr TouchEvent00): gboolean {.
    importc, libprag.}

proc getEmulatingPointer*(self: TouchEvent): bool =
  toBool(gdk_touch_event_get_emulating_pointer(cast[ptr TouchEvent00](self.impl)))

proc emulatingPointer*(self: TouchEvent): bool =
  toBool(gdk_touch_event_get_emulating_pointer(cast[ptr TouchEvent00](self.impl)))

type
  TouchpadEvent* = ref object of Event
  TouchpadEvent00* = object of Event00

proc gdk_touchpad_event_get_type*(): GType {.importc, libprag.}

proc gdk_event_unref*(self: ptr TouchpadEvent00) {.importc, libprag.}

proc generic_gdk_event_unref*(self: TouchpadEvent) =
  if not self.ignoreFinalizer:
    gdk_event_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TouchpadEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gdk_event_unref(self.impl)
      self.impl = nil

proc gdk_touchpad_event_get_deltas(self: ptr TouchpadEvent00; dx: var cdouble;
    dy: var cdouble) {.
    importc, libprag.}

proc getDeltas*(self: TouchpadEvent; dx: var cdouble;
    dy: var cdouble) =
  gdk_touchpad_event_get_deltas(cast[ptr TouchpadEvent00](self.impl), dx, dy)

proc gdk_touchpad_event_get_n_fingers(self: ptr TouchpadEvent00): uint32 {.
    importc, libprag.}

proc getNFingers*(self: TouchpadEvent): int =
  int(gdk_touchpad_event_get_n_fingers(cast[ptr TouchpadEvent00](self.impl)))

proc nFingers*(self: TouchpadEvent): int =
  int(gdk_touchpad_event_get_n_fingers(cast[ptr TouchpadEvent00](self.impl)))

proc gdk_touchpad_event_get_pinch_angle_delta(self: ptr TouchpadEvent00): cdouble {.
    importc, libprag.}

proc getPinchAngleDelta*(self: TouchpadEvent): cdouble =
  gdk_touchpad_event_get_pinch_angle_delta(cast[ptr TouchpadEvent00](self.impl))

proc pinchAngleDelta*(self: TouchpadEvent): cdouble =
  gdk_touchpad_event_get_pinch_angle_delta(cast[ptr TouchpadEvent00](self.impl))

proc gdk_touchpad_event_get_pinch_scale(self: ptr TouchpadEvent00): cdouble {.
    importc, libprag.}

proc getPinchScale*(self: TouchpadEvent): cdouble =
  gdk_touchpad_event_get_pinch_scale(cast[ptr TouchpadEvent00](self.impl))

proc pinchScale*(self: TouchpadEvent): cdouble =
  gdk_touchpad_event_get_pinch_scale(cast[ptr TouchpadEvent00](self.impl))

type
  TouchpadGesturePhase* {.size: sizeof(cint), pure.} = enum
    begin = 0
    update = 1
    `end` = 2
    cancel = 3

proc gdk_touchpad_event_get_gesture_phase(self: ptr TouchpadEvent00): TouchpadGesturePhase {.
    importc, libprag.}

proc getGesturePhase*(self: TouchpadEvent): TouchpadGesturePhase =
  gdk_touchpad_event_get_gesture_phase(cast[ptr TouchpadEvent00](self.impl))

proc gesturePhase*(self: TouchpadEvent): TouchpadGesturePhase =
  gdk_touchpad_event_get_gesture_phase(cast[ptr TouchpadEvent00](self.impl))

type
  VulkanError* {.size: sizeof(cint), pure.} = enum
    unsupported = 0
    notAvailable = 1

proc gdk_cairo_draw_from_gl(cr: ptr cairo.Context00; surface: ptr Surface00;
    source: int32; sourceType: int32; bufferScale: int32; x: int32; y: int32;
    width: int32; height: int32) {.
    importc, libprag.}

proc cairoDrawFromGl*(cr: cairo.Context; surface: Surface; source: int;
    sourceType: int; bufferScale: int; x: int; y: int; width: int; height: int) =
  gdk_cairo_draw_from_gl(cast[ptr cairo.Context00](cr.impl), cast[ptr Surface00](surface.impl), int32(source), int32(sourceType), int32(bufferScale), int32(x), int32(y), int32(width), int32(height))

proc gdk_cairo_rectangle(cr: ptr cairo.Context00; rectangle: Rectangle) {.
    importc, libprag.}

proc cairoRectangle*(cr: cairo.Context; rectangle: Rectangle) =
  gdk_cairo_rectangle(cast[ptr cairo.Context00](cr.impl), rectangle)

proc gdk_cairo_region(cr: ptr cairo.Context00; region: ptr cairo.Region00) {.
    importc, libprag.}

proc cairoRegion*(cr: cairo.Context; region: cairo.Region) =
  gdk_cairo_region(cast[ptr cairo.Context00](cr.impl), cast[ptr cairo.Region00](region.impl))

proc gdk_cairo_region_create_from_surface(surface: ptr cairo.Surface00): ptr cairo.Region00 {.
    importc, libprag.}

proc cairoRegionCreateFromSurface*(surface: cairo.Surface): cairo.Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = gdk_cairo_region_create_from_surface(cast[ptr cairo.Surface00](surface.impl))

proc gdk_cairo_set_source_pixbuf(cr: ptr cairo.Context00; pixbuf: ptr gdkpixbuf.Pixbuf00;
    pixbufX: cdouble; pixbufY: cdouble) {.
    importc, libprag.}

proc cairoSetSourcePixbuf*(cr: cairo.Context; pixbuf: gdkpixbuf.Pixbuf;
    pixbufX: cdouble; pixbufY: cdouble) =
  gdk_cairo_set_source_pixbuf(cast[ptr cairo.Context00](cr.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl), pixbufX, pixbufY)

proc gdk_cairo_set_source_rgba(cr: ptr cairo.Context00; rgba: RGBA) {.
    importc, libprag.}

proc cairoSetSourceRgba*(cr: cairo.Context; rgba: RGBA) =
  gdk_cairo_set_source_rgba(cast[ptr cairo.Context00](cr.impl), rgba)

proc gdk_content_deserialize_async(stream: ptr gio.InputStream00; mimeType: cstring;
    `type`: GType; ioPriority: int32; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc contentDeserializeAsync*(stream: gio.InputStream; mimeType: cstring;
    `type`: GType; ioPriority: int; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  gdk_content_deserialize_async(cast[ptr gio.InputStream00](stream.impl), mimeType, `type`, int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_content_deserialize_finish(resu: ptr gio.AsyncResult00; value: var gobject.Value;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc contentDeserializeFinish*(resu: gio.AsyncResult; value: var gobject.Value): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_content_deserialize_finish(cast[ptr gio.AsyncResult00](resu.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc contentRegisterDeserializer*(mimeType: cstring; `type`: GType;
    deserialize: ContentDeserializeFunc; data: pointer; notify: DestroyNotify) {.
    importc: "gdk_content_register_deserializer", libprag.}

proc contentRegisterSerializer*(`type`: GType; mimeType: cstring; serialize: ContentSerializeFunc;
    data: pointer; notify: DestroyNotify) {.
    importc: "gdk_content_register_serializer", libprag.}

proc gdk_content_serialize_async(stream: ptr gio.OutputStream00; mimeType: cstring;
    value: gobject.Value; ioPriority: int32; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc contentSerializeAsync*(stream: gio.OutputStream; mimeType: cstring;
    value: gobject.Value; ioPriority: int; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  gdk_content_serialize_async(cast[ptr gio.OutputStream00](stream.impl), mimeType, value, int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_content_serialize_finish(resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc contentSerializeFinish*(resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_content_serialize_finish(cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc dragSurfaceSizeGetType*(): GType {.
    importc: "gdk_drag_surface_size_get_type", libprag.}

proc gdk_intern_mime_type(string: cstring): cstring {.
    importc, libprag.}

proc internMimeType*(string: cstring): string =
  let resul0 = gdk_intern_mime_type(string)
  if resul0.isNil:
    return
  result = $resul0

proc gdk_keyval_convert_case(symbol: uint32; lower: var uint32; upper: var uint32) {.
    importc, libprag.}

proc keyvalConvertCase*(symbol: int; lower: var int; upper: var int) =
  var lower_00: uint32
  var upper_00: uint32
  gdk_keyval_convert_case(uint32(symbol), lower_00, upper_00)
  if lower.addr != nil:
    lower = int(lower_00)
  if upper.addr != nil:
    upper = int(upper_00)

proc gdk_keyval_from_name(keyvalName: cstring): uint32 {.
    importc, libprag.}

proc keyvalFromName*(keyvalName: cstring): int =
  int(gdk_keyval_from_name(keyvalName))

proc gdk_keyval_is_lower(keyval: uint32): gboolean {.
    importc, libprag.}

proc keyvalIsLower*(keyval: int): bool =
  toBool(gdk_keyval_is_lower(uint32(keyval)))

proc gdk_keyval_is_upper(keyval: uint32): gboolean {.
    importc, libprag.}

proc keyvalIsUpper*(keyval: int): bool =
  toBool(gdk_keyval_is_upper(uint32(keyval)))

proc gdk_keyval_name(keyval: uint32): cstring {.
    importc, libprag.}

proc keyvalName*(keyval: int): string =
  let resul0 = gdk_keyval_name(uint32(keyval))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_keyval_to_lower(keyval: uint32): uint32 {.
    importc, libprag.}

proc keyvalToLower*(keyval: int): int =
  int(gdk_keyval_to_lower(uint32(keyval)))

proc gdk_keyval_to_unicode(keyval: uint32): uint32 {.
    importc, libprag.}

proc keyvalToUnicode*(keyval: int): int =
  int(gdk_keyval_to_unicode(uint32(keyval)))

proc gdk_keyval_to_upper(keyval: uint32): uint32 {.
    importc, libprag.}

proc keyvalToUpper*(keyval: int): int =
  int(gdk_keyval_to_upper(uint32(keyval)))

proc gdk_pixbuf_get_from_surface(surface: ptr cairo.Surface00; srcX: int32;
    srcY: int32; width: int32; height: int32): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc pixbufGetFromSurface*(surface: cairo.Surface; srcX: int; srcY: int;
    width: int; height: int): gdkpixbuf.Pixbuf =
  let gobj = gdk_pixbuf_get_from_surface(cast[ptr cairo.Surface00](surface.impl), int32(srcX), int32(srcY), int32(width), int32(height))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_get_from_texture(texture: ptr Texture00): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc pixbufGetFromTexture*(texture: Texture): gdkpixbuf.Pixbuf =
  let gobj = gdk_pixbuf_get_from_texture(cast[ptr Texture00](texture.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc setAllowedBackends*(backends: cstring) {.
    importc: "gdk_set_allowed_backends", libprag.}

proc toplevelSizeGetType*(): GType {.
    importc: "gdk_toplevel_size_get_type", libprag.}

proc gdk_unicode_to_keyval(wc: uint32): uint32 {.
    importc, libprag.}

proc unicodeToKeyval*(wc: int): int =
  int(gdk_unicode_to_keyval(uint32(wc)))
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc asyncResult*(x: gdk4.ContentDeserializer): gio.AsyncResult = cast[gio.AsyncResult](x)

proc asyncResult*(x: gdk4.ContentSerializer): gio.AsyncResult = cast[gio.AsyncResult](x)

proc icon*(x: gdk4.DmabufTexture): gio.Icon = cast[gio.Icon](x)

proc loadableIcon*(x: gdk4.DmabufTexture): gio.LoadableIcon = cast[gio.LoadableIcon](x)

proc icon*(x: gdk4.GLTexture): gio.Icon = cast[gio.Icon](x)

proc loadableIcon*(x: gdk4.GLTexture): gio.LoadableIcon = cast[gio.LoadableIcon](x)

proc icon*(x: gdk4.MemoryTexture): gio.Icon = cast[gio.Icon](x)

proc loadableIcon*(x: gdk4.MemoryTexture): gio.LoadableIcon = cast[gio.LoadableIcon](x)

proc icon*(x: gdk4.Texture): gio.Icon = cast[gio.Icon](x)

proc loadableIcon*(x: gdk4.Texture): gio.LoadableIcon = cast[gio.LoadableIcon](x)

proc initable*(x: gdk4.VulkanContext): gio.Initable = cast[gio.Initable](x)

proc getAngle*(self: Event; event2: Event): cdouble =
  if not toBool(gdk_events_get_angle(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), result)):
    raise newException(Defect, "Events do not support getAngle().")

proc getCenter*(self: Event; event2: Event): (cdouble, cdouble) =
  if not toBool(gdk_events_get_center(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), result[0], result[1])):
    raise newException(Defect, "Events do not support getCenter().")

proc getDistance*(self: Event; event2: Event): cdouble =
  if not toBool(gdk_events_get_distance(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), result)):
    raise newException(Defect, "Events do not support getDistance().")

proc getAxis*(self: Event; axisUse: AxisUse): cdouble =
  if not toBool(gdk_event_get_axis(cast[ptr Event00](self.impl), axisUse, result)):
    raise newException(Defect, "Event does not support getAxis().")


proc getPosition*(self: Event): (float, float) =
  assert toBool(gdk_event_get_position(cast[ptr Event00](self.impl), result[0].float, result[1].float))


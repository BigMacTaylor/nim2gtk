# dependencies:
# libxml2-2.0
# Soup-3.0
# Gio-2.0
# GLib-2.0
# GModule-2.0
# GObject-2.0
# GSSDP-1.6
# immediate dependencies:
# libxml2-2.0
# Soup-3.0
# Gio-2.0
# GSSDP-1.6
# GObject-2.0
# libraries:
# libgupnp-1.6.so.0
{.warning[UnusedImport]: off.}
import libxml2, soup3, gio, glib, gmodule, gobject, gssdp
const Lib = "libgupnp-1.6.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  Acl00* = object of gobject.Object00
  Acl* = ref object of gobject.Object

proc gupnp_acl_can_sync(self: ptr Acl00): gboolean {.
    importc, libprag.}

proc canSync*(self: Acl): bool =
  toBool(gupnp_acl_can_sync(cast[ptr Acl00](self.impl)))

proc gupnp_acl_is_allowed_finish(self: ptr Acl00; res: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc isAllowedFinish*(self: Acl; res: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = gupnp_acl_is_allowed_finish(cast[ptr Acl00](self.impl), cast[ptr gio.AsyncResult00](res.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  DeviceInfo* = ref object of gobject.Object
  DeviceInfo00* = object of gobject.Object00

proc gupnp_device_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DeviceInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gupnp_device_info_get_description_value(self: ptr DeviceInfo00; element: cstring): cstring {.
    importc, libprag.}

proc getDescriptionValue*(self: DeviceInfo; element: cstring): string =
  let resul0 = gupnp_device_info_get_description_value(cast[ptr DeviceInfo00](self.impl), element)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_device(self: ptr DeviceInfo00; `type`: cstring): ptr DeviceInfo00 {.
    importc, libprag.}

proc getDevice*(self: DeviceInfo; `type`: cstring): DeviceInfo =
  let gobj = gupnp_device_info_get_device(cast[ptr DeviceInfo00](self.impl), `type`)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_device_info_get_device_type(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getDeviceType*(self: DeviceInfo): string =
  result = $gupnp_device_info_get_device_type(cast[ptr DeviceInfo00](self.impl))

proc deviceType*(self: DeviceInfo): string =
  result = $gupnp_device_info_get_device_type(cast[ptr DeviceInfo00](self.impl))

proc gupnp_device_info_get_friendly_name(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getFriendlyName*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_friendly_name(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc friendlyName*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_friendly_name(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_icon_async(self: ptr DeviceInfo00; requestedMimeType: cstring;
    requestedDepth: int32; requestedWidth: int32; requestedHeight: int32; preferBigger: gboolean;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc getIconAsync*(self: DeviceInfo; requestedMimeType: cstring = nil;
    requestedDepth: int; requestedWidth: int; requestedHeight: int; preferBigger: bool;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  gupnp_device_info_get_icon_async(cast[ptr DeviceInfo00](self.impl), requestedMimeType, int32(requestedDepth), int32(requestedWidth), int32(requestedHeight), gboolean(preferBigger), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gupnp_device_info_get_icon_finish(self: ptr DeviceInfo00; res: ptr gio.AsyncResult00;
    mime: var cstring; depth: var int32; width: var int32; height: var int32;
    error: ptr ptr glib.Error = nil): ptr glib.Bytes00 {.
    importc, libprag.}

proc getIconFinish*(self: DeviceInfo; res: gio.AsyncResult;
    mime: var string = cast[var string](nil); depth: var int = cast[var int](nil);
    width: var int = cast[var int](nil); height: var int = cast[var int](nil)): glib.Bytes =
  var gerror: ptr glib.Error
  var depth_00: int32
  var height_00: int32
  var mime_00: cstring
  var width_00: int32
  let impl0 = gupnp_device_info_get_icon_finish(cast[ptr DeviceInfo00](self.impl), cast[ptr gio.AsyncResult00](res.impl), mime_00, depth_00, width_00, height_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGBytes)
  result.impl = impl0
  if depth.addr != nil:
    depth = int(depth_00)
  if height.addr != nil:
    height = int(height_00)
  if mime.addr != nil:
    mime = $(mime_00)
  if width.addr != nil:
    width = int(width_00)

proc gupnp_device_info_get_icon_url(self: ptr DeviceInfo00; requestedMimeType: cstring;
    requestedDepth: int32; requestedWidth: int32; requestedHeight: int32; preferBigger: gboolean;
    mimeType: var cstring; depth: var int32; width: var int32; height: var int32): cstring {.
    importc, libprag.}

proc getIconUrl*(self: DeviceInfo; requestedMimeType: cstring = nil;
    requestedDepth: int; requestedWidth: int; requestedHeight: int; preferBigger: bool;
    mimeType: var string = cast[var string](nil); depth: var int = cast[var int](nil);
    width: var int = cast[var int](nil); height: var int = cast[var int](nil)): string =
  var depth_00: int32
  var height_00: int32
  var mimeType_00: cstring
  var width_00: int32
  let resul0 = gupnp_device_info_get_icon_url(cast[ptr DeviceInfo00](self.impl), requestedMimeType, int32(requestedDepth), int32(requestedWidth), int32(requestedHeight), gboolean(preferBigger), mimeType_00, depth_00, width_00, height_00)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)
  if depth.addr != nil:
    depth = int(depth_00)
  if height.addr != nil:
    height = int(height_00)
  if mimeType.addr != nil:
    mimeType = $(mimeType_00)
  if width.addr != nil:
    width = int(width_00)

proc gupnp_device_info_get_location(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getLocation*(self: DeviceInfo): string =
  result = $gupnp_device_info_get_location(cast[ptr DeviceInfo00](self.impl))

proc location*(self: DeviceInfo): string =
  result = $gupnp_device_info_get_location(cast[ptr DeviceInfo00](self.impl))

proc gupnp_device_info_get_manufacturer(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getManufacturer*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_manufacturer(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc manufacturer*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_manufacturer(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_manufacturer_url(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getManufacturerUrl*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_manufacturer_url(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc manufacturerUrl*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_manufacturer_url(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_model_description(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getModelDescription*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_model_description(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc modelDescription*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_model_description(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_model_name(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getModelName*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_model_name(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc modelName*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_model_name(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_model_number(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getModelNumber*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_model_number(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc modelNumber*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_model_number(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_model_url(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getModelUrl*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_model_url(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc modelUrl*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_model_url(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_presentation_url(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getPresentationUrl*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_presentation_url(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc presentationUrl*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_presentation_url(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_serial_number(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getSerialNumber*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_serial_number(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc serialNumber*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_serial_number(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_udn(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getUdn*(self: DeviceInfo): string =
  result = $gupnp_device_info_get_udn(cast[ptr DeviceInfo00](self.impl))

proc udn*(self: DeviceInfo): string =
  result = $gupnp_device_info_get_udn(cast[ptr DeviceInfo00](self.impl))

proc gupnp_device_info_get_upc(self: ptr DeviceInfo00): cstring {.
    importc, libprag.}

proc getUpc*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_upc(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc upc*(self: DeviceInfo): string =
  let resul0 = gupnp_device_info_get_upc(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gupnp_device_info_get_url_base(self: ptr DeviceInfo00): ptr glib.Uri00 {.
    importc, libprag.}

proc getUrlBase*(self: DeviceInfo): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = gupnp_device_info_get_url_base(cast[ptr DeviceInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc urlBase*(self: DeviceInfo): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = gupnp_device_info_get_url_base(cast[ptr DeviceInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc gupnp_device_info_list_device_types(self: ptr DeviceInfo00): ptr glib.List {.
    importc, libprag.}

proc listDeviceTypes*(self: DeviceInfo): seq[cstring] =
  let resul0 = gupnp_device_info_list_device_types(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  g_list_free(resul0)

proc gupnp_device_info_list_devices(self: ptr DeviceInfo00): ptr glib.List {.
    importc, libprag.}

proc listDevices*(self: DeviceInfo): seq[DeviceInfo] =
  let resul0 = gupnp_device_info_list_devices(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = glistObjects2seq(DeviceInfo, resul0, true)
  g_list_free(resul0)

proc gupnp_device_info_list_dlna_capabilities(self: ptr DeviceInfo00): ptr glib.List {.
    importc, libprag.}

proc listDlnaCapabilities*(self: DeviceInfo): seq[cstring] =
  let resul0 = gupnp_device_info_list_dlna_capabilities(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  g_list_free(resul0)

proc gupnp_device_info_list_dlna_device_class_identifier(self: ptr DeviceInfo00): ptr glib.List {.
    importc, libprag.}

proc listDlnaDeviceClassIdentifier*(self: DeviceInfo): seq[cstring] =
  let resul0 = gupnp_device_info_list_dlna_device_class_identifier(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  g_list_free(resul0)

proc gupnp_device_info_list_service_types(self: ptr DeviceInfo00): ptr glib.List {.
    importc, libprag.}

proc listServiceTypes*(self: DeviceInfo): seq[cstring] =
  let resul0 = gupnp_device_info_list_service_types(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  g_list_free(resul0)

type
  Device* = ref object of DeviceInfo
  Device00* = object of DeviceInfo00

proc gupnp_device_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Device()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  Context* = ref object of gssdp.Client
  Context00* = object of gssdp.Client00

proc gupnp_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Context()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gupnp_context_new(iface: cstring; port: uint32; error: ptr ptr glib.Error = nil): ptr Context00 {.
    importc, libprag.}

proc newContext*(iface: cstring = nil; port: int): Context {.deprecated.}  =
  var gerror: ptr glib.Error
  let gobj = gupnp_context_new(iface, uint32(port), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContext*(tdesc: typedesc; iface: cstring = nil; port: int): tdesc {.deprecated.}  =
  var gerror: ptr glib.Error
  assert(result is Context)
  let gobj = gupnp_context_new(iface, uint32(port), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContext*[T](result: var T; iface: cstring = nil; port: int) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Context)
  let gobj = gupnp_context_new(iface, uint32(port), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_context_new_for_address(`addr`: ptr gio.InetAddress00; port: uint16;
    udaVersion: gssdp.UDAVersion; error: ptr ptr glib.Error = nil): ptr Context00 {.
    importc, libprag.}

proc newContextForAddress*(`addr`: gio.InetAddress = nil; port: uint16;
    udaVersion: gssdp.UDAVersion): Context =
  var gerror: ptr glib.Error
  let gobj = gupnp_context_new_for_address(if `addr`.isNil: nil else: cast[ptr gio.InetAddress00](`addr`.impl), port, udaVersion, addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextForAddress*(tdesc: typedesc; `addr`: gio.InetAddress = nil; port: uint16;
    udaVersion: gssdp.UDAVersion): tdesc =
  var gerror: ptr glib.Error
  assert(result is Context)
  let gobj = gupnp_context_new_for_address(if `addr`.isNil: nil else: cast[ptr gio.InetAddress00](`addr`.impl), port, udaVersion, addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextForAddress*[T](result: var T; `addr`: gio.InetAddress = nil; port: uint16;
    udaVersion: gssdp.UDAVersion) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Context)
  let gobj = gupnp_context_new_for_address(if `addr`.isNil: nil else: cast[ptr gio.InetAddress00](`addr`.impl), port, udaVersion, addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_context_new_full(iface: cstring; `addr`: ptr gio.InetAddress00;
    port: uint16; udaVersion: gssdp.UDAVersion; error: ptr ptr glib.Error = nil): ptr Context00 {.
    importc, libprag.}

proc newContextFull*(iface: cstring = nil; `addr`: gio.InetAddress = nil;
    port: uint16; udaVersion: gssdp.UDAVersion): Context =
  var gerror: ptr glib.Error
  let gobj = gupnp_context_new_full(iface, if `addr`.isNil: nil else: cast[ptr gio.InetAddress00](`addr`.impl), port, udaVersion, addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextFull*(tdesc: typedesc; iface: cstring = nil; `addr`: gio.InetAddress = nil;
    port: uint16; udaVersion: gssdp.UDAVersion): tdesc =
  var gerror: ptr glib.Error
  assert(result is Context)
  let gobj = gupnp_context_new_full(iface, if `addr`.isNil: nil else: cast[ptr gio.InetAddress00](`addr`.impl), port, udaVersion, addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextFull*[T](result: var T; iface: cstring = nil; `addr`: gio.InetAddress = nil;
    port: uint16; udaVersion: gssdp.UDAVersion) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Context)
  let gobj = gupnp_context_new_full(iface, if `addr`.isNil: nil else: cast[ptr gio.InetAddress00](`addr`.impl), port, udaVersion, addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_context_add_server_handler(self: ptr Context00; useAcl: gboolean;
    path: cstring; callback: ServerCallback; userData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc addServerHandler*(self: Context; useAcl: bool; path: cstring;
    callback: ServerCallback; userData: pointer; destroy: DestroyNotify) =
  gupnp_context_add_server_handler(cast[ptr Context00](self.impl), gboolean(useAcl), path, callback, userData, destroy)

proc gupnp_context_get_acl(self: ptr Context00): ptr Acl00 {.
    importc, libprag.}

proc getAcl*(self: Context): Acl =
  let gobj = gupnp_context_get_acl(cast[ptr Context00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc acl*(self: Context): Acl =
  let gobj = gupnp_context_get_acl(cast[ptr Context00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_context_get_default_language(self: ptr Context00): cstring {.
    importc, libprag.}

proc getDefaultLanguage*(self: Context): string =
  result = $gupnp_context_get_default_language(cast[ptr Context00](self.impl))

proc defaultLanguage*(self: Context): string =
  result = $gupnp_context_get_default_language(cast[ptr Context00](self.impl))

proc gupnp_context_get_port(self: ptr Context00): uint32 {.
    importc, libprag.}

proc getPort*(self: Context): int =
  int(gupnp_context_get_port(cast[ptr Context00](self.impl)))

proc port*(self: Context): int =
  int(gupnp_context_get_port(cast[ptr Context00](self.impl)))

proc gupnp_context_get_server(self: ptr Context00): ptr soup3.Server00 {.
    importc, libprag.}

proc getServer*(self: Context): soup3.Server =
  let gobj = gupnp_context_get_server(cast[ptr Context00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup3.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc server*(self: Context): soup3.Server =
  let gobj = gupnp_context_get_server(cast[ptr Context00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup3.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_context_get_session(self: ptr Context00): ptr soup3.Session00 {.
    importc, libprag.}

proc getSession*(self: Context): soup3.Session =
  let gobj = gupnp_context_get_session(cast[ptr Context00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup3.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc session*(self: Context): soup3.Session =
  let gobj = gupnp_context_get_session(cast[ptr Context00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup3.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_context_get_subscription_timeout(self: ptr Context00): uint32 {.
    importc, libprag.}

proc getSubscriptionTimeout*(self: Context): int =
  int(gupnp_context_get_subscription_timeout(cast[ptr Context00](self.impl)))

proc subscriptionTimeout*(self: Context): int =
  int(gupnp_context_get_subscription_timeout(cast[ptr Context00](self.impl)))

proc gupnp_context_host_path(self: ptr Context00; localPath: cstring; serverPath: cstring) {.
    importc, libprag.}

proc hostPath*(self: Context; localPath: cstring; serverPath: cstring) =
  gupnp_context_host_path(cast[ptr Context00](self.impl), localPath, serverPath)

proc gupnp_context_host_path_for_agent(self: ptr Context00; localPath: cstring;
    serverPath: cstring; userAgent: ptr glib.Regex00): gboolean {.
    importc, libprag.}

proc hostPathForAgent*(self: Context; localPath: cstring;
    serverPath: cstring; userAgent: glib.Regex): bool =
  toBool(gupnp_context_host_path_for_agent(cast[ptr Context00](self.impl), localPath, serverPath, cast[ptr glib.Regex00](userAgent.impl)))

proc gupnp_context_remove_server_handler(self: ptr Context00; path: cstring) {.
    importc, libprag.}

proc removeServerHandler*(self: Context; path: cstring) =
  gupnp_context_remove_server_handler(cast[ptr Context00](self.impl), path)

proc gupnp_context_rewrite_uri(self: ptr Context00; uri: cstring): cstring {.
    importc, libprag.}

proc rewriteUri*(self: Context; uri: cstring): string =
  let resul0 = gupnp_context_rewrite_uri(cast[ptr Context00](self.impl), uri)
  result = $resul0
  cogfree(resul0)

proc gupnp_context_set_acl(self: ptr Context00; acl: ptr Acl00) {.
    importc, libprag.}

proc setAcl*(self: Context; acl: Acl = nil) =
  gupnp_context_set_acl(cast[ptr Context00](self.impl), if acl.isNil: nil else: cast[ptr Acl00](acl.impl))

proc `acl=`*(self: Context; acl: Acl = nil) =
  gupnp_context_set_acl(cast[ptr Context00](self.impl), if acl.isNil: nil else: cast[ptr Acl00](acl.impl))

proc gupnp_context_set_default_language(self: ptr Context00; language: cstring) {.
    importc, libprag.}

proc setDefaultLanguage*(self: Context; language: cstring) =
  gupnp_context_set_default_language(cast[ptr Context00](self.impl), language)

proc `defaultLanguage=`*(self: Context; language: cstring) =
  gupnp_context_set_default_language(cast[ptr Context00](self.impl), language)

proc gupnp_context_set_subscription_timeout(self: ptr Context00; timeout: uint32) {.
    importc, libprag.}

proc setSubscriptionTimeout*(self: Context; timeout: int) =
  gupnp_context_set_subscription_timeout(cast[ptr Context00](self.impl), uint32(timeout))

proc `subscriptionTimeout=`*(self: Context; timeout: int) =
  gupnp_context_set_subscription_timeout(cast[ptr Context00](self.impl), uint32(timeout))

proc gupnp_context_unhost_path(self: ptr Context00; serverPath: cstring) {.
    importc, libprag.}

proc unhostPath*(self: Context; serverPath: cstring) =
  gupnp_context_unhost_path(cast[ptr Context00](self.impl), serverPath)

proc gupnp_device_info_get_context(self: ptr DeviceInfo00): ptr Context00 {.
    importc, libprag.}

proc getContext*(self: DeviceInfo): Context =
  let gobj = gupnp_device_info_get_context(cast[ptr DeviceInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc context*(self: DeviceInfo): Context =
  let gobj = gupnp_device_info_get_context(cast[ptr DeviceInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ResourceFactory* = ref object of gobject.Object
  ResourceFactory00* = object of gobject.Object00

proc gupnp_resource_factory_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ResourceFactory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gupnp_resource_factory_new(): ptr ResourceFactory00 {.
    importc, libprag.}

proc newResourceFactory*(): ResourceFactory =
  let gobj = gupnp_resource_factory_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newResourceFactory*(tdesc: typedesc): tdesc =
  assert(result is ResourceFactory)
  let gobj = gupnp_resource_factory_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initResourceFactory*[T](result: var T) {.deprecated.} =
  assert(result is ResourceFactory)
  let gobj = gupnp_resource_factory_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_resource_factory_get_default(): ptr ResourceFactory00 {.
    importc, libprag.}

proc getDefaultResourceFactory*(): ResourceFactory =
  let gobj = gupnp_resource_factory_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_resource_factory_register_resource_proxy_type(self: ptr ResourceFactory00;
    upnpType: cstring; `type`: GType) {.
    importc, libprag.}

proc registerResourceProxyType*(self: ResourceFactory;
    upnpType: cstring; `type`: GType) =
  gupnp_resource_factory_register_resource_proxy_type(cast[ptr ResourceFactory00](self.impl), upnpType, `type`)

proc gupnp_resource_factory_register_resource_type(self: ptr ResourceFactory00;
    upnpType: cstring; `type`: GType) {.
    importc, libprag.}

proc registerResourceType*(self: ResourceFactory;
    upnpType: cstring; `type`: GType) =
  gupnp_resource_factory_register_resource_type(cast[ptr ResourceFactory00](self.impl), upnpType, `type`)

proc gupnp_resource_factory_unregister_resource_proxy_type(self: ptr ResourceFactory00;
    upnpType: cstring): gboolean {.
    importc, libprag.}

proc unregisterResourceProxyType*(self: ResourceFactory;
    upnpType: cstring): bool =
  toBool(gupnp_resource_factory_unregister_resource_proxy_type(cast[ptr ResourceFactory00](self.impl), upnpType))

proc gupnp_resource_factory_unregister_resource_type(self: ptr ResourceFactory00;
    upnpType: cstring): gboolean {.
    importc, libprag.}

proc unregisterResourceType*(self: ResourceFactory;
    upnpType: cstring): bool =
  toBool(gupnp_resource_factory_unregister_resource_type(cast[ptr ResourceFactory00](self.impl), upnpType))

proc gupnp_device_info_get_resource_factory(self: ptr DeviceInfo00): ptr ResourceFactory00 {.
    importc, libprag.}

proc getResourceFactory*(self: DeviceInfo): ResourceFactory =
  let gobj = gupnp_device_info_get_resource_factory(cast[ptr DeviceInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc resourceFactory*(self: DeviceInfo): ResourceFactory =
  let gobj = gupnp_device_info_get_resource_factory(cast[ptr DeviceInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ServiceInfo* = ref object of gobject.Object
  ServiceInfo00* = object of gobject.Object00

proc gupnp_service_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ServiceInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gupnp_service_info_get_context(self: ptr ServiceInfo00): ptr Context00 {.
    importc, libprag.}

proc getContext*(self: ServiceInfo): Context =
  let gobj = gupnp_service_info_get_context(cast[ptr ServiceInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc context*(self: ServiceInfo): Context =
  let gobj = gupnp_service_info_get_context(cast[ptr ServiceInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_service_info_get_control_url(self: ptr ServiceInfo00): cstring {.
    importc, libprag.}

proc getControlUrl*(self: ServiceInfo): string =
  let resul0 = gupnp_service_info_get_control_url(cast[ptr ServiceInfo00](self.impl))
  result = $resul0
  cogfree(resul0)

proc controlUrl*(self: ServiceInfo): string =
  let resul0 = gupnp_service_info_get_control_url(cast[ptr ServiceInfo00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gupnp_service_info_get_event_subscription_url(self: ptr ServiceInfo00): cstring {.
    importc, libprag.}

proc getEventSubscriptionUrl*(self: ServiceInfo): string =
  let resul0 = gupnp_service_info_get_event_subscription_url(cast[ptr ServiceInfo00](self.impl))
  result = $resul0
  cogfree(resul0)

proc eventSubscriptionUrl*(self: ServiceInfo): string =
  let resul0 = gupnp_service_info_get_event_subscription_url(cast[ptr ServiceInfo00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gupnp_service_info_get_id(self: ptr ServiceInfo00): cstring {.
    importc, libprag.}

proc getId*(self: ServiceInfo): string =
  let resul0 = gupnp_service_info_get_id(cast[ptr ServiceInfo00](self.impl))
  result = $resul0
  cogfree(resul0)

proc id*(self: ServiceInfo): string =
  let resul0 = gupnp_service_info_get_id(cast[ptr ServiceInfo00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gupnp_service_info_get_location(self: ptr ServiceInfo00): cstring {.
    importc, libprag.}

proc getLocation*(self: ServiceInfo): string =
  result = $gupnp_service_info_get_location(cast[ptr ServiceInfo00](self.impl))

proc location*(self: ServiceInfo): string =
  result = $gupnp_service_info_get_location(cast[ptr ServiceInfo00](self.impl))

proc gupnp_service_info_get_scpd_url(self: ptr ServiceInfo00): cstring {.
    importc, libprag.}

proc getScpdUrl*(self: ServiceInfo): string =
  let resul0 = gupnp_service_info_get_scpd_url(cast[ptr ServiceInfo00](self.impl))
  result = $resul0
  cogfree(resul0)

proc scpdUrl*(self: ServiceInfo): string =
  let resul0 = gupnp_service_info_get_scpd_url(cast[ptr ServiceInfo00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gupnp_service_info_get_service_type(self: ptr ServiceInfo00): cstring {.
    importc, libprag.}

proc getServiceType*(self: ServiceInfo): string =
  result = $gupnp_service_info_get_service_type(cast[ptr ServiceInfo00](self.impl))

proc serviceType*(self: ServiceInfo): string =
  result = $gupnp_service_info_get_service_type(cast[ptr ServiceInfo00](self.impl))

proc gupnp_service_info_get_udn(self: ptr ServiceInfo00): cstring {.
    importc, libprag.}

proc getUdn*(self: ServiceInfo): string =
  result = $gupnp_service_info_get_udn(cast[ptr ServiceInfo00](self.impl))

proc udn*(self: ServiceInfo): string =
  result = $gupnp_service_info_get_udn(cast[ptr ServiceInfo00](self.impl))

proc gupnp_service_info_get_url_base(self: ptr ServiceInfo00): ptr glib.Uri00 {.
    importc, libprag.}

proc getUrlBase*(self: ServiceInfo): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = gupnp_service_info_get_url_base(cast[ptr ServiceInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc urlBase*(self: ServiceInfo): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = gupnp_service_info_get_url_base(cast[ptr ServiceInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc gupnp_service_info_introspect_async(self: ptr ServiceInfo00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc introspectAsync*(self: ServiceInfo; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  gupnp_service_info_introspect_async(cast[ptr ServiceInfo00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gupnp_device_info_get_service(self: ptr DeviceInfo00; `type`: cstring): ptr ServiceInfo00 {.
    importc, libprag.}

proc getService*(self: DeviceInfo; `type`: cstring): ServiceInfo =
  let gobj = gupnp_device_info_get_service(cast[ptr DeviceInfo00](self.impl), `type`)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_device_info_list_services(self: ptr DeviceInfo00): ptr glib.List {.
    importc, libprag.}

proc listServices*(self: DeviceInfo): seq[ServiceInfo] =
  let resul0 = gupnp_device_info_list_services(cast[ptr DeviceInfo00](self.impl))
  if resul0.isNil:
    return
  result = glistObjects2seq(ServiceInfo, resul0, true)
  g_list_free(resul0)

type
  ServiceAction00* {.pure.} = object
  ServiceAction* = ref object
    impl*: ptr ServiceAction00
    ignoreFinalizer*: bool

proc gupnp_service_action_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGUPnPServiceAction*(self: ServiceAction) =
  if not self.ignoreFinalizer:
    boxedFree(gupnp_service_action_get_type(), cast[ptr ServiceAction00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ServiceAction()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gupnp_service_action_get_type(), cast[ptr ServiceAction00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ServiceAction) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGUPnPServiceAction)

proc gupnp_service_action_get_argument_count(self: ptr ServiceAction00): uint32 {.
    importc, libprag.}

proc getArgumentCount*(self: ServiceAction): int =
  int(gupnp_service_action_get_argument_count(cast[ptr ServiceAction00](self.impl)))

proc argumentCount*(self: ServiceAction): int =
  int(gupnp_service_action_get_argument_count(cast[ptr ServiceAction00](self.impl)))

proc gupnp_service_action_get_gvalue(self: ptr ServiceAction00; argument: cstring;
    `type`: GType): ptr gobject.Value {.
    importc, libprag.}

proc getValue*(self: ServiceAction; argument: cstring;
    `type`: GType): ptr gobject.Value =
  gupnp_service_action_get_gvalue(cast[ptr ServiceAction00](self.impl), argument, `type`)

proc gupnp_service_action_get_locales(self: ptr ServiceAction00): ptr glib.List {.
    importc, libprag.}

proc getLocales*(self: ServiceAction): seq[cstring] =
  let resul0 = gupnp_service_action_get_locales(cast[ptr ServiceAction00](self.impl))
  g_list_free(resul0)

proc locales*(self: ServiceAction): seq[cstring] =
  let resul0 = gupnp_service_action_get_locales(cast[ptr ServiceAction00](self.impl))
  g_list_free(resul0)

proc gupnp_service_action_get_message(self: ptr ServiceAction00): ptr soup3.ServerMessage00 {.
    importc, libprag.}

proc getMessage*(self: ServiceAction): soup3.ServerMessage =
  let gobj = gupnp_service_action_get_message(cast[ptr ServiceAction00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup3.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc message*(self: ServiceAction): soup3.ServerMessage =
  let gobj = gupnp_service_action_get_message(cast[ptr ServiceAction00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup3.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_service_action_get_name(self: ptr ServiceAction00): cstring {.
    importc, libprag.}

proc getName*(self: ServiceAction): string =
  result = $gupnp_service_action_get_name(cast[ptr ServiceAction00](self.impl))

proc name*(self: ServiceAction): string =
  result = $gupnp_service_action_get_name(cast[ptr ServiceAction00](self.impl))

proc gupnp_service_action_get_values(self: ptr ServiceAction00; argNames: ptr glib.List;
    argTypes: ptr glib.List): ptr glib.List {.
    importc, libprag.}

proc getValues*(self: ServiceAction; argNames: seq[cstring];
    argTypes: seq[GType]): seq[gobject.Value] =
  var tempResGL = seq2GList(argTypes)
  let resul0 = gupnp_service_action_get_values(cast[ptr ServiceAction00](self.impl), tempResGL, tempResGL)
  g_list_free(tempResGL)
  result = glistStructs2seq[gobject.Value](resul0, false)
  g_list_free(resul0)

proc gupnp_service_action_return_error(self: ptr ServiceAction00; errorCode: uint32;
    errorDescription: cstring) {.
    importc, libprag.}

proc returnError*(self: ServiceAction; errorCode: int;
    errorDescription: cstring) =
  gupnp_service_action_return_error(cast[ptr ServiceAction00](self.impl), uint32(errorCode), errorDescription)

proc gupnp_service_action_return_success(self: ptr ServiceAction00) {.
    importc, libprag.}

proc returnSuccess*(self: ServiceAction) =
  gupnp_service_action_return_success(cast[ptr ServiceAction00](self.impl))

proc gupnp_service_action_set_value(self: ptr ServiceAction00; argument: cstring;
    value: gobject.Value) {.
    importc, libprag.}

proc setValue*(self: ServiceAction; argument: cstring;
    value: gobject.Value) =
  gupnp_service_action_set_value(cast[ptr ServiceAction00](self.impl), argument, value)

proc gupnp_service_action_set_values(self: ptr ServiceAction00; argNames: ptr glib.List;
    argValues: ptr glib.List) {.
    importc, libprag.}

proc setValues*(self: ServiceAction; argNames: seq[cstring];
    argValues: seq[gobject.Value]) =
  var tempResGL = seq2GList(argValues)
  gupnp_service_action_set_values(cast[ptr ServiceAction00](self.impl), tempResGL, tempResGL)
  g_list_free(tempResGL)

type
  Service* = ref object of ServiceInfo
  Service00* = object of ServiceInfo00

proc gupnp_service_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Service()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActionInvoked*(self: Service;  p: proc (self: ptr Service00; action: ptr ServiceAction00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "action-invoked", cast[GCallback](p), xdata, nil, cf)

proc scNotifyFailed*(self: Service;  p: proc (self: ptr Service00; callbackUrl: ptr glib.List; reason: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "notify-failed", cast[GCallback](p), xdata, nil, cf)

proc scQueryVariable*(self: Service;  p: proc (self: ptr Service00; variable: cstring; value: var gobject.Value; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "query-variable", cast[GCallback](p), xdata, nil, cf)

proc gupnp_service_action_invoked(self: ptr Service00; action: ptr ServiceAction00) {.
    importc, libprag.}

proc actionInvoked*(self: Service; action: ServiceAction) =
  gupnp_service_action_invoked(cast[ptr Service00](self.impl), cast[ptr ServiceAction00](action.impl))

proc gupnp_service_freeze_notify(self: ptr Service00) {.
    importc, libprag.}

proc freezeNotify*(self: Service) =
  gupnp_service_freeze_notify(cast[ptr Service00](self.impl))

proc gupnp_service_notify_failed(self: ptr Service00; callbackUrls: ptr glib.List;
    reason: ptr glib.Error) {.
    importc, libprag.}

proc notifyFailed*(self: Service; callbackUrls: seq[glib.Uri];
    reason: ptr glib.Error) =
  var tempResGL = seq2GList(callbackUrls)
  gupnp_service_notify_failed(cast[ptr Service00](self.impl), tempResGL, reason)
  g_list_free(tempResGL)

proc gupnp_service_notify_value(self: ptr Service00; variable: cstring; value: gobject.Value) {.
    importc, libprag.}

proc notifyValue*(self: Service; variable: cstring; value: gobject.Value) =
  gupnp_service_notify_value(cast[ptr Service00](self.impl), variable, value)

proc gupnp_service_query_variable(self: ptr Service00; variable: cstring;
    value: gobject.Value) {.
    importc, libprag.}

proc queryVariable*(self: Service; variable: cstring; value: gobject.Value) =
  gupnp_service_query_variable(cast[ptr Service00](self.impl), variable, value)

proc gupnp_service_thaw_notify(self: ptr Service00) {.
    importc, libprag.}

proc thawNotify*(self: Service) =
  gupnp_service_thaw_notify(cast[ptr Service00](self.impl))

proc gupnp_acl_is_allowed(self: ptr Acl00; device: ptr Device00; service: ptr Service00;
    path: cstring; address: cstring; agent: cstring): gboolean {.
    importc, libprag.}

proc isAllowed*(self: Acl; device: Device = nil; service: Service = nil;
    path: cstring; address: cstring; agent: cstring = nil): bool =
  toBool(gupnp_acl_is_allowed(cast[ptr Acl00](self.impl), if device.isNil: nil else: cast[ptr Device00](device.impl), if service.isNil: nil else: cast[ptr Service00](service.impl), path, address, agent))

proc gupnp_acl_is_allowed_async(self: ptr Acl00; device: ptr Device00; service: ptr Service00;
    path: cstring; address: cstring; agent: cstring; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc isAllowedAsync*(self: Acl; device: Device = nil; service: Service = nil;
    path: cstring; address: cstring; agent: cstring = nil; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  gupnp_acl_is_allowed_async(cast[ptr Acl00](self.impl), if device.isNil: nil else: cast[ptr Device00](device.impl), if service.isNil: nil else: cast[ptr Service00](service.impl), path, address, agent, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

type
  ServiceIntrospection* = ref object of gobject.Object
  ServiceIntrospection00* = object of gobject.Object00

proc gupnp_service_introspection_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ServiceIntrospection()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gupnp_service_introspection_list_action_names(self: ptr ServiceIntrospection00): ptr glib.List {.
    importc, libprag.}

proc listActionNames*(self: ServiceIntrospection): seq[cstring] =
  discard

proc gupnp_service_introspection_list_state_variable_names(self: ptr ServiceIntrospection00): ptr glib.List {.
    importc, libprag.}

proc listStateVariableNames*(self: ServiceIntrospection): seq[cstring] =
  discard

proc gupnp_service_info_introspect_finish(self: ptr ServiceInfo00; res: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr ServiceIntrospection00 {.
    importc, libprag.}

proc introspectFinish*(self: ServiceInfo; res: gio.AsyncResult): ServiceIntrospection =
  var gerror: ptr glib.Error
  let gobj = gupnp_service_info_introspect_finish(cast[ptr ServiceInfo00](self.impl), cast[ptr gio.AsyncResult00](res.impl), addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ServiceActionInfo00* {.pure.} = object
  ServiceActionInfo* = ref object
    impl*: ptr ServiceActionInfo00
    ignoreFinalizer*: bool

proc gupnp_service_action_info_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGUPnPServiceActionInfo*(self: ServiceActionInfo) =
  if not self.ignoreFinalizer:
    boxedFree(gupnp_service_action_info_get_type(), cast[ptr ServiceActionInfo00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ServiceActionInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gupnp_service_action_info_get_type(), cast[ptr ServiceActionInfo00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ServiceActionInfo) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGUPnPServiceActionInfo)

proc gupnp_service_introspection_get_action(self: ptr ServiceIntrospection00;
    actionName: cstring): ptr ServiceActionInfo00 {.
    importc, libprag.}

proc getAction*(self: ServiceIntrospection; actionName: cstring): ServiceActionInfo =
  let impl0 = gupnp_service_introspection_get_action(cast[ptr ServiceIntrospection00](self.impl), actionName)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGUPnPServiceActionInfo)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gupnp_service_action_info_get_type(), impl0))

proc gupnp_service_introspection_list_actions(self: ptr ServiceIntrospection00): ptr glib.List {.
    importc, libprag.}

proc listActions*(self: ServiceIntrospection): seq[ServiceActionInfo] =
  discard

type
  ServiceStateVariableInfo00* {.pure.} = object
  ServiceStateVariableInfo* = ref object
    impl*: ptr ServiceStateVariableInfo00
    ignoreFinalizer*: bool

proc gupnp_service_state_variable_info_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGUPnPServiceStateVariableInfo*(self: ServiceStateVariableInfo) =
  if not self.ignoreFinalizer:
    boxedFree(gupnp_service_state_variable_info_get_type(), cast[ptr ServiceStateVariableInfo00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ServiceStateVariableInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gupnp_service_state_variable_info_get_type(), cast[ptr ServiceStateVariableInfo00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ServiceStateVariableInfo) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGUPnPServiceStateVariableInfo)

proc gupnp_service_introspection_get_state_variable(self: ptr ServiceIntrospection00;
    variableName: cstring): ptr ServiceStateVariableInfo00 {.
    importc, libprag.}

proc getStateVariable*(self: ServiceIntrospection;
    variableName: cstring): ServiceStateVariableInfo =
  let impl0 = gupnp_service_introspection_get_state_variable(cast[ptr ServiceIntrospection00](self.impl), variableName)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGUPnPServiceStateVariableInfo)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gupnp_service_state_variable_info_get_type(), impl0))

proc gupnp_service_introspection_list_state_variables(self: ptr ServiceIntrospection00): ptr glib.List {.
    importc, libprag.}

proc listStateVariables*(self: ServiceIntrospection): seq[ServiceStateVariableInfo] =
  discard



type
  ContextFilter* = ref object of gobject.Object
  ContextFilter00* = object of gobject.Object00

proc gupnp_context_filter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContextFilter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gupnp_context_filter_add_entry(self: ptr ContextFilter00; entry: cstring): gboolean {.
    importc, libprag.}

proc addEntry*(self: ContextFilter; entry: cstring): bool =
  toBool(gupnp_context_filter_add_entry(cast[ptr ContextFilter00](self.impl), entry))

proc gupnp_context_filter_add_entryv(self: ptr ContextFilter00; entries: ptr cstring) {.
    importc, libprag.}

proc addEntryv*(self: ContextFilter; entries: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gupnp_context_filter_add_entryv(cast[ptr ContextFilter00](self.impl), seq2CstringArray(entries, fs469n23))

proc gupnp_context_filter_check_context(self: ptr ContextFilter00; context: ptr Context00): gboolean {.
    importc, libprag.}

proc checkContext*(self: ContextFilter; context: Context): bool =
  toBool(gupnp_context_filter_check_context(cast[ptr ContextFilter00](self.impl), cast[ptr Context00](context.impl)))

proc gupnp_context_filter_clear(self: ptr ContextFilter00) {.
    importc, libprag.}

proc clear*(self: ContextFilter) =
  gupnp_context_filter_clear(cast[ptr ContextFilter00](self.impl))

proc gupnp_context_filter_get_enabled(self: ptr ContextFilter00): gboolean {.
    importc, libprag.}

proc getEnabled*(self: ContextFilter): bool =
  toBool(gupnp_context_filter_get_enabled(cast[ptr ContextFilter00](self.impl)))

proc enabled*(self: ContextFilter): bool =
  toBool(gupnp_context_filter_get_enabled(cast[ptr ContextFilter00](self.impl)))

proc gupnp_context_filter_get_entries(self: ptr ContextFilter00): ptr glib.List {.
    importc, libprag.}

proc getEntries*(self: ContextFilter): seq[cstring] =
  let resul0 = gupnp_context_filter_get_entries(cast[ptr ContextFilter00](self.impl))
  if resul0.isNil:
    return
  g_list_free(resul0)

proc entries*(self: ContextFilter): seq[cstring] =
  let resul0 = gupnp_context_filter_get_entries(cast[ptr ContextFilter00](self.impl))
  if resul0.isNil:
    return
  g_list_free(resul0)

proc gupnp_context_filter_is_empty(self: ptr ContextFilter00): gboolean {.
    importc, libprag.}

proc isEmpty*(self: ContextFilter): bool =
  toBool(gupnp_context_filter_is_empty(cast[ptr ContextFilter00](self.impl)))

proc gupnp_context_filter_remove_entry(self: ptr ContextFilter00; entry: cstring): gboolean {.
    importc, libprag.}

proc removeEntry*(self: ContextFilter; entry: cstring): bool =
  toBool(gupnp_context_filter_remove_entry(cast[ptr ContextFilter00](self.impl), entry))

proc gupnp_context_filter_set_enabled(self: ptr ContextFilter00; enable: gboolean) {.
    importc, libprag.}

proc setEnabled*(self: ContextFilter; enable: bool = true) =
  gupnp_context_filter_set_enabled(cast[ptr ContextFilter00](self.impl), gboolean(enable))

proc `enabled=`*(self: ContextFilter; enable: bool) =
  gupnp_context_filter_set_enabled(cast[ptr ContextFilter00](self.impl), gboolean(enable))

type
  ContextManager* = ref object of gobject.Object
  ContextManager00* = object of gobject.Object00

proc gupnp_context_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContextManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scContextAvailable*(self: ContextManager;  p: proc (self: ptr ContextManager00; context: ptr Context00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "context-available", cast[GCallback](p), xdata, nil, cf)

proc scContextUnavailable*(self: ContextManager;  p: proc (self: ptr ContextManager00; context: ptr Context00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "context-unavailable", cast[GCallback](p), xdata, nil, cf)

proc gupnp_context_manager_create(port: uint32): ptr ContextManager00 {.
    importc, libprag.}

proc create*(port: int): ContextManager =
  let gobj = gupnp_context_manager_create(uint32(port))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_context_manager_create_full(udaVersion: gssdp.UDAVersion; family: gio.SocketFamily;
    port: uint32): ptr ContextManager00 {.
    importc, libprag.}

proc createFull*(udaVersion: gssdp.UDAVersion; family: gio.SocketFamily;
    port: int): ContextManager =
  let gobj = gupnp_context_manager_create_full(udaVersion, family, uint32(port))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_context_manager_get_context_filter(self: ptr ContextManager00): ptr ContextFilter00 {.
    importc, libprag.}

proc getContextFilter*(self: ContextManager): ContextFilter =
  let gobj = gupnp_context_manager_get_context_filter(cast[ptr ContextManager00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc contextFilter*(self: ContextManager): ContextFilter =
  let gobj = gupnp_context_manager_get_context_filter(cast[ptr ContextManager00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_context_manager_get_port(self: ptr ContextManager00): uint32 {.
    importc, libprag.}

proc getPort*(self: ContextManager): int =
  int(gupnp_context_manager_get_port(cast[ptr ContextManager00](self.impl)))

proc port*(self: ContextManager): int =
  int(gupnp_context_manager_get_port(cast[ptr ContextManager00](self.impl)))

proc gupnp_context_manager_get_socket_family(self: ptr ContextManager00): gio.SocketFamily {.
    importc, libprag.}

proc getSocketFamily*(self: ContextManager): gio.SocketFamily =
  gupnp_context_manager_get_socket_family(cast[ptr ContextManager00](self.impl))

proc socketFamily*(self: ContextManager): gio.SocketFamily =
  gupnp_context_manager_get_socket_family(cast[ptr ContextManager00](self.impl))

proc gupnp_context_manager_get_uda_version(self: ptr ContextManager00): gssdp.UDAVersion {.
    importc, libprag.}

proc getUdaVersion*(self: ContextManager): gssdp.UDAVersion =
  gupnp_context_manager_get_uda_version(cast[ptr ContextManager00](self.impl))

proc udaVersion*(self: ContextManager): gssdp.UDAVersion =
  gupnp_context_manager_get_uda_version(cast[ptr ContextManager00](self.impl))

proc gupnp_context_manager_rescan_control_points(self: ptr ContextManager00) {.
    importc, libprag.}

proc rescanControlPoints*(self: ContextManager) =
  gupnp_context_manager_rescan_control_points(cast[ptr ContextManager00](self.impl))

type
  DeviceProxy* = ref object of DeviceInfo
  DeviceProxy00* = object of DeviceInfo00

proc gupnp_device_proxy_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DeviceProxy()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  ServiceProxy* = ref object of ServiceInfo
  ServiceProxy00* = object of ServiceInfo00

proc gupnp_service_proxy_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ServiceProxy()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scSubscriptionLost*(self: ServiceProxy;  p: proc (self: ptr ServiceProxy00; error: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "subscription-lost", cast[GCallback](p), xdata, nil, cf)

proc gupnp_service_proxy_get_subscribed(self: ptr ServiceProxy00): gboolean {.
    importc, libprag.}

proc getSubscribed*(self: ServiceProxy): bool =
  toBool(gupnp_service_proxy_get_subscribed(cast[ptr ServiceProxy00](self.impl)))

proc subscribed*(self: ServiceProxy): bool =
  toBool(gupnp_service_proxy_get_subscribed(cast[ptr ServiceProxy00](self.impl)))

proc gupnp_service_proxy_set_credentials(self: ptr ServiceProxy00; user: cstring;
    password: cstring) {.
    importc, libprag.}

proc setCredentials*(self: ServiceProxy; user: cstring;
    password: cstring) =
  gupnp_service_proxy_set_credentials(cast[ptr ServiceProxy00](self.impl), user, password)

proc gupnp_service_proxy_set_subscribed(self: ptr ServiceProxy00; subscribed: gboolean) {.
    importc, libprag.}

proc setSubscribed*(self: ServiceProxy; subscribed: bool = true) =
  gupnp_service_proxy_set_subscribed(cast[ptr ServiceProxy00](self.impl), gboolean(subscribed))

proc `subscribed=`*(self: ServiceProxy; subscribed: bool) =
  gupnp_service_proxy_set_subscribed(cast[ptr ServiceProxy00](self.impl), gboolean(subscribed))

type
  ControlPoint* = ref object of gssdp.ResourceBrowser
  ControlPoint00* = object of gssdp.ResourceBrowser00

proc gupnp_control_point_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ControlPoint()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDeviceProxyAvailable*(self: ControlPoint;  p: proc (self: ptr ControlPoint00; proxy: ptr DeviceProxy00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "device-proxy-available", cast[GCallback](p), xdata, nil, cf)

proc scDeviceProxyUnavailable*(self: ControlPoint;  p: proc (self: ptr ControlPoint00; proxy: ptr DeviceProxy00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "device-proxy-unavailable", cast[GCallback](p), xdata, nil, cf)

proc scServiceProxyAvailable*(self: ControlPoint;  p: proc (self: ptr ControlPoint00; proxy: ptr ServiceProxy00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "service-proxy-available", cast[GCallback](p), xdata, nil, cf)

proc scServiceProxyUnavailable*(self: ControlPoint;  p: proc (self: ptr ControlPoint00; proxy: ptr ServiceProxy00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "service-proxy-unavailable", cast[GCallback](p), xdata, nil, cf)

proc gupnp_control_point_new(context: ptr Context00; target: cstring): ptr ControlPoint00 {.
    importc, libprag.}

proc newControlPoint*(context: Context; target: cstring): ControlPoint =
  let gobj = gupnp_control_point_new(cast[ptr Context00](context.impl), target)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newControlPoint*(tdesc: typedesc; context: Context; target: cstring): tdesc =
  assert(result is ControlPoint)
  let gobj = gupnp_control_point_new(cast[ptr Context00](context.impl), target)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initControlPoint*[T](result: var T; context: Context; target: cstring) {.deprecated.} =
  assert(result is ControlPoint)
  let gobj = gupnp_control_point_new(cast[ptr Context00](context.impl), target)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_control_point_new_full(context: ptr Context00; factory: ptr ResourceFactory00;
    target: cstring): ptr ControlPoint00 {.
    importc, libprag.}

proc newControlPointFull*(context: Context; factory: ResourceFactory;
    target: cstring): ControlPoint =
  let gobj = gupnp_control_point_new_full(cast[ptr Context00](context.impl), cast[ptr ResourceFactory00](factory.impl), target)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newControlPointFull*(tdesc: typedesc; context: Context; factory: ResourceFactory;
    target: cstring): tdesc =
  assert(result is ControlPoint)
  let gobj = gupnp_control_point_new_full(cast[ptr Context00](context.impl), cast[ptr ResourceFactory00](factory.impl), target)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initControlPointFull*[T](result: var T; context: Context; factory: ResourceFactory;
    target: cstring) {.deprecated.} =
  assert(result is ControlPoint)
  let gobj = gupnp_control_point_new_full(cast[ptr Context00](context.impl), cast[ptr ResourceFactory00](factory.impl), target)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_control_point_get_context(self: ptr ControlPoint00): ptr Context00 {.
    importc, libprag.}

proc getContext*(self: ControlPoint): Context =
  let gobj = gupnp_control_point_get_context(cast[ptr ControlPoint00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc context*(self: ControlPoint): Context =
  let gobj = gupnp_control_point_get_context(cast[ptr ControlPoint00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_control_point_get_resource_factory(self: ptr ControlPoint00): ptr ResourceFactory00 {.
    importc, libprag.}

proc getResourceFactory*(self: ControlPoint): ResourceFactory =
  let gobj = gupnp_control_point_get_resource_factory(cast[ptr ControlPoint00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc resourceFactory*(self: ControlPoint): ResourceFactory =
  let gobj = gupnp_control_point_get_resource_factory(cast[ptr ControlPoint00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_control_point_list_device_proxies(self: ptr ControlPoint00): ptr glib.List {.
    importc, libprag.}

proc listDeviceProxies*(self: ControlPoint): seq[DeviceProxy] =
  result = glistObjects2seq(DeviceProxy, gupnp_control_point_list_device_proxies(cast[ptr ControlPoint00](self.impl)), false)

proc gupnp_control_point_list_service_proxies(self: ptr ControlPoint00): ptr glib.List {.
    importc, libprag.}

proc listServiceProxies*(self: ControlPoint): seq[ServiceProxy] =
  result = glistObjects2seq(ServiceProxy, gupnp_control_point_list_service_proxies(cast[ptr ControlPoint00](self.impl)), false)

proc gupnp_context_manager_manage_control_point(self: ptr ContextManager00;
    controlPoint: ptr ControlPoint00) {.
    importc, libprag.}

proc manageControlPoint*(self: ContextManager; controlPoint: ControlPoint) =
  gupnp_context_manager_manage_control_point(cast[ptr ContextManager00](self.impl), cast[ptr ControlPoint00](controlPoint.impl))

type
  ServiceProxyAction00* {.pure.} = object
  ServiceProxyAction* = ref object
    impl*: ptr ServiceProxyAction00
    ignoreFinalizer*: bool

proc gupnp_service_proxy_action_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGUPnPServiceProxyAction*(self: ServiceProxyAction) =
  if not self.ignoreFinalizer:
    boxedFree(gupnp_service_proxy_action_get_type(), cast[ptr ServiceProxyAction00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ServiceProxyAction()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gupnp_service_proxy_action_get_type(), cast[ptr ServiceProxyAction00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ServiceProxyAction) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGUPnPServiceProxyAction)

proc gupnp_service_proxy_action_unref(self: ptr ServiceProxyAction00) {.
    importc, libprag.}

proc unref*(self: ServiceProxyAction) =
  gupnp_service_proxy_action_unref(cast[ptr ServiceProxyAction00](self.impl))

proc finalizerunref*(self: ServiceProxyAction) =
  if not self.ignoreFinalizer:
    gupnp_service_proxy_action_unref(cast[ptr ServiceProxyAction00](self.impl))

proc gupnp_service_proxy_action_new_plain(action: cstring): ptr ServiceProxyAction00 {.
    importc, libprag.}

proc newServiceProxyActionPlain*(action: cstring): ServiceProxyAction =
  fnew(result, gBoxedFreeGUPnPServiceProxyAction)
  result.impl = gupnp_service_proxy_action_new_plain(action)

proc newServiceProxyActionPlain*(tdesc: typedesc; action: cstring): tdesc =
  assert(result is ServiceProxyAction)
  fnew(result, gBoxedFreeGUPnPServiceProxyAction)
  result.impl = gupnp_service_proxy_action_new_plain(action)

proc initServiceProxyActionPlain*[T](result: var T; action: cstring) {.deprecated.} =
  assert(result is ServiceProxyAction)
  fnew(result, gBoxedFreeGUPnPServiceProxyAction)
  result.impl = gupnp_service_proxy_action_new_plain(action)

proc gupnp_service_proxy_action_add_argument(self: ptr ServiceProxyAction00;
    name: cstring; value: gobject.Value): ptr ServiceProxyAction00 {.
    importc, libprag.}

proc addArgument*(self: ServiceProxyAction; name: cstring;
    value: gobject.Value): ServiceProxyAction =
  fnew(result, gBoxedFreeGUPnPServiceProxyAction)
  result.impl = gupnp_service_proxy_action_add_argument(cast[ptr ServiceProxyAction00](self.impl), name, value)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gupnp_service_proxy_action_get_type(), result.impl))

proc gupnp_service_proxy_action_get_result_hash(self: ptr ServiceProxyAction00;
    outHash: var ptr HashTable00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getResultHash*(self: ServiceProxyAction;
    outHash: var ptr HashTable00): bool =
  var gerror: ptr glib.Error
  let resul0 = gupnp_service_proxy_action_get_result_hash(cast[ptr ServiceProxyAction00](self.impl), outHash, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gupnp_service_proxy_action_get_result_list(self: ptr ServiceProxyAction00;
    outNames: ptr glib.List; outTypes: ptr glib.List; outValues: var ptr glib.List;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getResultList*(self: ServiceProxyAction;
    outNames: seq[cstring]; outTypes: seq[GType]; outValues: var seq[gobject.Value]): bool =
  var tempResGL = seq2GList(outValues)
  var gerror: ptr glib.Error
  let resul0 = gupnp_service_proxy_action_get_result_list(cast[ptr ServiceProxyAction00](self.impl), tempResGL, tempResGL, tempResGL, addr gerror)
  g_list_free(tempResGL)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gupnp_service_proxy_action_ref(self: ptr ServiceProxyAction00): ptr ServiceProxyAction00 {.
    importc, libprag.}

proc `ref`*(self: ServiceProxyAction): ServiceProxyAction =
  let impl0 = gupnp_service_proxy_action_ref(cast[ptr ServiceProxyAction00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGUPnPServiceProxyAction)
  result.impl = impl0

proc gupnp_service_proxy_action_set(self: ptr ServiceProxyAction00; key: cstring;
    value: gobject.Value; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc set*(self: ServiceProxyAction; key: cstring;
    value: gobject.Value): bool =
  var gerror: ptr glib.Error
  let resul0 = gupnp_service_proxy_action_set(cast[ptr ServiceProxyAction00](self.impl), key, value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gupnp_service_proxy_action_new_from_list(action: cstring; inNames: ptr glib.List;
    inValues: ptr glib.List): ptr ServiceProxyAction00 {.
    importc, libprag.}

proc newServiceProxyActionFromList*(action: cstring; inNames: seq[cstring];
    inValues: seq[gobject.Value]): ServiceProxyAction =
  var tempResGL = seq2GList(inValues)
  fnew(result, gBoxedFreeGUPnPServiceProxyAction)
  result.impl = gupnp_service_proxy_action_new_from_list(action, tempResGL, tempResGL)

proc newServiceProxyActionFromList*(tdesc: typedesc; action: cstring; inNames: seq[cstring];
    inValues: seq[gobject.Value]): tdesc =
  var tempResGL = seq2GList(inValues)
  assert(result is ServiceProxyAction)
  fnew(result, gBoxedFreeGUPnPServiceProxyAction)
  result.impl = gupnp_service_proxy_action_new_from_list(action, tempResGL, tempResGL)

proc initServiceProxyActionFromList*[T](result: var T; action: cstring; inNames: seq[cstring];
    inValues: seq[gobject.Value]) {.deprecated.} =
  var tempResGL = seq2GList(inValues)
  assert(result is ServiceProxyAction)
  fnew(result, gBoxedFreeGUPnPServiceProxyAction)
  result.impl = gupnp_service_proxy_action_new_from_list(action, tempResGL, tempResGL)

proc gupnp_service_proxy_call_action(self: ptr ServiceProxy00; action: ptr ServiceProxyAction00;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): ptr ServiceProxyAction00 {.
    importc, libprag.}

proc callAction*(self: ServiceProxy; action: ServiceProxyAction;
    cancellable: gio.Cancellable = nil): ServiceProxyAction =
  var gerror: ptr glib.Error
  let impl0 = gupnp_service_proxy_call_action(cast[ptr ServiceProxy00](self.impl), cast[ptr ServiceProxyAction00](action.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGUPnPServiceProxyAction)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gupnp_service_proxy_action_get_type(), impl0))

proc gupnp_service_proxy_call_action_async(self: ptr ServiceProxy00; action: ptr ServiceProxyAction00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc callActionAsync*(self: ServiceProxy; action: ServiceProxyAction;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  gupnp_service_proxy_call_action_async(cast[ptr ServiceProxy00](self.impl), cast[ptr ServiceProxyAction00](action.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gupnp_service_proxy_call_action_finish(self: ptr ServiceProxy00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr ServiceProxyAction00 {.
    importc, libprag.}

proc callActionFinish*(self: ServiceProxy; resu: gio.AsyncResult): ServiceProxyAction =
  var gerror: ptr glib.Error
  let impl0 = gupnp_service_proxy_call_action_finish(cast[ptr ServiceProxy00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGUPnPServiceProxyAction)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gupnp_service_proxy_action_get_type(), impl0))

type
  ServiceProxyActionIter* = ref object of gobject.Object
  ServiceProxyActionIter00* = object of gobject.Object00

proc gupnp_service_proxy_action_iter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ServiceProxyActionIter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gupnp_service_proxy_action_iter_get_name(self: ptr ServiceProxyActionIter00): cstring {.
    importc, libprag.}

proc getName*(self: ServiceProxyActionIter): string =
  result = $gupnp_service_proxy_action_iter_get_name(cast[ptr ServiceProxyActionIter00](self.impl))

proc name*(self: ServiceProxyActionIter): string =
  result = $gupnp_service_proxy_action_iter_get_name(cast[ptr ServiceProxyActionIter00](self.impl))

proc gupnp_service_proxy_action_iter_get_value(self: ptr ServiceProxyActionIter00;
    value: var gobject.Value): gboolean {.
    importc, libprag.}

proc getValue*(self: ServiceProxyActionIter;
    value: var gobject.Value): bool =
  toBool(gupnp_service_proxy_action_iter_get_value(cast[ptr ServiceProxyActionIter00](self.impl), value))

proc gupnp_service_proxy_action_iter_next(self: ptr ServiceProxyActionIter00): gboolean {.
    importc, libprag.}

proc next*(self: ServiceProxyActionIter): bool =
  toBool(gupnp_service_proxy_action_iter_next(cast[ptr ServiceProxyActionIter00](self.impl)))

proc gupnp_service_proxy_action_iterate(self: ptr ServiceProxyAction00; error: ptr ptr glib.Error = nil): ptr ServiceProxyActionIter00 {.
    importc, libprag.}

proc iterate*(self: ServiceProxyAction): ServiceProxyActionIter =
  var gerror: ptr glib.Error
  let gobj = gupnp_service_proxy_action_iterate(cast[ptr ServiceProxyAction00](self.impl), addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  RootDevice* = ref object of Device
  RootDevice00* = object of Device00

proc gupnp_root_device_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RootDevice()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gupnp_root_device_new(context: ptr Context00; descriptionPath: cstring;
    descriptionFolder: cstring; error: ptr ptr glib.Error = nil): ptr RootDevice00 {.
    importc, libprag.}

proc newRootDevice*(context: Context; descriptionPath: cstring; descriptionFolder: cstring): RootDevice =
  var gerror: ptr glib.Error
  let gobj = gupnp_root_device_new(cast[ptr Context00](context.impl), descriptionPath, descriptionFolder, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newRootDevice*(tdesc: typedesc; context: Context; descriptionPath: cstring; descriptionFolder: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is RootDevice)
  let gobj = gupnp_root_device_new(cast[ptr Context00](context.impl), descriptionPath, descriptionFolder, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initRootDevice*[T](result: var T; context: Context; descriptionPath: cstring; descriptionFolder: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is RootDevice)
  let gobj = gupnp_root_device_new(cast[ptr Context00](context.impl), descriptionPath, descriptionFolder, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_root_device_get_available(self: ptr RootDevice00): gboolean {.
    importc, libprag.}

proc getAvailable*(self: RootDevice): bool =
  toBool(gupnp_root_device_get_available(cast[ptr RootDevice00](self.impl)))

proc available*(self: RootDevice): bool =
  toBool(gupnp_root_device_get_available(cast[ptr RootDevice00](self.impl)))

proc gupnp_root_device_get_description_dir(self: ptr RootDevice00): cstring {.
    importc, libprag.}

proc getDescriptionDir*(self: RootDevice): string =
  result = $gupnp_root_device_get_description_dir(cast[ptr RootDevice00](self.impl))

proc descriptionDir*(self: RootDevice): string =
  result = $gupnp_root_device_get_description_dir(cast[ptr RootDevice00](self.impl))

proc gupnp_root_device_get_description_document_name(self: ptr RootDevice00): cstring {.
    importc, libprag.}

proc getDescriptionDocumentName*(self: RootDevice): string =
  result = $gupnp_root_device_get_description_document_name(cast[ptr RootDevice00](self.impl))

proc descriptionDocumentName*(self: RootDevice): string =
  result = $gupnp_root_device_get_description_document_name(cast[ptr RootDevice00](self.impl))

proc gupnp_root_device_get_description_path(self: ptr RootDevice00): cstring {.
    importc, libprag.}

proc getDescriptionPath*(self: RootDevice): string =
  result = $gupnp_root_device_get_description_path(cast[ptr RootDevice00](self.impl))

proc descriptionPath*(self: RootDevice): string =
  result = $gupnp_root_device_get_description_path(cast[ptr RootDevice00](self.impl))

proc gupnp_root_device_get_ssdp_resource_group(self: ptr RootDevice00): ptr gssdp.ResourceGroup00 {.
    importc, libprag.}

proc getSsdpResourceGroup*(self: RootDevice): gssdp.ResourceGroup =
  let gobj = gupnp_root_device_get_ssdp_resource_group(cast[ptr RootDevice00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gssdp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc ssdpResourceGroup*(self: RootDevice): gssdp.ResourceGroup =
  let gobj = gupnp_root_device_get_ssdp_resource_group(cast[ptr RootDevice00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gssdp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_root_device_set_available(self: ptr RootDevice00; available: gboolean) {.
    importc, libprag.}

proc setAvailable*(self: RootDevice; available: bool = true) =
  gupnp_root_device_set_available(cast[ptr RootDevice00](self.impl), gboolean(available))

proc `available=`*(self: RootDevice; available: bool) =
  gupnp_root_device_set_available(cast[ptr RootDevice00](self.impl), gboolean(available))

proc gupnp_context_manager_manage_root_device(self: ptr ContextManager00;
    rootDevice: ptr RootDevice00) {.
    importc, libprag.}

proc manageRootDevice*(self: ContextManager; rootDevice: RootDevice) =
  gupnp_context_manager_manage_root_device(cast[ptr ContextManager00](self.impl), cast[ptr RootDevice00](rootDevice.impl))

type
  XMLDoc* = ref object of gobject.Object
  XMLDoc00* = object of gobject.Object00

proc gupnp_xml_doc_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(XMLDoc()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gupnp_xml_doc_new(xmlDoc: ptr libxml2.Doc00): ptr XMLDoc00 {.
    importc, libprag.}

proc newXMLDoc*(xmlDoc: libxml2.Doc): XMLDoc =
  let gobj = gupnp_xml_doc_new(cast[ptr libxml2.Doc00](xmlDoc.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newXMLDoc*(tdesc: typedesc; xmlDoc: libxml2.Doc): tdesc =
  assert(result is XMLDoc)
  let gobj = gupnp_xml_doc_new(cast[ptr libxml2.Doc00](xmlDoc.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initXMLDoc*[T](result: var T; xmlDoc: libxml2.Doc) {.deprecated.} =
  assert(result is XMLDoc)
  let gobj = gupnp_xml_doc_new(cast[ptr libxml2.Doc00](xmlDoc.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_xml_doc_new_from_path(path: cstring; error: ptr ptr glib.Error = nil): ptr XMLDoc00 {.
    importc, libprag.}

proc newXMLDocFromPath*(path: cstring): XMLDoc =
  var gerror: ptr glib.Error
  let gobj = gupnp_xml_doc_new_from_path(path, addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newXMLDocFromPath*(tdesc: typedesc; path: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is XMLDoc)
  let gobj = gupnp_xml_doc_new_from_path(path, addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initXMLDocFromPath*[T](result: var T; path: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is XMLDoc)
  let gobj = gupnp_xml_doc_new_from_path(path, addr gerror)
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
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gupnp_xml_doc_get_doc(self: ptr XMLDoc00): ptr libxml2.Doc00 {.
    importc, libprag.}

proc getDoc*(self: XMLDoc): libxml2.Doc =
  new(result)
  result.impl = gupnp_xml_doc_get_doc(cast[ptr XMLDoc00](self.impl))
  result.ignoreFinalizer = true

proc doc*(self: XMLDoc): libxml2.Doc =
  new(result)
  result.impl = gupnp_xml_doc_get_doc(cast[ptr XMLDoc00](self.impl))
  result.ignoreFinalizer = true

proc gupnp_root_device_new_full(context: ptr Context00; factory: ptr ResourceFactory00;
    descriptionDoc: ptr XMLDoc00; descriptionPath: cstring; descriptionFolder: cstring;
    error: ptr ptr glib.Error = nil): ptr RootDevice00 {.
    importc, libprag.}

proc newRootDeviceFull*(context: Context; factory: ResourceFactory;
    descriptionDoc: XMLDoc; descriptionPath: cstring; descriptionFolder: cstring): RootDevice =
  var gerror: ptr glib.Error
  let gobj = gupnp_root_device_new_full(cast[ptr Context00](context.impl), cast[ptr ResourceFactory00](factory.impl), cast[ptr XMLDoc00](descriptionDoc.impl), descriptionPath, descriptionFolder, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newRootDeviceFull*(tdesc: typedesc; context: Context; factory: ResourceFactory;
    descriptionDoc: XMLDoc; descriptionPath: cstring; descriptionFolder: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is RootDevice)
  let gobj = gupnp_root_device_new_full(cast[ptr Context00](context.impl), cast[ptr ResourceFactory00](factory.impl), cast[ptr XMLDoc00](descriptionDoc.impl), descriptionPath, descriptionFolder, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initRootDeviceFull*[T](result: var T; context: Context; factory: ResourceFactory;
    descriptionDoc: XMLDoc; descriptionPath: cstring; descriptionFolder: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is RootDevice)
  let gobj = gupnp_root_device_new_full(cast[ptr Context00](context.impl), cast[ptr ResourceFactory00](factory.impl), cast[ptr XMLDoc00](descriptionDoc.impl), descriptionPath, descriptionFolder, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gupnp.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ControlError* {.size: sizeof(cint), pure.} = enum
    invalidAction = 401
    invalidArgs = 402
    outOfSync = 403
    actionFailed = 501




type
  EventingError* {.size: sizeof(cint), pure.} = enum
    subscriptionFailed = 0
    subscriptionLost = 1
    notifyFailed = 2

type
  RootdeviceError* {.size: sizeof(cint), pure.} = enum
    noContext = 0
    noDescriptionPath = 1
    noDescriptionFolder = 2
    noNetwork = 3
    fail = 4

type
  ServerError* {.size: sizeof(cint), pure.} = enum
    internalServerError = 0
    notFound = 1
    notImplemented = 2
    invalidResponse = 3
    invalidUrl = 4
    other = 5

type
  ServiceActionArgDirection* {.size: sizeof(cint), pure.} = enum
    `in` = 0
    `out` = 1

type
  ServiceActionArgInfo00* {.pure.} = object
  ServiceActionArgInfo* = ref object
    impl*: ptr ServiceActionArgInfo00
    ignoreFinalizer*: bool

proc gupnp_service_action_arg_info_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGUPnPServiceActionArgInfo*(self: ServiceActionArgInfo) =
  if not self.ignoreFinalizer:
    boxedFree(gupnp_service_action_arg_info_get_type(), cast[ptr ServiceActionArgInfo00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ServiceActionArgInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gupnp_service_action_arg_info_get_type(), cast[ptr ServiceActionArgInfo00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ServiceActionArgInfo) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGUPnPServiceActionArgInfo)

type
  ServiceError* {.size: sizeof(cint), pure.} = enum
    autoconnect = 0

type
  ServiceIntrospectionError* {.size: sizeof(cint), pure.} = enum
    other = 0

type
  ServiceProxyActionCallback* = proc (proxy: ptr ServiceProxy00; action: ptr ServiceProxyAction00; userData: pointer) {.cdecl.}

type
  ServiceProxyNotifyCallback* = proc (proxy: ptr ServiceProxy00; variable: cstring; value: gobject.Value;
    userData: pointer) {.cdecl.}

proc gupnp_service_proxy_add_notify_full(self: ptr ServiceProxy00; variable: cstring;
    `type`: GType; callback: ServiceProxyNotifyCallback; userData: pointer;
    notify: DestroyNotify): gboolean {.
    importc, libprag.}

proc addNotify*(self: ServiceProxy; variable: cstring;
    `type`: GType; callback: ServiceProxyNotifyCallback; userData: pointer;
    notify: DestroyNotify): bool =
  toBool(gupnp_service_proxy_add_notify_full(cast[ptr ServiceProxy00](self.impl), variable, `type`, callback, userData, notify))

proc gupnp_service_proxy_add_raw_notify(self: ptr ServiceProxy00; callback: ServiceProxyNotifyCallback;
    userData: pointer; notify: DestroyNotify): gboolean {.
    importc, libprag.}

proc addRawNotify*(self: ServiceProxy; callback: ServiceProxyNotifyCallback;
    userData: pointer; notify: DestroyNotify): bool =
  toBool(gupnp_service_proxy_add_raw_notify(cast[ptr ServiceProxy00](self.impl), callback, userData, notify))

proc gupnp_service_proxy_remove_notify(self: ptr ServiceProxy00; variable: cstring;
    callback: ServiceProxyNotifyCallback; userData: pointer): gboolean {.
    importc, libprag.}

proc removeNotify*(self: ServiceProxy; variable: cstring;
    callback: ServiceProxyNotifyCallback; userData: pointer): bool =
  toBool(gupnp_service_proxy_remove_notify(cast[ptr ServiceProxy00](self.impl), variable, callback, userData))

proc gupnp_service_proxy_remove_raw_notify(self: ptr ServiceProxy00; callback: ServiceProxyNotifyCallback;
    userData: pointer): gboolean {.
    importc, libprag.}

proc removeRawNotify*(self: ServiceProxy; callback: ServiceProxyNotifyCallback;
    userData: pointer): bool =
  toBool(gupnp_service_proxy_remove_raw_notify(cast[ptr ServiceProxy00](self.impl), callback, userData))





type
  XMLError* {.size: sizeof(cint), pure.} = enum
    parse = 0
    noNode = 1
    emptyNode = 2
    invalidAttribute = 3
    other = 4

proc gupnp_get_uuid(): cstring {.
    importc, libprag.}

proc getUuid*(): string =
  let resul0 = gupnp_get_uuid()
  result = $resul0
  cogfree(resul0)
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc initable*(x: gupnp.Context): gio.Initable = cast[gio.Initable](x)

proc initable*(x: gupnp.RootDevice): gio.Initable = cast[gio.Initable](x)

proc initable*(x: gupnp.ServiceIntrospection): gio.Initable = cast[gio.Initable](x)

proc initable*(x: gupnp.XMLDoc): gio.Initable = cast[gio.Initable](x)

# dependencies:
# GObject-2.0
# Gio-2.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# Gio-2.0
# libraries:
# libsoup-3.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gio, glib, gmodule
const Lib = "libsoup-3.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  Auth* = ref object of gobject.Object
  Auth00* = object of gobject.Object00

proc soup_auth_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Auth()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_auth_authenticate(self: ptr Auth00; username: cstring; password: cstring) {.
    importc, libprag.}

proc authenticate*(self: Auth; username: cstring; password: cstring) =
  soup_auth_authenticate(cast[ptr Auth00](self.impl), username, password)

proc soup_auth_can_authenticate(self: ptr Auth00): gboolean {.
    importc, libprag.}

proc canAuthenticate*(self: Auth): bool =
  toBool(soup_auth_can_authenticate(cast[ptr Auth00](self.impl)))

proc soup_auth_cancel(self: ptr Auth00) {.
    importc, libprag.}

proc cancel*(self: Auth) =
  soup_auth_cancel(cast[ptr Auth00](self.impl))

proc soup_auth_get_authority(self: ptr Auth00): cstring {.
    importc, libprag.}

proc getAuthority*(self: Auth): string =
  result = $soup_auth_get_authority(cast[ptr Auth00](self.impl))

proc authority*(self: Auth): string =
  result = $soup_auth_get_authority(cast[ptr Auth00](self.impl))

proc soup_auth_get_info(self: ptr Auth00): cstring {.
    importc, libprag.}

proc getInfoAuth*(self: Auth): string =
  let resul0 = soup_auth_get_info(cast[ptr Auth00](self.impl))
  result = $resul0
  cogfree(resul0)

proc infoAuth*(self: Auth): string =
  let resul0 = soup_auth_get_info(cast[ptr Auth00](self.impl))
  result = $resul0
  cogfree(resul0)

proc soup_auth_get_protection_space(self: ptr Auth00; sourceUri: ptr glib.Uri00): ptr glib.SList {.
    importc, libprag.}

proc getProtectionSpace*(self: Auth; sourceUri: glib.Uri): seq[cstring] =
  let resul0 = soup_auth_get_protection_space(cast[ptr Auth00](self.impl), cast[ptr glib.Uri00](sourceUri.impl))
  g_slist_free(resul0)

proc soup_auth_get_realm(self: ptr Auth00): cstring {.
    importc, libprag.}

proc getRealm*(self: Auth): string =
  result = $soup_auth_get_realm(cast[ptr Auth00](self.impl))

proc realm*(self: Auth): string =
  result = $soup_auth_get_realm(cast[ptr Auth00](self.impl))

proc soup_auth_get_scheme_name(self: ptr Auth00): cstring {.
    importc, libprag.}

proc getSchemeName*(self: Auth): string =
  result = $soup_auth_get_scheme_name(cast[ptr Auth00](self.impl))

proc schemeName*(self: Auth): string =
  result = $soup_auth_get_scheme_name(cast[ptr Auth00](self.impl))

proc soup_auth_is_authenticated(self: ptr Auth00): gboolean {.
    importc, libprag.}

proc isAuthenticated*(self: Auth): bool =
  toBool(soup_auth_is_authenticated(cast[ptr Auth00](self.impl)))

proc soup_auth_is_cancelled(self: ptr Auth00): gboolean {.
    importc, libprag.}

proc isCancelled*(self: Auth): bool =
  toBool(soup_auth_is_cancelled(cast[ptr Auth00](self.impl)))

proc soup_auth_is_for_proxy(self: ptr Auth00): gboolean {.
    importc, libprag.}

proc isForProxy*(self: Auth): bool =
  toBool(soup_auth_is_for_proxy(cast[ptr Auth00](self.impl)))

type
  Message* = ref object of gobject.Object
  Message00* = object of gobject.Object00

proc soup_message_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Message()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAcceptCertificate*(self: Message;  p: proc (self: ptr Message00; tlsPeerCertificate: ptr gio.TlsCertificate00; tlsPeerErrors: gio.TlsCertificateFlags; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "accept-certificate", cast[GCallback](p), xdata, nil, cf)

proc scAuthenticate*(self: Message;  p: proc (self: ptr Message00; auth: ptr Auth00; retrying: gboolean; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "authenticate", cast[GCallback](p), xdata, nil, cf)

proc scContentSniffed*(self: Message;  p: proc (self: ptr Message00; `type`: cstring; params: ptr HashTable00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "content-sniffed", cast[GCallback](p), xdata, nil, cf)

proc scFinished*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "finished", cast[GCallback](p), xdata, nil, cf)

proc scGotBody*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-body", cast[GCallback](p), xdata, nil, cf)

proc scGotBodyData*(self: Message;  p: proc (self: ptr Message00; chunkSize: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-body-data", cast[GCallback](p), xdata, nil, cf)

proc scGotHeaders*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-headers", cast[GCallback](p), xdata, nil, cf)

proc scGotInformational*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-informational", cast[GCallback](p), xdata, nil, cf)

proc scHstsEnforced*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "hsts-enforced", cast[GCallback](p), xdata, nil, cf)

proc scNetworkEvent*(self: Message;  p: proc (self: ptr Message00; event: gio.SocketClientEvent; connection: ptr gio.IOStream00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "network-event", cast[GCallback](p), xdata, nil, cf)

proc scRequestCertificate*(self: Message;  p: proc (self: ptr Message00; tlsConnection: ptr gio.TlsClientConnection00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-certificate", cast[GCallback](p), xdata, nil, cf)

proc scRequestCertificatePassword*(self: Message;  p: proc (self: ptr Message00; tlsPassword: ptr gio.TlsPassword00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-certificate-password", cast[GCallback](p), xdata, nil, cf)

proc scRestarted*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "restarted", cast[GCallback](p), xdata, nil, cf)

proc scStarting*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "starting", cast[GCallback](p), xdata, nil, cf)

proc scWroteBody*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-body", cast[GCallback](p), xdata, nil, cf)

proc scWroteBodyData*(self: Message;  p: proc (self: ptr Message00; chunkSize: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-body-data", cast[GCallback](p), xdata, nil, cf)

proc scWroteHeaders*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-headers", cast[GCallback](p), xdata, nil, cf)

proc soup_message_new(`method`: cstring; uriString: cstring): ptr Message00 {.
    importc, libprag.}

proc newMessage*(`method`: cstring; uriString: cstring): Message =
  let gobj = soup_message_new(`method`, uriString)
  if gobj.isNil:
    return nil
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

proc newMessage*(tdesc: typedesc; `method`: cstring; uriString: cstring): tdesc =
  assert(result is Message)
  let gobj = soup_message_new(`method`, uriString)
  if gobj.isNil:
    return nil
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

proc initMessage*[T](result: var T; `method`: cstring; uriString: cstring) {.deprecated.} =
  assert(result is Message)
  let gobj = soup_message_new(`method`, uriString)
  if gobj.isNil:
    return nil
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

proc soup_message_new_from_encoded_form(`method`: cstring; uriString: cstring;
    encodedForm: cstring): ptr Message00 {.
    importc, libprag.}

proc newMessageFromEncodedForm*(`method`: cstring; uriString: cstring;
    encodedForm: cstring): Message =
  let gobj = soup_message_new_from_encoded_form(`method`, uriString, encodedForm)
  if gobj.isNil:
    return nil
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

proc newMessageFromEncodedForm*(tdesc: typedesc; `method`: cstring; uriString: cstring;
    encodedForm: cstring): tdesc =
  assert(result is Message)
  let gobj = soup_message_new_from_encoded_form(`method`, uriString, encodedForm)
  if gobj.isNil:
    return nil
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

proc initMessageFromEncodedForm*[T](result: var T; `method`: cstring; uriString: cstring;
    encodedForm: cstring) {.deprecated.} =
  assert(result is Message)
  let gobj = soup_message_new_from_encoded_form(`method`, uriString, encodedForm)
  if gobj.isNil:
    return nil
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

proc soup_message_new_from_uri(`method`: cstring; uri: ptr glib.Uri00): ptr Message00 {.
    importc, libprag.}

proc newMessageFromUri*(`method`: cstring; uri: glib.Uri): Message =
  let gobj = soup_message_new_from_uri(`method`, cast[ptr glib.Uri00](uri.impl))
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

proc newMessageFromUri*(tdesc: typedesc; `method`: cstring; uri: glib.Uri): tdesc =
  assert(result is Message)
  let gobj = soup_message_new_from_uri(`method`, cast[ptr glib.Uri00](uri.impl))
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

proc initMessageFromUri*[T](result: var T; `method`: cstring; uri: glib.Uri) {.deprecated.} =
  assert(result is Message)
  let gobj = soup_message_new_from_uri(`method`, cast[ptr glib.Uri00](uri.impl))
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

proc soup_message_new_options_ping(baseUri: ptr glib.Uri00): ptr Message00 {.
    importc, libprag.}

proc newMessageOptionsPing*(baseUri: glib.Uri): Message =
  let gobj = soup_message_new_options_ping(cast[ptr glib.Uri00](baseUri.impl))
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

proc newMessageOptionsPing*(tdesc: typedesc; baseUri: glib.Uri): tdesc =
  assert(result is Message)
  let gobj = soup_message_new_options_ping(cast[ptr glib.Uri00](baseUri.impl))
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

proc initMessageOptionsPing*[T](result: var T; baseUri: glib.Uri) {.deprecated.} =
  assert(result is Message)
  let gobj = soup_message_new_options_ping(cast[ptr glib.Uri00](baseUri.impl))
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

proc soup_message_disable_feature(self: ptr Message00; featureType: GType) {.
    importc, libprag.}

proc disableFeature*(self: Message; featureType: GType) =
  soup_message_disable_feature(cast[ptr Message00](self.impl), featureType)

proc soup_message_get_connection_id(self: ptr Message00): uint64 {.
    importc, libprag.}

proc getConnectionId*(self: Message): uint64 =
  soup_message_get_connection_id(cast[ptr Message00](self.impl))

proc connectionId*(self: Message): uint64 =
  soup_message_get_connection_id(cast[ptr Message00](self.impl))

proc soup_message_get_first_party(self: ptr Message00): ptr glib.Uri00 {.
    importc, libprag.}

proc getFirstParty*(self: Message): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = soup_message_get_first_party(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc firstParty*(self: Message): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = soup_message_get_first_party(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc soup_message_get_force_http1(self: ptr Message00): gboolean {.
    importc, libprag.}

proc getForceHttp1*(self: Message): bool =
  toBool(soup_message_get_force_http1(cast[ptr Message00](self.impl)))

proc forceHttp1*(self: Message): bool =
  toBool(soup_message_get_force_http1(cast[ptr Message00](self.impl)))

proc soup_message_get_is_options_ping(self: ptr Message00): gboolean {.
    importc, libprag.}

proc getIsOptionsPing*(self: Message): bool =
  toBool(soup_message_get_is_options_ping(cast[ptr Message00](self.impl)))

proc isOptionsPing*(self: Message): bool =
  toBool(soup_message_get_is_options_ping(cast[ptr Message00](self.impl)))

proc soup_message_get_is_top_level_navigation(self: ptr Message00): gboolean {.
    importc, libprag.}

proc getIsTopLevelNavigation*(self: Message): bool =
  toBool(soup_message_get_is_top_level_navigation(cast[ptr Message00](self.impl)))

proc isTopLevelNavigation*(self: Message): bool =
  toBool(soup_message_get_is_top_level_navigation(cast[ptr Message00](self.impl)))

proc soup_message_get_method(self: ptr Message00): cstring {.
    importc, libprag.}

proc getMethod*(self: Message): string =
  result = $soup_message_get_method(cast[ptr Message00](self.impl))

proc soup_message_get_reason_phrase(self: ptr Message00): cstring {.
    importc, libprag.}

proc getReasonPhrase*(self: Message): string =
  let resul0 = soup_message_get_reason_phrase(cast[ptr Message00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc reasonPhrase*(self: Message): string =
  let resul0 = soup_message_get_reason_phrase(cast[ptr Message00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_message_get_remote_address(self: ptr Message00): ptr gio.SocketAddress00 {.
    importc, libprag.}

proc getRemoteAddress*(self: Message): gio.SocketAddress =
  let gobj = soup_message_get_remote_address(cast[ptr Message00](self.impl))
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

proc remoteAddress*(self: Message): gio.SocketAddress =
  let gobj = soup_message_get_remote_address(cast[ptr Message00](self.impl))
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

proc soup_message_get_site_for_cookies(self: ptr Message00): ptr glib.Uri00 {.
    importc, libprag.}

proc getSiteForCookies*(self: Message): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = soup_message_get_site_for_cookies(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc siteForCookies*(self: Message): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = soup_message_get_site_for_cookies(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc soup_message_get_tls_ciphersuite_name(self: ptr Message00): cstring {.
    importc, libprag.}

proc getTlsCiphersuiteName*(self: Message): string =
  result = $soup_message_get_tls_ciphersuite_name(cast[ptr Message00](self.impl))

proc tlsCiphersuiteName*(self: Message): string =
  result = $soup_message_get_tls_ciphersuite_name(cast[ptr Message00](self.impl))

proc soup_message_get_tls_peer_certificate(self: ptr Message00): ptr gio.TlsCertificate00 {.
    importc, libprag.}

proc getTlsPeerCertificate*(self: Message): gio.TlsCertificate =
  let gobj = soup_message_get_tls_peer_certificate(cast[ptr Message00](self.impl))
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

proc tlsPeerCertificate*(self: Message): gio.TlsCertificate =
  let gobj = soup_message_get_tls_peer_certificate(cast[ptr Message00](self.impl))
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

proc soup_message_get_tls_peer_certificate_errors(self: ptr Message00): gio.TlsCertificateFlags {.
    importc, libprag.}

proc getTlsPeerCertificateErrors*(self: Message): gio.TlsCertificateFlags =
  soup_message_get_tls_peer_certificate_errors(cast[ptr Message00](self.impl))

proc tlsPeerCertificateErrors*(self: Message): gio.TlsCertificateFlags =
  soup_message_get_tls_peer_certificate_errors(cast[ptr Message00](self.impl))

proc soup_message_get_tls_protocol_version(self: ptr Message00): gio.TlsProtocolVersion {.
    importc, libprag.}

proc getTlsProtocolVersion*(self: Message): gio.TlsProtocolVersion =
  soup_message_get_tls_protocol_version(cast[ptr Message00](self.impl))

proc tlsProtocolVersion*(self: Message): gio.TlsProtocolVersion =
  soup_message_get_tls_protocol_version(cast[ptr Message00](self.impl))

proc soup_message_get_uri(self: ptr Message00): ptr glib.Uri00 {.
    importc, libprag.}

proc getUri*(self: Message): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = soup_message_get_uri(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc uri*(self: Message): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = soup_message_get_uri(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc soup_message_is_feature_disabled(self: ptr Message00; featureType: GType): gboolean {.
    importc, libprag.}

proc isFeatureDisabled*(self: Message; featureType: GType): bool =
  toBool(soup_message_is_feature_disabled(cast[ptr Message00](self.impl), featureType))

proc soup_message_is_keepalive(self: ptr Message00): gboolean {.
    importc, libprag.}

proc isKeepalive*(self: Message): bool =
  toBool(soup_message_is_keepalive(cast[ptr Message00](self.impl)))

proc soup_message_set_first_party(self: ptr Message00; firstParty: ptr glib.Uri00) {.
    importc, libprag.}

proc setFirstParty*(self: Message; firstParty: glib.Uri) =
  soup_message_set_first_party(cast[ptr Message00](self.impl), cast[ptr glib.Uri00](firstParty.impl))

proc `firstParty=`*(self: Message; firstParty: glib.Uri) =
  soup_message_set_first_party(cast[ptr Message00](self.impl), cast[ptr glib.Uri00](firstParty.impl))

proc soup_message_set_force_http1(self: ptr Message00; value: gboolean) {.
    importc, libprag.}

proc setForceHttp1*(self: Message; value: bool = true) =
  soup_message_set_force_http1(cast[ptr Message00](self.impl), gboolean(value))

proc `forceHttp1=`*(self: Message; value: bool) =
  soup_message_set_force_http1(cast[ptr Message00](self.impl), gboolean(value))

proc soup_message_set_is_options_ping(self: ptr Message00; isOptionsPing: gboolean) {.
    importc, libprag.}

proc setIsOptionsPing*(self: Message; isOptionsPing: bool = true) =
  soup_message_set_is_options_ping(cast[ptr Message00](self.impl), gboolean(isOptionsPing))

proc `isOptionsPing=`*(self: Message; isOptionsPing: bool) =
  soup_message_set_is_options_ping(cast[ptr Message00](self.impl), gboolean(isOptionsPing))

proc soup_message_set_is_top_level_navigation(self: ptr Message00; isTopLevelNavigation: gboolean) {.
    importc, libprag.}

proc setIsTopLevelNavigation*(self: Message; isTopLevelNavigation: bool = true) =
  soup_message_set_is_top_level_navigation(cast[ptr Message00](self.impl), gboolean(isTopLevelNavigation))

proc `isTopLevelNavigation=`*(self: Message; isTopLevelNavigation: bool) =
  soup_message_set_is_top_level_navigation(cast[ptr Message00](self.impl), gboolean(isTopLevelNavigation))

proc soup_message_set_method(self: ptr Message00; `method`: cstring) {.
    importc, libprag.}

proc setMethod*(self: Message; `method`: cstring) =
  soup_message_set_method(cast[ptr Message00](self.impl), `method`)

proc `method=`*(self: Message; `method`: cstring) =
  soup_message_set_method(cast[ptr Message00](self.impl), `method`)

proc soup_message_set_request_body(self: ptr Message00; contentType: cstring;
    stream: ptr gio.InputStream00; contentLength: int64) {.
    importc, libprag.}

proc setRequestBody*(self: Message; contentType: cstring = nil;
    stream: gio.InputStream = nil; contentLength: int64) =
  soup_message_set_request_body(cast[ptr Message00](self.impl), contentType, if stream.isNil: nil else: cast[ptr gio.InputStream00](stream.impl), contentLength)

proc soup_message_set_request_body_from_bytes(self: ptr Message00; contentType: cstring;
    bytes: ptr glib.Bytes00) {.
    importc, libprag.}

proc setRequestBodyFromBytes*(self: Message; contentType: cstring = nil;
    bytes: glib.Bytes = nil) =
  soup_message_set_request_body_from_bytes(cast[ptr Message00](self.impl), contentType, if bytes.isNil: nil else: cast[ptr glib.Bytes00](bytes.impl))

proc soup_message_set_site_for_cookies(self: ptr Message00; siteForCookies: ptr glib.Uri00) {.
    importc, libprag.}

proc setSiteForCookies*(self: Message; siteForCookies: glib.Uri = nil) =
  soup_message_set_site_for_cookies(cast[ptr Message00](self.impl), if siteForCookies.isNil: nil else: cast[ptr glib.Uri00](siteForCookies.impl))

proc `siteForCookies=`*(self: Message; siteForCookies: glib.Uri = nil) =
  soup_message_set_site_for_cookies(cast[ptr Message00](self.impl), if siteForCookies.isNil: nil else: cast[ptr glib.Uri00](siteForCookies.impl))

proc soup_message_set_tls_client_certificate(self: ptr Message00; certificate: ptr gio.TlsCertificate00) {.
    importc, libprag.}

proc setTlsClientCertificate*(self: Message; certificate: gio.TlsCertificate = nil) =
  soup_message_set_tls_client_certificate(cast[ptr Message00](self.impl), if certificate.isNil: nil else: cast[ptr gio.TlsCertificate00](certificate.impl))

proc `tlsClientCertificate=`*(self: Message; certificate: gio.TlsCertificate = nil) =
  soup_message_set_tls_client_certificate(cast[ptr Message00](self.impl), if certificate.isNil: nil else: cast[ptr gio.TlsCertificate00](certificate.impl))

proc soup_message_set_uri(self: ptr Message00; uri: ptr glib.Uri00) {.
    importc, libprag.}

proc setUri*(self: Message; uri: glib.Uri) =
  soup_message_set_uri(cast[ptr Message00](self.impl), cast[ptr glib.Uri00](uri.impl))

proc `uri=`*(self: Message; uri: glib.Uri) =
  soup_message_set_uri(cast[ptr Message00](self.impl), cast[ptr glib.Uri00](uri.impl))

proc soup_message_tls_client_certificate_password_request_complete(self: ptr Message00) {.
    importc, libprag.}

proc tlsClientCertificatePasswordRequestComplete*(self: Message) =
  soup_message_tls_client_certificate_password_request_complete(cast[ptr Message00](self.impl))

proc soup_auth_new(`type`: GType; msg: ptr Message00; authHeader: cstring): ptr Auth00 {.
    importc, libprag.}

proc newAuth*(`type`: GType; msg: Message; authHeader: cstring): Auth =
  let gobj = soup_auth_new(`type`, cast[ptr Message00](msg.impl), authHeader)
  if gobj.isNil:
    return nil
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

proc newAuth*(tdesc: typedesc; `type`: GType; msg: Message; authHeader: cstring): tdesc =
  assert(result is Auth)
  let gobj = soup_auth_new(`type`, cast[ptr Message00](msg.impl), authHeader)
  if gobj.isNil:
    return nil
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

proc initAuth*[T](result: var T; `type`: GType; msg: Message; authHeader: cstring) {.deprecated.} =
  assert(result is Auth)
  let gobj = soup_auth_new(`type`, cast[ptr Message00](msg.impl), authHeader)
  if gobj.isNil:
    return nil
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

proc soup_auth_get_authorization(self: ptr Auth00; msg: ptr Message00): cstring {.
    importc, libprag.}

proc getAuthorization*(self: Auth; msg: Message): string =
  let resul0 = soup_auth_get_authorization(cast[ptr Auth00](self.impl), cast[ptr Message00](msg.impl))
  result = $resul0
  cogfree(resul0)

proc soup_auth_is_ready(self: ptr Auth00; msg: ptr Message00): gboolean {.
    importc, libprag.}

proc isReady*(self: Auth; msg: Message): bool =
  toBool(soup_auth_is_ready(cast[ptr Auth00](self.impl), cast[ptr Message00](msg.impl)))

proc soup_auth_update(self: ptr Auth00; msg: ptr Message00; authHeader: cstring): gboolean {.
    importc, libprag.}

proc update*(self: Auth; msg: Message; authHeader: cstring): bool =
  toBool(soup_auth_update(cast[ptr Auth00](self.impl), cast[ptr Message00](msg.impl), authHeader))

type
  Multipart00* {.pure.} = object
  Multipart* = ref object
    impl*: ptr Multipart00
    ignoreFinalizer*: bool

proc soup_multipart_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupMultipart*(self: Multipart) =
  if not self.ignoreFinalizer:
    boxedFree(soup_multipart_get_type(), cast[ptr Multipart00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Multipart()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_multipart_get_type(), cast[ptr Multipart00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Multipart) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupMultipart)

proc soup_multipart_free(self: ptr Multipart00) {.
    importc, libprag.}

proc free*(self: Multipart) =
  soup_multipart_free(cast[ptr Multipart00](self.impl))

proc finalizerfree*(self: Multipart) =
  if not self.ignoreFinalizer:
    soup_multipart_free(cast[ptr Multipart00](self.impl))

proc soup_multipart_append_form_file(self: ptr Multipart00; controlName: cstring;
    filename: cstring; contentType: cstring; body: ptr glib.Bytes00) {.
    importc, libprag.}

proc appendFormFile*(self: Multipart; controlName: cstring;
    filename: cstring = nil; contentType: cstring = nil; body: glib.Bytes) =
  soup_multipart_append_form_file(cast[ptr Multipart00](self.impl), controlName, filename, contentType, cast[ptr glib.Bytes00](body.impl))

proc soup_multipart_append_form_string(self: ptr Multipart00; controlName: cstring;
    data: cstring) {.
    importc, libprag.}

proc appendFormString*(self: Multipart; controlName: cstring;
    data: cstring) =
  soup_multipart_append_form_string(cast[ptr Multipart00](self.impl), controlName, data)

proc soup_multipart_new(mimeType: cstring): ptr Multipart00 {.
    importc, libprag.}

proc newMultipart*(mimeType: cstring): Multipart =
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = soup_multipart_new(mimeType)

proc newMultipart*(tdesc: typedesc; mimeType: cstring): tdesc =
  assert(result is Multipart)
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = soup_multipart_new(mimeType)

proc initMultipart*[T](result: var T; mimeType: cstring) {.deprecated.} =
  assert(result is Multipart)
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = soup_multipart_new(mimeType)

proc soup_multipart_get_length(self: ptr Multipart00): int32 {.
    importc, libprag.}

proc getLength*(self: Multipart): int =
  int(soup_multipart_get_length(cast[ptr Multipart00](self.impl)))

proc length*(self: Multipart): int =
  int(soup_multipart_get_length(cast[ptr Multipart00](self.impl)))

proc soup_message_new_from_multipart(uriString: cstring; multipart: ptr Multipart00): ptr Message00 {.
    importc, libprag.}

proc newMessageFromMultipart*(uriString: cstring; multipart: Multipart): Message =
  let gobj = soup_message_new_from_multipart(uriString, cast[ptr Multipart00](multipart.impl))
  if gobj.isNil:
    return nil
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

proc newMessageFromMultipart*(tdesc: typedesc; uriString: cstring; multipart: Multipart): tdesc =
  assert(result is Message)
  let gobj = soup_message_new_from_multipart(uriString, cast[ptr Multipart00](multipart.impl))
  if gobj.isNil:
    return nil
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

proc initMessageFromMultipart*[T](result: var T; uriString: cstring; multipart: Multipart) {.deprecated.} =
  assert(result is Message)
  let gobj = soup_message_new_from_multipart(uriString, cast[ptr Multipart00](multipart.impl))
  if gobj.isNil:
    return nil
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

type
  HTTPVersion* {.size: sizeof(cint), pure.} = enum
    http_1_0 = 0
    http_1_1 = 1
    http_2_0 = 2

proc soup_message_get_http_version(self: ptr Message00): HTTPVersion {.
    importc, libprag.}

proc getHttpVersion*(self: Message): HTTPVersion =
  soup_message_get_http_version(cast[ptr Message00](self.impl))

proc httpVersion*(self: Message): HTTPVersion =
  soup_message_get_http_version(cast[ptr Message00](self.impl))

type
  MessageMetrics00* {.pure.} = object
  MessageMetrics* = ref object
    impl*: ptr MessageMetrics00
    ignoreFinalizer*: bool

proc soup_message_metrics_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupMessageMetrics*(self: MessageMetrics) =
  if not self.ignoreFinalizer:
    boxedFree(soup_message_metrics_get_type(), cast[ptr MessageMetrics00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MessageMetrics()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_message_metrics_get_type(), cast[ptr MessageMetrics00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MessageMetrics) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupMessageMetrics)

proc soup_message_metrics_free(self: ptr MessageMetrics00) {.
    importc, libprag.}

proc free*(self: MessageMetrics) =
  soup_message_metrics_free(cast[ptr MessageMetrics00](self.impl))

proc finalizerfree*(self: MessageMetrics) =
  if not self.ignoreFinalizer:
    soup_message_metrics_free(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_copy(self: ptr MessageMetrics00): ptr MessageMetrics00 {.
    importc, libprag.}

proc copy*(self: MessageMetrics): MessageMetrics =
  fnew(result, gBoxedFreeSoupMessageMetrics)
  result.impl = soup_message_metrics_copy(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_connect_end(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getConnectEnd*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_connect_end(cast[ptr MessageMetrics00](self.impl))

proc connectEnd*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_connect_end(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_connect_start(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getConnectStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_connect_start(cast[ptr MessageMetrics00](self.impl))

proc connectStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_connect_start(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_dns_end(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getDnsEnd*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_dns_end(cast[ptr MessageMetrics00](self.impl))

proc dnsEnd*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_dns_end(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_dns_start(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getDnsStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_dns_start(cast[ptr MessageMetrics00](self.impl))

proc dnsStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_dns_start(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_fetch_start(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getFetchStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_fetch_start(cast[ptr MessageMetrics00](self.impl))

proc fetchStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_fetch_start(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_request_body_bytes_sent(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getRequestBodyBytesSent*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_request_body_bytes_sent(cast[ptr MessageMetrics00](self.impl))

proc requestBodyBytesSent*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_request_body_bytes_sent(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_request_body_size(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getRequestBodySize*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_request_body_size(cast[ptr MessageMetrics00](self.impl))

proc requestBodySize*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_request_body_size(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_request_header_bytes_sent(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getRequestHeaderBytesSent*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_request_header_bytes_sent(cast[ptr MessageMetrics00](self.impl))

proc requestHeaderBytesSent*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_request_header_bytes_sent(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_request_start(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getRequestStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_request_start(cast[ptr MessageMetrics00](self.impl))

proc requestStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_request_start(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_response_body_bytes_received(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getResponseBodyBytesReceived*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_response_body_bytes_received(cast[ptr MessageMetrics00](self.impl))

proc responseBodyBytesReceived*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_response_body_bytes_received(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_response_body_size(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getResponseBodySize*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_response_body_size(cast[ptr MessageMetrics00](self.impl))

proc responseBodySize*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_response_body_size(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_response_end(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getResponseEnd*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_response_end(cast[ptr MessageMetrics00](self.impl))

proc responseEnd*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_response_end(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_response_header_bytes_received(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getResponseHeaderBytesReceived*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_response_header_bytes_received(cast[ptr MessageMetrics00](self.impl))

proc responseHeaderBytesReceived*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_response_header_bytes_received(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_response_start(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getResponseStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_response_start(cast[ptr MessageMetrics00](self.impl))

proc responseStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_response_start(cast[ptr MessageMetrics00](self.impl))

proc soup_message_metrics_get_tls_start(self: ptr MessageMetrics00): uint64 {.
    importc, libprag.}

proc getTlsStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_tls_start(cast[ptr MessageMetrics00](self.impl))

proc tlsStart*(self: MessageMetrics): uint64 =
  soup_message_metrics_get_tls_start(cast[ptr MessageMetrics00](self.impl))

proc soup_message_get_metrics(self: ptr Message00): ptr MessageMetrics00 {.
    importc, libprag.}

proc getMetrics*(self: Message): MessageMetrics =
  let impl0 = soup_message_get_metrics(cast[ptr Message00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMessageMetrics)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_metrics_get_type(), impl0))

proc metrics*(self: Message): MessageMetrics =
  let impl0 = soup_message_get_metrics(cast[ptr Message00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMessageMetrics)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_metrics_get_type(), impl0))

type
  MessageHeaders00* {.pure.} = object
  MessageHeaders* = ref object
    impl*: ptr MessageHeaders00
    ignoreFinalizer*: bool

proc soup_message_headers_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupMessageHeaders*(self: MessageHeaders) =
  if not self.ignoreFinalizer:
    boxedFree(soup_message_headers_get_type(), cast[ptr MessageHeaders00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MessageHeaders()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_message_headers_get_type(), cast[ptr MessageHeaders00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MessageHeaders) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupMessageHeaders)

proc soup_message_headers_unref(self: ptr MessageHeaders00) {.
    importc, libprag.}

proc unref*(self: MessageHeaders) =
  soup_message_headers_unref(cast[ptr MessageHeaders00](self.impl))

proc finalizerunref*(self: MessageHeaders) =
  if not self.ignoreFinalizer:
    soup_message_headers_unref(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_append(self: ptr MessageHeaders00; name: cstring;
    value: cstring) {.
    importc, libprag.}

proc append*(self: MessageHeaders; name: cstring; value: cstring) =
  soup_message_headers_append(cast[ptr MessageHeaders00](self.impl), name, value)

proc soup_message_headers_clean_connection_headers(self: ptr MessageHeaders00) {.
    importc, libprag.}

proc cleanConnectionHeaders*(self: MessageHeaders) =
  soup_message_headers_clean_connection_headers(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_clear(self: ptr MessageHeaders00) {.
    importc, libprag.}

proc clear*(self: MessageHeaders) =
  soup_message_headers_clear(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_get_content_disposition(self: ptr MessageHeaders00;
    disposition: var cstring; params: var ptr HashTable00): gboolean {.
    importc, libprag.}

proc getContentDisposition*(self: MessageHeaders; disposition: var string;
    params: var ptr HashTable00): bool =
  var disposition_00: cstring
  result = toBool(soup_message_headers_get_content_disposition(cast[ptr MessageHeaders00](self.impl), disposition_00, params))
  if disposition.addr != nil:
    disposition = $(disposition_00)

proc soup_message_headers_get_content_length(self: ptr MessageHeaders00): int64 {.
    importc, libprag.}

proc getContentLength*(self: MessageHeaders): int64 =
  soup_message_headers_get_content_length(cast[ptr MessageHeaders00](self.impl))

proc contentLength*(self: MessageHeaders): int64 =
  soup_message_headers_get_content_length(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_get_content_range(self: ptr MessageHeaders00; start: var int64;
    `end`: var int64; totalLength: var int64): gboolean {.
    importc, libprag.}

proc getContentRange*(self: MessageHeaders; start: var int64;
    `end`: var int64; totalLength: var int64 = cast[var int64](nil)): bool =
  toBool(soup_message_headers_get_content_range(cast[ptr MessageHeaders00](self.impl), start, `end`, totalLength))

proc soup_message_headers_get_content_type(self: ptr MessageHeaders00; params: var ptr HashTable00): cstring {.
    importc, libprag.}

proc getContentType*(self: MessageHeaders; params: var ptr HashTable00 = cast[var ptr HashTable00](nil)): string =
  let resul0 = soup_message_headers_get_content_type(cast[ptr MessageHeaders00](self.impl), params)
  if resul0.isNil:
    return
  result = $resul0

proc soup_message_headers_get_list(self: ptr MessageHeaders00; name: cstring): cstring {.
    importc, libprag.}

proc getListMessageHeaders*(self: MessageHeaders; name: cstring): string =
  let resul0 = soup_message_headers_get_list(cast[ptr MessageHeaders00](self.impl), name)
  if resul0.isNil:
    return
  result = $resul0

proc soup_message_headers_get_one(self: ptr MessageHeaders00; name: cstring): cstring {.
    importc, libprag.}

proc getOne*(self: MessageHeaders; name: cstring): string =
  let resul0 = soup_message_headers_get_one(cast[ptr MessageHeaders00](self.impl), name)
  if resul0.isNil:
    return
  result = $resul0

proc soup_message_headers_header_contains(self: ptr MessageHeaders00; name: cstring;
    token: cstring): gboolean {.
    importc, libprag.}

proc headerContains*(self: MessageHeaders; name: cstring;
    token: cstring): bool =
  toBool(soup_message_headers_header_contains(cast[ptr MessageHeaders00](self.impl), name, token))

proc soup_message_headers_header_equals(self: ptr MessageHeaders00; name: cstring;
    value: cstring): gboolean {.
    importc, libprag.}

proc headerEquals*(self: MessageHeaders; name: cstring;
    value: cstring): bool =
  toBool(soup_message_headers_header_equals(cast[ptr MessageHeaders00](self.impl), name, value))

proc soup_message_headers_ref(self: ptr MessageHeaders00): ptr MessageHeaders00 {.
    importc, libprag.}

proc `ref`*(self: MessageHeaders): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_headers_ref(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_remove(self: ptr MessageHeaders00; name: cstring) {.
    importc, libprag.}

proc remove*(self: MessageHeaders; name: cstring) =
  soup_message_headers_remove(cast[ptr MessageHeaders00](self.impl), name)

proc soup_message_headers_replace(self: ptr MessageHeaders00; name: cstring;
    value: cstring) {.
    importc, libprag.}

proc replace*(self: MessageHeaders; name: cstring; value: cstring) =
  soup_message_headers_replace(cast[ptr MessageHeaders00](self.impl), name, value)

proc soup_message_headers_set_content_disposition(self: ptr MessageHeaders00;
    disposition: cstring; params: ptr HashTable00) {.
    importc, libprag.}

proc setContentDisposition*(self: MessageHeaders; disposition: cstring;
    params: ptr HashTable00) =
  soup_message_headers_set_content_disposition(cast[ptr MessageHeaders00](self.impl), disposition, params)

proc soup_message_headers_set_content_length(self: ptr MessageHeaders00;
    contentLength: int64) {.
    importc, libprag.}

proc setContentLength*(self: MessageHeaders; contentLength: int64) =
  soup_message_headers_set_content_length(cast[ptr MessageHeaders00](self.impl), contentLength)

proc `contentLength=`*(self: MessageHeaders; contentLength: int64) =
  soup_message_headers_set_content_length(cast[ptr MessageHeaders00](self.impl), contentLength)

proc soup_message_headers_set_content_range(self: ptr MessageHeaders00; start: int64;
    `end`: int64; totalLength: int64) {.
    importc, libprag.}

proc setContentRange*(self: MessageHeaders; start: int64;
    `end`: int64; totalLength: int64) =
  soup_message_headers_set_content_range(cast[ptr MessageHeaders00](self.impl), start, `end`, totalLength)

proc soup_message_headers_set_content_type(self: ptr MessageHeaders00; contentType: cstring;
    params: ptr HashTable00) {.
    importc, libprag.}

proc setContentType*(self: MessageHeaders; contentType: cstring;
    params: ptr HashTable00) =
  soup_message_headers_set_content_type(cast[ptr MessageHeaders00](self.impl), contentType, params)

proc soup_message_headers_set_range(self: ptr MessageHeaders00; start: int64;
    `end`: int64) {.
    importc, libprag.}

proc setRange*(self: MessageHeaders; start: int64; `end`: int64) =
  soup_message_headers_set_range(cast[ptr MessageHeaders00](self.impl), start, `end`)

proc soup_message_get_request_headers(self: ptr Message00): ptr MessageHeaders00 {.
    importc, libprag.}

proc getRequestHeaders*(self: Message): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_get_request_headers(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc requestHeaders*(self: Message): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_get_request_headers(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc soup_message_get_response_headers(self: ptr Message00): ptr MessageHeaders00 {.
    importc, libprag.}

proc getResponseHeaders*(self: Message): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_get_response_headers(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc responseHeaders*(self: Message): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_get_response_headers(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc soup_multipart_new_from_message(headers: ptr MessageHeaders00; body: ptr glib.Bytes00): ptr Multipart00 {.
    importc, libprag.}

proc newMultipartFromMessage*(headers: MessageHeaders; body: glib.Bytes): Multipart =
  let impl0 = soup_multipart_new_from_message(cast[ptr MessageHeaders00](headers.impl), cast[ptr glib.Bytes00](body.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = impl0

proc newMultipartFromMessage*(tdesc: typedesc; headers: MessageHeaders; body: glib.Bytes): tdesc =
  assert(result is Multipart)
  let impl0 = soup_multipart_new_from_message(cast[ptr MessageHeaders00](headers.impl), cast[ptr glib.Bytes00](body.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = impl0

proc initMultipartFromMessage*[T](result: var T; headers: MessageHeaders; body: glib.Bytes) {.deprecated.} =
  assert(result is Multipart)
  let impl0 = soup_multipart_new_from_message(cast[ptr MessageHeaders00](headers.impl), cast[ptr glib.Bytes00](body.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = impl0

proc soup_multipart_append_part(self: ptr Multipart00; headers: ptr MessageHeaders00;
    body: ptr glib.Bytes00) {.
    importc, libprag.}

proc appendPart*(self: Multipart; headers: MessageHeaders;
    body: glib.Bytes) =
  soup_multipart_append_part(cast[ptr Multipart00](self.impl), cast[ptr MessageHeaders00](headers.impl), cast[ptr glib.Bytes00](body.impl))

proc soup_multipart_get_part(self: ptr Multipart00; part: int32; headers: var ptr MessageHeaders00;
    body: var ptr glib.Bytes00): gboolean {.
    importc, libprag.}

proc getPart*(self: Multipart; part: int; headers: var MessageHeaders;
    body: var glib.Bytes): bool =
  fnew(headers, gBoxedFreeSoupMessageHeaders)
  fnew(body, gBoxedFreeGBytes)
  result = toBool(soup_multipart_get_part(cast[ptr Multipart00](self.impl), int32(part), cast[var ptr MessageHeaders00](addr headers.impl), cast[var ptr glib.Bytes00](addr body.impl)))
  headers.impl = cast[ptr MessageHeaders00](g_boxed_copy(soup_message_headers_get_type(), headers.impl))
  body.impl = cast[ptr glib.Bytes00](g_boxed_copy(g_bytes_get_type(), body.impl))

proc soup_multipart_to_message(self: ptr Multipart00; destHeaders: ptr MessageHeaders00;
    destBody: var ptr glib.Bytes00) {.
    importc, libprag.}

proc toMessage*(self: Multipart; destHeaders: MessageHeaders;
    destBody: var glib.Bytes) =
  fnew(destBody, gBoxedFreeGBytes)
  soup_multipart_to_message(cast[ptr Multipart00](self.impl), cast[ptr MessageHeaders00](destHeaders.impl), cast[var ptr glib.Bytes00](addr destBody.impl))

type
  Encoding* {.size: sizeof(cint), pure.} = enum
    unrecognized = 0
    none = 1
    contentLength = 2
    eof = 3
    chunked = 4
    byteranges = 5

proc soup_message_headers_get_encoding(self: ptr MessageHeaders00): Encoding {.
    importc, libprag.}

proc getEncoding*(self: MessageHeaders): Encoding =
  soup_message_headers_get_encoding(cast[ptr MessageHeaders00](self.impl))

proc encoding*(self: MessageHeaders): Encoding =
  soup_message_headers_get_encoding(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_set_encoding(self: ptr MessageHeaders00; encoding: Encoding) {.
    importc, libprag.}

proc setEncoding*(self: MessageHeaders; encoding: Encoding) =
  soup_message_headers_set_encoding(cast[ptr MessageHeaders00](self.impl), encoding)

proc `encoding=`*(self: MessageHeaders; encoding: Encoding) =
  soup_message_headers_set_encoding(cast[ptr MessageHeaders00](self.impl), encoding)

type
  Expectation* {.size: sizeof(cint), pure.} = enum
    unrecognized = 1
    `continue` = 2

proc soup_message_headers_get_expectations(self: ptr MessageHeaders00): Expectation {.
    importc, libprag.}

proc getExpectations*(self: MessageHeaders): Expectation =
  soup_message_headers_get_expectations(cast[ptr MessageHeaders00](self.impl))

proc expectations*(self: MessageHeaders): Expectation =
  soup_message_headers_get_expectations(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_set_expectations(self: ptr MessageHeaders00; expectations: Expectation) {.
    importc, libprag.}

proc setExpectations*(self: MessageHeaders; expectations: Expectation) =
  soup_message_headers_set_expectations(cast[ptr MessageHeaders00](self.impl), expectations)

proc `expectations=`*(self: MessageHeaders; expectations: Expectation) =
  soup_message_headers_set_expectations(cast[ptr MessageHeaders00](self.impl), expectations)

type
  Range00* {.pure.} = object
  Range* = ref object
    impl*: ptr Range00
    ignoreFinalizer*: bool

proc soup_message_headers_free_ranges(self: ptr MessageHeaders00; ranges: ptr Range00) {.
    importc, libprag.}

proc freeRanges*(self: MessageHeaders; ranges: Range) =
  soup_message_headers_free_ranges(cast[ptr MessageHeaders00](self.impl), cast[ptr Range00](ranges.impl))

proc soup_message_headers_get_ranges(self: ptr MessageHeaders00; totalLength: int64;
    ranges: var ptr Range00; length: var int32): gboolean {.
    importc, libprag.}

proc getRanges*(self: MessageHeaders; totalLength: int64;
    ranges: var ptr Range00; length: var int): bool =
  var length_00: int32
  result = toBool(soup_message_headers_get_ranges(cast[ptr MessageHeaders00](self.impl), totalLength, ranges, length_00))
  if length.addr != nil:
    length = int(length_00)

proc soup_message_headers_set_ranges(self: ptr MessageHeaders00; ranges: ptr Range00;
    length: int32) {.
    importc, libprag.}

proc setRanges*(self: MessageHeaders; ranges: Range;
    length: int) =
  soup_message_headers_set_ranges(cast[ptr MessageHeaders00](self.impl), cast[ptr Range00](ranges.impl), int32(length))

type
  MessageHeadersType* {.size: sizeof(cint), pure.} = enum
    request = 0
    response = 1
    multipart = 2

proc soup_message_headers_get_headers_type(self: ptr MessageHeaders00): MessageHeadersType {.
    importc, libprag.}

proc getHeadersType*(self: MessageHeaders): MessageHeadersType =
  soup_message_headers_get_headers_type(cast[ptr MessageHeaders00](self.impl))

proc headersType*(self: MessageHeaders): MessageHeadersType =
  soup_message_headers_get_headers_type(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_new(`type`: MessageHeadersType): ptr MessageHeaders00 {.
    importc, libprag.}

proc newMessageHeaders*(`type`: MessageHeadersType): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_headers_new(`type`)

proc newMessageHeaders*(tdesc: typedesc; `type`: MessageHeadersType): tdesc =
  assert(result is MessageHeaders)
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_headers_new(`type`)

proc initMessageHeaders*[T](result: var T; `type`: MessageHeadersType) {.deprecated.} =
  assert(result is MessageHeaders)
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_headers_new(`type`)

type
  Status* {.size: sizeof(cint), pure.} = enum
    none = 0
    `continue` = 100
    switchingProtocols = 101
    processing = 102
    ok = 200
    created = 201
    accepted = 202
    nonAuthoritative = 203
    noContent = 204
    resetContent = 205
    partialContent = 206
    multiStatus = 207
    multipleChoices = 300
    movedPermanently = 301
    found = 302
    seeOther = 303
    notModified = 304
    useProxy = 305
    notAppearingInThisProtocol = 306
    temporaryRedirect = 307
    permanentRedirect = 308
    badRequest = 400
    unauthorized = 401
    paymentRequired = 402
    forbidden = 403
    notFound = 404
    methodNotAllowed = 405
    notAcceptable = 406
    proxyAuthenticationRequired = 407
    requestTimeout = 408
    conflict = 409
    gone = 410
    lengthRequired = 411
    preconditionFailed = 412
    requestEntityTooLarge = 413
    requestUriTooLong = 414
    unsupportedMediaType = 415
    invalidRange = 416
    expectationFailed = 417
    misdirectedRequest = 421
    unprocessableEntity = 422
    locked = 423
    failedDependency = 424
    internalServerError = 500
    notImplemented = 501
    badGateway = 502
    serviceUnavailable = 503
    gatewayTimeout = 504
    httpVersionNotSupported = 505
    insufficientStorage = 507
    notExtended = 510

const
  StatusProxyUnauthorized* = Status.proxyAuthenticationRequired
  StatusMovedTemporarily* = Status.found
  StatusRequestedRangeNotSatisfiable* = Status.invalidRange

proc soup_status_get_phrase(statusCode: uint32): cstring {.
    importc, libprag.}

proc getPhrase*(statusCode: int): string =
  result = $soup_status_get_phrase(uint32(statusCode))

proc phrase*(statusCode: int): string =
  result = $soup_status_get_phrase(uint32(statusCode))

proc soup_message_get_status(self: ptr Message00): Status {.
    importc, libprag.}

proc getStatus*(self: Message): Status =
  soup_message_get_status(cast[ptr Message00](self.impl))

proc status*(self: Message): Status =
  soup_message_get_status(cast[ptr Message00](self.impl))

type
  MessageFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    noRedirect = 1
    newConnection = 2
    idempotent = 3
    doNotUseAuthCache = 4
    collectMetrics = 5

  MessageFlags* = set[MessageFlag]

proc soup_message_add_flags(self: ptr Message00; flags: MessageFlags) {.
    importc, libprag.}

proc addFlags*(self: Message; flags: MessageFlags) =
  soup_message_add_flags(cast[ptr Message00](self.impl), flags)

proc soup_message_get_flags(self: ptr Message00): MessageFlags {.
    importc, libprag.}

proc getFlags*(self: Message): MessageFlags =
  soup_message_get_flags(cast[ptr Message00](self.impl))

proc flags*(self: Message): MessageFlags =
  soup_message_get_flags(cast[ptr Message00](self.impl))

proc soup_message_query_flags(self: ptr Message00; flags: MessageFlags): gboolean {.
    importc, libprag.}

proc queryFlags*(self: Message; flags: MessageFlags): bool =
  toBool(soup_message_query_flags(cast[ptr Message00](self.impl), flags))

proc soup_message_remove_flags(self: ptr Message00; flags: MessageFlags) {.
    importc, libprag.}

proc removeFlags*(self: Message; flags: MessageFlags) =
  soup_message_remove_flags(cast[ptr Message00](self.impl), flags)

proc soup_message_set_flags(self: ptr Message00; flags: MessageFlags) {.
    importc, libprag.}

proc setFlags*(self: Message; flags: MessageFlags) =
  soup_message_set_flags(cast[ptr Message00](self.impl), flags)

proc `flags=`*(self: Message; flags: MessageFlags) =
  soup_message_set_flags(cast[ptr Message00](self.impl), flags)

type
  MessagePriority* {.size: sizeof(cint), pure.} = enum
    veryLow = 0
    low = 1
    normal = 2
    high = 3
    veryHigh = 4

proc soup_message_get_priority(self: ptr Message00): MessagePriority {.
    importc, libprag.}

proc getPriority*(self: Message): MessagePriority =
  soup_message_get_priority(cast[ptr Message00](self.impl))

proc priority*(self: Message): MessagePriority =
  soup_message_get_priority(cast[ptr Message00](self.impl))

proc soup_message_set_priority(self: ptr Message00; priority: MessagePriority) {.
    importc, libprag.}

proc setPriority*(self: Message; priority: MessagePriority) =
  soup_message_set_priority(cast[ptr Message00](self.impl), priority)

proc `priority=`*(self: Message; priority: MessagePriority) =
  soup_message_set_priority(cast[ptr Message00](self.impl), priority)

type
  AuthBasic* = ref object of Auth
  AuthBasic00* = object of Auth00

proc soup_auth_basic_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthBasic()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AuthDigest* = ref object of Auth
  AuthDigest00* = object of Auth00

proc soup_auth_digest_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthDigest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AuthDomain* = ref object of gobject.Object
  AuthDomain00* = object of gobject.Object00

proc soup_auth_domain_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthDomain()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_auth_domain_add_path(self: ptr AuthDomain00; path: cstring) {.
    importc, libprag.}

proc addPath*(self: AuthDomain; path: cstring) =
  soup_auth_domain_add_path(cast[ptr AuthDomain00](self.impl), path)

proc soup_auth_domain_get_realm(self: ptr AuthDomain00): cstring {.
    importc, libprag.}

proc getRealm*(self: AuthDomain): string =
  result = $soup_auth_domain_get_realm(cast[ptr AuthDomain00](self.impl))

proc realm*(self: AuthDomain): string =
  result = $soup_auth_domain_get_realm(cast[ptr AuthDomain00](self.impl))

proc soup_auth_domain_remove_path(self: ptr AuthDomain00; path: cstring) {.
    importc, libprag.}

proc removePath*(self: AuthDomain; path: cstring) =
  soup_auth_domain_remove_path(cast[ptr AuthDomain00](self.impl), path)

type
  ServerMessage* = ref object of gobject.Object
  ServerMessage00* = object of gobject.Object00

proc soup_server_message_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ServerMessage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAcceptCertificate*(self: ServerMessage;  p: proc (self: ptr ServerMessage00; tlsPeerCertificate: ptr gio.TlsCertificate00; tlsPeerErrors: gio.TlsCertificateFlags; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "accept-certificate", cast[GCallback](p), xdata, nil, cf)

proc scConnected*(self: ServerMessage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "connected", cast[GCallback](p), xdata, nil, cf)

proc scDisconnected*(self: ServerMessage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "disconnected", cast[GCallback](p), xdata, nil, cf)

proc scFinished*(self: ServerMessage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "finished", cast[GCallback](p), xdata, nil, cf)

proc scGotBody*(self: ServerMessage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-body", cast[GCallback](p), xdata, nil, cf)

proc scGotChunk*(self: ServerMessage;  p: proc (self: ptr ServerMessage00; chunk: ptr glib.Bytes00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-chunk", cast[GCallback](p), xdata, nil, cf)

proc scGotHeaders*(self: ServerMessage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-headers", cast[GCallback](p), xdata, nil, cf)

proc scWroteBody*(self: ServerMessage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-body", cast[GCallback](p), xdata, nil, cf)

proc scWroteBodyData*(self: ServerMessage;  p: proc (self: ptr ServerMessage00; chunkSize: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-body-data", cast[GCallback](p), xdata, nil, cf)

proc scWroteChunk*(self: ServerMessage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-chunk", cast[GCallback](p), xdata, nil, cf)

proc scWroteHeaders*(self: ServerMessage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-headers", cast[GCallback](p), xdata, nil, cf)

proc scWroteInformational*(self: ServerMessage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-informational", cast[GCallback](p), xdata, nil, cf)

proc soup_server_message_get_http_version(self: ptr ServerMessage00): HTTPVersion {.
    importc, libprag.}

proc getHttpVersion*(self: ServerMessage): HTTPVersion =
  soup_server_message_get_http_version(cast[ptr ServerMessage00](self.impl))

proc httpVersion*(self: ServerMessage): HTTPVersion =
  soup_server_message_get_http_version(cast[ptr ServerMessage00](self.impl))

proc soup_server_message_get_local_address(self: ptr ServerMessage00): ptr gio.SocketAddress00 {.
    importc, libprag.}

proc getLocalAddress*(self: ServerMessage): gio.SocketAddress =
  let gobj = soup_server_message_get_local_address(cast[ptr ServerMessage00](self.impl))
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

proc localAddress*(self: ServerMessage): gio.SocketAddress =
  let gobj = soup_server_message_get_local_address(cast[ptr ServerMessage00](self.impl))
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

proc soup_server_message_get_method(self: ptr ServerMessage00): cstring {.
    importc, libprag.}

proc getMethod*(self: ServerMessage): string =
  result = $soup_server_message_get_method(cast[ptr ServerMessage00](self.impl))

proc soup_server_message_get_reason_phrase(self: ptr ServerMessage00): cstring {.
    importc, libprag.}

proc getReasonPhrase*(self: ServerMessage): string =
  let resul0 = soup_server_message_get_reason_phrase(cast[ptr ServerMessage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc reasonPhrase*(self: ServerMessage): string =
  let resul0 = soup_server_message_get_reason_phrase(cast[ptr ServerMessage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_server_message_get_remote_address(self: ptr ServerMessage00): ptr gio.SocketAddress00 {.
    importc, libprag.}

proc getRemoteAddress*(self: ServerMessage): gio.SocketAddress =
  let gobj = soup_server_message_get_remote_address(cast[ptr ServerMessage00](self.impl))
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

proc remoteAddress*(self: ServerMessage): gio.SocketAddress =
  let gobj = soup_server_message_get_remote_address(cast[ptr ServerMessage00](self.impl))
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

proc soup_server_message_get_remote_host(self: ptr ServerMessage00): cstring {.
    importc, libprag.}

proc getRemoteHost*(self: ServerMessage): string =
  let resul0 = soup_server_message_get_remote_host(cast[ptr ServerMessage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc remoteHost*(self: ServerMessage): string =
  let resul0 = soup_server_message_get_remote_host(cast[ptr ServerMessage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_server_message_get_request_headers(self: ptr ServerMessage00): ptr MessageHeaders00 {.
    importc, libprag.}

proc getRequestHeaders*(self: ServerMessage): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_server_message_get_request_headers(cast[ptr ServerMessage00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc requestHeaders*(self: ServerMessage): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_server_message_get_request_headers(cast[ptr ServerMessage00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc soup_server_message_get_response_headers(self: ptr ServerMessage00): ptr MessageHeaders00 {.
    importc, libprag.}

proc getResponseHeaders*(self: ServerMessage): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_server_message_get_response_headers(cast[ptr ServerMessage00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc responseHeaders*(self: ServerMessage): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_server_message_get_response_headers(cast[ptr ServerMessage00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc soup_server_message_get_socket(self: ptr ServerMessage00): ptr gio.Socket00 {.
    importc, libprag.}

proc getSocket*(self: ServerMessage): gio.Socket =
  let gobj = soup_server_message_get_socket(cast[ptr ServerMessage00](self.impl))
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

proc socket*(self: ServerMessage): gio.Socket =
  let gobj = soup_server_message_get_socket(cast[ptr ServerMessage00](self.impl))
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

proc soup_server_message_get_status(self: ptr ServerMessage00): uint32 {.
    importc, libprag.}

proc getStatus*(self: ServerMessage): int =
  int(soup_server_message_get_status(cast[ptr ServerMessage00](self.impl)))

proc status*(self: ServerMessage): int =
  int(soup_server_message_get_status(cast[ptr ServerMessage00](self.impl)))

proc soup_server_message_get_tls_peer_certificate(self: ptr ServerMessage00): ptr gio.TlsCertificate00 {.
    importc, libprag.}

proc getTlsPeerCertificate*(self: ServerMessage): gio.TlsCertificate =
  let gobj = soup_server_message_get_tls_peer_certificate(cast[ptr ServerMessage00](self.impl))
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

proc tlsPeerCertificate*(self: ServerMessage): gio.TlsCertificate =
  let gobj = soup_server_message_get_tls_peer_certificate(cast[ptr ServerMessage00](self.impl))
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

proc soup_server_message_get_tls_peer_certificate_errors(self: ptr ServerMessage00): gio.TlsCertificateFlags {.
    importc, libprag.}

proc getTlsPeerCertificateErrors*(self: ServerMessage): gio.TlsCertificateFlags =
  soup_server_message_get_tls_peer_certificate_errors(cast[ptr ServerMessage00](self.impl))

proc tlsPeerCertificateErrors*(self: ServerMessage): gio.TlsCertificateFlags =
  soup_server_message_get_tls_peer_certificate_errors(cast[ptr ServerMessage00](self.impl))

proc soup_server_message_get_uri(self: ptr ServerMessage00): ptr glib.Uri00 {.
    importc, libprag.}

proc getUri*(self: ServerMessage): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = soup_server_message_get_uri(cast[ptr ServerMessage00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc uri*(self: ServerMessage): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = soup_server_message_get_uri(cast[ptr ServerMessage00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc soup_server_message_is_options_ping(self: ptr ServerMessage00): gboolean {.
    importc, libprag.}

proc isOptionsPing*(self: ServerMessage): bool =
  toBool(soup_server_message_is_options_ping(cast[ptr ServerMessage00](self.impl)))

proc soup_server_message_pause(self: ptr ServerMessage00) {.
    importc, libprag.}

proc pause*(self: ServerMessage) =
  soup_server_message_pause(cast[ptr ServerMessage00](self.impl))

proc soup_server_message_set_http_version(self: ptr ServerMessage00; version: HTTPVersion) {.
    importc, libprag.}

proc setHttpVersion*(self: ServerMessage; version: HTTPVersion) =
  soup_server_message_set_http_version(cast[ptr ServerMessage00](self.impl), version)

proc `httpVersion=`*(self: ServerMessage; version: HTTPVersion) =
  soup_server_message_set_http_version(cast[ptr ServerMessage00](self.impl), version)

proc soup_server_message_set_redirect(self: ptr ServerMessage00; statusCode: uint32;
    redirectUri: cstring) {.
    importc, libprag.}

proc setRedirect*(self: ServerMessage; statusCode: int;
    redirectUri: cstring) =
  soup_server_message_set_redirect(cast[ptr ServerMessage00](self.impl), uint32(statusCode), redirectUri)

proc soup_server_message_set_status(self: ptr ServerMessage00; statusCode: uint32;
    reasonPhrase: cstring) {.
    importc, libprag.}

proc setStatus*(self: ServerMessage; statusCode: int;
    reasonPhrase: cstring = nil) =
  soup_server_message_set_status(cast[ptr ServerMessage00](self.impl), uint32(statusCode), reasonPhrase)

proc soup_server_message_steal_connection(self: ptr ServerMessage00): ptr gio.IOStream00 {.
    importc, libprag.}

proc stealConnection*(self: ServerMessage): gio.IOStream =
  let gobj = soup_server_message_steal_connection(cast[ptr ServerMessage00](self.impl))
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

proc soup_server_message_unpause(self: ptr ServerMessage00) {.
    importc, libprag.}

proc unpause*(self: ServerMessage) =
  soup_server_message_unpause(cast[ptr ServerMessage00](self.impl))

proc soup_auth_domain_accepts(self: ptr AuthDomain00; msg: ptr ServerMessage00): cstring {.
    importc, libprag.}

proc accepts*(self: AuthDomain; msg: ServerMessage): string =
  let resul0 = soup_auth_domain_accepts(cast[ptr AuthDomain00](self.impl), cast[ptr ServerMessage00](msg.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc soup_auth_domain_challenge(self: ptr AuthDomain00; msg: ptr ServerMessage00) {.
    importc, libprag.}

proc challenge*(self: AuthDomain; msg: ServerMessage) =
  soup_auth_domain_challenge(cast[ptr AuthDomain00](self.impl), cast[ptr ServerMessage00](msg.impl))

proc soup_auth_domain_check_password(self: ptr AuthDomain00; msg: ptr ServerMessage00;
    username: cstring; password: cstring): gboolean {.
    importc, libprag.}

proc checkPassword*(self: AuthDomain; msg: ServerMessage;
    username: cstring; password: cstring): bool =
  toBool(soup_auth_domain_check_password(cast[ptr AuthDomain00](self.impl), cast[ptr ServerMessage00](msg.impl), username, password))

proc soup_auth_domain_covers(self: ptr AuthDomain00; msg: ptr ServerMessage00): gboolean {.
    importc, libprag.}

proc covers*(self: AuthDomain; msg: ServerMessage): bool =
  toBool(soup_auth_domain_covers(cast[ptr AuthDomain00](self.impl), cast[ptr ServerMessage00](msg.impl)))

type
  MessageBody00* {.pure.} = object
  MessageBody* = ref object
    impl*: ptr MessageBody00
    ignoreFinalizer*: bool

proc soup_message_body_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupMessageBody*(self: MessageBody) =
  if not self.ignoreFinalizer:
    boxedFree(soup_message_body_get_type(), cast[ptr MessageBody00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MessageBody()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_message_body_get_type(), cast[ptr MessageBody00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MessageBody) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupMessageBody)

proc soup_message_body_unref(self: ptr MessageBody00) {.
    importc, libprag.}

proc unref*(self: MessageBody) =
  soup_message_body_unref(cast[ptr MessageBody00](self.impl))

proc finalizerunref*(self: MessageBody) =
  if not self.ignoreFinalizer:
    soup_message_body_unref(cast[ptr MessageBody00](self.impl))

proc soup_message_body_append_bytes(self: ptr MessageBody00; buffer: ptr glib.Bytes00) {.
    importc, libprag.}

proc appendBytes*(self: MessageBody; buffer: glib.Bytes) =
  soup_message_body_append_bytes(cast[ptr MessageBody00](self.impl), cast[ptr glib.Bytes00](buffer.impl))

proc soup_message_body_append_take(self: ptr MessageBody00; data: ptr uint8;
    length: uint64) {.
    importc, libprag.}

proc append*(self: MessageBody; data: seq[uint8] | string) =
  let length = uint64(data.len)
  soup_message_body_append_take(cast[ptr MessageBody00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), length)

proc soup_message_body_complete(self: ptr MessageBody00) {.
    importc, libprag.}

proc complete*(self: MessageBody) =
  soup_message_body_complete(cast[ptr MessageBody00](self.impl))

proc soup_message_body_flatten(self: ptr MessageBody00): ptr glib.Bytes00 {.
    importc, libprag.}

proc flatten*(self: MessageBody): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = soup_message_body_flatten(cast[ptr MessageBody00](self.impl))

proc soup_message_body_get_accumulate(self: ptr MessageBody00): gboolean {.
    importc, libprag.}

proc getAccumulate*(self: MessageBody): bool =
  toBool(soup_message_body_get_accumulate(cast[ptr MessageBody00](self.impl)))

proc accumulate*(self: MessageBody): bool =
  toBool(soup_message_body_get_accumulate(cast[ptr MessageBody00](self.impl)))

proc soup_message_body_get_chunk(self: ptr MessageBody00; offset: int64): ptr glib.Bytes00 {.
    importc, libprag.}

proc getChunk*(self: MessageBody; offset: int64): glib.Bytes =
  let impl0 = soup_message_body_get_chunk(cast[ptr MessageBody00](self.impl), offset)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGBytes)
  result.impl = impl0

proc soup_message_body_got_chunk(self: ptr MessageBody00; chunk: ptr glib.Bytes00) {.
    importc, libprag.}

proc gotChunk*(self: MessageBody; chunk: glib.Bytes) =
  soup_message_body_got_chunk(cast[ptr MessageBody00](self.impl), cast[ptr glib.Bytes00](chunk.impl))

proc soup_message_body_ref(self: ptr MessageBody00): ptr MessageBody00 {.
    importc, libprag.}

proc `ref`*(self: MessageBody): MessageBody =
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_message_body_ref(cast[ptr MessageBody00](self.impl))

proc soup_message_body_set_accumulate(self: ptr MessageBody00; accumulate: gboolean) {.
    importc, libprag.}

proc setAccumulate*(self: MessageBody; accumulate: bool = true) =
  soup_message_body_set_accumulate(cast[ptr MessageBody00](self.impl), gboolean(accumulate))

proc `accumulate=`*(self: MessageBody; accumulate: bool) =
  soup_message_body_set_accumulate(cast[ptr MessageBody00](self.impl), gboolean(accumulate))

proc soup_message_body_truncate(self: ptr MessageBody00) {.
    importc, libprag.}

proc truncate*(self: MessageBody) =
  soup_message_body_truncate(cast[ptr MessageBody00](self.impl))

proc soup_message_body_new(): ptr MessageBody00 {.
    importc, libprag.}

proc newMessageBody*(): MessageBody =
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_message_body_new()

proc newMessageBody*(tdesc: typedesc): tdesc =
  assert(result is MessageBody)
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_message_body_new()

proc initMessageBody*[T](result: var T) {.deprecated.} =
  assert(result is MessageBody)
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_message_body_new()

proc soup_message_body_wrote_chunk(self: ptr MessageBody00; chunk: ptr glib.Bytes00) {.
    importc, libprag.}

proc wroteChunk*(self: MessageBody; chunk: glib.Bytes) =
  soup_message_body_wrote_chunk(cast[ptr MessageBody00](self.impl), cast[ptr glib.Bytes00](chunk.impl))

proc soup_server_message_get_request_body(self: ptr ServerMessage00): ptr MessageBody00 {.
    importc, libprag.}

proc getRequestBody*(self: ServerMessage): MessageBody =
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_server_message_get_request_body(cast[ptr ServerMessage00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_body_get_type(), result.impl))

proc requestBody*(self: ServerMessage): MessageBody =
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_server_message_get_request_body(cast[ptr ServerMessage00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_body_get_type(), result.impl))

proc soup_server_message_get_response_body(self: ptr ServerMessage00): ptr MessageBody00 {.
    importc, libprag.}

proc getResponseBody*(self: ServerMessage): MessageBody =
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_server_message_get_response_body(cast[ptr ServerMessage00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_body_get_type(), result.impl))

proc responseBody*(self: ServerMessage): MessageBody =
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_server_message_get_response_body(cast[ptr ServerMessage00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_body_get_type(), result.impl))

type
  MemoryUse* {.size: sizeof(cint), pure.} = enum
    `static` = 0
    take = 1
    copy = 2

proc soup_server_message_set_response(self: ptr ServerMessage00; contentType: cstring;
    respUse: MemoryUse; respBody: ptr uint8; respLength: uint64) {.
    importc, libprag.}

proc setResponse*(self: ServerMessage; contentType: cstring = nil;
    respUse: MemoryUse; respBody: seq[uint8] | string) =
  let respLength = uint64(respBody.len)
  soup_server_message_set_response(cast[ptr ServerMessage00](self.impl), contentType, respUse, cast[ptr uint8](unsafeaddr(respBody[0])), respLength)

type
  AuthDomainBasic* = ref object of AuthDomain
  AuthDomainBasic00* = object of AuthDomain00

proc soup_auth_domain_basic_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthDomainBasic()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AuthDomainBasicAuthCallback* = proc (domain: ptr AuthDomainBasic00; msg: ptr ServerMessage00; username: cstring;
    password: cstring; userData: pointer): gboolean {.cdecl.}

proc soup_auth_domain_basic_set_auth_callback(self: ptr AuthDomainBasic00;
    callback: AuthDomainBasicAuthCallback; userData: pointer; dnotify: DestroyNotify) {.
    importc, libprag.}

proc setAuthCallback*(self: AuthDomainBasic; callback: AuthDomainBasicAuthCallback;
    userData: pointer; dnotify: DestroyNotify) =
  soup_auth_domain_basic_set_auth_callback(cast[ptr AuthDomainBasic00](self.impl), callback, userData, dnotify)

type
  AuthDomainDigest* = ref object of AuthDomain
  AuthDomainDigest00* = object of AuthDomain00

proc soup_auth_domain_digest_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthDomainDigest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_auth_domain_digest_encode_password(username: cstring; realm: cstring;
    password: cstring): cstring {.
    importc, libprag.}

proc encodePassword*(username: cstring; realm: cstring;
    password: cstring): string =
  let resul0 = soup_auth_domain_digest_encode_password(username, realm, password)
  result = $resul0
  cogfree(resul0)

type
  AuthDomainDigestAuthCallback* = proc (domain: ptr AuthDomainDigest00; msg: ptr ServerMessage00; username: cstring;
    userData: pointer): cstring {.cdecl.}

proc soup_auth_domain_digest_set_auth_callback(self: ptr AuthDomainDigest00;
    callback: AuthDomainDigestAuthCallback; userData: pointer; dnotify: DestroyNotify) {.
    importc, libprag.}

proc setAuthCallback*(self: AuthDomainDigest; callback: AuthDomainDigestAuthCallback;
    userData: pointer; dnotify: DestroyNotify) =
  soup_auth_domain_digest_set_auth_callback(cast[ptr AuthDomainDigest00](self.impl), callback, userData, dnotify)

type
  AuthDomainFilter* = proc (domain: ptr AuthDomain00; msg: ptr ServerMessage00; userData: pointer): gboolean {.cdecl.}

proc soup_auth_domain_set_filter(self: ptr AuthDomain00; filter: AuthDomainFilter;
    filterData: pointer; dnotify: DestroyNotify) {.
    importc, libprag.}

proc setFilter*(self: AuthDomain; filter: AuthDomainFilter;
    filterData: pointer; dnotify: DestroyNotify) =
  soup_auth_domain_set_filter(cast[ptr AuthDomain00](self.impl), filter, filterData, dnotify)

type
  AuthDomainGenericAuthCallback* = proc (domain: ptr AuthDomain00; msg: ptr ServerMessage00; username: cstring;
    userData: pointer): gboolean {.cdecl.}

proc soup_auth_domain_set_generic_auth_callback(self: ptr AuthDomain00; authCallback: AuthDomainGenericAuthCallback;
    authData: pointer; dnotify: DestroyNotify) {.
    importc, libprag.}

proc setGenericAuthCallback*(self: AuthDomain; authCallback: AuthDomainGenericAuthCallback;
    authData: pointer; dnotify: DestroyNotify) =
  soup_auth_domain_set_generic_auth_callback(cast[ptr AuthDomain00](self.impl), authCallback, authData, dnotify)

type
  AuthManager* = ref object of gobject.Object
  AuthManager00* = object of gobject.Object00

proc soup_auth_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_auth_manager_clear_cached_credentials(self: ptr AuthManager00) {.
    importc, libprag.}

proc clearCachedCredentials*(self: AuthManager) =
  soup_auth_manager_clear_cached_credentials(cast[ptr AuthManager00](self.impl))

proc soup_auth_manager_use_auth(self: ptr AuthManager00; uri: ptr glib.Uri00;
    auth: ptr Auth00) {.
    importc, libprag.}

proc useAuth*(self: AuthManager; uri: glib.Uri; auth: Auth) =
  soup_auth_manager_use_auth(cast[ptr AuthManager00](self.impl), cast[ptr glib.Uri00](uri.impl), cast[ptr Auth00](auth.impl))

type
  AuthNTLM* = ref object of Auth
  AuthNTLM00* = object of Auth00

proc soup_auth_ntlm_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthNTLM()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AuthNegotiate* = ref object of Auth
  AuthNegotiate00* = object of Auth00

proc soup_auth_negotiate_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthNegotiate()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_auth_negotiate_supported(): gboolean {.
    importc, libprag.}

proc supported*(): bool =
  toBool(soup_auth_negotiate_supported())

const COOKIE_MAX_AGE_ONE_DAY_STR* = 0'i32

const COOKIE_MAX_AGE_ONE_HOUR_STR* = 3600'i32

const COOKIE_MAX_AGE_ONE_WEEK_STR* = 0'i32

const COOKIE_MAX_AGE_ONE_YEAR_STR* = 0'i32

type
  Cache* = ref object of gobject.Object
  Cache00* = object of gobject.Object00

proc soup_cache_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Cache()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_cache_clear(self: ptr Cache00) {.
    importc, libprag.}

proc clear*(self: Cache) =
  soup_cache_clear(cast[ptr Cache00](self.impl))

proc soup_cache_dump(self: ptr Cache00) {.
    importc, libprag.}

proc dump*(self: Cache) =
  soup_cache_dump(cast[ptr Cache00](self.impl))

proc soup_cache_flush(self: ptr Cache00) {.
    importc, libprag.}

proc flush*(self: Cache) =
  soup_cache_flush(cast[ptr Cache00](self.impl))

proc soup_cache_get_max_size(self: ptr Cache00): uint32 {.
    importc, libprag.}

proc getMaxSize*(self: Cache): int =
  int(soup_cache_get_max_size(cast[ptr Cache00](self.impl)))

proc maxSize*(self: Cache): int =
  int(soup_cache_get_max_size(cast[ptr Cache00](self.impl)))

proc soup_cache_load(self: ptr Cache00) {.
    importc, libprag.}

proc load*(self: Cache) =
  soup_cache_load(cast[ptr Cache00](self.impl))

proc soup_cache_set_max_size(self: ptr Cache00; maxSize: uint32) {.
    importc, libprag.}

proc setMaxSize*(self: Cache; maxSize: int) =
  soup_cache_set_max_size(cast[ptr Cache00](self.impl), uint32(maxSize))

proc `maxSize=`*(self: Cache; maxSize: int) =
  soup_cache_set_max_size(cast[ptr Cache00](self.impl), uint32(maxSize))

type
  CacheType* {.size: sizeof(cint), pure.} = enum
    singleUser = 0
    shared = 1

proc soup_cache_new(cacheDir: cstring; cacheType: CacheType): ptr Cache00 {.
    importc, libprag.}

proc newCache*(cacheDir: cstring = nil; cacheType: CacheType): Cache =
  let gobj = soup_cache_new(cacheDir, cacheType)
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

proc newCache*(tdesc: typedesc; cacheDir: cstring = nil; cacheType: CacheType): tdesc =
  assert(result is Cache)
  let gobj = soup_cache_new(cacheDir, cacheType)
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

proc initCache*[T](result: var T; cacheDir: cstring = nil; cacheType: CacheType) {.deprecated.} =
  assert(result is Cache)
  let gobj = soup_cache_new(cacheDir, cacheType)
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

type
  CacheabilityFlag* {.size: sizeof(cint), pure.} = enum
    cacheable = 0
    uncacheable = 1
    invalidates = 2
    validates = 3

  Cacheability* = set[CacheabilityFlag]

type
  ContentDecoder* = ref object of gobject.Object
  ContentDecoder00* = object of gobject.Object00

proc soup_content_decoder_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContentDecoder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  ContentSniffer* = ref object of gobject.Object
  ContentSniffer00* = object of gobject.Object00

proc soup_content_sniffer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContentSniffer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_content_sniffer_new(): ptr ContentSniffer00 {.
    importc, libprag.}

proc newContentSniffer*(): ContentSniffer =
  let gobj = soup_content_sniffer_new()
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

proc newContentSniffer*(tdesc: typedesc): tdesc =
  assert(result is ContentSniffer)
  let gobj = soup_content_sniffer_new()
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

proc initContentSniffer*[T](result: var T) {.deprecated.} =
  assert(result is ContentSniffer)
  let gobj = soup_content_sniffer_new()
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

proc soup_content_sniffer_sniff(self: ptr ContentSniffer00; msg: ptr Message00;
    buffer: ptr glib.Bytes00; params: var ptr HashTable00): cstring {.
    importc, libprag.}

proc sniff*(self: ContentSniffer; msg: Message; buffer: glib.Bytes;
    params: var ptr HashTable00): string =
  let resul0 = soup_content_sniffer_sniff(cast[ptr ContentSniffer00](self.impl), cast[ptr Message00](msg.impl), cast[ptr glib.Bytes00](buffer.impl), params)
  result = $resul0
  cogfree(resul0)

type
  Cookie00* {.pure.} = object
  Cookie* = ref object
    impl*: ptr Cookie00
    ignoreFinalizer*: bool

proc soup_cookie_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupCookie*(self: Cookie) =
  if not self.ignoreFinalizer:
    boxedFree(soup_cookie_get_type(), cast[ptr Cookie00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Cookie()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_cookie_get_type(), cast[ptr Cookie00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Cookie) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupCookie)

proc soup_cookie_free(self: ptr Cookie00) {.
    importc, libprag.}

proc free*(self: Cookie) =
  soup_cookie_free(cast[ptr Cookie00](self.impl))

proc finalizerfree*(self: Cookie) =
  if not self.ignoreFinalizer:
    soup_cookie_free(cast[ptr Cookie00](self.impl))

proc soup_cookie_applies_to_uri(self: ptr Cookie00; uri: ptr glib.Uri00): gboolean {.
    importc, libprag.}

proc appliesToUri*(self: Cookie; uri: glib.Uri): bool =
  toBool(soup_cookie_applies_to_uri(cast[ptr Cookie00](self.impl), cast[ptr glib.Uri00](uri.impl)))

proc soup_cookie_copy(self: ptr Cookie00): ptr Cookie00 {.
    importc, libprag.}

proc copy*(self: Cookie): Cookie =
  fnew(result, gBoxedFreeSoupCookie)
  result.impl = soup_cookie_copy(cast[ptr Cookie00](self.impl))

proc soup_cookie_domain_matches(self: ptr Cookie00; host: cstring): gboolean {.
    importc, libprag.}

proc domainMatches*(self: Cookie; host: cstring): bool =
  toBool(soup_cookie_domain_matches(cast[ptr Cookie00](self.impl), host))

proc soup_cookie_equal(self: ptr Cookie00; cookie2: ptr Cookie00): gboolean {.
    importc, libprag.}

proc equal*(self: Cookie; cookie2: Cookie): bool =
  toBool(soup_cookie_equal(cast[ptr Cookie00](self.impl), cast[ptr Cookie00](cookie2.impl)))

proc soup_cookie_new(name: cstring; value: cstring; domain: cstring; path: cstring;
    maxAge: int32): ptr Cookie00 {.
    importc, libprag.}

proc newCookie*(name: cstring; value: cstring; domain: cstring; path: cstring;
    maxAge: int): Cookie =
  fnew(result, gBoxedFreeSoupCookie)
  result.impl = soup_cookie_new(name, value, domain, path, int32(maxAge))

proc newCookie*(tdesc: typedesc; name: cstring; value: cstring; domain: cstring; path: cstring;
    maxAge: int): tdesc =
  assert(result is Cookie)
  fnew(result, gBoxedFreeSoupCookie)
  result.impl = soup_cookie_new(name, value, domain, path, int32(maxAge))

proc initCookie*[T](result: var T; name: cstring; value: cstring; domain: cstring; path: cstring;
    maxAge: int) {.deprecated.} =
  assert(result is Cookie)
  fnew(result, gBoxedFreeSoupCookie)
  result.impl = soup_cookie_new(name, value, domain, path, int32(maxAge))

proc soup_cookie_get_domain(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc getDomain*(self: Cookie): string =
  result = $soup_cookie_get_domain(cast[ptr Cookie00](self.impl))

proc domain*(self: Cookie): string =
  result = $soup_cookie_get_domain(cast[ptr Cookie00](self.impl))

proc soup_cookie_get_expires(self: ptr Cookie00): ptr glib.DateTime00 {.
    importc, libprag.}

proc getExpires*(self: Cookie): glib.DateTime =
  let impl0 = soup_cookie_get_expires(cast[ptr Cookie00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), impl0))

proc expires*(self: Cookie): glib.DateTime =
  let impl0 = soup_cookie_get_expires(cast[ptr Cookie00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), impl0))

proc soup_cookie_get_http_only(self: ptr Cookie00): gboolean {.
    importc, libprag.}

proc getHttpOnly*(self: Cookie): bool =
  toBool(soup_cookie_get_http_only(cast[ptr Cookie00](self.impl)))

proc httpOnly*(self: Cookie): bool =
  toBool(soup_cookie_get_http_only(cast[ptr Cookie00](self.impl)))

proc soup_cookie_get_name(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc getName*(self: Cookie): string =
  result = $soup_cookie_get_name(cast[ptr Cookie00](self.impl))

proc name*(self: Cookie): string =
  result = $soup_cookie_get_name(cast[ptr Cookie00](self.impl))

proc soup_cookie_get_path(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc getPath*(self: Cookie): string =
  result = $soup_cookie_get_path(cast[ptr Cookie00](self.impl))

proc path*(self: Cookie): string =
  result = $soup_cookie_get_path(cast[ptr Cookie00](self.impl))

proc soup_cookie_get_secure(self: ptr Cookie00): gboolean {.
    importc, libprag.}

proc getSecure*(self: Cookie): bool =
  toBool(soup_cookie_get_secure(cast[ptr Cookie00](self.impl)))

proc secure*(self: Cookie): bool =
  toBool(soup_cookie_get_secure(cast[ptr Cookie00](self.impl)))

proc soup_cookie_get_value(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc getValue*(self: Cookie): string =
  result = $soup_cookie_get_value(cast[ptr Cookie00](self.impl))

proc value*(self: Cookie): string =
  result = $soup_cookie_get_value(cast[ptr Cookie00](self.impl))

proc soup_cookie_set_domain(self: ptr Cookie00; domain: cstring) {.
    importc, libprag.}

proc setDomain*(self: Cookie; domain: cstring) =
  soup_cookie_set_domain(cast[ptr Cookie00](self.impl), domain)

proc `domain=`*(self: Cookie; domain: cstring) =
  soup_cookie_set_domain(cast[ptr Cookie00](self.impl), domain)

proc soup_cookie_set_expires(self: ptr Cookie00; expires: ptr glib.DateTime00) {.
    importc, libprag.}

proc setExpires*(self: Cookie; expires: glib.DateTime) =
  soup_cookie_set_expires(cast[ptr Cookie00](self.impl), cast[ptr glib.DateTime00](expires.impl))

proc `expires=`*(self: Cookie; expires: glib.DateTime) =
  soup_cookie_set_expires(cast[ptr Cookie00](self.impl), cast[ptr glib.DateTime00](expires.impl))

proc soup_cookie_set_http_only(self: ptr Cookie00; httpOnly: gboolean) {.
    importc, libprag.}

proc setHttpOnly*(self: Cookie; httpOnly: bool = true) =
  soup_cookie_set_http_only(cast[ptr Cookie00](self.impl), gboolean(httpOnly))

proc `httpOnly=`*(self: Cookie; httpOnly: bool) =
  soup_cookie_set_http_only(cast[ptr Cookie00](self.impl), gboolean(httpOnly))

proc soup_cookie_set_max_age(self: ptr Cookie00; maxAge: int32) {.
    importc, libprag.}

proc setMaxAge*(self: Cookie; maxAge: int) =
  soup_cookie_set_max_age(cast[ptr Cookie00](self.impl), int32(maxAge))

proc `maxAge=`*(self: Cookie; maxAge: int) =
  soup_cookie_set_max_age(cast[ptr Cookie00](self.impl), int32(maxAge))

proc soup_cookie_set_name(self: ptr Cookie00; name: cstring) {.
    importc, libprag.}

proc setName*(self: Cookie; name: cstring) =
  soup_cookie_set_name(cast[ptr Cookie00](self.impl), name)

proc `name=`*(self: Cookie; name: cstring) =
  soup_cookie_set_name(cast[ptr Cookie00](self.impl), name)

proc soup_cookie_set_path(self: ptr Cookie00; path: cstring) {.
    importc, libprag.}

proc setPath*(self: Cookie; path: cstring) =
  soup_cookie_set_path(cast[ptr Cookie00](self.impl), path)

proc `path=`*(self: Cookie; path: cstring) =
  soup_cookie_set_path(cast[ptr Cookie00](self.impl), path)

proc soup_cookie_set_secure(self: ptr Cookie00; secure: gboolean) {.
    importc, libprag.}

proc setSecure*(self: Cookie; secure: bool = true) =
  soup_cookie_set_secure(cast[ptr Cookie00](self.impl), gboolean(secure))

proc `secure=`*(self: Cookie; secure: bool) =
  soup_cookie_set_secure(cast[ptr Cookie00](self.impl), gboolean(secure))

proc soup_cookie_set_value(self: ptr Cookie00; value: cstring) {.
    importc, libprag.}

proc setValue*(self: Cookie; value: cstring) =
  soup_cookie_set_value(cast[ptr Cookie00](self.impl), value)

proc `value=`*(self: Cookie; value: cstring) =
  soup_cookie_set_value(cast[ptr Cookie00](self.impl), value)

proc soup_cookie_to_cookie_header(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc toCookieHeader*(self: Cookie): string =
  let resul0 = soup_cookie_to_cookie_header(cast[ptr Cookie00](self.impl))
  result = $resul0
  cogfree(resul0)

proc soup_cookie_to_set_cookie_header(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc toSetCookieHeader*(self: Cookie): string =
  let resul0 = soup_cookie_to_set_cookie_header(cast[ptr Cookie00](self.impl))
  result = $resul0
  cogfree(resul0)

proc soup_cookie_parse(header: cstring; origin: ptr glib.Uri00): ptr Cookie00 {.
    importc, libprag.}

proc parse*(header: cstring; origin: glib.Uri = nil): Cookie =
  let impl0 = soup_cookie_parse(header, if origin.isNil: nil else: cast[ptr glib.Uri00](origin.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupCookie)
  result.impl = impl0

type
  SameSitePolicy* {.size: sizeof(cint), pure.} = enum
    none = 0
    lax = 1
    strict = 2

proc soup_cookie_get_same_site_policy(self: ptr Cookie00): SameSitePolicy {.
    importc, libprag.}

proc getSameSitePolicy*(self: Cookie): SameSitePolicy =
  soup_cookie_get_same_site_policy(cast[ptr Cookie00](self.impl))

proc sameSitePolicy*(self: Cookie): SameSitePolicy =
  soup_cookie_get_same_site_policy(cast[ptr Cookie00](self.impl))

proc soup_cookie_set_same_site_policy(self: ptr Cookie00; policy: SameSitePolicy) {.
    importc, libprag.}

proc setSameSitePolicy*(self: Cookie; policy: SameSitePolicy) =
  soup_cookie_set_same_site_policy(cast[ptr Cookie00](self.impl), policy)

proc `sameSitePolicy=`*(self: Cookie; policy: SameSitePolicy) =
  soup_cookie_set_same_site_policy(cast[ptr Cookie00](self.impl), policy)

type
  CookieJar* = ref object of gobject.Object
  CookieJar00* = object of gobject.Object00

proc soup_cookie_jar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CookieJar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChanged*(self: CookieJar;  p: proc (self: ptr CookieJar00; oldCookie: ptr Cookie00; newCookie: ptr Cookie00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc soup_cookie_jar_new(): ptr CookieJar00 {.
    importc, libprag.}

proc newCookieJar*(): CookieJar =
  let gobj = soup_cookie_jar_new()
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

proc newCookieJar*(tdesc: typedesc): tdesc =
  assert(result is CookieJar)
  let gobj = soup_cookie_jar_new()
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

proc initCookieJar*[T](result: var T) {.deprecated.} =
  assert(result is CookieJar)
  let gobj = soup_cookie_jar_new()
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

proc soup_cookie_jar_add_cookie(self: ptr CookieJar00; cookie: ptr Cookie00) {.
    importc, libprag.}

proc addCookie*(self: CookieJar; cookie: Cookie) =
  soup_cookie_jar_add_cookie(cast[ptr CookieJar00](self.impl), cast[ptr Cookie00](g_boxed_copy(soup_cookie_get_type(), cookie.impl)))

proc soup_cookie_jar_add_cookie_full(self: ptr CookieJar00; cookie: ptr Cookie00;
    uri: ptr glib.Uri00; firstParty: ptr glib.Uri00) {.
    importc, libprag.}

proc addCookieFull*(self: CookieJar; cookie: Cookie; uri: glib.Uri = nil;
    firstParty: glib.Uri = nil) =
  soup_cookie_jar_add_cookie_full(cast[ptr CookieJar00](self.impl), cast[ptr Cookie00](g_boxed_copy(soup_cookie_get_type(), cookie.impl)), if uri.isNil: nil else: cast[ptr glib.Uri00](uri.impl), if firstParty.isNil: nil else: cast[ptr glib.Uri00](firstParty.impl))

proc soup_cookie_jar_add_cookie_with_first_party(self: ptr CookieJar00; firstParty: ptr glib.Uri00;
    cookie: ptr Cookie00) {.
    importc, libprag.}

proc addCookieWithFirstParty*(self: CookieJar; firstParty: glib.Uri;
    cookie: Cookie) =
  soup_cookie_jar_add_cookie_with_first_party(cast[ptr CookieJar00](self.impl), cast[ptr glib.Uri00](firstParty.impl), cast[ptr Cookie00](g_boxed_copy(soup_cookie_get_type(), cookie.impl)))

proc soup_cookie_jar_all_cookies(self: ptr CookieJar00): ptr glib.SList {.
    importc, libprag.}

proc allCookies*(self: CookieJar): seq[Cookie] =
  let resul0 = soup_cookie_jar_all_cookies(cast[ptr CookieJar00](self.impl))
  result = gslistStructs2seq[Cookie](resul0, false)
  g_slist_free(resul0)

proc soup_cookie_jar_delete_cookie(self: ptr CookieJar00; cookie: ptr Cookie00) {.
    importc, libprag.}

proc deleteCookie*(self: CookieJar; cookie: Cookie) =
  soup_cookie_jar_delete_cookie(cast[ptr CookieJar00](self.impl), cast[ptr Cookie00](cookie.impl))

proc soup_cookie_jar_get_cookie_list(self: ptr CookieJar00; uri: ptr glib.Uri00;
    forHttp: gboolean): ptr glib.SList {.
    importc, libprag.}

proc getCookieList*(self: CookieJar; uri: glib.Uri; forHttp: bool): seq[Cookie] =
  let resul0 = soup_cookie_jar_get_cookie_list(cast[ptr CookieJar00](self.impl), cast[ptr glib.Uri00](uri.impl), gboolean(forHttp))
  result = gslistStructs2seq[Cookie](resul0, false)
  g_slist_free(resul0)

proc soup_cookie_jar_get_cookie_list_with_same_site_info(self: ptr CookieJar00;
    uri: ptr glib.Uri00; topLevel: ptr glib.Uri00; siteForCookies: ptr glib.Uri00;
    forHttp: gboolean; isSafeMethod: gboolean; isTopLevelNavigation: gboolean): ptr glib.SList {.
    importc, libprag.}

proc getCookieListWithSameSiteInfo*(self: CookieJar;
    uri: glib.Uri; topLevel: glib.Uri = nil; siteForCookies: glib.Uri = nil;
    forHttp: bool; isSafeMethod: bool; isTopLevelNavigation: bool): seq[Cookie] =
  let resul0 = soup_cookie_jar_get_cookie_list_with_same_site_info(cast[ptr CookieJar00](self.impl), cast[ptr glib.Uri00](uri.impl), if topLevel.isNil: nil else: cast[ptr glib.Uri00](topLevel.impl), if siteForCookies.isNil: nil else: cast[ptr glib.Uri00](siteForCookies.impl), gboolean(forHttp), gboolean(isSafeMethod), gboolean(isTopLevelNavigation))
  result = gslistStructs2seq[Cookie](resul0, false)
  g_slist_free(resul0)

proc soup_cookie_jar_get_cookies(self: ptr CookieJar00; uri: ptr glib.Uri00;
    forHttp: gboolean): cstring {.
    importc, libprag.}

proc getCookies*(self: CookieJar; uri: glib.Uri; forHttp: bool): string =
  let resul0 = soup_cookie_jar_get_cookies(cast[ptr CookieJar00](self.impl), cast[ptr glib.Uri00](uri.impl), gboolean(forHttp))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc soup_cookie_jar_is_persistent(self: ptr CookieJar00): gboolean {.
    importc, libprag.}

proc isPersistent*(self: CookieJar): bool =
  toBool(soup_cookie_jar_is_persistent(cast[ptr CookieJar00](self.impl)))

proc soup_cookie_jar_set_cookie(self: ptr CookieJar00; uri: ptr glib.Uri00;
    cookie: cstring) {.
    importc, libprag.}

proc setCookie*(self: CookieJar; uri: glib.Uri; cookie: cstring) =
  soup_cookie_jar_set_cookie(cast[ptr CookieJar00](self.impl), cast[ptr glib.Uri00](uri.impl), cookie)

proc soup_cookie_jar_set_cookie_with_first_party(self: ptr CookieJar00; uri: ptr glib.Uri00;
    firstParty: ptr glib.Uri00; cookie: cstring) {.
    importc, libprag.}

proc setCookieWithFirstParty*(self: CookieJar; uri: glib.Uri;
    firstParty: glib.Uri; cookie: cstring) =
  soup_cookie_jar_set_cookie_with_first_party(cast[ptr CookieJar00](self.impl), cast[ptr glib.Uri00](uri.impl), cast[ptr glib.Uri00](firstParty.impl), cookie)

type
  CookieJarAcceptPolicy* {.size: sizeof(cint), pure.} = enum
    always = 0
    never = 1
    noThirdParty = 2
    grandfatheredThirdParty = 3

proc soup_cookie_jar_get_accept_policy(self: ptr CookieJar00): CookieJarAcceptPolicy {.
    importc, libprag.}

proc getAcceptPolicy*(self: CookieJar): CookieJarAcceptPolicy =
  soup_cookie_jar_get_accept_policy(cast[ptr CookieJar00](self.impl))

proc acceptPolicy*(self: CookieJar): CookieJarAcceptPolicy =
  soup_cookie_jar_get_accept_policy(cast[ptr CookieJar00](self.impl))

proc soup_cookie_jar_set_accept_policy(self: ptr CookieJar00; policy: CookieJarAcceptPolicy) {.
    importc, libprag.}

proc setAcceptPolicy*(self: CookieJar; policy: CookieJarAcceptPolicy) =
  soup_cookie_jar_set_accept_policy(cast[ptr CookieJar00](self.impl), policy)

proc `acceptPolicy=`*(self: CookieJar; policy: CookieJarAcceptPolicy) =
  soup_cookie_jar_set_accept_policy(cast[ptr CookieJar00](self.impl), policy)

type
  CookieJarDB* = ref object of CookieJar
  CookieJarDB00* = object of CookieJar00

proc soup_cookie_jar_db_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CookieJarDB()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_cookie_jar_db_new(filename: cstring; readOnly: gboolean): ptr CookieJarDB00 {.
    importc, libprag.}

proc newCookieJarDB*(filename: cstring; readOnly: bool): CookieJarDB =
  let gobj = soup_cookie_jar_db_new(filename, gboolean(readOnly))
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

proc newCookieJarDB*(tdesc: typedesc; filename: cstring; readOnly: bool): tdesc =
  assert(result is CookieJarDB)
  let gobj = soup_cookie_jar_db_new(filename, gboolean(readOnly))
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

proc initCookieJarDB*[T](result: var T; filename: cstring; readOnly: bool) {.deprecated.} =
  assert(result is CookieJarDB)
  let gobj = soup_cookie_jar_db_new(filename, gboolean(readOnly))
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

type
  CookieJarText* = ref object of CookieJar
  CookieJarText00* = object of CookieJar00

proc soup_cookie_jar_text_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CookieJarText()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_cookie_jar_text_new(filename: cstring; readOnly: gboolean): ptr CookieJarText00 {.
    importc, libprag.}

proc newCookieJarText*(filename: cstring; readOnly: bool): CookieJarText =
  let gobj = soup_cookie_jar_text_new(filename, gboolean(readOnly))
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

proc newCookieJarText*(tdesc: typedesc; filename: cstring; readOnly: bool): tdesc =
  assert(result is CookieJarText)
  let gobj = soup_cookie_jar_text_new(filename, gboolean(readOnly))
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

proc initCookieJarText*[T](result: var T; filename: cstring; readOnly: bool) {.deprecated.} =
  assert(result is CookieJarText)
  let gobj = soup_cookie_jar_text_new(filename, gboolean(readOnly))
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

type
  DateFormat* {.size: sizeof(cint), pure.} = enum
    http = 1
    cookie = 2

const FORM_MIME_TYPE_MULTIPART_STR* = "multipart/form-data"

const FORM_MIME_TYPE_URLENCODED_STR* = "application/x-www-form-urlencoded"

type
  HSTSPolicy00* {.pure.} = object
  HSTSPolicy* = ref object
    impl*: ptr HSTSPolicy00
    ignoreFinalizer*: bool

proc soup_hsts_policy_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupHSTSPolicy*(self: HSTSPolicy) =
  if not self.ignoreFinalizer:
    boxedFree(soup_hsts_policy_get_type(), cast[ptr HSTSPolicy00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HSTSPolicy()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_hsts_policy_get_type(), cast[ptr HSTSPolicy00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var HSTSPolicy) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupHSTSPolicy)

proc soup_hsts_policy_free(self: ptr HSTSPolicy00) {.
    importc, libprag.}

proc free*(self: HSTSPolicy) =
  soup_hsts_policy_free(cast[ptr HSTSPolicy00](g_boxed_copy(soup_hsts_policy_get_type(), self.impl)))

proc finalizerfree*(self: HSTSPolicy) =
  if not self.ignoreFinalizer:
    soup_hsts_policy_free(cast[ptr HSTSPolicy00](self.impl))

proc soup_hsts_policy_new_from_response(msg: ptr Message00): ptr HSTSPolicy00 {.
    importc, libprag.}

proc newHSTSPolicyFromResponse*(msg: Message): HSTSPolicy =
  let impl0 = soup_hsts_policy_new_from_response(cast[ptr Message00](msg.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = impl0

proc newHSTSPolicyFromResponse*(tdesc: typedesc; msg: Message): tdesc =
  assert(result is HSTSPolicy)
  let impl0 = soup_hsts_policy_new_from_response(cast[ptr Message00](msg.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = impl0

proc initHSTSPolicyFromResponse*[T](result: var T; msg: Message) {.deprecated.} =
  assert(result is HSTSPolicy)
  let impl0 = soup_hsts_policy_new_from_response(cast[ptr Message00](msg.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = impl0

proc soup_hsts_policy_new_full(domain: cstring; maxAge: uint64; expires: ptr glib.DateTime00;
    includeSubdomains: gboolean): ptr HSTSPolicy00 {.
    importc, libprag.}

proc newHSTSPolicyFull*(domain: cstring; maxAge: uint64; expires: glib.DateTime;
    includeSubdomains: bool): HSTSPolicy =
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_full(domain, maxAge, cast[ptr glib.DateTime00](expires.impl), gboolean(includeSubdomains))

proc newHSTSPolicyFull*(tdesc: typedesc; domain: cstring; maxAge: uint64; expires: glib.DateTime;
    includeSubdomains: bool): tdesc =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_full(domain, maxAge, cast[ptr glib.DateTime00](expires.impl), gboolean(includeSubdomains))

proc initHSTSPolicyFull*[T](result: var T; domain: cstring; maxAge: uint64; expires: glib.DateTime;
    includeSubdomains: bool) {.deprecated.} =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_full(domain, maxAge, cast[ptr glib.DateTime00](expires.impl), gboolean(includeSubdomains))

proc soup_hsts_policy_new_session_policy(domain: cstring; includeSubdomains: gboolean): ptr HSTSPolicy00 {.
    importc, libprag.}

proc newHSTSPolicySessionPolicy*(domain: cstring; includeSubdomains: bool): HSTSPolicy =
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_session_policy(domain, gboolean(includeSubdomains))

proc newHSTSPolicySessionPolicy*(tdesc: typedesc; domain: cstring; includeSubdomains: bool): tdesc =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_session_policy(domain, gboolean(includeSubdomains))

proc initHSTSPolicySessionPolicy*[T](result: var T; domain: cstring; includeSubdomains: bool) {.deprecated.} =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_session_policy(domain, gboolean(includeSubdomains))

proc soup_hsts_policy_copy(self: ptr HSTSPolicy00): ptr HSTSPolicy00 {.
    importc, libprag.}

proc copy*(self: HSTSPolicy): HSTSPolicy =
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_copy(cast[ptr HSTSPolicy00](self.impl))

proc soup_hsts_policy_equal(self: ptr HSTSPolicy00; policy2: ptr HSTSPolicy00): gboolean {.
    importc, libprag.}

proc equal*(self: HSTSPolicy; policy2: HSTSPolicy): bool =
  toBool(soup_hsts_policy_equal(cast[ptr HSTSPolicy00](self.impl), cast[ptr HSTSPolicy00](policy2.impl)))

proc soup_hsts_policy_new(domain: cstring; maxAge: uint64; includeSubdomains: gboolean): ptr HSTSPolicy00 {.
    importc, libprag.}

proc newHSTSPolicy*(domain: cstring; maxAge: uint64; includeSubdomains: bool): HSTSPolicy =
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new(domain, maxAge, gboolean(includeSubdomains))

proc newHSTSPolicy*(tdesc: typedesc; domain: cstring; maxAge: uint64; includeSubdomains: bool): tdesc =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new(domain, maxAge, gboolean(includeSubdomains))

proc initHSTSPolicy*[T](result: var T; domain: cstring; maxAge: uint64; includeSubdomains: bool) {.deprecated.} =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new(domain, maxAge, gboolean(includeSubdomains))

proc soup_hsts_policy_get_domain(self: ptr HSTSPolicy00): cstring {.
    importc, libprag.}

proc getDomain*(self: HSTSPolicy): string =
  result = $soup_hsts_policy_get_domain(cast[ptr HSTSPolicy00](self.impl))

proc domain*(self: HSTSPolicy): string =
  result = $soup_hsts_policy_get_domain(cast[ptr HSTSPolicy00](self.impl))

proc soup_hsts_policy_get_expires(self: ptr HSTSPolicy00): ptr glib.DateTime00 {.
    importc, libprag.}

proc getExpires*(self: HSTSPolicy): glib.DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = soup_hsts_policy_get_expires(cast[ptr HSTSPolicy00](self.impl))

proc expires*(self: HSTSPolicy): glib.DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = soup_hsts_policy_get_expires(cast[ptr HSTSPolicy00](self.impl))

proc soup_hsts_policy_get_max_age(self: ptr HSTSPolicy00): uint64 {.
    importc, libprag.}

proc getMaxAge*(self: HSTSPolicy): uint64 =
  soup_hsts_policy_get_max_age(cast[ptr HSTSPolicy00](self.impl))

proc maxAge*(self: HSTSPolicy): uint64 =
  soup_hsts_policy_get_max_age(cast[ptr HSTSPolicy00](self.impl))

proc soup_hsts_policy_includes_subdomains(self: ptr HSTSPolicy00): gboolean {.
    importc, libprag.}

proc includesSubdomains*(self: HSTSPolicy): bool =
  toBool(soup_hsts_policy_includes_subdomains(cast[ptr HSTSPolicy00](self.impl)))

proc soup_hsts_policy_is_expired(self: ptr HSTSPolicy00): gboolean {.
    importc, libprag.}

proc isExpired*(self: HSTSPolicy): bool =
  toBool(soup_hsts_policy_is_expired(cast[ptr HSTSPolicy00](self.impl)))

proc soup_hsts_policy_is_session_policy(self: ptr HSTSPolicy00): gboolean {.
    importc, libprag.}

proc isSessionPolicy*(self: HSTSPolicy): bool =
  toBool(soup_hsts_policy_is_session_policy(cast[ptr HSTSPolicy00](self.impl)))

type
  HSTSEnforcer* = ref object of gobject.Object
  HSTSEnforcer00* = object of gobject.Object00

proc soup_hsts_enforcer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HSTSEnforcer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChanged*(self: HSTSEnforcer;  p: proc (self: ptr HSTSEnforcer00; oldPolicy: ptr HSTSPolicy00; newPolicy: ptr HSTSPolicy00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc soup_hsts_enforcer_new(): ptr HSTSEnforcer00 {.
    importc, libprag.}

proc newHSTSEnforcer*(): HSTSEnforcer =
  let gobj = soup_hsts_enforcer_new()
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

proc newHSTSEnforcer*(tdesc: typedesc): tdesc =
  assert(result is HSTSEnforcer)
  let gobj = soup_hsts_enforcer_new()
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

proc initHSTSEnforcer*[T](result: var T) {.deprecated.} =
  assert(result is HSTSEnforcer)
  let gobj = soup_hsts_enforcer_new()
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

proc soup_hsts_enforcer_get_domains(self: ptr HSTSEnforcer00; sessionPolicies: gboolean): ptr glib.List {.
    importc, libprag.}

proc getDomains*(self: HSTSEnforcer; sessionPolicies: bool): seq[cstring] =
  let resul0 = soup_hsts_enforcer_get_domains(cast[ptr HSTSEnforcer00](self.impl), gboolean(sessionPolicies))
  g_list_free(resul0)

proc soup_hsts_enforcer_get_policies(self: ptr HSTSEnforcer00; sessionPolicies: gboolean): ptr glib.List {.
    importc, libprag.}

proc getPolicies*(self: HSTSEnforcer; sessionPolicies: bool): seq[HSTSPolicy] =
  let resul0 = soup_hsts_enforcer_get_policies(cast[ptr HSTSEnforcer00](self.impl), gboolean(sessionPolicies))
  result = glistStructs2seq[HSTSPolicy](resul0, false)
  g_list_free(resul0)

proc soup_hsts_enforcer_has_valid_policy(self: ptr HSTSEnforcer00; domain: cstring): gboolean {.
    importc, libprag.}

proc hasValidPolicy*(self: HSTSEnforcer; domain: cstring): bool =
  toBool(soup_hsts_enforcer_has_valid_policy(cast[ptr HSTSEnforcer00](self.impl), domain))

proc soup_hsts_enforcer_is_persistent(self: ptr HSTSEnforcer00): gboolean {.
    importc, libprag.}

proc isPersistent*(self: HSTSEnforcer): bool =
  toBool(soup_hsts_enforcer_is_persistent(cast[ptr HSTSEnforcer00](self.impl)))

proc soup_hsts_enforcer_set_policy(self: ptr HSTSEnforcer00; policy: ptr HSTSPolicy00) {.
    importc, libprag.}

proc setPolicy*(self: HSTSEnforcer; policy: HSTSPolicy) =
  soup_hsts_enforcer_set_policy(cast[ptr HSTSEnforcer00](self.impl), cast[ptr HSTSPolicy00](policy.impl))

proc `policy=`*(self: HSTSEnforcer; policy: HSTSPolicy) =
  soup_hsts_enforcer_set_policy(cast[ptr HSTSEnforcer00](self.impl), cast[ptr HSTSPolicy00](policy.impl))

proc soup_hsts_enforcer_set_session_policy(self: ptr HSTSEnforcer00; domain: cstring;
    includeSubdomains: gboolean) {.
    importc, libprag.}

proc setSessionPolicy*(self: HSTSEnforcer; domain: cstring;
    includeSubdomains: bool) =
  soup_hsts_enforcer_set_session_policy(cast[ptr HSTSEnforcer00](self.impl), domain, gboolean(includeSubdomains))

type
  HSTSEnforcerDB* = ref object of HSTSEnforcer
  HSTSEnforcerDB00* = object of HSTSEnforcer00

proc soup_hsts_enforcer_db_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HSTSEnforcerDB()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_hsts_enforcer_db_new(filename: cstring): ptr HSTSEnforcerDB00 {.
    importc, libprag.}

proc newHSTSEnforcerDB*(filename: cstring): HSTSEnforcerDB =
  let gobj = soup_hsts_enforcer_db_new(filename)
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

proc newHSTSEnforcerDB*(tdesc: typedesc; filename: cstring): tdesc =
  assert(result is HSTSEnforcerDB)
  let gobj = soup_hsts_enforcer_db_new(filename)
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

proc initHSTSEnforcerDB*[T](result: var T; filename: cstring) {.deprecated.} =
  assert(result is HSTSEnforcerDB)
  let gobj = soup_hsts_enforcer_db_new(filename)
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

const HSTS_POLICY_MAX_AGE_PAST_STR* = 0'i32

const HTTP_URI_FLAGS_STR* = 482'i32

type
  Logger* = ref object of gobject.Object
  Logger00* = object of gobject.Object00

proc soup_logger_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Logger()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_logger_get_max_body_size(self: ptr Logger00): int32 {.
    importc, libprag.}

proc getMaxBodySize*(self: Logger): int =
  int(soup_logger_get_max_body_size(cast[ptr Logger00](self.impl)))

proc maxBodySize*(self: Logger): int =
  int(soup_logger_get_max_body_size(cast[ptr Logger00](self.impl)))

proc soup_logger_set_max_body_size(self: ptr Logger00; maxBodySize: int32) {.
    importc, libprag.}

proc setMaxBodySize*(self: Logger; maxBodySize: int) =
  soup_logger_set_max_body_size(cast[ptr Logger00](self.impl), int32(maxBodySize))

proc `maxBodySize=`*(self: Logger; maxBodySize: int) =
  soup_logger_set_max_body_size(cast[ptr Logger00](self.impl), int32(maxBodySize))

type
  LoggerLogLevel* {.size: sizeof(cint), pure.} = enum
    none = 0
    minimal = 1
    headers = 2
    body = 3

proc soup_logger_new(level: LoggerLogLevel): ptr Logger00 {.
    importc, libprag.}

proc newLogger*(level: LoggerLogLevel): Logger =
  let gobj = soup_logger_new(level)
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

proc newLogger*(tdesc: typedesc; level: LoggerLogLevel): tdesc =
  assert(result is Logger)
  let gobj = soup_logger_new(level)
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

proc initLogger*[T](result: var T; level: LoggerLogLevel) {.deprecated.} =
  assert(result is Logger)
  let gobj = soup_logger_new(level)
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

type
  LoggerFilter* = proc (logger: ptr Logger00; msg: ptr Message00; userData: pointer): LoggerLogLevel {.cdecl.}

proc soup_logger_set_request_filter(self: ptr Logger00; requestFilter: LoggerFilter;
    filterData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc setRequestFilter*(self: Logger; requestFilter: LoggerFilter;
    filterData: pointer; destroy: DestroyNotify) =
  soup_logger_set_request_filter(cast[ptr Logger00](self.impl), requestFilter, filterData, destroy)

proc soup_logger_set_response_filter(self: ptr Logger00; responseFilter: LoggerFilter;
    filterData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc setResponseFilter*(self: Logger; responseFilter: LoggerFilter;
    filterData: pointer; destroy: DestroyNotify) =
  soup_logger_set_response_filter(cast[ptr Logger00](self.impl), responseFilter, filterData, destroy)

type
  LoggerPrinter* = proc (logger: ptr Logger00; level: LoggerLogLevel; direction: int8; data: cstring;
    userData: pointer) {.cdecl.}

proc soup_logger_set_printer(self: ptr Logger00; printer: LoggerPrinter;
    printerData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc setPrinter*(self: Logger; printer: LoggerPrinter; printerData: pointer;
    destroy: DestroyNotify) =
  soup_logger_set_printer(cast[ptr Logger00](self.impl), printer, printerData, destroy)

const MAJOR_VERSION_STR* = 3'i32

const MICRO_VERSION_STR* = 4'i32

const MINOR_VERSION_STR* = 4'i32

type
  MessageHeadersForeachFunc* = proc (name: cstring; value: cstring; userData: pointer) {.cdecl.}

proc soup_message_headers_foreach(self: ptr MessageHeaders00; `func`: MessageHeadersForeachFunc;
    userData: pointer) {.
    importc, libprag.}

proc foreach*(self: MessageHeaders; `func`: MessageHeadersForeachFunc;
    userData: pointer) =
  soup_message_headers_foreach(cast[ptr MessageHeaders00](self.impl), `func`, userData)

type
  MessageHeadersIter00* {.pure.} = object
  MessageHeadersIter* = ref object
    impl*: ptr MessageHeadersIter00
    ignoreFinalizer*: bool

proc soup_message_headers_iter_next(self: ptr MessageHeadersIter00; name: var cstring;
    value: var cstring): gboolean {.
    importc, libprag.}

proc next*(self: MessageHeadersIter; name: var string;
    value: var string): bool =
  var name_00: cstring
  var value_00: cstring
  result = toBool(soup_message_headers_iter_next(cast[ptr MessageHeadersIter00](self.impl), name_00, value_00))
  if name.addr != nil:
    name = $(name_00)
  if value.addr != nil:
    value = $(value_00)

proc soup_message_headers_iter_init(iter: var MessageHeadersIter00; hdrs: ptr MessageHeaders00) {.
    importc, libprag.}

proc init*(iter: var MessageHeadersIter00; hdrs: MessageHeaders) =
  soup_message_headers_iter_init(iter, cast[ptr MessageHeaders00](hdrs.impl))

type
  MultipartInputStream* = ref object of gio.FilterInputStream
  MultipartInputStream00* = object of gio.FilterInputStream00

proc soup_multipart_input_stream_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MultipartInputStream()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_multipart_input_stream_new(msg: ptr Message00; baseStream: ptr gio.InputStream00): ptr MultipartInputStream00 {.
    importc, libprag.}

proc newMultipartInputStream*(msg: Message; baseStream: gio.InputStream): MultipartInputStream =
  let gobj = soup_multipart_input_stream_new(cast[ptr Message00](msg.impl), cast[ptr gio.InputStream00](baseStream.impl))
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

proc newMultipartInputStream*(tdesc: typedesc; msg: Message; baseStream: gio.InputStream): tdesc =
  assert(result is MultipartInputStream)
  let gobj = soup_multipart_input_stream_new(cast[ptr Message00](msg.impl), cast[ptr gio.InputStream00](baseStream.impl))
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

proc initMultipartInputStream*[T](result: var T; msg: Message; baseStream: gio.InputStream) {.deprecated.} =
  assert(result is MultipartInputStream)
  let gobj = soup_multipart_input_stream_new(cast[ptr Message00](msg.impl), cast[ptr gio.InputStream00](baseStream.impl))
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

proc soup_multipart_input_stream_get_headers(self: ptr MultipartInputStream00): ptr MessageHeaders00 {.
    importc, libprag.}

proc getHeaders*(self: MultipartInputStream): MessageHeaders =
  let impl0 = soup_multipart_input_stream_get_headers(cast[ptr MultipartInputStream00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), impl0))

proc headers*(self: MultipartInputStream): MessageHeaders =
  let impl0 = soup_multipart_input_stream_get_headers(cast[ptr MultipartInputStream00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), impl0))

proc soup_multipart_input_stream_next_part(self: ptr MultipartInputStream00;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc nextPart*(self: MultipartInputStream; cancellable: gio.Cancellable = nil): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = soup_multipart_input_stream_next_part(cast[ptr MultipartInputStream00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
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

proc soup_multipart_input_stream_next_part_async(self: ptr MultipartInputStream00;
    ioPriority: int32; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    data: pointer) {.
    importc, libprag.}

proc nextPartAsync*(self: MultipartInputStream;
    ioPriority: int; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    data: pointer) =
  soup_multipart_input_stream_next_part_async(cast[ptr MultipartInputStream00](self.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, data)

proc soup_multipart_input_stream_next_part_finish(self: ptr MultipartInputStream00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc nextPartFinish*(self: MultipartInputStream;
    resu: gio.AsyncResult): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = soup_multipart_input_stream_next_part_finish(cast[ptr MultipartInputStream00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
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

type
  Server* = ref object of gobject.Object
  Server00* = object of gobject.Object00

proc soup_server_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Server()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scRequestAborted*(self: Server;  p: proc (self: ptr Server00; message: ptr ServerMessage00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-aborted", cast[GCallback](p), xdata, nil, cf)

proc scRequestFinished*(self: Server;  p: proc (self: ptr Server00; message: ptr ServerMessage00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-finished", cast[GCallback](p), xdata, nil, cf)

proc scRequestRead*(self: Server;  p: proc (self: ptr Server00; message: ptr ServerMessage00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-read", cast[GCallback](p), xdata, nil, cf)

proc scRequestStarted*(self: Server;  p: proc (self: ptr Server00; message: ptr ServerMessage00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-started", cast[GCallback](p), xdata, nil, cf)

proc soup_server_accept_iostream(self: ptr Server00; stream: ptr gio.IOStream00;
    localAddr: ptr gio.SocketAddress00; remoteAddr: ptr gio.SocketAddress00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc acceptIostream*(self: Server; stream: gio.IOStream; localAddr: gio.SocketAddress = nil;
    remoteAddr: gio.SocketAddress = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_accept_iostream(cast[ptr Server00](self.impl), cast[ptr gio.IOStream00](stream.impl), if localAddr.isNil: nil else: cast[ptr gio.SocketAddress00](localAddr.impl), if remoteAddr.isNil: nil else: cast[ptr gio.SocketAddress00](remoteAddr.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_server_add_auth_domain(self: ptr Server00; authDomain: ptr AuthDomain00) {.
    importc, libprag.}

proc addAuthDomain*(self: Server; authDomain: AuthDomain) =
  soup_server_add_auth_domain(cast[ptr Server00](self.impl), cast[ptr AuthDomain00](authDomain.impl))

proc soup_server_add_websocket_extension(self: ptr Server00; extensionType: GType) {.
    importc, libprag.}

proc addWebsocketExtension*(self: Server; extensionType: GType) =
  soup_server_add_websocket_extension(cast[ptr Server00](self.impl), extensionType)

proc soup_server_disconnect(self: ptr Server00) {.
    importc, libprag.}

proc disconnect*(self: Server) =
  soup_server_disconnect(cast[ptr Server00](self.impl))

proc soup_server_get_listeners(self: ptr Server00): ptr glib.SList {.
    importc, libprag.}

proc getListeners*(self: Server): seq[gio.Socket] =
  let resul0 = soup_server_get_listeners(cast[ptr Server00](self.impl))
  result = gslistObjects2seq(gio.Socket, resul0, false)
  g_slist_free(resul0)

proc listeners*(self: Server): seq[gio.Socket] =
  let resul0 = soup_server_get_listeners(cast[ptr Server00](self.impl))
  result = gslistObjects2seq(gio.Socket, resul0, false)
  g_slist_free(resul0)

proc soup_server_get_tls_auth_mode(self: ptr Server00): gio.TlsAuthenticationMode {.
    importc, libprag.}

proc getTlsAuthMode*(self: Server): gio.TlsAuthenticationMode =
  soup_server_get_tls_auth_mode(cast[ptr Server00](self.impl))

proc tlsAuthMode*(self: Server): gio.TlsAuthenticationMode =
  soup_server_get_tls_auth_mode(cast[ptr Server00](self.impl))

proc soup_server_get_tls_certificate(self: ptr Server00): ptr gio.TlsCertificate00 {.
    importc, libprag.}

proc getTlsCertificate*(self: Server): gio.TlsCertificate =
  let gobj = soup_server_get_tls_certificate(cast[ptr Server00](self.impl))
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

proc tlsCertificate*(self: Server): gio.TlsCertificate =
  let gobj = soup_server_get_tls_certificate(cast[ptr Server00](self.impl))
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

proc soup_server_get_tls_database(self: ptr Server00): ptr gio.TlsDatabase00 {.
    importc, libprag.}

proc getTlsDatabase*(self: Server): gio.TlsDatabase =
  let gobj = soup_server_get_tls_database(cast[ptr Server00](self.impl))
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

proc tlsDatabase*(self: Server): gio.TlsDatabase =
  let gobj = soup_server_get_tls_database(cast[ptr Server00](self.impl))
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

proc soup_server_get_uris(self: ptr Server00): ptr glib.SList {.
    importc, libprag.}

proc getUris*(self: Server): seq[glib.Uri] =
  let resul0 = soup_server_get_uris(cast[ptr Server00](self.impl))
  result = gslistStructs2seq[glib.Uri](resul0, false)
  g_slist_free(resul0)

proc uris*(self: Server): seq[glib.Uri] =
  let resul0 = soup_server_get_uris(cast[ptr Server00](self.impl))
  result = gslistStructs2seq[glib.Uri](resul0, false)
  g_slist_free(resul0)

proc soup_server_is_https(self: ptr Server00): gboolean {.
    importc, libprag.}

proc isHttps*(self: Server): bool =
  toBool(soup_server_is_https(cast[ptr Server00](self.impl)))

proc soup_server_pause_message(self: ptr Server00; msg: ptr ServerMessage00) {.
    importc, libprag.}

proc pauseMessage*(self: Server; msg: ServerMessage) =
  soup_server_pause_message(cast[ptr Server00](self.impl), cast[ptr ServerMessage00](msg.impl))

proc soup_server_remove_auth_domain(self: ptr Server00; authDomain: ptr AuthDomain00) {.
    importc, libprag.}

proc removeAuthDomain*(self: Server; authDomain: AuthDomain) =
  soup_server_remove_auth_domain(cast[ptr Server00](self.impl), cast[ptr AuthDomain00](authDomain.impl))

proc soup_server_remove_handler(self: ptr Server00; path: cstring) {.
    importc, libprag.}

proc removeHandler*(self: Server; path: cstring) =
  soup_server_remove_handler(cast[ptr Server00](self.impl), path)

proc soup_server_remove_websocket_extension(self: ptr Server00; extensionType: GType) {.
    importc, libprag.}

proc removeWebsocketExtension*(self: Server; extensionType: GType) =
  soup_server_remove_websocket_extension(cast[ptr Server00](self.impl), extensionType)

proc soup_server_set_tls_auth_mode(self: ptr Server00; mode: gio.TlsAuthenticationMode) {.
    importc, libprag.}

proc setTlsAuthMode*(self: Server; mode: gio.TlsAuthenticationMode) =
  soup_server_set_tls_auth_mode(cast[ptr Server00](self.impl), mode)

proc `tlsAuthMode=`*(self: Server; mode: gio.TlsAuthenticationMode) =
  soup_server_set_tls_auth_mode(cast[ptr Server00](self.impl), mode)

proc soup_server_set_tls_certificate(self: ptr Server00; certificate: ptr gio.TlsCertificate00) {.
    importc, libprag.}

proc setTlsCertificate*(self: Server; certificate: gio.TlsCertificate) =
  soup_server_set_tls_certificate(cast[ptr Server00](self.impl), cast[ptr gio.TlsCertificate00](certificate.impl))

proc `tlsCertificate=`*(self: Server; certificate: gio.TlsCertificate) =
  soup_server_set_tls_certificate(cast[ptr Server00](self.impl), cast[ptr gio.TlsCertificate00](certificate.impl))

proc soup_server_set_tls_database(self: ptr Server00; tlsDatabase: ptr gio.TlsDatabase00) {.
    importc, libprag.}

proc setTlsDatabase*(self: Server; tlsDatabase: gio.TlsDatabase) =
  soup_server_set_tls_database(cast[ptr Server00](self.impl), cast[ptr gio.TlsDatabase00](tlsDatabase.impl))

proc `tlsDatabase=`*(self: Server; tlsDatabase: gio.TlsDatabase) =
  soup_server_set_tls_database(cast[ptr Server00](self.impl), cast[ptr gio.TlsDatabase00](tlsDatabase.impl))

proc soup_server_unpause_message(self: ptr Server00; msg: ptr ServerMessage00) {.
    importc, libprag.}

proc unpauseMessage*(self: Server; msg: ServerMessage) =
  soup_server_unpause_message(cast[ptr Server00](self.impl), cast[ptr ServerMessage00](msg.impl))

type
  ServerListenOptionsFlag* {.size: sizeof(cint), pure.} = enum
    https = 0
    ipv4Only = 1
    ipv6Only = 2

  ServerListenOptions* = set[ServerListenOptionsFlag]

proc soup_server_listen(self: ptr Server00; address: ptr gio.SocketAddress00;
    options: ServerListenOptions; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc listen*(self: Server; address: gio.SocketAddress; options: ServerListenOptions): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_listen(cast[ptr Server00](self.impl), cast[ptr gio.SocketAddress00](address.impl), options, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_server_listen_all(self: ptr Server00; port: uint32; options: ServerListenOptions;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc listenAll*(self: Server; port: int; options: ServerListenOptions): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_listen_all(cast[ptr Server00](self.impl), uint32(port), options, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_server_listen_local(self: ptr Server00; port: uint32; options: ServerListenOptions;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc listenLocal*(self: Server; port: int; options: ServerListenOptions): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_listen_local(cast[ptr Server00](self.impl), uint32(port), options, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_server_listen_socket(self: ptr Server00; socket: ptr gio.Socket00;
    options: ServerListenOptions; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc listenSocket*(self: Server; socket: gio.Socket; options: ServerListenOptions): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_listen_socket(cast[ptr Server00](self.impl), cast[ptr gio.Socket00](socket.impl), options, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  ServerCallback* = proc (server: ptr Server00; msg: ptr ServerMessage00; path: cstring; query: ptr HashTable00;
    userData: pointer) {.cdecl.}

proc soup_server_add_early_handler(self: ptr Server00; path: cstring; callback: ServerCallback;
    userData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc addEarlyHandler*(self: Server; path: cstring = nil; callback: ServerCallback;
    userData: pointer; destroy: DestroyNotify) =
  soup_server_add_early_handler(cast[ptr Server00](self.impl), path, callback, userData, destroy)

proc soup_server_add_handler(self: ptr Server00; path: cstring; callback: ServerCallback;
    userData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc addHandler*(self: Server; path: cstring = nil; callback: ServerCallback;
    userData: pointer; destroy: DestroyNotify) =
  soup_server_add_handler(cast[ptr Server00](self.impl), path, callback, userData, destroy)

type
  WebsocketConnection* = ref object of gobject.Object
  WebsocketConnection00* = object of gobject.Object00

proc soup_websocket_connection_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsocketConnection()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scClosed*(self: WebsocketConnection;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cf)

proc scClosing*(self: WebsocketConnection;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closing", cast[GCallback](p), xdata, nil, cf)

proc scError*(self: WebsocketConnection;  p: proc (self: ptr WebsocketConnection00; error: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "error", cast[GCallback](p), xdata, nil, cf)

proc scMessage*(self: WebsocketConnection;  p: proc (self: ptr WebsocketConnection00; `type`: int32; message: ptr glib.Bytes00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "message", cast[GCallback](p), xdata, nil, cf)

proc scPong*(self: WebsocketConnection;  p: proc (self: ptr WebsocketConnection00; message: ptr glib.Bytes00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "pong", cast[GCallback](p), xdata, nil, cf)

proc soup_websocket_connection_close(self: ptr WebsocketConnection00; code: uint16;
    data: cstring) {.
    importc, libprag.}

proc close*(self: WebsocketConnection; code: uint16;
    data: cstring = nil) =
  soup_websocket_connection_close(cast[ptr WebsocketConnection00](self.impl), code, data)

proc soup_websocket_connection_get_close_code(self: ptr WebsocketConnection00): uint16 {.
    importc, libprag.}

proc getCloseCode*(self: WebsocketConnection): uint16 =
  soup_websocket_connection_get_close_code(cast[ptr WebsocketConnection00](self.impl))

proc closeCode*(self: WebsocketConnection): uint16 =
  soup_websocket_connection_get_close_code(cast[ptr WebsocketConnection00](self.impl))

proc soup_websocket_connection_get_close_data(self: ptr WebsocketConnection00): cstring {.
    importc, libprag.}

proc getCloseData*(self: WebsocketConnection): string =
  result = $soup_websocket_connection_get_close_data(cast[ptr WebsocketConnection00](self.impl))

proc closeData*(self: WebsocketConnection): string =
  result = $soup_websocket_connection_get_close_data(cast[ptr WebsocketConnection00](self.impl))

proc soup_websocket_connection_get_io_stream(self: ptr WebsocketConnection00): ptr gio.IOStream00 {.
    importc, libprag.}

proc getIoStream*(self: WebsocketConnection): gio.IOStream =
  let gobj = soup_websocket_connection_get_io_stream(cast[ptr WebsocketConnection00](self.impl))
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

proc ioStream*(self: WebsocketConnection): gio.IOStream =
  let gobj = soup_websocket_connection_get_io_stream(cast[ptr WebsocketConnection00](self.impl))
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

proc soup_websocket_connection_get_keepalive_interval(self: ptr WebsocketConnection00): uint32 {.
    importc, libprag.}

proc getKeepaliveInterval*(self: WebsocketConnection): int =
  int(soup_websocket_connection_get_keepalive_interval(cast[ptr WebsocketConnection00](self.impl)))

proc keepaliveInterval*(self: WebsocketConnection): int =
  int(soup_websocket_connection_get_keepalive_interval(cast[ptr WebsocketConnection00](self.impl)))

proc soup_websocket_connection_get_max_incoming_payload_size(self: ptr WebsocketConnection00): uint64 {.
    importc, libprag.}

proc getMaxIncomingPayloadSize*(self: WebsocketConnection): uint64 =
  soup_websocket_connection_get_max_incoming_payload_size(cast[ptr WebsocketConnection00](self.impl))

proc maxIncomingPayloadSize*(self: WebsocketConnection): uint64 =
  soup_websocket_connection_get_max_incoming_payload_size(cast[ptr WebsocketConnection00](self.impl))

proc soup_websocket_connection_get_origin(self: ptr WebsocketConnection00): cstring {.
    importc, libprag.}

proc getOrigin*(self: WebsocketConnection): string =
  let resul0 = soup_websocket_connection_get_origin(cast[ptr WebsocketConnection00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc origin*(self: WebsocketConnection): string =
  let resul0 = soup_websocket_connection_get_origin(cast[ptr WebsocketConnection00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_websocket_connection_get_protocol(self: ptr WebsocketConnection00): cstring {.
    importc, libprag.}

proc getProtocol*(self: WebsocketConnection): string =
  let resul0 = soup_websocket_connection_get_protocol(cast[ptr WebsocketConnection00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc protocol*(self: WebsocketConnection): string =
  let resul0 = soup_websocket_connection_get_protocol(cast[ptr WebsocketConnection00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_websocket_connection_get_uri(self: ptr WebsocketConnection00): ptr glib.Uri00 {.
    importc, libprag.}

proc getUri*(self: WebsocketConnection): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = soup_websocket_connection_get_uri(cast[ptr WebsocketConnection00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc uri*(self: WebsocketConnection): glib.Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = soup_websocket_connection_get_uri(cast[ptr WebsocketConnection00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_uri_get_type(), result.impl))

proc soup_websocket_connection_send_binary(self: ptr WebsocketConnection00;
    data: ptr uint8; length: uint64) {.
    importc, libprag.}

proc sendBinary*(self: WebsocketConnection; data: seq[uint8] | string) =
  let length = uint64(data.len)
  soup_websocket_connection_send_binary(cast[ptr WebsocketConnection00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), length)

proc soup_websocket_connection_send_text(self: ptr WebsocketConnection00;
    text: cstring) {.
    importc, libprag.}

proc sendText*(self: WebsocketConnection; text: cstring) =
  soup_websocket_connection_send_text(cast[ptr WebsocketConnection00](self.impl), text)

proc soup_websocket_connection_set_keepalive_interval(self: ptr WebsocketConnection00;
    interval: uint32) {.
    importc, libprag.}

proc setKeepaliveInterval*(self: WebsocketConnection;
    interval: int) =
  soup_websocket_connection_set_keepalive_interval(cast[ptr WebsocketConnection00](self.impl), uint32(interval))

proc `keepaliveInterval=`*(self: WebsocketConnection;
    interval: int) =
  soup_websocket_connection_set_keepalive_interval(cast[ptr WebsocketConnection00](self.impl), uint32(interval))

proc soup_websocket_connection_set_max_incoming_payload_size(self: ptr WebsocketConnection00;
    maxIncomingPayloadSize: uint64) {.
    importc, libprag.}

proc setMaxIncomingPayloadSize*(self: WebsocketConnection;
    maxIncomingPayloadSize: uint64) =
  soup_websocket_connection_set_max_incoming_payload_size(cast[ptr WebsocketConnection00](self.impl), maxIncomingPayloadSize)

proc `maxIncomingPayloadSize=`*(self: WebsocketConnection;
    maxIncomingPayloadSize: uint64) =
  soup_websocket_connection_set_max_incoming_payload_size(cast[ptr WebsocketConnection00](self.impl), maxIncomingPayloadSize)

type
  ServerWebsocketCallback* = proc (server: ptr Server00; msg: ptr ServerMessage00; path: cstring; connection: ptr WebsocketConnection00;
    userData: pointer) {.cdecl.}

proc soup_server_add_websocket_handler(self: ptr Server00; path: cstring;
    origin: cstring; protocols: ptr cstring; callback: ServerWebsocketCallback;
    userData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc addWebsocketHandler*(self: Server; path: cstring = nil;
    origin: cstring = nil; protocols: openArray[string]; callback: ServerWebsocketCallback;
    userData: pointer; destroy: DestroyNotify) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  soup_server_add_websocket_handler(cast[ptr Server00](self.impl), path, origin, seq2CstringArray(protocols, fs469n23), callback, userData, destroy)

type
  WebsocketConnectionType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    client = 1
    server = 2

proc soup_websocket_connection_get_connection_type(self: ptr WebsocketConnection00): WebsocketConnectionType {.
    importc, libprag.}

proc getConnectionType*(self: WebsocketConnection): WebsocketConnectionType =
  soup_websocket_connection_get_connection_type(cast[ptr WebsocketConnection00](self.impl))

proc connectionType*(self: WebsocketConnection): WebsocketConnectionType =
  soup_websocket_connection_get_connection_type(cast[ptr WebsocketConnection00](self.impl))

type
  WebsocketExtension* = ref object of gobject.Object
  WebsocketExtension00* = object of gobject.Object00

proc soup_websocket_extension_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsocketExtension()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_websocket_extension_configure(self: ptr WebsocketExtension00; connectionType: WebsocketConnectionType;
    params: ptr HashTable00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc configure*(self: WebsocketExtension; connectionType: WebsocketConnectionType;
    params: ptr HashTable00): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_websocket_extension_configure(cast[ptr WebsocketExtension00](self.impl), connectionType, params, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_websocket_extension_get_request_params(self: ptr WebsocketExtension00): cstring {.
    importc, libprag.}

proc getRequestParams*(self: WebsocketExtension): string =
  let resul0 = soup_websocket_extension_get_request_params(cast[ptr WebsocketExtension00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc requestParams*(self: WebsocketExtension): string =
  let resul0 = soup_websocket_extension_get_request_params(cast[ptr WebsocketExtension00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc soup_websocket_extension_get_response_params(self: ptr WebsocketExtension00): cstring {.
    importc, libprag.}

proc getResponseParams*(self: WebsocketExtension): string =
  let resul0 = soup_websocket_extension_get_response_params(cast[ptr WebsocketExtension00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc responseParams*(self: WebsocketExtension): string =
  let resul0 = soup_websocket_extension_get_response_params(cast[ptr WebsocketExtension00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc soup_websocket_extension_process_incoming_message(self: ptr WebsocketExtension00;
    header: var uint8; payload: ptr glib.Bytes00; error: ptr ptr glib.Error = nil): ptr glib.Bytes00 {.
    importc, libprag.}

proc processIncomingMessage*(self: WebsocketExtension;
    header: var uint8; payload: glib.Bytes): glib.Bytes =
  var gerror: ptr glib.Error
  let impl0 = soup_websocket_extension_process_incoming_message(cast[ptr WebsocketExtension00](self.impl), header, cast[ptr glib.Bytes00](g_boxed_copy(g_bytes_get_type(), payload.impl)), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGBytes)
  result.impl = impl0

proc soup_websocket_extension_process_outgoing_message(self: ptr WebsocketExtension00;
    header: var uint8; payload: ptr glib.Bytes00; error: ptr ptr glib.Error = nil): ptr glib.Bytes00 {.
    importc, libprag.}

proc processOutgoingMessage*(self: WebsocketExtension;
    header: var uint8; payload: glib.Bytes): glib.Bytes =
  var gerror: ptr glib.Error
  let impl0 = soup_websocket_extension_process_outgoing_message(cast[ptr WebsocketExtension00](self.impl), header, cast[ptr glib.Bytes00](g_boxed_copy(g_bytes_get_type(), payload.impl)), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGBytes)
  result.impl = impl0

proc soup_websocket_connection_new(stream: ptr gio.IOStream00; uri: ptr glib.Uri00;
    `type`: WebsocketConnectionType; origin: cstring; protocol: cstring; extensions: ptr glib.List): ptr WebsocketConnection00 {.
    importc, libprag.}

proc newWebsocketConnection*(stream: gio.IOStream; uri: glib.Uri; `type`: WebsocketConnectionType;
    origin: cstring = nil; protocol: cstring = nil; extensions: seq[WebsocketExtension]): WebsocketConnection =
  var tempResGL = seq2GList(extensions)
  let gobj = soup_websocket_connection_new(cast[ptr gio.IOStream00](stream.impl), cast[ptr glib.Uri00](uri.impl), `type`, origin, protocol, tempResGL)
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

proc newWebsocketConnection*(tdesc: typedesc; stream: gio.IOStream; uri: glib.Uri; `type`: WebsocketConnectionType;
    origin: cstring = nil; protocol: cstring = nil; extensions: seq[WebsocketExtension]): tdesc =
  assert(result is WebsocketConnection)
  var tempResGL = seq2GList(extensions)
  let gobj = soup_websocket_connection_new(cast[ptr gio.IOStream00](stream.impl), cast[ptr glib.Uri00](uri.impl), `type`, origin, protocol, tempResGL)
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

proc initWebsocketConnection*[T](result: var T; stream: gio.IOStream; uri: glib.Uri; `type`: WebsocketConnectionType;
    origin: cstring = nil; protocol: cstring = nil; extensions: seq[WebsocketExtension]) {.deprecated.} =
  assert(result is WebsocketConnection)
  var tempResGL = seq2GList(extensions)
  let gobj = soup_websocket_connection_new(cast[ptr gio.IOStream00](stream.impl), cast[ptr glib.Uri00](uri.impl), `type`, origin, protocol, tempResGL)
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

proc soup_websocket_connection_get_extensions(self: ptr WebsocketConnection00): ptr glib.List {.
    importc, libprag.}

proc getExtensions*(self: WebsocketConnection): seq[WebsocketExtension] =
  result = glistObjects2seq(WebsocketExtension, soup_websocket_connection_get_extensions(cast[ptr WebsocketConnection00](self.impl)), false)

proc extensions*(self: WebsocketConnection): seq[WebsocketExtension] =
  result = glistObjects2seq(WebsocketExtension, soup_websocket_connection_get_extensions(cast[ptr WebsocketConnection00](self.impl)), false)

type
  WebsocketState* {.size: sizeof(cint), pure.} = enum
    open = 1
    closing = 2
    closed = 3

proc soup_websocket_connection_get_state(self: ptr WebsocketConnection00): WebsocketState {.
    importc, libprag.}

proc getState*(self: WebsocketConnection): WebsocketState =
  soup_websocket_connection_get_state(cast[ptr WebsocketConnection00](self.impl))

proc state*(self: WebsocketConnection): WebsocketState =
  soup_websocket_connection_get_state(cast[ptr WebsocketConnection00](self.impl))

type
  WebsocketDataType* {.size: sizeof(cint), pure.} = enum
    text = 1
    binary = 2

proc soup_websocket_connection_send_message(self: ptr WebsocketConnection00;
    `type`: WebsocketDataType; message: ptr glib.Bytes00) {.
    importc, libprag.}

proc sendMessage*(self: WebsocketConnection; `type`: WebsocketDataType;
    message: glib.Bytes) =
  soup_websocket_connection_send_message(cast[ptr WebsocketConnection00](self.impl), `type`, cast[ptr glib.Bytes00](message.impl))

type
  Session* = ref object of gobject.Object
  Session00* = object of gobject.Object00

proc soup_session_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Session()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scRequestQueued*(self: Session;  p: proc (self: ptr Session00; msg: ptr Message00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-queued", cast[GCallback](p), xdata, nil, cf)

proc scRequestUnqueued*(self: Session;  p: proc (self: ptr Session00; msg: ptr Message00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-unqueued", cast[GCallback](p), xdata, nil, cf)

proc soup_session_new(): ptr Session00 {.
    importc, libprag.}

proc newSession*(): Session =
  let gobj = soup_session_new()
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

proc newSession*(tdesc: typedesc): tdesc =
  assert(result is Session)
  let gobj = soup_session_new()
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

proc initSession*[T](result: var T) {.deprecated.} =
  assert(result is Session)
  let gobj = soup_session_new()
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

proc soup_session_abort(self: ptr Session00) {.
    importc, libprag.}

proc abort*(self: Session) =
  soup_session_abort(cast[ptr Session00](self.impl))

proc soup_session_add_feature_by_type(self: ptr Session00; featureType: GType) {.
    importc, libprag.}

proc addFeatureByType*(self: Session; featureType: GType) =
  soup_session_add_feature_by_type(cast[ptr Session00](self.impl), featureType)

proc soup_session_get_accept_language(self: ptr Session00): cstring {.
    importc, libprag.}

proc getAcceptLanguage*(self: Session): string =
  let resul0 = soup_session_get_accept_language(cast[ptr Session00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc acceptLanguage*(self: Session): string =
  let resul0 = soup_session_get_accept_language(cast[ptr Session00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_session_get_accept_language_auto(self: ptr Session00): gboolean {.
    importc, libprag.}

proc getAcceptLanguageAuto*(self: Session): bool =
  toBool(soup_session_get_accept_language_auto(cast[ptr Session00](self.impl)))

proc acceptLanguageAuto*(self: Session): bool =
  toBool(soup_session_get_accept_language_auto(cast[ptr Session00](self.impl)))

proc soup_session_get_async_result_message(self: ptr Session00; resu: ptr gio.AsyncResult00): ptr Message00 {.
    importc, libprag.}

proc getAsyncResultMessage*(self: Session; resu: gio.AsyncResult): Message =
  let gobj = soup_session_get_async_result_message(cast[ptr Session00](self.impl), cast[ptr gio.AsyncResult00](resu.impl))
  if gobj.isNil:
    return nil
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

proc soup_session_get_idle_timeout(self: ptr Session00): uint32 {.
    importc, libprag.}

proc getIdleTimeout*(self: Session): int =
  int(soup_session_get_idle_timeout(cast[ptr Session00](self.impl)))

proc idleTimeout*(self: Session): int =
  int(soup_session_get_idle_timeout(cast[ptr Session00](self.impl)))

proc soup_session_get_local_address(self: ptr Session00): ptr gio.InetSocketAddress00 {.
    importc, libprag.}

proc getLocalAddress*(self: Session): gio.InetSocketAddress =
  let gobj = soup_session_get_local_address(cast[ptr Session00](self.impl))
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

proc localAddress*(self: Session): gio.InetSocketAddress =
  let gobj = soup_session_get_local_address(cast[ptr Session00](self.impl))
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

proc soup_session_get_max_conns(self: ptr Session00): uint32 {.
    importc, libprag.}

proc getMaxConns*(self: Session): int =
  int(soup_session_get_max_conns(cast[ptr Session00](self.impl)))

proc maxConns*(self: Session): int =
  int(soup_session_get_max_conns(cast[ptr Session00](self.impl)))

proc soup_session_get_max_conns_per_host(self: ptr Session00): uint32 {.
    importc, libprag.}

proc getMaxConnsPerHost*(self: Session): int =
  int(soup_session_get_max_conns_per_host(cast[ptr Session00](self.impl)))

proc maxConnsPerHost*(self: Session): int =
  int(soup_session_get_max_conns_per_host(cast[ptr Session00](self.impl)))

proc soup_session_get_proxy_resolver(self: ptr Session00): ptr gio.ProxyResolver00 {.
    importc, libprag.}

proc getProxyResolver*(self: Session): gio.ProxyResolver =
  let gobj = soup_session_get_proxy_resolver(cast[ptr Session00](self.impl))
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

proc proxyResolver*(self: Session): gio.ProxyResolver =
  let gobj = soup_session_get_proxy_resolver(cast[ptr Session00](self.impl))
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

proc soup_session_get_remote_connectable(self: ptr Session00): ptr gio.SocketConnectable00 {.
    importc, libprag.}

proc getRemoteConnectable*(self: Session): gio.SocketConnectable =
  let gobj = soup_session_get_remote_connectable(cast[ptr Session00](self.impl))
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

proc remoteConnectable*(self: Session): gio.SocketConnectable =
  let gobj = soup_session_get_remote_connectable(cast[ptr Session00](self.impl))
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

proc soup_session_get_timeout(self: ptr Session00): uint32 {.
    importc, libprag.}

proc getTimeout*(self: Session): int =
  int(soup_session_get_timeout(cast[ptr Session00](self.impl)))

proc timeout*(self: Session): int =
  int(soup_session_get_timeout(cast[ptr Session00](self.impl)))

proc soup_session_get_tls_database(self: ptr Session00): ptr gio.TlsDatabase00 {.
    importc, libprag.}

proc getTlsDatabase*(self: Session): gio.TlsDatabase =
  let gobj = soup_session_get_tls_database(cast[ptr Session00](self.impl))
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

proc tlsDatabase*(self: Session): gio.TlsDatabase =
  let gobj = soup_session_get_tls_database(cast[ptr Session00](self.impl))
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

proc soup_session_get_tls_interaction(self: ptr Session00): ptr gio.TlsInteraction00 {.
    importc, libprag.}

proc getTlsInteraction*(self: Session): gio.TlsInteraction =
  let gobj = soup_session_get_tls_interaction(cast[ptr Session00](self.impl))
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

proc tlsInteraction*(self: Session): gio.TlsInteraction =
  let gobj = soup_session_get_tls_interaction(cast[ptr Session00](self.impl))
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

proc soup_session_get_user_agent(self: ptr Session00): cstring {.
    importc, libprag.}

proc getUserAgent*(self: Session): string =
  let resul0 = soup_session_get_user_agent(cast[ptr Session00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc userAgent*(self: Session): string =
  let resul0 = soup_session_get_user_agent(cast[ptr Session00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_session_has_feature(self: ptr Session00; featureType: GType): gboolean {.
    importc, libprag.}

proc hasFeature*(self: Session; featureType: GType): bool =
  toBool(soup_session_has_feature(cast[ptr Session00](self.impl), featureType))

proc soup_session_preconnect_async(self: ptr Session00; msg: ptr Message00;
    ioPriority: int32; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc preconnectAsync*(self: Session; msg: Message; ioPriority: int;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  soup_session_preconnect_async(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc soup_session_preconnect_finish(self: ptr Session00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc preconnectFinish*(self: Session; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_session_preconnect_finish(cast[ptr Session00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_session_remove_feature_by_type(self: ptr Session00; featureType: GType) {.
    importc, libprag.}

proc removeFeatureByType*(self: Session; featureType: GType) =
  soup_session_remove_feature_by_type(cast[ptr Session00](self.impl), featureType)

proc soup_session_send(self: ptr Session00; msg: ptr Message00; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc send*(self: Session; msg: Message; cancellable: gio.Cancellable = nil): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = soup_session_send(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc soup_session_send_and_read(self: ptr Session00; msg: ptr Message00;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): ptr glib.Bytes00 {.
    importc, libprag.}

proc sendAndRead*(self: Session; msg: Message; cancellable: gio.Cancellable = nil): glib.Bytes =
  var gerror: ptr glib.Error
  let impl0 = soup_session_send_and_read(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGBytes)
  result.impl = impl0

proc soup_session_send_and_read_async(self: ptr Session00; msg: ptr Message00;
    ioPriority: int32; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc sendAndReadAsync*(self: Session; msg: Message; ioPriority: int;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  soup_session_send_and_read_async(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc soup_session_send_and_read_finish(self: ptr Session00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr glib.Bytes00 {.
    importc, libprag.}

proc sendAndReadFinish*(self: Session; resu: gio.AsyncResult): glib.Bytes =
  var gerror: ptr glib.Error
  let impl0 = soup_session_send_and_read_finish(cast[ptr Session00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGBytes)
  result.impl = impl0

proc soup_session_send_and_splice(self: ptr Session00; msg: ptr Message00;
    outStream: ptr gio.OutputStream00; flags: gio.OutputStreamSpliceFlags;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc sendAndSplice*(self: Session; msg: Message; outStream: gio.OutputStream;
    flags: gio.OutputStreamSpliceFlags; cancellable: gio.Cancellable = nil): int64 =
  var gerror: ptr glib.Error
  let resul0 = soup_session_send_and_splice(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), cast[ptr gio.OutputStream00](outStream.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc soup_session_send_and_splice_async(self: ptr Session00; msg: ptr Message00;
    outStream: ptr gio.OutputStream00; flags: gio.OutputStreamSpliceFlags;
    ioPriority: int32; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc sendAndSpliceAsync*(self: Session; msg: Message; outStream: gio.OutputStream;
    flags: gio.OutputStreamSpliceFlags; ioPriority: int; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  soup_session_send_and_splice_async(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), cast[ptr gio.OutputStream00](outStream.impl), flags, int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc soup_session_send_and_splice_finish(self: ptr Session00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc sendAndSpliceFinish*(self: Session; resu: gio.AsyncResult): int64 =
  var gerror: ptr glib.Error
  let resul0 = soup_session_send_and_splice_finish(cast[ptr Session00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc soup_session_send_async(self: ptr Session00; msg: ptr Message00; ioPriority: int32;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc sendAsync*(self: Session; msg: Message; ioPriority: int;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  soup_session_send_async(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc soup_session_send_finish(self: ptr Session00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc sendFinish*(self: Session; resu: gio.AsyncResult): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = soup_session_send_finish(cast[ptr Session00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc soup_session_set_accept_language(self: ptr Session00; acceptLanguage: cstring) {.
    importc, libprag.}

proc setAcceptLanguage*(self: Session; acceptLanguage: cstring) =
  soup_session_set_accept_language(cast[ptr Session00](self.impl), acceptLanguage)

proc `acceptLanguage=`*(self: Session; acceptLanguage: cstring) =
  soup_session_set_accept_language(cast[ptr Session00](self.impl), acceptLanguage)

proc soup_session_set_accept_language_auto(self: ptr Session00; acceptLanguageAuto: gboolean) {.
    importc, libprag.}

proc setAcceptLanguageAuto*(self: Session; acceptLanguageAuto: bool = true) =
  soup_session_set_accept_language_auto(cast[ptr Session00](self.impl), gboolean(acceptLanguageAuto))

proc `acceptLanguageAuto=`*(self: Session; acceptLanguageAuto: bool) =
  soup_session_set_accept_language_auto(cast[ptr Session00](self.impl), gboolean(acceptLanguageAuto))

proc soup_session_set_idle_timeout(self: ptr Session00; timeout: uint32) {.
    importc, libprag.}

proc setIdleTimeout*(self: Session; timeout: int) =
  soup_session_set_idle_timeout(cast[ptr Session00](self.impl), uint32(timeout))

proc `idleTimeout=`*(self: Session; timeout: int) =
  soup_session_set_idle_timeout(cast[ptr Session00](self.impl), uint32(timeout))

proc soup_session_set_proxy_resolver(self: ptr Session00; proxyResolver: ptr gio.ProxyResolver00) {.
    importc, libprag.}

proc setProxyResolver*(self: Session; proxyResolver: gio.ProxyResolver = nil) =
  soup_session_set_proxy_resolver(cast[ptr Session00](self.impl), if proxyResolver.isNil: nil else: cast[ptr gio.ProxyResolver00](proxyResolver.impl))

proc `proxyResolver=`*(self: Session; proxyResolver: gio.ProxyResolver = nil) =
  soup_session_set_proxy_resolver(cast[ptr Session00](self.impl), if proxyResolver.isNil: nil else: cast[ptr gio.ProxyResolver00](proxyResolver.impl))

proc soup_session_set_timeout(self: ptr Session00; timeout: uint32) {.
    importc, libprag.}

proc setTimeout*(self: Session; timeout: int) =
  soup_session_set_timeout(cast[ptr Session00](self.impl), uint32(timeout))

proc `timeout=`*(self: Session; timeout: int) =
  soup_session_set_timeout(cast[ptr Session00](self.impl), uint32(timeout))

proc soup_session_set_tls_database(self: ptr Session00; tlsDatabase: ptr gio.TlsDatabase00) {.
    importc, libprag.}

proc setTlsDatabase*(self: Session; tlsDatabase: gio.TlsDatabase = nil) =
  soup_session_set_tls_database(cast[ptr Session00](self.impl), if tlsDatabase.isNil: nil else: cast[ptr gio.TlsDatabase00](tlsDatabase.impl))

proc `tlsDatabase=`*(self: Session; tlsDatabase: gio.TlsDatabase = nil) =
  soup_session_set_tls_database(cast[ptr Session00](self.impl), if tlsDatabase.isNil: nil else: cast[ptr gio.TlsDatabase00](tlsDatabase.impl))

proc soup_session_set_tls_interaction(self: ptr Session00; tlsInteraction: ptr gio.TlsInteraction00) {.
    importc, libprag.}

proc setTlsInteraction*(self: Session; tlsInteraction: gio.TlsInteraction = nil) =
  soup_session_set_tls_interaction(cast[ptr Session00](self.impl), if tlsInteraction.isNil: nil else: cast[ptr gio.TlsInteraction00](tlsInteraction.impl))

proc `tlsInteraction=`*(self: Session; tlsInteraction: gio.TlsInteraction = nil) =
  soup_session_set_tls_interaction(cast[ptr Session00](self.impl), if tlsInteraction.isNil: nil else: cast[ptr gio.TlsInteraction00](tlsInteraction.impl))

proc soup_session_set_user_agent(self: ptr Session00; userAgent: cstring) {.
    importc, libprag.}

proc setUserAgent*(self: Session; userAgent: cstring) =
  soup_session_set_user_agent(cast[ptr Session00](self.impl), userAgent)

proc `userAgent=`*(self: Session; userAgent: cstring) =
  soup_session_set_user_agent(cast[ptr Session00](self.impl), userAgent)

proc soup_session_websocket_connect_async(self: ptr Session00; msg: ptr Message00;
    origin: cstring; protocols: ptr cstring; ioPriority: int32; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc websocketConnectAsync*(self: Session; msg: Message; origin: cstring = nil;
    protocols: openArray[string]; ioPriority: int; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  soup_session_websocket_connect_async(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), origin, seq2CstringArray(protocols, fs469n23), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc soup_session_websocket_connect_finish(self: ptr Session00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr WebsocketConnection00 {.
    importc, libprag.}

proc websocketConnectFinish*(self: Session; resu: gio.AsyncResult): WebsocketConnection =
  var gerror: ptr glib.Error
  let gobj = soup_session_websocket_connect_finish(cast[ptr Session00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

type
  SessionFeature00* = object of gobject.Object00
  SessionFeature* = ref object of gobject.Object

proc soup_session_get_feature(self: ptr Session00; featureType: GType): ptr SessionFeature00 {.
    importc, libprag.}

proc getFeature*(self: Session; featureType: GType): SessionFeature =
  let gobj = soup_session_get_feature(cast[ptr Session00](self.impl), featureType)
  if gobj.isNil:
    return nil
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

proc soup_session_get_feature_for_message(self: ptr Session00; featureType: GType;
    msg: ptr Message00): ptr SessionFeature00 {.
    importc, libprag.}

proc getFeatureForMessage*(self: Session; featureType: GType;
    msg: Message): SessionFeature =
  let gobj = soup_session_get_feature_for_message(cast[ptr Session00](self.impl), featureType, cast[ptr Message00](msg.impl))
  if gobj.isNil:
    return nil
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

type
  WebsocketExtensionManager* = ref object of gobject.Object
  WebsocketExtensionManager00* = object of gobject.Object00

proc soup_websocket_extension_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsocketExtensionManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_session_add_feature(self: ptr Session00; feature: ptr SessionFeature00) {.
    importc, libprag.}

proc addFeature*(self: Session; feature: SessionFeature | CookieJar | Logger | HSTSEnforcer | ContentDecoder | WebsocketExtensionManager | CookieJarText | ContentSniffer | HSTSEnforcerDB | AuthManager | Cache | CookieJarDB) =
  soup_session_add_feature(cast[ptr Session00](self.impl), cast[ptr SessionFeature00](feature.impl))

proc soup_session_remove_feature(self: ptr Session00; feature: ptr SessionFeature00) {.
    importc, libprag.}

proc removeFeature*(self: Session; feature: SessionFeature | CookieJar | Logger | HSTSEnforcer | ContentDecoder | WebsocketExtensionManager | CookieJarText | ContentSniffer | HSTSEnforcerDB | AuthManager | Cache | CookieJarDB) =
  soup_session_remove_feature(cast[ptr Session00](self.impl), cast[ptr SessionFeature00](feature.impl))

type
  SessionError* {.size: sizeof(cint), pure.} = enum
    parsing = 0
    encoding = 1
    tooManyRedirects = 2
    tooManyRestarts = 3
    redirectNoLocation = 4
    redirectBadUri = 5
    messageAlreadyInQueue = 6

type
  TLDError* {.size: sizeof(cint), pure.} = enum
    invalidHostname = 0
    isIpAddress = 1
    notEnoughDomains = 2
    noBaseDomain = 3
    noPslData = 4

type
  URIComponent* {.size: sizeof(cint), pure.} = enum
    none = 0
    scheme = 1
    user = 2
    password = 3
    authParams = 4
    host = 5
    port = 6
    path = 7
    query = 8
    fragment = 9

const VERSION_MIN_REQUIRED_STR* = 2'i32

type
  WebsocketCloseCode* {.size: sizeof(cint), pure.} = enum
    normal = 1000
    goingAway = 1001
    protocolError = 1002
    unsupportedData = 1003
    noStatus = 1005
    abnormal = 1006
    badData = 1007
    policyViolation = 1008
    tooBig = 1009
    noExtension = 1010
    serverError = 1011
    tlsHandshake = 1015

type
  WebsocketError* {.size: sizeof(cint), pure.} = enum
    failed = 0
    notWebsocket = 1
    badHandshake = 2
    badOrigin = 3

type
  WebsocketExtensionDeflate* = ref object of WebsocketExtension
  WebsocketExtensionDeflate00* = object of WebsocketExtension00

proc soup_websocket_extension_deflate_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsocketExtensionDeflate()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_check_version(major: uint32; minor: uint32; micro: uint32): gboolean {.
    importc, libprag.}

proc checkVersion*(major: int; minor: int; micro: int): bool =
  toBool(soup_check_version(uint32(major), uint32(minor), uint32(micro)))

proc soup_cookies_from_request(msg: ptr Message00): ptr glib.SList {.
    importc, libprag.}

proc cookiesFromRequest*(msg: Message): seq[Cookie] =
  let resul0 = soup_cookies_from_request(cast[ptr Message00](msg.impl))
  result = gslistStructs2seq[Cookie](resul0, false)
  g_slist_free(resul0)

proc soup_cookies_from_response(msg: ptr Message00): ptr glib.SList {.
    importc, libprag.}

proc cookiesFromResponse*(msg: Message): seq[Cookie] =
  let resul0 = soup_cookies_from_response(cast[ptr Message00](msg.impl))
  result = gslistStructs2seq[Cookie](resul0, false)
  g_slist_free(resul0)

proc soup_cookies_to_cookie_header(cookies: ptr glib.SList): cstring {.
    importc, libprag.}

proc cookiesToCookieHeader*(cookies: seq[Cookie]): string =
  var tempResGL = seq2GSList(cookies)
  let resul0 = soup_cookies_to_cookie_header(tempResGL)
  g_slist_free(tempResGL)
  result = $resul0
  cogfree(resul0)

proc soup_cookies_to_request(cookies: ptr glib.SList; msg: ptr Message00) {.
    importc, libprag.}

proc cookiesToRequest*(cookies: seq[Cookie]; msg: Message) =
  var tempResGL = seq2GSList(cookies)
  soup_cookies_to_request(tempResGL, cast[ptr Message00](msg.impl))
  g_slist_free(tempResGL)

proc soup_cookies_to_response(cookies: ptr glib.SList; msg: ptr Message00) {.
    importc, libprag.}

proc cookiesToResponse*(cookies: seq[Cookie]; msg: Message) =
  var tempResGL = seq2GSList(cookies)
  soup_cookies_to_response(tempResGL, cast[ptr Message00](msg.impl))
  g_slist_free(tempResGL)

proc soup_date_time_new_from_http_string(dateString: cstring): ptr glib.DateTime00 {.
    importc, libprag.}

proc dateTimeNewFromHttpString*(dateString: cstring): glib.DateTime =
  let impl0 = soup_date_time_new_from_http_string(dateString)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc soup_date_time_to_string(date: ptr glib.DateTime00; format: DateFormat): cstring {.
    importc, libprag.}

proc dateTimeToString*(date: glib.DateTime; format: DateFormat): string =
  let resul0 = soup_date_time_to_string(cast[ptr glib.DateTime00](date.impl), format)
  result = $resul0
  cogfree(resul0)

proc formDecode*(encodedForm: cstring): ptr HashTable00 {.
    importc: "soup_form_decode", libprag.}

proc soup_form_decode_multipart(multipart: ptr Multipart00; fileControlName: cstring;
    filename: var cstring; contentType: var cstring; file: var ptr glib.Bytes00): ptr HashTable00 {.
    importc, libprag.}

proc formDecodeMultipart*(multipart: Multipart; fileControlName: cstring = nil;
    filename: var string = cast[var string](nil); contentType: var string = cast[var string](nil);
    file: var glib.Bytes = cast[var glib.Bytes](nil)): ptr HashTable00 =
  if addr(file) != nil:
    fnew(file, gBoxedFreeGBytes)
  var contentType_00: cstring
  var filename_00: cstring
  let resul0 = soup_form_decode_multipart(cast[ptr Multipart00](multipart.impl), fileControlName, filename_00, contentType_00, cast[var ptr glib.Bytes00](if addr(file) == nil: nil else: addr file.impl))
  if resul0.isNil:
    return
  result = resul0
  if contentType.addr != nil:
    contentType = $(contentType_00)
  if filename.addr != nil:
    filename = $(filename_00)

proc soup_form_encode_datalist(formDataSet: glib.Data): cstring {.
    importc, libprag.}

proc formEncodeDatalist*(formDataSet: glib.Data): string =
  let resul0 = soup_form_encode_datalist(formDataSet)
  result = $resul0
  cogfree(resul0)

proc soup_form_encode_hash(formDataSet: ptr HashTable00): cstring {.
    importc, libprag.}

proc formEncodeHash*(formDataSet: ptr HashTable00): string =
  let resul0 = soup_form_encode_hash(formDataSet)
  result = $resul0
  cogfree(resul0)

proc soup_get_major_version(): uint32 {.
    importc, libprag.}

proc getMajorVersion*(): int =
  int(soup_get_major_version())

proc soup_get_micro_version(): uint32 {.
    importc, libprag.}

proc getMicroVersion*(): int =
  int(soup_get_micro_version())

proc soup_get_minor_version(): uint32 {.
    importc, libprag.}

proc getMinorVersion*(): int =
  int(soup_get_minor_version())

proc soup_header_contains(header: cstring; token: cstring): gboolean {.
    importc, libprag.}

proc headerContains*(header: cstring; token: cstring): bool =
  toBool(soup_header_contains(header, token))

proc headerFreeParamList*(paramList: ptr HashTable00) {.
    importc: "soup_header_free_param_list", libprag.}

proc headerGStringAppendParam*(string: glib.String; name: cstring;
    value: cstring) {.
    importc: "soup_header_g_string_append_param", libprag.}

proc headerGStringAppendParamQuoted*(string: glib.String; name: cstring;
    value: cstring) {.
    importc: "soup_header_g_string_append_param_quoted", libprag.}

proc headerParseList*(header: cstring): ptr glib.SList {.
    importc: "soup_header_parse_list", libprag.}

proc headerParseParamList*(header: cstring): ptr HashTable00 {.
    importc: "soup_header_parse_param_list", libprag.}

proc headerParseParamListStrict*(header: cstring): ptr HashTable00 {.
    importc: "soup_header_parse_param_list_strict", libprag.}

proc headerParseQualityList*(header: cstring; unacceptable: var ptr glib.SList): ptr glib.SList {.
    importc: "soup_header_parse_quality_list", libprag.}

proc headerParseSemiParamList*(header: cstring): ptr HashTable00 {.
    importc: "soup_header_parse_semi_param_list", libprag.}

proc headerParseSemiParamListStrict*(header: cstring): ptr HashTable00 {.
    importc: "soup_header_parse_semi_param_list_strict", libprag.}

proc soup_headers_parse(str: cstring; len: int32; dest: ptr MessageHeaders00): gboolean {.
    importc, libprag.}

proc headersParse*(str: cstring; len: int; dest: MessageHeaders): bool =
  toBool(soup_headers_parse(str, int32(len), cast[ptr MessageHeaders00](dest.impl)))

proc soup_headers_parse_request(str: cstring; len: int32; reqHeaders: ptr MessageHeaders00;
    reqMethod: var cstring; reqPath: var cstring; ver: var HTTPVersion): uint32 {.
    importc, libprag.}

proc headersParseRequest*(str: cstring; len: int; reqHeaders: MessageHeaders;
    reqMethod: var string = cast[var string](nil); reqPath: var string = cast[var string](nil);
    ver: var HTTPVersion = cast[var HTTPVersion](nil)): int =
  var reqMethod_00: cstring
  var reqPath_00: cstring
  result = int(soup_headers_parse_request(str, int32(len), cast[ptr MessageHeaders00](reqHeaders.impl), reqMethod_00, reqPath_00, ver))
  if reqMethod.addr != nil:
    reqMethod = $(reqMethod_00)
  if reqPath.addr != nil:
    reqPath = $(reqPath_00)

proc soup_headers_parse_response(str: cstring; len: int32; headers: ptr MessageHeaders00;
    ver: var HTTPVersion; statusCode: var uint32; reasonPhrase: var cstring): gboolean {.
    importc, libprag.}

proc headersParseResponse*(str: cstring; len: int; headers: MessageHeaders;
    ver: var HTTPVersion = cast[var HTTPVersion](nil); statusCode: var int = cast[var int](nil);
    reasonPhrase: var string = cast[var string](nil)): bool =
  var reasonPhrase_00: cstring
  var statusCode_00: uint32
  result = toBool(soup_headers_parse_response(str, int32(len), cast[ptr MessageHeaders00](headers.impl), ver, statusCode_00, reasonPhrase_00))
  if reasonPhrase.addr != nil:
    reasonPhrase = $(reasonPhrase_00)
  if statusCode.addr != nil:
    statusCode = int(statusCode_00)

proc soup_headers_parse_status_line(statusLine: cstring; ver: var HTTPVersion;
    statusCode: var uint32; reasonPhrase: var cstring): gboolean {.
    importc, libprag.}

proc headersParseStatusLine*(statusLine: cstring; ver: var HTTPVersion = cast[var HTTPVersion](nil);
    statusCode: var int = cast[var int](nil); reasonPhrase: var string = cast[var string](nil)): bool =
  var reasonPhrase_00: cstring
  var statusCode_00: uint32
  result = toBool(soup_headers_parse_status_line(statusLine, ver, statusCode_00, reasonPhrase_00))
  if reasonPhrase.addr != nil:
    reasonPhrase = $(reasonPhrase_00)
  if statusCode.addr != nil:
    statusCode = int(statusCode_00)

proc soup_tld_domain_is_public_suffix(domain: cstring): gboolean {.
    importc, libprag.}

proc tldDomainIsPublicSuffix*(domain: cstring): bool =
  toBool(soup_tld_domain_is_public_suffix(domain))

proc soup_tld_get_base_domain(hostname: cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc tldGetBaseDomain*(hostname: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = soup_tld_get_base_domain(hostname, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0

proc soup_uri_decode_data_uri(uri: cstring; contentType: var cstring): ptr glib.Bytes00 {.
    importc, libprag.}

proc uriDecodeDataUri*(uri: cstring; contentType: var string): glib.Bytes =
  var contentType_00: cstring
  fnew(result, gBoxedFreeGBytes)
  result.impl = soup_uri_decode_data_uri(uri, contentType_00)
  if contentType.addr != nil:
    contentType = $(contentType_00)

proc soup_uri_equal(uri1: ptr glib.Uri00; uri2: ptr glib.Uri00): gboolean {.
    importc, libprag.}

proc uriEqual*(uri1: glib.Uri; uri2: glib.Uri): bool =
  toBool(soup_uri_equal(cast[ptr glib.Uri00](uri1.impl), cast[ptr glib.Uri00](uri2.impl)))

proc soup_websocket_client_prepare_handshake(msg: ptr Message00; origin: cstring;
    protocols: ptr cstring; supportedExtensions: ptr PtrArray00) {.
    importc, libprag.}

proc websocketClientPrepareHandshake*(msg: Message; origin: cstring = nil;
    protocols: openArray[string]; supportedExtensions: ptr PtrArray00) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  soup_websocket_client_prepare_handshake(cast[ptr Message00](msg.impl), origin, seq2CstringArray(protocols, fs469n23), supportedExtensions)

proc soup_websocket_client_verify_handshake(msg: ptr Message00; supportedExtensions: ptr PtrArray00;
    acceptedExtensions: var ptr glib.List; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc websocketClientVerifyHandshake*(msg: Message; supportedExtensions: ptr PtrArray00;
    acceptedExtensions: var seq[WebsocketExtension] = cast[var seq[WebsocketExtension]](nil)): bool =
  var tempResGL = seq2GList(acceptedExtensions)
  var gerror: ptr glib.Error
  let resul0 = soup_websocket_client_verify_handshake(cast[ptr Message00](msg.impl), supportedExtensions, tempResGL, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_websocket_server_check_handshake(msg: ptr ServerMessage00; origin: cstring;
    protocols: ptr cstring; supportedExtensions: ptr PtrArray00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc websocketServerCheckHandshake*(msg: ServerMessage; origin: cstring = nil;
    protocols: openArray[string]; supportedExtensions: ptr PtrArray00): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var gerror: ptr glib.Error
  let resul0 = soup_websocket_server_check_handshake(cast[ptr ServerMessage00](msg.impl), origin, seq2CstringArray(protocols, fs469n23), supportedExtensions, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_websocket_server_process_handshake(msg: ptr ServerMessage00; expectedOrigin: cstring;
    protocols: ptr cstring; supportedExtensions: ptr PtrArray00; acceptedExtensions: var ptr glib.List): gboolean {.
    importc, libprag.}

proc websocketServerProcessHandshake*(msg: ServerMessage; expectedOrigin: cstring = nil;
    protocols: openArray[string]; supportedExtensions: ptr PtrArray00; acceptedExtensions: var seq[WebsocketExtension] = cast[var seq[WebsocketExtension]](nil)): bool =
  var tempResGL = seq2GList(acceptedExtensions)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  toBool(soup_websocket_server_process_handshake(cast[ptr ServerMessage00](msg.impl), expectedOrigin, seq2CstringArray(protocols, fs469n23), supportedExtensions, tempResGL))
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc pollableInputStream*(x: soup.MultipartInputStream): gio.PollableInputStream = cast[gio.PollableInputStream](x)

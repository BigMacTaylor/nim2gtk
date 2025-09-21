# dependencies:
# GObject-2.0
# GstSdp-1.0
# Gst-1.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# GstSdp-1.0
# Gst-1.0
# libraries:
# libgstwebrtc-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gstsdp, gst, glib, gmodule
const Lib = "libgstwebrtc-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  WebRTCBundlePolicy* {.size: sizeof(cint), pure.} = enum
    none = 0
    balanced = 1
    maxCompat = 2
    maxBundle = 3

type
  WebRTCDTLSSetup* {.size: sizeof(cint), pure.} = enum
    none = 0
    actpass = 1
    active = 2
    passive = 3

type
  WebRTCDTLSTransport* = ref object of gst.Object
  WebRTCDTLSTransport00* = object of gst.Object00

proc gst_webrtc_dtls_transport_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCDTLSTransport()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  WebRTCDTLSTransportState* {.size: sizeof(cint), pure.} = enum
    new = 0
    closed = 1
    failed = 2
    connecting = 3
    connected = 4

type
  WebRTCDataChannel* = ref object of gobject.Object
  WebRTCDataChannel00* = object of gobject.Object00

proc gst_webrtc_data_channel_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCDataChannel()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scClose*(self: WebRTCDataChannel;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "close", cast[GCallback](p), xdata, nil, cf)

proc scOnBufferedAmountLow*(self: WebRTCDataChannel;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "on-buffered-amount-low", cast[GCallback](p), xdata, nil, cf)

proc scOnClose*(self: WebRTCDataChannel;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "on-close", cast[GCallback](p), xdata, nil, cf)

proc scOnError*(self: WebRTCDataChannel;  p: proc (self: ptr WebRTCDataChannel00; error: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "on-error", cast[GCallback](p), xdata, nil, cf)

proc scOnMessageData*(self: WebRTCDataChannel;  p: proc (self: ptr WebRTCDataChannel00; data: ptr glib.Bytes00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "on-message-data", cast[GCallback](p), xdata, nil, cf)

proc scOnMessageString*(self: WebRTCDataChannel;  p: proc (self: ptr WebRTCDataChannel00; data: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "on-message-string", cast[GCallback](p), xdata, nil, cf)

proc scOnOpen*(self: WebRTCDataChannel;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "on-open", cast[GCallback](p), xdata, nil, cf)

proc scSendData*(self: WebRTCDataChannel;  p: proc (self: ptr WebRTCDataChannel00; data: ptr glib.Bytes00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "send-data", cast[GCallback](p), xdata, nil, cf)

proc scSendString*(self: WebRTCDataChannel;  p: proc (self: ptr WebRTCDataChannel00; data: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "send-string", cast[GCallback](p), xdata, nil, cf)

proc gst_webrtc_data_channel_close(self: ptr WebRTCDataChannel00) {.
    importc, libprag.}

proc close*(self: WebRTCDataChannel) =
  gst_webrtc_data_channel_close(cast[ptr WebRTCDataChannel00](self.impl))

proc gst_webrtc_data_channel_send_data(self: ptr WebRTCDataChannel00; data: ptr glib.Bytes00) {.
    importc, libprag.}

proc sendData*(self: WebRTCDataChannel; data: glib.Bytes = nil) =
  gst_webrtc_data_channel_send_data(cast[ptr WebRTCDataChannel00](self.impl), if data.isNil: nil else: cast[ptr glib.Bytes00](data.impl))

proc gst_webrtc_data_channel_send_data_full(self: ptr WebRTCDataChannel00;
    data: ptr glib.Bytes00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc sendDataFull*(self: WebRTCDataChannel; data: glib.Bytes = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_webrtc_data_channel_send_data_full(cast[ptr WebRTCDataChannel00](self.impl), if data.isNil: nil else: cast[ptr glib.Bytes00](data.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gst_webrtc_data_channel_send_string(self: ptr WebRTCDataChannel00; str: cstring) {.
    importc, libprag.}

proc sendString*(self: WebRTCDataChannel; str: cstring = nil) =
  gst_webrtc_data_channel_send_string(cast[ptr WebRTCDataChannel00](self.impl), str)

proc gst_webrtc_data_channel_send_string_full(self: ptr WebRTCDataChannel00;
    str: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc sendStringFull*(self: WebRTCDataChannel; str: cstring = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_webrtc_data_channel_send_string_full(cast[ptr WebRTCDataChannel00](self.impl), str, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  WebRTCDataChannelState* {.size: sizeof(cint), pure.} = enum
    connecting = 1
    open = 2
    closing = 3
    closed = 4

type
  WebRTCError* {.size: sizeof(cint), pure.} = enum
    dataChannelFailure = 0
    dtlsFailure = 1
    fingerprintFailure = 2
    sctpFailure = 3
    sdpSyntaxError = 4
    hardwareEncoderNotAvailable = 5
    encoderError = 6
    invalidState = 7
    internalFailure = 8
    invalidModification = 9
    typeError = 10

type
  WebRTCFECType* {.size: sizeof(cint), pure.} = enum
    none = 0
    ulpRed = 1

type
  WebRTCICE* = ref object of gst.Object
  WebRTCICE00* = object of gst.Object00

proc gst_webrtc_ice_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCICE()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAddLocalIpAddress*(self: WebRTCICE;  p: proc (self: ptr WebRTCICE00; address: cstring; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "add-local-ip-address", cast[GCallback](p), xdata, nil, cf)

proc gst_webrtc_ice_add_turn_server(self: ptr WebRTCICE00; uri: cstring): gboolean {.
    importc, libprag.}

proc addTurnServer*(self: WebRTCICE; uri: cstring): bool =
  toBool(gst_webrtc_ice_add_turn_server(cast[ptr WebRTCICE00](self.impl), uri))

proc gst_webrtc_ice_get_http_proxy(self: ptr WebRTCICE00): cstring {.
    importc, libprag.}

proc getHttpProxy*(self: WebRTCICE): string =
  let resul0 = gst_webrtc_ice_get_http_proxy(cast[ptr WebRTCICE00](self.impl))
  result = $resul0
  cogfree(resul0)

proc httpProxy*(self: WebRTCICE): string =
  let resul0 = gst_webrtc_ice_get_http_proxy(cast[ptr WebRTCICE00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_webrtc_ice_get_is_controller(self: ptr WebRTCICE00): gboolean {.
    importc, libprag.}

proc getIsController*(self: WebRTCICE): bool =
  toBool(gst_webrtc_ice_get_is_controller(cast[ptr WebRTCICE00](self.impl)))

proc isController*(self: WebRTCICE): bool =
  toBool(gst_webrtc_ice_get_is_controller(cast[ptr WebRTCICE00](self.impl)))

proc gst_webrtc_ice_get_stun_server(self: ptr WebRTCICE00): cstring {.
    importc, libprag.}

proc getStunServer*(self: WebRTCICE): string =
  let resul0 = gst_webrtc_ice_get_stun_server(cast[ptr WebRTCICE00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc stunServer*(self: WebRTCICE): string =
  let resul0 = gst_webrtc_ice_get_stun_server(cast[ptr WebRTCICE00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_webrtc_ice_get_turn_server(self: ptr WebRTCICE00): cstring {.
    importc, libprag.}

proc getTurnServer*(self: WebRTCICE): string =
  let resul0 = gst_webrtc_ice_get_turn_server(cast[ptr WebRTCICE00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc turnServer*(self: WebRTCICE): string =
  let resul0 = gst_webrtc_ice_get_turn_server(cast[ptr WebRTCICE00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_webrtc_ice_set_force_relay(self: ptr WebRTCICE00; forceRelay: gboolean) {.
    importc, libprag.}

proc setForceRelay*(self: WebRTCICE; forceRelay: bool = true) =
  gst_webrtc_ice_set_force_relay(cast[ptr WebRTCICE00](self.impl), gboolean(forceRelay))

proc `forceRelay=`*(self: WebRTCICE; forceRelay: bool) =
  gst_webrtc_ice_set_force_relay(cast[ptr WebRTCICE00](self.impl), gboolean(forceRelay))

proc gst_webrtc_ice_set_http_proxy(self: ptr WebRTCICE00; uri: cstring) {.
    importc, libprag.}

proc setHttpProxy*(self: WebRTCICE; uri: cstring) =
  gst_webrtc_ice_set_http_proxy(cast[ptr WebRTCICE00](self.impl), uri)

proc `httpProxy=`*(self: WebRTCICE; uri: cstring) =
  gst_webrtc_ice_set_http_proxy(cast[ptr WebRTCICE00](self.impl), uri)

proc gst_webrtc_ice_set_is_controller(self: ptr WebRTCICE00; controller: gboolean) {.
    importc, libprag.}

proc setIsController*(self: WebRTCICE; controller: bool = true) =
  gst_webrtc_ice_set_is_controller(cast[ptr WebRTCICE00](self.impl), gboolean(controller))

proc `isController=`*(self: WebRTCICE; controller: bool) =
  gst_webrtc_ice_set_is_controller(cast[ptr WebRTCICE00](self.impl), gboolean(controller))

proc gst_webrtc_ice_set_stun_server(self: ptr WebRTCICE00; uri: cstring) {.
    importc, libprag.}

proc setStunServer*(self: WebRTCICE; uri: cstring = nil) =
  gst_webrtc_ice_set_stun_server(cast[ptr WebRTCICE00](self.impl), uri)

proc `stunServer=`*(self: WebRTCICE; uri: cstring = nil) =
  gst_webrtc_ice_set_stun_server(cast[ptr WebRTCICE00](self.impl), uri)

proc gst_webrtc_ice_set_turn_server(self: ptr WebRTCICE00; uri: cstring) {.
    importc, libprag.}

proc setTurnServer*(self: WebRTCICE; uri: cstring = nil) =
  gst_webrtc_ice_set_turn_server(cast[ptr WebRTCICE00](self.impl), uri)

proc `turnServer=`*(self: WebRTCICE; uri: cstring = nil) =
  gst_webrtc_ice_set_turn_server(cast[ptr WebRTCICE00](self.impl), uri)

type
  WebRTCICEStream* = ref object of gst.Object
  WebRTCICEStream00* = object of gst.Object00

proc gst_webrtc_ice_stream_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCICEStream()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_webrtc_ice_stream_gather_candidates(self: ptr WebRTCICEStream00): gboolean {.
    importc, libprag.}

proc gatherCandidates*(self: WebRTCICEStream): bool =
  toBool(gst_webrtc_ice_stream_gather_candidates(cast[ptr WebRTCICEStream00](self.impl)))

proc gst_webrtc_ice_add_candidate(self: ptr WebRTCICE00; stream: ptr WebRTCICEStream00;
    candidate: cstring; promise: ptr gst.Promise00) {.
    importc, libprag.}

proc addCandidate*(self: WebRTCICE; stream: WebRTCICEStream;
    candidate: cstring; promise: gst.Promise = nil) =
  gst_webrtc_ice_add_candidate(cast[ptr WebRTCICE00](self.impl), cast[ptr WebRTCICEStream00](stream.impl), candidate, if promise.isNil: nil else: cast[ptr gst.Promise00](promise.impl))

proc gst_webrtc_ice_add_stream(self: ptr WebRTCICE00; sessionId: uint32): ptr WebRTCICEStream00 {.
    importc, libprag.}

proc addStream*(self: WebRTCICE; sessionId: int): WebRTCICEStream =
  let gobj = gst_webrtc_ice_add_stream(cast[ptr WebRTCICE00](self.impl), uint32(sessionId))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstwebrtc.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_webrtc_ice_gather_candidates(self: ptr WebRTCICE00; stream: ptr WebRTCICEStream00): gboolean {.
    importc, libprag.}

proc gatherCandidates*(self: WebRTCICE; stream: WebRTCICEStream): bool =
  toBool(gst_webrtc_ice_gather_candidates(cast[ptr WebRTCICE00](self.impl), cast[ptr WebRTCICEStream00](stream.impl)))

proc gst_webrtc_ice_set_local_credentials(self: ptr WebRTCICE00; stream: ptr WebRTCICEStream00;
    ufrag: cstring; pwd: cstring): gboolean {.
    importc, libprag.}

proc setLocalCredentials*(self: WebRTCICE; stream: WebRTCICEStream;
    ufrag: cstring; pwd: cstring): bool =
  toBool(gst_webrtc_ice_set_local_credentials(cast[ptr WebRTCICE00](self.impl), cast[ptr WebRTCICEStream00](stream.impl), ufrag, pwd))

proc gst_webrtc_ice_set_remote_credentials(self: ptr WebRTCICE00; stream: ptr WebRTCICEStream00;
    ufrag: cstring; pwd: cstring): gboolean {.
    importc, libprag.}

proc setRemoteCredentials*(self: WebRTCICE; stream: WebRTCICEStream;
    ufrag: cstring; pwd: cstring): bool =
  toBool(gst_webrtc_ice_set_remote_credentials(cast[ptr WebRTCICE00](self.impl), cast[ptr WebRTCICEStream00](stream.impl), ufrag, pwd))

proc gst_webrtc_ice_set_tos(self: ptr WebRTCICE00; stream: ptr WebRTCICEStream00;
    tos: uint32) {.
    importc, libprag.}

proc setTos*(self: WebRTCICE; stream: WebRTCICEStream; tos: int) =
  gst_webrtc_ice_set_tos(cast[ptr WebRTCICE00](self.impl), cast[ptr WebRTCICEStream00](stream.impl), uint32(tos))

type
  WebRTCICECandidateStats00* {.pure.} = object
  WebRTCICECandidateStats* = ref object
    impl*: ptr WebRTCICECandidateStats00
    ignoreFinalizer*: bool

proc gst_webrtc_ice_candidate_stats_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstWebRTCICECandidateStats*(self: WebRTCICECandidateStats) =
  if not self.ignoreFinalizer:
    boxedFree(gst_webrtc_ice_candidate_stats_get_type(), cast[ptr WebRTCICECandidateStats00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCICECandidateStats()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_webrtc_ice_candidate_stats_get_type(), cast[ptr WebRTCICECandidateStats00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var WebRTCICECandidateStats) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstWebRTCICECandidateStats)

proc gst_webrtc_ice_candidate_stats_free(self: ptr WebRTCICECandidateStats00) {.
    importc, libprag.}

proc free*(self: WebRTCICECandidateStats) =
  gst_webrtc_ice_candidate_stats_free(cast[ptr WebRTCICECandidateStats00](self.impl))

proc finalizerfree*(self: WebRTCICECandidateStats) =
  if not self.ignoreFinalizer:
    gst_webrtc_ice_candidate_stats_free(cast[ptr WebRTCICECandidateStats00](self.impl))

proc gst_webrtc_ice_candidate_stats_copy(self: ptr WebRTCICECandidateStats00): ptr WebRTCICECandidateStats00 {.
    importc, libprag.}

proc copy*(self: WebRTCICECandidateStats): WebRTCICECandidateStats =
  fnew(result, gBoxedFreeGstWebRTCICECandidateStats)
  result.impl = gst_webrtc_ice_candidate_stats_copy(cast[ptr WebRTCICECandidateStats00](self.impl))

proc gst_webrtc_ice_get_local_candidates(self: ptr WebRTCICE00; stream: ptr WebRTCICEStream00): ptr ptr WebRTCICECandidateStats00 {.
    importc, libprag.}

proc getLocalCandidates*(self: WebRTCICE; stream: WebRTCICEStream): ptr ptr WebRTCICECandidateStats00 =
  gst_webrtc_ice_get_local_candidates(cast[ptr WebRTCICE00](self.impl), cast[ptr WebRTCICEStream00](stream.impl))

proc gst_webrtc_ice_get_remote_candidates(self: ptr WebRTCICE00; stream: ptr WebRTCICEStream00): ptr ptr WebRTCICECandidateStats00 {.
    importc, libprag.}

proc getRemoteCandidates*(self: WebRTCICE; stream: WebRTCICEStream): ptr ptr WebRTCICECandidateStats00 =
  gst_webrtc_ice_get_remote_candidates(cast[ptr WebRTCICE00](self.impl), cast[ptr WebRTCICEStream00](stream.impl))

proc gst_webrtc_ice_get_selected_pair(self: ptr WebRTCICE00; stream: ptr WebRTCICEStream00;
    localStats: var ptr WebRTCICECandidateStats00; remoteStats: var ptr WebRTCICECandidateStats00): gboolean {.
    importc, libprag.}

proc getSelectedPair*(self: WebRTCICE; stream: WebRTCICEStream;
    localStats: var WebRTCICECandidateStats; remoteStats: var WebRTCICECandidateStats): bool =
  fnew(localStats, gBoxedFreeGstWebRTCICECandidateStats)
  fnew(remoteStats, gBoxedFreeGstWebRTCICECandidateStats)
  toBool(gst_webrtc_ice_get_selected_pair(cast[ptr WebRTCICE00](self.impl), cast[ptr WebRTCICEStream00](stream.impl), cast[var ptr WebRTCICECandidateStats00](addr localStats.impl), cast[var ptr WebRTCICECandidateStats00](addr remoteStats.impl)))

type
  WebRTCICEComponent* {.size: sizeof(cint), pure.} = enum
    rtp = 0
    rtcp = 1

type
  WebRTCICETransport* = ref object of gst.Object
  WebRTCICETransport00* = object of gst.Object00

proc gst_webrtc_ice_transport_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCICETransport()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scOnNewCandidate*(self: WebRTCICETransport;  p: proc (self: ptr WebRTCICETransport00; obj: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "on-new-candidate", cast[GCallback](p), xdata, nil, cf)

proc scOnSelectedCandidatePairChange*(self: WebRTCICETransport;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "on-selected-candidate-pair-change", cast[GCallback](p), xdata, nil, cf)

proc gst_webrtc_ice_transport_new_candidate(self: ptr WebRTCICETransport00;
    streamId: uint32; component: WebRTCICEComponent; attr: cstring) {.
    importc, libprag.}

proc newCandidate*(self: WebRTCICETransport; streamId: int;
    component: WebRTCICEComponent; attr: cstring) =
  gst_webrtc_ice_transport_new_candidate(cast[ptr WebRTCICETransport00](self.impl), uint32(streamId), component, attr)

proc gst_webrtc_ice_transport_selected_pair_change(self: ptr WebRTCICETransport00) {.
    importc, libprag.}

proc selectedPairChange*(self: WebRTCICETransport) =
  gst_webrtc_ice_transport_selected_pair_change(cast[ptr WebRTCICETransport00](self.impl))

proc gst_webrtc_ice_find_transport(self: ptr WebRTCICE00; stream: ptr WebRTCICEStream00;
    component: WebRTCICEComponent): ptr WebRTCICETransport00 {.
    importc, libprag.}

proc findTransport*(self: WebRTCICE; stream: WebRTCICEStream;
    component: WebRTCICEComponent): WebRTCICETransport =
  let gobj = gst_webrtc_ice_find_transport(cast[ptr WebRTCICE00](self.impl), cast[ptr WebRTCICEStream00](stream.impl), component)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstwebrtc.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_webrtc_ice_stream_find_transport(self: ptr WebRTCICEStream00; component: WebRTCICEComponent): ptr WebRTCICETransport00 {.
    importc, libprag.}

proc findTransport*(self: WebRTCICEStream; component: WebRTCICEComponent): WebRTCICETransport =
  let gobj = gst_webrtc_ice_stream_find_transport(cast[ptr WebRTCICEStream00](self.impl), component)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstwebrtc.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  WebRTCICEConnectionState* {.size: sizeof(cint), pure.} = enum
    new = 0
    checking = 1
    connected = 2
    completed = 3
    failed = 4
    disconnected = 5
    closed = 6

proc gst_webrtc_ice_transport_connection_state_change(self: ptr WebRTCICETransport00;
    newState: WebRTCICEConnectionState) {.
    importc, libprag.}

proc connectionStateChange*(self: WebRTCICETransport;
    newState: WebRTCICEConnectionState) =
  gst_webrtc_ice_transport_connection_state_change(cast[ptr WebRTCICETransport00](self.impl), newState)

type
  WebRTCICEGatheringState* {.size: sizeof(cint), pure.} = enum
    new = 0
    gathering = 1
    complete = 2

proc gst_webrtc_ice_transport_gathering_state_change(self: ptr WebRTCICETransport00;
    newState: WebRTCICEGatheringState) {.
    importc, libprag.}

proc gatheringStateChange*(self: WebRTCICETransport;
    newState: WebRTCICEGatheringState) =
  gst_webrtc_ice_transport_gathering_state_change(cast[ptr WebRTCICETransport00](self.impl), newState)

type
  WebRTCICEOnCandidateFunc* = proc (ice: ptr WebRTCICE00; streamId: uint32; candidate: cstring; userData: pointer) {.cdecl.}

proc gst_webrtc_ice_set_on_ice_candidate(self: ptr WebRTCICE00; `func`: WebRTCICEOnCandidateFunc;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setOnIceCandidate*(self: WebRTCICE; `func`: WebRTCICEOnCandidateFunc;
    userData: pointer; notify: DestroyNotify) =
  gst_webrtc_ice_set_on_ice_candidate(cast[ptr WebRTCICE00](self.impl), `func`, userData, notify)

type
  WebRTCICERole* {.size: sizeof(cint), pure.} = enum
    controlled = 0
    controlling = 1

type
  WebRTCICETransportPolicy* {.size: sizeof(cint), pure.} = enum
    all = 0
    relay = 1

type
  WebRTCKind* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    audio = 1
    video = 2

type
  WebRTCPeerConnectionState* {.size: sizeof(cint), pure.} = enum
    new = 0
    connecting = 1
    connected = 2
    disconnected = 3
    failed = 4
    closed = 5

type
  WebRTCPriorityType* {.size: sizeof(cint), pure.} = enum
    veryLow = 1
    low = 2
    medium = 3
    high = 4

type
  WebRTCRTPReceiver* = ref object of gst.Object
  WebRTCRTPReceiver00* = object of gst.Object00

proc gst_webrtc_rtp_receiver_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCRTPReceiver()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  WebRTCRTPSender* = ref object of gst.Object
  WebRTCRTPSender00* = object of gst.Object00

proc gst_webrtc_rtp_sender_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCRTPSender()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_webrtc_rtp_sender_set_priority(self: ptr WebRTCRTPSender00; priority: WebRTCPriorityType) {.
    importc, libprag.}

proc setPriority*(self: WebRTCRTPSender; priority: WebRTCPriorityType) =
  gst_webrtc_rtp_sender_set_priority(cast[ptr WebRTCRTPSender00](self.impl), priority)

proc `priority=`*(self: WebRTCRTPSender; priority: WebRTCPriorityType) =
  gst_webrtc_rtp_sender_set_priority(cast[ptr WebRTCRTPSender00](self.impl), priority)

type
  WebRTCRTPTransceiver* = ref object of gst.Object
  WebRTCRTPTransceiver00* = object of gst.Object00

proc gst_webrtc_rtp_transceiver_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCRTPTransceiver()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  WebRTCRTPTransceiverDirection* {.size: sizeof(cint), pure.} = enum
    none = 0
    inactive = 1
    sendonly = 2
    recvonly = 3
    sendrecv = 4

type
  WebRTCSCTPTransport* = ref object of gst.Object
  WebRTCSCTPTransport00* = object of gst.Object00

proc gst_webrtc_sctp_transport_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCSCTPTransport()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  WebRTCSCTPTransportState* {.size: sizeof(cint), pure.} = enum
    new = 0
    connecting = 1
    connected = 2
    closed = 3

type
  WebRTCSDPType* {.size: sizeof(cint), pure.} = enum
    offer = 1
    pranswer = 2
    answer = 3
    rollback = 4

proc gst_webrtc_sdp_type_to_string(`type`: WebRTCSDPType): cstring {.
    importc, libprag.}

proc toString*(`type`: WebRTCSDPType): string =
  result = $gst_webrtc_sdp_type_to_string(`type`)

type
  WebRTCSessionDescription00* {.pure.} = object
  WebRTCSessionDescription* = ref object
    impl*: ptr WebRTCSessionDescription00
    ignoreFinalizer*: bool

proc gst_webrtc_session_description_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstWebRTCSessionDescription*(self: WebRTCSessionDescription) =
  if not self.ignoreFinalizer:
    boxedFree(gst_webrtc_session_description_get_type(), cast[ptr WebRTCSessionDescription00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebRTCSessionDescription()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_webrtc_session_description_get_type(), cast[ptr WebRTCSessionDescription00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var WebRTCSessionDescription) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstWebRTCSessionDescription)

proc gst_webrtc_session_description_free(self: ptr WebRTCSessionDescription00) {.
    importc, libprag.}

proc free*(self: WebRTCSessionDescription) =
  gst_webrtc_session_description_free(cast[ptr WebRTCSessionDescription00](g_boxed_copy(gst_webrtc_session_description_get_type(), self.impl)))

proc finalizerfree*(self: WebRTCSessionDescription) =
  if not self.ignoreFinalizer:
    gst_webrtc_session_description_free(cast[ptr WebRTCSessionDescription00](self.impl))

proc gst_webrtc_session_description_copy(self: ptr WebRTCSessionDescription00): ptr WebRTCSessionDescription00 {.
    importc, libprag.}

proc copy*(self: WebRTCSessionDescription): WebRTCSessionDescription =
  fnew(result, gBoxedFreeGstWebRTCSessionDescription)
  result.impl = gst_webrtc_session_description_copy(cast[ptr WebRTCSessionDescription00](self.impl))

proc gst_webrtc_session_description_new(`type`: WebRTCSDPType; sdp: ptr gstsdp.SDPMessage00): ptr WebRTCSessionDescription00 {.
    importc, libprag.}

proc newWebRTCSessionDescription*(`type`: WebRTCSDPType; sdp: gstsdp.SDPMessage): WebRTCSessionDescription =
  fnew(result, gBoxedFreeGstWebRTCSessionDescription)
  result.impl = gst_webrtc_session_description_new(`type`, cast[ptr gstsdp.SDPMessage00](g_boxed_copy(gst_sdp_message_get_type(), sdp.impl)))

proc newWebRTCSessionDescription*(tdesc: typedesc; `type`: WebRTCSDPType; sdp: gstsdp.SDPMessage): tdesc =
  assert(result is WebRTCSessionDescription)
  fnew(result, gBoxedFreeGstWebRTCSessionDescription)
  result.impl = gst_webrtc_session_description_new(`type`, cast[ptr gstsdp.SDPMessage00](g_boxed_copy(gst_sdp_message_get_type(), sdp.impl)))

proc initWebRTCSessionDescription*[T](result: var T; `type`: WebRTCSDPType; sdp: gstsdp.SDPMessage) {.deprecated.} =
  assert(result is WebRTCSessionDescription)
  fnew(result, gBoxedFreeGstWebRTCSessionDescription)
  result.impl = gst_webrtc_session_description_new(`type`, cast[ptr gstsdp.SDPMessage00](g_boxed_copy(gst_sdp_message_get_type(), sdp.impl)))

type
  WebRTCSignalingState* {.size: sizeof(cint), pure.} = enum
    stable = 0
    closed = 1
    haveLocalOffer = 2
    haveRemoteOffer = 3
    haveLocalPranswer = 4
    haveRemotePranswer = 5

type
  WebRTCStatsType* {.size: sizeof(cint), pure.} = enum
    codec = 1
    inboundRtp = 2
    outboundRtp = 3
    remoteInboundRtp = 4
    remoteOutboundRtp = 5
    csrc = 6
    peerConnection = 7
    dataChannel = 8
    stream = 9
    transport = 10
    candidatePair = 11
    localCandidate = 12
    remoteCandidate = 13
    certificate = 14
# === remaining symbols:

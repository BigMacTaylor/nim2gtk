# dependencies:
# GObject-2.0
# Gio-2.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# Gio-2.0
# GObject-2.0
# libraries:
# libnice.so.10
{.warning[UnusedImport]: off.}
import gobject, gio, glib, gmodule
const Lib = "libnice.so.10"
{.pragma: libprag, cdecl, dynlib: Lib.}
import macros, nativesockets

from strutils import `%`


proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const AGENT_MAX_REMOTE_CANDIDATES* = 25'i32

type
  Address* {.pure, byRef, union.} = object
    `addr`*: SockAddr
    ip4*: Sockaddr_in
    ip6*: Sockaddr_in6

proc nice_address_get_type*(): GType {.importc, libprag.}

proc nice_address_free(self: Address) {.
    importc, libprag.}

proc free*(self: Address) =
  nice_address_free(self)

proc nice_address_copy_to_sockaddr(self: Address; sin: pointer) {.
    importc, libprag.}

proc copyToSockaddr*(self: Address; sin: pointer) =
  nice_address_copy_to_sockaddr(self, sin)

proc nice_address_dup(self: Address): ptr Address {.
    importc, libprag.}

proc dup*(self: Address): ptr Address =
  nice_address_dup(self)

proc nice_address_dup_string(self: Address): cstring {.
    importc, libprag.}

proc dupString*(self: Address): string =
  let resul0 = nice_address_dup_string(self)
  result = $resul0
  cogfree(resul0)

proc nice_address_equal(self: Address; b: Address): gboolean {.
    importc, libprag.}

proc equal*(self: Address; b: Address): bool =
  toBool(nice_address_equal(self, b))

proc nice_address_equal_no_port(self: Address; b: Address): gboolean {.
    importc, libprag.}

proc equalNoPort*(self: Address; b: Address): bool =
  toBool(nice_address_equal_no_port(self, b))

proc new*(): ptr Address {.
    importc: "nice_address_new", libprag.}

proc nice_address_get_port(self: Address): uint32 {.
    importc, libprag.}

proc getPort*(self: Address): int =
  int(nice_address_get_port(self))

proc port*(self: Address): int =
  int(nice_address_get_port(self))

proc nice_address_init(self: Address) {.
    importc, libprag.}

proc init*(self: Address) =
  nice_address_init(self)

proc nice_address_ip_version(self: Address): int32 {.
    importc, libprag.}

proc ipVersion*(self: Address): int =
  int(nice_address_ip_version(self))

proc nice_address_is_linklocal(self: Address): gboolean {.
    importc, libprag.}

proc isLinklocal*(self: Address): bool =
  toBool(nice_address_is_linklocal(self))

proc nice_address_is_private(self: Address): gboolean {.
    importc, libprag.}

proc isPrivate*(self: Address): bool =
  toBool(nice_address_is_private(self))

proc nice_address_is_valid(self: Address): gboolean {.
    importc, libprag.}

proc isValid*(self: Address): bool =
  toBool(nice_address_is_valid(self))

proc nice_address_set_from_sockaddr(self: Address; sin: pointer) {.
    importc, libprag.}

proc setFromSockaddr*(self: Address; sin: pointer) =
  nice_address_set_from_sockaddr(self, sin)

proc `fromSockaddr=`*(self: Address; sin: pointer) =
  nice_address_set_from_sockaddr(self, sin)

proc nice_address_set_from_string(self: Address; str: cstring): gboolean {.
    importc, libprag.}

proc setFromString*(self: Address; str: cstring): bool =
  toBool(nice_address_set_from_string(self, str))

proc nice_address_set_ipv4(self: Address; addrIpv4: uint32) {.
    importc, libprag.}

proc setIpv4*(self: Address; addrIpv4: int) =
  nice_address_set_ipv4(self, uint32(addrIpv4))

proc `ipv4=`*(self: Address; addrIpv4: int) =
  nice_address_set_ipv4(self, uint32(addrIpv4))

proc nice_address_set_ipv6(self: Address; addrIpv6: ptr uint8) {.
    importc, libprag.}

proc setIpv6*(self: Address; addrIpv6: ptr uint8) =
  nice_address_set_ipv6(self, addrIpv6)

proc `ipv6=`*(self: Address; addrIpv6: ptr uint8) =
  nice_address_set_ipv6(self, addrIpv6)

proc nice_address_set_port(self: Address; port: uint32) {.
    importc, libprag.}

proc setPort*(self: Address; port: int) =
  nice_address_set_port(self, uint32(port))

proc `port=`*(self: Address; port: int) =
  nice_address_set_port(self, uint32(port))

type
  CandidateType* {.size: sizeof(cint), pure.} = enum
    host = 0
    serverReflexive = 1
    peerReflexive = 2
    relayed = 3

type
  CandidateTransport* {.size: sizeof(cint), pure.} = enum
    udp = 0
    tcpActive = 1
    tcpPassive = 2
    tcpSo = 3

type
  Candidate00* {.pure.} = object
    `type`*: CandidateType
    transport*: CandidateTransport
    `addr`*: Address
    baseAddr*: Address
    priority*: uint32
    streamId*: uint32
    componentId*: uint32
    foundation*: array[33, int8]
    username*: cstring
    password*: cstring
  Candidate* = ref object
    impl*: ptr Candidate00
    ignoreFinalizer*: bool

proc nice_candidate_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeNiceCandidate*(self: Candidate) =
  if not self.ignoreFinalizer:
    boxedFree(nice_candidate_get_type(), cast[ptr Candidate00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Candidate()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(nice_candidate_get_type(), cast[ptr Candidate00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Candidate) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeNiceCandidate)

proc nice_candidate_free(self: ptr Candidate00) {.
    importc, libprag.}

proc free*(self: Candidate) =
  nice_candidate_free(cast[ptr Candidate00](self.impl))

proc finalizerfree*(self: Candidate) =
  if not self.ignoreFinalizer:
    nice_candidate_free(cast[ptr Candidate00](self.impl))

proc nice_candidate_copy(self: ptr Candidate00): ptr Candidate00 {.
    importc, libprag.}

proc copy*(self: Candidate): Candidate =
  fnew(result, gBoxedFreeNiceCandidate)
  result.impl = nice_candidate_copy(cast[ptr Candidate00](self.impl))

proc nice_candidate_equal_target(self: ptr Candidate00; candidate2: ptr Candidate00): gboolean {.
    importc, libprag.}

proc equalTarget*(self: Candidate; candidate2: Candidate): bool =
  toBool(nice_candidate_equal_target(cast[ptr Candidate00](self.impl), cast[ptr Candidate00](candidate2.impl)))

proc nice_candidate_new(`type`: CandidateType): ptr Candidate00 {.
    importc, libprag.}

proc newCandidate*(`type`: CandidateType): Candidate =
  fnew(result, gBoxedFreeNiceCandidate)
  result.impl = nice_candidate_new(`type`)

proc newCandidate*(tdesc: typedesc; `type`: CandidateType): tdesc =
  assert(result is Candidate)
  fnew(result, gBoxedFreeNiceCandidate)
  result.impl = nice_candidate_new(`type`)

proc initCandidate*[T](result: var T; `type`: CandidateType) {.deprecated.} =
  assert(result is Candidate)
  fnew(result, gBoxedFreeNiceCandidate)
  result.impl = nice_candidate_new(`type`)

proc nice_candidate_relay_address(self: ptr Candidate00; `addr`: Address) {.
    importc, libprag.}

proc relayAddress*(self: Candidate; `addr`: Address) =
  nice_candidate_relay_address(cast[ptr Candidate00](self.impl), `addr`)

proc nice_candidate_stun_server_address(self: ptr Candidate00; `addr`: Address): gboolean {.
    importc, libprag.}

proc stunServerAddress*(self: Candidate; `addr`: Address): bool =
  toBool(nice_candidate_stun_server_address(cast[ptr Candidate00](self.impl), `addr`))

proc nice_candidate_transport_to_string(transport: CandidateTransport): cstring {.
    importc, libprag.}

proc transportToString*(transport: CandidateTransport): string =
  result = $nice_candidate_transport_to_string(transport)

proc nice_candidate_type_to_string(`type`: CandidateType): cstring {.
    importc, libprag.}

proc typeToString*(`type`: CandidateType): string =
  result = $nice_candidate_type_to_string(`type`)

type
  Agent* = ref object of gobject.Object
  Agent00* = object of gobject.Object00

proc nice_agent_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Agent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCandidateGatheringDone*(self: Agent;  p: proc (self: ptr Agent00; streamId: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "candidate-gathering-done", cast[GCallback](p), xdata, nil, cf)

proc scComponentStateChanged*(self: Agent;  p: proc (self: ptr Agent00; streamId: uint32; componentId: uint32; state: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "component-state-changed", cast[GCallback](p), xdata, nil, cf)

proc scInitialBindingRequestReceived*(self: Agent;  p: proc (self: ptr Agent00; streamId: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "initial-binding-request-received", cast[GCallback](p), xdata, nil, cf)

proc scNewCandidate*(self: Agent;  p: proc (self: ptr Agent00; streamId: uint32; componentId: uint32; foundation: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "new-candidate", cast[GCallback](p), xdata, nil, cf)

proc scNewCandidateFull*(self: Agent;  p: proc (self: ptr Agent00; candidate: ptr Candidate00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "new-candidate-full", cast[GCallback](p), xdata, nil, cf)

proc scNewRemoteCandidate*(self: Agent;  p: proc (self: ptr Agent00; streamId: uint32; componentId: uint32; foundation: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "new-remote-candidate", cast[GCallback](p), xdata, nil, cf)

proc scNewRemoteCandidateFull*(self: Agent;  p: proc (self: ptr Agent00; candidate: ptr Candidate00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "new-remote-candidate-full", cast[GCallback](p), xdata, nil, cf)

proc scNewSelectedPair*(self: Agent;  p: proc (self: ptr Agent00; streamId: uint32; componentId: uint32; lfoundation: cstring; rfoundation: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "new-selected-pair", cast[GCallback](p), xdata, nil, cf)

proc scNewSelectedPairFull*(self: Agent;  p: proc (self: ptr Agent00; streamId: uint32; componentId: uint32; lcandidate: ptr Candidate00;
    rcandidate: ptr Candidate00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "new-selected-pair-full", cast[GCallback](p), xdata, nil, cf)

proc scReliableTransportWritable*(self: Agent;  p: proc (self: ptr Agent00; streamId: uint32; componentId: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "reliable-transport-writable", cast[GCallback](p), xdata, nil, cf)

proc scStreamsRemoved*(self: Agent;  p: proc (self: ptr Agent00; streamIds: ptr uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "streams-removed", cast[GCallback](p), xdata, nil, cf)

proc nice_agent_add_local_address(self: ptr Agent00; `addr`: Address): gboolean {.
    importc, libprag.}

proc addLocalAddress*(self: Agent; `addr`: Address): bool =
  toBool(nice_agent_add_local_address(cast[ptr Agent00](self.impl), `addr`))

proc nice_agent_add_stream(self: ptr Agent00; nComponents: uint32): uint32 {.
    importc, libprag.}

proc addStream*(self: Agent; nComponents: int): int =
  int(nice_agent_add_stream(cast[ptr Agent00](self.impl), uint32(nComponents)))

proc nice_agent_close_async(self: ptr Agent00; callback: AsyncReadyCallback;
    callbackData: pointer) {.
    importc, libprag.}

proc closeAsync*(self: Agent; callback: AsyncReadyCallback; callbackData: pointer) =
  nice_agent_close_async(cast[ptr Agent00](self.impl), callback, callbackData)

proc nice_agent_consent_lost(self: ptr Agent00; streamId: uint32; componentId: uint32): gboolean {.
    importc, libprag.}

proc consentLost*(self: Agent; streamId: int; componentId: int): bool =
  toBool(nice_agent_consent_lost(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId)))

proc nice_agent_forget_relays(self: ptr Agent00; streamId: uint32; componentId: uint32): gboolean {.
    importc, libprag.}

proc forgetRelays*(self: Agent; streamId: int; componentId: int): bool =
  toBool(nice_agent_forget_relays(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId)))

proc nice_agent_gather_candidates(self: ptr Agent00; streamId: uint32): gboolean {.
    importc, libprag.}

proc gatherCandidates*(self: Agent; streamId: int): bool =
  toBool(nice_agent_gather_candidates(cast[ptr Agent00](self.impl), uint32(streamId)))

proc nice_agent_generate_local_candidate_sdp(self: ptr Agent00; candidate: ptr Candidate00): cstring {.
    importc, libprag.}

proc generateLocalCandidateSdp*(self: Agent; candidate: Candidate): string =
  let resul0 = nice_agent_generate_local_candidate_sdp(cast[ptr Agent00](self.impl), cast[ptr Candidate00](candidate.impl))
  result = $resul0
  cogfree(resul0)

proc nice_agent_generate_local_sdp(self: ptr Agent00): cstring {.
    importc, libprag.}

proc generateLocalSdp*(self: Agent): string =
  let resul0 = nice_agent_generate_local_sdp(cast[ptr Agent00](self.impl))
  result = $resul0
  cogfree(resul0)

proc nice_agent_generate_local_stream_sdp(self: ptr Agent00; streamId: uint32;
    includeNonIce: gboolean): cstring {.
    importc, libprag.}

proc generateLocalStreamSdp*(self: Agent; streamId: int; includeNonIce: bool): string =
  let resul0 = nice_agent_generate_local_stream_sdp(cast[ptr Agent00](self.impl), uint32(streamId), gboolean(includeNonIce))
  result = $resul0
  cogfree(resul0)

proc nice_agent_get_default_local_candidate(self: ptr Agent00; streamId: uint32;
    componentId: uint32): ptr Candidate00 {.
    importc, libprag.}

proc getDefaultLocalCandidate*(self: Agent; streamId: int; componentId: int): Candidate =
  fnew(result, gBoxedFreeNiceCandidate)
  result.impl = nice_agent_get_default_local_candidate(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId))

proc nice_agent_get_io_stream(self: ptr Agent00; streamId: uint32; componentId: uint32): ptr gio.IOStream00 {.
    importc, libprag.}

proc getIoStream*(self: Agent; streamId: int; componentId: int): gio.IOStream =
  let gobj = nice_agent_get_io_stream(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId))
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

proc nice_agent_get_local_candidates(self: ptr Agent00; streamId: uint32;
    componentId: uint32): ptr glib.SList {.
    importc, libprag.}

proc getLocalCandidates*(self: Agent; streamId: int; componentId: int): seq[Candidate] =
  let resul0 = nice_agent_get_local_candidates(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId))
  result = gslistStructs2seq[Candidate](resul0, false)
  g_slist_free(resul0)

proc nice_agent_get_local_credentials(self: ptr Agent00; streamId: uint32;
    ufrag: var cstring; pwd: var cstring): gboolean {.
    importc, libprag.}

proc getLocalCredentials*(self: Agent; streamId: int; ufrag: var string;
    pwd: var string): bool =
  var pwd_00: cstring
  var ufrag_00: cstring
  result = toBool(nice_agent_get_local_credentials(cast[ptr Agent00](self.impl), uint32(streamId), ufrag_00, pwd_00))
  if pwd.addr != nil:
    pwd = $(pwd_00)
  if ufrag.addr != nil:
    ufrag = $(ufrag_00)

proc nice_agent_get_remote_candidates(self: ptr Agent00; streamId: uint32;
    componentId: uint32): ptr glib.SList {.
    importc, libprag.}

proc getRemoteCandidates*(self: Agent; streamId: int; componentId: int): seq[Candidate] =
  let resul0 = nice_agent_get_remote_candidates(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId))
  result = gslistStructs2seq[Candidate](resul0, false)
  g_slist_free(resul0)

proc nice_agent_get_selected_socket(self: ptr Agent00; streamId: uint32;
    componentId: uint32): ptr gio.Socket00 {.
    importc, libprag.}

proc getSelectedSocket*(self: Agent; streamId: int; componentId: int): gio.Socket =
  let gobj = nice_agent_get_selected_socket(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId))
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

proc nice_agent_get_sockets(self: ptr Agent00; streamId: uint32; componentId: uint32): ptr PtrArray00 {.
    importc, libprag.}

proc getSockets*(self: Agent; streamId: int; componentId: int): ptr PtrArray00 =
  nice_agent_get_sockets(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId))

proc nice_agent_get_stream_name(self: ptr Agent00; streamId: uint32): cstring {.
    importc, libprag.}

proc getStreamName*(self: Agent; streamId: int): string =
  result = $nice_agent_get_stream_name(cast[ptr Agent00](self.impl), uint32(streamId))

proc nice_agent_parse_remote_candidate_sdp(self: ptr Agent00; streamId: uint32;
    sdp: cstring): ptr Candidate00 {.
    importc, libprag.}

proc parseRemoteCandidateSdp*(self: Agent; streamId: int; sdp: cstring): Candidate =
  fnew(result, gBoxedFreeNiceCandidate)
  result.impl = nice_agent_parse_remote_candidate_sdp(cast[ptr Agent00](self.impl), uint32(streamId), sdp)

proc nice_agent_parse_remote_sdp(self: ptr Agent00; sdp: cstring): int32 {.
    importc, libprag.}

proc parseRemoteSdp*(self: Agent; sdp: cstring): int =
  int(nice_agent_parse_remote_sdp(cast[ptr Agent00](self.impl), sdp))

proc nice_agent_parse_remote_stream_sdp(self: ptr Agent00; streamId: uint32;
    sdp: cstring; ufrag: cstring; pwd: cstring): ptr glib.SList {.
    importc, libprag.}

proc parseRemoteStreamSdp*(self: Agent; streamId: int; sdp: cstring;
    ufrag: cstring; pwd: cstring): seq[Candidate] =
  let resul0 = nice_agent_parse_remote_stream_sdp(cast[ptr Agent00](self.impl), uint32(streamId), sdp, ufrag, pwd)
  result = gslistStructs2seq[Candidate](resul0, false)
  g_slist_free(resul0)

proc nice_agent_peer_candidate_gathering_done(self: ptr Agent00; streamId: uint32): gboolean {.
    importc, libprag.}

proc peerCandidateGatheringDone*(self: Agent; streamId: int): bool =
  toBool(nice_agent_peer_candidate_gathering_done(cast[ptr Agent00](self.impl), uint32(streamId)))

proc nice_agent_recv(self: ptr Agent00; streamId: uint32; componentId: uint32;
    buf: ptr uint8; bufLen: uint64; cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc recv*(self: Agent; streamId: int; componentId: int; buf: var (seq[uint8] | string);
    cancellable: gio.Cancellable = nil): int64 =
  let bufLen = uint64(buf.len)
  var gerror: ptr glib.Error
  let resul0 = nice_agent_recv(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), cast[ptr uint8](unsafeaddr(buf[0])), bufLen, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc nice_agent_recv_nonblocking(self: ptr Agent00; streamId: uint32; componentId: uint32;
    buf: ptr uint8; bufLen: uint64; cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc recvNonblocking*(self: Agent; streamId: int; componentId: int;
    buf: var (seq[uint8] | string); cancellable: gio.Cancellable = nil): int64 =
  let bufLen = uint64(buf.len)
  var gerror: ptr glib.Error
  let resul0 = nice_agent_recv_nonblocking(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), cast[ptr uint8](unsafeaddr(buf[0])), bufLen, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc nice_agent_remove_stream(self: ptr Agent00; streamId: uint32) {.
    importc, libprag.}

proc removeStream*(self: Agent; streamId: int) =
  nice_agent_remove_stream(cast[ptr Agent00](self.impl), uint32(streamId))

proc nice_agent_restart(self: ptr Agent00): gboolean {.
    importc, libprag.}

proc restart*(self: Agent): bool =
  toBool(nice_agent_restart(cast[ptr Agent00](self.impl)))

proc nice_agent_restart_stream(self: ptr Agent00; streamId: uint32): gboolean {.
    importc, libprag.}

proc restartStream*(self: Agent; streamId: int): bool =
  toBool(nice_agent_restart_stream(cast[ptr Agent00](self.impl), uint32(streamId)))

proc nice_agent_send(self: ptr Agent00; streamId: uint32; componentId: uint32;
    len: uint32; buf: cstring): int32 {.
    importc, libprag.}

proc send*(self: Agent; streamId: int; componentId: int; len: int;
    buf: cstring): int =
  int(nice_agent_send(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), uint32(len), buf))

proc nice_agent_set_local_credentials(self: ptr Agent00; streamId: uint32;
    ufrag: cstring; pwd: cstring): gboolean {.
    importc, libprag.}

proc setLocalCredentials*(self: Agent; streamId: int; ufrag: cstring;
    pwd: cstring): bool =
  toBool(nice_agent_set_local_credentials(cast[ptr Agent00](self.impl), uint32(streamId), ufrag, pwd))

proc nice_agent_set_port_range(self: ptr Agent00; streamId: uint32; componentId: uint32;
    minPort: uint32; maxPort: uint32) {.
    importc, libprag.}

proc setPortRange*(self: Agent; streamId: int; componentId: int;
    minPort: int; maxPort: int) =
  nice_agent_set_port_range(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), uint32(minPort), uint32(maxPort))

proc nice_agent_set_remote_candidates(self: ptr Agent00; streamId: uint32;
    componentId: uint32; candidates: ptr glib.SList): int32 {.
    importc, libprag.}

proc setRemoteCandidates*(self: Agent; streamId: int; componentId: int;
    candidates: seq[Candidate]): int =
  var tempResGL = seq2GSList(candidates)
  result = int(nice_agent_set_remote_candidates(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), tempResGL))
  g_slist_free(tempResGL)

proc nice_agent_set_remote_credentials(self: ptr Agent00; streamId: uint32;
    ufrag: cstring; pwd: cstring): gboolean {.
    importc, libprag.}

proc setRemoteCredentials*(self: Agent; streamId: int; ufrag: cstring;
    pwd: cstring): bool =
  toBool(nice_agent_set_remote_credentials(cast[ptr Agent00](self.impl), uint32(streamId), ufrag, pwd))

proc nice_agent_set_selected_pair(self: ptr Agent00; streamId: uint32; componentId: uint32;
    lfoundation: cstring; rfoundation: cstring): gboolean {.
    importc, libprag.}

proc setSelectedPair*(self: Agent; streamId: int; componentId: int;
    lfoundation: cstring; rfoundation: cstring): bool =
  toBool(nice_agent_set_selected_pair(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), lfoundation, rfoundation))

proc nice_agent_set_selected_remote_candidate(self: ptr Agent00; streamId: uint32;
    componentId: uint32; candidate: ptr Candidate00): gboolean {.
    importc, libprag.}

proc setSelectedRemoteCandidate*(self: Agent; streamId: int;
    componentId: int; candidate: Candidate): bool =
  toBool(nice_agent_set_selected_remote_candidate(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), cast[ptr Candidate00](candidate.impl)))

proc nice_agent_set_software(self: ptr Agent00; software: cstring) {.
    importc, libprag.}

proc setSoftware*(self: Agent; software: cstring) =
  nice_agent_set_software(cast[ptr Agent00](self.impl), software)

proc `software=`*(self: Agent; software: cstring) =
  nice_agent_set_software(cast[ptr Agent00](self.impl), software)

proc nice_agent_set_stream_name(self: ptr Agent00; streamId: uint32; name: cstring): gboolean {.
    importc, libprag.}

proc setStreamName*(self: Agent; streamId: int; name: cstring): bool =
  toBool(nice_agent_set_stream_name(cast[ptr Agent00](self.impl), uint32(streamId), name))

proc nice_agent_set_stream_tos(self: ptr Agent00; streamId: uint32; tos: int32) {.
    importc, libprag.}

proc setStreamTos*(self: Agent; streamId: int; tos: int) =
  nice_agent_set_stream_tos(cast[ptr Agent00](self.impl), uint32(streamId), int32(tos))

type
  Compatibility* {.size: sizeof(cint), pure.} = enum
    draft19 = 0
    google = 1
    msn = 2
    wlm2009 = 3
    oc2007 = 4
    last = 5

const
  CompatibilityRfc5245* = Compatibility.draft19
  CompatibilityOc2007r2* = Compatibility.last

proc nice_agent_new(ctx: ptr glib.MainContext00; compat: Compatibility): ptr Agent00 {.
    importc, libprag.}

proc newAgent*(ctx: glib.MainContext; compat: Compatibility): Agent =
  let gobj = nice_agent_new(cast[ptr glib.MainContext00](ctx.impl), compat)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAgent*(tdesc: typedesc; ctx: glib.MainContext; compat: Compatibility): tdesc =
  assert(result is Agent)
  let gobj = nice_agent_new(cast[ptr glib.MainContext00](ctx.impl), compat)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAgent*[T](result: var T; ctx: glib.MainContext; compat: Compatibility) {.deprecated.} =
  assert(result is Agent)
  let gobj = nice_agent_new(cast[ptr glib.MainContext00](ctx.impl), compat)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc nice_agent_new_reliable(ctx: ptr glib.MainContext00; compat: Compatibility): ptr Agent00 {.
    importc, libprag.}

proc newAgentReliable*(ctx: glib.MainContext; compat: Compatibility): Agent =
  let gobj = nice_agent_new_reliable(cast[ptr glib.MainContext00](ctx.impl), compat)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAgentReliable*(tdesc: typedesc; ctx: glib.MainContext; compat: Compatibility): tdesc =
  assert(result is Agent)
  let gobj = nice_agent_new_reliable(cast[ptr glib.MainContext00](ctx.impl), compat)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAgentReliable*[T](result: var T; ctx: glib.MainContext; compat: Compatibility) {.deprecated.} =
  assert(result is Agent)
  let gobj = nice_agent_new_reliable(cast[ptr glib.MainContext00](ctx.impl), compat)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  AgentOptionFlag* {.size: sizeof(cint), pure.} = enum
    regularNomination = 0
    reliable = 1
    liteMode = 2
    iceTrickle = 3
    supportRenomination = 4
    consentFreshness = 5
    bytestreamTcp = 6

  AgentOption* = set[AgentOptionFlag]

const
  AgentOptionNone* = AgentOption({})
proc none*(t: typedesc[AgentOption]): AgentOption = AgentOption({})

proc nice_agent_new_full(ctx: ptr glib.MainContext00; compat: Compatibility;
    flags: AgentOption): ptr Agent00 {.
    importc, libprag.}

proc newAgentFull*(ctx: glib.MainContext; compat: Compatibility; flags: AgentOption): Agent =
  let gobj = nice_agent_new_full(cast[ptr glib.MainContext00](ctx.impl), compat, flags)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAgentFull*(tdesc: typedesc; ctx: glib.MainContext; compat: Compatibility; flags: AgentOption): tdesc =
  assert(result is Agent)
  let gobj = nice_agent_new_full(cast[ptr glib.MainContext00](ctx.impl), compat, flags)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAgentFull*[T](result: var T; ctx: glib.MainContext; compat: Compatibility; flags: AgentOption) {.deprecated.} =
  assert(result is Agent)
  let gobj = nice_agent_new_full(cast[ptr glib.MainContext00](ctx.impl), compat, flags)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ComponentState* {.size: sizeof(cint), pure.} = enum
    disconnected = 0
    gathering = 1
    connecting = 2
    connected = 3
    ready = 4
    failed = 5
    last = 6

proc nice_agent_get_component_state(self: ptr Agent00; streamId: uint32;
    componentId: uint32): ComponentState {.
    importc, libprag.}

proc getComponentState*(self: Agent; streamId: int; componentId: int): ComponentState =
  nice_agent_get_component_state(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId))

type
  InputMessage00* {.pure.} = object
  InputMessage* = ref object
    impl*: ptr InputMessage00
    ignoreFinalizer*: bool

proc nice_agent_recv_messages(self: ptr Agent00; streamId: uint32; componentId: uint32;
    messages: var ptr InputMessage00; nMessages: var uint32; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): int32 {.
    importc, libprag.}

proc recvMessages*(self: Agent; streamId: int; componentId: int;
    messages: var ptr InputMessage00; nMessages: var int; cancellable: gio.Cancellable = nil): int =
  var gerror: ptr glib.Error
  var nMessages_00: uint32
  let resul0 = nice_agent_recv_messages(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), messages, nMessages_00, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = int(resul0)
  if nMessages.addr != nil:
    nMessages = int(nMessages_00)

proc nice_agent_recv_messages_nonblocking(self: ptr Agent00; streamId: uint32;
    componentId: uint32; messages: var ptr InputMessage00; nMessages: var uint32;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): int32 {.
    importc, libprag.}

proc recvMessagesNonblocking*(self: Agent; streamId: int; componentId: int;
    messages: var ptr InputMessage00; nMessages: var int; cancellable: gio.Cancellable = nil): int =
  var gerror: ptr glib.Error
  var nMessages_00: uint32
  let resul0 = nice_agent_recv_messages_nonblocking(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), messages, nMessages_00, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = int(resul0)
  if nMessages.addr != nil:
    nMessages = int(nMessages_00)

type
  OutputMessage00* {.pure.} = object
  OutputMessage* = ref object
    impl*: ptr OutputMessage00
    ignoreFinalizer*: bool

proc nice_agent_send_messages_nonblocking(self: ptr Agent00; streamId: uint32;
    componentId: uint32; messages: ptr OutputMessage00; nMessages: uint32;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): int32 {.
    importc, libprag.}

proc sendMessagesNonblocking*(self: Agent; streamId: int; componentId: int;
    messages: ptr OutputMessage00; nMessages: int; cancellable: gio.Cancellable = nil): int =
  var gerror: ptr glib.Error
  let resul0 = nice_agent_send_messages_nonblocking(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), messages, uint32(nMessages), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = int(resul0)

type
  RelayType* {.size: sizeof(cint), pure.} = enum
    udp = 0
    tcp = 1
    tls = 2

proc nice_agent_set_relay_info(self: ptr Agent00; streamId: uint32; componentId: uint32;
    serverIp: cstring; serverPort: uint32; username: cstring; password: cstring;
    `type`: RelayType): gboolean {.
    importc, libprag.}

proc setRelayInfo*(self: Agent; streamId: int; componentId: int;
    serverIp: cstring; serverPort: int; username: cstring; password: cstring;
    `type`: RelayType): bool =
  toBool(nice_agent_set_relay_info(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), serverIp, uint32(serverPort), username, password, `type`))

type
  AgentRecvFunc* = proc (agent: ptr Agent00; streamId: uint32; componentId: uint32; len: uint32;
    buf: cstring; userData: pointer) {.cdecl.}

const CANDIDATE_MAX_FOUNDATION* = 33'i32

const CANDIDATE_MAX_LOCAL_ADDRESSES* = 64'i32

const CANDIDATE_MAX_TURN_SERVERS* = 8'i32

type
  ComponentType* {.size: sizeof(cint), pure.} = enum
    rtp = 1
    rtcp = 2

type
  NominationMode* {.size: sizeof(cint), pure.} = enum
    regular = 0
    aggressive = 1

type
  ProxyType* {.size: sizeof(cint), pure.} = enum
    none = 0
    socks5 = 1
    http = 2

const
  ProxyTypeLast* = ProxyType.http

type
  PseudoTcpCallbacks00* {.pure.} = object
  PseudoTcpCallbacks* = ref object
    impl*: ptr PseudoTcpCallbacks00
    ignoreFinalizer*: bool

type
  PseudoTcpDebugLevel* {.size: sizeof(cint), pure.} = enum
    none = 0
    normal = 1
    verbose = 2

type
  PseudoTcpShutdown* {.size: sizeof(cint), pure.} = enum
    rd = 0
    wr = 1
    rdwr = 2

type
  PseudoTcpSocket* = ref object of gobject.Object
  PseudoTcpSocket00* = object of gobject.Object00

proc pseudo_tcp_socket_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PseudoTcpSocket()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pseudo_tcp_socket_new(conversation: uint32; callbacks: ptr PseudoTcpCallbacks00): ptr PseudoTcpSocket00 {.
    importc, libprag.}

proc newPseudoTcpSocket*(conversation: int; callbacks: PseudoTcpCallbacks): PseudoTcpSocket =
  let gobj = pseudo_tcp_socket_new(uint32(conversation), cast[ptr PseudoTcpCallbacks00](callbacks.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPseudoTcpSocket*(tdesc: typedesc; conversation: int; callbacks: PseudoTcpCallbacks): tdesc =
  assert(result is PseudoTcpSocket)
  let gobj = pseudo_tcp_socket_new(uint32(conversation), cast[ptr PseudoTcpCallbacks00](callbacks.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPseudoTcpSocket*[T](result: var T; conversation: int; callbacks: PseudoTcpCallbacks) {.deprecated.} =
  assert(result is PseudoTcpSocket)
  let gobj = pseudo_tcp_socket_new(uint32(conversation), cast[ptr PseudoTcpCallbacks00](callbacks.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, nice.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pseudo_tcp_socket_can_send(self: ptr PseudoTcpSocket00): gboolean {.
    importc, libprag.}

proc canSend*(self: PseudoTcpSocket): bool =
  toBool(pseudo_tcp_socket_can_send(cast[ptr PseudoTcpSocket00](self.impl)))

proc pseudo_tcp_socket_close(self: ptr PseudoTcpSocket00; force: gboolean) {.
    importc, libprag.}

proc close*(self: PseudoTcpSocket; force: bool) =
  pseudo_tcp_socket_close(cast[ptr PseudoTcpSocket00](self.impl), gboolean(force))

proc pseudo_tcp_socket_connect(self: ptr PseudoTcpSocket00): gboolean {.
    importc, libprag.}

proc connect*(self: PseudoTcpSocket): bool =
  toBool(pseudo_tcp_socket_connect(cast[ptr PseudoTcpSocket00](self.impl)))

proc pseudo_tcp_socket_get_available_bytes(self: ptr PseudoTcpSocket00): int32 {.
    importc, libprag.}

proc getAvailableBytes*(self: PseudoTcpSocket): int =
  int(pseudo_tcp_socket_get_available_bytes(cast[ptr PseudoTcpSocket00](self.impl)))

proc availableBytes*(self: PseudoTcpSocket): int =
  int(pseudo_tcp_socket_get_available_bytes(cast[ptr PseudoTcpSocket00](self.impl)))

proc pseudo_tcp_socket_get_available_send_space(self: ptr PseudoTcpSocket00): uint64 {.
    importc, libprag.}

proc getAvailableSendSpace*(self: PseudoTcpSocket): uint64 =
  pseudo_tcp_socket_get_available_send_space(cast[ptr PseudoTcpSocket00](self.impl))

proc availableSendSpace*(self: PseudoTcpSocket): uint64 =
  pseudo_tcp_socket_get_available_send_space(cast[ptr PseudoTcpSocket00](self.impl))

proc pseudo_tcp_socket_get_error(self: ptr PseudoTcpSocket00): int32 {.
    importc, libprag.}

proc getError*(self: PseudoTcpSocket): int =
  int(pseudo_tcp_socket_get_error(cast[ptr PseudoTcpSocket00](self.impl)))

proc error*(self: PseudoTcpSocket): int =
  int(pseudo_tcp_socket_get_error(cast[ptr PseudoTcpSocket00](self.impl)))

proc pseudo_tcp_socket_get_next_clock(self: ptr PseudoTcpSocket00; timeout: ptr uint64): gboolean {.
    importc, libprag.}

proc getNextClock*(self: PseudoTcpSocket; timeout: ptr uint64): bool =
  toBool(pseudo_tcp_socket_get_next_clock(cast[ptr PseudoTcpSocket00](self.impl), timeout))

proc pseudo_tcp_socket_is_closed(self: ptr PseudoTcpSocket00): gboolean {.
    importc, libprag.}

proc isClosed*(self: PseudoTcpSocket): bool =
  toBool(pseudo_tcp_socket_is_closed(cast[ptr PseudoTcpSocket00](self.impl)))

proc pseudo_tcp_socket_is_closed_remotely(self: ptr PseudoTcpSocket00): gboolean {.
    importc, libprag.}

proc isClosedRemotely*(self: PseudoTcpSocket): bool =
  toBool(pseudo_tcp_socket_is_closed_remotely(cast[ptr PseudoTcpSocket00](self.impl)))

proc pseudo_tcp_socket_notify_clock(self: ptr PseudoTcpSocket00) {.
    importc, libprag.}

proc notifyClock*(self: PseudoTcpSocket) =
  pseudo_tcp_socket_notify_clock(cast[ptr PseudoTcpSocket00](self.impl))

proc pseudo_tcp_socket_notify_message(self: ptr PseudoTcpSocket00; message: ptr InputMessage00): gboolean {.
    importc, libprag.}

proc notifyMessage*(self: PseudoTcpSocket; message: InputMessage): bool =
  toBool(pseudo_tcp_socket_notify_message(cast[ptr PseudoTcpSocket00](self.impl), cast[ptr InputMessage00](message.impl)))

proc pseudo_tcp_socket_notify_mtu(self: ptr PseudoTcpSocket00; mtu: uint16) {.
    importc, libprag.}

proc notifyMtu*(self: PseudoTcpSocket; mtu: uint16) =
  pseudo_tcp_socket_notify_mtu(cast[ptr PseudoTcpSocket00](self.impl), mtu)

proc pseudo_tcp_socket_notify_packet(self: ptr PseudoTcpSocket00; buffer: cstring;
    len: uint32): gboolean {.
    importc, libprag.}

proc notifyPacket*(self: PseudoTcpSocket; buffer: cstring;
    len: int): bool =
  toBool(pseudo_tcp_socket_notify_packet(cast[ptr PseudoTcpSocket00](self.impl), buffer, uint32(len)))

proc pseudo_tcp_socket_recv(self: ptr PseudoTcpSocket00; buffer: cstring;
    len: uint64): int32 {.
    importc, libprag.}

proc recv*(self: PseudoTcpSocket; buffer: cstring; len: uint64): int =
  int(pseudo_tcp_socket_recv(cast[ptr PseudoTcpSocket00](self.impl), buffer, len))

proc pseudo_tcp_socket_send(self: ptr PseudoTcpSocket00; buffer: cstring;
    len: uint32): int32 {.
    importc, libprag.}

proc send*(self: PseudoTcpSocket; buffer: cstring; len: int): int =
  int(pseudo_tcp_socket_send(cast[ptr PseudoTcpSocket00](self.impl), buffer, uint32(len)))

proc pseudo_tcp_socket_set_time(self: ptr PseudoTcpSocket00; currentTime: uint32) {.
    importc, libprag.}

proc setTime*(self: PseudoTcpSocket; currentTime: int) =
  pseudo_tcp_socket_set_time(cast[ptr PseudoTcpSocket00](self.impl), uint32(currentTime))

proc `time=`*(self: PseudoTcpSocket; currentTime: int) =
  pseudo_tcp_socket_set_time(cast[ptr PseudoTcpSocket00](self.impl), uint32(currentTime))

proc pseudo_tcp_socket_shutdown(self: ptr PseudoTcpSocket00; how: PseudoTcpShutdown) {.
    importc, libprag.}

proc shutdown*(self: PseudoTcpSocket; how: PseudoTcpShutdown) =
  pseudo_tcp_socket_shutdown(cast[ptr PseudoTcpSocket00](self.impl), how)

type
  PseudoTcpState* {.size: sizeof(cint), pure.} = enum
    listen = 0
    synSent = 1
    synReceived = 2
    established = 3
    closed = 4
    finWait_1 = 5
    finWait_2 = 6
    closing = 7
    timeWait = 8
    closeWait = 9
    lastAck = 10

type
  PseudoTcpWriteResult* {.size: sizeof(cint), pure.} = enum
    success = 0
    tooLarge = 1
    fail = 2

proc nice_component_state_to_string(state: ComponentState): cstring {.
    importc, libprag.}

proc componentStateToString*(state: ComponentState): string =
  result = $nice_component_state_to_string(state)

proc nice_debug_disable(withStun: gboolean) {.
    importc, libprag.}

proc debugDisable*(withStun: bool) =
  nice_debug_disable(gboolean(withStun))

proc nice_debug_enable(withStun: gboolean) {.
    importc, libprag.}

proc debugEnable*(withStun: bool) =
  nice_debug_enable(gboolean(withStun))

proc nice_interfaces_get_if_index_by_addr(`addr`: Address): uint32 {.
    importc, libprag.}

proc interfacesGetIfIndexByAddr*(`addr`: Address): int =
  int(nice_interfaces_get_if_index_by_addr(`addr`))

proc nice_interfaces_get_ip_for_interface(interfaceName: cstring): cstring {.
    importc, libprag.}

proc interfacesGetIpForInterface*(interfaceName: cstring): string =
  let resul0 = nice_interfaces_get_ip_for_interface(interfaceName)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc nice_interfaces_get_local_interfaces(): ptr glib.List {.
    importc, libprag.}

proc interfacesGetLocalInterfaces*(): seq[cstring] =
  let resul0 = nice_interfaces_get_local_interfaces()
  g_list_free(resul0)

proc nice_interfaces_get_local_ips(includeLoopback: gboolean): ptr glib.List {.
    importc, libprag.}

proc interfacesGetLocalIps*(includeLoopback: bool): seq[cstring] =
  let resul0 = nice_interfaces_get_local_ips(gboolean(includeLoopback))
  g_list_free(resul0)

proc pseudoTcpSetDebugLevel*(level: PseudoTcpDebugLevel) {.
    importc: "pseudo_tcp_set_debug_level", libprag.}
# === remaining symbols:

proc nice_agent_get_selected_pair(self: ptr Agent00; streamId: uint32; componentId: uint32;
    local: var ptr Candidate00; remote: var ptr Candidate00): gboolean {.importc, libprag.}

proc getSelectedPair*(self: Agent; streamId: int; componentId: int; local: var Candidate; remote: var Candidate): bool =
  fnew(local, gBoxedFreeNiceCandidate)
  local.ignoreFinalizer = true
  fnew(remote, gBoxedFreeNiceCandidate)
  remote.ignoreFinalizer = true
  toBool(nice_agent_get_selected_pair(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), local.impl, remote.impl))

include gimplnice


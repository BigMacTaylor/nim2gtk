# dependencies:
# GObject-2.0
# Gst-1.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# Gst-1.0
# libraries:
# libgstmpegts-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gst, glib, gmodule
const Lib = "libgstmpegts-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  ATSCDescriptorType* {.size: sizeof(cint), pure.} = enum
    stuffing = 128
    ac3 = 129
    captionService = 134
    contentAdvisory = 135
    extendedChannelName = 160
    serviceLocation = 161
    timeShiftedService = 162
    componentName = 163
    dataService = 164
    pidCount = 165
    downloadDescriptor = 166
    multiprotocolEncapsulation = 167
    dccDepartingRequest = 168
    dccArrivingRequest = 169
    redistributionControl = 170
    genre = 171
    privateInformation = 173
    enhancedSignaling = 178
    moduleLink = 180
    crc32 = 181
    groupLink = 184
    eac3 = 204

type
  ATSCStreamType* {.size: sizeof(cint), pure.} = enum
    dciiVideo = 128
    audioAc3 = 129
    subtitling = 130
    isochData = 131
    sit = 134
    audioEac3 = 135
    audioDtsHd = 136

type
  AtscEIT00* {.pure.} = object
  AtscEIT* = ref object
    impl*: ptr AtscEIT00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_eit_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscEIT*(self: AtscEIT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_eit_get_type(), cast[ptr AtscEIT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscEIT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_eit_get_type(), cast[ptr AtscEIT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscEIT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscEIT)

type
  AtscEITEvent00* {.pure.} = object
  AtscEITEvent* = ref object
    impl*: ptr AtscEITEvent00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_eit_event_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscEITEvent*(self: AtscEITEvent) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_eit_event_get_type(), cast[ptr AtscEITEvent00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscEITEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_eit_event_get_type(), cast[ptr AtscEITEvent00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscEITEvent) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscEITEvent)

type
  AtscETT00* {.pure.} = object
  AtscETT* = ref object
    impl*: ptr AtscETT00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_ett_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscETT*(self: AtscETT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_ett_get_type(), cast[ptr AtscETT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscETT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_ett_get_type(), cast[ptr AtscETT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscETT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscETT)

type
  AtscMGT00* {.pure.} = object
  AtscMGT* = ref object
    impl*: ptr AtscMGT00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_mgt_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscMGT*(self: AtscMGT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_mgt_get_type(), cast[ptr AtscMGT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscMGT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_mgt_get_type(), cast[ptr AtscMGT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscMGT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscMGT)

proc gst_mpegts_atsc_mgt_new(): ptr AtscMGT00 {.
    importc, libprag.}

proc newAtscMGT*(): AtscMGT =
  fnew(result, gBoxedFreeGstMpegtsAtscMGT)
  result.impl = gst_mpegts_atsc_mgt_new()

proc newAtscMGT*(tdesc: typedesc): tdesc =
  assert(result is AtscMGT)
  fnew(result, gBoxedFreeGstMpegtsAtscMGT)
  result.impl = gst_mpegts_atsc_mgt_new()

proc initAtscMGT*[T](result: var T) {.deprecated.} =
  assert(result is AtscMGT)
  fnew(result, gBoxedFreeGstMpegtsAtscMGT)
  result.impl = gst_mpegts_atsc_mgt_new()

type
  AtscMGTTable00* {.pure.} = object
  AtscMGTTable* = ref object
    impl*: ptr AtscMGTTable00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_mgt_table_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscMGTTable*(self: AtscMGTTable) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_mgt_table_get_type(), cast[ptr AtscMGTTable00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscMGTTable()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_mgt_table_get_type(), cast[ptr AtscMGTTable00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscMGTTable) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscMGTTable)

type
  AtscMGTTableType* {.size: sizeof(cint), pure.} = enum
    eit0 = 256
    eit127 = 383
    ett0 = 512
    ett127 = 639

type
  AtscMultString00* {.pure.} = object
  AtscMultString* = ref object
    impl*: ptr AtscMultString00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_mult_string_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscMultString*(self: AtscMultString) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_mult_string_get_type(), cast[ptr AtscMultString00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscMultString()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_mult_string_get_type(), cast[ptr AtscMultString00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscMultString) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscMultString)

type
  AtscRRT00* {.pure.} = object
  AtscRRT* = ref object
    impl*: ptr AtscRRT00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_rrt_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscRRT*(self: AtscRRT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_rrt_get_type(), cast[ptr AtscRRT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscRRT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_rrt_get_type(), cast[ptr AtscRRT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscRRT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscRRT)

proc gst_mpegts_atsc_rrt_new(): ptr AtscRRT00 {.
    importc, libprag.}

proc newAtscRRT*(): AtscRRT =
  fnew(result, gBoxedFreeGstMpegtsAtscRRT)
  result.impl = gst_mpegts_atsc_rrt_new()

proc newAtscRRT*(tdesc: typedesc): tdesc =
  assert(result is AtscRRT)
  fnew(result, gBoxedFreeGstMpegtsAtscRRT)
  result.impl = gst_mpegts_atsc_rrt_new()

proc initAtscRRT*[T](result: var T) {.deprecated.} =
  assert(result is AtscRRT)
  fnew(result, gBoxedFreeGstMpegtsAtscRRT)
  result.impl = gst_mpegts_atsc_rrt_new()

type
  AtscRRTDimension00* {.pure.} = object
  AtscRRTDimension* = ref object
    impl*: ptr AtscRRTDimension00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_rrt_dimension_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscRRTDimension*(self: AtscRRTDimension) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_rrt_dimension_get_type(), cast[ptr AtscRRTDimension00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscRRTDimension()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_rrt_dimension_get_type(), cast[ptr AtscRRTDimension00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscRRTDimension) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscRRTDimension)

proc gst_mpegts_atsc_rrt_dimension_new(): ptr AtscRRTDimension00 {.
    importc, libprag.}

proc newAtscRRTDimension*(): AtscRRTDimension =
  fnew(result, gBoxedFreeGstMpegtsAtscRRTDimension)
  result.impl = gst_mpegts_atsc_rrt_dimension_new()

proc newAtscRRTDimension*(tdesc: typedesc): tdesc =
  assert(result is AtscRRTDimension)
  fnew(result, gBoxedFreeGstMpegtsAtscRRTDimension)
  result.impl = gst_mpegts_atsc_rrt_dimension_new()

proc initAtscRRTDimension*[T](result: var T) {.deprecated.} =
  assert(result is AtscRRTDimension)
  fnew(result, gBoxedFreeGstMpegtsAtscRRTDimension)
  result.impl = gst_mpegts_atsc_rrt_dimension_new()

type
  AtscRRTDimensionValue00* {.pure.} = object
  AtscRRTDimensionValue* = ref object
    impl*: ptr AtscRRTDimensionValue00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_rrt_dimension_value_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscRRTDimensionValue*(self: AtscRRTDimensionValue) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_rrt_dimension_value_get_type(), cast[ptr AtscRRTDimensionValue00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscRRTDimensionValue()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_rrt_dimension_value_get_type(), cast[ptr AtscRRTDimensionValue00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscRRTDimensionValue) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscRRTDimensionValue)

proc gst_mpegts_atsc_rrt_dimension_value_new(): ptr AtscRRTDimensionValue00 {.
    importc, libprag.}

proc newAtscRRTDimensionValue*(): AtscRRTDimensionValue =
  fnew(result, gBoxedFreeGstMpegtsAtscRRTDimensionValue)
  result.impl = gst_mpegts_atsc_rrt_dimension_value_new()

proc newAtscRRTDimensionValue*(tdesc: typedesc): tdesc =
  assert(result is AtscRRTDimensionValue)
  fnew(result, gBoxedFreeGstMpegtsAtscRRTDimensionValue)
  result.impl = gst_mpegts_atsc_rrt_dimension_value_new()

proc initAtscRRTDimensionValue*[T](result: var T) {.deprecated.} =
  assert(result is AtscRRTDimensionValue)
  fnew(result, gBoxedFreeGstMpegtsAtscRRTDimensionValue)
  result.impl = gst_mpegts_atsc_rrt_dimension_value_new()

type
  AtscSTT00* {.pure.} = object
  AtscSTT* = ref object
    impl*: ptr AtscSTT00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_stt_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscSTT*(self: AtscSTT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_stt_get_type(), cast[ptr AtscSTT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscSTT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_stt_get_type(), cast[ptr AtscSTT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscSTT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscSTT)

proc gst_mpegts_atsc_stt_new(): ptr AtscSTT00 {.
    importc, libprag.}

proc newAtscSTT*(): AtscSTT =
  fnew(result, gBoxedFreeGstMpegtsAtscSTT)
  result.impl = gst_mpegts_atsc_stt_new()

proc newAtscSTT*(tdesc: typedesc): tdesc =
  assert(result is AtscSTT)
  fnew(result, gBoxedFreeGstMpegtsAtscSTT)
  result.impl = gst_mpegts_atsc_stt_new()

proc initAtscSTT*[T](result: var T) {.deprecated.} =
  assert(result is AtscSTT)
  fnew(result, gBoxedFreeGstMpegtsAtscSTT)
  result.impl = gst_mpegts_atsc_stt_new()

proc gst_mpegts_atsc_stt_get_datetime_utc(self: ptr AtscSTT00): ptr gst.DateTime00 {.
    importc, libprag.}

proc getDatetimeUtc*(self: AtscSTT): gst.DateTime =
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_mpegts_atsc_stt_get_datetime_utc(cast[ptr AtscSTT00](self.impl))

proc datetimeUtc*(self: AtscSTT): gst.DateTime =
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_mpegts_atsc_stt_get_datetime_utc(cast[ptr AtscSTT00](self.impl))

type
  AtscStringSegment00* {.pure.} = object
  AtscStringSegment* = ref object
    impl*: ptr AtscStringSegment00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_string_segment_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscStringSegment*(self: AtscStringSegment) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_string_segment_get_type(), cast[ptr AtscStringSegment00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscStringSegment()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_string_segment_get_type(), cast[ptr AtscStringSegment00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscStringSegment) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscStringSegment)

proc gst_mpegts_atsc_string_segment_get_string(self: ptr AtscStringSegment00): cstring {.
    importc, libprag.}

proc getString*(self: AtscStringSegment): string =
  result = $gst_mpegts_atsc_string_segment_get_string(cast[ptr AtscStringSegment00](self.impl))

proc gst_mpegts_atsc_string_segment_set_string(self: ptr AtscStringSegment00;
    string: cstring; compressionType: uint8; mode: uint8): gboolean {.
    importc, libprag.}

proc setString*(self: AtscStringSegment; string: cstring;
    compressionType: uint8; mode: uint8): bool =
  toBool(gst_mpegts_atsc_string_segment_set_string(cast[ptr AtscStringSegment00](self.impl), string, compressionType, mode))

type
  AtscVCT00* {.pure.} = object
  AtscVCT* = ref object
    impl*: ptr AtscVCT00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_vct_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscVCT*(self: AtscVCT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_vct_get_type(), cast[ptr AtscVCT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscVCT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_vct_get_type(), cast[ptr AtscVCT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscVCT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscVCT)

type
  AtscVCTSource00* {.pure.} = object
  AtscVCTSource* = ref object
    impl*: ptr AtscVCTSource00
    ignoreFinalizer*: bool

proc gst_mpegts_atsc_vct_source_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsAtscVCTSource*(self: AtscVCTSource) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_atsc_vct_source_get_type(), cast[ptr AtscVCTSource00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtscVCTSource()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_atsc_vct_source_get_type(), cast[ptr AtscVCTSource00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtscVCTSource) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsAtscVCTSource)

type
  AudioPreselectionDescriptor00* {.pure.} = object
  AudioPreselectionDescriptor* = ref object
    impl*: ptr AudioPreselectionDescriptor00
    ignoreFinalizer*: bool

type
  BAT00* {.pure.} = object
  BAT* = ref object
    impl*: ptr BAT00
    ignoreFinalizer*: bool

proc gst_mpegts_bat_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsBAT*(self: BAT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_bat_get_type(), cast[ptr BAT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BAT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_bat_get_type(), cast[ptr BAT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var BAT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsBAT)

type
  BATStream00* {.pure.} = object
  BATStream* = ref object
    impl*: ptr BATStream00
    ignoreFinalizer*: bool

proc gst_mpegts_bat_stream_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsBATStream*(self: BATStream) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_bat_stream_get_type(), cast[ptr BATStream00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BATStream()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_bat_stream_get_type(), cast[ptr BATStream00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var BATStream) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsBATStream)

type
  CableDeliverySystemDescriptor00* {.pure.} = object
  CableDeliverySystemDescriptor* = ref object
    impl*: ptr CableDeliverySystemDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_cable_delivery_system_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsCableDeliverySystemDescriptor*(self: CableDeliverySystemDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_cable_delivery_system_descriptor_get_type(), cast[ptr CableDeliverySystemDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CableDeliverySystemDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_cable_delivery_system_descriptor_get_type(), cast[ptr CableDeliverySystemDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var CableDeliverySystemDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsCableDeliverySystemDescriptor)

proc gst_mpegts_dvb_cable_delivery_system_descriptor_free(self: ptr CableDeliverySystemDescriptor00) {.
    importc, libprag.}

proc free*(self: CableDeliverySystemDescriptor) =
  gst_mpegts_dvb_cable_delivery_system_descriptor_free(cast[ptr CableDeliverySystemDescriptor00](self.impl))

proc finalizerfree*(self: CableDeliverySystemDescriptor) =
  if not self.ignoreFinalizer:
    gst_mpegts_dvb_cable_delivery_system_descriptor_free(cast[ptr CableDeliverySystemDescriptor00](self.impl))

type
  CableOuterFECScheme* {.size: sizeof(cint), pure.} = enum
    undefined = 0
    none = 1
    rs_204_188 = 2

type
  ComponentDescriptor00* {.pure.} = object
  ComponentDescriptor* = ref object
    impl*: ptr ComponentDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_component_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsComponentDescriptor*(self: ComponentDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_component_descriptor_get_type(), cast[ptr ComponentDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ComponentDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_component_descriptor_get_type(), cast[ptr ComponentDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ComponentDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsComponentDescriptor)

type
  ComponentStreamContent* {.size: sizeof(cint), pure.} = enum
    mpeg2Video = 1
    mpeg1Layer2Audio = 2
    teletextOrSubtitle = 3
    ac_3 = 4
    avc = 5
    aac = 6
    dts = 7
    srmCpcm = 8

type
  Content00* {.pure.} = object
  Content* = ref object
    impl*: ptr Content00
    ignoreFinalizer*: bool

proc gst_mpegts_content_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsContent*(self: Content) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_content_get_type(), cast[ptr Content00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Content()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_content_get_type(), cast[ptr Content00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Content) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsContent)

type
  ContentNibbleHi* {.size: sizeof(cint), pure.} = enum
    movieDrama = 1
    newsCurrentAffairs = 2
    showGameShow = 3
    sports = 4
    childrenYouthProgram = 5
    musicBalletDance = 6
    artsCulture = 7
    socialPoliticalEconomics = 8
    educationScienceFactual = 9
    leisureHobbies = 10
    specialCharacteristics = 11

type
  DVBCodeRate* {.size: sizeof(cint), pure.} = enum
    none = 0
    enum1_2 = 1
    enum2_3 = 2
    enum3_4 = 3
    enum4_5 = 4
    enum5_6 = 5
    enum6_7 = 6
    enum7_8 = 7
    enum8_9 = 8
    auto = 9
    enum3_5 = 10
    enum9_10 = 11
    enum2_5 = 12

type
  DVBDescriptorType* {.size: sizeof(cint), pure.} = enum
    networkName = 64
    serviceList = 65
    stuffing = 66
    satelliteDeliverySystem = 67
    cableDeliverySystem = 68
    vbiData = 69
    vbiTeletext = 70
    bouquetName = 71
    service = 72
    countryAvailability = 73
    linkage = 74
    nvodReference = 75
    timeShiftedService = 76
    shortEvent = 77
    extendedEvent = 78
    timeShiftedEvent = 79
    component = 80
    mosaic = 81
    streamIdentifier = 82
    caIdentifier = 83
    content = 84
    parentalRating = 85
    teletext = 86
    telephone = 87
    localTimeOffset = 88
    subtitling = 89
    terrestrialDeliverySystem = 90
    multilingualNetworkName = 91
    multilingualBouquetName = 92
    multilingualServiceName = 93
    multilingualComponent = 94
    privateDataSpecifier = 95
    serviceMove = 96
    shortSmoothingBuffer = 97
    frequencyList = 98
    partialTransportStream = 99
    dataBroadcast = 100
    scrambling = 101
    dataBroadcastId = 102
    transportStream = 103
    dsng = 104
    pdc = 105
    ac3 = 106
    ancillaryData = 107
    cellList = 108
    cellFrequencyLink = 109
    announcementSupport = 110
    applicationSignalling = 111
    adaptationFieldData = 112
    serviceIdentifier = 113
    serviceAvailability = 114
    defaultAuthority = 115
    relatedContent = 116
    tvaId = 117
    contentIdentifier = 118
    timesliceFecIdentifier = 119
    ecmRepetitionRate = 120
    s2SatelliteDeliverySystem = 121
    enhancedAc3 = 122
    dts = 123
    aac = 124
    xaitLocation = 125
    ftaContentManagement = 126
    extension = 127

type
  DVBExtendedDescriptorType* {.size: sizeof(cint), pure.} = enum
    imageIcon = 0
    cpcmDeliverySignalling = 1
    cp = 2
    cpIdentifier = 3
    t2DeliverySystem = 4
    shDeliverySystem = 5
    supplementaryAudio = 6
    networkChangeNotify = 7
    message = 8
    targetRegion = 9
    targetRegionName = 10
    serviceRelocated = 11
    xaitPid = 12
    c2DeliverySystem = 13
    dtsHdAudioStream = 14
    dtsNeutral = 15
    videoDepthRange = 16
    t2mi = 17
    uriLinkage = 19
    ac4 = 21
    audioPreselection = 25

type
  DVBLinkageDescriptor00* {.pure.} = object
  DVBLinkageDescriptor* = ref object
    impl*: ptr DVBLinkageDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_linkage_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDVBLinkageDescriptor*(self: DVBLinkageDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_linkage_descriptor_get_type(), cast[ptr DVBLinkageDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DVBLinkageDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_linkage_descriptor_get_type(), cast[ptr DVBLinkageDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DVBLinkageDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDVBLinkageDescriptor)

proc gst_mpegts_dvb_linkage_descriptor_free(self: ptr DVBLinkageDescriptor00) {.
    importc, libprag.}

proc free*(self: DVBLinkageDescriptor) =
  gst_mpegts_dvb_linkage_descriptor_free(cast[ptr DVBLinkageDescriptor00](self.impl))

proc finalizerfree*(self: DVBLinkageDescriptor) =
  if not self.ignoreFinalizer:
    gst_mpegts_dvb_linkage_descriptor_free(cast[ptr DVBLinkageDescriptor00](self.impl))

proc gst_mpegts_dvb_linkage_descriptor_get_extended_event(self: ptr DVBLinkageDescriptor00): ptr PtrArray00 {.
    importc, libprag.}

proc getExtendedEvent*(self: DVBLinkageDescriptor): ptr PtrArray00 =
  gst_mpegts_dvb_linkage_descriptor_get_extended_event(cast[ptr DVBLinkageDescriptor00](self.impl))

proc extendedEvent*(self: DVBLinkageDescriptor): ptr PtrArray00 =
  gst_mpegts_dvb_linkage_descriptor_get_extended_event(cast[ptr DVBLinkageDescriptor00](self.impl))

type
  DVBLinkageEvent00* {.pure.} = object
  DVBLinkageEvent* = ref object
    impl*: ptr DVBLinkageEvent00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_linkage_event_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDVBLinkageEvent*(self: DVBLinkageEvent) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_linkage_event_get_type(), cast[ptr DVBLinkageEvent00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DVBLinkageEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_linkage_event_get_type(), cast[ptr DVBLinkageEvent00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DVBLinkageEvent) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDVBLinkageEvent)

proc gst_mpegts_dvb_linkage_descriptor_get_event(self: ptr DVBLinkageDescriptor00): ptr DVBLinkageEvent00 {.
    importc, libprag.}

proc getEvent*(self: DVBLinkageDescriptor): DVBLinkageEvent =
  fnew(result, gBoxedFreeGstMpegtsDVBLinkageEvent)
  result.impl = gst_mpegts_dvb_linkage_descriptor_get_event(cast[ptr DVBLinkageDescriptor00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_dvb_linkage_event_get_type(), result.impl))

proc event*(self: DVBLinkageDescriptor): DVBLinkageEvent =
  fnew(result, gBoxedFreeGstMpegtsDVBLinkageEvent)
  result.impl = gst_mpegts_dvb_linkage_descriptor_get_event(cast[ptr DVBLinkageDescriptor00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_dvb_linkage_event_get_type(), result.impl))

type
  DVBLinkageMobileHandOver00* {.pure.} = object
  DVBLinkageMobileHandOver* = ref object
    impl*: ptr DVBLinkageMobileHandOver00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_linkage_mobile_hand_over_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDVBLinkageMobileHandOver*(self: DVBLinkageMobileHandOver) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_linkage_mobile_hand_over_get_type(), cast[ptr DVBLinkageMobileHandOver00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DVBLinkageMobileHandOver()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_linkage_mobile_hand_over_get_type(), cast[ptr DVBLinkageMobileHandOver00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DVBLinkageMobileHandOver) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDVBLinkageMobileHandOver)

proc gst_mpegts_dvb_linkage_descriptor_get_mobile_hand_over(self: ptr DVBLinkageDescriptor00): ptr DVBLinkageMobileHandOver00 {.
    importc, libprag.}

proc getMobileHandOver*(self: DVBLinkageDescriptor): DVBLinkageMobileHandOver =
  fnew(result, gBoxedFreeGstMpegtsDVBLinkageMobileHandOver)
  result.impl = gst_mpegts_dvb_linkage_descriptor_get_mobile_hand_over(cast[ptr DVBLinkageDescriptor00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_dvb_linkage_mobile_hand_over_get_type(), result.impl))

proc mobileHandOver*(self: DVBLinkageDescriptor): DVBLinkageMobileHandOver =
  fnew(result, gBoxedFreeGstMpegtsDVBLinkageMobileHandOver)
  result.impl = gst_mpegts_dvb_linkage_descriptor_get_mobile_hand_over(cast[ptr DVBLinkageDescriptor00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_dvb_linkage_mobile_hand_over_get_type(), result.impl))

type
  DVBLinkageExtendedEvent00* {.pure.} = object
  DVBLinkageExtendedEvent* = ref object
    impl*: ptr DVBLinkageExtendedEvent00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_linkage_extended_event_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDVBLinkageExtendedEvent*(self: DVBLinkageExtendedEvent) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_linkage_extended_event_get_type(), cast[ptr DVBLinkageExtendedEvent00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DVBLinkageExtendedEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_linkage_extended_event_get_type(), cast[ptr DVBLinkageExtendedEvent00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DVBLinkageExtendedEvent) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDVBLinkageExtendedEvent)

type
  DVBLinkageHandOverType* {.size: sizeof(cint), pure.} = enum
    reserved = 0
    identical = 1
    localVariation = 2
    associated = 3

type
  DVBLinkageType* {.size: sizeof(cint), pure.} = enum
    reserved_00 = 0
    information = 1
    epg = 2
    caReplacement = 3
    tsContainingCompleteSi = 4
    serviceReplacement = 5
    dataBroadcast = 6
    rcsMap = 7
    mobileHandOver = 8
    systemSoftwareUpdate = 9
    tsContainingSsu = 10
    ipMacNotification = 11
    tsContainingInt = 12
    event = 13
    extendedEvent = 14

type
  DVBParentalRatingItem00* {.pure.} = object
  DVBParentalRatingItem* = ref object
    impl*: ptr DVBParentalRatingItem00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_parental_rating_item_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDVBParentalRatingItem*(self: DVBParentalRatingItem) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_parental_rating_item_get_type(), cast[ptr DVBParentalRatingItem00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DVBParentalRatingItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_parental_rating_item_get_type(), cast[ptr DVBParentalRatingItem00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DVBParentalRatingItem) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDVBParentalRatingItem)

type
  DVBScramblingModeType* {.size: sizeof(cint), pure.} = enum
    reserved = 0
    csa1 = 1
    csa2 = 2
    csa3Standard = 3
    csa3MinimalEnhanced = 4
    csa3FullEnhanced = 5
    cissa = 16
    atis_0 = 112
    atisF = 127

type
  DVBServiceListItem00* {.pure.} = object
  DVBServiceListItem* = ref object
    impl*: ptr DVBServiceListItem00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_service_list_item_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDVBServiceListItem*(self: DVBServiceListItem) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_service_list_item_get_type(), cast[ptr DVBServiceListItem00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DVBServiceListItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_service_list_item_get_type(), cast[ptr DVBServiceListItem00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DVBServiceListItem) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDVBServiceListItem)

type
  DVBServiceType* {.size: sizeof(cint), pure.} = enum
    reserved_00 = 0
    digitalTelevision = 1
    digitalRadioSound = 2
    teletext = 3
    nvodReference = 4
    nvodTimeShifted = 5
    mosaic = 6
    fmRadio = 7
    dvbSrm = 8
    reserved_09 = 9
    advancedCodecDigitalRadioSound = 10
    advancedCodecMosaic = 11
    dataBroadcast = 12
    reserved_0dCommonInterface = 13
    rcsMap = 14
    rcsFls = 15
    dvbMhp = 16
    mpeg2HdDigitalTelevision = 17
    advancedCodecSdDigitalTelevision = 22
    advancedCodecSdNvodTimeShifted = 23
    advancedCodecSdNvodReference = 24
    advancedCodecHdDigitalTelevision = 25
    advancedCodecHdNvodTimeShifted = 26
    advancedCodecHdNvodReference = 27
    advancedCodecStereoHdDigitalTelevision = 28
    advancedCodecStereoHdNvodTimeShifted = 29
    advancedCodecStereoHdNvodReference = 30
    reservedFf = 31

type
  DVBTeletextType* {.size: sizeof(cint), pure.} = enum
    nitialPage = 1
    ubtitlePage = 2
    dditionalInfoPage = 3
    rogrammeSchedulePage = 4
    earingImpairedPage = 5

type
  DataBroadcastDescriptor00* {.pure.} = object
  DataBroadcastDescriptor* = ref object
    impl*: ptr DataBroadcastDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_data_broadcast_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDataBroadcastDescriptor*(self: DataBroadcastDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_data_broadcast_descriptor_get_type(), cast[ptr DataBroadcastDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DataBroadcastDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_data_broadcast_descriptor_get_type(), cast[ptr DataBroadcastDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DataBroadcastDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDataBroadcastDescriptor)

proc gst_mpegts_dvb_data_broadcast_descriptor_free(self: ptr DataBroadcastDescriptor00) {.
    importc, libprag.}

proc free*(self: DataBroadcastDescriptor) =
  gst_mpegts_dvb_data_broadcast_descriptor_free(cast[ptr DataBroadcastDescriptor00](self.impl))

proc finalizerfree*(self: DataBroadcastDescriptor) =
  if not self.ignoreFinalizer:
    gst_mpegts_dvb_data_broadcast_descriptor_free(cast[ptr DataBroadcastDescriptor00](self.impl))

type
  Descriptor00* {.pure.} = object
  Descriptor* = ref object
    impl*: ptr Descriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDescriptor*(self: Descriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_descriptor_get_type(), cast[ptr Descriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Descriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_descriptor_get_type(), cast[ptr Descriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Descriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDescriptor)

proc gst_mpegts_descriptor_free(self: ptr Descriptor00) {.
    importc, libprag.}

proc free*(self: Descriptor) =
  gst_mpegts_descriptor_free(cast[ptr Descriptor00](self.impl))

proc finalizerfree*(self: Descriptor) =
  if not self.ignoreFinalizer:
    gst_mpegts_descriptor_free(cast[ptr Descriptor00](self.impl))

proc gst_mpegts_descriptor_parse_audio_preselection_list(self: ptr Descriptor00;
    list: var ptr PtrArray00): gboolean {.
    importc, libprag.}

proc parseAudioPreselectionList*(self: Descriptor;
    list: var ptr PtrArray00): bool =
  toBool(gst_mpegts_descriptor_parse_audio_preselection_list(cast[ptr Descriptor00](self.impl), list))

proc gst_mpegts_descriptor_parse_ca(self: ptr Descriptor00; caSystemId: var uint16;
    caPid: var uint16; privateData: var ptr uint8; privateDataSize: var uint64): gboolean {.
    importc, libprag.}

proc parseCa*(self: Descriptor; caSystemId: var uint16;
    caPid: var uint16; privateData: var seq[uint8] = cast[var seq[uint8]](nil);
    privateDataSize: var uint64 = cast[var uint64](nil)): bool =
  var privateData_00: ptr uint8
  result = toBool(gst_mpegts_descriptor_parse_ca(cast[ptr Descriptor00](self.impl), caSystemId, caPid, privateData_00, privateDataSize))
  privateData.setLen(privateDataSize)
  copyMem(unsafeaddr privateData[0], privateData_00, privateDataSize.int * sizeof(privateData[0]))
  cogfree(privateData_00)

proc gst_mpegts_descriptor_parse_cable_delivery_system(self: ptr Descriptor00;
    res: var CableDeliverySystemDescriptor00): gboolean {.
    importc, libprag.}

proc parseCableDeliverySystem*(self: Descriptor;
    res: var CableDeliverySystemDescriptor00): bool =
  toBool(gst_mpegts_descriptor_parse_cable_delivery_system(cast[ptr Descriptor00](self.impl), res))

proc gst_mpegts_descriptor_parse_dvb_bouquet_name(self: ptr Descriptor00;
    bouquetName: var cstring): gboolean {.
    importc, libprag.}

proc parseDvbBouquetName*(self: Descriptor; bouquetName: var string = cast[var string](nil)): bool =
  var bouquetName_00: cstring
  result = toBool(gst_mpegts_descriptor_parse_dvb_bouquet_name(cast[ptr Descriptor00](self.impl), bouquetName_00))
  if bouquetName.addr != nil:
    bouquetName = $(bouquetName_00)

proc gst_mpegts_descriptor_parse_dvb_ca_identifier(self: ptr Descriptor00;
    list: var ptr GArray00): gboolean {.
    importc, libprag.}

proc parseDvbCaIdentifier*(self: Descriptor; list: var ptr GArray00): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_ca_identifier(cast[ptr Descriptor00](self.impl), list))

proc gst_mpegts_descriptor_parse_dvb_component(self: ptr Descriptor00; res: var ptr ComponentDescriptor00): gboolean {.
    importc, libprag.}

proc parseDvbComponent*(self: Descriptor; res: var ComponentDescriptor): bool =
  fnew(res, gBoxedFreeGstMpegtsComponentDescriptor)
  toBool(gst_mpegts_descriptor_parse_dvb_component(cast[ptr Descriptor00](self.impl), cast[var ptr ComponentDescriptor00](addr res.impl)))

proc gst_mpegts_descriptor_parse_dvb_content(self: ptr Descriptor00; content: var ptr PtrArray00): gboolean {.
    importc, libprag.}

proc parseDvbContent*(self: Descriptor; content: var ptr PtrArray00): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_content(cast[ptr Descriptor00](self.impl), content))

proc gst_mpegts_descriptor_parse_dvb_data_broadcast(self: ptr Descriptor00;
    res: var ptr DataBroadcastDescriptor00): gboolean {.
    importc, libprag.}

proc parseDvbDataBroadcast*(self: Descriptor; res: var DataBroadcastDescriptor): bool =
  fnew(res, gBoxedFreeGstMpegtsDataBroadcastDescriptor)
  toBool(gst_mpegts_descriptor_parse_dvb_data_broadcast(cast[ptr Descriptor00](self.impl), cast[var ptr DataBroadcastDescriptor00](addr res.impl)))

proc gst_mpegts_descriptor_parse_dvb_data_broadcast_id(self: ptr Descriptor00;
    dataBroadcastId: var uint16; idSelectorBytes: var ptr uint8; len: var uint8): gboolean {.
    importc, libprag.}

proc parseDvbDataBroadcastId*(self: Descriptor;
    dataBroadcastId: var uint16; idSelectorBytes: var (seq[uint8] | string);
    len: var uint8): bool =
  var idSelectorBytes_00: ptr uint8
  result = toBool(gst_mpegts_descriptor_parse_dvb_data_broadcast_id(cast[ptr Descriptor00](self.impl), dataBroadcastId, idSelectorBytes_00, len))
  idSelectorBytes.setLen(len)
  copyMem(unsafeaddr idSelectorBytes[0], idSelectorBytes_00, len.int * sizeof(idSelectorBytes[0]))
  cogfree(idSelectorBytes_00)

proc gst_mpegts_descriptor_parse_dvb_frequency_list(self: ptr Descriptor00;
    offset: var gboolean; list: var ptr GArray00): gboolean {.
    importc, libprag.}

proc parseDvbFrequencyList*(self: Descriptor; offset: var bool;
    list: var ptr GArray00): bool =
  var offset_00: gboolean
  result = toBool(gst_mpegts_descriptor_parse_dvb_frequency_list(cast[ptr Descriptor00](self.impl), offset_00, list))
  if offset.addr != nil:
    offset = toBool(offset_00)

proc gst_mpegts_descriptor_parse_dvb_linkage(self: ptr Descriptor00; res: var ptr DVBLinkageDescriptor00): gboolean {.
    importc, libprag.}

proc parseDvbLinkage*(self: Descriptor; res: var DVBLinkageDescriptor): bool =
  fnew(res, gBoxedFreeGstMpegtsDVBLinkageDescriptor)
  toBool(gst_mpegts_descriptor_parse_dvb_linkage(cast[ptr Descriptor00](self.impl), cast[var ptr DVBLinkageDescriptor00](addr res.impl)))

proc gst_mpegts_descriptor_parse_dvb_multilingual_bouquet_name(self: ptr Descriptor00;
    bouquetNameItems: var ptr PtrArray00): gboolean {.
    importc, libprag.}

proc parseDvbMultilingualBouquetName*(self: Descriptor;
    bouquetNameItems: var ptr PtrArray00): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_multilingual_bouquet_name(cast[ptr Descriptor00](self.impl), bouquetNameItems))

proc gst_mpegts_descriptor_parse_dvb_multilingual_component(self: ptr Descriptor00;
    componentTag: var uint8; componentDescriptionItems: var ptr PtrArray00): gboolean {.
    importc, libprag.}

proc parseDvbMultilingualComponent*(self: Descriptor;
    componentTag: var uint8; componentDescriptionItems: var ptr PtrArray00): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_multilingual_component(cast[ptr Descriptor00](self.impl), componentTag, componentDescriptionItems))

proc gst_mpegts_descriptor_parse_dvb_multilingual_network_name(self: ptr Descriptor00;
    networkNameItems: var ptr PtrArray00): gboolean {.
    importc, libprag.}

proc parseDvbMultilingualNetworkName*(self: Descriptor;
    networkNameItems: var ptr PtrArray00): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_multilingual_network_name(cast[ptr Descriptor00](self.impl), networkNameItems))

proc gst_mpegts_descriptor_parse_dvb_multilingual_service_name(self: ptr Descriptor00;
    serviceNameItems: var ptr PtrArray00): gboolean {.
    importc, libprag.}

proc parseDvbMultilingualServiceName*(self: Descriptor;
    serviceNameItems: var ptr PtrArray00): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_multilingual_service_name(cast[ptr Descriptor00](self.impl), serviceNameItems))

proc gst_mpegts_descriptor_parse_dvb_network_name(self: ptr Descriptor00;
    name: var cstring): gboolean {.
    importc, libprag.}

proc parseDvbNetworkName*(self: Descriptor; name: var string): bool =
  var name_00: cstring
  result = toBool(gst_mpegts_descriptor_parse_dvb_network_name(cast[ptr Descriptor00](self.impl), name_00))
  if name.addr != nil:
    name = $(name_00)

proc gst_mpegts_descriptor_parse_dvb_parental_rating(self: ptr Descriptor00;
    rating: var ptr PtrArray00): gboolean {.
    importc, libprag.}

proc parseDvbParentalRating*(self: Descriptor; rating: var ptr PtrArray00): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_parental_rating(cast[ptr Descriptor00](self.impl), rating))

proc gst_mpegts_descriptor_parse_dvb_private_data_specifier(self: ptr Descriptor00;
    privateDataSpecifier: var uint32; privateData: var ptr uint8; length: var uint8): gboolean {.
    importc, libprag.}

proc parseDvbPrivateDataSpecifier*(self: Descriptor;
    privateDataSpecifier: var int; privateData: var seq[uint8] = cast[var seq[uint8]](nil);
    length: var uint8 = cast[var uint8](nil)): bool =
  var privateDataSpecifier_00: uint32
  var privateData_00: ptr uint8
  result = toBool(gst_mpegts_descriptor_parse_dvb_private_data_specifier(cast[ptr Descriptor00](self.impl), privateDataSpecifier_00, privateData_00, length))
  if privateDataSpecifier.addr != nil:
    privateDataSpecifier = int(privateDataSpecifier_00)
  privateData.setLen(length)
  copyMem(unsafeaddr privateData[0], privateData_00, length.int * sizeof(privateData[0]))
  cogfree(privateData_00)

proc gst_mpegts_descriptor_parse_dvb_scrambling(self: ptr Descriptor00; scramblingMode: var DVBScramblingModeType): gboolean {.
    importc, libprag.}

proc parseDvbScrambling*(self: Descriptor; scramblingMode: var DVBScramblingModeType): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_scrambling(cast[ptr Descriptor00](self.impl), scramblingMode))

proc gst_mpegts_descriptor_parse_dvb_service(self: ptr Descriptor00; serviceType: var DVBServiceType;
    serviceName: var cstring; providerName: var cstring): gboolean {.
    importc, libprag.}

proc parseDvbService*(self: Descriptor; serviceType: var DVBServiceType = cast[var DVBServiceType](nil);
    serviceName: var string = cast[var string](nil); providerName: var string = cast[var string](nil)): bool =
  var serviceName_00: cstring
  var providerName_00: cstring
  result = toBool(gst_mpegts_descriptor_parse_dvb_service(cast[ptr Descriptor00](self.impl), serviceType, serviceName_00, providerName_00))
  if serviceName.addr != nil:
    serviceName = $(serviceName_00)
  if providerName.addr != nil:
    providerName = $(providerName_00)

proc gst_mpegts_descriptor_parse_dvb_service_list(self: ptr Descriptor00;
    list: var ptr PtrArray00): gboolean {.
    importc, libprag.}

proc parseDvbServiceList*(self: Descriptor; list: var ptr PtrArray00): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_service_list(cast[ptr Descriptor00](self.impl), list))

proc gst_mpegts_descriptor_parse_dvb_short_event(self: ptr Descriptor00;
    languageCode: var cstring; eventName: var cstring; text: var cstring): gboolean {.
    importc, libprag.}

proc parseDvbShortEvent*(self: Descriptor; languageCode: var string = cast[var string](nil);
    eventName: var string = cast[var string](nil); text: var string = cast[var string](nil)): bool =
  var languageCode_00: cstring
  var text_00: cstring
  var eventName_00: cstring
  result = toBool(gst_mpegts_descriptor_parse_dvb_short_event(cast[ptr Descriptor00](self.impl), languageCode_00, eventName_00, text_00))
  if languageCode.addr != nil:
    languageCode = $(languageCode_00)
  if text.addr != nil:
    text = $(text_00)
  if eventName.addr != nil:
    eventName = $(eventName_00)

proc gst_mpegts_descriptor_parse_dvb_stream_identifier(self: ptr Descriptor00;
    componentTag: var uint8): gboolean {.
    importc, libprag.}

proc parseDvbStreamIdentifier*(self: Descriptor;
    componentTag: var uint8): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_stream_identifier(cast[ptr Descriptor00](self.impl), componentTag))

proc gst_mpegts_descriptor_parse_dvb_stuffing(self: ptr Descriptor00; stuffingBytes: var ptr uint8): gboolean {.
    importc, libprag.}

proc parseDvbStuffing*(self: Descriptor; stuffingBytes: var ptr uint8): bool =
  toBool(gst_mpegts_descriptor_parse_dvb_stuffing(cast[ptr Descriptor00](self.impl), stuffingBytes))

proc gst_mpegts_descriptor_parse_dvb_subtitling_idx(self: ptr Descriptor00;
    idx: uint32; lang: var cstring; `type`: var uint8; compositionPageId: var uint16;
    ancillaryPageId: var uint16): gboolean {.
    importc, libprag.}

proc parseDvbSubtitlingIdx*(self: Descriptor; idx: int;
    lang: var string; `type`: var uint8 = cast[var uint8](nil); compositionPageId: var uint16 = cast[var uint16](nil);
    ancillaryPageId: var uint16 = cast[var uint16](nil)): bool =
  var lang_00: cstring
  result = toBool(gst_mpegts_descriptor_parse_dvb_subtitling_idx(cast[ptr Descriptor00](self.impl), uint32(idx), lang_00, `type`, compositionPageId, ancillaryPageId))
  if lang.addr != nil:
    lang = $(lang_00)

proc gst_mpegts_descriptor_parse_dvb_subtitling_nb(self: ptr Descriptor00): uint32 {.
    importc, libprag.}

proc parseDvbSubtitlingNb*(self: Descriptor): int =
  int(gst_mpegts_descriptor_parse_dvb_subtitling_nb(cast[ptr Descriptor00](self.impl)))

proc gst_mpegts_descriptor_parse_dvb_teletext_idx(self: ptr Descriptor00;
    idx: uint32; languageCode: var cstring; teletextType: var DVBTeletextType;
    magazineNumber: var uint8; pageNumber: var uint8): gboolean {.
    importc, libprag.}

proc parseDvbTeletextIdx*(self: Descriptor; idx: int;
    languageCode: var string = cast[var string](nil); teletextType: var DVBTeletextType = cast[var DVBTeletextType](nil);
    magazineNumber: var uint8 = cast[var uint8](nil); pageNumber: var uint8 = cast[var uint8](nil)): bool =
  var languageCode_00: cstring
  result = toBool(gst_mpegts_descriptor_parse_dvb_teletext_idx(cast[ptr Descriptor00](self.impl), uint32(idx), languageCode_00, teletextType, magazineNumber, pageNumber))
  if languageCode.addr != nil:
    languageCode = $(languageCode_00)

proc gst_mpegts_descriptor_parse_dvb_teletext_nb(self: ptr Descriptor00): uint32 {.
    importc, libprag.}

proc parseDvbTeletextNb*(self: Descriptor): int =
  int(gst_mpegts_descriptor_parse_dvb_teletext_nb(cast[ptr Descriptor00](self.impl)))

proc gst_mpegts_descriptor_parse_iso_639_language_nb(self: ptr Descriptor00): uint32 {.
    importc, libprag.}

proc parseIso_639LanguageNb*(self: Descriptor): int =
  int(gst_mpegts_descriptor_parse_iso_639_language_nb(cast[ptr Descriptor00](self.impl)))

proc gst_mpegts_descriptor_parse_metadata_std(self: ptr Descriptor00; metadataInputLeakRate: ptr uint32;
    metadataBufferSize: ptr uint32; metadataOutputLeakRate: ptr uint32): gboolean {.
    importc, libprag.}

proc parseMetadataStd*(self: Descriptor; metadataInputLeakRate: ptr uint32;
    metadataBufferSize: ptr uint32; metadataOutputLeakRate: ptr uint32): bool =
  toBool(gst_mpegts_descriptor_parse_metadata_std(cast[ptr Descriptor00](self.impl), metadataInputLeakRate, metadataBufferSize, metadataOutputLeakRate))

proc gst_mpegts_descriptor_parse_registration(self: ptr Descriptor00; registrationId: var uint32;
    additionalInfo: var ptr uint8; additionalInfoLength: var uint64): gboolean {.
    importc, libprag.}

proc parseRegistration*(self: Descriptor; registrationId: var int;
    additionalInfo: var seq[uint8] = cast[var seq[uint8]](nil); additionalInfoLength: var uint64 = cast[var uint64](nil)): bool =
  var registrationId_00: uint32
  var additionalInfo_00: ptr uint8
  result = toBool(gst_mpegts_descriptor_parse_registration(cast[ptr Descriptor00](self.impl), registrationId_00, additionalInfo_00, additionalInfoLength))
  if registrationId.addr != nil:
    registrationId = int(registrationId_00)
  additionalInfo.setLen(additionalInfoLength)
  copyMem(unsafeaddr additionalInfo[0], additionalInfo_00, additionalInfoLength.int * sizeof(additionalInfo[0]))
  cogfree(additionalInfo_00)

proc gst_mpegts_descriptor_from_custom(tag: uint8; data: ptr uint8; length: uint64): ptr Descriptor00 {.
    importc, libprag.}

proc fromCustom*(tag: uint8; data: seq[uint8] | string): Descriptor =
  let length = uint64(data.len)
  fnew(result, gBoxedFreeGstMpegtsDescriptor)
  result.impl = gst_mpegts_descriptor_from_custom(tag, cast[ptr uint8](unsafeaddr(data[0])), length)

proc gst_mpegts_descriptor_from_custom_with_extension(tag: uint8; tagExtension: uint8;
    data: ptr uint8; length: uint64): ptr Descriptor00 {.
    importc, libprag.}

proc fromCustomWithExtension*(tag: uint8; tagExtension: uint8;
    data: seq[uint8] | string): Descriptor =
  let length = uint64(data.len)
  fnew(result, gBoxedFreeGstMpegtsDescriptor)
  result.impl = gst_mpegts_descriptor_from_custom_with_extension(tag, tagExtension, cast[ptr uint8](unsafeaddr(data[0])), length)

proc gst_mpegts_descriptor_from_dvb_network_name(name: cstring): ptr Descriptor00 {.
    importc, libprag.}

proc fromDvbNetworkName*(name: cstring): Descriptor =
  fnew(result, gBoxedFreeGstMpegtsDescriptor)
  result.impl = gst_mpegts_descriptor_from_dvb_network_name(name)

proc gst_mpegts_descriptor_from_dvb_service(serviceType: DVBServiceType;
    serviceName: cstring; serviceProvider: cstring): ptr Descriptor00 {.
    importc, libprag.}

proc fromDvbService*(serviceType: DVBServiceType;
    serviceName: cstring = nil; serviceProvider: cstring = nil): Descriptor =
  fnew(result, gBoxedFreeGstMpegtsDescriptor)
  result.impl = gst_mpegts_descriptor_from_dvb_service(serviceType, serviceName, serviceProvider)

proc gst_mpegts_descriptor_from_dvb_subtitling(lang: cstring; `type`: uint8;
    composition: uint16; ancillary: uint16): ptr Descriptor00 {.
    importc, libprag.}

proc fromDvbSubtitling*(lang: cstring; `type`: uint8;
    composition: uint16; ancillary: uint16): Descriptor =
  fnew(result, gBoxedFreeGstMpegtsDescriptor)
  result.impl = gst_mpegts_descriptor_from_dvb_subtitling(lang, `type`, composition, ancillary)

proc gst_mpegts_descriptor_from_iso_639_language(language: cstring): ptr Descriptor00 {.
    importc, libprag.}

proc fromIso_639Language*(language: cstring): Descriptor =
  fnew(result, gBoxedFreeGstMpegtsDescriptor)
  result.impl = gst_mpegts_descriptor_from_iso_639_language(language)

proc gst_mpegts_descriptor_from_registration(formatIdentifier: cstring; additionalInfo: ptr uint8;
    additionalInfoLength: uint64): ptr Descriptor00 {.
    importc, libprag.}

proc fromRegistration*(formatIdentifier: cstring; additionalInfo: seq[uint8] | string): Descriptor =
  let additionalInfoLength = uint64(additionalInfo.len)
  fnew(result, gBoxedFreeGstMpegtsDescriptor)
  result.impl = gst_mpegts_descriptor_from_registration(formatIdentifier, cast[ptr uint8](unsafeaddr(additionalInfo[0])), additionalInfoLength)

proc gst_mpegts_descriptor_parse_audio_preselection_dump(source: ptr AudioPreselectionDescriptor00) {.
    importc, libprag.}

proc parseAudioPreselectionDump*(source: AudioPreselectionDescriptor) =
  gst_mpegts_descriptor_parse_audio_preselection_dump(cast[ptr AudioPreselectionDescriptor00](source.impl))

proc gst_mpegts_descriptor_parse_audio_preselection_free(source: ptr AudioPreselectionDescriptor00) {.
    importc, libprag.}

proc parseAudioPreselectionFree*(source: AudioPreselectionDescriptor) =
  gst_mpegts_descriptor_parse_audio_preselection_free(cast[ptr AudioPreselectionDescriptor00](source.impl))

type
  ExtendedEventDescriptor00* {.pure.} = object
  ExtendedEventDescriptor* = ref object
    impl*: ptr ExtendedEventDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_extended_event_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsExtendedEventDescriptor*(self: ExtendedEventDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_extended_event_descriptor_get_type(), cast[ptr ExtendedEventDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ExtendedEventDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_extended_event_descriptor_get_type(), cast[ptr ExtendedEventDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ExtendedEventDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsExtendedEventDescriptor)

proc gst_mpegts_extended_event_descriptor_free(self: ptr ExtendedEventDescriptor00) {.
    importc, libprag.}

proc free*(self: ExtendedEventDescriptor) =
  gst_mpegts_extended_event_descriptor_free(cast[ptr ExtendedEventDescriptor00](self.impl))

proc finalizerfree*(self: ExtendedEventDescriptor) =
  if not self.ignoreFinalizer:
    gst_mpegts_extended_event_descriptor_free(cast[ptr ExtendedEventDescriptor00](self.impl))

proc gst_mpegts_descriptor_parse_dvb_extended_event(self: ptr Descriptor00;
    res: var ptr ExtendedEventDescriptor00): gboolean {.
    importc, libprag.}

proc parseDvbExtendedEvent*(self: Descriptor; res: var ExtendedEventDescriptor): bool =
  fnew(res, gBoxedFreeGstMpegtsExtendedEventDescriptor)
  toBool(gst_mpegts_descriptor_parse_dvb_extended_event(cast[ptr Descriptor00](self.impl), cast[var ptr ExtendedEventDescriptor00](addr res.impl)))

type
  T2DeliverySystemDescriptor00* {.pure.} = object
  T2DeliverySystemDescriptor* = ref object
    impl*: ptr T2DeliverySystemDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_t2_delivery_system_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsT2DeliverySystemDescriptor*(self: T2DeliverySystemDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_t2_delivery_system_descriptor_get_type(), cast[ptr T2DeliverySystemDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(T2DeliverySystemDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_t2_delivery_system_descriptor_get_type(), cast[ptr T2DeliverySystemDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var T2DeliverySystemDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsT2DeliverySystemDescriptor)

proc gst_mpegts_t2_delivery_system_descriptor_free(self: ptr T2DeliverySystemDescriptor00) {.
    importc, libprag.}

proc free*(self: T2DeliverySystemDescriptor) =
  gst_mpegts_t2_delivery_system_descriptor_free(cast[ptr T2DeliverySystemDescriptor00](self.impl))

proc finalizerfree*(self: T2DeliverySystemDescriptor) =
  if not self.ignoreFinalizer:
    gst_mpegts_t2_delivery_system_descriptor_free(cast[ptr T2DeliverySystemDescriptor00](self.impl))

proc gst_mpegts_descriptor_parse_dvb_t2_delivery_system(self: ptr Descriptor00;
    res: var ptr T2DeliverySystemDescriptor00): gboolean {.
    importc, libprag.}

proc parseDvbT2DeliverySystem*(self: Descriptor;
    res: var T2DeliverySystemDescriptor): bool =
  fnew(res, gBoxedFreeGstMpegtsT2DeliverySystemDescriptor)
  toBool(gst_mpegts_descriptor_parse_dvb_t2_delivery_system(cast[ptr Descriptor00](self.impl), cast[var ptr T2DeliverySystemDescriptor00](addr res.impl)))

type
  ISO639LanguageDescriptor00* {.pure.} = object
  ISO639LanguageDescriptor* = ref object
    impl*: ptr ISO639LanguageDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_iso_639_language_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsISO639LanguageDescriptor*(self: ISO639LanguageDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_iso_639_language_get_type(), cast[ptr ISO639LanguageDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ISO639LanguageDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_iso_639_language_get_type(), cast[ptr ISO639LanguageDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ISO639LanguageDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsISO639LanguageDescriptor)

proc gst_mpegts_iso_639_language_descriptor_free(self: ptr ISO639LanguageDescriptor00) {.
    importc, libprag.}

proc descriptorFree*(self: ISO639LanguageDescriptor) =
  gst_mpegts_iso_639_language_descriptor_free(cast[ptr ISO639LanguageDescriptor00](self.impl))

proc gst_mpegts_descriptor_parse_iso_639_language(self: ptr Descriptor00;
    res: var ptr ISO639LanguageDescriptor00): gboolean {.
    importc, libprag.}

proc parseIso_639Language*(self: Descriptor; res: var ISO639LanguageDescriptor): bool =
  fnew(res, gBoxedFreeGstMpegtsISO639LanguageDescriptor)
  toBool(gst_mpegts_descriptor_parse_iso_639_language(cast[ptr Descriptor00](self.impl), cast[var ptr ISO639LanguageDescriptor00](addr res.impl)))

type
  Iso639AudioType* {.size: sizeof(cint), pure.} = enum
    undefined = 0
    cleanEffects = 1
    hearingImpaired = 2
    visualImpairedCommentary = 3

proc gst_mpegts_descriptor_parse_iso_639_language_idx(self: ptr Descriptor00;
    idx: uint32; lang: var cstring; audioType: var Iso639AudioType): gboolean {.
    importc, libprag.}

proc parseIso_639LanguageIdx*(self: Descriptor; idx: int;
    lang: var string; audioType: var Iso639AudioType = cast[var Iso639AudioType](nil)): bool =
  var lang_00: cstring
  result = toBool(gst_mpegts_descriptor_parse_iso_639_language_idx(cast[ptr Descriptor00](self.impl), uint32(idx), lang_00, audioType))
  if lang.addr != nil:
    lang = $(lang_00)

type
  LogicalChannelDescriptor00* {.pure.} = object
  LogicalChannelDescriptor* = ref object
    impl*: ptr LogicalChannelDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_logical_channel_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsLogicalChannelDescriptor*(self: LogicalChannelDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_logical_channel_descriptor_get_type(), cast[ptr LogicalChannelDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LogicalChannelDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_logical_channel_descriptor_get_type(), cast[ptr LogicalChannelDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var LogicalChannelDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsLogicalChannelDescriptor)

proc gst_mpegts_descriptor_parse_logical_channel(self: ptr Descriptor00;
    res: var LogicalChannelDescriptor00): gboolean {.
    importc, libprag.}

proc parseLogicalChannel*(self: Descriptor; res: var LogicalChannelDescriptor00): bool =
  toBool(gst_mpegts_descriptor_parse_logical_channel(cast[ptr Descriptor00](self.impl), res))

type
  MetadataDescriptor00* {.pure.} = object
  MetadataDescriptor* = ref object
    impl*: ptr MetadataDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_metadata_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsMetadataDescriptor*(self: MetadataDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_metadata_descriptor_get_type(), cast[ptr MetadataDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MetadataDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_metadata_descriptor_get_type(), cast[ptr MetadataDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MetadataDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsMetadataDescriptor)

proc gst_mpegts_descriptor_parse_metadata(self: ptr Descriptor00; res: var ptr MetadataDescriptor00): gboolean {.
    importc, libprag.}

proc parseMetadata*(self: Descriptor; res: var MetadataDescriptor): bool =
  fnew(res, gBoxedFreeGstMpegtsMetadataDescriptor)
  toBool(gst_mpegts_descriptor_parse_metadata(cast[ptr Descriptor00](self.impl), cast[var ptr MetadataDescriptor00](addr res.impl)))

type
  SatelliteDeliverySystemDescriptor00* {.pure.} = object
  SatelliteDeliverySystemDescriptor* = ref object
    impl*: ptr SatelliteDeliverySystemDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_satellite_delivery_system_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsSatelliteDeliverySystemDescriptor*(self: SatelliteDeliverySystemDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_satellite_delivery_system_descriptor_get_type(), cast[ptr SatelliteDeliverySystemDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SatelliteDeliverySystemDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_satellite_delivery_system_descriptor_get_type(), cast[ptr SatelliteDeliverySystemDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SatelliteDeliverySystemDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsSatelliteDeliverySystemDescriptor)

proc gst_mpegts_descriptor_parse_satellite_delivery_system(self: ptr Descriptor00;
    res: var SatelliteDeliverySystemDescriptor00): gboolean {.
    importc, libprag.}

proc parseSatelliteDeliverySystem*(self: Descriptor;
    res: var SatelliteDeliverySystemDescriptor00): bool =
  toBool(gst_mpegts_descriptor_parse_satellite_delivery_system(cast[ptr Descriptor00](self.impl), res))

type
  TerrestrialDeliverySystemDescriptor00* {.pure.} = object
  TerrestrialDeliverySystemDescriptor* = ref object
    impl*: ptr TerrestrialDeliverySystemDescriptor00
    ignoreFinalizer*: bool

proc gst_mpegts_terrestrial_delivery_system_descriptor_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsTerrestrialDeliverySystemDescriptor*(self: TerrestrialDeliverySystemDescriptor) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_terrestrial_delivery_system_descriptor_get_type(), cast[ptr TerrestrialDeliverySystemDescriptor00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TerrestrialDeliverySystemDescriptor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_terrestrial_delivery_system_descriptor_get_type(), cast[ptr TerrestrialDeliverySystemDescriptor00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var TerrestrialDeliverySystemDescriptor) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsTerrestrialDeliverySystemDescriptor)

proc gst_mpegts_descriptor_parse_terrestrial_delivery_system(self: ptr Descriptor00;
    res: var TerrestrialDeliverySystemDescriptor00): gboolean {.
    importc, libprag.}

proc parseTerrestrialDeliverySystem*(self: Descriptor;
    res: var TerrestrialDeliverySystemDescriptor00): bool =
  toBool(gst_mpegts_descriptor_parse_terrestrial_delivery_system(cast[ptr Descriptor00](self.impl), res))

type
  DescriptorType* {.size: sizeof(cint), pure.} = enum
    reserved_00 = 0
    reserved_01 = 1
    videoStream = 2
    audioStream = 3
    hierarchy = 4
    registration = 5
    dataStreamAlignment = 6
    targetBackgroundGrid = 7
    videoWindow = 8
    ca = 9
    iso_639Language = 10
    systemClock = 11
    multiplexBufferUtilisation = 12
    copyright = 13
    maximumBitrate = 14
    privateDataIndicator = 15
    smoothingBuffer = 16
    std = 17
    ibp = 18
    dsmccCarouselIdentifier = 19
    dsmccAssociationTag = 20
    dsmccDeferredAssociationTag = 21
    dsmccNptReference = 23
    dsmccNptEndpoint = 24
    dsmccStreamMode = 25
    dsmccStreamEvent = 26
    mpeg4Video = 27
    mpeg4Audio = 28
    iod = 29
    sl = 30
    fmc = 31
    externalEsId = 32
    muxCode = 33
    fmxBufferSize = 34
    multiplexBuffer = 35
    contentLabeling = 36
    metadataPointer = 37
    metadata = 38
    metadataStd = 39
    avcVideo = 40
    ipmp = 41
    avcTimingAndHrd = 42
    mpeg2AacAudio = 43
    flexMuxTiming = 44
    mpeg4Text = 45
    mpeg4AudioExtension = 46
    auxiliaryVideoStream = 47
    svcExtension = 48
    mvcExtension = 49
    j2kVideo = 50
    mvcOperationPoint = 51
    mpeg2StereoscopicVideoFormat = 52
    stereoscopicProgramInfo = 53
    stereoscopicVideoInfo = 54

type
  DvbMultilingualBouquetNameItem00* {.pure.} = object
  DvbMultilingualBouquetNameItem* = ref object
    impl*: ptr DvbMultilingualBouquetNameItem00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_multilingual_bouquet_name_item_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDvbMultilingualBouquetNameItem*(self: DvbMultilingualBouquetNameItem) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_multilingual_bouquet_name_item_get_type(), cast[ptr DvbMultilingualBouquetNameItem00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DvbMultilingualBouquetNameItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_multilingual_bouquet_name_item_get_type(), cast[ptr DvbMultilingualBouquetNameItem00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DvbMultilingualBouquetNameItem) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDvbMultilingualBouquetNameItem)

type
  DvbMultilingualComponentItem00* {.pure.} = object
  DvbMultilingualComponentItem* = ref object
    impl*: ptr DvbMultilingualComponentItem00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_multilingual_component_item_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDvbMultilingualComponentItem*(self: DvbMultilingualComponentItem) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_multilingual_component_item_get_type(), cast[ptr DvbMultilingualComponentItem00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DvbMultilingualComponentItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_multilingual_component_item_get_type(), cast[ptr DvbMultilingualComponentItem00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DvbMultilingualComponentItem) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDvbMultilingualComponentItem)

type
  DvbMultilingualNetworkNameItem00* {.pure.} = object
  DvbMultilingualNetworkNameItem* = ref object
    impl*: ptr DvbMultilingualNetworkNameItem00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_multilingual_network_name_item_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDvbMultilingualNetworkNameItem*(self: DvbMultilingualNetworkNameItem) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_multilingual_network_name_item_get_type(), cast[ptr DvbMultilingualNetworkNameItem00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DvbMultilingualNetworkNameItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_multilingual_network_name_item_get_type(), cast[ptr DvbMultilingualNetworkNameItem00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DvbMultilingualNetworkNameItem) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDvbMultilingualNetworkNameItem)

type
  DvbMultilingualServiceNameItem00* {.pure.} = object
  DvbMultilingualServiceNameItem* = ref object
    impl*: ptr DvbMultilingualServiceNameItem00
    ignoreFinalizer*: bool

proc gst_mpegts_dvb_multilingual_service_name_item_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsDvbMultilingualServiceNameItem*(self: DvbMultilingualServiceNameItem) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_dvb_multilingual_service_name_item_get_type(), cast[ptr DvbMultilingualServiceNameItem00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DvbMultilingualServiceNameItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_dvb_multilingual_service_name_item_get_type(), cast[ptr DvbMultilingualServiceNameItem00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DvbMultilingualServiceNameItem) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsDvbMultilingualServiceNameItem)

type
  EIT00* {.pure.} = object
  EIT* = ref object
    impl*: ptr EIT00
    ignoreFinalizer*: bool

proc gst_mpegts_eit_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsEIT*(self: EIT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_eit_get_type(), cast[ptr EIT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EIT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_eit_get_type(), cast[ptr EIT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var EIT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsEIT)

type
  EITEvent00* {.pure.} = object
  EITEvent* = ref object
    impl*: ptr EITEvent00
    ignoreFinalizer*: bool

proc gst_mpegts_eit_event_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsEITEvent*(self: EITEvent) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_eit_event_get_type(), cast[ptr EITEvent00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EITEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_eit_event_get_type(), cast[ptr EITEvent00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var EITEvent) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsEITEvent)

type
  ExtendedEventItem00* {.pure.} = object
  ExtendedEventItem* = ref object
    impl*: ptr ExtendedEventItem00
    ignoreFinalizer*: bool

proc gst_mpegts_extended_event_item_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsExtendedEventItem*(self: ExtendedEventItem) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_extended_event_item_get_type(), cast[ptr ExtendedEventItem00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ExtendedEventItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_extended_event_item_get_type(), cast[ptr ExtendedEventItem00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ExtendedEventItem) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsExtendedEventItem)

type
  HdmvStreamType* {.size: sizeof(cint), pure.} = enum
    audioLpcm = 128
    audioAc3 = 129
    audioDts = 130
    audioAc3TrueHd = 131
    audioAc3Plus = 132
    audioDtsHd = 133
    audioDtsHdMasterAudio = 134
    audioEac3 = 135
    subpicturePgs = 144
    igs = 145
    subtitle = 146
    audioAc3PlusSecondary = 161
    audioDtsHdSecondary = 162

type
  ISDBDescriptorType* {.size: sizeof(cint), pure.} = enum
    hierarchicalTransmission = 192
    digitalCopyControl = 193
    networkIdentification = 194
    partialTsTime = 195
    audioComponent = 196
    hyperlink = 197
    targetRegion = 198
    dataContent = 199
    videoDecodeControl = 200
    downloadContent = 201
    caEmmTs = 202
    caContractInformation = 203
    caService = 204
    tsInformation = 205
    extendedBroadcaster = 206
    logoTransmission = 207
    basicLocalEvent = 208
    reference = 209
    nodeRelation = 210
    shortNodeInformation = 211
    stcReference = 212
    series = 213
    eventGroup = 214
    siParameter = 215
    broadcasterName = 216
    componentGroup = 217
    siPrimeTs = 218
    boardInformation = 219
    ldtLinkage = 220
    connectedTransmission = 221
    contentAvailability = 222
    serviceGroup = 224

type
  LogicalChannel00* {.pure.} = object
  LogicalChannel* = ref object
    impl*: ptr LogicalChannel00
    ignoreFinalizer*: bool

proc gst_mpegts_logical_channel_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsLogicalChannel*(self: LogicalChannel) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_logical_channel_get_type(), cast[ptr LogicalChannel00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LogicalChannel()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_logical_channel_get_type(), cast[ptr LogicalChannel00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var LogicalChannel) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsLogicalChannel)

type
  MetadataFormat* {.size: sizeof(cint), pure.} = enum
    tem = 16
    bim = 17
    applicationFormat = 63
    identifierField = 255

type
  MiscDescriptorType* {.size: sizeof(cint), pure.} = enum
    mtsDescDtgLogicalChannel = 131

type
  ModulationType* {.size: sizeof(cint), pure.} = enum
    qpsk = 0
    qam_16 = 1
    qam_32 = 2
    qam_64 = 3
    qam_128 = 4
    qam_256 = 5
    qamAuto = 6
    vsb_8 = 7
    vsb_16 = 8
    psk_8 = 9
    apsk_16 = 10
    apsk_32 = 11
    dqpsk = 12
    qam_4Nr = 13
    none = 14

type
  NIT00* {.pure.} = object
  NIT* = ref object
    impl*: ptr NIT00
    ignoreFinalizer*: bool

proc gst_mpegts_nit_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsNIT*(self: NIT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_nit_get_type(), cast[ptr NIT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NIT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_nit_get_type(), cast[ptr NIT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var NIT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsNIT)

proc gst_mpegts_nit_new(): ptr NIT00 {.
    importc, libprag.}

proc newNIT*(): NIT =
  fnew(result, gBoxedFreeGstMpegtsNIT)
  result.impl = gst_mpegts_nit_new()

proc newNIT*(tdesc: typedesc): tdesc =
  assert(result is NIT)
  fnew(result, gBoxedFreeGstMpegtsNIT)
  result.impl = gst_mpegts_nit_new()

proc initNIT*[T](result: var T) {.deprecated.} =
  assert(result is NIT)
  fnew(result, gBoxedFreeGstMpegtsNIT)
  result.impl = gst_mpegts_nit_new()

type
  NITStream00* {.pure.} = object
  NITStream* = ref object
    impl*: ptr NITStream00
    ignoreFinalizer*: bool

proc gst_mpegts_nit_stream_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsNITStream*(self: NITStream) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_nit_stream_get_type(), cast[ptr NITStream00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NITStream()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_nit_stream_get_type(), cast[ptr NITStream00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var NITStream) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsNITStream)

proc gst_mpegts_nit_stream_new(): ptr NITStream00 {.
    importc, libprag.}

proc newNITStream*(): NITStream =
  fnew(result, gBoxedFreeGstMpegtsNITStream)
  result.impl = gst_mpegts_nit_stream_new()

proc newNITStream*(tdesc: typedesc): tdesc =
  assert(result is NITStream)
  fnew(result, gBoxedFreeGstMpegtsNITStream)
  result.impl = gst_mpegts_nit_stream_new()

proc initNITStream*[T](result: var T) {.deprecated.} =
  assert(result is NITStream)
  fnew(result, gBoxedFreeGstMpegtsNITStream)
  result.impl = gst_mpegts_nit_stream_new()

type
  PESMetadataMeta00* {.pure.} = object
  PESMetadataMeta* = ref object
    impl*: ptr PESMetadataMeta00
    ignoreFinalizer*: bool

proc gst_mpegts_pes_metadata_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoPESMetadataMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_mpegts_pes_metadata_meta_get_info()
  result.ignoreFinalizer = true

type
  PMT00* {.pure.} = object
  PMT* = ref object
    impl*: ptr PMT00
    ignoreFinalizer*: bool

proc gst_mpegts_pmt_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsPMT*(self: PMT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_pmt_get_type(), cast[ptr PMT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PMT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_pmt_get_type(), cast[ptr PMT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PMT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsPMT)

proc gst_mpegts_pmt_new(): ptr PMT00 {.
    importc, libprag.}

proc newPMT*(): PMT =
  fnew(result, gBoxedFreeGstMpegtsPMT)
  result.impl = gst_mpegts_pmt_new()

proc newPMT*(tdesc: typedesc): tdesc =
  assert(result is PMT)
  fnew(result, gBoxedFreeGstMpegtsPMT)
  result.impl = gst_mpegts_pmt_new()

proc initPMT*[T](result: var T) {.deprecated.} =
  assert(result is PMT)
  fnew(result, gBoxedFreeGstMpegtsPMT)
  result.impl = gst_mpegts_pmt_new()

type
  PMTStream00* {.pure.} = object
  PMTStream* = ref object
    impl*: ptr PMTStream00
    ignoreFinalizer*: bool

proc gst_mpegts_pmt_stream_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsPMTStream*(self: PMTStream) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_pmt_stream_get_type(), cast[ptr PMTStream00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PMTStream()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_pmt_stream_get_type(), cast[ptr PMTStream00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PMTStream) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsPMTStream)

proc gst_mpegts_pmt_stream_new(): ptr PMTStream00 {.
    importc, libprag.}

proc newPMTStream*(): PMTStream =
  fnew(result, gBoxedFreeGstMpegtsPMTStream)
  result.impl = gst_mpegts_pmt_stream_new()

proc newPMTStream*(tdesc: typedesc): tdesc =
  assert(result is PMTStream)
  fnew(result, gBoxedFreeGstMpegtsPMTStream)
  result.impl = gst_mpegts_pmt_stream_new()

proc initPMTStream*[T](result: var T) {.deprecated.} =
  assert(result is PMTStream)
  fnew(result, gBoxedFreeGstMpegtsPMTStream)
  result.impl = gst_mpegts_pmt_stream_new()

type
  Section00* {.pure.} = object
  Section* = ref object
    impl*: ptr Section00
    ignoreFinalizer*: bool

proc gst_mpegts_section_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsSection*(self: Section) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_section_get_type(), cast[ptr Section00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Section()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_section_get_type(), cast[ptr Section00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Section) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsSection)

proc gst_mpegts_section_new(pid: uint16; data: ptr uint8; dataSize: uint64): ptr Section00 {.
    importc, libprag.}

proc newSection*(pid: uint16; data: seq[uint8] | string): Section =
  let dataSize = uint64(data.len)
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_new(pid, cast[ptr uint8](unsafeaddr(data[0])), dataSize)

proc newSection*(tdesc: typedesc; pid: uint16; data: seq[uint8] | string): tdesc =
  let dataSize = uint64(data.len)
  assert(result is Section)
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_new(pid, cast[ptr uint8](unsafeaddr(data[0])), dataSize)

proc initSection*[T](result: var T; pid: uint16; data: seq[uint8] | string) {.deprecated.} =
  let dataSize = uint64(data.len)
  assert(result is Section)
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_new(pid, cast[ptr uint8](unsafeaddr(data[0])), dataSize)

proc gst_mpegts_section_get_atsc_cvct(self: ptr Section00): ptr AtscVCT00 {.
    importc, libprag.}

proc getAtscCvct*(self: Section): AtscVCT =
  fnew(result, gBoxedFreeGstMpegtsAtscVCT)
  result.impl = gst_mpegts_section_get_atsc_cvct(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_vct_get_type(), result.impl))

proc atscCvct*(self: Section): AtscVCT =
  fnew(result, gBoxedFreeGstMpegtsAtscVCT)
  result.impl = gst_mpegts_section_get_atsc_cvct(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_vct_get_type(), result.impl))

proc gst_mpegts_section_get_atsc_eit(self: ptr Section00): ptr AtscEIT00 {.
    importc, libprag.}

proc getAtscEit*(self: Section): AtscEIT =
  fnew(result, gBoxedFreeGstMpegtsAtscEIT)
  result.impl = gst_mpegts_section_get_atsc_eit(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_eit_get_type(), result.impl))

proc atscEit*(self: Section): AtscEIT =
  fnew(result, gBoxedFreeGstMpegtsAtscEIT)
  result.impl = gst_mpegts_section_get_atsc_eit(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_eit_get_type(), result.impl))

proc gst_mpegts_section_get_atsc_ett(self: ptr Section00): ptr AtscETT00 {.
    importc, libprag.}

proc getAtscEtt*(self: Section): AtscETT =
  fnew(result, gBoxedFreeGstMpegtsAtscETT)
  result.impl = gst_mpegts_section_get_atsc_ett(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_ett_get_type(), result.impl))

proc atscEtt*(self: Section): AtscETT =
  fnew(result, gBoxedFreeGstMpegtsAtscETT)
  result.impl = gst_mpegts_section_get_atsc_ett(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_ett_get_type(), result.impl))

proc gst_mpegts_section_get_atsc_mgt(self: ptr Section00): ptr AtscMGT00 {.
    importc, libprag.}

proc getAtscMgt*(self: Section): AtscMGT =
  fnew(result, gBoxedFreeGstMpegtsAtscMGT)
  result.impl = gst_mpegts_section_get_atsc_mgt(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_mgt_get_type(), result.impl))

proc atscMgt*(self: Section): AtscMGT =
  fnew(result, gBoxedFreeGstMpegtsAtscMGT)
  result.impl = gst_mpegts_section_get_atsc_mgt(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_mgt_get_type(), result.impl))

proc gst_mpegts_section_get_atsc_rrt(self: ptr Section00): ptr AtscRRT00 {.
    importc, libprag.}

proc getAtscRrt*(self: Section): AtscRRT =
  fnew(result, gBoxedFreeGstMpegtsAtscRRT)
  result.impl = gst_mpegts_section_get_atsc_rrt(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_rrt_get_type(), result.impl))

proc atscRrt*(self: Section): AtscRRT =
  fnew(result, gBoxedFreeGstMpegtsAtscRRT)
  result.impl = gst_mpegts_section_get_atsc_rrt(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_rrt_get_type(), result.impl))

proc gst_mpegts_section_get_atsc_stt(self: ptr Section00): ptr AtscSTT00 {.
    importc, libprag.}

proc getAtscStt*(self: Section): AtscSTT =
  fnew(result, gBoxedFreeGstMpegtsAtscSTT)
  result.impl = gst_mpegts_section_get_atsc_stt(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_stt_get_type(), result.impl))

proc atscStt*(self: Section): AtscSTT =
  fnew(result, gBoxedFreeGstMpegtsAtscSTT)
  result.impl = gst_mpegts_section_get_atsc_stt(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_stt_get_type(), result.impl))

proc gst_mpegts_section_get_atsc_tvct(self: ptr Section00): ptr AtscVCT00 {.
    importc, libprag.}

proc getAtscTvct*(self: Section): AtscVCT =
  fnew(result, gBoxedFreeGstMpegtsAtscVCT)
  result.impl = gst_mpegts_section_get_atsc_tvct(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_vct_get_type(), result.impl))

proc atscTvct*(self: Section): AtscVCT =
  fnew(result, gBoxedFreeGstMpegtsAtscVCT)
  result.impl = gst_mpegts_section_get_atsc_tvct(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_atsc_vct_get_type(), result.impl))

proc gst_mpegts_section_get_bat(self: ptr Section00): ptr BAT00 {.
    importc, libprag.}

proc getBat*(self: Section): BAT =
  fnew(result, gBoxedFreeGstMpegtsBAT)
  result.impl = gst_mpegts_section_get_bat(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_bat_get_type(), result.impl))

proc bat*(self: Section): BAT =
  fnew(result, gBoxedFreeGstMpegtsBAT)
  result.impl = gst_mpegts_section_get_bat(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_bat_get_type(), result.impl))

proc gst_mpegts_section_get_cat(self: ptr Section00): ptr PtrArray00 {.
    importc, libprag.}

proc getCat*(self: Section): ptr PtrArray00 =
  gst_mpegts_section_get_cat(cast[ptr Section00](self.impl))

proc cat*(self: Section): ptr PtrArray00 =
  gst_mpegts_section_get_cat(cast[ptr Section00](self.impl))

proc gst_mpegts_section_get_data(self: ptr Section00): ptr glib.Bytes00 {.
    importc, libprag.}

proc getData*(self: Section): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gst_mpegts_section_get_data(cast[ptr Section00](self.impl))

proc data*(self: Section): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gst_mpegts_section_get_data(cast[ptr Section00](self.impl))

proc gst_mpegts_section_get_eit(self: ptr Section00): ptr EIT00 {.
    importc, libprag.}

proc getEit*(self: Section): EIT =
  fnew(result, gBoxedFreeGstMpegtsEIT)
  result.impl = gst_mpegts_section_get_eit(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_eit_get_type(), result.impl))

proc eit*(self: Section): EIT =
  fnew(result, gBoxedFreeGstMpegtsEIT)
  result.impl = gst_mpegts_section_get_eit(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_eit_get_type(), result.impl))

proc gst_mpegts_section_get_nit(self: ptr Section00): ptr NIT00 {.
    importc, libprag.}

proc getNit*(self: Section): NIT =
  fnew(result, gBoxedFreeGstMpegtsNIT)
  result.impl = gst_mpegts_section_get_nit(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_nit_get_type(), result.impl))

proc nit*(self: Section): NIT =
  fnew(result, gBoxedFreeGstMpegtsNIT)
  result.impl = gst_mpegts_section_get_nit(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_nit_get_type(), result.impl))

proc gst_mpegts_section_get_pat(self: ptr Section00): ptr PtrArray00 {.
    importc, libprag.}

proc getPat*(self: Section): ptr PtrArray00 =
  gst_mpegts_section_get_pat(cast[ptr Section00](self.impl))

proc pat*(self: Section): ptr PtrArray00 =
  gst_mpegts_section_get_pat(cast[ptr Section00](self.impl))

proc gst_mpegts_section_get_pmt(self: ptr Section00): ptr PMT00 {.
    importc, libprag.}

proc getPmt*(self: Section): PMT =
  fnew(result, gBoxedFreeGstMpegtsPMT)
  result.impl = gst_mpegts_section_get_pmt(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_pmt_get_type(), result.impl))

proc pmt*(self: Section): PMT =
  fnew(result, gBoxedFreeGstMpegtsPMT)
  result.impl = gst_mpegts_section_get_pmt(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_pmt_get_type(), result.impl))

proc gst_mpegts_section_get_tdt(self: ptr Section00): ptr gst.DateTime00 {.
    importc, libprag.}

proc getTdt*(self: Section): gst.DateTime =
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_mpegts_section_get_tdt(cast[ptr Section00](self.impl))

proc tdt*(self: Section): gst.DateTime =
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_mpegts_section_get_tdt(cast[ptr Section00](self.impl))

proc gst_mpegts_section_get_tsdt(self: ptr Section00): ptr PtrArray00 {.
    importc, libprag.}

proc getTsdt*(self: Section): ptr PtrArray00 =
  gst_mpegts_section_get_tsdt(cast[ptr Section00](self.impl))

proc tsdt*(self: Section): ptr PtrArray00 =
  gst_mpegts_section_get_tsdt(cast[ptr Section00](self.impl))

proc gst_mpegts_section_packetize(self: ptr Section00; outputSize: var uint64): ptr uint8 {.
    importc, libprag.}

proc packetize*(self: Section; outputSize: var uint64): ptr uint8 =
  gst_mpegts_section_packetize(cast[ptr Section00](self.impl), outputSize)

proc gst_mpegts_section_send_event(self: ptr Section00; element: ptr gst.Element00): gboolean {.
    importc, libprag.}

proc sendEvent*(self: Section; element: gst.Element): bool =
  toBool(gst_mpegts_section_send_event(cast[ptr Section00](self.impl), cast[ptr gst.Element00](element.impl)))

proc gst_mpegts_section_from_atsc_mgt(mgt: ptr AtscMGT00): ptr Section00 {.
    importc, libprag.}

proc fromAtscMgt*(mgt: AtscMGT): Section =
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_from_atsc_mgt(cast[ptr AtscMGT00](g_boxed_copy(gst_mpegts_atsc_mgt_get_type(), mgt.impl)))

proc gst_mpegts_section_from_atsc_rrt(rrt: ptr AtscRRT00): ptr Section00 {.
    importc, libprag.}

proc fromAtscRrt*(rrt: AtscRRT): Section =
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_from_atsc_rrt(cast[ptr AtscRRT00](rrt.impl))

proc gst_mpegts_section_from_atsc_stt(stt: ptr AtscSTT00): ptr Section00 {.
    importc, libprag.}

proc fromAtscStt*(stt: AtscSTT): Section =
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_from_atsc_stt(cast[ptr AtscSTT00](stt.impl))

proc gst_mpegts_section_from_nit(nit: ptr NIT00): ptr Section00 {.
    importc, libprag.}

proc fromNit*(nit: NIT): Section =
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_from_nit(cast[ptr NIT00](g_boxed_copy(gst_mpegts_nit_get_type(), nit.impl)))

proc gst_mpegts_section_from_pat(programs: ptr PtrArray00; tsId: uint16): ptr Section00 {.
    importc, libprag.}

proc fromPat*(programs: ptr PtrArray00; tsId: uint16): Section =
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_from_pat(programs, tsId)

proc gst_mpegts_section_from_pmt(pmt: ptr PMT00; pid: uint16): ptr Section00 {.
    importc, libprag.}

proc fromPmt*(pmt: PMT; pid: uint16): Section =
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_from_pmt(cast[ptr PMT00](g_boxed_copy(gst_mpegts_pmt_get_type(), pmt.impl)), pid)

type
  PacketizeFunc* = proc (section: ptr Section00): gboolean {.cdecl.}

type
  SIT00* {.pure.} = object
  SIT* = ref object
    impl*: ptr SIT00
    ignoreFinalizer*: bool

proc gst_mpegts_sit_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsSIT*(self: SIT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_sit_get_type(), cast[ptr SIT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SIT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_sit_get_type(), cast[ptr SIT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SIT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsSIT)

proc gst_mpegts_section_get_sit(self: ptr Section00): ptr SIT00 {.
    importc, libprag.}

proc getSit*(self: Section): SIT =
  fnew(result, gBoxedFreeGstMpegtsSIT)
  result.impl = gst_mpegts_section_get_sit(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_sit_get_type(), result.impl))

proc sit*(self: Section): SIT =
  fnew(result, gBoxedFreeGstMpegtsSIT)
  result.impl = gst_mpegts_section_get_sit(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_sit_get_type(), result.impl))

type
  TOT00* {.pure.} = object
  TOT* = ref object
    impl*: ptr TOT00
    ignoreFinalizer*: bool

proc gst_mpegts_tot_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsTOT*(self: TOT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_tot_get_type(), cast[ptr TOT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TOT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_tot_get_type(), cast[ptr TOT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var TOT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsTOT)

proc gst_mpegts_section_get_tot(self: ptr Section00): ptr TOT00 {.
    importc, libprag.}

proc getTot*(self: Section): TOT =
  fnew(result, gBoxedFreeGstMpegtsTOT)
  result.impl = gst_mpegts_section_get_tot(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_tot_get_type(), result.impl))

proc tot*(self: Section): TOT =
  fnew(result, gBoxedFreeGstMpegtsTOT)
  result.impl = gst_mpegts_section_get_tot(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_tot_get_type(), result.impl))

type
  SCTESIT00* {.pure.} = object
  SCTESIT* = ref object
    impl*: ptr SCTESIT00
    ignoreFinalizer*: bool

proc gst_mpegts_scte_sit_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsSCTESIT*(self: SCTESIT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_scte_sit_get_type(), cast[ptr SCTESIT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SCTESIT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_scte_sit_get_type(), cast[ptr SCTESIT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SCTESIT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsSCTESIT)

proc gst_mpegts_scte_sit_new(): ptr SCTESIT00 {.
    importc, libprag.}

proc newSCTESIT*(): SCTESIT =
  fnew(result, gBoxedFreeGstMpegtsSCTESIT)
  result.impl = gst_mpegts_scte_sit_new()

proc newSCTESIT*(tdesc: typedesc): tdesc =
  assert(result is SCTESIT)
  fnew(result, gBoxedFreeGstMpegtsSCTESIT)
  result.impl = gst_mpegts_scte_sit_new()

proc initSCTESIT*[T](result: var T) {.deprecated.} =
  assert(result is SCTESIT)
  fnew(result, gBoxedFreeGstMpegtsSCTESIT)
  result.impl = gst_mpegts_scte_sit_new()

proc gst_mpegts_section_get_scte_sit(self: ptr Section00): ptr SCTESIT00 {.
    importc, libprag.}

proc getScteSit*(self: Section): SCTESIT =
  fnew(result, gBoxedFreeGstMpegtsSCTESIT)
  result.impl = gst_mpegts_section_get_scte_sit(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_scte_sit_get_type(), result.impl))

proc scteSit*(self: Section): SCTESIT =
  fnew(result, gBoxedFreeGstMpegtsSCTESIT)
  result.impl = gst_mpegts_section_get_scte_sit(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_scte_sit_get_type(), result.impl))

proc gst_mpegts_section_from_scte_sit(sit: ptr SCTESIT00; pid: uint16): ptr Section00 {.
    importc, libprag.}

proc fromScteSit*(sit: SCTESIT; pid: uint16): Section =
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_from_scte_sit(cast[ptr SCTESIT00](g_boxed_copy(gst_mpegts_scte_sit_get_type(), sit.impl)), pid)

type
  SDT00* {.pure.} = object
  SDT* = ref object
    impl*: ptr SDT00
    ignoreFinalizer*: bool

proc gst_mpegts_sdt_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsSDT*(self: SDT) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_sdt_get_type(), cast[ptr SDT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SDT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_sdt_get_type(), cast[ptr SDT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SDT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsSDT)

proc gst_mpegts_sdt_new(): ptr SDT00 {.
    importc, libprag.}

proc newSDT*(): SDT =
  fnew(result, gBoxedFreeGstMpegtsSDT)
  result.impl = gst_mpegts_sdt_new()

proc newSDT*(tdesc: typedesc): tdesc =
  assert(result is SDT)
  fnew(result, gBoxedFreeGstMpegtsSDT)
  result.impl = gst_mpegts_sdt_new()

proc initSDT*[T](result: var T) {.deprecated.} =
  assert(result is SDT)
  fnew(result, gBoxedFreeGstMpegtsSDT)
  result.impl = gst_mpegts_sdt_new()

proc gst_mpegts_section_get_sdt(self: ptr Section00): ptr SDT00 {.
    importc, libprag.}

proc getSdt*(self: Section): SDT =
  fnew(result, gBoxedFreeGstMpegtsSDT)
  result.impl = gst_mpegts_section_get_sdt(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_sdt_get_type(), result.impl))

proc sdt*(self: Section): SDT =
  fnew(result, gBoxedFreeGstMpegtsSDT)
  result.impl = gst_mpegts_section_get_sdt(cast[ptr Section00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_sdt_get_type(), result.impl))

proc gst_mpegts_section_from_sdt(sdt: ptr SDT00): ptr Section00 {.
    importc, libprag.}

proc fromSdt*(sdt: SDT): Section =
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_mpegts_section_from_sdt(cast[ptr SDT00](g_boxed_copy(gst_mpegts_sdt_get_type(), sdt.impl)))

type
  PatProgram00* {.pure.} = object
  PatProgram* = ref object
    impl*: ptr PatProgram00
    ignoreFinalizer*: bool

proc gst_mpegts_pat_program_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsPatProgram*(self: PatProgram) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_pat_program_get_type(), cast[ptr PatProgram00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PatProgram()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_pat_program_get_type(), cast[ptr PatProgram00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PatProgram) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsPatProgram)

proc gst_mpegts_pat_program_new(): ptr PatProgram00 {.
    importc, libprag.}

proc newPatProgram*(): PatProgram =
  fnew(result, gBoxedFreeGstMpegtsPatProgram)
  result.impl = gst_mpegts_pat_program_new()

proc newPatProgram*(tdesc: typedesc): tdesc =
  assert(result is PatProgram)
  fnew(result, gBoxedFreeGstMpegtsPatProgram)
  result.impl = gst_mpegts_pat_program_new()

proc initPatProgram*[T](result: var T) {.deprecated.} =
  assert(result is PatProgram)
  fnew(result, gBoxedFreeGstMpegtsPatProgram)
  result.impl = gst_mpegts_pat_program_new()

type
  RegistrationId* {.size: sizeof(cint), pure.} = enum
    enum0 = 0
    ac_3 = 1094921523
    ac_4 = 1094921524
    bssd = 1112757060
    cuei = 1129661769
    dts1 = 1146377009
    dts2 = 1146377010
    dts3 = 1146377011
    eac3 = 1161904947
    etv1 = 1163154993
    ga94 = 1195456820
    hdmv = 1212435798
    otherHevc = 1212503619
    klva = 1263294017
    opus = 1330664787
    tshv = 1414744150
    vc_1 = 1447243057
    drac = 1685217635

type
  RunningStatus* {.size: sizeof(cint), pure.} = enum
    undefined = 0
    notRunning = 1
    startsInFewSeconds = 2
    pausing = 3
    running = 4
    offAir = 5

type
  SCTEDescriptorType* {.size: sizeof(cint), pure.} = enum
    stuffing = 128
    ac3 = 129
    frameRate = 130
    extendedVideo = 131
    componentName = 132
    frequencySpec = 144
    modulationParams = 145
    transportStreamId = 146

type
  SCTESpliceCommandType* {.size: sizeof(cint), pure.} = enum
    null = 0
    schedule = 4
    insert = 5
    time = 6
    bandwidth = 7
    private = 255

type
  SCTESpliceComponent00* {.pure.} = object
  SCTESpliceComponent* = ref object
    impl*: ptr SCTESpliceComponent00
    ignoreFinalizer*: bool

proc gst_mpegts_scte_splice_component_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsSCTESpliceComponent*(self: SCTESpliceComponent) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_scte_splice_component_get_type(), cast[ptr SCTESpliceComponent00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SCTESpliceComponent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_scte_splice_component_get_type(), cast[ptr SCTESpliceComponent00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SCTESpliceComponent) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsSCTESpliceComponent)

proc gst_mpegts_scte_splice_component_new(tag: uint8): ptr SCTESpliceComponent00 {.
    importc, libprag.}

proc newSCTESpliceComponent*(tag: uint8): SCTESpliceComponent =
  fnew(result, gBoxedFreeGstMpegtsSCTESpliceComponent)
  result.impl = gst_mpegts_scte_splice_component_new(tag)

proc newSCTESpliceComponent*(tdesc: typedesc; tag: uint8): tdesc =
  assert(result is SCTESpliceComponent)
  fnew(result, gBoxedFreeGstMpegtsSCTESpliceComponent)
  result.impl = gst_mpegts_scte_splice_component_new(tag)

proc initSCTESpliceComponent*[T](result: var T; tag: uint8) {.deprecated.} =
  assert(result is SCTESpliceComponent)
  fnew(result, gBoxedFreeGstMpegtsSCTESpliceComponent)
  result.impl = gst_mpegts_scte_splice_component_new(tag)

type
  SCTESpliceDescriptor* {.size: sizeof(cint), pure.} = enum
    avail = 0
    dtmf = 1
    segmentation = 2
    time = 3
    audio = 4

type
  SCTESpliceEvent00* {.pure.} = object
  SCTESpliceEvent* = ref object
    impl*: ptr SCTESpliceEvent00
    ignoreFinalizer*: bool

proc gst_mpegts_scte_splice_event_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsSCTESpliceEvent*(self: SCTESpliceEvent) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_scte_splice_event_get_type(), cast[ptr SCTESpliceEvent00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SCTESpliceEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_scte_splice_event_get_type(), cast[ptr SCTESpliceEvent00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SCTESpliceEvent) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsSCTESpliceEvent)

proc gst_mpegts_scte_splice_event_new(): ptr SCTESpliceEvent00 {.
    importc, libprag.}

proc newSCTESpliceEvent*(): SCTESpliceEvent =
  fnew(result, gBoxedFreeGstMpegtsSCTESpliceEvent)
  result.impl = gst_mpegts_scte_splice_event_new()

proc newSCTESpliceEvent*(tdesc: typedesc): tdesc =
  assert(result is SCTESpliceEvent)
  fnew(result, gBoxedFreeGstMpegtsSCTESpliceEvent)
  result.impl = gst_mpegts_scte_splice_event_new()

proc initSCTESpliceEvent*[T](result: var T) {.deprecated.} =
  assert(result is SCTESpliceEvent)
  fnew(result, gBoxedFreeGstMpegtsSCTESpliceEvent)
  result.impl = gst_mpegts_scte_splice_event_new()

type
  SDTService00* {.pure.} = object
  SDTService* = ref object
    impl*: ptr SDTService00
    ignoreFinalizer*: bool

proc gst_mpegts_sdt_service_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsSDTService*(self: SDTService) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_sdt_service_get_type(), cast[ptr SDTService00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SDTService()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_sdt_service_get_type(), cast[ptr SDTService00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SDTService) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsSDTService)

proc gst_mpegts_sdt_service_new(): ptr SDTService00 {.
    importc, libprag.}

proc newSDTService*(): SDTService =
  fnew(result, gBoxedFreeGstMpegtsSDTService)
  result.impl = gst_mpegts_sdt_service_new()

proc newSDTService*(tdesc: typedesc): tdesc =
  assert(result is SDTService)
  fnew(result, gBoxedFreeGstMpegtsSDTService)
  result.impl = gst_mpegts_sdt_service_new()

proc initSDTService*[T](result: var T) {.deprecated.} =
  assert(result is SDTService)
  fnew(result, gBoxedFreeGstMpegtsSDTService)
  result.impl = gst_mpegts_sdt_service_new()

type
  SITService00* {.pure.} = object
  SITService* = ref object
    impl*: ptr SITService00
    ignoreFinalizer*: bool

proc gst_mpegts_sit_service_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsSITService*(self: SITService) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_sit_service_get_type(), cast[ptr SITService00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SITService()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_sit_service_get_type(), cast[ptr SITService00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SITService) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsSITService)

type
  SatellitePolarizationType* {.size: sizeof(cint), pure.} = enum
    linearHorizontal = 0
    linearVertical = 1
    circularLeft = 2
    circularRight = 3

type
  SatelliteRolloff* {.size: sizeof(cint), pure.} = enum
    enum35 = 0
    enum20 = 1
    enum25 = 2
    reserved = 3
    auto = 4

type
  ScteStreamType* {.size: sizeof(cint), pure.} = enum
    subtitling = 130
    isochData = 131
    sit = 134
    dstNrt = 149
    dsmccDcb = 176
    signaling = 192
    syncData = 194
    asyncData = 195

type
  SectionATSCTableID* {.size: sizeof(cint), pure.} = enum
    masterGuide = 199
    terrestrialVirtualChannel = 200
    cableVirtualChannel = 201
    ratingRegion = 202
    eventInformation = 203
    channelOrEventExtendedText = 204
    systemTime = 205
    dataEvent = 206
    dataService = 207
    programIdentifier = 208
    networkResource = 209
    longTermService = 210
    directedChannelChange = 211
    directedChannelChangeSectionCode = 212
    aggregateEventInformation = 214
    aggregateExtendedText = 215
    aggregateDataEvent = 217
    satelliteVirtualChannel = 218

type
  SectionDVBTableID* {.size: sizeof(cint), pure.} = enum
    networkInformationActualNetwork = 64
    networkInformationOtherNetwork = 65
    serviceDescriptionActualTs = 66
    serviceDescriptionOtherTs = 70
    bouquetAssociation = 74
    updateNotification = 75
    downloadableFontInfo = 76
    eventInformationActualTsPresent = 78
    eventInformationOtherTsPresent = 79
    eventInformationActualTsSchedule_1 = 80
    eventInformationActualTsScheduleN = 95
    eventInformationOtherTsSchedule_1 = 96
    eventInformationOtherTsScheduleN = 111
    timeDate = 112
    runningStatus = 113
    stuffing = 114
    timeOffset = 115
    applicationInformationTable = 116
    container = 117
    relatedContent = 118
    contentIdentifier = 119
    mpeFec = 120
    resolutionNotification = 121
    mpeIfec = 122
    protectionMessage = 123
    discontinuityInformation = 126
    selectionInformation = 127
    caMessageEcm_0 = 128
    caMessageEcm_1 = 129
    caMessageSystemPrivate_1 = 130
    caMessageSystemPrivateN = 143
    sct = 160
    fct = 161
    tct = 162
    spt = 163
    cmt = 164
    tbtp = 165
    pcrPacketPayload = 166
    transmissionModeSupportPayload = 170
    tim = 176
    llFecParityDataTable = 177

type
  SectionSCTETableID* {.size: sizeof(cint), pure.} = enum
    eas = 216
    ebif = 224
    reserved = 225
    eiss = 226
    dii = 227
    ddb = 228
    splice = 252

type
  SectionTableID* {.size: sizeof(cint), pure.} = enum
    programAssociation = 0
    conditionalAccess = 1
    tsProgramMap = 2
    tsDescription = 3
    enum14496SceneDescription = 4
    enum14496ObjetDescriptor = 5
    metadata = 6
    ipmpControlInformation = 7
    enum14496Section = 8
    enum23001_11Section = 9
    enum23001_10Section = 10
    dsmCcMultiprotoEncapsulatedData = 58
    dsmCcUNMessages = 59
    dsmCcDownloadDataMessages = 60
    dsmCcStreamDescriptors = 61
    dsmCcPrivateData = 62
    dsmCcAddressableSections = 63
    unset = 255

type
  SectionType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    pat = 1
    pmt = 2
    cat = 3
    tsdt = 4
    eit = 5
    nit = 6
    bat = 7
    sdt = 8
    tdt = 9
    tot = 10
    sit = 11
    atscTvct = 12
    atscCvct = 13
    atscMgt = 14
    atscEtt = 15
    atscEit = 16
    atscStt = 17
    atscRrt = 18
    scteSit = 19

type
  StreamType* {.size: sizeof(cint), pure.} = enum
    reserved_00 = 0
    videoMpeg1 = 1
    videoMpeg2 = 2
    audioMpeg1 = 3
    audioMpeg2 = 4
    privateSections = 5
    privatePesPackets = 6
    mheg = 7
    dsmCc = 8
    h_222_1 = 9
    dsmccA = 10
    dsmccB = 11
    dsmccC = 12
    dsmccD = 13
    auxiliary = 14
    audioAacAdts = 15
    videoMpeg4 = 16
    audioAacLatm = 17
    slFlexmuxPesPackets = 18
    slFlexmuxSections = 19
    synchronizedDownload = 20
    metadataPesPackets = 21
    metadataSections = 22
    metadataDataCarousel = 23
    metadataObjectCarousel = 24
    metadataSynchronizedDownload = 25
    mpeg2Ipmp = 26
    videoH264 = 27
    audioAacClean = 28
    mpeg4TimedText = 29
    videoRvc = 30
    videoH264SvcSubBitstream = 31
    videoH264MvcSubBitstream = 32
    videoJp2k = 33
    videoMpeg2StereoAdditionalView = 34
    videoH264StereoAdditionalView = 35
    videoHevc = 36
    ipmpStream = 127
    userPrivateEa = 234

type
  T2DeliverySystemCell00* {.pure.} = object
  T2DeliverySystemCell* = ref object
    impl*: ptr T2DeliverySystemCell00
    ignoreFinalizer*: bool

proc gst_mpegts_t2_delivery_system_cell_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsT2DeliverySystemCell*(self: T2DeliverySystemCell) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_t2_delivery_system_cell_get_type(), cast[ptr T2DeliverySystemCell00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(T2DeliverySystemCell()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_t2_delivery_system_cell_get_type(), cast[ptr T2DeliverySystemCell00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var T2DeliverySystemCell) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsT2DeliverySystemCell)

type
  T2DeliverySystemCellExtension00* {.pure.} = object
  T2DeliverySystemCellExtension* = ref object
    impl*: ptr T2DeliverySystemCellExtension00
    ignoreFinalizer*: bool

proc gst_mpegts_t2_delivery_system_cell_extension_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMpegtsT2DeliverySystemCellExtension*(self: T2DeliverySystemCellExtension) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mpegts_t2_delivery_system_cell_extension_get_type(), cast[ptr T2DeliverySystemCellExtension00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(T2DeliverySystemCellExtension()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mpegts_t2_delivery_system_cell_extension_get_type(), cast[ptr T2DeliverySystemCellExtension00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var T2DeliverySystemCellExtension) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMpegtsT2DeliverySystemCellExtension)

type
  TerrestrialGuardInterval* {.size: sizeof(cint), pure.} = enum
    enum1_32 = 0
    enum1_16 = 1
    enum1_8 = 2
    enum1_4 = 3
    auto = 4
    enum1_128 = 5
    enum19_128 = 6
    enum19_256 = 7
    pn420 = 8
    pn595 = 9
    pn945 = 10

type
  TerrestrialHierarchy* {.size: sizeof(cint), pure.} = enum
    none = 0
    enum1 = 1
    enum2 = 2
    enum4 = 3
    auto = 4

type
  TerrestrialTransmissionMode* {.size: sizeof(cint), pure.} = enum
    enum2k = 0
    enum8k = 1
    auto = 2
    enum4k = 3
    enum1k = 4
    enum16k = 5
    enum32k = 6
    c1 = 7
    c3780 = 8

proc gst_buffer_add_mpegts_pes_metadata_meta(buffer: ptr gst.Buffer00): ptr PESMetadataMeta00 {.
    importc, libprag.}

proc bufferAddMpegtsPesMetadataMeta*(buffer: gst.Buffer): PESMetadataMeta =
  new(result)
  result.impl = gst_buffer_add_mpegts_pes_metadata_meta(cast[ptr gst.Buffer00](buffer.impl))
  result.ignoreFinalizer = true

proc gst_mpegts_dvb_component_descriptor_free(source: ptr ComponentDescriptor00) {.
    importc, libprag.}

proc dvbComponentDescriptorFree*(source: ComponentDescriptor) =
  gst_mpegts_dvb_component_descriptor_free(cast[ptr ComponentDescriptor00](source.impl))

proc gst_event_new_mpegts_section(section: ptr Section00): ptr gst.Event00 {.
    importc, libprag.}

proc eventNewMpegtsSection*(section: Section): gst.Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_mpegts_section(cast[ptr Section00](section.impl))

proc gst_event_parse_mpegts_section(event: ptr gst.Event00): ptr Section00 {.
    importc, libprag.}

proc eventParseMpegtsSection*(event: gst.Event): Section =
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_event_parse_mpegts_section(cast[ptr gst.Event00](event.impl))

proc gst_mpegts_find_descriptor(descriptors: ptr PtrArray00; tag: uint8): ptr Descriptor00 {.
    importc, libprag.}

proc findDescriptor*(descriptors: ptr PtrArray00; tag: uint8): Descriptor =
  fnew(result, gBoxedFreeGstMpegtsDescriptor)
  result.impl = gst_mpegts_find_descriptor(descriptors, tag)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_descriptor_get_type(), result.impl))

proc gst_mpegts_find_descriptor_with_extension(descriptors: ptr PtrArray00;
    tag: uint8; tagExtension: uint8): ptr Descriptor00 {.
    importc, libprag.}

proc findDescriptorWithExtension*(descriptors: ptr PtrArray00;
    tag: uint8; tagExtension: uint8): Descriptor =
  fnew(result, gBoxedFreeGstMpegtsDescriptor)
  result.impl = gst_mpegts_find_descriptor_with_extension(descriptors, tag, tagExtension)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mpegts_descriptor_get_type(), result.impl))

proc initialize*() {.
    importc: "gst_mpegts_initialize", libprag.}

proc gst_message_new_mpegts_section(parent: ptr gst.Object00; section: ptr Section00): ptr gst.Message00 {.
    importc, libprag.}

proc messageNewMpegtsSection*(parent: gst.Object; section: Section): gst.Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_mpegts_section(cast[ptr gst.Object00](parent.impl), cast[ptr Section00](section.impl))

proc gst_message_parse_mpegts_section(message: ptr gst.Message00): ptr Section00 {.
    importc, libprag.}

proc messageParseMpegtsSection*(message: gst.Message): Section =
  fnew(result, gBoxedFreeGstMpegtsSection)
  result.impl = gst_message_parse_mpegts_section(cast[ptr gst.Message00](message.impl))

proc parseDescriptors*(buffer: ptr uint8; bufLen: uint64): ptr PtrArray00 {.
    importc: "gst_mpegts_parse_descriptors", libprag.}

proc patNew*(): ptr PtrArray00 {.
    importc: "gst_mpegts_pat_new", libprag.}

proc pesMetadataMetaApiGetType*(): GType {.
    importc: "gst_mpegts_pes_metadata_meta_api_get_type", libprag.}

proc gst_mpegts_scte_cancel_new(eventId: uint32): ptr SCTESIT00 {.
    importc, libprag.}

proc newScteCancel*(eventId: int): SCTESIT =
  fnew(result, gBoxedFreeGstMpegtsSCTESIT)
  result.impl = gst_mpegts_scte_cancel_new(uint32(eventId))

proc gst_mpegts_scte_null_new(): ptr SCTESIT00 {.
    importc, libprag.}

proc newScteNull*(): SCTESIT =
  fnew(result, gBoxedFreeGstMpegtsSCTESIT)
  result.impl = gst_mpegts_scte_null_new()

proc gst_mpegts_scte_splice_in_new(eventId: uint32; spliceTime: uint64): ptr SCTESIT00 {.
    importc, libprag.}

proc newScteSpliceIn*(eventId: int; spliceTime: uint64): SCTESIT =
  fnew(result, gBoxedFreeGstMpegtsSCTESIT)
  result.impl = gst_mpegts_scte_splice_in_new(uint32(eventId), spliceTime)

proc gst_mpegts_scte_splice_out_new(eventId: uint32; spliceTime: uint64;
    duration: uint64): ptr SCTESIT00 {.
    importc, libprag.}

proc newScteSpliceOut*(eventId: int; spliceTime: uint64; duration: uint64): SCTESIT =
  fnew(result, gBoxedFreeGstMpegtsSCTESIT)
  result.impl = gst_mpegts_scte_splice_out_new(uint32(eventId), spliceTime, duration)
# === remaining symbols:

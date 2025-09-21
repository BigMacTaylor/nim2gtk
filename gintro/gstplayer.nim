# dependencies:
# GstPbutils-1.0
# GLib-2.0
# GstAudio-1.0
# GModule-2.0
# GstTag-1.0
# GstVideo-1.0
# GObject-2.0
# GstBase-1.0
# Gst-1.0
# immediate dependencies:
# GstVideo-1.0
# GstTag-1.0
# GstPbutils-1.0
# GstBase-1.0
# GstAudio-1.0
# Gst-1.0
# libraries:
# libgstplayer-1.0.so.0
{.warning[UnusedImport]: off.}
import gstpbutils, glib, gstaudio, gmodule, gsttag, gstvideo, gobject, gstbase, gst
const Lib = "libgstplayer-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  PlayerMediaInfo* = ref object of gobject.Object
  PlayerMediaInfo00* = object of gobject.Object00

proc gst_player_media_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PlayerMediaInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_player_media_info_get_container_format(self: ptr PlayerMediaInfo00): cstring {.
    importc, libprag.}

proc getContainerFormat*(self: PlayerMediaInfo): string =
  let resul0 = gst_player_media_info_get_container_format(cast[ptr PlayerMediaInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc containerFormat*(self: PlayerMediaInfo): string =
  let resul0 = gst_player_media_info_get_container_format(cast[ptr PlayerMediaInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_player_media_info_get_duration(self: ptr PlayerMediaInfo00): uint64 {.
    importc, libprag.}

proc getDuration*(self: PlayerMediaInfo): uint64 =
  gst_player_media_info_get_duration(cast[ptr PlayerMediaInfo00](self.impl))

proc duration*(self: PlayerMediaInfo): uint64 =
  gst_player_media_info_get_duration(cast[ptr PlayerMediaInfo00](self.impl))

proc gst_player_media_info_get_image_sample(self: ptr PlayerMediaInfo00): ptr gst.Sample00 {.
    importc, libprag.}

proc getImageSample*(self: PlayerMediaInfo): gst.Sample =
  let impl0 = gst_player_media_info_get_image_sample(cast[ptr PlayerMediaInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstSample)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_sample_get_type(), impl0))

proc imageSample*(self: PlayerMediaInfo): gst.Sample =
  let impl0 = gst_player_media_info_get_image_sample(cast[ptr PlayerMediaInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstSample)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_sample_get_type(), impl0))

proc gst_player_media_info_get_number_of_audio_streams(self: ptr PlayerMediaInfo00): uint32 {.
    importc, libprag.}

proc getNumberOfAudioStreams*(self: PlayerMediaInfo): int =
  int(gst_player_media_info_get_number_of_audio_streams(cast[ptr PlayerMediaInfo00](self.impl)))

proc numberOfAudioStreams*(self: PlayerMediaInfo): int =
  int(gst_player_media_info_get_number_of_audio_streams(cast[ptr PlayerMediaInfo00](self.impl)))

proc gst_player_media_info_get_number_of_streams(self: ptr PlayerMediaInfo00): uint32 {.
    importc, libprag.}

proc getNumberOfStreams*(self: PlayerMediaInfo): int =
  int(gst_player_media_info_get_number_of_streams(cast[ptr PlayerMediaInfo00](self.impl)))

proc numberOfStreams*(self: PlayerMediaInfo): int =
  int(gst_player_media_info_get_number_of_streams(cast[ptr PlayerMediaInfo00](self.impl)))

proc gst_player_media_info_get_number_of_subtitle_streams(self: ptr PlayerMediaInfo00): uint32 {.
    importc, libprag.}

proc getNumberOfSubtitleStreams*(self: PlayerMediaInfo): int =
  int(gst_player_media_info_get_number_of_subtitle_streams(cast[ptr PlayerMediaInfo00](self.impl)))

proc numberOfSubtitleStreams*(self: PlayerMediaInfo): int =
  int(gst_player_media_info_get_number_of_subtitle_streams(cast[ptr PlayerMediaInfo00](self.impl)))

proc gst_player_media_info_get_number_of_video_streams(self: ptr PlayerMediaInfo00): uint32 {.
    importc, libprag.}

proc getNumberOfVideoStreams*(self: PlayerMediaInfo): int =
  int(gst_player_media_info_get_number_of_video_streams(cast[ptr PlayerMediaInfo00](self.impl)))

proc numberOfVideoStreams*(self: PlayerMediaInfo): int =
  int(gst_player_media_info_get_number_of_video_streams(cast[ptr PlayerMediaInfo00](self.impl)))

proc gst_player_media_info_get_tags(self: ptr PlayerMediaInfo00): ptr gst.TagList00 {.
    importc, libprag.}

proc getTags*(self: PlayerMediaInfo): gst.TagList =
  let impl0 = gst_player_media_info_get_tags(cast[ptr PlayerMediaInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), impl0))

proc tags*(self: PlayerMediaInfo): gst.TagList =
  let impl0 = gst_player_media_info_get_tags(cast[ptr PlayerMediaInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), impl0))

proc gst_player_media_info_get_title(self: ptr PlayerMediaInfo00): cstring {.
    importc, libprag.}

proc getTitle*(self: PlayerMediaInfo): string =
  let resul0 = gst_player_media_info_get_title(cast[ptr PlayerMediaInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc title*(self: PlayerMediaInfo): string =
  let resul0 = gst_player_media_info_get_title(cast[ptr PlayerMediaInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_player_media_info_get_uri(self: ptr PlayerMediaInfo00): cstring {.
    importc, libprag.}

proc getUri*(self: PlayerMediaInfo): string =
  result = $gst_player_media_info_get_uri(cast[ptr PlayerMediaInfo00](self.impl))

proc uri*(self: PlayerMediaInfo): string =
  result = $gst_player_media_info_get_uri(cast[ptr PlayerMediaInfo00](self.impl))

proc gst_player_media_info_is_live(self: ptr PlayerMediaInfo00): gboolean {.
    importc, libprag.}

proc isLive*(self: PlayerMediaInfo): bool =
  toBool(gst_player_media_info_is_live(cast[ptr PlayerMediaInfo00](self.impl)))

proc gst_player_media_info_is_seekable(self: ptr PlayerMediaInfo00): gboolean {.
    importc, libprag.}

proc isSeekable*(self: PlayerMediaInfo): bool =
  toBool(gst_player_media_info_is_seekable(cast[ptr PlayerMediaInfo00](self.impl)))

type
  PlayerState* {.size: sizeof(cint), pure.} = enum
    stopped = 0
    buffering = 1
    paused = 2
    playing = 3

proc gst_player_state_get_name(state: PlayerState): cstring {.
    importc, libprag.}

proc getName*(state: PlayerState): string =
  result = $gst_player_state_get_name(state)

proc name*(state: PlayerState): string =
  result = $gst_player_state_get_name(state)

type
  Player* = ref object of gst.Object
  Player00* = object of gst.Object00

proc gst_player_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Player()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scBuffering*(self: Player;  p: proc (self: ptr Player00; obj: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "buffering", cast[GCallback](p), xdata, nil, cf)

proc scDurationChanged*(self: Player;  p: proc (self: ptr Player00; obj: uint64; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "duration-changed", cast[GCallback](p), xdata, nil, cf)

proc scEndOfStream*(self: Player;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "end-of-stream", cast[GCallback](p), xdata, nil, cf)

proc scError*(self: Player;  p: proc (self: ptr Player00; obj: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "error", cast[GCallback](p), xdata, nil, cf)

proc scMediaInfoUpdated*(self: Player;  p: proc (self: ptr Player00; obj: ptr PlayerMediaInfo00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "media-info-updated", cast[GCallback](p), xdata, nil, cf)

proc scMuteChanged*(self: Player;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "mute-changed", cast[GCallback](p), xdata, nil, cf)

proc scPositionUpdated*(self: Player;  p: proc (self: ptr Player00; obj: uint64; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "position-updated", cast[GCallback](p), xdata, nil, cf)

proc scSeekDone*(self: Player;  p: proc (self: ptr Player00; obj: uint64; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "seek-done", cast[GCallback](p), xdata, nil, cf)

proc scStateChanged*(self: Player;  p: proc (self: ptr Player00; obj: PlayerState; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "state-changed", cast[GCallback](p), xdata, nil, cf)

proc scUriLoaded*(self: Player;  p: proc (self: ptr Player00; obj: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "uri-loaded", cast[GCallback](p), xdata, nil, cf)

proc scVideoDimensionsChanged*(self: Player;  p: proc (self: ptr Player00; obj: int32; p0: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "video-dimensions-changed", cast[GCallback](p), xdata, nil, cf)

proc scVolumeChanged*(self: Player;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "volume-changed", cast[GCallback](p), xdata, nil, cf)

proc scWarning*(self: Player;  p: proc (self: ptr Player00; obj: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "warning", cast[GCallback](p), xdata, nil, cf)

proc gst_player_config_get_position_update_interval(config: ptr gst.Structure00): uint32 {.
    importc, libprag.}

proc configGetPositionUpdateInterval*(config: gst.Structure): int =
  int(gst_player_config_get_position_update_interval(cast[ptr gst.Structure00](config.impl)))

proc gst_player_config_get_seek_accurate(config: ptr gst.Structure00): gboolean {.
    importc, libprag.}

proc configGetSeekAccurate*(config: gst.Structure): bool =
  toBool(gst_player_config_get_seek_accurate(cast[ptr gst.Structure00](config.impl)))

proc gst_player_config_get_user_agent(config: ptr gst.Structure00): cstring {.
    importc, libprag.}

proc configGetUserAgent*(config: gst.Structure): string =
  let resul0 = gst_player_config_get_user_agent(cast[ptr gst.Structure00](config.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_player_config_set_position_update_interval(config: ptr gst.Structure00;
    interval: uint32) {.
    importc, libprag.}

proc configSetPositionUpdateInterval*(config: gst.Structure;
    interval: int) =
  gst_player_config_set_position_update_interval(cast[ptr gst.Structure00](config.impl), uint32(interval))

proc gst_player_config_set_seek_accurate(config: ptr gst.Structure00; accurate: gboolean) {.
    importc, libprag.}

proc configSetSeekAccurate*(config: gst.Structure; accurate: bool) =
  gst_player_config_set_seek_accurate(cast[ptr gst.Structure00](config.impl), gboolean(accurate))

proc gst_player_config_set_user_agent(config: ptr gst.Structure00; agent: cstring) {.
    importc, libprag.}

proc configSetUserAgent*(config: gst.Structure; agent: cstring = nil) =
  gst_player_config_set_user_agent(cast[ptr gst.Structure00](config.impl), agent)

proc gst_player_get_audio_video_offset(self: ptr Player00): int64 {.
    importc, libprag.}

proc getAudioVideoOffset*(self: Player): int64 =
  gst_player_get_audio_video_offset(cast[ptr Player00](self.impl))

proc audioVideoOffset*(self: Player): int64 =
  gst_player_get_audio_video_offset(cast[ptr Player00](self.impl))

proc gst_player_get_config(self: ptr Player00): ptr gst.Structure00 {.
    importc, libprag.}

proc getConfig*(self: Player): gst.Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_player_get_config(cast[ptr Player00](self.impl))

proc config*(self: Player): gst.Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_player_get_config(cast[ptr Player00](self.impl))

proc gst_player_get_current_visualization(self: ptr Player00): cstring {.
    importc, libprag.}

proc getCurrentVisualization*(self: Player): string =
  let resul0 = gst_player_get_current_visualization(cast[ptr Player00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc currentVisualization*(self: Player): string =
  let resul0 = gst_player_get_current_visualization(cast[ptr Player00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_player_get_duration(self: ptr Player00): uint64 {.
    importc, libprag.}

proc getDuration*(self: Player): uint64 =
  gst_player_get_duration(cast[ptr Player00](self.impl))

proc duration*(self: Player): uint64 =
  gst_player_get_duration(cast[ptr Player00](self.impl))

proc gst_player_get_media_info(self: ptr Player00): ptr PlayerMediaInfo00 {.
    importc, libprag.}

proc getMediaInfo*(self: Player): PlayerMediaInfo =
  let gobj = gst_player_get_media_info(cast[ptr Player00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc mediaInfo*(self: Player): PlayerMediaInfo =
  let gobj = gst_player_get_media_info(cast[ptr Player00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_player_get_multiview_flags(self: ptr Player00): gstvideo.VideoMultiviewFlags {.
    importc, libprag.}

proc getMultiviewFlags*(self: Player): gstvideo.VideoMultiviewFlags =
  gst_player_get_multiview_flags(cast[ptr Player00](self.impl))

proc multiviewFlags*(self: Player): gstvideo.VideoMultiviewFlags =
  gst_player_get_multiview_flags(cast[ptr Player00](self.impl))

proc gst_player_get_multiview_mode(self: ptr Player00): gstvideo.VideoMultiviewFramePacking {.
    importc, libprag.}

proc getMultiviewMode*(self: Player): gstvideo.VideoMultiviewFramePacking =
  gst_player_get_multiview_mode(cast[ptr Player00](self.impl))

proc multiviewMode*(self: Player): gstvideo.VideoMultiviewFramePacking =
  gst_player_get_multiview_mode(cast[ptr Player00](self.impl))

proc gst_player_get_mute(self: ptr Player00): gboolean {.
    importc, libprag.}

proc getMute*(self: Player): bool =
  toBool(gst_player_get_mute(cast[ptr Player00](self.impl)))

proc mute*(self: Player): bool =
  toBool(gst_player_get_mute(cast[ptr Player00](self.impl)))

proc gst_player_get_pipeline(self: ptr Player00): ptr gst.Element00 {.
    importc, libprag.}

proc getPipeline*(self: Player): gst.Element =
  let gobj = gst_player_get_pipeline(cast[ptr Player00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pipeline*(self: Player): gst.Element =
  let gobj = gst_player_get_pipeline(cast[ptr Player00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_player_get_position(self: ptr Player00): uint64 {.
    importc, libprag.}

proc getPosition*(self: Player): uint64 =
  gst_player_get_position(cast[ptr Player00](self.impl))

proc position*(self: Player): uint64 =
  gst_player_get_position(cast[ptr Player00](self.impl))

proc gst_player_get_rate(self: ptr Player00): cdouble {.
    importc, libprag.}

proc getRate*(self: Player): cdouble =
  gst_player_get_rate(cast[ptr Player00](self.impl))

proc rate*(self: Player): cdouble =
  gst_player_get_rate(cast[ptr Player00](self.impl))

proc gst_player_get_subtitle_uri(self: ptr Player00): cstring {.
    importc, libprag.}

proc getSubtitleUri*(self: Player): string =
  let resul0 = gst_player_get_subtitle_uri(cast[ptr Player00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc subtitleUri*(self: Player): string =
  let resul0 = gst_player_get_subtitle_uri(cast[ptr Player00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_player_get_subtitle_video_offset(self: ptr Player00): int64 {.
    importc, libprag.}

proc getSubtitleVideoOffset*(self: Player): int64 =
  gst_player_get_subtitle_video_offset(cast[ptr Player00](self.impl))

proc subtitleVideoOffset*(self: Player): int64 =
  gst_player_get_subtitle_video_offset(cast[ptr Player00](self.impl))

proc gst_player_get_uri(self: ptr Player00): cstring {.
    importc, libprag.}

proc getUri*(self: Player): string =
  let resul0 = gst_player_get_uri(cast[ptr Player00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc uri*(self: Player): string =
  let resul0 = gst_player_get_uri(cast[ptr Player00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_player_get_volume(self: ptr Player00): cdouble {.
    importc, libprag.}

proc getVolume*(self: Player): cdouble =
  gst_player_get_volume(cast[ptr Player00](self.impl))

proc volume*(self: Player): cdouble =
  gst_player_get_volume(cast[ptr Player00](self.impl))

proc gst_player_has_color_balance(self: ptr Player00): gboolean {.
    importc, libprag.}

proc hasColorBalance*(self: Player): bool =
  toBool(gst_player_has_color_balance(cast[ptr Player00](self.impl)))

proc gst_player_pause(self: ptr Player00) {.
    importc, libprag.}

proc pause*(self: Player) =
  gst_player_pause(cast[ptr Player00](self.impl))

proc gst_player_play(self: ptr Player00) {.
    importc, libprag.}

proc play*(self: Player) =
  gst_player_play(cast[ptr Player00](self.impl))

proc gst_player_seek(self: ptr Player00; position: uint64) {.
    importc, libprag.}

proc seek*(self: Player; position: uint64) =
  gst_player_seek(cast[ptr Player00](self.impl), position)

proc gst_player_set_audio_track(self: ptr Player00; streamIndex: int32): gboolean {.
    importc, libprag.}

proc setAudioTrack*(self: Player; streamIndex: int): bool =
  toBool(gst_player_set_audio_track(cast[ptr Player00](self.impl), int32(streamIndex)))

proc gst_player_set_audio_track_enabled(self: ptr Player00; enabled: gboolean) {.
    importc, libprag.}

proc setAudioTrackEnabled*(self: Player; enabled: bool = true) =
  gst_player_set_audio_track_enabled(cast[ptr Player00](self.impl), gboolean(enabled))

proc `audioTrackEnabled=`*(self: Player; enabled: bool) =
  gst_player_set_audio_track_enabled(cast[ptr Player00](self.impl), gboolean(enabled))

proc gst_player_set_audio_video_offset(self: ptr Player00; offset: int64) {.
    importc, libprag.}

proc setAudioVideoOffset*(self: Player; offset: int64) =
  gst_player_set_audio_video_offset(cast[ptr Player00](self.impl), offset)

proc `audioVideoOffset=`*(self: Player; offset: int64) =
  gst_player_set_audio_video_offset(cast[ptr Player00](self.impl), offset)

proc gst_player_set_config(self: ptr Player00; config: ptr gst.Structure00): gboolean {.
    importc, libprag.}

proc setConfig*(self: Player; config: gst.Structure): bool =
  toBool(gst_player_set_config(cast[ptr Player00](self.impl), cast[ptr gst.Structure00](g_boxed_copy(gst_structure_get_type(), config.impl))))

proc gst_player_set_multiview_flags(self: ptr Player00; flags: gstvideo.VideoMultiviewFlags) {.
    importc, libprag.}

proc setMultiviewFlags*(self: Player; flags: gstvideo.VideoMultiviewFlags) =
  gst_player_set_multiview_flags(cast[ptr Player00](self.impl), flags)

proc `multiviewFlags=`*(self: Player; flags: gstvideo.VideoMultiviewFlags) =
  gst_player_set_multiview_flags(cast[ptr Player00](self.impl), flags)

proc gst_player_set_multiview_mode(self: ptr Player00; mode: gstvideo.VideoMultiviewFramePacking) {.
    importc, libprag.}

proc setMultiviewMode*(self: Player; mode: gstvideo.VideoMultiviewFramePacking) =
  gst_player_set_multiview_mode(cast[ptr Player00](self.impl), mode)

proc `multiviewMode=`*(self: Player; mode: gstvideo.VideoMultiviewFramePacking) =
  gst_player_set_multiview_mode(cast[ptr Player00](self.impl), mode)

proc gst_player_set_mute(self: ptr Player00; val: gboolean) {.
    importc, libprag.}

proc setMute*(self: Player; val: bool = true) =
  gst_player_set_mute(cast[ptr Player00](self.impl), gboolean(val))

proc `mute=`*(self: Player; val: bool) =
  gst_player_set_mute(cast[ptr Player00](self.impl), gboolean(val))

proc gst_player_set_rate(self: ptr Player00; rate: cdouble) {.
    importc, libprag.}

proc setRate*(self: Player; rate: cdouble) =
  gst_player_set_rate(cast[ptr Player00](self.impl), rate)

proc `rate=`*(self: Player; rate: cdouble) =
  gst_player_set_rate(cast[ptr Player00](self.impl), rate)

proc gst_player_set_subtitle_track(self: ptr Player00; streamIndex: int32): gboolean {.
    importc, libprag.}

proc setSubtitleTrack*(self: Player; streamIndex: int): bool =
  toBool(gst_player_set_subtitle_track(cast[ptr Player00](self.impl), int32(streamIndex)))

proc gst_player_set_subtitle_track_enabled(self: ptr Player00; enabled: gboolean) {.
    importc, libprag.}

proc setSubtitleTrackEnabled*(self: Player; enabled: bool = true) =
  gst_player_set_subtitle_track_enabled(cast[ptr Player00](self.impl), gboolean(enabled))

proc `subtitleTrackEnabled=`*(self: Player; enabled: bool) =
  gst_player_set_subtitle_track_enabled(cast[ptr Player00](self.impl), gboolean(enabled))

proc gst_player_set_subtitle_uri(self: ptr Player00; uri: cstring) {.
    importc, libprag.}

proc setSubtitleUri*(self: Player; uri: cstring = nil) =
  gst_player_set_subtitle_uri(cast[ptr Player00](self.impl), uri)

proc `subtitleUri=`*(self: Player; uri: cstring = nil) =
  gst_player_set_subtitle_uri(cast[ptr Player00](self.impl), uri)

proc gst_player_set_subtitle_video_offset(self: ptr Player00; offset: int64) {.
    importc, libprag.}

proc setSubtitleVideoOffset*(self: Player; offset: int64) =
  gst_player_set_subtitle_video_offset(cast[ptr Player00](self.impl), offset)

proc `subtitleVideoOffset=`*(self: Player; offset: int64) =
  gst_player_set_subtitle_video_offset(cast[ptr Player00](self.impl), offset)

proc gst_player_set_uri(self: ptr Player00; uri: cstring) {.
    importc, libprag.}

proc setUri*(self: Player; uri: cstring = nil) =
  gst_player_set_uri(cast[ptr Player00](self.impl), uri)

proc `uri=`*(self: Player; uri: cstring = nil) =
  gst_player_set_uri(cast[ptr Player00](self.impl), uri)

proc gst_player_set_video_track(self: ptr Player00; streamIndex: int32): gboolean {.
    importc, libprag.}

proc setVideoTrack*(self: Player; streamIndex: int): bool =
  toBool(gst_player_set_video_track(cast[ptr Player00](self.impl), int32(streamIndex)))

proc gst_player_set_video_track_enabled(self: ptr Player00; enabled: gboolean) {.
    importc, libprag.}

proc setVideoTrackEnabled*(self: Player; enabled: bool = true) =
  gst_player_set_video_track_enabled(cast[ptr Player00](self.impl), gboolean(enabled))

proc `videoTrackEnabled=`*(self: Player; enabled: bool) =
  gst_player_set_video_track_enabled(cast[ptr Player00](self.impl), gboolean(enabled))

proc gst_player_set_visualization(self: ptr Player00; name: cstring): gboolean {.
    importc, libprag.}

proc setVisualization*(self: Player; name: cstring = nil): bool =
  toBool(gst_player_set_visualization(cast[ptr Player00](self.impl), name))

proc gst_player_set_visualization_enabled(self: ptr Player00; enabled: gboolean) {.
    importc, libprag.}

proc setVisualizationEnabled*(self: Player; enabled: bool = true) =
  gst_player_set_visualization_enabled(cast[ptr Player00](self.impl), gboolean(enabled))

proc `visualizationEnabled=`*(self: Player; enabled: bool) =
  gst_player_set_visualization_enabled(cast[ptr Player00](self.impl), gboolean(enabled))

proc gst_player_set_volume(self: ptr Player00; val: cdouble) {.
    importc, libprag.}

proc setVolume*(self: Player; val: cdouble) =
  gst_player_set_volume(cast[ptr Player00](self.impl), val)

proc `volume=`*(self: Player; val: cdouble) =
  gst_player_set_volume(cast[ptr Player00](self.impl), val)

proc gst_player_stop(self: ptr Player00) {.
    importc, libprag.}

proc stop*(self: Player) =
  gst_player_stop(cast[ptr Player00](self.impl))

type
  PlayerVideoRenderer00* = object of gobject.Object00
  PlayerVideoRenderer* = ref object of gobject.Object

type
  PlayerSignalDispatcher00* = object of gobject.Object00
  PlayerSignalDispatcher* = ref object of gobject.Object

type
  PlayerVideoOverlayVideoRenderer* = ref object of gobject.Object
  PlayerVideoOverlayVideoRenderer00* = object of gobject.Object00

proc gst_player_video_overlay_video_renderer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PlayerVideoOverlayVideoRenderer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_player_video_overlay_video_renderer_new(windowHandle: pointer): ptr PlayerVideoRenderer00 {.
    importc, libprag.}

proc newPlayerVideoOverlayVideoRenderer*(windowHandle: pointer): PlayerVideoRenderer =
  let gobj = gst_player_video_overlay_video_renderer_new(windowHandle)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_player_video_overlay_video_renderer_new_with_sink(windowHandle: pointer;
    videoSink: ptr gst.Element00): ptr PlayerVideoRenderer00 {.
    importc, libprag.}

proc newPlayerVideoOverlayVideoRendererWithSink*(windowHandle: pointer;
    videoSink: gst.Element): PlayerVideoRenderer =
  let gobj = gst_player_video_overlay_video_renderer_new_with_sink(windowHandle, cast[ptr gst.Element00](videoSink.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_player_video_overlay_video_renderer_expose(self: ptr PlayerVideoOverlayVideoRenderer00) {.
    importc, libprag.}

proc expose*(self: PlayerVideoOverlayVideoRenderer) =
  gst_player_video_overlay_video_renderer_expose(cast[ptr PlayerVideoOverlayVideoRenderer00](self.impl))

proc gst_player_video_overlay_video_renderer_get_render_rectangle(self: ptr PlayerVideoOverlayVideoRenderer00;
    x: var int32; y: var int32; width: var int32; height: var int32) {.
    importc, libprag.}

proc getRenderRectangle*(self: PlayerVideoOverlayVideoRenderer;
    x: var int = cast[var int](nil); y: var int = cast[var int](nil); width: var int = cast[var int](nil);
    height: var int = cast[var int](nil)) =
  var width_00: int32
  var y_00: int32
  var x_00: int32
  var height_00: int32
  gst_player_video_overlay_video_renderer_get_render_rectangle(cast[ptr PlayerVideoOverlayVideoRenderer00](self.impl), x_00, y_00, width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)
  if height.addr != nil:
    height = int(height_00)

proc gst_player_video_overlay_video_renderer_get_window_handle(self: ptr PlayerVideoOverlayVideoRenderer00): pointer {.
    importc, libprag.}

proc getWindowHandle*(self: PlayerVideoOverlayVideoRenderer): pointer =
  gst_player_video_overlay_video_renderer_get_window_handle(cast[ptr PlayerVideoOverlayVideoRenderer00](self.impl))

proc gst_player_video_overlay_video_renderer_set_render_rectangle(self: ptr PlayerVideoOverlayVideoRenderer00;
    x: int32; y: int32; width: int32; height: int32) {.
    importc, libprag.}

proc setRenderRectangle*(self: PlayerVideoOverlayVideoRenderer;
    x: int; y: int; width: int; height: int) =
  gst_player_video_overlay_video_renderer_set_render_rectangle(cast[ptr PlayerVideoOverlayVideoRenderer00](self.impl), int32(x), int32(y), int32(width), int32(height))

proc gst_player_video_overlay_video_renderer_set_window_handle(self: ptr PlayerVideoOverlayVideoRenderer00;
    windowHandle: pointer) {.
    importc, libprag.}

proc setWindowHandle*(self: PlayerVideoOverlayVideoRenderer;
    windowHandle: pointer) =
  gst_player_video_overlay_video_renderer_set_window_handle(cast[ptr PlayerVideoOverlayVideoRenderer00](self.impl), windowHandle)

proc `windowHandle=`*(self: PlayerVideoOverlayVideoRenderer;
    windowHandle: pointer) =
  gst_player_video_overlay_video_renderer_set_window_handle(cast[ptr PlayerVideoOverlayVideoRenderer00](self.impl), windowHandle)

type
  PlayerGMainContextSignalDispatcher* = ref object of gobject.Object
  PlayerGMainContextSignalDispatcher00* = object of gobject.Object00

proc gst_player_g_main_context_signal_dispatcher_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PlayerGMainContextSignalDispatcher()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_player_g_main_context_signal_dispatcher_new(applicationContext: ptr glib.MainContext00): ptr PlayerSignalDispatcher00 {.
    importc, libprag.}

proc newPlayerGMainContextSignalDispatcher*(applicationContext: glib.MainContext = nil): PlayerSignalDispatcher =
  let gobj = gst_player_g_main_context_signal_dispatcher_new(if applicationContext.isNil: nil else: cast[ptr glib.MainContext00](applicationContext.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_player_new(videoRenderer: ptr PlayerVideoRenderer00; signalDispatcher: ptr PlayerSignalDispatcher00): ptr Player00 {.
    importc, libprag.}

proc newPlayer*(videoRenderer: PlayerVideoRenderer | PlayerVideoOverlayVideoRenderer = PlayerVideoRenderer(nil);
    signalDispatcher: PlayerSignalDispatcher | PlayerGMainContextSignalDispatcher = PlayerSignalDispatcher(nil)): Player =
  let gobj = gst_player_new(if videoRenderer.isNil: nil else: cast[ptr PlayerVideoRenderer00](g_object_ref(videoRenderer.impl)), if signalDispatcher.isNil: nil else: cast[ptr PlayerSignalDispatcher00](g_object_ref(signalDispatcher.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPlayer*(tdesc: typedesc; videoRenderer: PlayerVideoRenderer | PlayerVideoOverlayVideoRenderer = PlayerVideoRenderer(nil);
    signalDispatcher: PlayerSignalDispatcher | PlayerGMainContextSignalDispatcher = PlayerSignalDispatcher(nil)): tdesc =
  assert(result is Player)
  let gobj = gst_player_new(if videoRenderer.isNil: nil else: cast[ptr PlayerVideoRenderer00](g_object_ref(videoRenderer.impl)), if signalDispatcher.isNil: nil else: cast[ptr PlayerSignalDispatcher00](g_object_ref(signalDispatcher.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPlayer*[T](result: var T; videoRenderer: PlayerVideoRenderer | PlayerVideoOverlayVideoRenderer = PlayerVideoRenderer(nil);
    signalDispatcher: PlayerSignalDispatcher | PlayerGMainContextSignalDispatcher = PlayerSignalDispatcher(nil)) {.deprecated.} =
  assert(result is Player)
  let gobj = gst_player_new(if videoRenderer.isNil: nil else: cast[ptr PlayerVideoRenderer00](g_object_ref(videoRenderer.impl)), if signalDispatcher.isNil: nil else: cast[ptr PlayerSignalDispatcher00](g_object_ref(signalDispatcher.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PlayerVisualization00* {.pure.} = object
  PlayerVisualization* = ref object
    impl*: ptr PlayerVisualization00
    ignoreFinalizer*: bool

proc gst_player_visualization_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstPlayerVisualization*(self: PlayerVisualization) =
  if not self.ignoreFinalizer:
    boxedFree(gst_player_visualization_get_type(), cast[ptr PlayerVisualization00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PlayerVisualization()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_player_visualization_get_type(), cast[ptr PlayerVisualization00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PlayerVisualization) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstPlayerVisualization)

proc gst_player_visualization_free(self: ptr PlayerVisualization00) {.
    importc, libprag.}

proc free*(self: PlayerVisualization) =
  gst_player_visualization_free(cast[ptr PlayerVisualization00](self.impl))

proc finalizerfree*(self: PlayerVisualization) =
  if not self.ignoreFinalizer:
    gst_player_visualization_free(cast[ptr PlayerVisualization00](self.impl))

proc gst_player_visualization_copy(self: ptr PlayerVisualization00): ptr PlayerVisualization00 {.
    importc, libprag.}

proc copy*(self: PlayerVisualization): PlayerVisualization =
  fnew(result, gBoxedFreeGstPlayerVisualization)
  result.impl = gst_player_visualization_copy(cast[ptr PlayerVisualization00](self.impl))

proc gst_player_visualizations_free(viss: ptr PlayerVisualization00) {.
    importc, libprag.}

proc visualizationsFree*(viss: PlayerVisualization) =
  gst_player_visualizations_free(cast[ptr PlayerVisualization00](viss.impl))

proc visualizationsGet*(): ptr PlayerVisualization00 {.
    importc: "gst_player_visualizations_get", libprag.}

type
  PlayerSnapshotFormat* {.size: sizeof(cint), pure.} = enum
    rawNative = 0
    rawXrgb = 1
    rawBgrx = 2
    jpg = 3
    png = 4

proc gst_player_get_video_snapshot(self: ptr Player00; format: PlayerSnapshotFormat;
    config: ptr gst.Structure00): ptr gst.Sample00 {.
    importc, libprag.}

proc getVideoSnapshot*(self: Player; format: PlayerSnapshotFormat;
    config: gst.Structure = nil): gst.Sample =
  let impl0 = gst_player_get_video_snapshot(cast[ptr Player00](self.impl), format, if config.isNil: nil else: cast[ptr gst.Structure00](config.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstSample)
  result.impl = impl0

type
  PlayerColorBalanceType* {.size: sizeof(cint), pure.} = enum
    brightness = 0
    contrast = 1
    saturation = 2
    hue = 3

proc gst_player_color_balance_type_get_name(`type`: PlayerColorBalanceType): cstring {.
    importc, libprag.}

proc getName*(`type`: PlayerColorBalanceType): string =
  result = $gst_player_color_balance_type_get_name(`type`)

proc name*(`type`: PlayerColorBalanceType): string =
  result = $gst_player_color_balance_type_get_name(`type`)

proc gst_player_get_color_balance(self: ptr Player00; `type`: PlayerColorBalanceType): cdouble {.
    importc, libprag.}

proc getColorBalance*(self: Player; `type`: PlayerColorBalanceType): cdouble =
  gst_player_get_color_balance(cast[ptr Player00](self.impl), `type`)

proc gst_player_set_color_balance(self: ptr Player00; `type`: PlayerColorBalanceType;
    value: cdouble) {.
    importc, libprag.}

proc setColorBalance*(self: Player; `type`: PlayerColorBalanceType;
    value: cdouble) =
  gst_player_set_color_balance(cast[ptr Player00](self.impl), `type`, value)

type
  PlayerStreamInfo* = ref object of gobject.Object
  PlayerStreamInfo00* = object of gobject.Object00

proc gst_player_stream_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PlayerStreamInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_player_stream_info_get_caps(self: ptr PlayerStreamInfo00): ptr gst.Caps00 {.
    importc, libprag.}

proc getCaps*(self: PlayerStreamInfo): gst.Caps =
  let impl0 = gst_player_stream_info_get_caps(cast[ptr PlayerStreamInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_caps_get_type(), impl0))

proc caps*(self: PlayerStreamInfo): gst.Caps =
  let impl0 = gst_player_stream_info_get_caps(cast[ptr PlayerStreamInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_caps_get_type(), impl0))

proc gst_player_stream_info_get_codec(self: ptr PlayerStreamInfo00): cstring {.
    importc, libprag.}

proc getCodec*(self: PlayerStreamInfo): string =
  let resul0 = gst_player_stream_info_get_codec(cast[ptr PlayerStreamInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc codec*(self: PlayerStreamInfo): string =
  let resul0 = gst_player_stream_info_get_codec(cast[ptr PlayerStreamInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_player_stream_info_get_index(self: ptr PlayerStreamInfo00): int32 {.
    importc, libprag.}

proc getIndex*(self: PlayerStreamInfo): int =
  int(gst_player_stream_info_get_index(cast[ptr PlayerStreamInfo00](self.impl)))

proc index*(self: PlayerStreamInfo): int =
  int(gst_player_stream_info_get_index(cast[ptr PlayerStreamInfo00](self.impl)))

proc gst_player_stream_info_get_stream_type(self: ptr PlayerStreamInfo00): cstring {.
    importc, libprag.}

proc getStreamType*(self: PlayerStreamInfo): string =
  result = $gst_player_stream_info_get_stream_type(cast[ptr PlayerStreamInfo00](self.impl))

proc streamType*(self: PlayerStreamInfo): string =
  result = $gst_player_stream_info_get_stream_type(cast[ptr PlayerStreamInfo00](self.impl))

proc gst_player_stream_info_get_tags(self: ptr PlayerStreamInfo00): ptr gst.TagList00 {.
    importc, libprag.}

proc getTags*(self: PlayerStreamInfo): gst.TagList =
  let impl0 = gst_player_stream_info_get_tags(cast[ptr PlayerStreamInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), impl0))

proc tags*(self: PlayerStreamInfo): gst.TagList =
  let impl0 = gst_player_stream_info_get_tags(cast[ptr PlayerStreamInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), impl0))

type
  PlayerAudioInfo* = ref object of PlayerStreamInfo
  PlayerAudioInfo00* = object of PlayerStreamInfo00

proc gst_player_audio_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PlayerAudioInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_player_audio_info_get_bitrate(self: ptr PlayerAudioInfo00): int32 {.
    importc, libprag.}

proc getBitrate*(self: PlayerAudioInfo): int =
  int(gst_player_audio_info_get_bitrate(cast[ptr PlayerAudioInfo00](self.impl)))

proc bitrate*(self: PlayerAudioInfo): int =
  int(gst_player_audio_info_get_bitrate(cast[ptr PlayerAudioInfo00](self.impl)))

proc gst_player_audio_info_get_channels(self: ptr PlayerAudioInfo00): int32 {.
    importc, libprag.}

proc getChannels*(self: PlayerAudioInfo): int =
  int(gst_player_audio_info_get_channels(cast[ptr PlayerAudioInfo00](self.impl)))

proc channels*(self: PlayerAudioInfo): int =
  int(gst_player_audio_info_get_channels(cast[ptr PlayerAudioInfo00](self.impl)))

proc gst_player_audio_info_get_language(self: ptr PlayerAudioInfo00): cstring {.
    importc, libprag.}

proc getLanguage*(self: PlayerAudioInfo): string =
  let resul0 = gst_player_audio_info_get_language(cast[ptr PlayerAudioInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc language*(self: PlayerAudioInfo): string =
  let resul0 = gst_player_audio_info_get_language(cast[ptr PlayerAudioInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_player_audio_info_get_max_bitrate(self: ptr PlayerAudioInfo00): int32 {.
    importc, libprag.}

proc getMaxBitrate*(self: PlayerAudioInfo): int =
  int(gst_player_audio_info_get_max_bitrate(cast[ptr PlayerAudioInfo00](self.impl)))

proc maxBitrate*(self: PlayerAudioInfo): int =
  int(gst_player_audio_info_get_max_bitrate(cast[ptr PlayerAudioInfo00](self.impl)))

proc gst_player_audio_info_get_sample_rate(self: ptr PlayerAudioInfo00): int32 {.
    importc, libprag.}

proc getSampleRate*(self: PlayerAudioInfo): int =
  int(gst_player_audio_info_get_sample_rate(cast[ptr PlayerAudioInfo00](self.impl)))

proc sampleRate*(self: PlayerAudioInfo): int =
  int(gst_player_audio_info_get_sample_rate(cast[ptr PlayerAudioInfo00](self.impl)))

proc gst_player_media_info_get_audio_streams(self: ptr PlayerMediaInfo00): ptr glib.List {.
    importc, libprag.}

proc getAudioStreams*(self: PlayerMediaInfo): seq[PlayerAudioInfo] =
  result = glistObjects2seq(PlayerAudioInfo, gst_player_media_info_get_audio_streams(cast[ptr PlayerMediaInfo00](self.impl)), false)

proc audioStreams*(self: PlayerMediaInfo): seq[PlayerAudioInfo] =
  result = glistObjects2seq(PlayerAudioInfo, gst_player_media_info_get_audio_streams(cast[ptr PlayerMediaInfo00](self.impl)), false)

proc gst_player_media_info_get_stream_list(self: ptr PlayerMediaInfo00): ptr glib.List {.
    importc, libprag.}

proc getStreamList*(self: PlayerMediaInfo): seq[PlayerStreamInfo] =
  result = glistObjects2seq(PlayerStreamInfo, gst_player_media_info_get_stream_list(cast[ptr PlayerMediaInfo00](self.impl)), false)

proc streamList*(self: PlayerMediaInfo): seq[PlayerStreamInfo] =
  result = glistObjects2seq(PlayerStreamInfo, gst_player_media_info_get_stream_list(cast[ptr PlayerMediaInfo00](self.impl)), false)

proc gst_player_get_audio_streams(info: ptr PlayerMediaInfo00): ptr glib.List {.
    importc, libprag.}

proc getAudioStreams*(info: PlayerMediaInfo): seq[PlayerAudioInfo] =
  result = glistObjects2seq(PlayerAudioInfo, gst_player_get_audio_streams(cast[ptr PlayerMediaInfo00](info.impl)), false)

proc audioStreams*(info: PlayerMediaInfo): seq[PlayerAudioInfo] =
  result = glistObjects2seq(PlayerAudioInfo, gst_player_get_audio_streams(cast[ptr PlayerMediaInfo00](info.impl)), false)

proc gst_player_get_current_audio_track(self: ptr Player00): ptr PlayerAudioInfo00 {.
    importc, libprag.}

proc getCurrentAudioTrack*(self: Player): PlayerAudioInfo =
  let gobj = gst_player_get_current_audio_track(cast[ptr Player00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentAudioTrack*(self: Player): PlayerAudioInfo =
  let gobj = gst_player_get_current_audio_track(cast[ptr Player00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PlayerSubtitleInfo* = ref object of PlayerStreamInfo
  PlayerSubtitleInfo00* = object of PlayerStreamInfo00

proc gst_player_subtitle_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PlayerSubtitleInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_player_subtitle_info_get_language(self: ptr PlayerSubtitleInfo00): cstring {.
    importc, libprag.}

proc getLanguage*(self: PlayerSubtitleInfo): string =
  let resul0 = gst_player_subtitle_info_get_language(cast[ptr PlayerSubtitleInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc language*(self: PlayerSubtitleInfo): string =
  let resul0 = gst_player_subtitle_info_get_language(cast[ptr PlayerSubtitleInfo00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_player_media_info_get_subtitle_streams(self: ptr PlayerMediaInfo00): ptr glib.List {.
    importc, libprag.}

proc getSubtitleStreams*(self: PlayerMediaInfo): seq[PlayerSubtitleInfo] =
  result = glistObjects2seq(PlayerSubtitleInfo, gst_player_media_info_get_subtitle_streams(cast[ptr PlayerMediaInfo00](self.impl)), false)

proc subtitleStreams*(self: PlayerMediaInfo): seq[PlayerSubtitleInfo] =
  result = glistObjects2seq(PlayerSubtitleInfo, gst_player_media_info_get_subtitle_streams(cast[ptr PlayerMediaInfo00](self.impl)), false)

proc gst_player_get_subtitle_streams(info: ptr PlayerMediaInfo00): ptr glib.List {.
    importc, libprag.}

proc getSubtitleStreams*(info: PlayerMediaInfo): seq[PlayerSubtitleInfo] =
  result = glistObjects2seq(PlayerSubtitleInfo, gst_player_get_subtitle_streams(cast[ptr PlayerMediaInfo00](info.impl)), false)

proc subtitleStreams*(info: PlayerMediaInfo): seq[PlayerSubtitleInfo] =
  result = glistObjects2seq(PlayerSubtitleInfo, gst_player_get_subtitle_streams(cast[ptr PlayerMediaInfo00](info.impl)), false)

proc gst_player_get_current_subtitle_track(self: ptr Player00): ptr PlayerSubtitleInfo00 {.
    importc, libprag.}

proc getCurrentSubtitleTrack*(self: Player): PlayerSubtitleInfo =
  let gobj = gst_player_get_current_subtitle_track(cast[ptr Player00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentSubtitleTrack*(self: Player): PlayerSubtitleInfo =
  let gobj = gst_player_get_current_subtitle_track(cast[ptr Player00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PlayerVideoInfo* = ref object of PlayerStreamInfo
  PlayerVideoInfo00* = object of PlayerStreamInfo00

proc gst_player_video_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PlayerVideoInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_player_video_info_get_bitrate(self: ptr PlayerVideoInfo00): int32 {.
    importc, libprag.}

proc getBitrate*(self: PlayerVideoInfo): int =
  int(gst_player_video_info_get_bitrate(cast[ptr PlayerVideoInfo00](self.impl)))

proc bitrate*(self: PlayerVideoInfo): int =
  int(gst_player_video_info_get_bitrate(cast[ptr PlayerVideoInfo00](self.impl)))

proc gst_player_video_info_get_framerate(self: ptr PlayerVideoInfo00; fpsN: var int32;
    fpsD: var int32) {.
    importc, libprag.}

proc getFramerate*(self: PlayerVideoInfo; fpsN: var int;
    fpsD: var int) =
  var fpsN_00: int32
  var fpsD_00: int32
  gst_player_video_info_get_framerate(cast[ptr PlayerVideoInfo00](self.impl), fpsN_00, fpsD_00)
  if fpsN.addr != nil:
    fpsN = int(fpsN_00)
  if fpsD.addr != nil:
    fpsD = int(fpsD_00)

proc gst_player_video_info_get_height(self: ptr PlayerVideoInfo00): int32 {.
    importc, libprag.}

proc getHeight*(self: PlayerVideoInfo): int =
  int(gst_player_video_info_get_height(cast[ptr PlayerVideoInfo00](self.impl)))

proc height*(self: PlayerVideoInfo): int =
  int(gst_player_video_info_get_height(cast[ptr PlayerVideoInfo00](self.impl)))

proc gst_player_video_info_get_max_bitrate(self: ptr PlayerVideoInfo00): int32 {.
    importc, libprag.}

proc getMaxBitrate*(self: PlayerVideoInfo): int =
  int(gst_player_video_info_get_max_bitrate(cast[ptr PlayerVideoInfo00](self.impl)))

proc maxBitrate*(self: PlayerVideoInfo): int =
  int(gst_player_video_info_get_max_bitrate(cast[ptr PlayerVideoInfo00](self.impl)))

proc gst_player_video_info_get_pixel_aspect_ratio(self: ptr PlayerVideoInfo00;
    parN: var uint32; parD: var uint32) {.
    importc, libprag.}

proc getPixelAspectRatio*(self: PlayerVideoInfo;
    parN: var int; parD: var int) =
  var parN_00: uint32
  var parD_00: uint32
  gst_player_video_info_get_pixel_aspect_ratio(cast[ptr PlayerVideoInfo00](self.impl), parN_00, parD_00)
  if parN.addr != nil:
    parN = int(parN_00)
  if parD.addr != nil:
    parD = int(parD_00)

proc gst_player_video_info_get_width(self: ptr PlayerVideoInfo00): int32 {.
    importc, libprag.}

proc getWidth*(self: PlayerVideoInfo): int =
  int(gst_player_video_info_get_width(cast[ptr PlayerVideoInfo00](self.impl)))

proc width*(self: PlayerVideoInfo): int =
  int(gst_player_video_info_get_width(cast[ptr PlayerVideoInfo00](self.impl)))

proc gst_player_media_info_get_video_streams(self: ptr PlayerMediaInfo00): ptr glib.List {.
    importc, libprag.}

proc getVideoStreams*(self: PlayerMediaInfo): seq[PlayerVideoInfo] =
  result = glistObjects2seq(PlayerVideoInfo, gst_player_media_info_get_video_streams(cast[ptr PlayerMediaInfo00](self.impl)), false)

proc videoStreams*(self: PlayerMediaInfo): seq[PlayerVideoInfo] =
  result = glistObjects2seq(PlayerVideoInfo, gst_player_media_info_get_video_streams(cast[ptr PlayerMediaInfo00](self.impl)), false)

proc gst_player_get_video_streams(info: ptr PlayerMediaInfo00): ptr glib.List {.
    importc, libprag.}

proc getVideoStreams*(info: PlayerMediaInfo): seq[PlayerVideoInfo] =
  result = glistObjects2seq(PlayerVideoInfo, gst_player_get_video_streams(cast[ptr PlayerMediaInfo00](info.impl)), false)

proc videoStreams*(info: PlayerMediaInfo): seq[PlayerVideoInfo] =
  result = glistObjects2seq(PlayerVideoInfo, gst_player_get_video_streams(cast[ptr PlayerMediaInfo00](info.impl)), false)

proc gst_player_get_current_video_track(self: ptr Player00): ptr PlayerVideoInfo00 {.
    importc, libprag.}

proc getCurrentVideoTrack*(self: Player): PlayerVideoInfo =
  let gobj = gst_player_get_current_video_track(cast[ptr Player00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentVideoTrack*(self: Player): PlayerVideoInfo =
  let gobj = gst_player_get_current_video_track(cast[ptr Player00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstplayer.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PlayerError* {.size: sizeof(cint), pure.} = enum
    failed = 0

proc gst_player_error_get_name(error: PlayerError): cstring {.
    importc, libprag.}

proc getName*(error: PlayerError): string =
  result = $gst_player_error_get_name(error)

proc name*(error: PlayerError): string =
  result = $gst_player_error_get_name(error)

type
  PlayerSignalDispatcherFunc* = proc (data: pointer) {.cdecl.}
# === remaining symbols:

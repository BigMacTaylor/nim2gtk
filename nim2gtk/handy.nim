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
# Gio-2.0
# libraries:
# libhandy-1.so.0
{.warning[UnusedImport]: off.}
import xlib, freetype2, glib, gdk, harfbuzz, gmodule, gtk, cairo, gobject, pango, gio, atk, gdkpixbuf
const Lib = "libhandy-1.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  PreferencesRow* = ref object of gtk.ListBoxRow
  PreferencesRow00* = object of gtk.ListBoxRow00

proc hdy_preferences_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PreferencesRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_preferences_row_new(): ptr PreferencesRow00 {.
    importc, libprag.}

proc newPreferencesRow*(): PreferencesRow =
  let gobj = hdy_preferences_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPreferencesRow*(tdesc: typedesc): tdesc =
  assert(result is PreferencesRow)
  let gobj = hdy_preferences_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPreferencesRow*[T](result: var T) {.deprecated.} =
  assert(result is PreferencesRow)
  let gobj = hdy_preferences_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_preferences_row_get_title(self: ptr PreferencesRow00): cstring {.
    importc, libprag.}

proc getTitle*(self: PreferencesRow): string =
  let resul0 = hdy_preferences_row_get_title(cast[ptr PreferencesRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc title*(self: PreferencesRow): string =
  let resul0 = hdy_preferences_row_get_title(cast[ptr PreferencesRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_preferences_row_get_use_underline(self: ptr PreferencesRow00): gboolean {.
    importc, libprag.}

proc getUseUnderline*(self: PreferencesRow): bool =
  toBool(hdy_preferences_row_get_use_underline(cast[ptr PreferencesRow00](self.impl)))

proc useUnderline*(self: PreferencesRow): bool =
  toBool(hdy_preferences_row_get_use_underline(cast[ptr PreferencesRow00](self.impl)))

proc hdy_preferences_row_set_title(self: ptr PreferencesRow00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: PreferencesRow; title: cstring = nil) =
  hdy_preferences_row_set_title(cast[ptr PreferencesRow00](self.impl), title)

proc `title=`*(self: PreferencesRow; title: cstring = nil) =
  hdy_preferences_row_set_title(cast[ptr PreferencesRow00](self.impl), title)

proc hdy_preferences_row_set_use_underline(self: ptr PreferencesRow00; useUnderline: gboolean) {.
    importc, libprag.}

proc setUseUnderline*(self: PreferencesRow; useUnderline: bool = true) =
  hdy_preferences_row_set_use_underline(cast[ptr PreferencesRow00](self.impl), gboolean(useUnderline))

proc `useUnderline=`*(self: PreferencesRow; useUnderline: bool) =
  hdy_preferences_row_set_use_underline(cast[ptr PreferencesRow00](self.impl), gboolean(useUnderline))

type
  ActionRow* = ref object of PreferencesRow
  ActionRow00* = object of PreferencesRow00

proc hdy_action_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ActionRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActivated*(self: ActionRow;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "activated", cast[GCallback](p), xdata, nil, cf)

proc hdy_action_row_new(): ptr ActionRow00 {.
    importc, libprag.}

proc newActionRow*(): ActionRow =
  let gobj = hdy_action_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newActionRow*(tdesc: typedesc): tdesc =
  assert(result is ActionRow)
  let gobj = hdy_action_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initActionRow*[T](result: var T) {.deprecated.} =
  assert(result is ActionRow)
  let gobj = hdy_action_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_action_row_activate(self: ptr ActionRow00) {.
    importc, libprag.}

proc activate*(self: ActionRow) =
  hdy_action_row_activate(cast[ptr ActionRow00](self.impl))

proc hdy_action_row_add_prefix(self: ptr ActionRow00; widget: ptr gtk.Widget00) {.
    importc, libprag.}

proc addPrefix*(self: ActionRow; widget: gtk.Widget) =
  hdy_action_row_add_prefix(cast[ptr ActionRow00](self.impl), cast[ptr gtk.Widget00](widget.impl))

proc hdy_action_row_get_activatable_widget(self: ptr ActionRow00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getActivatableWidget*(self: ActionRow): gtk.Widget =
  let gobj = hdy_action_row_get_activatable_widget(cast[ptr ActionRow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc activatableWidget*(self: ActionRow): gtk.Widget =
  let gobj = hdy_action_row_get_activatable_widget(cast[ptr ActionRow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_action_row_get_icon_name(self: ptr ActionRow00): cstring {.
    importc, libprag.}

proc getIconName*(self: ActionRow): string =
  result = $hdy_action_row_get_icon_name(cast[ptr ActionRow00](self.impl))

proc iconName*(self: ActionRow): string =
  result = $hdy_action_row_get_icon_name(cast[ptr ActionRow00](self.impl))

proc hdy_action_row_get_subtitle(self: ptr ActionRow00): cstring {.
    importc, libprag.}

proc getSubtitle*(self: ActionRow): string =
  let resul0 = hdy_action_row_get_subtitle(cast[ptr ActionRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc subtitle*(self: ActionRow): string =
  let resul0 = hdy_action_row_get_subtitle(cast[ptr ActionRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_action_row_get_subtitle_lines(self: ptr ActionRow00): int32 {.
    importc, libprag.}

proc getSubtitleLines*(self: ActionRow): int =
  int(hdy_action_row_get_subtitle_lines(cast[ptr ActionRow00](self.impl)))

proc subtitleLines*(self: ActionRow): int =
  int(hdy_action_row_get_subtitle_lines(cast[ptr ActionRow00](self.impl)))

proc hdy_action_row_get_title_lines(self: ptr ActionRow00): int32 {.
    importc, libprag.}

proc getTitleLines*(self: ActionRow): int =
  int(hdy_action_row_get_title_lines(cast[ptr ActionRow00](self.impl)))

proc titleLines*(self: ActionRow): int =
  int(hdy_action_row_get_title_lines(cast[ptr ActionRow00](self.impl)))

proc hdy_action_row_get_use_underline(self: ptr ActionRow00): gboolean {.
    importc, libprag.}

proc getUseUnderline*(self: ActionRow): bool =
  toBool(hdy_action_row_get_use_underline(cast[ptr ActionRow00](self.impl)))

proc useUnderline*(self: ActionRow): bool =
  toBool(hdy_action_row_get_use_underline(cast[ptr ActionRow00](self.impl)))

proc hdy_action_row_set_activatable_widget(self: ptr ActionRow00; widget: ptr gtk.Widget00) {.
    importc, libprag.}

proc setActivatableWidget*(self: ActionRow; widget: gtk.Widget = nil) =
  hdy_action_row_set_activatable_widget(cast[ptr ActionRow00](self.impl), if widget.isNil: nil else: cast[ptr gtk.Widget00](widget.impl))

proc `activatableWidget=`*(self: ActionRow; widget: gtk.Widget = nil) =
  hdy_action_row_set_activatable_widget(cast[ptr ActionRow00](self.impl), if widget.isNil: nil else: cast[ptr gtk.Widget00](widget.impl))

proc hdy_action_row_set_icon_name(self: ptr ActionRow00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: ActionRow; iconName: cstring) =
  hdy_action_row_set_icon_name(cast[ptr ActionRow00](self.impl), iconName)

proc `iconName=`*(self: ActionRow; iconName: cstring) =
  hdy_action_row_set_icon_name(cast[ptr ActionRow00](self.impl), iconName)

proc hdy_action_row_set_subtitle(self: ptr ActionRow00; subtitle: cstring) {.
    importc, libprag.}

proc setSubtitle*(self: ActionRow; subtitle: cstring = nil) =
  hdy_action_row_set_subtitle(cast[ptr ActionRow00](self.impl), subtitle)

proc `subtitle=`*(self: ActionRow; subtitle: cstring = nil) =
  hdy_action_row_set_subtitle(cast[ptr ActionRow00](self.impl), subtitle)

proc hdy_action_row_set_subtitle_lines(self: ptr ActionRow00; subtitleLines: int32) {.
    importc, libprag.}

proc setSubtitleLines*(self: ActionRow; subtitleLines: int) =
  hdy_action_row_set_subtitle_lines(cast[ptr ActionRow00](self.impl), int32(subtitleLines))

proc `subtitleLines=`*(self: ActionRow; subtitleLines: int) =
  hdy_action_row_set_subtitle_lines(cast[ptr ActionRow00](self.impl), int32(subtitleLines))

proc hdy_action_row_set_title_lines(self: ptr ActionRow00; titleLines: int32) {.
    importc, libprag.}

proc setTitleLines*(self: ActionRow; titleLines: int) =
  hdy_action_row_set_title_lines(cast[ptr ActionRow00](self.impl), int32(titleLines))

proc `titleLines=`*(self: ActionRow; titleLines: int) =
  hdy_action_row_set_title_lines(cast[ptr ActionRow00](self.impl), int32(titleLines))

proc hdy_action_row_set_use_underline(self: ptr ActionRow00; useUnderline: gboolean) {.
    importc, libprag.}

proc setUseUnderline*(self: ActionRow; useUnderline: bool = true) =
  hdy_action_row_set_use_underline(cast[ptr ActionRow00](self.impl), gboolean(useUnderline))

proc `useUnderline=`*(self: ActionRow; useUnderline: bool) =
  hdy_action_row_set_use_underline(cast[ptr ActionRow00](self.impl), gboolean(useUnderline))

type
  ApplicationWindow* = ref object of gtk.ApplicationWindow
  ApplicationWindow00* = object of gtk.ApplicationWindow00

proc hdy_application_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ApplicationWindow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_application_window_new(): ptr ApplicationWindow00 {.
    importc, libprag.}

proc newApplicationWindow*(): ApplicationWindow =
  let gobj = hdy_application_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newApplicationWindow*(tdesc: typedesc): tdesc =
  assert(result is ApplicationWindow)
  let gobj = hdy_application_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initApplicationWindow*[T](result: var T) {.deprecated.} =
  assert(result is ApplicationWindow)
  let gobj = hdy_application_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Avatar* = ref object of gtk.DrawingArea
  Avatar00* = object of gtk.DrawingArea00

proc hdy_avatar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Avatar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_avatar_new(size: int32; text: cstring; showInitials: gboolean): ptr Avatar00 {.
    importc, libprag.}

proc newAvatar*(size: int; text: cstring = nil; showInitials: bool): Avatar =
  let gobj = hdy_avatar_new(int32(size), text, gboolean(showInitials))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAvatar*(tdesc: typedesc; size: int; text: cstring = nil; showInitials: bool): tdesc =
  assert(result is Avatar)
  let gobj = hdy_avatar_new(int32(size), text, gboolean(showInitials))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAvatar*[T](result: var T; size: int; text: cstring = nil; showInitials: bool) {.deprecated.} =
  assert(result is Avatar)
  let gobj = hdy_avatar_new(int32(size), text, gboolean(showInitials))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_avatar_draw_to_pixbuf(self: ptr Avatar00; size: int32; scaleFactor: int32): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc drawToPixbuf*(self: Avatar; size: int; scaleFactor: int): gdkpixbuf.Pixbuf =
  let gobj = hdy_avatar_draw_to_pixbuf(cast[ptr Avatar00](self.impl), int32(size), int32(scaleFactor))
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

proc hdy_avatar_draw_to_pixbuf_async(self: ptr Avatar00; size: int32; scaleFactor: int32;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc drawToPixbufAsync*(self: Avatar; size: int; scaleFactor: int;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  hdy_avatar_draw_to_pixbuf_async(cast[ptr Avatar00](self.impl), int32(size), int32(scaleFactor), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc hdy_avatar_draw_to_pixbuf_finish(self: ptr Avatar00; asyncResult: ptr gio.AsyncResult00): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc drawToPixbufFinish*(self: Avatar; asyncResult: gio.AsyncResult): gdkpixbuf.Pixbuf =
  let gobj = hdy_avatar_draw_to_pixbuf_finish(cast[ptr Avatar00](self.impl), cast[ptr gio.AsyncResult00](asyncResult.impl))
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

proc hdy_avatar_get_icon_name(self: ptr Avatar00): cstring {.
    importc, libprag.}

proc getIconName*(self: Avatar): string =
  let resul0 = hdy_avatar_get_icon_name(cast[ptr Avatar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: Avatar): string =
  let resul0 = hdy_avatar_get_icon_name(cast[ptr Avatar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_avatar_get_loadable_icon(self: ptr Avatar00): ptr gio.LoadableIcon00 {.
    importc, libprag.}

proc getLoadableIcon*(self: Avatar): gio.LoadableIcon =
  let gobj = hdy_avatar_get_loadable_icon(cast[ptr Avatar00](self.impl))
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

proc loadableIcon*(self: Avatar): gio.LoadableIcon =
  let gobj = hdy_avatar_get_loadable_icon(cast[ptr Avatar00](self.impl))
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

proc hdy_avatar_get_show_initials(self: ptr Avatar00): gboolean {.
    importc, libprag.}

proc getShowInitials*(self: Avatar): bool =
  toBool(hdy_avatar_get_show_initials(cast[ptr Avatar00](self.impl)))

proc showInitials*(self: Avatar): bool =
  toBool(hdy_avatar_get_show_initials(cast[ptr Avatar00](self.impl)))

proc hdy_avatar_get_size(self: ptr Avatar00): int32 {.
    importc, libprag.}

proc getSize*(self: Avatar): int =
  int(hdy_avatar_get_size(cast[ptr Avatar00](self.impl)))

proc size*(self: Avatar): int =
  int(hdy_avatar_get_size(cast[ptr Avatar00](self.impl)))

proc hdy_avatar_get_text(self: ptr Avatar00): cstring {.
    importc, libprag.}

proc getText*(self: Avatar): string =
  let resul0 = hdy_avatar_get_text(cast[ptr Avatar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc text*(self: Avatar): string =
  let resul0 = hdy_avatar_get_text(cast[ptr Avatar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_avatar_set_icon_name(self: ptr Avatar00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: Avatar; iconName: cstring = nil) =
  hdy_avatar_set_icon_name(cast[ptr Avatar00](self.impl), iconName)

proc `iconName=`*(self: Avatar; iconName: cstring = nil) =
  hdy_avatar_set_icon_name(cast[ptr Avatar00](self.impl), iconName)

proc hdy_avatar_set_loadable_icon(self: ptr Avatar00; icon: ptr gio.LoadableIcon00) {.
    importc, libprag.}

proc setLoadableIcon*(self: Avatar; icon: gio.LoadableIcon = nil) =
  hdy_avatar_set_loadable_icon(cast[ptr Avatar00](self.impl), if icon.isNil: nil else: cast[ptr gio.LoadableIcon00](icon.impl))

proc `loadableIcon=`*(self: Avatar; icon: gio.LoadableIcon = nil) =
  hdy_avatar_set_loadable_icon(cast[ptr Avatar00](self.impl), if icon.isNil: nil else: cast[ptr gio.LoadableIcon00](icon.impl))

proc hdy_avatar_set_show_initials(self: ptr Avatar00; showInitials: gboolean) {.
    importc, libprag.}

proc setShowInitials*(self: Avatar; showInitials: bool = true) =
  hdy_avatar_set_show_initials(cast[ptr Avatar00](self.impl), gboolean(showInitials))

proc `showInitials=`*(self: Avatar; showInitials: bool) =
  hdy_avatar_set_show_initials(cast[ptr Avatar00](self.impl), gboolean(showInitials))

proc hdy_avatar_set_size(self: ptr Avatar00; size: int32) {.
    importc, libprag.}

proc setSize*(self: Avatar; size: int) =
  hdy_avatar_set_size(cast[ptr Avatar00](self.impl), int32(size))

proc `size=`*(self: Avatar; size: int) =
  hdy_avatar_set_size(cast[ptr Avatar00](self.impl), int32(size))

proc hdy_avatar_set_text(self: ptr Avatar00; text: cstring) {.
    importc, libprag.}

proc setText*(self: Avatar; text: cstring = nil) =
  hdy_avatar_set_text(cast[ptr Avatar00](self.impl), text)

proc `text=`*(self: Avatar; text: cstring = nil) =
  hdy_avatar_set_text(cast[ptr Avatar00](self.impl), text)

type
  AvatarImageLoadFunc* = proc (size: int32; userData: pointer): ptr gdkpixbuf.Pixbuf00 {.cdecl.}

proc hdy_avatar_set_image_load_func(self: ptr Avatar00; loadImage: AvatarImageLoadFunc;
    userData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc setImageLoadFunc*(self: Avatar; loadImage: AvatarImageLoadFunc;
    userData: pointer; destroy: DestroyNotify) =
  hdy_avatar_set_image_load_func(cast[ptr Avatar00](self.impl), loadImage, userData, destroy)

type
  Carousel* = ref object of gtk.EventBox
  Carousel00* = object of gtk.EventBox00

proc hdy_carousel_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Carousel()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scPageChanged*(self: Carousel;  p: proc (self: ptr Carousel00; index: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "page-changed", cast[GCallback](p), xdata, nil, cf)

proc hdy_carousel_new(): ptr Carousel00 {.
    importc, libprag.}

proc newCarousel*(): Carousel =
  let gobj = hdy_carousel_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCarousel*(tdesc: typedesc): tdesc =
  assert(result is Carousel)
  let gobj = hdy_carousel_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCarousel*[T](result: var T) {.deprecated.} =
  assert(result is Carousel)
  let gobj = hdy_carousel_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_carousel_get_allow_long_swipes(self: ptr Carousel00): gboolean {.
    importc, libprag.}

proc getAllowLongSwipes*(self: Carousel): bool =
  toBool(hdy_carousel_get_allow_long_swipes(cast[ptr Carousel00](self.impl)))

proc allowLongSwipes*(self: Carousel): bool =
  toBool(hdy_carousel_get_allow_long_swipes(cast[ptr Carousel00](self.impl)))

proc hdy_carousel_get_allow_mouse_drag(self: ptr Carousel00): gboolean {.
    importc, libprag.}

proc getAllowMouseDrag*(self: Carousel): bool =
  toBool(hdy_carousel_get_allow_mouse_drag(cast[ptr Carousel00](self.impl)))

proc allowMouseDrag*(self: Carousel): bool =
  toBool(hdy_carousel_get_allow_mouse_drag(cast[ptr Carousel00](self.impl)))

proc hdy_carousel_get_allow_scroll_wheel(self: ptr Carousel00): gboolean {.
    importc, libprag.}

proc getAllowScrollWheel*(self: Carousel): bool =
  toBool(hdy_carousel_get_allow_scroll_wheel(cast[ptr Carousel00](self.impl)))

proc allowScrollWheel*(self: Carousel): bool =
  toBool(hdy_carousel_get_allow_scroll_wheel(cast[ptr Carousel00](self.impl)))

proc hdy_carousel_get_animation_duration(self: ptr Carousel00): uint32 {.
    importc, libprag.}

proc getAnimationDuration*(self: Carousel): int =
  int(hdy_carousel_get_animation_duration(cast[ptr Carousel00](self.impl)))

proc animationDuration*(self: Carousel): int =
  int(hdy_carousel_get_animation_duration(cast[ptr Carousel00](self.impl)))

proc hdy_carousel_get_interactive(self: ptr Carousel00): gboolean {.
    importc, libprag.}

proc getInteractive*(self: Carousel): bool =
  toBool(hdy_carousel_get_interactive(cast[ptr Carousel00](self.impl)))

proc interactive*(self: Carousel): bool =
  toBool(hdy_carousel_get_interactive(cast[ptr Carousel00](self.impl)))

proc hdy_carousel_get_n_pages(self: ptr Carousel00): uint32 {.
    importc, libprag.}

proc getNPages*(self: Carousel): int =
  int(hdy_carousel_get_n_pages(cast[ptr Carousel00](self.impl)))

proc nPages*(self: Carousel): int =
  int(hdy_carousel_get_n_pages(cast[ptr Carousel00](self.impl)))

proc hdy_carousel_get_position(self: ptr Carousel00): cdouble {.
    importc, libprag.}

proc getPosition*(self: Carousel): cdouble =
  hdy_carousel_get_position(cast[ptr Carousel00](self.impl))

proc position*(self: Carousel): cdouble =
  hdy_carousel_get_position(cast[ptr Carousel00](self.impl))

proc hdy_carousel_get_reveal_duration(self: ptr Carousel00): uint32 {.
    importc, libprag.}

proc getRevealDuration*(self: Carousel): int =
  int(hdy_carousel_get_reveal_duration(cast[ptr Carousel00](self.impl)))

proc revealDuration*(self: Carousel): int =
  int(hdy_carousel_get_reveal_duration(cast[ptr Carousel00](self.impl)))

proc hdy_carousel_get_spacing(self: ptr Carousel00): uint32 {.
    importc, libprag.}

proc getSpacing*(self: Carousel): int =
  int(hdy_carousel_get_spacing(cast[ptr Carousel00](self.impl)))

proc spacing*(self: Carousel): int =
  int(hdy_carousel_get_spacing(cast[ptr Carousel00](self.impl)))

proc hdy_carousel_insert(self: ptr Carousel00; child: ptr gtk.Widget00; position: int32) {.
    importc, libprag.}

proc insert*(self: Carousel; child: gtk.Widget; position: int) =
  hdy_carousel_insert(cast[ptr Carousel00](self.impl), cast[ptr gtk.Widget00](child.impl), int32(position))

proc hdy_carousel_prepend(self: ptr Carousel00; child: ptr gtk.Widget00) {.
    importc, libprag.}

proc prepend*(self: Carousel; child: gtk.Widget) =
  hdy_carousel_prepend(cast[ptr Carousel00](self.impl), cast[ptr gtk.Widget00](child.impl))

proc hdy_carousel_reorder(self: ptr Carousel00; child: ptr gtk.Widget00;
    position: int32) {.
    importc, libprag.}

proc reorder*(self: Carousel; child: gtk.Widget; position: int) =
  hdy_carousel_reorder(cast[ptr Carousel00](self.impl), cast[ptr gtk.Widget00](child.impl), int32(position))

proc hdy_carousel_scroll_to(self: ptr Carousel00; widget: ptr gtk.Widget00) {.
    importc, libprag.}

proc scrollTo*(self: Carousel; widget: gtk.Widget) =
  hdy_carousel_scroll_to(cast[ptr Carousel00](self.impl), cast[ptr gtk.Widget00](widget.impl))

proc hdy_carousel_scroll_to_full(self: ptr Carousel00; widget: ptr gtk.Widget00;
    duration: int64) {.
    importc, libprag.}

proc scrollToFull*(self: Carousel; widget: gtk.Widget; duration: int64) =
  hdy_carousel_scroll_to_full(cast[ptr Carousel00](self.impl), cast[ptr gtk.Widget00](widget.impl), duration)

proc hdy_carousel_set_allow_long_swipes(self: ptr Carousel00; allowLongSwipes: gboolean) {.
    importc, libprag.}

proc setAllowLongSwipes*(self: Carousel; allowLongSwipes: bool = true) =
  hdy_carousel_set_allow_long_swipes(cast[ptr Carousel00](self.impl), gboolean(allowLongSwipes))

proc `allowLongSwipes=`*(self: Carousel; allowLongSwipes: bool) =
  hdy_carousel_set_allow_long_swipes(cast[ptr Carousel00](self.impl), gboolean(allowLongSwipes))

proc hdy_carousel_set_allow_mouse_drag(self: ptr Carousel00; allowMouseDrag: gboolean) {.
    importc, libprag.}

proc setAllowMouseDrag*(self: Carousel; allowMouseDrag: bool = true) =
  hdy_carousel_set_allow_mouse_drag(cast[ptr Carousel00](self.impl), gboolean(allowMouseDrag))

proc `allowMouseDrag=`*(self: Carousel; allowMouseDrag: bool) =
  hdy_carousel_set_allow_mouse_drag(cast[ptr Carousel00](self.impl), gboolean(allowMouseDrag))

proc hdy_carousel_set_allow_scroll_wheel(self: ptr Carousel00; allowScrollWheel: gboolean) {.
    importc, libprag.}

proc setAllowScrollWheel*(self: Carousel; allowScrollWheel: bool = true) =
  hdy_carousel_set_allow_scroll_wheel(cast[ptr Carousel00](self.impl), gboolean(allowScrollWheel))

proc `allowScrollWheel=`*(self: Carousel; allowScrollWheel: bool) =
  hdy_carousel_set_allow_scroll_wheel(cast[ptr Carousel00](self.impl), gboolean(allowScrollWheel))

proc hdy_carousel_set_animation_duration(self: ptr Carousel00; duration: uint32) {.
    importc, libprag.}

proc setAnimationDuration*(self: Carousel; duration: int) =
  hdy_carousel_set_animation_duration(cast[ptr Carousel00](self.impl), uint32(duration))

proc `animationDuration=`*(self: Carousel; duration: int) =
  hdy_carousel_set_animation_duration(cast[ptr Carousel00](self.impl), uint32(duration))

proc hdy_carousel_set_interactive(self: ptr Carousel00; interactive: gboolean) {.
    importc, libprag.}

proc setInteractive*(self: Carousel; interactive: bool = true) =
  hdy_carousel_set_interactive(cast[ptr Carousel00](self.impl), gboolean(interactive))

proc `interactive=`*(self: Carousel; interactive: bool) =
  hdy_carousel_set_interactive(cast[ptr Carousel00](self.impl), gboolean(interactive))

proc hdy_carousel_set_reveal_duration(self: ptr Carousel00; revealDuration: uint32) {.
    importc, libprag.}

proc setRevealDuration*(self: Carousel; revealDuration: int) =
  hdy_carousel_set_reveal_duration(cast[ptr Carousel00](self.impl), uint32(revealDuration))

proc `revealDuration=`*(self: Carousel; revealDuration: int) =
  hdy_carousel_set_reveal_duration(cast[ptr Carousel00](self.impl), uint32(revealDuration))

proc hdy_carousel_set_spacing(self: ptr Carousel00; spacing: uint32) {.
    importc, libprag.}

proc setSpacing*(self: Carousel; spacing: int) =
  hdy_carousel_set_spacing(cast[ptr Carousel00](self.impl), uint32(spacing))

proc `spacing=`*(self: Carousel; spacing: int) =
  hdy_carousel_set_spacing(cast[ptr Carousel00](self.impl), uint32(spacing))

type
  CarouselIndicatorDots* = ref object of gtk.DrawingArea
  CarouselIndicatorDots00* = object of gtk.DrawingArea00

proc hdy_carousel_indicator_dots_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CarouselIndicatorDots()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_carousel_indicator_dots_new(): ptr CarouselIndicatorDots00 {.
    importc, libprag.}

proc newCarouselIndicatorDots*(): CarouselIndicatorDots =
  let gobj = hdy_carousel_indicator_dots_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCarouselIndicatorDots*(tdesc: typedesc): tdesc =
  assert(result is CarouselIndicatorDots)
  let gobj = hdy_carousel_indicator_dots_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCarouselIndicatorDots*[T](result: var T) {.deprecated.} =
  assert(result is CarouselIndicatorDots)
  let gobj = hdy_carousel_indicator_dots_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_carousel_indicator_dots_get_carousel(self: ptr CarouselIndicatorDots00): ptr Carousel00 {.
    importc, libprag.}

proc getCarousel*(self: CarouselIndicatorDots): Carousel =
  let gobj = hdy_carousel_indicator_dots_get_carousel(cast[ptr CarouselIndicatorDots00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc carousel*(self: CarouselIndicatorDots): Carousel =
  let gobj = hdy_carousel_indicator_dots_get_carousel(cast[ptr CarouselIndicatorDots00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_carousel_indicator_dots_set_carousel(self: ptr CarouselIndicatorDots00;
    carousel: ptr Carousel00) {.
    importc, libprag.}

proc setCarousel*(self: CarouselIndicatorDots;
    carousel: Carousel = nil) =
  hdy_carousel_indicator_dots_set_carousel(cast[ptr CarouselIndicatorDots00](self.impl), if carousel.isNil: nil else: cast[ptr Carousel00](carousel.impl))

proc `carousel=`*(self: CarouselIndicatorDots;
    carousel: Carousel = nil) =
  hdy_carousel_indicator_dots_set_carousel(cast[ptr CarouselIndicatorDots00](self.impl), if carousel.isNil: nil else: cast[ptr Carousel00](carousel.impl))

type
  CarouselIndicatorLines* = ref object of gtk.DrawingArea
  CarouselIndicatorLines00* = object of gtk.DrawingArea00

proc hdy_carousel_indicator_lines_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CarouselIndicatorLines()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_carousel_indicator_lines_new(): ptr CarouselIndicatorLines00 {.
    importc, libprag.}

proc newCarouselIndicatorLines*(): CarouselIndicatorLines =
  let gobj = hdy_carousel_indicator_lines_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCarouselIndicatorLines*(tdesc: typedesc): tdesc =
  assert(result is CarouselIndicatorLines)
  let gobj = hdy_carousel_indicator_lines_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCarouselIndicatorLines*[T](result: var T) {.deprecated.} =
  assert(result is CarouselIndicatorLines)
  let gobj = hdy_carousel_indicator_lines_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_carousel_indicator_lines_get_carousel(self: ptr CarouselIndicatorLines00): ptr Carousel00 {.
    importc, libprag.}

proc getCarousel*(self: CarouselIndicatorLines): Carousel =
  let gobj = hdy_carousel_indicator_lines_get_carousel(cast[ptr CarouselIndicatorLines00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc carousel*(self: CarouselIndicatorLines): Carousel =
  let gobj = hdy_carousel_indicator_lines_get_carousel(cast[ptr CarouselIndicatorLines00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_carousel_indicator_lines_set_carousel(self: ptr CarouselIndicatorLines00;
    carousel: ptr Carousel00) {.
    importc, libprag.}

proc setCarousel*(self: CarouselIndicatorLines;
    carousel: Carousel = nil) =
  hdy_carousel_indicator_lines_set_carousel(cast[ptr CarouselIndicatorLines00](self.impl), if carousel.isNil: nil else: cast[ptr Carousel00](carousel.impl))

proc `carousel=`*(self: CarouselIndicatorLines;
    carousel: Carousel = nil) =
  hdy_carousel_indicator_lines_set_carousel(cast[ptr CarouselIndicatorLines00](self.impl), if carousel.isNil: nil else: cast[ptr Carousel00](carousel.impl))

type
  CenteringPolicy* {.size: sizeof(cint), pure.} = enum
    loose = 0
    strict = 1

type
  Clamp* = ref object of gtk.Bin
  Clamp00* = object of gtk.Bin00

proc hdy_clamp_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Clamp()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_clamp_new(): ptr Clamp00 {.
    importc, libprag.}

proc newClamp*(): Clamp =
  let gobj = hdy_clamp_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newClamp*(tdesc: typedesc): tdesc =
  assert(result is Clamp)
  let gobj = hdy_clamp_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initClamp*[T](result: var T) {.deprecated.} =
  assert(result is Clamp)
  let gobj = hdy_clamp_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_clamp_get_maximum_size(self: ptr Clamp00): int32 {.
    importc, libprag.}

proc getMaximumSize*(self: Clamp): int =
  int(hdy_clamp_get_maximum_size(cast[ptr Clamp00](self.impl)))

proc maximumSize*(self: Clamp): int =
  int(hdy_clamp_get_maximum_size(cast[ptr Clamp00](self.impl)))

proc hdy_clamp_get_tightening_threshold(self: ptr Clamp00): int32 {.
    importc, libprag.}

proc getTighteningThreshold*(self: Clamp): int =
  int(hdy_clamp_get_tightening_threshold(cast[ptr Clamp00](self.impl)))

proc tighteningThreshold*(self: Clamp): int =
  int(hdy_clamp_get_tightening_threshold(cast[ptr Clamp00](self.impl)))

proc hdy_clamp_set_maximum_size(self: ptr Clamp00; maximumSize: int32) {.
    importc, libprag.}

proc setMaximumSize*(self: Clamp; maximumSize: int) =
  hdy_clamp_set_maximum_size(cast[ptr Clamp00](self.impl), int32(maximumSize))

proc `maximumSize=`*(self: Clamp; maximumSize: int) =
  hdy_clamp_set_maximum_size(cast[ptr Clamp00](self.impl), int32(maximumSize))

proc hdy_clamp_set_tightening_threshold(self: ptr Clamp00; tighteningThreshold: int32) {.
    importc, libprag.}

proc setTighteningThreshold*(self: Clamp; tighteningThreshold: int) =
  hdy_clamp_set_tightening_threshold(cast[ptr Clamp00](self.impl), int32(tighteningThreshold))

proc `tighteningThreshold=`*(self: Clamp; tighteningThreshold: int) =
  hdy_clamp_set_tightening_threshold(cast[ptr Clamp00](self.impl), int32(tighteningThreshold))

type
  ColorScheme* {.size: sizeof(cint), pure.} = enum
    default = 0
    forceLight = 1
    preferLight = 2
    preferDark = 3
    forceDark = 4

type
  ComboRow* = ref object of ActionRow
  ComboRow00* = object of ActionRow00

proc hdy_combo_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ComboRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_combo_row_new(): ptr ComboRow00 {.
    importc, libprag.}

proc newComboRow*(): ComboRow =
  let gobj = hdy_combo_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newComboRow*(tdesc: typedesc): tdesc =
  assert(result is ComboRow)
  let gobj = hdy_combo_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initComboRow*[T](result: var T) {.deprecated.} =
  assert(result is ComboRow)
  let gobj = hdy_combo_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_combo_row_bind_model(self: ptr ComboRow00; model: ptr gio.ListModel00;
    createListWidgetFunc: ListBoxCreateWidgetFunc; createCurrentWidgetFunc: ListBoxCreateWidgetFunc;
    userData: pointer; userDataFreeFunc: DestroyNotify) {.
    importc, libprag.}

proc bindModel*(self: ComboRow; model: gio.ListModel = nil;
    createListWidgetFunc: ListBoxCreateWidgetFunc; createCurrentWidgetFunc: ListBoxCreateWidgetFunc;
    userData: pointer; userDataFreeFunc: DestroyNotify) =
  hdy_combo_row_bind_model(cast[ptr ComboRow00](self.impl), if model.isNil: nil else: cast[ptr gio.ListModel00](model.impl), createListWidgetFunc, createCurrentWidgetFunc, userData, userDataFreeFunc)

proc hdy_combo_row_get_model(self: ptr ComboRow00): ptr gio.ListModel00 {.
    importc, libprag.}

proc getModel*(self: ComboRow): gio.ListModel =
  let gobj = hdy_combo_row_get_model(cast[ptr ComboRow00](self.impl))
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

proc model*(self: ComboRow): gio.ListModel =
  let gobj = hdy_combo_row_get_model(cast[ptr ComboRow00](self.impl))
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

proc hdy_combo_row_get_selected_index(self: ptr ComboRow00): int32 {.
    importc, libprag.}

proc getSelectedIndex*(self: ComboRow): int =
  int(hdy_combo_row_get_selected_index(cast[ptr ComboRow00](self.impl)))

proc selectedIndex*(self: ComboRow): int =
  int(hdy_combo_row_get_selected_index(cast[ptr ComboRow00](self.impl)))

proc hdy_combo_row_get_use_subtitle(self: ptr ComboRow00): gboolean {.
    importc, libprag.}

proc getUseSubtitle*(self: ComboRow): bool =
  toBool(hdy_combo_row_get_use_subtitle(cast[ptr ComboRow00](self.impl)))

proc useSubtitle*(self: ComboRow): bool =
  toBool(hdy_combo_row_get_use_subtitle(cast[ptr ComboRow00](self.impl)))

proc hdy_combo_row_set_selected_index(self: ptr ComboRow00; selectedIndex: int32) {.
    importc, libprag.}

proc setSelectedIndex*(self: ComboRow; selectedIndex: int) =
  hdy_combo_row_set_selected_index(cast[ptr ComboRow00](self.impl), int32(selectedIndex))

proc `selectedIndex=`*(self: ComboRow; selectedIndex: int) =
  hdy_combo_row_set_selected_index(cast[ptr ComboRow00](self.impl), int32(selectedIndex))

proc hdy_combo_row_set_use_subtitle(self: ptr ComboRow00; useSubtitle: gboolean) {.
    importc, libprag.}

proc setUseSubtitle*(self: ComboRow; useSubtitle: bool = true) =
  hdy_combo_row_set_use_subtitle(cast[ptr ComboRow00](self.impl), gboolean(useSubtitle))

proc `useSubtitle=`*(self: ComboRow; useSubtitle: bool) =
  hdy_combo_row_set_use_subtitle(cast[ptr ComboRow00](self.impl), gboolean(useSubtitle))

type
  EnumValueObject* = ref object of gobject.Object
  EnumValueObject00* = object of gobject.Object00

proc hdy_enum_value_object_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EnumValueObject()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_enum_value_object_new(enumValue: gobject.EnumValue): ptr EnumValueObject00 {.
    importc, libprag.}

proc newEnumValueObject*(enumValue: gobject.EnumValue): EnumValueObject =
  let gobj = hdy_enum_value_object_new(enumValue)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newEnumValueObject*(tdesc: typedesc; enumValue: gobject.EnumValue): tdesc =
  assert(result is EnumValueObject)
  let gobj = hdy_enum_value_object_new(enumValue)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initEnumValueObject*[T](result: var T; enumValue: gobject.EnumValue) {.deprecated.} =
  assert(result is EnumValueObject)
  let gobj = hdy_enum_value_object_new(enumValue)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_enum_value_object_get_name(self: ptr EnumValueObject00): cstring {.
    importc, libprag.}

proc getName*(self: EnumValueObject): string =
  result = $hdy_enum_value_object_get_name(cast[ptr EnumValueObject00](self.impl))

proc name*(self: EnumValueObject): string =
  result = $hdy_enum_value_object_get_name(cast[ptr EnumValueObject00](self.impl))

proc hdy_enum_value_object_get_nick(self: ptr EnumValueObject00): cstring {.
    importc, libprag.}

proc getNick*(self: EnumValueObject): string =
  result = $hdy_enum_value_object_get_nick(cast[ptr EnumValueObject00](self.impl))

proc nick*(self: EnumValueObject): string =
  result = $hdy_enum_value_object_get_nick(cast[ptr EnumValueObject00](self.impl))

proc hdy_enum_value_object_get_value(self: ptr EnumValueObject00): int32 {.
    importc, libprag.}

proc getValue*(self: EnumValueObject): int =
  int(hdy_enum_value_object_get_value(cast[ptr EnumValueObject00](self.impl)))

proc value*(self: EnumValueObject): int =
  int(hdy_enum_value_object_get_value(cast[ptr EnumValueObject00](self.impl)))

type
  ComboRowGetEnumValueNameFunc* = proc (value: ptr EnumValueObject00; userData: pointer): cstring {.cdecl.}

proc hdy_combo_row_set_for_enum(self: ptr ComboRow00; enumType: GType; getNameFunc: ComboRowGetEnumValueNameFunc;
    userData: pointer; userDataFreeFunc: DestroyNotify) {.
    importc, libprag.}

proc setForEnum*(self: ComboRow; enumType: GType; getNameFunc: ComboRowGetEnumValueNameFunc;
    userData: pointer; userDataFreeFunc: DestroyNotify) =
  hdy_combo_row_set_for_enum(cast[ptr ComboRow00](self.impl), enumType, getNameFunc, userData, userDataFreeFunc)

type
  ComboRowGetNameFunc* = proc (item: ptr gobject.Object00; userData: pointer): cstring {.cdecl.}

proc hdy_combo_row_bind_name_model(self: ptr ComboRow00; model: ptr gio.ListModel00;
    getNameFunc: ComboRowGetNameFunc; userData: pointer; userDataFreeFunc: DestroyNotify) {.
    importc, libprag.}

proc bindNameModel*(self: ComboRow; model: gio.ListModel = nil;
    getNameFunc: ComboRowGetNameFunc; userData: pointer; userDataFreeFunc: DestroyNotify) =
  hdy_combo_row_bind_name_model(cast[ptr ComboRow00](self.impl), if model.isNil: nil else: cast[ptr gio.ListModel00](model.impl), getNameFunc, userData, userDataFreeFunc)

proc hdy_combo_row_set_get_name_func(self: ptr ComboRow00; getNameFunc: ComboRowGetNameFunc;
    userData: pointer; userDataFreeFunc: DestroyNotify) {.
    importc, libprag.}

proc setGetNameFunc*(self: ComboRow; getNameFunc: ComboRowGetNameFunc;
    userData: pointer; userDataFreeFunc: DestroyNotify) =
  hdy_combo_row_set_get_name_func(cast[ptr ComboRow00](self.impl), getNameFunc, userData, userDataFreeFunc)

type
  Deck* = ref object of gtk.Container
  Deck00* = object of gtk.Container00

proc hdy_deck_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Deck()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_deck_new(): ptr Deck00 {.
    importc, libprag.}

proc newDeck*(): Deck =
  let gobj = hdy_deck_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newDeck*(tdesc: typedesc): tdesc =
  assert(result is Deck)
  let gobj = hdy_deck_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDeck*[T](result: var T) {.deprecated.} =
  assert(result is Deck)
  let gobj = hdy_deck_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_deck_get_can_swipe_back(self: ptr Deck00): gboolean {.
    importc, libprag.}

proc getCanSwipeBack*(self: Deck): bool =
  toBool(hdy_deck_get_can_swipe_back(cast[ptr Deck00](self.impl)))

proc canSwipeBack*(self: Deck): bool =
  toBool(hdy_deck_get_can_swipe_back(cast[ptr Deck00](self.impl)))

proc hdy_deck_get_can_swipe_forward(self: ptr Deck00): gboolean {.
    importc, libprag.}

proc getCanSwipeForward*(self: Deck): bool =
  toBool(hdy_deck_get_can_swipe_forward(cast[ptr Deck00](self.impl)))

proc canSwipeForward*(self: Deck): bool =
  toBool(hdy_deck_get_can_swipe_forward(cast[ptr Deck00](self.impl)))

proc hdy_deck_get_child_by_name(self: ptr Deck00; name: cstring): ptr gtk.Widget00 {.
    importc, libprag.}

proc getChildByName*(self: Deck; name: cstring): gtk.Widget =
  let gobj = hdy_deck_get_child_by_name(cast[ptr Deck00](self.impl), name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_deck_get_homogeneous(self: ptr Deck00; orientation: gtk.Orientation): gboolean {.
    importc, libprag.}

proc getHomogeneous*(self: Deck; orientation: gtk.Orientation): bool =
  toBool(hdy_deck_get_homogeneous(cast[ptr Deck00](self.impl), orientation))

proc hdy_deck_get_interpolate_size(self: ptr Deck00): gboolean {.
    importc, libprag.}

proc getInterpolateSize*(self: Deck): bool =
  toBool(hdy_deck_get_interpolate_size(cast[ptr Deck00](self.impl)))

proc interpolateSize*(self: Deck): bool =
  toBool(hdy_deck_get_interpolate_size(cast[ptr Deck00](self.impl)))

proc hdy_deck_get_transition_duration(self: ptr Deck00): uint32 {.
    importc, libprag.}

proc getTransitionDuration*(self: Deck): int =
  int(hdy_deck_get_transition_duration(cast[ptr Deck00](self.impl)))

proc transitionDuration*(self: Deck): int =
  int(hdy_deck_get_transition_duration(cast[ptr Deck00](self.impl)))

proc hdy_deck_get_transition_running(self: ptr Deck00): gboolean {.
    importc, libprag.}

proc getTransitionRunning*(self: Deck): bool =
  toBool(hdy_deck_get_transition_running(cast[ptr Deck00](self.impl)))

proc transitionRunning*(self: Deck): bool =
  toBool(hdy_deck_get_transition_running(cast[ptr Deck00](self.impl)))

proc hdy_deck_get_visible_child(self: ptr Deck00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getVisibleChild*(self: Deck): gtk.Widget =
  let gobj = hdy_deck_get_visible_child(cast[ptr Deck00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visibleChild*(self: Deck): gtk.Widget =
  let gobj = hdy_deck_get_visible_child(cast[ptr Deck00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_deck_get_visible_child_name(self: ptr Deck00): cstring {.
    importc, libprag.}

proc getVisibleChildName*(self: Deck): string =
  result = $hdy_deck_get_visible_child_name(cast[ptr Deck00](self.impl))

proc visibleChildName*(self: Deck): string =
  result = $hdy_deck_get_visible_child_name(cast[ptr Deck00](self.impl))

proc hdy_deck_insert_child_after(self: ptr Deck00; child: ptr gtk.Widget00;
    sibling: ptr gtk.Widget00) {.
    importc, libprag.}

proc insertChildAfter*(self: Deck; child: gtk.Widget; sibling: gtk.Widget = nil) =
  hdy_deck_insert_child_after(cast[ptr Deck00](self.impl), cast[ptr gtk.Widget00](child.impl), if sibling.isNil: nil else: cast[ptr gtk.Widget00](sibling.impl))

proc hdy_deck_prepend(self: ptr Deck00; child: ptr gtk.Widget00) {.
    importc, libprag.}

proc prepend*(self: Deck; child: gtk.Widget) =
  hdy_deck_prepend(cast[ptr Deck00](self.impl), cast[ptr gtk.Widget00](child.impl))

proc hdy_deck_reorder_child_after(self: ptr Deck00; child: ptr gtk.Widget00;
    sibling: ptr gtk.Widget00) {.
    importc, libprag.}

proc reorderChildAfter*(self: Deck; child: gtk.Widget; sibling: gtk.Widget = nil) =
  hdy_deck_reorder_child_after(cast[ptr Deck00](self.impl), cast[ptr gtk.Widget00](child.impl), if sibling.isNil: nil else: cast[ptr gtk.Widget00](sibling.impl))

proc hdy_deck_set_can_swipe_back(self: ptr Deck00; canSwipeBack: gboolean) {.
    importc, libprag.}

proc setCanSwipeBack*(self: Deck; canSwipeBack: bool = true) =
  hdy_deck_set_can_swipe_back(cast[ptr Deck00](self.impl), gboolean(canSwipeBack))

proc `canSwipeBack=`*(self: Deck; canSwipeBack: bool) =
  hdy_deck_set_can_swipe_back(cast[ptr Deck00](self.impl), gboolean(canSwipeBack))

proc hdy_deck_set_can_swipe_forward(self: ptr Deck00; canSwipeForward: gboolean) {.
    importc, libprag.}

proc setCanSwipeForward*(self: Deck; canSwipeForward: bool = true) =
  hdy_deck_set_can_swipe_forward(cast[ptr Deck00](self.impl), gboolean(canSwipeForward))

proc `canSwipeForward=`*(self: Deck; canSwipeForward: bool) =
  hdy_deck_set_can_swipe_forward(cast[ptr Deck00](self.impl), gboolean(canSwipeForward))

proc hdy_deck_set_homogeneous(self: ptr Deck00; orientation: gtk.Orientation;
    homogeneous: gboolean) {.
    importc, libprag.}

proc setHomogeneous*(self: Deck; orientation: gtk.Orientation; homogeneous: bool) =
  hdy_deck_set_homogeneous(cast[ptr Deck00](self.impl), orientation, gboolean(homogeneous))

proc hdy_deck_set_interpolate_size(self: ptr Deck00; interpolateSize: gboolean) {.
    importc, libprag.}

proc setInterpolateSize*(self: Deck; interpolateSize: bool = true) =
  hdy_deck_set_interpolate_size(cast[ptr Deck00](self.impl), gboolean(interpolateSize))

proc `interpolateSize=`*(self: Deck; interpolateSize: bool) =
  hdy_deck_set_interpolate_size(cast[ptr Deck00](self.impl), gboolean(interpolateSize))

proc hdy_deck_set_transition_duration(self: ptr Deck00; duration: uint32) {.
    importc, libprag.}

proc setTransitionDuration*(self: Deck; duration: int) =
  hdy_deck_set_transition_duration(cast[ptr Deck00](self.impl), uint32(duration))

proc `transitionDuration=`*(self: Deck; duration: int) =
  hdy_deck_set_transition_duration(cast[ptr Deck00](self.impl), uint32(duration))

proc hdy_deck_set_visible_child(self: ptr Deck00; visibleChild: ptr gtk.Widget00) {.
    importc, libprag.}

proc setVisibleChild*(self: Deck; visibleChild: gtk.Widget) =
  hdy_deck_set_visible_child(cast[ptr Deck00](self.impl), cast[ptr gtk.Widget00](visibleChild.impl))

proc `visibleChild=`*(self: Deck; visibleChild: gtk.Widget) =
  hdy_deck_set_visible_child(cast[ptr Deck00](self.impl), cast[ptr gtk.Widget00](visibleChild.impl))

proc hdy_deck_set_visible_child_name(self: ptr Deck00; name: cstring) {.
    importc, libprag.}

proc setVisibleChildName*(self: Deck; name: cstring) =
  hdy_deck_set_visible_child_name(cast[ptr Deck00](self.impl), name)

proc `visibleChildName=`*(self: Deck; name: cstring) =
  hdy_deck_set_visible_child_name(cast[ptr Deck00](self.impl), name)

type
  NavigationDirection* {.size: sizeof(cint), pure.} = enum
    back = 0
    forward = 1

proc hdy_deck_get_adjacent_child(self: ptr Deck00; direction: NavigationDirection): ptr gtk.Widget00 {.
    importc, libprag.}

proc getAdjacentChild*(self: Deck; direction: NavigationDirection): gtk.Widget =
  let gobj = hdy_deck_get_adjacent_child(cast[ptr Deck00](self.impl), direction)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_deck_navigate(self: ptr Deck00; direction: NavigationDirection): gboolean {.
    importc, libprag.}

proc navigate*(self: Deck; direction: NavigationDirection): bool =
  toBool(hdy_deck_navigate(cast[ptr Deck00](self.impl), direction))

type
  DeckTransitionType* {.size: sizeof(cint), pure.} = enum
    over = 0
    under = 1
    slide = 2

proc hdy_deck_get_transition_type(self: ptr Deck00): DeckTransitionType {.
    importc, libprag.}

proc getTransitionType*(self: Deck): DeckTransitionType =
  hdy_deck_get_transition_type(cast[ptr Deck00](self.impl))

proc transitionType*(self: Deck): DeckTransitionType =
  hdy_deck_get_transition_type(cast[ptr Deck00](self.impl))

proc hdy_deck_set_transition_type(self: ptr Deck00; transition: DeckTransitionType) {.
    importc, libprag.}

proc setTransitionType*(self: Deck; transition: DeckTransitionType) =
  hdy_deck_set_transition_type(cast[ptr Deck00](self.impl), transition)

proc `transitionType=`*(self: Deck; transition: DeckTransitionType) =
  hdy_deck_set_transition_type(cast[ptr Deck00](self.impl), transition)

type
  ExpanderRow* = ref object of PreferencesRow
  ExpanderRow00* = object of PreferencesRow00

proc hdy_expander_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ExpanderRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_expander_row_new(): ptr ExpanderRow00 {.
    importc, libprag.}

proc newExpanderRow*(): ExpanderRow =
  let gobj = hdy_expander_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newExpanderRow*(tdesc: typedesc): tdesc =
  assert(result is ExpanderRow)
  let gobj = hdy_expander_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initExpanderRow*[T](result: var T) {.deprecated.} =
  assert(result is ExpanderRow)
  let gobj = hdy_expander_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_expander_row_add_action(self: ptr ExpanderRow00; widget: ptr gtk.Widget00) {.
    importc, libprag.}

proc addAction*(self: ExpanderRow; widget: gtk.Widget) =
  hdy_expander_row_add_action(cast[ptr ExpanderRow00](self.impl), cast[ptr gtk.Widget00](widget.impl))

proc hdy_expander_row_add_prefix(self: ptr ExpanderRow00; widget: ptr gtk.Widget00) {.
    importc, libprag.}

proc addPrefix*(self: ExpanderRow; widget: gtk.Widget) =
  hdy_expander_row_add_prefix(cast[ptr ExpanderRow00](self.impl), cast[ptr gtk.Widget00](widget.impl))

proc hdy_expander_row_get_enable_expansion(self: ptr ExpanderRow00): gboolean {.
    importc, libprag.}

proc getEnableExpansion*(self: ExpanderRow): bool =
  toBool(hdy_expander_row_get_enable_expansion(cast[ptr ExpanderRow00](self.impl)))

proc enableExpansion*(self: ExpanderRow): bool =
  toBool(hdy_expander_row_get_enable_expansion(cast[ptr ExpanderRow00](self.impl)))

proc hdy_expander_row_get_expanded(self: ptr ExpanderRow00): gboolean {.
    importc, libprag.}

proc getExpanded*(self: ExpanderRow): bool =
  toBool(hdy_expander_row_get_expanded(cast[ptr ExpanderRow00](self.impl)))

proc expanded*(self: ExpanderRow): bool =
  toBool(hdy_expander_row_get_expanded(cast[ptr ExpanderRow00](self.impl)))

proc hdy_expander_row_get_icon_name(self: ptr ExpanderRow00): cstring {.
    importc, libprag.}

proc getIconName*(self: ExpanderRow): string =
  result = $hdy_expander_row_get_icon_name(cast[ptr ExpanderRow00](self.impl))

proc iconName*(self: ExpanderRow): string =
  result = $hdy_expander_row_get_icon_name(cast[ptr ExpanderRow00](self.impl))

proc hdy_expander_row_get_show_enable_switch(self: ptr ExpanderRow00): gboolean {.
    importc, libprag.}

proc getShowEnableSwitch*(self: ExpanderRow): bool =
  toBool(hdy_expander_row_get_show_enable_switch(cast[ptr ExpanderRow00](self.impl)))

proc showEnableSwitch*(self: ExpanderRow): bool =
  toBool(hdy_expander_row_get_show_enable_switch(cast[ptr ExpanderRow00](self.impl)))

proc hdy_expander_row_get_subtitle(self: ptr ExpanderRow00): cstring {.
    importc, libprag.}

proc getSubtitle*(self: ExpanderRow): string =
  let resul0 = hdy_expander_row_get_subtitle(cast[ptr ExpanderRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc subtitle*(self: ExpanderRow): string =
  let resul0 = hdy_expander_row_get_subtitle(cast[ptr ExpanderRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_expander_row_get_use_underline(self: ptr ExpanderRow00): gboolean {.
    importc, libprag.}

proc getUseUnderline*(self: ExpanderRow): bool =
  toBool(hdy_expander_row_get_use_underline(cast[ptr ExpanderRow00](self.impl)))

proc useUnderline*(self: ExpanderRow): bool =
  toBool(hdy_expander_row_get_use_underline(cast[ptr ExpanderRow00](self.impl)))

proc hdy_expander_row_set_enable_expansion(self: ptr ExpanderRow00; enableExpansion: gboolean) {.
    importc, libprag.}

proc setEnableExpansion*(self: ExpanderRow; enableExpansion: bool = true) =
  hdy_expander_row_set_enable_expansion(cast[ptr ExpanderRow00](self.impl), gboolean(enableExpansion))

proc `enableExpansion=`*(self: ExpanderRow; enableExpansion: bool) =
  hdy_expander_row_set_enable_expansion(cast[ptr ExpanderRow00](self.impl), gboolean(enableExpansion))

proc hdy_expander_row_set_expanded(self: ptr ExpanderRow00; expanded: gboolean) {.
    importc, libprag.}

proc setExpanded*(self: ExpanderRow; expanded: bool = true) =
  hdy_expander_row_set_expanded(cast[ptr ExpanderRow00](self.impl), gboolean(expanded))

proc `expanded=`*(self: ExpanderRow; expanded: bool) =
  hdy_expander_row_set_expanded(cast[ptr ExpanderRow00](self.impl), gboolean(expanded))

proc hdy_expander_row_set_icon_name(self: ptr ExpanderRow00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: ExpanderRow; iconName: cstring) =
  hdy_expander_row_set_icon_name(cast[ptr ExpanderRow00](self.impl), iconName)

proc `iconName=`*(self: ExpanderRow; iconName: cstring) =
  hdy_expander_row_set_icon_name(cast[ptr ExpanderRow00](self.impl), iconName)

proc hdy_expander_row_set_show_enable_switch(self: ptr ExpanderRow00; showEnableSwitch: gboolean) {.
    importc, libprag.}

proc setShowEnableSwitch*(self: ExpanderRow; showEnableSwitch: bool = true) =
  hdy_expander_row_set_show_enable_switch(cast[ptr ExpanderRow00](self.impl), gboolean(showEnableSwitch))

proc `showEnableSwitch=`*(self: ExpanderRow; showEnableSwitch: bool) =
  hdy_expander_row_set_show_enable_switch(cast[ptr ExpanderRow00](self.impl), gboolean(showEnableSwitch))

proc hdy_expander_row_set_subtitle(self: ptr ExpanderRow00; subtitle: cstring) {.
    importc, libprag.}

proc setSubtitle*(self: ExpanderRow; subtitle: cstring = nil) =
  hdy_expander_row_set_subtitle(cast[ptr ExpanderRow00](self.impl), subtitle)

proc `subtitle=`*(self: ExpanderRow; subtitle: cstring = nil) =
  hdy_expander_row_set_subtitle(cast[ptr ExpanderRow00](self.impl), subtitle)

proc hdy_expander_row_set_use_underline(self: ptr ExpanderRow00; useUnderline: gboolean) {.
    importc, libprag.}

proc setUseUnderline*(self: ExpanderRow; useUnderline: bool = true) =
  hdy_expander_row_set_use_underline(cast[ptr ExpanderRow00](self.impl), gboolean(useUnderline))

proc `useUnderline=`*(self: ExpanderRow; useUnderline: bool) =
  hdy_expander_row_set_use_underline(cast[ptr ExpanderRow00](self.impl), gboolean(useUnderline))

type
  Flap* = ref object of gtk.Container
  Flap00* = object of gtk.Container00

proc hdy_flap_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Flap()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_flap_new(): ptr Flap00 {.
    importc, libprag.}

proc newFlap*(): Flap =
  let gobj = hdy_flap_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFlap*(tdesc: typedesc): tdesc =
  assert(result is Flap)
  let gobj = hdy_flap_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFlap*[T](result: var T) {.deprecated.} =
  assert(result is Flap)
  let gobj = hdy_flap_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_flap_get_content(self: ptr Flap00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getContent*(self: Flap): gtk.Widget =
  let gobj = hdy_flap_get_content(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc content*(self: Flap): gtk.Widget =
  let gobj = hdy_flap_get_content(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_flap_get_flap(self: ptr Flap00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getFlap*(self: Flap): gtk.Widget =
  let gobj = hdy_flap_get_flap(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc flap*(self: Flap): gtk.Widget =
  let gobj = hdy_flap_get_flap(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_flap_get_flap_position(self: ptr Flap00): gtk.PackType {.
    importc, libprag.}

proc getFlapPosition*(self: Flap): gtk.PackType =
  hdy_flap_get_flap_position(cast[ptr Flap00](self.impl))

proc flapPosition*(self: Flap): gtk.PackType =
  hdy_flap_get_flap_position(cast[ptr Flap00](self.impl))

proc hdy_flap_get_fold_duration(self: ptr Flap00): uint32 {.
    importc, libprag.}

proc getFoldDuration*(self: Flap): int =
  int(hdy_flap_get_fold_duration(cast[ptr Flap00](self.impl)))

proc foldDuration*(self: Flap): int =
  int(hdy_flap_get_fold_duration(cast[ptr Flap00](self.impl)))

proc hdy_flap_get_folded(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getFolded*(self: Flap): bool =
  toBool(hdy_flap_get_folded(cast[ptr Flap00](self.impl)))

proc folded*(self: Flap): bool =
  toBool(hdy_flap_get_folded(cast[ptr Flap00](self.impl)))

proc hdy_flap_get_locked(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getLocked*(self: Flap): bool =
  toBool(hdy_flap_get_locked(cast[ptr Flap00](self.impl)))

proc locked*(self: Flap): bool =
  toBool(hdy_flap_get_locked(cast[ptr Flap00](self.impl)))

proc hdy_flap_get_modal(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getModal*(self: Flap): bool =
  toBool(hdy_flap_get_modal(cast[ptr Flap00](self.impl)))

proc modal*(self: Flap): bool =
  toBool(hdy_flap_get_modal(cast[ptr Flap00](self.impl)))

proc hdy_flap_get_reveal_duration(self: ptr Flap00): uint32 {.
    importc, libprag.}

proc getRevealDuration*(self: Flap): int =
  int(hdy_flap_get_reveal_duration(cast[ptr Flap00](self.impl)))

proc revealDuration*(self: Flap): int =
  int(hdy_flap_get_reveal_duration(cast[ptr Flap00](self.impl)))

proc hdy_flap_get_reveal_flap(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getRevealFlap*(self: Flap): bool =
  toBool(hdy_flap_get_reveal_flap(cast[ptr Flap00](self.impl)))

proc revealFlap*(self: Flap): bool =
  toBool(hdy_flap_get_reveal_flap(cast[ptr Flap00](self.impl)))

proc hdy_flap_get_reveal_progress(self: ptr Flap00): cdouble {.
    importc, libprag.}

proc getRevealProgress*(self: Flap): cdouble =
  hdy_flap_get_reveal_progress(cast[ptr Flap00](self.impl))

proc revealProgress*(self: Flap): cdouble =
  hdy_flap_get_reveal_progress(cast[ptr Flap00](self.impl))

proc hdy_flap_get_separator(self: ptr Flap00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getSeparator*(self: Flap): gtk.Widget =
  let gobj = hdy_flap_get_separator(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc separator*(self: Flap): gtk.Widget =
  let gobj = hdy_flap_get_separator(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_flap_get_swipe_to_close(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getSwipeToClose*(self: Flap): bool =
  toBool(hdy_flap_get_swipe_to_close(cast[ptr Flap00](self.impl)))

proc swipeToClose*(self: Flap): bool =
  toBool(hdy_flap_get_swipe_to_close(cast[ptr Flap00](self.impl)))

proc hdy_flap_get_swipe_to_open(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getSwipeToOpen*(self: Flap): bool =
  toBool(hdy_flap_get_swipe_to_open(cast[ptr Flap00](self.impl)))

proc swipeToOpen*(self: Flap): bool =
  toBool(hdy_flap_get_swipe_to_open(cast[ptr Flap00](self.impl)))

proc hdy_flap_set_content(self: ptr Flap00; content: ptr gtk.Widget00) {.
    importc, libprag.}

proc setContent*(self: Flap; content: gtk.Widget = nil) =
  hdy_flap_set_content(cast[ptr Flap00](self.impl), if content.isNil: nil else: cast[ptr gtk.Widget00](content.impl))

proc `content=`*(self: Flap; content: gtk.Widget = nil) =
  hdy_flap_set_content(cast[ptr Flap00](self.impl), if content.isNil: nil else: cast[ptr gtk.Widget00](content.impl))

proc hdy_flap_set_flap(self: ptr Flap00; flap: ptr gtk.Widget00) {.
    importc, libprag.}

proc setFlap*(self: Flap; flap: gtk.Widget = nil) =
  hdy_flap_set_flap(cast[ptr Flap00](self.impl), if flap.isNil: nil else: cast[ptr gtk.Widget00](flap.impl))

proc `flap=`*(self: Flap; flap: gtk.Widget = nil) =
  hdy_flap_set_flap(cast[ptr Flap00](self.impl), if flap.isNil: nil else: cast[ptr gtk.Widget00](flap.impl))

proc hdy_flap_set_flap_position(self: ptr Flap00; position: gtk.PackType) {.
    importc, libprag.}

proc setFlapPosition*(self: Flap; position: gtk.PackType) =
  hdy_flap_set_flap_position(cast[ptr Flap00](self.impl), position)

proc `flapPosition=`*(self: Flap; position: gtk.PackType) =
  hdy_flap_set_flap_position(cast[ptr Flap00](self.impl), position)

proc hdy_flap_set_fold_duration(self: ptr Flap00; duration: uint32) {.
    importc, libprag.}

proc setFoldDuration*(self: Flap; duration: int) =
  hdy_flap_set_fold_duration(cast[ptr Flap00](self.impl), uint32(duration))

proc `foldDuration=`*(self: Flap; duration: int) =
  hdy_flap_set_fold_duration(cast[ptr Flap00](self.impl), uint32(duration))

proc hdy_flap_set_locked(self: ptr Flap00; locked: gboolean) {.
    importc, libprag.}

proc setLocked*(self: Flap; locked: bool = true) =
  hdy_flap_set_locked(cast[ptr Flap00](self.impl), gboolean(locked))

proc `locked=`*(self: Flap; locked: bool) =
  hdy_flap_set_locked(cast[ptr Flap00](self.impl), gboolean(locked))

proc hdy_flap_set_modal(self: ptr Flap00; modal: gboolean) {.
    importc, libprag.}

proc setModal*(self: Flap; modal: bool = true) =
  hdy_flap_set_modal(cast[ptr Flap00](self.impl), gboolean(modal))

proc `modal=`*(self: Flap; modal: bool) =
  hdy_flap_set_modal(cast[ptr Flap00](self.impl), gboolean(modal))

proc hdy_flap_set_reveal_duration(self: ptr Flap00; duration: uint32) {.
    importc, libprag.}

proc setRevealDuration*(self: Flap; duration: int) =
  hdy_flap_set_reveal_duration(cast[ptr Flap00](self.impl), uint32(duration))

proc `revealDuration=`*(self: Flap; duration: int) =
  hdy_flap_set_reveal_duration(cast[ptr Flap00](self.impl), uint32(duration))

proc hdy_flap_set_reveal_flap(self: ptr Flap00; revealFlap: gboolean) {.
    importc, libprag.}

proc setRevealFlap*(self: Flap; revealFlap: bool = true) =
  hdy_flap_set_reveal_flap(cast[ptr Flap00](self.impl), gboolean(revealFlap))

proc `revealFlap=`*(self: Flap; revealFlap: bool) =
  hdy_flap_set_reveal_flap(cast[ptr Flap00](self.impl), gboolean(revealFlap))

proc hdy_flap_set_separator(self: ptr Flap00; separator: ptr gtk.Widget00) {.
    importc, libprag.}

proc setSeparator*(self: Flap; separator: gtk.Widget = nil) =
  hdy_flap_set_separator(cast[ptr Flap00](self.impl), if separator.isNil: nil else: cast[ptr gtk.Widget00](separator.impl))

proc `separator=`*(self: Flap; separator: gtk.Widget = nil) =
  hdy_flap_set_separator(cast[ptr Flap00](self.impl), if separator.isNil: nil else: cast[ptr gtk.Widget00](separator.impl))

proc hdy_flap_set_swipe_to_close(self: ptr Flap00; swipeToClose: gboolean) {.
    importc, libprag.}

proc setSwipeToClose*(self: Flap; swipeToClose: bool = true) =
  hdy_flap_set_swipe_to_close(cast[ptr Flap00](self.impl), gboolean(swipeToClose))

proc `swipeToClose=`*(self: Flap; swipeToClose: bool) =
  hdy_flap_set_swipe_to_close(cast[ptr Flap00](self.impl), gboolean(swipeToClose))

proc hdy_flap_set_swipe_to_open(self: ptr Flap00; swipeToOpen: gboolean) {.
    importc, libprag.}

proc setSwipeToOpen*(self: Flap; swipeToOpen: bool = true) =
  hdy_flap_set_swipe_to_open(cast[ptr Flap00](self.impl), gboolean(swipeToOpen))

proc `swipeToOpen=`*(self: Flap; swipeToOpen: bool) =
  hdy_flap_set_swipe_to_open(cast[ptr Flap00](self.impl), gboolean(swipeToOpen))

type
  FlapFoldPolicy* {.size: sizeof(cint), pure.} = enum
    never = 0
    always = 1
    auto = 2

proc hdy_flap_get_fold_policy(self: ptr Flap00): FlapFoldPolicy {.
    importc, libprag.}

proc getFoldPolicy*(self: Flap): FlapFoldPolicy =
  hdy_flap_get_fold_policy(cast[ptr Flap00](self.impl))

proc foldPolicy*(self: Flap): FlapFoldPolicy =
  hdy_flap_get_fold_policy(cast[ptr Flap00](self.impl))

proc hdy_flap_set_fold_policy(self: ptr Flap00; policy: FlapFoldPolicy) {.
    importc, libprag.}

proc setFoldPolicy*(self: Flap; policy: FlapFoldPolicy) =
  hdy_flap_set_fold_policy(cast[ptr Flap00](self.impl), policy)

proc `foldPolicy=`*(self: Flap; policy: FlapFoldPolicy) =
  hdy_flap_set_fold_policy(cast[ptr Flap00](self.impl), policy)

type
  FlapTransitionType* {.size: sizeof(cint), pure.} = enum
    over = 0
    under = 1
    slide = 2

proc hdy_flap_get_transition_type(self: ptr Flap00): FlapTransitionType {.
    importc, libprag.}

proc getTransitionType*(self: Flap): FlapTransitionType =
  hdy_flap_get_transition_type(cast[ptr Flap00](self.impl))

proc transitionType*(self: Flap): FlapTransitionType =
  hdy_flap_get_transition_type(cast[ptr Flap00](self.impl))

proc hdy_flap_set_transition_type(self: ptr Flap00; transitionType: FlapTransitionType) {.
    importc, libprag.}

proc setTransitionType*(self: Flap; transitionType: FlapTransitionType) =
  hdy_flap_set_transition_type(cast[ptr Flap00](self.impl), transitionType)

proc `transitionType=`*(self: Flap; transitionType: FlapTransitionType) =
  hdy_flap_set_transition_type(cast[ptr Flap00](self.impl), transitionType)

type
  HeaderBar* = ref object of gtk.Container
  HeaderBar00* = object of gtk.Container00

proc hdy_header_bar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HeaderBar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_header_bar_new(): ptr HeaderBar00 {.
    importc, libprag.}

proc newHeaderBar*(): HeaderBar =
  let gobj = hdy_header_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHeaderBar*(tdesc: typedesc): tdesc =
  assert(result is HeaderBar)
  let gobj = hdy_header_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHeaderBar*[T](result: var T) {.deprecated.} =
  assert(result is HeaderBar)
  let gobj = hdy_header_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_header_bar_get_centering_policy(self: ptr HeaderBar00): CenteringPolicy {.
    importc, libprag.}

proc getCenteringPolicy*(self: HeaderBar): CenteringPolicy =
  hdy_header_bar_get_centering_policy(cast[ptr HeaderBar00](self.impl))

proc centeringPolicy*(self: HeaderBar): CenteringPolicy =
  hdy_header_bar_get_centering_policy(cast[ptr HeaderBar00](self.impl))

proc hdy_header_bar_get_custom_title(self: ptr HeaderBar00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getCustomTitle*(self: HeaderBar): gtk.Widget =
  let gobj = hdy_header_bar_get_custom_title(cast[ptr HeaderBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc customTitle*(self: HeaderBar): gtk.Widget =
  let gobj = hdy_header_bar_get_custom_title(cast[ptr HeaderBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_header_bar_get_decoration_layout(self: ptr HeaderBar00): cstring {.
    importc, libprag.}

proc getDecorationLayout*(self: HeaderBar): string =
  result = $hdy_header_bar_get_decoration_layout(cast[ptr HeaderBar00](self.impl))

proc decorationLayout*(self: HeaderBar): string =
  result = $hdy_header_bar_get_decoration_layout(cast[ptr HeaderBar00](self.impl))

proc hdy_header_bar_get_has_subtitle(self: ptr HeaderBar00): gboolean {.
    importc, libprag.}

proc getHasSubtitle*(self: HeaderBar): bool =
  toBool(hdy_header_bar_get_has_subtitle(cast[ptr HeaderBar00](self.impl)))

proc hasSubtitle*(self: HeaderBar): bool =
  toBool(hdy_header_bar_get_has_subtitle(cast[ptr HeaderBar00](self.impl)))

proc hdy_header_bar_get_interpolate_size(self: ptr HeaderBar00): gboolean {.
    importc, libprag.}

proc getInterpolateSize*(self: HeaderBar): bool =
  toBool(hdy_header_bar_get_interpolate_size(cast[ptr HeaderBar00](self.impl)))

proc interpolateSize*(self: HeaderBar): bool =
  toBool(hdy_header_bar_get_interpolate_size(cast[ptr HeaderBar00](self.impl)))

proc hdy_header_bar_get_show_close_button(self: ptr HeaderBar00): gboolean {.
    importc, libprag.}

proc getShowCloseButton*(self: HeaderBar): bool =
  toBool(hdy_header_bar_get_show_close_button(cast[ptr HeaderBar00](self.impl)))

proc showCloseButton*(self: HeaderBar): bool =
  toBool(hdy_header_bar_get_show_close_button(cast[ptr HeaderBar00](self.impl)))

proc hdy_header_bar_get_subtitle(self: ptr HeaderBar00): cstring {.
    importc, libprag.}

proc getSubtitle*(self: HeaderBar): string =
  let resul0 = hdy_header_bar_get_subtitle(cast[ptr HeaderBar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc subtitle*(self: HeaderBar): string =
  let resul0 = hdy_header_bar_get_subtitle(cast[ptr HeaderBar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_header_bar_get_title(self: ptr HeaderBar00): cstring {.
    importc, libprag.}

proc getTitle*(self: HeaderBar): string =
  let resul0 = hdy_header_bar_get_title(cast[ptr HeaderBar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc title*(self: HeaderBar): string =
  let resul0 = hdy_header_bar_get_title(cast[ptr HeaderBar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_header_bar_get_transition_duration(self: ptr HeaderBar00): uint32 {.
    importc, libprag.}

proc getTransitionDuration*(self: HeaderBar): int =
  int(hdy_header_bar_get_transition_duration(cast[ptr HeaderBar00](self.impl)))

proc transitionDuration*(self: HeaderBar): int =
  int(hdy_header_bar_get_transition_duration(cast[ptr HeaderBar00](self.impl)))

proc hdy_header_bar_get_transition_running(self: ptr HeaderBar00): gboolean {.
    importc, libprag.}

proc getTransitionRunning*(self: HeaderBar): bool =
  toBool(hdy_header_bar_get_transition_running(cast[ptr HeaderBar00](self.impl)))

proc transitionRunning*(self: HeaderBar): bool =
  toBool(hdy_header_bar_get_transition_running(cast[ptr HeaderBar00](self.impl)))

proc hdy_header_bar_pack_end(self: ptr HeaderBar00; child: ptr gtk.Widget00) {.
    importc, libprag.}

proc packEnd*(self: HeaderBar; child: gtk.Widget) =
  hdy_header_bar_pack_end(cast[ptr HeaderBar00](self.impl), cast[ptr gtk.Widget00](child.impl))

proc hdy_header_bar_pack_start(self: ptr HeaderBar00; child: ptr gtk.Widget00) {.
    importc, libprag.}

proc packStart*(self: HeaderBar; child: gtk.Widget) =
  hdy_header_bar_pack_start(cast[ptr HeaderBar00](self.impl), cast[ptr gtk.Widget00](child.impl))

proc hdy_header_bar_set_centering_policy(self: ptr HeaderBar00; centeringPolicy: CenteringPolicy) {.
    importc, libprag.}

proc setCenteringPolicy*(self: HeaderBar; centeringPolicy: CenteringPolicy) =
  hdy_header_bar_set_centering_policy(cast[ptr HeaderBar00](self.impl), centeringPolicy)

proc `centeringPolicy=`*(self: HeaderBar; centeringPolicy: CenteringPolicy) =
  hdy_header_bar_set_centering_policy(cast[ptr HeaderBar00](self.impl), centeringPolicy)

proc hdy_header_bar_set_custom_title(self: ptr HeaderBar00; titleWidget: ptr gtk.Widget00) {.
    importc, libprag.}

proc setCustomTitle*(self: HeaderBar; titleWidget: gtk.Widget = nil) =
  hdy_header_bar_set_custom_title(cast[ptr HeaderBar00](self.impl), if titleWidget.isNil: nil else: cast[ptr gtk.Widget00](titleWidget.impl))

proc `customTitle=`*(self: HeaderBar; titleWidget: gtk.Widget = nil) =
  hdy_header_bar_set_custom_title(cast[ptr HeaderBar00](self.impl), if titleWidget.isNil: nil else: cast[ptr gtk.Widget00](titleWidget.impl))

proc hdy_header_bar_set_decoration_layout(self: ptr HeaderBar00; layout: cstring) {.
    importc, libprag.}

proc setDecorationLayout*(self: HeaderBar; layout: cstring = nil) =
  hdy_header_bar_set_decoration_layout(cast[ptr HeaderBar00](self.impl), layout)

proc `decorationLayout=`*(self: HeaderBar; layout: cstring = nil) =
  hdy_header_bar_set_decoration_layout(cast[ptr HeaderBar00](self.impl), layout)

proc hdy_header_bar_set_has_subtitle(self: ptr HeaderBar00; setting: gboolean) {.
    importc, libprag.}

proc setHasSubtitle*(self: HeaderBar; setting: bool = true) =
  hdy_header_bar_set_has_subtitle(cast[ptr HeaderBar00](self.impl), gboolean(setting))

proc `hasSubtitle=`*(self: HeaderBar; setting: bool) =
  hdy_header_bar_set_has_subtitle(cast[ptr HeaderBar00](self.impl), gboolean(setting))

proc hdy_header_bar_set_interpolate_size(self: ptr HeaderBar00; interpolateSize: gboolean) {.
    importc, libprag.}

proc setInterpolateSize*(self: HeaderBar; interpolateSize: bool = true) =
  hdy_header_bar_set_interpolate_size(cast[ptr HeaderBar00](self.impl), gboolean(interpolateSize))

proc `interpolateSize=`*(self: HeaderBar; interpolateSize: bool) =
  hdy_header_bar_set_interpolate_size(cast[ptr HeaderBar00](self.impl), gboolean(interpolateSize))

proc hdy_header_bar_set_show_close_button(self: ptr HeaderBar00; setting: gboolean) {.
    importc, libprag.}

proc setShowCloseButton*(self: HeaderBar; setting: bool = true) =
  hdy_header_bar_set_show_close_button(cast[ptr HeaderBar00](self.impl), gboolean(setting))

proc `showCloseButton=`*(self: HeaderBar; setting: bool) =
  hdy_header_bar_set_show_close_button(cast[ptr HeaderBar00](self.impl), gboolean(setting))

proc hdy_header_bar_set_subtitle(self: ptr HeaderBar00; subtitle: cstring) {.
    importc, libprag.}

proc setSubtitle*(self: HeaderBar; subtitle: cstring = nil) =
  hdy_header_bar_set_subtitle(cast[ptr HeaderBar00](self.impl), subtitle)

proc `subtitle=`*(self: HeaderBar; subtitle: cstring = nil) =
  hdy_header_bar_set_subtitle(cast[ptr HeaderBar00](self.impl), subtitle)

proc hdy_header_bar_set_title(self: ptr HeaderBar00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: HeaderBar; title: cstring = nil) =
  hdy_header_bar_set_title(cast[ptr HeaderBar00](self.impl), title)

proc `title=`*(self: HeaderBar; title: cstring = nil) =
  hdy_header_bar_set_title(cast[ptr HeaderBar00](self.impl), title)

proc hdy_header_bar_set_transition_duration(self: ptr HeaderBar00; duration: uint32) {.
    importc, libprag.}

proc setTransitionDuration*(self: HeaderBar; duration: int) =
  hdy_header_bar_set_transition_duration(cast[ptr HeaderBar00](self.impl), uint32(duration))

proc `transitionDuration=`*(self: HeaderBar; duration: int) =
  hdy_header_bar_set_transition_duration(cast[ptr HeaderBar00](self.impl), uint32(duration))

type
  HeaderGroup* = ref object of gobject.Object
  HeaderGroup00* = object of gobject.Object00

proc hdy_header_group_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HeaderGroup()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scUpdateDecorationLayouts*(self: HeaderGroup;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "update-decoration-layouts", cast[GCallback](p), xdata, nil, cf)

proc hdy_header_group_new(): ptr HeaderGroup00 {.
    importc, libprag.}

proc newHeaderGroup*(): HeaderGroup =
  let gobj = hdy_header_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHeaderGroup*(tdesc: typedesc): tdesc =
  assert(result is HeaderGroup)
  let gobj = hdy_header_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHeaderGroup*[T](result: var T) {.deprecated.} =
  assert(result is HeaderGroup)
  let gobj = hdy_header_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_header_group_add_gtk_header_bar(self: ptr HeaderGroup00; headerBar: ptr gtk.HeaderBar00) {.
    importc, libprag.}

proc addGtkHeaderBar*(self: HeaderGroup; headerBar: gtk.HeaderBar) =
  hdy_header_group_add_gtk_header_bar(cast[ptr HeaderGroup00](self.impl), cast[ptr gtk.HeaderBar00](headerBar.impl))

proc hdy_header_group_add_header_bar(self: ptr HeaderGroup00; headerBar: ptr HeaderBar00) {.
    importc, libprag.}

proc addHeaderBar*(self: HeaderGroup; headerBar: HeaderBar) =
  hdy_header_group_add_header_bar(cast[ptr HeaderGroup00](self.impl), cast[ptr HeaderBar00](headerBar.impl))

proc hdy_header_group_add_header_group(self: ptr HeaderGroup00; headerGroup: ptr HeaderGroup00) {.
    importc, libprag.}

proc addHeaderGroup*(self: HeaderGroup; headerGroup: HeaderGroup) =
  hdy_header_group_add_header_group(cast[ptr HeaderGroup00](self.impl), cast[ptr HeaderGroup00](headerGroup.impl))

proc hdy_header_group_get_decorate_all(self: ptr HeaderGroup00): gboolean {.
    importc, libprag.}

proc getDecorateAll*(self: HeaderGroup): bool =
  toBool(hdy_header_group_get_decorate_all(cast[ptr HeaderGroup00](self.impl)))

proc decorateAll*(self: HeaderGroup): bool =
  toBool(hdy_header_group_get_decorate_all(cast[ptr HeaderGroup00](self.impl)))

proc hdy_header_group_remove_gtk_header_bar(self: ptr HeaderGroup00; headerBar: ptr gtk.HeaderBar00) {.
    importc, libprag.}

proc removeGtkHeaderBar*(self: HeaderGroup; headerBar: gtk.HeaderBar) =
  hdy_header_group_remove_gtk_header_bar(cast[ptr HeaderGroup00](self.impl), cast[ptr gtk.HeaderBar00](headerBar.impl))

proc hdy_header_group_remove_header_bar(self: ptr HeaderGroup00; headerBar: ptr HeaderBar00) {.
    importc, libprag.}

proc removeHeaderBar*(self: HeaderGroup; headerBar: HeaderBar) =
  hdy_header_group_remove_header_bar(cast[ptr HeaderGroup00](self.impl), cast[ptr HeaderBar00](headerBar.impl))

proc hdy_header_group_remove_header_group(self: ptr HeaderGroup00; headerGroup: ptr HeaderGroup00) {.
    importc, libprag.}

proc removeHeaderGroup*(self: HeaderGroup; headerGroup: HeaderGroup) =
  hdy_header_group_remove_header_group(cast[ptr HeaderGroup00](self.impl), cast[ptr HeaderGroup00](headerGroup.impl))

proc hdy_header_group_set_decorate_all(self: ptr HeaderGroup00; decorateAll: gboolean) {.
    importc, libprag.}

proc setDecorateAll*(self: HeaderGroup; decorateAll: bool = true) =
  hdy_header_group_set_decorate_all(cast[ptr HeaderGroup00](self.impl), gboolean(decorateAll))

proc `decorateAll=`*(self: HeaderGroup; decorateAll: bool) =
  hdy_header_group_set_decorate_all(cast[ptr HeaderGroup00](self.impl), gboolean(decorateAll))

type
  HeaderGroupChild* = ref object of gobject.Object
  HeaderGroupChild00* = object of gobject.Object00

proc hdy_header_group_child_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HeaderGroupChild()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_header_group_child_get_gtk_header_bar(self: ptr HeaderGroupChild00): ptr gtk.HeaderBar00 {.
    importc, libprag.}

proc getGtkHeaderBar*(self: HeaderGroupChild): gtk.HeaderBar =
  let gobj = hdy_header_group_child_get_gtk_header_bar(cast[ptr HeaderGroupChild00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtkHeaderBar*(self: HeaderGroupChild): gtk.HeaderBar =
  let gobj = hdy_header_group_child_get_gtk_header_bar(cast[ptr HeaderGroupChild00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_header_group_child_get_header_bar(self: ptr HeaderGroupChild00): ptr HeaderBar00 {.
    importc, libprag.}

proc getHeaderBar*(self: HeaderGroupChild): HeaderBar =
  let gobj = hdy_header_group_child_get_header_bar(cast[ptr HeaderGroupChild00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc headerBar*(self: HeaderGroupChild): HeaderBar =
  let gobj = hdy_header_group_child_get_header_bar(cast[ptr HeaderGroupChild00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_header_group_child_get_header_group(self: ptr HeaderGroupChild00): ptr HeaderGroup00 {.
    importc, libprag.}

proc getHeaderGroup*(self: HeaderGroupChild): HeaderGroup =
  let gobj = hdy_header_group_child_get_header_group(cast[ptr HeaderGroupChild00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc headerGroup*(self: HeaderGroupChild): HeaderGroup =
  let gobj = hdy_header_group_child_get_header_group(cast[ptr HeaderGroupChild00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_header_group_get_children(self: ptr HeaderGroup00): ptr glib.SList {.
    importc, libprag.}

proc getChildren*(self: HeaderGroup): seq[HeaderGroupChild] =
  result = gslistObjects2seq(HeaderGroupChild, hdy_header_group_get_children(cast[ptr HeaderGroup00](self.impl)), false)

proc children*(self: HeaderGroup): seq[HeaderGroupChild] =
  result = gslistObjects2seq(HeaderGroupChild, hdy_header_group_get_children(cast[ptr HeaderGroup00](self.impl)), false)

proc hdy_header_group_remove_child(self: ptr HeaderGroup00; child: ptr HeaderGroupChild00) {.
    importc, libprag.}

proc removeChild*(self: HeaderGroup; child: HeaderGroupChild) =
  hdy_header_group_remove_child(cast[ptr HeaderGroup00](self.impl), cast[ptr HeaderGroupChild00](child.impl))

type
  HeaderGroupChildType* {.size: sizeof(cint), pure.} = enum
    headerBar = 0
    gtkHeaderBar = 1
    headerGroup = 2

proc hdy_header_group_child_get_child_type(self: ptr HeaderGroupChild00): HeaderGroupChildType {.
    importc, libprag.}

proc getChildType*(self: HeaderGroupChild): HeaderGroupChildType =
  hdy_header_group_child_get_child_type(cast[ptr HeaderGroupChild00](self.impl))

proc childType*(self: HeaderGroupChild): HeaderGroupChildType =
  hdy_header_group_child_get_child_type(cast[ptr HeaderGroupChild00](self.impl))

type
  Keypad* = ref object of gtk.Bin
  Keypad00* = object of gtk.Bin00

proc hdy_keypad_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Keypad()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_keypad_new(symbolsVisible: gboolean; lettersVisible: gboolean): ptr Keypad00 {.
    importc, libprag.}

proc newKeypad*(symbolsVisible: bool; lettersVisible: bool): Keypad =
  let gobj = hdy_keypad_new(gboolean(symbolsVisible), gboolean(lettersVisible))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newKeypad*(tdesc: typedesc; symbolsVisible: bool; lettersVisible: bool): tdesc =
  assert(result is Keypad)
  let gobj = hdy_keypad_new(gboolean(symbolsVisible), gboolean(lettersVisible))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initKeypad*[T](result: var T; symbolsVisible: bool; lettersVisible: bool) {.deprecated.} =
  assert(result is Keypad)
  let gobj = hdy_keypad_new(gboolean(symbolsVisible), gboolean(lettersVisible))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_keypad_get_column_spacing(self: ptr Keypad00): uint32 {.
    importc, libprag.}

proc getColumnSpacing*(self: Keypad): int =
  int(hdy_keypad_get_column_spacing(cast[ptr Keypad00](self.impl)))

proc columnSpacing*(self: Keypad): int =
  int(hdy_keypad_get_column_spacing(cast[ptr Keypad00](self.impl)))

proc hdy_keypad_get_end_action(self: ptr Keypad00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getEndAction*(self: Keypad): gtk.Widget =
  let gobj = hdy_keypad_get_end_action(cast[ptr Keypad00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc endAction*(self: Keypad): gtk.Widget =
  let gobj = hdy_keypad_get_end_action(cast[ptr Keypad00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_keypad_get_entry(self: ptr Keypad00): ptr gtk.Entry00 {.
    importc, libprag.}

proc getEntry*(self: Keypad): gtk.Entry =
  let gobj = hdy_keypad_get_entry(cast[ptr Keypad00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc entry*(self: Keypad): gtk.Entry =
  let gobj = hdy_keypad_get_entry(cast[ptr Keypad00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_keypad_get_letters_visible(self: ptr Keypad00): gboolean {.
    importc, libprag.}

proc getLettersVisible*(self: Keypad): bool =
  toBool(hdy_keypad_get_letters_visible(cast[ptr Keypad00](self.impl)))

proc lettersVisible*(self: Keypad): bool =
  toBool(hdy_keypad_get_letters_visible(cast[ptr Keypad00](self.impl)))

proc hdy_keypad_get_row_spacing(self: ptr Keypad00): uint32 {.
    importc, libprag.}

proc getRowSpacing*(self: Keypad): int =
  int(hdy_keypad_get_row_spacing(cast[ptr Keypad00](self.impl)))

proc rowSpacing*(self: Keypad): int =
  int(hdy_keypad_get_row_spacing(cast[ptr Keypad00](self.impl)))

proc hdy_keypad_get_start_action(self: ptr Keypad00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getStartAction*(self: Keypad): gtk.Widget =
  let gobj = hdy_keypad_get_start_action(cast[ptr Keypad00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc startAction*(self: Keypad): gtk.Widget =
  let gobj = hdy_keypad_get_start_action(cast[ptr Keypad00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_keypad_get_symbols_visible(self: ptr Keypad00): gboolean {.
    importc, libprag.}

proc getSymbolsVisible*(self: Keypad): bool =
  toBool(hdy_keypad_get_symbols_visible(cast[ptr Keypad00](self.impl)))

proc symbolsVisible*(self: Keypad): bool =
  toBool(hdy_keypad_get_symbols_visible(cast[ptr Keypad00](self.impl)))

proc hdy_keypad_set_column_spacing(self: ptr Keypad00; spacing: uint32) {.
    importc, libprag.}

proc setColumnSpacing*(self: Keypad; spacing: int) =
  hdy_keypad_set_column_spacing(cast[ptr Keypad00](self.impl), uint32(spacing))

proc `columnSpacing=`*(self: Keypad; spacing: int) =
  hdy_keypad_set_column_spacing(cast[ptr Keypad00](self.impl), uint32(spacing))

proc hdy_keypad_set_end_action(self: ptr Keypad00; endAction: ptr gtk.Widget00) {.
    importc, libprag.}

proc setEndAction*(self: Keypad; endAction: gtk.Widget = nil) =
  hdy_keypad_set_end_action(cast[ptr Keypad00](self.impl), if endAction.isNil: nil else: cast[ptr gtk.Widget00](endAction.impl))

proc `endAction=`*(self: Keypad; endAction: gtk.Widget = nil) =
  hdy_keypad_set_end_action(cast[ptr Keypad00](self.impl), if endAction.isNil: nil else: cast[ptr gtk.Widget00](endAction.impl))

proc hdy_keypad_set_entry(self: ptr Keypad00; entry: ptr gtk.Entry00) {.
    importc, libprag.}

proc setEntry*(self: Keypad; entry: gtk.Entry = nil) =
  hdy_keypad_set_entry(cast[ptr Keypad00](self.impl), if entry.isNil: nil else: cast[ptr gtk.Entry00](entry.impl))

proc `entry=`*(self: Keypad; entry: gtk.Entry = nil) =
  hdy_keypad_set_entry(cast[ptr Keypad00](self.impl), if entry.isNil: nil else: cast[ptr gtk.Entry00](entry.impl))

proc hdy_keypad_set_letters_visible(self: ptr Keypad00; lettersVisible: gboolean) {.
    importc, libprag.}

proc setLettersVisible*(self: Keypad; lettersVisible: bool = true) =
  hdy_keypad_set_letters_visible(cast[ptr Keypad00](self.impl), gboolean(lettersVisible))

proc `lettersVisible=`*(self: Keypad; lettersVisible: bool) =
  hdy_keypad_set_letters_visible(cast[ptr Keypad00](self.impl), gboolean(lettersVisible))

proc hdy_keypad_set_row_spacing(self: ptr Keypad00; spacing: uint32) {.
    importc, libprag.}

proc setRowSpacing*(self: Keypad; spacing: int) =
  hdy_keypad_set_row_spacing(cast[ptr Keypad00](self.impl), uint32(spacing))

proc `rowSpacing=`*(self: Keypad; spacing: int) =
  hdy_keypad_set_row_spacing(cast[ptr Keypad00](self.impl), uint32(spacing))

proc hdy_keypad_set_start_action(self: ptr Keypad00; startAction: ptr gtk.Widget00) {.
    importc, libprag.}

proc setStartAction*(self: Keypad; startAction: gtk.Widget = nil) =
  hdy_keypad_set_start_action(cast[ptr Keypad00](self.impl), if startAction.isNil: nil else: cast[ptr gtk.Widget00](startAction.impl))

proc `startAction=`*(self: Keypad; startAction: gtk.Widget = nil) =
  hdy_keypad_set_start_action(cast[ptr Keypad00](self.impl), if startAction.isNil: nil else: cast[ptr gtk.Widget00](startAction.impl))

proc hdy_keypad_set_symbols_visible(self: ptr Keypad00; symbolsVisible: gboolean) {.
    importc, libprag.}

proc setSymbolsVisible*(self: Keypad; symbolsVisible: bool = true) =
  hdy_keypad_set_symbols_visible(cast[ptr Keypad00](self.impl), gboolean(symbolsVisible))

proc `symbolsVisible=`*(self: Keypad; symbolsVisible: bool) =
  hdy_keypad_set_symbols_visible(cast[ptr Keypad00](self.impl), gboolean(symbolsVisible))

type
  Leaflet* = ref object of gtk.Container
  Leaflet00* = object of gtk.Container00

proc hdy_leaflet_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Leaflet()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_leaflet_new(): ptr Leaflet00 {.
    importc, libprag.}

proc newLeaflet*(): Leaflet =
  let gobj = hdy_leaflet_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newLeaflet*(tdesc: typedesc): tdesc =
  assert(result is Leaflet)
  let gobj = hdy_leaflet_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initLeaflet*[T](result: var T) {.deprecated.} =
  assert(result is Leaflet)
  let gobj = hdy_leaflet_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_leaflet_get_adjacent_child(self: ptr Leaflet00; direction: NavigationDirection): ptr gtk.Widget00 {.
    importc, libprag.}

proc getAdjacentChild*(self: Leaflet; direction: NavigationDirection): gtk.Widget =
  let gobj = hdy_leaflet_get_adjacent_child(cast[ptr Leaflet00](self.impl), direction)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_leaflet_get_can_swipe_back(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getCanSwipeBack*(self: Leaflet): bool =
  toBool(hdy_leaflet_get_can_swipe_back(cast[ptr Leaflet00](self.impl)))

proc canSwipeBack*(self: Leaflet): bool =
  toBool(hdy_leaflet_get_can_swipe_back(cast[ptr Leaflet00](self.impl)))

proc hdy_leaflet_get_can_swipe_forward(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getCanSwipeForward*(self: Leaflet): bool =
  toBool(hdy_leaflet_get_can_swipe_forward(cast[ptr Leaflet00](self.impl)))

proc canSwipeForward*(self: Leaflet): bool =
  toBool(hdy_leaflet_get_can_swipe_forward(cast[ptr Leaflet00](self.impl)))

proc hdy_leaflet_get_child_by_name(self: ptr Leaflet00; name: cstring): ptr gtk.Widget00 {.
    importc, libprag.}

proc getChildByName*(self: Leaflet; name: cstring): gtk.Widget =
  let gobj = hdy_leaflet_get_child_by_name(cast[ptr Leaflet00](self.impl), name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_leaflet_get_child_transition_duration(self: ptr Leaflet00): uint32 {.
    importc, libprag.}

proc getChildTransitionDuration*(self: Leaflet): int =
  int(hdy_leaflet_get_child_transition_duration(cast[ptr Leaflet00](self.impl)))

proc childTransitionDuration*(self: Leaflet): int =
  int(hdy_leaflet_get_child_transition_duration(cast[ptr Leaflet00](self.impl)))

proc hdy_leaflet_get_child_transition_running(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getChildTransitionRunning*(self: Leaflet): bool =
  toBool(hdy_leaflet_get_child_transition_running(cast[ptr Leaflet00](self.impl)))

proc childTransitionRunning*(self: Leaflet): bool =
  toBool(hdy_leaflet_get_child_transition_running(cast[ptr Leaflet00](self.impl)))

proc hdy_leaflet_get_folded(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getFolded*(self: Leaflet): bool =
  toBool(hdy_leaflet_get_folded(cast[ptr Leaflet00](self.impl)))

proc folded*(self: Leaflet): bool =
  toBool(hdy_leaflet_get_folded(cast[ptr Leaflet00](self.impl)))

proc hdy_leaflet_get_homogeneous(self: ptr Leaflet00; folded: gboolean; orientation: gtk.Orientation): gboolean {.
    importc, libprag.}

proc getHomogeneous*(self: Leaflet; folded: bool; orientation: gtk.Orientation): bool =
  toBool(hdy_leaflet_get_homogeneous(cast[ptr Leaflet00](self.impl), gboolean(folded), orientation))

proc hdy_leaflet_get_interpolate_size(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getInterpolateSize*(self: Leaflet): bool =
  toBool(hdy_leaflet_get_interpolate_size(cast[ptr Leaflet00](self.impl)))

proc interpolateSize*(self: Leaflet): bool =
  toBool(hdy_leaflet_get_interpolate_size(cast[ptr Leaflet00](self.impl)))

proc hdy_leaflet_get_mode_transition_duration(self: ptr Leaflet00): uint32 {.
    importc, libprag.}

proc getModeTransitionDuration*(self: Leaflet): int =
  int(hdy_leaflet_get_mode_transition_duration(cast[ptr Leaflet00](self.impl)))

proc modeTransitionDuration*(self: Leaflet): int =
  int(hdy_leaflet_get_mode_transition_duration(cast[ptr Leaflet00](self.impl)))

proc hdy_leaflet_get_visible_child(self: ptr Leaflet00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getVisibleChild*(self: Leaflet): gtk.Widget =
  let gobj = hdy_leaflet_get_visible_child(cast[ptr Leaflet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visibleChild*(self: Leaflet): gtk.Widget =
  let gobj = hdy_leaflet_get_visible_child(cast[ptr Leaflet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_leaflet_get_visible_child_name(self: ptr Leaflet00): cstring {.
    importc, libprag.}

proc getVisibleChildName*(self: Leaflet): string =
  result = $hdy_leaflet_get_visible_child_name(cast[ptr Leaflet00](self.impl))

proc visibleChildName*(self: Leaflet): string =
  result = $hdy_leaflet_get_visible_child_name(cast[ptr Leaflet00](self.impl))

proc hdy_leaflet_insert_child_after(self: ptr Leaflet00; child: ptr gtk.Widget00;
    sibling: ptr gtk.Widget00) {.
    importc, libprag.}

proc insertChildAfter*(self: Leaflet; child: gtk.Widget; sibling: gtk.Widget = nil) =
  hdy_leaflet_insert_child_after(cast[ptr Leaflet00](self.impl), cast[ptr gtk.Widget00](child.impl), if sibling.isNil: nil else: cast[ptr gtk.Widget00](sibling.impl))

proc hdy_leaflet_navigate(self: ptr Leaflet00; direction: NavigationDirection): gboolean {.
    importc, libprag.}

proc navigate*(self: Leaflet; direction: NavigationDirection): bool =
  toBool(hdy_leaflet_navigate(cast[ptr Leaflet00](self.impl), direction))

proc hdy_leaflet_prepend(self: ptr Leaflet00; child: ptr gtk.Widget00) {.
    importc, libprag.}

proc prepend*(self: Leaflet; child: gtk.Widget) =
  hdy_leaflet_prepend(cast[ptr Leaflet00](self.impl), cast[ptr gtk.Widget00](child.impl))

proc hdy_leaflet_reorder_child_after(self: ptr Leaflet00; child: ptr gtk.Widget00;
    sibling: ptr gtk.Widget00) {.
    importc, libprag.}

proc reorderChildAfter*(self: Leaflet; child: gtk.Widget; sibling: gtk.Widget = nil) =
  hdy_leaflet_reorder_child_after(cast[ptr Leaflet00](self.impl), cast[ptr gtk.Widget00](child.impl), if sibling.isNil: nil else: cast[ptr gtk.Widget00](sibling.impl))

proc hdy_leaflet_set_can_swipe_back(self: ptr Leaflet00; canSwipeBack: gboolean) {.
    importc, libprag.}

proc setCanSwipeBack*(self: Leaflet; canSwipeBack: bool = true) =
  hdy_leaflet_set_can_swipe_back(cast[ptr Leaflet00](self.impl), gboolean(canSwipeBack))

proc `canSwipeBack=`*(self: Leaflet; canSwipeBack: bool) =
  hdy_leaflet_set_can_swipe_back(cast[ptr Leaflet00](self.impl), gboolean(canSwipeBack))

proc hdy_leaflet_set_can_swipe_forward(self: ptr Leaflet00; canSwipeForward: gboolean) {.
    importc, libprag.}

proc setCanSwipeForward*(self: Leaflet; canSwipeForward: bool = true) =
  hdy_leaflet_set_can_swipe_forward(cast[ptr Leaflet00](self.impl), gboolean(canSwipeForward))

proc `canSwipeForward=`*(self: Leaflet; canSwipeForward: bool) =
  hdy_leaflet_set_can_swipe_forward(cast[ptr Leaflet00](self.impl), gboolean(canSwipeForward))

proc hdy_leaflet_set_child_transition_duration(self: ptr Leaflet00; duration: uint32) {.
    importc, libprag.}

proc setChildTransitionDuration*(self: Leaflet; duration: int) =
  hdy_leaflet_set_child_transition_duration(cast[ptr Leaflet00](self.impl), uint32(duration))

proc `childTransitionDuration=`*(self: Leaflet; duration: int) =
  hdy_leaflet_set_child_transition_duration(cast[ptr Leaflet00](self.impl), uint32(duration))

proc hdy_leaflet_set_homogeneous(self: ptr Leaflet00; folded: gboolean; orientation: gtk.Orientation;
    homogeneous: gboolean) {.
    importc, libprag.}

proc setHomogeneous*(self: Leaflet; folded: bool; orientation: gtk.Orientation;
    homogeneous: bool) =
  hdy_leaflet_set_homogeneous(cast[ptr Leaflet00](self.impl), gboolean(folded), orientation, gboolean(homogeneous))

proc hdy_leaflet_set_interpolate_size(self: ptr Leaflet00; interpolateSize: gboolean) {.
    importc, libprag.}

proc setInterpolateSize*(self: Leaflet; interpolateSize: bool = true) =
  hdy_leaflet_set_interpolate_size(cast[ptr Leaflet00](self.impl), gboolean(interpolateSize))

proc `interpolateSize=`*(self: Leaflet; interpolateSize: bool) =
  hdy_leaflet_set_interpolate_size(cast[ptr Leaflet00](self.impl), gboolean(interpolateSize))

proc hdy_leaflet_set_mode_transition_duration(self: ptr Leaflet00; duration: uint32) {.
    importc, libprag.}

proc setModeTransitionDuration*(self: Leaflet; duration: int) =
  hdy_leaflet_set_mode_transition_duration(cast[ptr Leaflet00](self.impl), uint32(duration))

proc `modeTransitionDuration=`*(self: Leaflet; duration: int) =
  hdy_leaflet_set_mode_transition_duration(cast[ptr Leaflet00](self.impl), uint32(duration))

proc hdy_leaflet_set_visible_child(self: ptr Leaflet00; visibleChild: ptr gtk.Widget00) {.
    importc, libprag.}

proc setVisibleChild*(self: Leaflet; visibleChild: gtk.Widget) =
  hdy_leaflet_set_visible_child(cast[ptr Leaflet00](self.impl), cast[ptr gtk.Widget00](visibleChild.impl))

proc `visibleChild=`*(self: Leaflet; visibleChild: gtk.Widget) =
  hdy_leaflet_set_visible_child(cast[ptr Leaflet00](self.impl), cast[ptr gtk.Widget00](visibleChild.impl))

proc hdy_leaflet_set_visible_child_name(self: ptr Leaflet00; name: cstring) {.
    importc, libprag.}

proc setVisibleChildName*(self: Leaflet; name: cstring) =
  hdy_leaflet_set_visible_child_name(cast[ptr Leaflet00](self.impl), name)

proc `visibleChildName=`*(self: Leaflet; name: cstring) =
  hdy_leaflet_set_visible_child_name(cast[ptr Leaflet00](self.impl), name)

type
  LeafletTransitionType* {.size: sizeof(cint), pure.} = enum
    over = 0
    under = 1
    slide = 2

proc hdy_leaflet_get_transition_type(self: ptr Leaflet00): LeafletTransitionType {.
    importc, libprag.}

proc getTransitionType*(self: Leaflet): LeafletTransitionType =
  hdy_leaflet_get_transition_type(cast[ptr Leaflet00](self.impl))

proc transitionType*(self: Leaflet): LeafletTransitionType =
  hdy_leaflet_get_transition_type(cast[ptr Leaflet00](self.impl))

proc hdy_leaflet_set_transition_type(self: ptr Leaflet00; transition: LeafletTransitionType) {.
    importc, libprag.}

proc setTransitionType*(self: Leaflet; transition: LeafletTransitionType) =
  hdy_leaflet_set_transition_type(cast[ptr Leaflet00](self.impl), transition)

proc `transitionType=`*(self: Leaflet; transition: LeafletTransitionType) =
  hdy_leaflet_set_transition_type(cast[ptr Leaflet00](self.impl), transition)

type
  PreferencesGroup* = ref object of gtk.Bin
  PreferencesGroup00* = object of gtk.Bin00

proc hdy_preferences_group_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PreferencesGroup()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_preferences_group_new(): ptr PreferencesGroup00 {.
    importc, libprag.}

proc newPreferencesGroup*(): PreferencesGroup =
  let gobj = hdy_preferences_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPreferencesGroup*(tdesc: typedesc): tdesc =
  assert(result is PreferencesGroup)
  let gobj = hdy_preferences_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPreferencesGroup*[T](result: var T) {.deprecated.} =
  assert(result is PreferencesGroup)
  let gobj = hdy_preferences_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_preferences_group_get_description(self: ptr PreferencesGroup00): cstring {.
    importc, libprag.}

proc getDescription*(self: PreferencesGroup): string =
  result = $hdy_preferences_group_get_description(cast[ptr PreferencesGroup00](self.impl))

proc description*(self: PreferencesGroup): string =
  result = $hdy_preferences_group_get_description(cast[ptr PreferencesGroup00](self.impl))

proc hdy_preferences_group_get_title(self: ptr PreferencesGroup00): cstring {.
    importc, libprag.}

proc getTitle*(self: PreferencesGroup): string =
  result = $hdy_preferences_group_get_title(cast[ptr PreferencesGroup00](self.impl))

proc title*(self: PreferencesGroup): string =
  result = $hdy_preferences_group_get_title(cast[ptr PreferencesGroup00](self.impl))

proc hdy_preferences_group_get_use_markup(self: ptr PreferencesGroup00): gboolean {.
    importc, libprag.}

proc getUseMarkup*(self: PreferencesGroup): bool =
  toBool(hdy_preferences_group_get_use_markup(cast[ptr PreferencesGroup00](self.impl)))

proc useMarkup*(self: PreferencesGroup): bool =
  toBool(hdy_preferences_group_get_use_markup(cast[ptr PreferencesGroup00](self.impl)))

proc hdy_preferences_group_set_description(self: ptr PreferencesGroup00;
    description: cstring) {.
    importc, libprag.}

proc setDescription*(self: PreferencesGroup; description: cstring) =
  hdy_preferences_group_set_description(cast[ptr PreferencesGroup00](self.impl), description)

proc `description=`*(self: PreferencesGroup; description: cstring) =
  hdy_preferences_group_set_description(cast[ptr PreferencesGroup00](self.impl), description)

proc hdy_preferences_group_set_title(self: ptr PreferencesGroup00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: PreferencesGroup; title: cstring) =
  hdy_preferences_group_set_title(cast[ptr PreferencesGroup00](self.impl), title)

proc `title=`*(self: PreferencesGroup; title: cstring) =
  hdy_preferences_group_set_title(cast[ptr PreferencesGroup00](self.impl), title)

proc hdy_preferences_group_set_use_markup(self: ptr PreferencesGroup00; useMarkup: gboolean) {.
    importc, libprag.}

proc setUseMarkup*(self: PreferencesGroup; useMarkup: bool = true) =
  hdy_preferences_group_set_use_markup(cast[ptr PreferencesGroup00](self.impl), gboolean(useMarkup))

proc `useMarkup=`*(self: PreferencesGroup; useMarkup: bool) =
  hdy_preferences_group_set_use_markup(cast[ptr PreferencesGroup00](self.impl), gboolean(useMarkup))

type
  PreferencesPage* = ref object of gtk.Bin
  PreferencesPage00* = object of gtk.Bin00

proc hdy_preferences_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PreferencesPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_preferences_page_new(): ptr PreferencesPage00 {.
    importc, libprag.}

proc newPreferencesPage*(): PreferencesPage =
  let gobj = hdy_preferences_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPreferencesPage*(tdesc: typedesc): tdesc =
  assert(result is PreferencesPage)
  let gobj = hdy_preferences_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPreferencesPage*[T](result: var T) {.deprecated.} =
  assert(result is PreferencesPage)
  let gobj = hdy_preferences_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_preferences_page_get_icon_name(self: ptr PreferencesPage00): cstring {.
    importc, libprag.}

proc getIconName*(self: PreferencesPage): string =
  let resul0 = hdy_preferences_page_get_icon_name(cast[ptr PreferencesPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: PreferencesPage): string =
  let resul0 = hdy_preferences_page_get_icon_name(cast[ptr PreferencesPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_preferences_page_get_title(self: ptr PreferencesPage00): cstring {.
    importc, libprag.}

proc getTitle*(self: PreferencesPage): string =
  let resul0 = hdy_preferences_page_get_title(cast[ptr PreferencesPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc title*(self: PreferencesPage): string =
  let resul0 = hdy_preferences_page_get_title(cast[ptr PreferencesPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_preferences_page_set_icon_name(self: ptr PreferencesPage00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: PreferencesPage; iconName: cstring = nil) =
  hdy_preferences_page_set_icon_name(cast[ptr PreferencesPage00](self.impl), iconName)

proc `iconName=`*(self: PreferencesPage; iconName: cstring = nil) =
  hdy_preferences_page_set_icon_name(cast[ptr PreferencesPage00](self.impl), iconName)

proc hdy_preferences_page_set_title(self: ptr PreferencesPage00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: PreferencesPage; title: cstring = nil) =
  hdy_preferences_page_set_title(cast[ptr PreferencesPage00](self.impl), title)

proc `title=`*(self: PreferencesPage; title: cstring = nil) =
  hdy_preferences_page_set_title(cast[ptr PreferencesPage00](self.impl), title)

type
  Window* = ref object of gtk.Window
  Window00* = object of gtk.Window00

proc hdy_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Window()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_window_new(): ptr Window00 {.
    importc, libprag.}

proc newWindow*(): Window =
  let gobj = hdy_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWindow*(tdesc: typedesc): tdesc =
  assert(result is Window)
  let gobj = hdy_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWindow*[T](result: var T) {.deprecated.} =
  assert(result is Window)
  let gobj = hdy_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PreferencesWindow* = ref object of Window
  PreferencesWindow00* = object of Window00

proc hdy_preferences_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PreferencesWindow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_preferences_window_new(): ptr PreferencesWindow00 {.
    importc, libprag.}

proc newPreferencesWindow*(): PreferencesWindow =
  let gobj = hdy_preferences_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPreferencesWindow*(tdesc: typedesc): tdesc =
  assert(result is PreferencesWindow)
  let gobj = hdy_preferences_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPreferencesWindow*[T](result: var T) {.deprecated.} =
  assert(result is PreferencesWindow)
  let gobj = hdy_preferences_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_preferences_window_close_subpage(self: ptr PreferencesWindow00) {.
    importc, libprag.}

proc closeSubpage*(self: PreferencesWindow) =
  hdy_preferences_window_close_subpage(cast[ptr PreferencesWindow00](self.impl))

proc hdy_preferences_window_get_can_swipe_back(self: ptr PreferencesWindow00): gboolean {.
    importc, libprag.}

proc getCanSwipeBack*(self: PreferencesWindow): bool =
  toBool(hdy_preferences_window_get_can_swipe_back(cast[ptr PreferencesWindow00](self.impl)))

proc canSwipeBack*(self: PreferencesWindow): bool =
  toBool(hdy_preferences_window_get_can_swipe_back(cast[ptr PreferencesWindow00](self.impl)))

proc hdy_preferences_window_get_search_enabled(self: ptr PreferencesWindow00): gboolean {.
    importc, libprag.}

proc getSearchEnabled*(self: PreferencesWindow): bool =
  toBool(hdy_preferences_window_get_search_enabled(cast[ptr PreferencesWindow00](self.impl)))

proc searchEnabled*(self: PreferencesWindow): bool =
  toBool(hdy_preferences_window_get_search_enabled(cast[ptr PreferencesWindow00](self.impl)))

proc hdy_preferences_window_present_subpage(self: ptr PreferencesWindow00;
    subpage: ptr gtk.Widget00) {.
    importc, libprag.}

proc presentSubpage*(self: PreferencesWindow; subpage: gtk.Widget) =
  hdy_preferences_window_present_subpage(cast[ptr PreferencesWindow00](self.impl), cast[ptr gtk.Widget00](subpage.impl))

proc hdy_preferences_window_set_can_swipe_back(self: ptr PreferencesWindow00;
    canSwipeBack: gboolean) {.
    importc, libprag.}

proc setCanSwipeBack*(self: PreferencesWindow; canSwipeBack: bool = true) =
  hdy_preferences_window_set_can_swipe_back(cast[ptr PreferencesWindow00](self.impl), gboolean(canSwipeBack))

proc `canSwipeBack=`*(self: PreferencesWindow; canSwipeBack: bool) =
  hdy_preferences_window_set_can_swipe_back(cast[ptr PreferencesWindow00](self.impl), gboolean(canSwipeBack))

proc hdy_preferences_window_set_search_enabled(self: ptr PreferencesWindow00;
    searchEnabled: gboolean) {.
    importc, libprag.}

proc setSearchEnabled*(self: PreferencesWindow; searchEnabled: bool = true) =
  hdy_preferences_window_set_search_enabled(cast[ptr PreferencesWindow00](self.impl), gboolean(searchEnabled))

proc `searchEnabled=`*(self: PreferencesWindow; searchEnabled: bool) =
  hdy_preferences_window_set_search_enabled(cast[ptr PreferencesWindow00](self.impl), gboolean(searchEnabled))

type
  SearchBar* = ref object of gtk.Bin
  SearchBar00* = object of gtk.Bin00

proc hdy_search_bar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SearchBar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_search_bar_new(): ptr SearchBar00 {.
    importc, libprag.}

proc newSearchBar*(): SearchBar =
  let gobj = hdy_search_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSearchBar*(tdesc: typedesc): tdesc =
  assert(result is SearchBar)
  let gobj = hdy_search_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSearchBar*[T](result: var T) {.deprecated.} =
  assert(result is SearchBar)
  let gobj = hdy_search_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_search_bar_connect_entry(self: ptr SearchBar00; entry: ptr gtk.Entry00) {.
    importc, libprag.}

proc connectEntry*(self: SearchBar; entry: gtk.Entry) =
  hdy_search_bar_connect_entry(cast[ptr SearchBar00](self.impl), cast[ptr gtk.Entry00](entry.impl))

proc hdy_search_bar_get_search_mode(self: ptr SearchBar00): gboolean {.
    importc, libprag.}

proc getSearchMode*(self: SearchBar): bool =
  toBool(hdy_search_bar_get_search_mode(cast[ptr SearchBar00](self.impl)))

proc searchMode*(self: SearchBar): bool =
  toBool(hdy_search_bar_get_search_mode(cast[ptr SearchBar00](self.impl)))

proc hdy_search_bar_get_show_close_button(self: ptr SearchBar00): gboolean {.
    importc, libprag.}

proc getShowCloseButton*(self: SearchBar): bool =
  toBool(hdy_search_bar_get_show_close_button(cast[ptr SearchBar00](self.impl)))

proc showCloseButton*(self: SearchBar): bool =
  toBool(hdy_search_bar_get_show_close_button(cast[ptr SearchBar00](self.impl)))

proc hdy_search_bar_handle_event(self: ptr SearchBar00; event: ptr gdk.Event00): gboolean {.
    importc, libprag.}

proc handleEvent*(self: SearchBar; event: gdk.Event): bool =
  toBool(hdy_search_bar_handle_event(cast[ptr SearchBar00](self.impl), cast[ptr gdk.Event00](event.impl)))

proc hdy_search_bar_set_search_mode(self: ptr SearchBar00; searchMode: gboolean) {.
    importc, libprag.}

proc setSearchMode*(self: SearchBar; searchMode: bool = true) =
  hdy_search_bar_set_search_mode(cast[ptr SearchBar00](self.impl), gboolean(searchMode))

proc `searchMode=`*(self: SearchBar; searchMode: bool) =
  hdy_search_bar_set_search_mode(cast[ptr SearchBar00](self.impl), gboolean(searchMode))

proc hdy_search_bar_set_show_close_button(self: ptr SearchBar00; visible: gboolean) {.
    importc, libprag.}

proc setShowCloseButton*(self: SearchBar; visible: bool = true) =
  hdy_search_bar_set_show_close_button(cast[ptr SearchBar00](self.impl), gboolean(visible))

proc `showCloseButton=`*(self: SearchBar; visible: bool) =
  hdy_search_bar_set_show_close_button(cast[ptr SearchBar00](self.impl), gboolean(visible))

type
  Squeezer* = ref object of gtk.Container
  Squeezer00* = object of gtk.Container00

proc hdy_squeezer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Squeezer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_squeezer_new(): ptr Squeezer00 {.
    importc, libprag.}

proc newSqueezer*(): Squeezer =
  let gobj = hdy_squeezer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSqueezer*(tdesc: typedesc): tdesc =
  assert(result is Squeezer)
  let gobj = hdy_squeezer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSqueezer*[T](result: var T) {.deprecated.} =
  assert(result is Squeezer)
  let gobj = hdy_squeezer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_squeezer_get_child_enabled(self: ptr Squeezer00; child: ptr gtk.Widget00): gboolean {.
    importc, libprag.}

proc getChildEnabled*(self: Squeezer; child: gtk.Widget): bool =
  toBool(hdy_squeezer_get_child_enabled(cast[ptr Squeezer00](self.impl), cast[ptr gtk.Widget00](child.impl)))

proc hdy_squeezer_get_homogeneous(self: ptr Squeezer00): gboolean {.
    importc, libprag.}

proc getHomogeneous*(self: Squeezer): bool =
  toBool(hdy_squeezer_get_homogeneous(cast[ptr Squeezer00](self.impl)))

proc homogeneous*(self: Squeezer): bool =
  toBool(hdy_squeezer_get_homogeneous(cast[ptr Squeezer00](self.impl)))

proc hdy_squeezer_get_interpolate_size(self: ptr Squeezer00): gboolean {.
    importc, libprag.}

proc getInterpolateSize*(self: Squeezer): bool =
  toBool(hdy_squeezer_get_interpolate_size(cast[ptr Squeezer00](self.impl)))

proc interpolateSize*(self: Squeezer): bool =
  toBool(hdy_squeezer_get_interpolate_size(cast[ptr Squeezer00](self.impl)))

proc hdy_squeezer_get_transition_duration(self: ptr Squeezer00): uint32 {.
    importc, libprag.}

proc getTransitionDuration*(self: Squeezer): int =
  int(hdy_squeezer_get_transition_duration(cast[ptr Squeezer00](self.impl)))

proc transitionDuration*(self: Squeezer): int =
  int(hdy_squeezer_get_transition_duration(cast[ptr Squeezer00](self.impl)))

proc hdy_squeezer_get_transition_running(self: ptr Squeezer00): gboolean {.
    importc, libprag.}

proc getTransitionRunning*(self: Squeezer): bool =
  toBool(hdy_squeezer_get_transition_running(cast[ptr Squeezer00](self.impl)))

proc transitionRunning*(self: Squeezer): bool =
  toBool(hdy_squeezer_get_transition_running(cast[ptr Squeezer00](self.impl)))

proc hdy_squeezer_get_visible_child(self: ptr Squeezer00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getVisibleChild*(self: Squeezer): gtk.Widget =
  let gobj = hdy_squeezer_get_visible_child(cast[ptr Squeezer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visibleChild*(self: Squeezer): gtk.Widget =
  let gobj = hdy_squeezer_get_visible_child(cast[ptr Squeezer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_squeezer_get_xalign(self: ptr Squeezer00): cfloat {.
    importc, libprag.}

proc getXalign*(self: Squeezer): cfloat =
  hdy_squeezer_get_xalign(cast[ptr Squeezer00](self.impl))

proc xalign*(self: Squeezer): cfloat =
  hdy_squeezer_get_xalign(cast[ptr Squeezer00](self.impl))

proc hdy_squeezer_get_yalign(self: ptr Squeezer00): cfloat {.
    importc, libprag.}

proc getYalign*(self: Squeezer): cfloat =
  hdy_squeezer_get_yalign(cast[ptr Squeezer00](self.impl))

proc yalign*(self: Squeezer): cfloat =
  hdy_squeezer_get_yalign(cast[ptr Squeezer00](self.impl))

proc hdy_squeezer_set_child_enabled(self: ptr Squeezer00; child: ptr gtk.Widget00;
    enabled: gboolean) {.
    importc, libprag.}

proc setChildEnabled*(self: Squeezer; child: gtk.Widget; enabled: bool) =
  hdy_squeezer_set_child_enabled(cast[ptr Squeezer00](self.impl), cast[ptr gtk.Widget00](child.impl), gboolean(enabled))

proc hdy_squeezer_set_homogeneous(self: ptr Squeezer00; homogeneous: gboolean) {.
    importc, libprag.}

proc setHomogeneous*(self: Squeezer; homogeneous: bool = true) =
  hdy_squeezer_set_homogeneous(cast[ptr Squeezer00](self.impl), gboolean(homogeneous))

proc `homogeneous=`*(self: Squeezer; homogeneous: bool) =
  hdy_squeezer_set_homogeneous(cast[ptr Squeezer00](self.impl), gboolean(homogeneous))

proc hdy_squeezer_set_interpolate_size(self: ptr Squeezer00; interpolateSize: gboolean) {.
    importc, libprag.}

proc setInterpolateSize*(self: Squeezer; interpolateSize: bool = true) =
  hdy_squeezer_set_interpolate_size(cast[ptr Squeezer00](self.impl), gboolean(interpolateSize))

proc `interpolateSize=`*(self: Squeezer; interpolateSize: bool) =
  hdy_squeezer_set_interpolate_size(cast[ptr Squeezer00](self.impl), gboolean(interpolateSize))

proc hdy_squeezer_set_transition_duration(self: ptr Squeezer00; duration: uint32) {.
    importc, libprag.}

proc setTransitionDuration*(self: Squeezer; duration: int) =
  hdy_squeezer_set_transition_duration(cast[ptr Squeezer00](self.impl), uint32(duration))

proc `transitionDuration=`*(self: Squeezer; duration: int) =
  hdy_squeezer_set_transition_duration(cast[ptr Squeezer00](self.impl), uint32(duration))

proc hdy_squeezer_set_xalign(self: ptr Squeezer00; xalign: cfloat) {.
    importc, libprag.}

proc setXalign*(self: Squeezer; xalign: cfloat) =
  hdy_squeezer_set_xalign(cast[ptr Squeezer00](self.impl), xalign)

proc `xalign=`*(self: Squeezer; xalign: cfloat) =
  hdy_squeezer_set_xalign(cast[ptr Squeezer00](self.impl), xalign)

proc hdy_squeezer_set_yalign(self: ptr Squeezer00; yalign: cfloat) {.
    importc, libprag.}

proc setYalign*(self: Squeezer; yalign: cfloat) =
  hdy_squeezer_set_yalign(cast[ptr Squeezer00](self.impl), yalign)

proc `yalign=`*(self: Squeezer; yalign: cfloat) =
  hdy_squeezer_set_yalign(cast[ptr Squeezer00](self.impl), yalign)

type
  SqueezerTransitionType* {.size: sizeof(cint), pure.} = enum
    none = 0
    crossfade = 1

proc hdy_squeezer_get_transition_type(self: ptr Squeezer00): SqueezerTransitionType {.
    importc, libprag.}

proc getTransitionType*(self: Squeezer): SqueezerTransitionType =
  hdy_squeezer_get_transition_type(cast[ptr Squeezer00](self.impl))

proc transitionType*(self: Squeezer): SqueezerTransitionType =
  hdy_squeezer_get_transition_type(cast[ptr Squeezer00](self.impl))

proc hdy_squeezer_set_transition_type(self: ptr Squeezer00; transition: SqueezerTransitionType) {.
    importc, libprag.}

proc setTransitionType*(self: Squeezer; transition: SqueezerTransitionType) =
  hdy_squeezer_set_transition_type(cast[ptr Squeezer00](self.impl), transition)

proc `transitionType=`*(self: Squeezer; transition: SqueezerTransitionType) =
  hdy_squeezer_set_transition_type(cast[ptr Squeezer00](self.impl), transition)

type
  StatusPage* = ref object of gtk.Bin
  StatusPage00* = object of gtk.Bin00

proc hdy_status_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StatusPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_status_page_new(): ptr StatusPage00 {.
    importc, libprag.}

proc newStatusPage*(): StatusPage =
  let gobj = hdy_status_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newStatusPage*(tdesc: typedesc): tdesc =
  assert(result is StatusPage)
  let gobj = hdy_status_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initStatusPage*[T](result: var T) {.deprecated.} =
  assert(result is StatusPage)
  let gobj = hdy_status_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_status_page_get_description(self: ptr StatusPage00): cstring {.
    importc, libprag.}

proc getDescription*(self: StatusPage): string =
  let resul0 = hdy_status_page_get_description(cast[ptr StatusPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc description*(self: StatusPage): string =
  let resul0 = hdy_status_page_get_description(cast[ptr StatusPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_status_page_get_icon_name(self: ptr StatusPage00): cstring {.
    importc, libprag.}

proc getIconName*(self: StatusPage): string =
  let resul0 = hdy_status_page_get_icon_name(cast[ptr StatusPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: StatusPage): string =
  let resul0 = hdy_status_page_get_icon_name(cast[ptr StatusPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_status_page_get_title(self: ptr StatusPage00): cstring {.
    importc, libprag.}

proc getTitle*(self: StatusPage): string =
  let resul0 = hdy_status_page_get_title(cast[ptr StatusPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc title*(self: StatusPage): string =
  let resul0 = hdy_status_page_get_title(cast[ptr StatusPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_status_page_set_description(self: ptr StatusPage00; description: cstring) {.
    importc, libprag.}

proc setDescription*(self: StatusPage; description: cstring = nil) =
  hdy_status_page_set_description(cast[ptr StatusPage00](self.impl), description)

proc `description=`*(self: StatusPage; description: cstring = nil) =
  hdy_status_page_set_description(cast[ptr StatusPage00](self.impl), description)

proc hdy_status_page_set_icon_name(self: ptr StatusPage00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: StatusPage; iconName: cstring = nil) =
  hdy_status_page_set_icon_name(cast[ptr StatusPage00](self.impl), iconName)

proc `iconName=`*(self: StatusPage; iconName: cstring = nil) =
  hdy_status_page_set_icon_name(cast[ptr StatusPage00](self.impl), iconName)

proc hdy_status_page_set_title(self: ptr StatusPage00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: StatusPage; title: cstring = nil) =
  hdy_status_page_set_title(cast[ptr StatusPage00](self.impl), title)

proc `title=`*(self: StatusPage; title: cstring = nil) =
  hdy_status_page_set_title(cast[ptr StatusPage00](self.impl), title)

type
  StyleManager* = ref object of gobject.Object
  StyleManager00* = object of gobject.Object00

proc hdy_style_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_style_manager_get_default(): ptr StyleManager00 {.
    importc, libprag.}

proc getDefaultStyleManager*(): StyleManager =
  let gobj = hdy_style_manager_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_style_manager_get_for_display(display: ptr gdk.Display00): ptr StyleManager00 {.
    importc, libprag.}

proc getForDisplay*(display: gdk.Display): StyleManager =
  let gobj = hdy_style_manager_get_for_display(cast[ptr gdk.Display00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc forDisplay*(display: gdk.Display): StyleManager =
  let gobj = hdy_style_manager_get_for_display(cast[ptr gdk.Display00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_style_manager_get_color_scheme(self: ptr StyleManager00): ColorScheme {.
    importc, libprag.}

proc getColorScheme*(self: StyleManager): ColorScheme =
  hdy_style_manager_get_color_scheme(cast[ptr StyleManager00](self.impl))

proc colorScheme*(self: StyleManager): ColorScheme =
  hdy_style_manager_get_color_scheme(cast[ptr StyleManager00](self.impl))

proc hdy_style_manager_get_dark(self: ptr StyleManager00): gboolean {.
    importc, libprag.}

proc getDark*(self: StyleManager): bool =
  toBool(hdy_style_manager_get_dark(cast[ptr StyleManager00](self.impl)))

proc dark*(self: StyleManager): bool =
  toBool(hdy_style_manager_get_dark(cast[ptr StyleManager00](self.impl)))

proc hdy_style_manager_get_display(self: ptr StyleManager00): ptr gdk.Display00 {.
    importc, libprag.}

proc getDisplay*(self: StyleManager): gdk.Display =
  let gobj = hdy_style_manager_get_display(cast[ptr StyleManager00](self.impl))
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

proc display*(self: StyleManager): gdk.Display =
  let gobj = hdy_style_manager_get_display(cast[ptr StyleManager00](self.impl))
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

proc hdy_style_manager_get_high_contrast(self: ptr StyleManager00): gboolean {.
    importc, libprag.}

proc getHighContrast*(self: StyleManager): bool =
  toBool(hdy_style_manager_get_high_contrast(cast[ptr StyleManager00](self.impl)))

proc highContrast*(self: StyleManager): bool =
  toBool(hdy_style_manager_get_high_contrast(cast[ptr StyleManager00](self.impl)))

proc hdy_style_manager_get_system_supports_color_schemes(self: ptr StyleManager00): gboolean {.
    importc, libprag.}

proc getSystemSupportsColorSchemes*(self: StyleManager): bool =
  toBool(hdy_style_manager_get_system_supports_color_schemes(cast[ptr StyleManager00](self.impl)))

proc systemSupportsColorSchemes*(self: StyleManager): bool =
  toBool(hdy_style_manager_get_system_supports_color_schemes(cast[ptr StyleManager00](self.impl)))

proc hdy_style_manager_set_color_scheme(self: ptr StyleManager00; colorScheme: ColorScheme) {.
    importc, libprag.}

proc setColorScheme*(self: StyleManager; colorScheme: ColorScheme) =
  hdy_style_manager_set_color_scheme(cast[ptr StyleManager00](self.impl), colorScheme)

proc `colorScheme=`*(self: StyleManager; colorScheme: ColorScheme) =
  hdy_style_manager_set_color_scheme(cast[ptr StyleManager00](self.impl), colorScheme)

type
  SwipeGroup* = ref object of gobject.Object
  SwipeGroup00* = object of gobject.Object00

proc hdy_swipe_group_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SwipeGroup()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_swipe_group_new(): ptr SwipeGroup00 {.
    importc, libprag.}

proc newSwipeGroup*(): SwipeGroup {.deprecated.}  =
  let gobj = hdy_swipe_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSwipeGroup*(tdesc: typedesc): tdesc {.deprecated.}  =
  assert(result is SwipeGroup)
  let gobj = hdy_swipe_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSwipeGroup*[T](result: var T) {.deprecated.} =
  assert(result is SwipeGroup)
  let gobj = hdy_swipe_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Swipeable00* = object of gobject.Object00
  Swipeable* = ref object of gobject.Object

proc scChildSwitched*(self: Swipeable | Carousel | Flap | Deck | Leaflet;  p: proc (self: ptr Swipeable00; index: uint32; duration: int64; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "child-switched", cast[GCallback](p), xdata, nil, cf)

proc hdy_swipeable_emit_child_switched(self: ptr Swipeable00; index: uint32;
    duration: int64) {.
    importc, libprag.}

proc emitChildSwitched*(self: Swipeable | Carousel | Flap | Deck | Leaflet;
    index: int; duration: int64) =
  hdy_swipeable_emit_child_switched(cast[ptr Swipeable00](self.impl), uint32(index), duration)

proc hdy_swipeable_get_cancel_progress(self: ptr Swipeable00): cdouble {.
    importc, libprag.}

proc getCancelProgress*(self: Swipeable | Carousel | Flap | Deck | Leaflet): cdouble =
  hdy_swipeable_get_cancel_progress(cast[ptr Swipeable00](self.impl))

proc cancelProgress*(self: Swipeable | Carousel | Flap | Deck | Leaflet): cdouble =
  hdy_swipeable_get_cancel_progress(cast[ptr Swipeable00](self.impl))

proc hdy_swipeable_get_distance(self: ptr Swipeable00): cdouble {.
    importc, libprag.}

proc getDistance*(self: Swipeable | Carousel | Flap | Deck | Leaflet): cdouble =
  hdy_swipeable_get_distance(cast[ptr Swipeable00](self.impl))

proc distance*(self: Swipeable | Carousel | Flap | Deck | Leaflet): cdouble =
  hdy_swipeable_get_distance(cast[ptr Swipeable00](self.impl))

proc hdy_swipeable_get_progress(self: ptr Swipeable00): cdouble {.
    importc, libprag.}

proc getProgress*(self: Swipeable | Carousel | Flap | Deck | Leaflet): cdouble =
  hdy_swipeable_get_progress(cast[ptr Swipeable00](self.impl))

proc progress*(self: Swipeable | Carousel | Flap | Deck | Leaflet): cdouble =
  hdy_swipeable_get_progress(cast[ptr Swipeable00](self.impl))

proc hdy_swipeable_get_snap_points(self: ptr Swipeable00; nSnapPoints: var int32): ptr cdouble {.
    importc, libprag.}

proc getSnapPoints*(self: Swipeable | Carousel | Flap | Deck | Leaflet;
    nSnapPoints: var int): ptr cdouble =
  var nSnapPoints_00: int32
  let resul0 = hdy_swipeable_get_snap_points(cast[ptr Swipeable00](self.impl), nSnapPoints_00)
  result = resul0
  if nSnapPoints.addr != nil:
    nSnapPoints = int(nSnapPoints_00)

proc hdy_swipeable_get_swipe_area(self: ptr Swipeable00; navigationDirection: NavigationDirection;
    isDrag: gboolean; rect: var gdk.Rectangle) {.
    importc, libprag.}

proc getSwipeArea*(self: Swipeable | Carousel | Flap | Deck | Leaflet;
    navigationDirection: NavigationDirection; isDrag: bool; rect: var gdk.Rectangle) =
  hdy_swipeable_get_swipe_area(cast[ptr Swipeable00](self.impl), navigationDirection, gboolean(isDrag), rect)

proc hdy_swipeable_switch_child(self: ptr Swipeable00; index: uint32; duration: int64) {.
    importc, libprag.}

proc switchChild*(self: Swipeable | Carousel | Flap | Deck | Leaflet;
    index: int; duration: int64) =
  hdy_swipeable_switch_child(cast[ptr Swipeable00](self.impl), uint32(index), duration)

proc hdy_swipe_group_add_swipeable(self: ptr SwipeGroup00; swipeable: ptr Swipeable00) {.
    importc, libprag.}

proc addSwipeable*(self: SwipeGroup; swipeable: Swipeable | Carousel | Flap | Deck | Leaflet) =
  hdy_swipe_group_add_swipeable(cast[ptr SwipeGroup00](self.impl), cast[ptr Swipeable00](swipeable.impl))

proc hdy_swipe_group_get_swipeables(self: ptr SwipeGroup00): ptr glib.SList {.
    importc, libprag.}

proc getSwipeables*(self: SwipeGroup): seq[Swipeable] =
  result = gslistObjects2seq(Swipeable, hdy_swipe_group_get_swipeables(cast[ptr SwipeGroup00](self.impl)), false)

proc swipeables*(self: SwipeGroup): seq[Swipeable] =
  result = gslistObjects2seq(Swipeable, hdy_swipe_group_get_swipeables(cast[ptr SwipeGroup00](self.impl)), false)

proc hdy_swipe_group_remove_swipeable(self: ptr SwipeGroup00; swipeable: ptr Swipeable00) {.
    importc, libprag.}

proc removeSwipeable*(self: SwipeGroup; swipeable: Swipeable | Carousel | Flap | Deck | Leaflet) =
  hdy_swipe_group_remove_swipeable(cast[ptr SwipeGroup00](self.impl), cast[ptr Swipeable00](swipeable.impl))

type
  SwipeTracker* = ref object of gobject.Object
  SwipeTracker00* = object of gobject.Object00

proc hdy_swipe_tracker_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SwipeTracker()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scBeginSwipe*(self: SwipeTracker;  p: proc (self: ptr SwipeTracker00; direction: NavigationDirection; direct: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "begin-swipe", cast[GCallback](p), xdata, nil, cf)

proc scEndSwipe*(self: SwipeTracker;  p: proc (self: ptr SwipeTracker00; duration: int64; to: cdouble; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "end-swipe", cast[GCallback](p), xdata, nil, cf)

proc scUpdateSwipe*(self: SwipeTracker;  p: proc (self: ptr SwipeTracker00; progress: cdouble; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "update-swipe", cast[GCallback](p), xdata, nil, cf)

proc hdy_swipe_tracker_new(swipeable: ptr Swipeable00): ptr SwipeTracker00 {.
    importc, libprag.}

proc newSwipeTracker*(swipeable: Swipeable | Carousel | Flap | Deck | Leaflet): SwipeTracker =
  let gobj = hdy_swipe_tracker_new(cast[ptr Swipeable00](swipeable.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSwipeTracker*(tdesc: typedesc; swipeable: Swipeable | Carousel | Flap | Deck | Leaflet): tdesc =
  assert(result is SwipeTracker)
  let gobj = hdy_swipe_tracker_new(cast[ptr Swipeable00](swipeable.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSwipeTracker*[T](result: var T; swipeable: Swipeable | Carousel | Flap | Deck | Leaflet) {.deprecated.} =
  assert(result is SwipeTracker)
  let gobj = hdy_swipe_tracker_new(cast[ptr Swipeable00](swipeable.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_swipe_tracker_get_allow_long_swipes(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getAllowLongSwipes*(self: SwipeTracker): bool =
  toBool(hdy_swipe_tracker_get_allow_long_swipes(cast[ptr SwipeTracker00](self.impl)))

proc allowLongSwipes*(self: SwipeTracker): bool =
  toBool(hdy_swipe_tracker_get_allow_long_swipes(cast[ptr SwipeTracker00](self.impl)))

proc hdy_swipe_tracker_get_allow_mouse_drag(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getAllowMouseDrag*(self: SwipeTracker): bool =
  toBool(hdy_swipe_tracker_get_allow_mouse_drag(cast[ptr SwipeTracker00](self.impl)))

proc allowMouseDrag*(self: SwipeTracker): bool =
  toBool(hdy_swipe_tracker_get_allow_mouse_drag(cast[ptr SwipeTracker00](self.impl)))

proc hdy_swipe_tracker_get_enabled(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getEnabled*(self: SwipeTracker): bool =
  toBool(hdy_swipe_tracker_get_enabled(cast[ptr SwipeTracker00](self.impl)))

proc enabled*(self: SwipeTracker): bool =
  toBool(hdy_swipe_tracker_get_enabled(cast[ptr SwipeTracker00](self.impl)))

proc hdy_swipe_tracker_get_reversed(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getReversed*(self: SwipeTracker): bool =
  toBool(hdy_swipe_tracker_get_reversed(cast[ptr SwipeTracker00](self.impl)))

proc reversed*(self: SwipeTracker): bool =
  toBool(hdy_swipe_tracker_get_reversed(cast[ptr SwipeTracker00](self.impl)))

proc hdy_swipe_tracker_get_swipeable(self: ptr SwipeTracker00): ptr Swipeable00 {.
    importc, libprag.}

proc getSwipeable*(self: SwipeTracker): Swipeable =
  let gobj = hdy_swipe_tracker_get_swipeable(cast[ptr SwipeTracker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc swipeable*(self: SwipeTracker): Swipeable =
  let gobj = hdy_swipe_tracker_get_swipeable(cast[ptr SwipeTracker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_swipe_tracker_set_allow_long_swipes(self: ptr SwipeTracker00; allowLongSwipes: gboolean) {.
    importc, libprag.}

proc setAllowLongSwipes*(self: SwipeTracker; allowLongSwipes: bool = true) =
  hdy_swipe_tracker_set_allow_long_swipes(cast[ptr SwipeTracker00](self.impl), gboolean(allowLongSwipes))

proc `allowLongSwipes=`*(self: SwipeTracker; allowLongSwipes: bool) =
  hdy_swipe_tracker_set_allow_long_swipes(cast[ptr SwipeTracker00](self.impl), gboolean(allowLongSwipes))

proc hdy_swipe_tracker_set_allow_mouse_drag(self: ptr SwipeTracker00; allowMouseDrag: gboolean) {.
    importc, libprag.}

proc setAllowMouseDrag*(self: SwipeTracker; allowMouseDrag: bool = true) =
  hdy_swipe_tracker_set_allow_mouse_drag(cast[ptr SwipeTracker00](self.impl), gboolean(allowMouseDrag))

proc `allowMouseDrag=`*(self: SwipeTracker; allowMouseDrag: bool) =
  hdy_swipe_tracker_set_allow_mouse_drag(cast[ptr SwipeTracker00](self.impl), gboolean(allowMouseDrag))

proc hdy_swipe_tracker_set_enabled(self: ptr SwipeTracker00; enabled: gboolean) {.
    importc, libprag.}

proc setEnabled*(self: SwipeTracker; enabled: bool = true) =
  hdy_swipe_tracker_set_enabled(cast[ptr SwipeTracker00](self.impl), gboolean(enabled))

proc `enabled=`*(self: SwipeTracker; enabled: bool) =
  hdy_swipe_tracker_set_enabled(cast[ptr SwipeTracker00](self.impl), gboolean(enabled))

proc hdy_swipe_tracker_set_reversed(self: ptr SwipeTracker00; reversed: gboolean) {.
    importc, libprag.}

proc setReversed*(self: SwipeTracker; reversed: bool = true) =
  hdy_swipe_tracker_set_reversed(cast[ptr SwipeTracker00](self.impl), gboolean(reversed))

proc `reversed=`*(self: SwipeTracker; reversed: bool) =
  hdy_swipe_tracker_set_reversed(cast[ptr SwipeTracker00](self.impl), gboolean(reversed))

proc hdy_swipe_tracker_shift_position(self: ptr SwipeTracker00; delta: cdouble) {.
    importc, libprag.}

proc shiftPosition*(self: SwipeTracker; delta: cdouble) =
  hdy_swipe_tracker_shift_position(cast[ptr SwipeTracker00](self.impl), delta)

proc hdy_swipeable_get_swipe_tracker(self: ptr Swipeable00): ptr SwipeTracker00 {.
    importc, libprag.}

proc getSwipeTracker*(self: Swipeable | Carousel | Flap | Deck | Leaflet): SwipeTracker =
  let gobj = hdy_swipeable_get_swipe_tracker(cast[ptr Swipeable00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc swipeTracker*(self: Swipeable | Carousel | Flap | Deck | Leaflet): SwipeTracker =
  let gobj = hdy_swipeable_get_swipe_tracker(cast[ptr Swipeable00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  TabPage* = ref object of gobject.Object
  TabPage00* = object of gobject.Object00

proc hdy_tab_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TabPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_tab_page_get_child(self: ptr TabPage00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getChild*(self: TabPage): gtk.Widget =
  let gobj = hdy_tab_page_get_child(cast[ptr TabPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: TabPage): gtk.Widget =
  let gobj = hdy_tab_page_get_child(cast[ptr TabPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_page_get_icon(self: ptr TabPage00): ptr gio.Icon00 {.
    importc, libprag.}

proc getIcon*(self: TabPage): gio.Icon =
  let gobj = hdy_tab_page_get_icon(cast[ptr TabPage00](self.impl))
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

proc icon*(self: TabPage): gio.Icon =
  let gobj = hdy_tab_page_get_icon(cast[ptr TabPage00](self.impl))
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

proc hdy_tab_page_get_indicator_activatable(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getIndicatorActivatable*(self: TabPage): bool =
  toBool(hdy_tab_page_get_indicator_activatable(cast[ptr TabPage00](self.impl)))

proc indicatorActivatable*(self: TabPage): bool =
  toBool(hdy_tab_page_get_indicator_activatable(cast[ptr TabPage00](self.impl)))

proc hdy_tab_page_get_indicator_icon(self: ptr TabPage00): ptr gio.Icon00 {.
    importc, libprag.}

proc getIndicatorIcon*(self: TabPage): gio.Icon =
  let gobj = hdy_tab_page_get_indicator_icon(cast[ptr TabPage00](self.impl))
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

proc indicatorIcon*(self: TabPage): gio.Icon =
  let gobj = hdy_tab_page_get_indicator_icon(cast[ptr TabPage00](self.impl))
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

proc hdy_tab_page_get_loading(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getLoading*(self: TabPage): bool =
  toBool(hdy_tab_page_get_loading(cast[ptr TabPage00](self.impl)))

proc loading*(self: TabPage): bool =
  toBool(hdy_tab_page_get_loading(cast[ptr TabPage00](self.impl)))

proc hdy_tab_page_get_needs_attention(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getNeedsAttention*(self: TabPage): bool =
  toBool(hdy_tab_page_get_needs_attention(cast[ptr TabPage00](self.impl)))

proc needsAttention*(self: TabPage): bool =
  toBool(hdy_tab_page_get_needs_attention(cast[ptr TabPage00](self.impl)))

proc hdy_tab_page_get_parent(self: ptr TabPage00): ptr TabPage00 {.
    importc, libprag.}

proc getParent*(self: TabPage): TabPage =
  let gobj = hdy_tab_page_get_parent(cast[ptr TabPage00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parent*(self: TabPage): TabPage =
  let gobj = hdy_tab_page_get_parent(cast[ptr TabPage00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_page_get_pinned(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getPinned*(self: TabPage): bool =
  toBool(hdy_tab_page_get_pinned(cast[ptr TabPage00](self.impl)))

proc pinned*(self: TabPage): bool =
  toBool(hdy_tab_page_get_pinned(cast[ptr TabPage00](self.impl)))

proc hdy_tab_page_get_selected(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getSelected*(self: TabPage): bool =
  toBool(hdy_tab_page_get_selected(cast[ptr TabPage00](self.impl)))

proc selected*(self: TabPage): bool =
  toBool(hdy_tab_page_get_selected(cast[ptr TabPage00](self.impl)))

proc hdy_tab_page_get_title(self: ptr TabPage00): cstring {.
    importc, libprag.}

proc getTitle*(self: TabPage): string =
  let resul0 = hdy_tab_page_get_title(cast[ptr TabPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc title*(self: TabPage): string =
  let resul0 = hdy_tab_page_get_title(cast[ptr TabPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_tab_page_get_tooltip(self: ptr TabPage00): cstring {.
    importc, libprag.}

proc getTooltip*(self: TabPage): string =
  let resul0 = hdy_tab_page_get_tooltip(cast[ptr TabPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc tooltip*(self: TabPage): string =
  let resul0 = hdy_tab_page_get_tooltip(cast[ptr TabPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_tab_page_set_icon(self: ptr TabPage00; icon: ptr gio.Icon00) {.
    importc, libprag.}

proc setIcon*(self: TabPage; icon: gio.Icon = nil) =
  hdy_tab_page_set_icon(cast[ptr TabPage00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc `icon=`*(self: TabPage; icon: gio.Icon = nil) =
  hdy_tab_page_set_icon(cast[ptr TabPage00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc hdy_tab_page_set_indicator_activatable(self: ptr TabPage00; activatable: gboolean) {.
    importc, libprag.}

proc setIndicatorActivatable*(self: TabPage; activatable: bool = true) =
  hdy_tab_page_set_indicator_activatable(cast[ptr TabPage00](self.impl), gboolean(activatable))

proc `indicatorActivatable=`*(self: TabPage; activatable: bool) =
  hdy_tab_page_set_indicator_activatable(cast[ptr TabPage00](self.impl), gboolean(activatable))

proc hdy_tab_page_set_indicator_icon(self: ptr TabPage00; indicatorIcon: ptr gio.Icon00) {.
    importc, libprag.}

proc setIndicatorIcon*(self: TabPage; indicatorIcon: gio.Icon = nil) =
  hdy_tab_page_set_indicator_icon(cast[ptr TabPage00](self.impl), if indicatorIcon.isNil: nil else: cast[ptr gio.Icon00](indicatorIcon.impl))

proc `indicatorIcon=`*(self: TabPage; indicatorIcon: gio.Icon = nil) =
  hdy_tab_page_set_indicator_icon(cast[ptr TabPage00](self.impl), if indicatorIcon.isNil: nil else: cast[ptr gio.Icon00](indicatorIcon.impl))

proc hdy_tab_page_set_loading(self: ptr TabPage00; loading: gboolean) {.
    importc, libprag.}

proc setLoading*(self: TabPage; loading: bool = true) =
  hdy_tab_page_set_loading(cast[ptr TabPage00](self.impl), gboolean(loading))

proc `loading=`*(self: TabPage; loading: bool) =
  hdy_tab_page_set_loading(cast[ptr TabPage00](self.impl), gboolean(loading))

proc hdy_tab_page_set_needs_attention(self: ptr TabPage00; needsAttention: gboolean) {.
    importc, libprag.}

proc setNeedsAttention*(self: TabPage; needsAttention: bool = true) =
  hdy_tab_page_set_needs_attention(cast[ptr TabPage00](self.impl), gboolean(needsAttention))

proc `needsAttention=`*(self: TabPage; needsAttention: bool) =
  hdy_tab_page_set_needs_attention(cast[ptr TabPage00](self.impl), gboolean(needsAttention))

proc hdy_tab_page_set_title(self: ptr TabPage00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: TabPage; title: cstring = nil) =
  hdy_tab_page_set_title(cast[ptr TabPage00](self.impl), title)

proc `title=`*(self: TabPage; title: cstring = nil) =
  hdy_tab_page_set_title(cast[ptr TabPage00](self.impl), title)

proc hdy_tab_page_set_tooltip(self: ptr TabPage00; tooltip: cstring) {.
    importc, libprag.}

proc setTooltip*(self: TabPage; tooltip: cstring = nil) =
  hdy_tab_page_set_tooltip(cast[ptr TabPage00](self.impl), tooltip)

proc `tooltip=`*(self: TabPage; tooltip: cstring = nil) =
  hdy_tab_page_set_tooltip(cast[ptr TabPage00](self.impl), tooltip)

type
  TabBar* = ref object of gtk.Bin
  TabBar00* = object of gtk.Bin00

proc hdy_tab_bar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TabBar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scExtraDragDataReceived*(self: TabBar;  p: proc (self: ptr TabBar00; page: ptr TabPage00; context: ptr gdk.DragContext00; data: ptr gtk.SelectionData00;
    info: uint32; time: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "extra-drag-data-received", cast[GCallback](p), xdata, nil, cf)

proc hdy_tab_bar_new(): ptr TabBar00 {.
    importc, libprag.}

proc newTabBar*(): TabBar =
  let gobj = hdy_tab_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTabBar*(tdesc: typedesc): tdesc =
  assert(result is TabBar)
  let gobj = hdy_tab_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTabBar*[T](result: var T) {.deprecated.} =
  assert(result is TabBar)
  let gobj = hdy_tab_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_bar_get_autohide(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getAutohide*(self: TabBar): bool =
  toBool(hdy_tab_bar_get_autohide(cast[ptr TabBar00](self.impl)))

proc autohide*(self: TabBar): bool =
  toBool(hdy_tab_bar_get_autohide(cast[ptr TabBar00](self.impl)))

proc hdy_tab_bar_get_end_action_widget(self: ptr TabBar00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getEndActionWidget*(self: TabBar): gtk.Widget =
  let gobj = hdy_tab_bar_get_end_action_widget(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc endActionWidget*(self: TabBar): gtk.Widget =
  let gobj = hdy_tab_bar_get_end_action_widget(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_bar_get_expand_tabs(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getExpandTabs*(self: TabBar): bool =
  toBool(hdy_tab_bar_get_expand_tabs(cast[ptr TabBar00](self.impl)))

proc expandTabs*(self: TabBar): bool =
  toBool(hdy_tab_bar_get_expand_tabs(cast[ptr TabBar00](self.impl)))

proc hdy_tab_bar_get_extra_drag_dest_targets(self: ptr TabBar00): ptr gtk.TargetList00 {.
    importc, libprag.}

proc getExtraDragDestTargets*(self: TabBar): gtk.TargetList =
  let impl0 = hdy_tab_bar_get_extra_drag_dest_targets(cast[ptr TabBar00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGtkTargetList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_target_list_get_type(), impl0))

proc extraDragDestTargets*(self: TabBar): gtk.TargetList =
  let impl0 = hdy_tab_bar_get_extra_drag_dest_targets(cast[ptr TabBar00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGtkTargetList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_target_list_get_type(), impl0))

proc hdy_tab_bar_get_inverted(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getInverted*(self: TabBar): bool =
  toBool(hdy_tab_bar_get_inverted(cast[ptr TabBar00](self.impl)))

proc inverted*(self: TabBar): bool =
  toBool(hdy_tab_bar_get_inverted(cast[ptr TabBar00](self.impl)))

proc hdy_tab_bar_get_is_overflowing(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getIsOverflowing*(self: TabBar): bool =
  toBool(hdy_tab_bar_get_is_overflowing(cast[ptr TabBar00](self.impl)))

proc isOverflowing*(self: TabBar): bool =
  toBool(hdy_tab_bar_get_is_overflowing(cast[ptr TabBar00](self.impl)))

proc hdy_tab_bar_get_start_action_widget(self: ptr TabBar00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getStartActionWidget*(self: TabBar): gtk.Widget =
  let gobj = hdy_tab_bar_get_start_action_widget(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc startActionWidget*(self: TabBar): gtk.Widget =
  let gobj = hdy_tab_bar_get_start_action_widget(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_bar_get_tabs_revealed(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getTabsRevealed*(self: TabBar): bool =
  toBool(hdy_tab_bar_get_tabs_revealed(cast[ptr TabBar00](self.impl)))

proc tabsRevealed*(self: TabBar): bool =
  toBool(hdy_tab_bar_get_tabs_revealed(cast[ptr TabBar00](self.impl)))

proc hdy_tab_bar_set_autohide(self: ptr TabBar00; autohide: gboolean) {.
    importc, libprag.}

proc setAutohide*(self: TabBar; autohide: bool = true) =
  hdy_tab_bar_set_autohide(cast[ptr TabBar00](self.impl), gboolean(autohide))

proc `autohide=`*(self: TabBar; autohide: bool) =
  hdy_tab_bar_set_autohide(cast[ptr TabBar00](self.impl), gboolean(autohide))

proc hdy_tab_bar_set_end_action_widget(self: ptr TabBar00; widget: ptr gtk.Widget00) {.
    importc, libprag.}

proc setEndActionWidget*(self: TabBar; widget: gtk.Widget = nil) =
  hdy_tab_bar_set_end_action_widget(cast[ptr TabBar00](self.impl), if widget.isNil: nil else: cast[ptr gtk.Widget00](widget.impl))

proc `endActionWidget=`*(self: TabBar; widget: gtk.Widget = nil) =
  hdy_tab_bar_set_end_action_widget(cast[ptr TabBar00](self.impl), if widget.isNil: nil else: cast[ptr gtk.Widget00](widget.impl))

proc hdy_tab_bar_set_expand_tabs(self: ptr TabBar00; expandTabs: gboolean) {.
    importc, libprag.}

proc setExpandTabs*(self: TabBar; expandTabs: bool = true) =
  hdy_tab_bar_set_expand_tabs(cast[ptr TabBar00](self.impl), gboolean(expandTabs))

proc `expandTabs=`*(self: TabBar; expandTabs: bool) =
  hdy_tab_bar_set_expand_tabs(cast[ptr TabBar00](self.impl), gboolean(expandTabs))

proc hdy_tab_bar_set_extra_drag_dest_targets(self: ptr TabBar00; extraDragDestTargets: ptr gtk.TargetList00) {.
    importc, libprag.}

proc setExtraDragDestTargets*(self: TabBar; extraDragDestTargets: gtk.TargetList = nil) =
  hdy_tab_bar_set_extra_drag_dest_targets(cast[ptr TabBar00](self.impl), if extraDragDestTargets.isNil: nil else: cast[ptr gtk.TargetList00](extraDragDestTargets.impl))

proc `extraDragDestTargets=`*(self: TabBar; extraDragDestTargets: gtk.TargetList = nil) =
  hdy_tab_bar_set_extra_drag_dest_targets(cast[ptr TabBar00](self.impl), if extraDragDestTargets.isNil: nil else: cast[ptr gtk.TargetList00](extraDragDestTargets.impl))

proc hdy_tab_bar_set_inverted(self: ptr TabBar00; inverted: gboolean) {.
    importc, libprag.}

proc setInverted*(self: TabBar; inverted: bool = true) =
  hdy_tab_bar_set_inverted(cast[ptr TabBar00](self.impl), gboolean(inverted))

proc `inverted=`*(self: TabBar; inverted: bool) =
  hdy_tab_bar_set_inverted(cast[ptr TabBar00](self.impl), gboolean(inverted))

proc hdy_tab_bar_set_start_action_widget(self: ptr TabBar00; widget: ptr gtk.Widget00) {.
    importc, libprag.}

proc setStartActionWidget*(self: TabBar; widget: gtk.Widget = nil) =
  hdy_tab_bar_set_start_action_widget(cast[ptr TabBar00](self.impl), if widget.isNil: nil else: cast[ptr gtk.Widget00](widget.impl))

proc `startActionWidget=`*(self: TabBar; widget: gtk.Widget = nil) =
  hdy_tab_bar_set_start_action_widget(cast[ptr TabBar00](self.impl), if widget.isNil: nil else: cast[ptr gtk.Widget00](widget.impl))

type
  TabView* = ref object of gtk.Bin
  TabView00* = object of gtk.Bin00

proc hdy_tab_view_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TabView()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scClosePage*(self: TabView;  p: proc (self: ptr TabView00; page: ptr TabPage00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "close-page", cast[GCallback](p), xdata, nil, cf)

proc scCreateWindow*(self: TabView;  p: proc (self: ptr TabView00; xdata: pointer): ptr TabView00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "create-window", cast[GCallback](p), xdata, nil, cf)

proc scIndicatorActivated*(self: TabView;  p: proc (self: ptr TabView00; page: ptr TabPage00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "indicator-activated", cast[GCallback](p), xdata, nil, cf)

proc scPageAttached*(self: TabView;  p: proc (self: ptr TabView00; page: ptr TabPage00; position: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "page-attached", cast[GCallback](p), xdata, nil, cf)

proc scPageDetached*(self: TabView;  p: proc (self: ptr TabView00; page: ptr TabPage00; position: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "page-detached", cast[GCallback](p), xdata, nil, cf)

proc scPageReordered*(self: TabView;  p: proc (self: ptr TabView00; page: ptr TabPage00; position: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "page-reordered", cast[GCallback](p), xdata, nil, cf)

proc scSetupMenu*(self: TabView;  p: proc (self: ptr TabView00; page: ptr TabPage00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "setup-menu", cast[GCallback](p), xdata, nil, cf)

proc hdy_tab_view_new(): ptr TabView00 {.
    importc, libprag.}

proc newTabView*(): TabView =
  let gobj = hdy_tab_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTabView*(tdesc: typedesc): tdesc =
  assert(result is TabView)
  let gobj = hdy_tab_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTabView*[T](result: var T) {.deprecated.} =
  assert(result is TabView)
  let gobj = hdy_tab_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_add_page(self: ptr TabView00; child: ptr gtk.Widget00;
    parent: ptr TabPage00): ptr TabPage00 {.
    importc, libprag.}

proc addPage*(self: TabView; child: gtk.Widget; parent: TabPage = nil): TabPage =
  let gobj = hdy_tab_view_add_page(cast[ptr TabView00](self.impl), cast[ptr gtk.Widget00](child.impl), if parent.isNil: nil else: cast[ptr TabPage00](parent.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_append(self: ptr TabView00; child: ptr gtk.Widget00): ptr TabPage00 {.
    importc, libprag.}

proc append*(self: TabView; child: gtk.Widget): TabPage =
  let gobj = hdy_tab_view_append(cast[ptr TabView00](self.impl), cast[ptr gtk.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_append_pinned(self: ptr TabView00; child: ptr gtk.Widget00): ptr TabPage00 {.
    importc, libprag.}

proc appendPinned*(self: TabView; child: gtk.Widget): TabPage =
  let gobj = hdy_tab_view_append_pinned(cast[ptr TabView00](self.impl), cast[ptr gtk.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_close_other_pages(self: ptr TabView00; page: ptr TabPage00) {.
    importc, libprag.}

proc closeOtherPages*(self: TabView; page: TabPage) =
  hdy_tab_view_close_other_pages(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl))

proc hdy_tab_view_close_page(self: ptr TabView00; page: ptr TabPage00) {.
    importc, libprag.}

proc closePage*(self: TabView; page: TabPage) =
  hdy_tab_view_close_page(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl))

proc hdy_tab_view_close_page_finish(self: ptr TabView00; page: ptr TabPage00;
    confirm: gboolean) {.
    importc, libprag.}

proc closePageFinish*(self: TabView; page: TabPage; confirm: bool) =
  hdy_tab_view_close_page_finish(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl), gboolean(confirm))

proc hdy_tab_view_close_pages_after(self: ptr TabView00; page: ptr TabPage00) {.
    importc, libprag.}

proc closePagesAfter*(self: TabView; page: TabPage) =
  hdy_tab_view_close_pages_after(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl))

proc hdy_tab_view_close_pages_before(self: ptr TabView00; page: ptr TabPage00) {.
    importc, libprag.}

proc closePagesBefore*(self: TabView; page: TabPage) =
  hdy_tab_view_close_pages_before(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl))

proc hdy_tab_view_get_default_icon(self: ptr TabView00): ptr gio.Icon00 {.
    importc, libprag.}

proc getDefaultIcon*(self: TabView): gio.Icon =
  let gobj = hdy_tab_view_get_default_icon(cast[ptr TabView00](self.impl))
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

proc defaultIcon*(self: TabView): gio.Icon =
  let gobj = hdy_tab_view_get_default_icon(cast[ptr TabView00](self.impl))
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

proc hdy_tab_view_get_is_transferring_page(self: ptr TabView00): gboolean {.
    importc, libprag.}

proc getIsTransferringPage*(self: TabView): bool =
  toBool(hdy_tab_view_get_is_transferring_page(cast[ptr TabView00](self.impl)))

proc isTransferringPage*(self: TabView): bool =
  toBool(hdy_tab_view_get_is_transferring_page(cast[ptr TabView00](self.impl)))

proc hdy_tab_view_get_menu_model(self: ptr TabView00): ptr gio.MenuModel00 {.
    importc, libprag.}

proc getMenuModel*(self: TabView): gio.MenuModel =
  let gobj = hdy_tab_view_get_menu_model(cast[ptr TabView00](self.impl))
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

proc menuModel*(self: TabView): gio.MenuModel =
  let gobj = hdy_tab_view_get_menu_model(cast[ptr TabView00](self.impl))
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

proc hdy_tab_view_get_n_pages(self: ptr TabView00): int32 {.
    importc, libprag.}

proc getNPages*(self: TabView): int =
  int(hdy_tab_view_get_n_pages(cast[ptr TabView00](self.impl)))

proc nPages*(self: TabView): int =
  int(hdy_tab_view_get_n_pages(cast[ptr TabView00](self.impl)))

proc hdy_tab_view_get_n_pinned_pages(self: ptr TabView00): int32 {.
    importc, libprag.}

proc getNPinnedPages*(self: TabView): int =
  int(hdy_tab_view_get_n_pinned_pages(cast[ptr TabView00](self.impl)))

proc nPinnedPages*(self: TabView): int =
  int(hdy_tab_view_get_n_pinned_pages(cast[ptr TabView00](self.impl)))

proc hdy_tab_view_get_nth_page(self: ptr TabView00; position: int32): ptr TabPage00 {.
    importc, libprag.}

proc getNthPage*(self: TabView; position: int): TabPage =
  let gobj = hdy_tab_view_get_nth_page(cast[ptr TabView00](self.impl), int32(position))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_get_page(self: ptr TabView00; child: ptr gtk.Widget00): ptr TabPage00 {.
    importc, libprag.}

proc getPage*(self: TabView; child: gtk.Widget): TabPage =
  let gobj = hdy_tab_view_get_page(cast[ptr TabView00](self.impl), cast[ptr gtk.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_get_page_position(self: ptr TabView00; page: ptr TabPage00): int32 {.
    importc, libprag.}

proc getPagePosition*(self: TabView; page: TabPage): int =
  int(hdy_tab_view_get_page_position(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl)))

proc hdy_tab_view_get_pages(self: ptr TabView00): ptr gio.ListModel00 {.
    importc, libprag.}

proc getPages*(self: TabView): gio.ListModel =
  let gobj = hdy_tab_view_get_pages(cast[ptr TabView00](self.impl))
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

proc pages*(self: TabView): gio.ListModel =
  let gobj = hdy_tab_view_get_pages(cast[ptr TabView00](self.impl))
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

proc hdy_tab_view_get_selected_page(self: ptr TabView00): ptr TabPage00 {.
    importc, libprag.}

proc getSelectedPage*(self: TabView): TabPage =
  let gobj = hdy_tab_view_get_selected_page(cast[ptr TabView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc selectedPage*(self: TabView): TabPage =
  let gobj = hdy_tab_view_get_selected_page(cast[ptr TabView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_get_shortcut_widget(self: ptr TabView00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getShortcutWidget*(self: TabView): gtk.Widget =
  let gobj = hdy_tab_view_get_shortcut_widget(cast[ptr TabView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc shortcutWidget*(self: TabView): gtk.Widget =
  let gobj = hdy_tab_view_get_shortcut_widget(cast[ptr TabView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_insert(self: ptr TabView00; child: ptr gtk.Widget00; position: int32): ptr TabPage00 {.
    importc, libprag.}

proc insert*(self: TabView; child: gtk.Widget; position: int): TabPage =
  let gobj = hdy_tab_view_insert(cast[ptr TabView00](self.impl), cast[ptr gtk.Widget00](child.impl), int32(position))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_insert_pinned(self: ptr TabView00; child: ptr gtk.Widget00;
    position: int32): ptr TabPage00 {.
    importc, libprag.}

proc insertPinned*(self: TabView; child: gtk.Widget; position: int): TabPage =
  let gobj = hdy_tab_view_insert_pinned(cast[ptr TabView00](self.impl), cast[ptr gtk.Widget00](child.impl), int32(position))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_prepend(self: ptr TabView00; child: ptr gtk.Widget00): ptr TabPage00 {.
    importc, libprag.}

proc prepend*(self: TabView; child: gtk.Widget): TabPage =
  let gobj = hdy_tab_view_prepend(cast[ptr TabView00](self.impl), cast[ptr gtk.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_prepend_pinned(self: ptr TabView00; child: ptr gtk.Widget00): ptr TabPage00 {.
    importc, libprag.}

proc prependPinned*(self: TabView; child: gtk.Widget): TabPage =
  let gobj = hdy_tab_view_prepend_pinned(cast[ptr TabView00](self.impl), cast[ptr gtk.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_view_reorder_backward(self: ptr TabView00; page: ptr TabPage00): gboolean {.
    importc, libprag.}

proc reorderBackward*(self: TabView; page: TabPage): bool =
  toBool(hdy_tab_view_reorder_backward(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl)))

proc hdy_tab_view_reorder_first(self: ptr TabView00; page: ptr TabPage00): gboolean {.
    importc, libprag.}

proc reorderFirst*(self: TabView; page: TabPage): bool =
  toBool(hdy_tab_view_reorder_first(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl)))

proc hdy_tab_view_reorder_forward(self: ptr TabView00; page: ptr TabPage00): gboolean {.
    importc, libprag.}

proc reorderForward*(self: TabView; page: TabPage): bool =
  toBool(hdy_tab_view_reorder_forward(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl)))

proc hdy_tab_view_reorder_last(self: ptr TabView00; page: ptr TabPage00): gboolean {.
    importc, libprag.}

proc reorderLast*(self: TabView; page: TabPage): bool =
  toBool(hdy_tab_view_reorder_last(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl)))

proc hdy_tab_view_reorder_page(self: ptr TabView00; page: ptr TabPage00;
    position: int32): gboolean {.
    importc, libprag.}

proc reorderPage*(self: TabView; page: TabPage; position: int): bool =
  toBool(hdy_tab_view_reorder_page(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl), int32(position)))

proc hdy_tab_view_select_next_page(self: ptr TabView00): gboolean {.
    importc, libprag.}

proc selectNextPage*(self: TabView): bool =
  toBool(hdy_tab_view_select_next_page(cast[ptr TabView00](self.impl)))

proc hdy_tab_view_select_previous_page(self: ptr TabView00): gboolean {.
    importc, libprag.}

proc selectPreviousPage*(self: TabView): bool =
  toBool(hdy_tab_view_select_previous_page(cast[ptr TabView00](self.impl)))

proc hdy_tab_view_set_default_icon(self: ptr TabView00; defaultIcon: ptr gio.Icon00) {.
    importc, libprag.}

proc setDefaultIcon*(self: TabView; defaultIcon: gio.Icon) =
  hdy_tab_view_set_default_icon(cast[ptr TabView00](self.impl), cast[ptr gio.Icon00](defaultIcon.impl))

proc `defaultIcon=`*(self: TabView; defaultIcon: gio.Icon) =
  hdy_tab_view_set_default_icon(cast[ptr TabView00](self.impl), cast[ptr gio.Icon00](defaultIcon.impl))

proc hdy_tab_view_set_menu_model(self: ptr TabView00; menuModel: ptr gio.MenuModel00) {.
    importc, libprag.}

proc setMenuModel*(self: TabView; menuModel: gio.MenuModel = nil) =
  hdy_tab_view_set_menu_model(cast[ptr TabView00](self.impl), if menuModel.isNil: nil else: cast[ptr gio.MenuModel00](menuModel.impl))

proc `menuModel=`*(self: TabView; menuModel: gio.MenuModel = nil) =
  hdy_tab_view_set_menu_model(cast[ptr TabView00](self.impl), if menuModel.isNil: nil else: cast[ptr gio.MenuModel00](menuModel.impl))

proc hdy_tab_view_set_page_pinned(self: ptr TabView00; page: ptr TabPage00;
    pinned: gboolean) {.
    importc, libprag.}

proc setPagePinned*(self: TabView; page: TabPage; pinned: bool) =
  hdy_tab_view_set_page_pinned(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl), gboolean(pinned))

proc hdy_tab_view_set_selected_page(self: ptr TabView00; selectedPage: ptr TabPage00) {.
    importc, libprag.}

proc setSelectedPage*(self: TabView; selectedPage: TabPage) =
  hdy_tab_view_set_selected_page(cast[ptr TabView00](self.impl), cast[ptr TabPage00](selectedPage.impl))

proc `selectedPage=`*(self: TabView; selectedPage: TabPage) =
  hdy_tab_view_set_selected_page(cast[ptr TabView00](self.impl), cast[ptr TabPage00](selectedPage.impl))

proc hdy_tab_view_set_shortcut_widget(self: ptr TabView00; widget: ptr gtk.Widget00) {.
    importc, libprag.}

proc setShortcutWidget*(self: TabView; widget: gtk.Widget = nil) =
  hdy_tab_view_set_shortcut_widget(cast[ptr TabView00](self.impl), if widget.isNil: nil else: cast[ptr gtk.Widget00](widget.impl))

proc `shortcutWidget=`*(self: TabView; widget: gtk.Widget = nil) =
  hdy_tab_view_set_shortcut_widget(cast[ptr TabView00](self.impl), if widget.isNil: nil else: cast[ptr gtk.Widget00](widget.impl))

proc hdy_tab_view_transfer_page(self: ptr TabView00; page: ptr TabPage00;
    otherView: ptr TabView00; position: int32) {.
    importc, libprag.}

proc transferPage*(self: TabView; page: TabPage; otherView: TabView;
    position: int) =
  hdy_tab_view_transfer_page(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl), cast[ptr TabView00](otherView.impl), int32(position))

proc hdy_tab_bar_get_view(self: ptr TabBar00): ptr TabView00 {.
    importc, libprag.}

proc getView*(self: TabBar): TabView =
  let gobj = hdy_tab_bar_get_view(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: TabBar): TabView =
  let gobj = hdy_tab_bar_get_view(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_tab_bar_set_view(self: ptr TabBar00; view: ptr TabView00) {.
    importc, libprag.}

proc setView*(self: TabBar; view: TabView = nil) =
  hdy_tab_bar_set_view(cast[ptr TabBar00](self.impl), if view.isNil: nil else: cast[ptr TabView00](view.impl))

proc `view=`*(self: TabBar; view: TabView = nil) =
  hdy_tab_bar_set_view(cast[ptr TabBar00](self.impl), if view.isNil: nil else: cast[ptr TabView00](view.impl))

type
  TitleBar* = ref object of gtk.Bin
  TitleBar00* = object of gtk.Bin00

proc hdy_title_bar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TitleBar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_title_bar_new(): ptr TitleBar00 {.
    importc, libprag.}

proc newTitleBar*(): TitleBar {.deprecated.}  =
  let gobj = hdy_title_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTitleBar*(tdesc: typedesc): tdesc {.deprecated.}  =
  assert(result is TitleBar)
  let gobj = hdy_title_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTitleBar*[T](result: var T) {.deprecated.} =
  assert(result is TitleBar)
  let gobj = hdy_title_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_title_bar_get_selection_mode(self: ptr TitleBar00): gboolean {.
    importc, libprag.}

proc getSelectionMode*(self: TitleBar): bool =
  toBool(hdy_title_bar_get_selection_mode(cast[ptr TitleBar00](self.impl)))

proc selectionMode*(self: TitleBar): bool =
  toBool(hdy_title_bar_get_selection_mode(cast[ptr TitleBar00](self.impl)))

proc hdy_title_bar_set_selection_mode(self: ptr TitleBar00; selectionMode: gboolean) {.
    importc, libprag.}

proc setSelectionMode*(self: TitleBar; selectionMode: bool = true) =
  hdy_title_bar_set_selection_mode(cast[ptr TitleBar00](self.impl), gboolean(selectionMode))

proc `selectionMode=`*(self: TitleBar; selectionMode: bool) =
  hdy_title_bar_set_selection_mode(cast[ptr TitleBar00](self.impl), gboolean(selectionMode))

type
  ValueObject* = ref object of gobject.Object
  ValueObject00* = object of gobject.Object00

proc hdy_value_object_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ValueObject()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_value_object_new(value: gobject.Value): ptr ValueObject00 {.
    importc, libprag.}

proc newValueObject*(value: gobject.Value): ValueObject =
  let gobj = hdy_value_object_new(value)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueObject*(tdesc: typedesc; value: gobject.Value): tdesc =
  assert(result is ValueObject)
  let gobj = hdy_value_object_new(value)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueObject*[T](result: var T; value: gobject.Value) {.deprecated.} =
  assert(result is ValueObject)
  let gobj = hdy_value_object_new(value)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_value_object_copy_value(self: ptr ValueObject00; dest: gobject.Value) {.
    importc, libprag.}

proc copyValue*(self: ValueObject; dest: gobject.Value) =
  hdy_value_object_copy_value(cast[ptr ValueObject00](self.impl), dest)

proc hdy_value_object_dup_string(self: ptr ValueObject00): cstring {.
    importc, libprag.}

proc dupString*(self: ValueObject): string =
  let resul0 = hdy_value_object_dup_string(cast[ptr ValueObject00](self.impl))
  result = $resul0
  cogfree(resul0)

proc hdy_value_object_get_string(self: ptr ValueObject00): cstring {.
    importc, libprag.}

proc getString*(self: ValueObject): string =
  result = $hdy_value_object_get_string(cast[ptr ValueObject00](self.impl))

proc hdy_value_object_get_value(self: ptr ValueObject00): ptr gobject.Value {.
    importc, libprag.}

proc getValue*(self: ValueObject): ptr gobject.Value =
  hdy_value_object_get_value(cast[ptr ValueObject00](self.impl))

proc value*(self: ValueObject): ptr gobject.Value =
  hdy_value_object_get_value(cast[ptr ValueObject00](self.impl))

type
  ViewSwitcher* = ref object of gtk.Bin
  ViewSwitcher00* = object of gtk.Bin00

proc hdy_view_switcher_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ViewSwitcher()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_view_switcher_new(): ptr ViewSwitcher00 {.
    importc, libprag.}

proc newViewSwitcher*(): ViewSwitcher =
  let gobj = hdy_view_switcher_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newViewSwitcher*(tdesc: typedesc): tdesc =
  assert(result is ViewSwitcher)
  let gobj = hdy_view_switcher_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initViewSwitcher*[T](result: var T) {.deprecated.} =
  assert(result is ViewSwitcher)
  let gobj = hdy_view_switcher_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_view_switcher_get_narrow_ellipsize(self: ptr ViewSwitcher00): pango.EllipsizeMode {.
    importc, libprag.}

proc getNarrowEllipsize*(self: ViewSwitcher): pango.EllipsizeMode =
  hdy_view_switcher_get_narrow_ellipsize(cast[ptr ViewSwitcher00](self.impl))

proc narrowEllipsize*(self: ViewSwitcher): pango.EllipsizeMode =
  hdy_view_switcher_get_narrow_ellipsize(cast[ptr ViewSwitcher00](self.impl))

proc hdy_view_switcher_get_stack(self: ptr ViewSwitcher00): ptr gtk.Stack00 {.
    importc, libprag.}

proc getStack*(self: ViewSwitcher): gtk.Stack =
  let gobj = hdy_view_switcher_get_stack(cast[ptr ViewSwitcher00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc stack*(self: ViewSwitcher): gtk.Stack =
  let gobj = hdy_view_switcher_get_stack(cast[ptr ViewSwitcher00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_view_switcher_set_narrow_ellipsize(self: ptr ViewSwitcher00; mode: pango.EllipsizeMode) {.
    importc, libprag.}

proc setNarrowEllipsize*(self: ViewSwitcher; mode: pango.EllipsizeMode) =
  hdy_view_switcher_set_narrow_ellipsize(cast[ptr ViewSwitcher00](self.impl), mode)

proc `narrowEllipsize=`*(self: ViewSwitcher; mode: pango.EllipsizeMode) =
  hdy_view_switcher_set_narrow_ellipsize(cast[ptr ViewSwitcher00](self.impl), mode)

proc hdy_view_switcher_set_stack(self: ptr ViewSwitcher00; stack: ptr gtk.Stack00) {.
    importc, libprag.}

proc setStack*(self: ViewSwitcher; stack: gtk.Stack = nil) =
  hdy_view_switcher_set_stack(cast[ptr ViewSwitcher00](self.impl), if stack.isNil: nil else: cast[ptr gtk.Stack00](stack.impl))

proc `stack=`*(self: ViewSwitcher; stack: gtk.Stack = nil) =
  hdy_view_switcher_set_stack(cast[ptr ViewSwitcher00](self.impl), if stack.isNil: nil else: cast[ptr gtk.Stack00](stack.impl))

type
  ViewSwitcherPolicy* {.size: sizeof(cint), pure.} = enum
    auto = 0
    narrow = 1
    wide = 2

proc hdy_view_switcher_get_policy(self: ptr ViewSwitcher00): ViewSwitcherPolicy {.
    importc, libprag.}

proc getPolicy*(self: ViewSwitcher): ViewSwitcherPolicy =
  hdy_view_switcher_get_policy(cast[ptr ViewSwitcher00](self.impl))

proc policy*(self: ViewSwitcher): ViewSwitcherPolicy =
  hdy_view_switcher_get_policy(cast[ptr ViewSwitcher00](self.impl))

proc hdy_view_switcher_set_policy(self: ptr ViewSwitcher00; policy: ViewSwitcherPolicy) {.
    importc, libprag.}

proc setPolicy*(self: ViewSwitcher; policy: ViewSwitcherPolicy) =
  hdy_view_switcher_set_policy(cast[ptr ViewSwitcher00](self.impl), policy)

proc `policy=`*(self: ViewSwitcher; policy: ViewSwitcherPolicy) =
  hdy_view_switcher_set_policy(cast[ptr ViewSwitcher00](self.impl), policy)

type
  ViewSwitcherBar* = ref object of gtk.Bin
  ViewSwitcherBar00* = object of gtk.Bin00

proc hdy_view_switcher_bar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ViewSwitcherBar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_view_switcher_bar_new(): ptr ViewSwitcherBar00 {.
    importc, libprag.}

proc newViewSwitcherBar*(): ViewSwitcherBar =
  let gobj = hdy_view_switcher_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newViewSwitcherBar*(tdesc: typedesc): tdesc =
  assert(result is ViewSwitcherBar)
  let gobj = hdy_view_switcher_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initViewSwitcherBar*[T](result: var T) {.deprecated.} =
  assert(result is ViewSwitcherBar)
  let gobj = hdy_view_switcher_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_view_switcher_bar_get_policy(self: ptr ViewSwitcherBar00): ViewSwitcherPolicy {.
    importc, libprag.}

proc getPolicy*(self: ViewSwitcherBar): ViewSwitcherPolicy =
  hdy_view_switcher_bar_get_policy(cast[ptr ViewSwitcherBar00](self.impl))

proc policy*(self: ViewSwitcherBar): ViewSwitcherPolicy =
  hdy_view_switcher_bar_get_policy(cast[ptr ViewSwitcherBar00](self.impl))

proc hdy_view_switcher_bar_get_reveal(self: ptr ViewSwitcherBar00): gboolean {.
    importc, libprag.}

proc getReveal*(self: ViewSwitcherBar): bool =
  toBool(hdy_view_switcher_bar_get_reveal(cast[ptr ViewSwitcherBar00](self.impl)))

proc reveal*(self: ViewSwitcherBar): bool =
  toBool(hdy_view_switcher_bar_get_reveal(cast[ptr ViewSwitcherBar00](self.impl)))

proc hdy_view_switcher_bar_get_stack(self: ptr ViewSwitcherBar00): ptr gtk.Stack00 {.
    importc, libprag.}

proc getStack*(self: ViewSwitcherBar): gtk.Stack =
  let gobj = hdy_view_switcher_bar_get_stack(cast[ptr ViewSwitcherBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc stack*(self: ViewSwitcherBar): gtk.Stack =
  let gobj = hdy_view_switcher_bar_get_stack(cast[ptr ViewSwitcherBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_view_switcher_bar_set_policy(self: ptr ViewSwitcherBar00; policy: ViewSwitcherPolicy) {.
    importc, libprag.}

proc setPolicy*(self: ViewSwitcherBar; policy: ViewSwitcherPolicy) =
  hdy_view_switcher_bar_set_policy(cast[ptr ViewSwitcherBar00](self.impl), policy)

proc `policy=`*(self: ViewSwitcherBar; policy: ViewSwitcherPolicy) =
  hdy_view_switcher_bar_set_policy(cast[ptr ViewSwitcherBar00](self.impl), policy)

proc hdy_view_switcher_bar_set_reveal(self: ptr ViewSwitcherBar00; reveal: gboolean) {.
    importc, libprag.}

proc setReveal*(self: ViewSwitcherBar; reveal: bool = true) =
  hdy_view_switcher_bar_set_reveal(cast[ptr ViewSwitcherBar00](self.impl), gboolean(reveal))

proc `reveal=`*(self: ViewSwitcherBar; reveal: bool) =
  hdy_view_switcher_bar_set_reveal(cast[ptr ViewSwitcherBar00](self.impl), gboolean(reveal))

proc hdy_view_switcher_bar_set_stack(self: ptr ViewSwitcherBar00; stack: ptr gtk.Stack00) {.
    importc, libprag.}

proc setStack*(self: ViewSwitcherBar; stack: gtk.Stack = nil) =
  hdy_view_switcher_bar_set_stack(cast[ptr ViewSwitcherBar00](self.impl), if stack.isNil: nil else: cast[ptr gtk.Stack00](stack.impl))

proc `stack=`*(self: ViewSwitcherBar; stack: gtk.Stack = nil) =
  hdy_view_switcher_bar_set_stack(cast[ptr ViewSwitcherBar00](self.impl), if stack.isNil: nil else: cast[ptr gtk.Stack00](stack.impl))

type
  ViewSwitcherTitle* = ref object of gtk.Bin
  ViewSwitcherTitle00* = object of gtk.Bin00

proc hdy_view_switcher_title_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ViewSwitcherTitle()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_view_switcher_title_new(): ptr ViewSwitcherTitle00 {.
    importc, libprag.}

proc newViewSwitcherTitle*(): ViewSwitcherTitle =
  let gobj = hdy_view_switcher_title_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newViewSwitcherTitle*(tdesc: typedesc): tdesc =
  assert(result is ViewSwitcherTitle)
  let gobj = hdy_view_switcher_title_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initViewSwitcherTitle*[T](result: var T) {.deprecated.} =
  assert(result is ViewSwitcherTitle)
  let gobj = hdy_view_switcher_title_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, handy.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_view_switcher_title_get_policy(self: ptr ViewSwitcherTitle00): ViewSwitcherPolicy {.
    importc, libprag.}

proc getPolicy*(self: ViewSwitcherTitle): ViewSwitcherPolicy =
  hdy_view_switcher_title_get_policy(cast[ptr ViewSwitcherTitle00](self.impl))

proc policy*(self: ViewSwitcherTitle): ViewSwitcherPolicy =
  hdy_view_switcher_title_get_policy(cast[ptr ViewSwitcherTitle00](self.impl))

proc hdy_view_switcher_title_get_stack(self: ptr ViewSwitcherTitle00): ptr gtk.Stack00 {.
    importc, libprag.}

proc getStack*(self: ViewSwitcherTitle): gtk.Stack =
  let gobj = hdy_view_switcher_title_get_stack(cast[ptr ViewSwitcherTitle00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc stack*(self: ViewSwitcherTitle): gtk.Stack =
  let gobj = hdy_view_switcher_title_get_stack(cast[ptr ViewSwitcherTitle00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hdy_view_switcher_title_get_subtitle(self: ptr ViewSwitcherTitle00): cstring {.
    importc, libprag.}

proc getSubtitle*(self: ViewSwitcherTitle): string =
  let resul0 = hdy_view_switcher_title_get_subtitle(cast[ptr ViewSwitcherTitle00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc subtitle*(self: ViewSwitcherTitle): string =
  let resul0 = hdy_view_switcher_title_get_subtitle(cast[ptr ViewSwitcherTitle00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_view_switcher_title_get_title(self: ptr ViewSwitcherTitle00): cstring {.
    importc, libprag.}

proc getTitle*(self: ViewSwitcherTitle): string =
  let resul0 = hdy_view_switcher_title_get_title(cast[ptr ViewSwitcherTitle00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc title*(self: ViewSwitcherTitle): string =
  let resul0 = hdy_view_switcher_title_get_title(cast[ptr ViewSwitcherTitle00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hdy_view_switcher_title_get_title_visible(self: ptr ViewSwitcherTitle00): gboolean {.
    importc, libprag.}

proc getTitleVisible*(self: ViewSwitcherTitle): bool =
  toBool(hdy_view_switcher_title_get_title_visible(cast[ptr ViewSwitcherTitle00](self.impl)))

proc titleVisible*(self: ViewSwitcherTitle): bool =
  toBool(hdy_view_switcher_title_get_title_visible(cast[ptr ViewSwitcherTitle00](self.impl)))

proc hdy_view_switcher_title_get_view_switcher_enabled(self: ptr ViewSwitcherTitle00): gboolean {.
    importc, libprag.}

proc getViewSwitcherEnabled*(self: ViewSwitcherTitle): bool =
  toBool(hdy_view_switcher_title_get_view_switcher_enabled(cast[ptr ViewSwitcherTitle00](self.impl)))

proc viewSwitcherEnabled*(self: ViewSwitcherTitle): bool =
  toBool(hdy_view_switcher_title_get_view_switcher_enabled(cast[ptr ViewSwitcherTitle00](self.impl)))

proc hdy_view_switcher_title_set_policy(self: ptr ViewSwitcherTitle00; policy: ViewSwitcherPolicy) {.
    importc, libprag.}

proc setPolicy*(self: ViewSwitcherTitle; policy: ViewSwitcherPolicy) =
  hdy_view_switcher_title_set_policy(cast[ptr ViewSwitcherTitle00](self.impl), policy)

proc `policy=`*(self: ViewSwitcherTitle; policy: ViewSwitcherPolicy) =
  hdy_view_switcher_title_set_policy(cast[ptr ViewSwitcherTitle00](self.impl), policy)

proc hdy_view_switcher_title_set_stack(self: ptr ViewSwitcherTitle00; stack: ptr gtk.Stack00) {.
    importc, libprag.}

proc setStack*(self: ViewSwitcherTitle; stack: gtk.Stack = nil) =
  hdy_view_switcher_title_set_stack(cast[ptr ViewSwitcherTitle00](self.impl), if stack.isNil: nil else: cast[ptr gtk.Stack00](stack.impl))

proc `stack=`*(self: ViewSwitcherTitle; stack: gtk.Stack = nil) =
  hdy_view_switcher_title_set_stack(cast[ptr ViewSwitcherTitle00](self.impl), if stack.isNil: nil else: cast[ptr gtk.Stack00](stack.impl))

proc hdy_view_switcher_title_set_subtitle(self: ptr ViewSwitcherTitle00;
    subtitle: cstring) {.
    importc, libprag.}

proc setSubtitle*(self: ViewSwitcherTitle; subtitle: cstring = nil) =
  hdy_view_switcher_title_set_subtitle(cast[ptr ViewSwitcherTitle00](self.impl), subtitle)

proc `subtitle=`*(self: ViewSwitcherTitle; subtitle: cstring = nil) =
  hdy_view_switcher_title_set_subtitle(cast[ptr ViewSwitcherTitle00](self.impl), subtitle)

proc hdy_view_switcher_title_set_title(self: ptr ViewSwitcherTitle00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: ViewSwitcherTitle; title: cstring = nil) =
  hdy_view_switcher_title_set_title(cast[ptr ViewSwitcherTitle00](self.impl), title)

proc `title=`*(self: ViewSwitcherTitle; title: cstring = nil) =
  hdy_view_switcher_title_set_title(cast[ptr ViewSwitcherTitle00](self.impl), title)

proc hdy_view_switcher_title_set_view_switcher_enabled(self: ptr ViewSwitcherTitle00;
    enabled: gboolean) {.
    importc, libprag.}

proc setViewSwitcherEnabled*(self: ViewSwitcherTitle;
    enabled: bool = true) =
  hdy_view_switcher_title_set_view_switcher_enabled(cast[ptr ViewSwitcherTitle00](self.impl), gboolean(enabled))

proc `viewSwitcherEnabled=`*(self: ViewSwitcherTitle;
    enabled: bool) =
  hdy_view_switcher_title_set_view_switcher_enabled(cast[ptr ViewSwitcherTitle00](self.impl), gboolean(enabled))

type
  WindowHandle* = ref object of gtk.EventBox
  WindowHandle00* = object of gtk.EventBox00

proc hdy_window_handle_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WindowHandle()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc hdy_window_handle_new(): ptr WindowHandle00 {.
    importc, libprag.}

proc newWindowHandle*(): WindowHandle =
  let gobj = hdy_window_handle_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWindowHandle*(tdesc: typedesc): tdesc =
  assert(result is WindowHandle)
  let gobj = hdy_window_handle_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWindowHandle*[T](result: var T) {.deprecated.} =
  assert(result is WindowHandle)
  let gobj = hdy_window_handle_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc easeOutCubic*(t: cdouble): cdouble {.
    importc: "hdy_ease_out_cubic", libprag.}

proc hdy_enum_value_row_name(value: ptr EnumValueObject00; userData: pointer): cstring {.
    importc, libprag.}

proc enumValueRowName*(value: EnumValueObject; userData: pointer): string =
  let resul0 = hdy_enum_value_row_name(cast[ptr EnumValueObject00](value.impl), userData)
  result = $resul0
  cogfree(resul0)

proc hdy_get_enable_animations(widget: ptr gtk.Widget00): gboolean {.
    importc, libprag.}

proc getEnableAnimations*(widget: gtk.Widget): bool =
  toBool(hdy_get_enable_animations(cast[ptr gtk.Widget00](widget.impl)))

proc enableAnimations*(widget: gtk.Widget): bool =
  toBool(hdy_get_enable_animations(cast[ptr gtk.Widget00](widget.impl)))

proc init*() {.
    importc: "hdy_init", libprag.}
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc implementorIface*(x: handy.ActionRow): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc actionable*(x: handy.ActionRow): gtk.Actionable = cast[gtk.Actionable](x)

proc buildable*(x: handy.ActionRow): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.ApplicationWindow): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc actionGroup*(x: handy.ApplicationWindow): gio.ActionGroup = cast[gio.ActionGroup](x)

proc actionMap*(x: handy.ApplicationWindow): gio.ActionMap = cast[gio.ActionMap](x)

proc buildable*(x: handy.ApplicationWindow): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.Avatar): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.Avatar): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.Carousel): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.Carousel): gtk.Buildable = cast[gtk.Buildable](x)

proc orientable*(x: handy.Carousel): gtk.Orientable = cast[gtk.Orientable](x)

proc implementorIface*(x: handy.CarouselIndicatorDots): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.CarouselIndicatorDots): gtk.Buildable = cast[gtk.Buildable](x)

proc orientable*(x: handy.CarouselIndicatorDots): gtk.Orientable = cast[gtk.Orientable](x)

proc implementorIface*(x: handy.CarouselIndicatorLines): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.CarouselIndicatorLines): gtk.Buildable = cast[gtk.Buildable](x)

proc orientable*(x: handy.CarouselIndicatorLines): gtk.Orientable = cast[gtk.Orientable](x)

proc implementorIface*(x: handy.Clamp): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.Clamp): gtk.Buildable = cast[gtk.Buildable](x)

proc orientable*(x: handy.Clamp): gtk.Orientable = cast[gtk.Orientable](x)

proc implementorIface*(x: handy.ComboRow): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc actionable*(x: handy.ComboRow): gtk.Actionable = cast[gtk.Actionable](x)

proc buildable*(x: handy.ComboRow): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.Deck): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.Deck): gtk.Buildable = cast[gtk.Buildable](x)

proc orientable*(x: handy.Deck): gtk.Orientable = cast[gtk.Orientable](x)

proc implementorIface*(x: handy.ExpanderRow): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc actionable*(x: handy.ExpanderRow): gtk.Actionable = cast[gtk.Actionable](x)

proc buildable*(x: handy.ExpanderRow): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.Flap): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.Flap): gtk.Buildable = cast[gtk.Buildable](x)

proc orientable*(x: handy.Flap): gtk.Orientable = cast[gtk.Orientable](x)

proc implementorIface*(x: handy.HeaderBar): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.HeaderBar): gtk.Buildable = cast[gtk.Buildable](x)

proc buildable*(x: handy.HeaderGroup): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.Keypad): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.Keypad): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.Leaflet): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.Leaflet): gtk.Buildable = cast[gtk.Buildable](x)

proc orientable*(x: handy.Leaflet): gtk.Orientable = cast[gtk.Orientable](x)

proc implementorIface*(x: handy.PreferencesGroup): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.PreferencesGroup): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.PreferencesPage): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.PreferencesPage): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.PreferencesRow): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc actionable*(x: handy.PreferencesRow): gtk.Actionable = cast[gtk.Actionable](x)

proc buildable*(x: handy.PreferencesRow): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.PreferencesWindow): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.PreferencesWindow): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.SearchBar): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.SearchBar): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.Squeezer): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.Squeezer): gtk.Buildable = cast[gtk.Buildable](x)

proc orientable*(x: handy.Squeezer): gtk.Orientable = cast[gtk.Orientable](x)

proc implementorIface*(x: handy.StatusPage): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.StatusPage): gtk.Buildable = cast[gtk.Buildable](x)

proc buildable*(x: handy.SwipeGroup): gtk.Buildable = cast[gtk.Buildable](x)

proc orientable*(x: handy.SwipeTracker): gtk.Orientable = cast[gtk.Orientable](x)

proc implementorIface*(x: handy.TabBar): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.TabBar): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.TabView): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.TabView): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.TitleBar): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.TitleBar): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.ViewSwitcher): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.ViewSwitcher): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.ViewSwitcherBar): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.ViewSwitcherBar): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.ViewSwitcherTitle): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.ViewSwitcherTitle): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.Window): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.Window): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: handy.WindowHandle): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: handy.WindowHandle): gtk.Buildable = cast[gtk.Buildable](x)

# dependencies:
# PangoCairo-1.0
# Gtk-4.0
# freetype2-2.0
# GLib-2.0
# GdkPixbuf-2.0
# HarfBuzz-0.0
# GModule-2.0
# cairo-1.0
# Graphene-1.0
# Gsk-4.0
# GObject-2.0
# Gdk-4.0
# Gio-2.0
# Pango-1.0
# immediate dependencies:
# Gtk-4.0
# Gio-2.0
# libraries:
# libadwaita-1.so.0
{.warning[UnusedImport]: off.}
import pangocairo, gtk4, freetype2, glib, gdkpixbuf, harfbuzz, gmodule, cairo, graphene, gsk, gobject, gdk4, gio, pango
const Lib = "libadwaita-1.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  Dialog* = ref object of gtk4.Widget
  Dialog00* = object of gtk4.Widget00

proc adw_dialog_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Dialog()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCloseAttempt*(self: Dialog;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "close-attempt", cast[GCallback](p), xdata, nil, cf)

proc scClosed*(self: Dialog;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cf)

proc adw_dialog_new(): ptr Dialog00 {.
    importc, libprag.}

proc newDialog*(): Dialog =
  let gobj = adw_dialog_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newDialog*(tdesc: typedesc): tdesc =
  assert(result is Dialog)
  let gobj = adw_dialog_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDialog*[T](result: var T) {.deprecated.} =
  assert(result is Dialog)
  let gobj = adw_dialog_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_dialog_close(self: ptr Dialog00): gboolean {.
    importc, libprag.}

proc close*(self: Dialog): bool =
  toBool(adw_dialog_close(cast[ptr Dialog00](self.impl)))

proc adw_dialog_force_close(self: ptr Dialog00) {.
    importc, libprag.}

proc forceClose*(self: Dialog) =
  adw_dialog_force_close(cast[ptr Dialog00](self.impl))

proc adw_dialog_get_can_close(self: ptr Dialog00): gboolean {.
    importc, libprag.}

proc getCanClose*(self: Dialog): bool =
  toBool(adw_dialog_get_can_close(cast[ptr Dialog00](self.impl)))

proc canClose*(self: Dialog): bool =
  toBool(adw_dialog_get_can_close(cast[ptr Dialog00](self.impl)))

proc adw_dialog_get_child(self: ptr Dialog00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: Dialog): gtk4.Widget =
  let gobj = adw_dialog_get_child(cast[ptr Dialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: Dialog): gtk4.Widget =
  let gobj = adw_dialog_get_child(cast[ptr Dialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_dialog_get_content_height(self: ptr Dialog00): int32 {.
    importc, libprag.}

proc getContentHeight*(self: Dialog): int =
  int(adw_dialog_get_content_height(cast[ptr Dialog00](self.impl)))

proc contentHeight*(self: Dialog): int =
  int(adw_dialog_get_content_height(cast[ptr Dialog00](self.impl)))

proc adw_dialog_get_content_width(self: ptr Dialog00): int32 {.
    importc, libprag.}

proc getContentWidth*(self: Dialog): int =
  int(adw_dialog_get_content_width(cast[ptr Dialog00](self.impl)))

proc contentWidth*(self: Dialog): int =
  int(adw_dialog_get_content_width(cast[ptr Dialog00](self.impl)))

proc adw_dialog_get_default_widget(self: ptr Dialog00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getDefaultWidget*(self: Dialog): gtk4.Widget =
  let gobj = adw_dialog_get_default_widget(cast[ptr Dialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc defaultWidget*(self: Dialog): gtk4.Widget =
  let gobj = adw_dialog_get_default_widget(cast[ptr Dialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_dialog_get_focus(self: ptr Dialog00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getFocus*(self: Dialog): gtk4.Widget =
  let gobj = adw_dialog_get_focus(cast[ptr Dialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc focus*(self: Dialog): gtk4.Widget =
  let gobj = adw_dialog_get_focus(cast[ptr Dialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_dialog_get_follows_content_size(self: ptr Dialog00): gboolean {.
    importc, libprag.}

proc getFollowsContentSize*(self: Dialog): bool =
  toBool(adw_dialog_get_follows_content_size(cast[ptr Dialog00](self.impl)))

proc followsContentSize*(self: Dialog): bool =
  toBool(adw_dialog_get_follows_content_size(cast[ptr Dialog00](self.impl)))

proc adw_dialog_get_title(self: ptr Dialog00): cstring {.
    importc, libprag.}

proc getTitle*(self: Dialog): string =
  result = $adw_dialog_get_title(cast[ptr Dialog00](self.impl))

proc title*(self: Dialog): string =
  result = $adw_dialog_get_title(cast[ptr Dialog00](self.impl))

proc adw_dialog_present(self: ptr Dialog00; parent: ptr gtk4.Widget00) {.
    importc, libprag.}

proc present*(self: Dialog; parent: gtk4.Widget = nil) =
  adw_dialog_present(cast[ptr Dialog00](self.impl), if parent.isNil: nil else: cast[ptr gtk4.Widget00](parent.impl))

proc adw_dialog_set_can_close(self: ptr Dialog00; canClose: gboolean) {.
    importc, libprag.}

proc setCanClose*(self: Dialog; canClose: bool = true) =
  adw_dialog_set_can_close(cast[ptr Dialog00](self.impl), gboolean(canClose))

proc `canClose=`*(self: Dialog; canClose: bool) =
  adw_dialog_set_can_close(cast[ptr Dialog00](self.impl), gboolean(canClose))

proc adw_dialog_set_child(self: ptr Dialog00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setChild*(self: Dialog; child: gtk4.Widget = nil) =
  adw_dialog_set_child(cast[ptr Dialog00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `child=`*(self: Dialog; child: gtk4.Widget = nil) =
  adw_dialog_set_child(cast[ptr Dialog00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc adw_dialog_set_content_height(self: ptr Dialog00; contentHeight: int32) {.
    importc, libprag.}

proc setContentHeight*(self: Dialog; contentHeight: int) =
  adw_dialog_set_content_height(cast[ptr Dialog00](self.impl), int32(contentHeight))

proc `contentHeight=`*(self: Dialog; contentHeight: int) =
  adw_dialog_set_content_height(cast[ptr Dialog00](self.impl), int32(contentHeight))

proc adw_dialog_set_content_width(self: ptr Dialog00; contentWidth: int32) {.
    importc, libprag.}

proc setContentWidth*(self: Dialog; contentWidth: int) =
  adw_dialog_set_content_width(cast[ptr Dialog00](self.impl), int32(contentWidth))

proc `contentWidth=`*(self: Dialog; contentWidth: int) =
  adw_dialog_set_content_width(cast[ptr Dialog00](self.impl), int32(contentWidth))

proc adw_dialog_set_default_widget(self: ptr Dialog00; defaultWidget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setDefaultWidget*(self: Dialog; defaultWidget: gtk4.Widget = nil) =
  adw_dialog_set_default_widget(cast[ptr Dialog00](self.impl), if defaultWidget.isNil: nil else: cast[ptr gtk4.Widget00](defaultWidget.impl))

proc `defaultWidget=`*(self: Dialog; defaultWidget: gtk4.Widget = nil) =
  adw_dialog_set_default_widget(cast[ptr Dialog00](self.impl), if defaultWidget.isNil: nil else: cast[ptr gtk4.Widget00](defaultWidget.impl))

proc adw_dialog_set_focus(self: ptr Dialog00; focus: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setFocus*(self: Dialog; focus: gtk4.Widget = nil) =
  adw_dialog_set_focus(cast[ptr Dialog00](self.impl), if focus.isNil: nil else: cast[ptr gtk4.Widget00](focus.impl))

proc `focus=`*(self: Dialog; focus: gtk4.Widget = nil) =
  adw_dialog_set_focus(cast[ptr Dialog00](self.impl), if focus.isNil: nil else: cast[ptr gtk4.Widget00](focus.impl))

proc adw_dialog_set_follows_content_size(self: ptr Dialog00; followsContentSize: gboolean) {.
    importc, libprag.}

proc setFollowsContentSize*(self: Dialog; followsContentSize: bool = true) =
  adw_dialog_set_follows_content_size(cast[ptr Dialog00](self.impl), gboolean(followsContentSize))

proc `followsContentSize=`*(self: Dialog; followsContentSize: bool) =
  adw_dialog_set_follows_content_size(cast[ptr Dialog00](self.impl), gboolean(followsContentSize))

proc adw_dialog_set_title(self: ptr Dialog00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: Dialog; title: cstring) =
  adw_dialog_set_title(cast[ptr Dialog00](self.impl), title)

proc `title=`*(self: Dialog; title: cstring) =
  adw_dialog_set_title(cast[ptr Dialog00](self.impl), title)

type
  AboutDialog* = ref object of Dialog
  AboutDialog00* = object of Dialog00

proc adw_about_dialog_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AboutDialog()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActivateLink*(self: AboutDialog;  p: proc (self: ptr AboutDialog00; uri: cstring; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "activate-link", cast[GCallback](p), xdata, nil, cf)

proc adw_about_dialog_new(): ptr AboutDialog00 {.
    importc, libprag.}

proc newAboutDialog*(): AboutDialog =
  let gobj = adw_about_dialog_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAboutDialog*(tdesc: typedesc): tdesc =
  assert(result is AboutDialog)
  let gobj = adw_about_dialog_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAboutDialog*[T](result: var T) {.deprecated.} =
  assert(result is AboutDialog)
  let gobj = adw_about_dialog_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_about_dialog_new_from_appdata(resourcePath: cstring; releaseNotesVersion: cstring): ptr AboutDialog00 {.
    importc, libprag.}

proc newAboutDialogFromAppdata*(resourcePath: cstring; releaseNotesVersion: cstring = nil): AboutDialog =
  let gobj = adw_about_dialog_new_from_appdata(resourcePath, releaseNotesVersion)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAboutDialogFromAppdata*(tdesc: typedesc; resourcePath: cstring; releaseNotesVersion: cstring = nil): tdesc =
  assert(result is AboutDialog)
  let gobj = adw_about_dialog_new_from_appdata(resourcePath, releaseNotesVersion)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAboutDialogFromAppdata*[T](result: var T; resourcePath: cstring; releaseNotesVersion: cstring = nil) {.deprecated.} =
  assert(result is AboutDialog)
  let gobj = adw_about_dialog_new_from_appdata(resourcePath, releaseNotesVersion)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_about_dialog_add_acknowledgement_section(self: ptr AboutDialog00;
    name: cstring; people: ptr cstring) {.
    importc, libprag.}

proc addAcknowledgementSection*(self: AboutDialog; name: cstring = nil;
    people: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_dialog_add_acknowledgement_section(cast[ptr AboutDialog00](self.impl), name, seq2CstringArray(people, fs469n23))

proc adw_about_dialog_add_credit_section(self: ptr AboutDialog00; name: cstring;
    people: ptr cstring) {.
    importc, libprag.}

proc addCreditSection*(self: AboutDialog; name: cstring = nil;
    people: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_dialog_add_credit_section(cast[ptr AboutDialog00](self.impl), name, seq2CstringArray(people, fs469n23))

proc adw_about_dialog_add_legal_section(self: ptr AboutDialog00; title: cstring;
    copyright: cstring; licenseType: gtk4.License; license: cstring) {.
    importc, libprag.}

proc addLegalSection*(self: AboutDialog; title: cstring;
    copyright: cstring = nil; licenseType: gtk4.License; license: cstring = nil) =
  adw_about_dialog_add_legal_section(cast[ptr AboutDialog00](self.impl), title, copyright, licenseType, license)

proc adw_about_dialog_add_link(self: ptr AboutDialog00; title: cstring; url: cstring) {.
    importc, libprag.}

proc addLink*(self: AboutDialog; title: cstring; url: cstring) =
  adw_about_dialog_add_link(cast[ptr AboutDialog00](self.impl), title, url)

proc adw_about_dialog_get_application_icon(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getApplicationIcon*(self: AboutDialog): string =
  result = $adw_about_dialog_get_application_icon(cast[ptr AboutDialog00](self.impl))

proc applicationIcon*(self: AboutDialog): string =
  result = $adw_about_dialog_get_application_icon(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_application_name(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getApplicationName*(self: AboutDialog): string =
  result = $adw_about_dialog_get_application_name(cast[ptr AboutDialog00](self.impl))

proc applicationName*(self: AboutDialog): string =
  result = $adw_about_dialog_get_application_name(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_artists(self: ptr AboutDialog00): ptr cstring {.
    importc, libprag.}

proc getArtists*(self: AboutDialog): seq[string] =
  let resul0 = adw_about_dialog_get_artists(cast[ptr AboutDialog00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc artists*(self: AboutDialog): seq[string] =
  let resul0 = adw_about_dialog_get_artists(cast[ptr AboutDialog00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc adw_about_dialog_get_comments(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getComments*(self: AboutDialog): string =
  result = $adw_about_dialog_get_comments(cast[ptr AboutDialog00](self.impl))

proc comments*(self: AboutDialog): string =
  result = $adw_about_dialog_get_comments(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_copyright(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getCopyright*(self: AboutDialog): string =
  result = $adw_about_dialog_get_copyright(cast[ptr AboutDialog00](self.impl))

proc copyright*(self: AboutDialog): string =
  result = $adw_about_dialog_get_copyright(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_debug_info(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getDebugInfo*(self: AboutDialog): string =
  result = $adw_about_dialog_get_debug_info(cast[ptr AboutDialog00](self.impl))

proc debugInfo*(self: AboutDialog): string =
  result = $adw_about_dialog_get_debug_info(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_debug_info_filename(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getDebugInfoFilename*(self: AboutDialog): string =
  result = $adw_about_dialog_get_debug_info_filename(cast[ptr AboutDialog00](self.impl))

proc debugInfoFilename*(self: AboutDialog): string =
  result = $adw_about_dialog_get_debug_info_filename(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_designers(self: ptr AboutDialog00): ptr cstring {.
    importc, libprag.}

proc getDesigners*(self: AboutDialog): seq[string] =
  let resul0 = adw_about_dialog_get_designers(cast[ptr AboutDialog00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc designers*(self: AboutDialog): seq[string] =
  let resul0 = adw_about_dialog_get_designers(cast[ptr AboutDialog00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc adw_about_dialog_get_developer_name(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getDeveloperName*(self: AboutDialog): string =
  result = $adw_about_dialog_get_developer_name(cast[ptr AboutDialog00](self.impl))

proc developerName*(self: AboutDialog): string =
  result = $adw_about_dialog_get_developer_name(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_developers(self: ptr AboutDialog00): ptr cstring {.
    importc, libprag.}

proc getDevelopers*(self: AboutDialog): seq[string] =
  let resul0 = adw_about_dialog_get_developers(cast[ptr AboutDialog00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc developers*(self: AboutDialog): seq[string] =
  let resul0 = adw_about_dialog_get_developers(cast[ptr AboutDialog00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc adw_about_dialog_get_documenters(self: ptr AboutDialog00): ptr cstring {.
    importc, libprag.}

proc getDocumenters*(self: AboutDialog): seq[string] =
  let resul0 = adw_about_dialog_get_documenters(cast[ptr AboutDialog00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc documenters*(self: AboutDialog): seq[string] =
  let resul0 = adw_about_dialog_get_documenters(cast[ptr AboutDialog00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc adw_about_dialog_get_issue_url(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getIssueUrl*(self: AboutDialog): string =
  result = $adw_about_dialog_get_issue_url(cast[ptr AboutDialog00](self.impl))

proc issueUrl*(self: AboutDialog): string =
  result = $adw_about_dialog_get_issue_url(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_license(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getLicense*(self: AboutDialog): string =
  result = $adw_about_dialog_get_license(cast[ptr AboutDialog00](self.impl))

proc license*(self: AboutDialog): string =
  result = $adw_about_dialog_get_license(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_license_type(self: ptr AboutDialog00): gtk4.License {.
    importc, libprag.}

proc getLicenseType*(self: AboutDialog): gtk4.License =
  adw_about_dialog_get_license_type(cast[ptr AboutDialog00](self.impl))

proc licenseType*(self: AboutDialog): gtk4.License =
  adw_about_dialog_get_license_type(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_release_notes(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getReleaseNotes*(self: AboutDialog): string =
  result = $adw_about_dialog_get_release_notes(cast[ptr AboutDialog00](self.impl))

proc releaseNotes*(self: AboutDialog): string =
  result = $adw_about_dialog_get_release_notes(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_release_notes_version(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getReleaseNotesVersion*(self: AboutDialog): string =
  result = $adw_about_dialog_get_release_notes_version(cast[ptr AboutDialog00](self.impl))

proc releaseNotesVersion*(self: AboutDialog): string =
  result = $adw_about_dialog_get_release_notes_version(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_support_url(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getSupportUrl*(self: AboutDialog): string =
  result = $adw_about_dialog_get_support_url(cast[ptr AboutDialog00](self.impl))

proc supportUrl*(self: AboutDialog): string =
  result = $adw_about_dialog_get_support_url(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_translator_credits(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getTranslatorCredits*(self: AboutDialog): string =
  result = $adw_about_dialog_get_translator_credits(cast[ptr AboutDialog00](self.impl))

proc translatorCredits*(self: AboutDialog): string =
  result = $adw_about_dialog_get_translator_credits(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_version(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getVersion*(self: AboutDialog): string =
  result = $adw_about_dialog_get_version(cast[ptr AboutDialog00](self.impl))

proc version*(self: AboutDialog): string =
  result = $adw_about_dialog_get_version(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_get_website(self: ptr AboutDialog00): cstring {.
    importc, libprag.}

proc getWebsite*(self: AboutDialog): string =
  result = $adw_about_dialog_get_website(cast[ptr AboutDialog00](self.impl))

proc website*(self: AboutDialog): string =
  result = $adw_about_dialog_get_website(cast[ptr AboutDialog00](self.impl))

proc adw_about_dialog_set_application_icon(self: ptr AboutDialog00; applicationIcon: cstring) {.
    importc, libprag.}

proc setApplicationIcon*(self: AboutDialog; applicationIcon: cstring) =
  adw_about_dialog_set_application_icon(cast[ptr AboutDialog00](self.impl), applicationIcon)

proc `applicationIcon=`*(self: AboutDialog; applicationIcon: cstring) =
  adw_about_dialog_set_application_icon(cast[ptr AboutDialog00](self.impl), applicationIcon)

proc adw_about_dialog_set_application_name(self: ptr AboutDialog00; applicationName: cstring) {.
    importc, libprag.}

proc setApplicationName*(self: AboutDialog; applicationName: cstring) =
  adw_about_dialog_set_application_name(cast[ptr AboutDialog00](self.impl), applicationName)

proc `applicationName=`*(self: AboutDialog; applicationName: cstring) =
  adw_about_dialog_set_application_name(cast[ptr AboutDialog00](self.impl), applicationName)

proc adw_about_dialog_set_artists(self: ptr AboutDialog00; artists: ptr cstring) {.
    importc, libprag.}

proc setArtists*(self: AboutDialog; artists: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_dialog_set_artists(cast[ptr AboutDialog00](self.impl), seq2CstringArray(artists, fs469n23))

proc `artists=`*(self: AboutDialog; artists: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_dialog_set_artists(cast[ptr AboutDialog00](self.impl), seq2CstringArray(artists, fs469n23))

proc adw_about_dialog_set_comments(self: ptr AboutDialog00; comments: cstring) {.
    importc, libprag.}

proc setComments*(self: AboutDialog; comments: cstring) =
  adw_about_dialog_set_comments(cast[ptr AboutDialog00](self.impl), comments)

proc `comments=`*(self: AboutDialog; comments: cstring) =
  adw_about_dialog_set_comments(cast[ptr AboutDialog00](self.impl), comments)

proc adw_about_dialog_set_copyright(self: ptr AboutDialog00; copyright: cstring) {.
    importc, libprag.}

proc setCopyright*(self: AboutDialog; copyright: cstring) =
  adw_about_dialog_set_copyright(cast[ptr AboutDialog00](self.impl), copyright)

proc `copyright=`*(self: AboutDialog; copyright: cstring) =
  adw_about_dialog_set_copyright(cast[ptr AboutDialog00](self.impl), copyright)

proc adw_about_dialog_set_debug_info(self: ptr AboutDialog00; debugInfo: cstring) {.
    importc, libprag.}

proc setDebugInfo*(self: AboutDialog; debugInfo: cstring) =
  adw_about_dialog_set_debug_info(cast[ptr AboutDialog00](self.impl), debugInfo)

proc `debugInfo=`*(self: AboutDialog; debugInfo: cstring) =
  adw_about_dialog_set_debug_info(cast[ptr AboutDialog00](self.impl), debugInfo)

proc adw_about_dialog_set_debug_info_filename(self: ptr AboutDialog00; filename: cstring) {.
    importc, libprag.}

proc setDebugInfoFilename*(self: AboutDialog; filename: cstring) =
  adw_about_dialog_set_debug_info_filename(cast[ptr AboutDialog00](self.impl), filename)

proc `debugInfoFilename=`*(self: AboutDialog; filename: cstring) =
  adw_about_dialog_set_debug_info_filename(cast[ptr AboutDialog00](self.impl), filename)

proc adw_about_dialog_set_designers(self: ptr AboutDialog00; designers: ptr cstring) {.
    importc, libprag.}

proc setDesigners*(self: AboutDialog; designers: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_dialog_set_designers(cast[ptr AboutDialog00](self.impl), seq2CstringArray(designers, fs469n23))

proc `designers=`*(self: AboutDialog; designers: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_dialog_set_designers(cast[ptr AboutDialog00](self.impl), seq2CstringArray(designers, fs469n23))

proc adw_about_dialog_set_developer_name(self: ptr AboutDialog00; developerName: cstring) {.
    importc, libprag.}

proc setDeveloperName*(self: AboutDialog; developerName: cstring) =
  adw_about_dialog_set_developer_name(cast[ptr AboutDialog00](self.impl), developerName)

proc `developerName=`*(self: AboutDialog; developerName: cstring) =
  adw_about_dialog_set_developer_name(cast[ptr AboutDialog00](self.impl), developerName)

proc adw_about_dialog_set_developers(self: ptr AboutDialog00; developers: ptr cstring) {.
    importc, libprag.}

proc setDevelopers*(self: AboutDialog; developers: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_dialog_set_developers(cast[ptr AboutDialog00](self.impl), seq2CstringArray(developers, fs469n23))

proc `developers=`*(self: AboutDialog; developers: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_dialog_set_developers(cast[ptr AboutDialog00](self.impl), seq2CstringArray(developers, fs469n23))

proc adw_about_dialog_set_documenters(self: ptr AboutDialog00; documenters: ptr cstring) {.
    importc, libprag.}

proc setDocumenters*(self: AboutDialog; documenters: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_dialog_set_documenters(cast[ptr AboutDialog00](self.impl), seq2CstringArray(documenters, fs469n23))

proc `documenters=`*(self: AboutDialog; documenters: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_dialog_set_documenters(cast[ptr AboutDialog00](self.impl), seq2CstringArray(documenters, fs469n23))

proc adw_about_dialog_set_issue_url(self: ptr AboutDialog00; issueUrl: cstring) {.
    importc, libprag.}

proc setIssueUrl*(self: AboutDialog; issueUrl: cstring) =
  adw_about_dialog_set_issue_url(cast[ptr AboutDialog00](self.impl), issueUrl)

proc `issueUrl=`*(self: AboutDialog; issueUrl: cstring) =
  adw_about_dialog_set_issue_url(cast[ptr AboutDialog00](self.impl), issueUrl)

proc adw_about_dialog_set_license(self: ptr AboutDialog00; license: cstring) {.
    importc, libprag.}

proc setLicense*(self: AboutDialog; license: cstring) =
  adw_about_dialog_set_license(cast[ptr AboutDialog00](self.impl), license)

proc `license=`*(self: AboutDialog; license: cstring) =
  adw_about_dialog_set_license(cast[ptr AboutDialog00](self.impl), license)

proc adw_about_dialog_set_license_type(self: ptr AboutDialog00; licenseType: gtk4.License) {.
    importc, libprag.}

proc setLicenseType*(self: AboutDialog; licenseType: gtk4.License) =
  adw_about_dialog_set_license_type(cast[ptr AboutDialog00](self.impl), licenseType)

proc `licenseType=`*(self: AboutDialog; licenseType: gtk4.License) =
  adw_about_dialog_set_license_type(cast[ptr AboutDialog00](self.impl), licenseType)

proc adw_about_dialog_set_release_notes(self: ptr AboutDialog00; releaseNotes: cstring) {.
    importc, libprag.}

proc setReleaseNotes*(self: AboutDialog; releaseNotes: cstring) =
  adw_about_dialog_set_release_notes(cast[ptr AboutDialog00](self.impl), releaseNotes)

proc `releaseNotes=`*(self: AboutDialog; releaseNotes: cstring) =
  adw_about_dialog_set_release_notes(cast[ptr AboutDialog00](self.impl), releaseNotes)

proc adw_about_dialog_set_release_notes_version(self: ptr AboutDialog00;
    version: cstring) {.
    importc, libprag.}

proc setReleaseNotesVersion*(self: AboutDialog; version: cstring) =
  adw_about_dialog_set_release_notes_version(cast[ptr AboutDialog00](self.impl), version)

proc `releaseNotesVersion=`*(self: AboutDialog; version: cstring) =
  adw_about_dialog_set_release_notes_version(cast[ptr AboutDialog00](self.impl), version)

proc adw_about_dialog_set_support_url(self: ptr AboutDialog00; supportUrl: cstring) {.
    importc, libprag.}

proc setSupportUrl*(self: AboutDialog; supportUrl: cstring) =
  adw_about_dialog_set_support_url(cast[ptr AboutDialog00](self.impl), supportUrl)

proc `supportUrl=`*(self: AboutDialog; supportUrl: cstring) =
  adw_about_dialog_set_support_url(cast[ptr AboutDialog00](self.impl), supportUrl)

proc adw_about_dialog_set_translator_credits(self: ptr AboutDialog00; translatorCredits: cstring) {.
    importc, libprag.}

proc setTranslatorCredits*(self: AboutDialog; translatorCredits: cstring) =
  adw_about_dialog_set_translator_credits(cast[ptr AboutDialog00](self.impl), translatorCredits)

proc `translatorCredits=`*(self: AboutDialog; translatorCredits: cstring) =
  adw_about_dialog_set_translator_credits(cast[ptr AboutDialog00](self.impl), translatorCredits)

proc adw_about_dialog_set_version(self: ptr AboutDialog00; version: cstring) {.
    importc, libprag.}

proc setVersion*(self: AboutDialog; version: cstring) =
  adw_about_dialog_set_version(cast[ptr AboutDialog00](self.impl), version)

proc `version=`*(self: AboutDialog; version: cstring) =
  adw_about_dialog_set_version(cast[ptr AboutDialog00](self.impl), version)

proc adw_about_dialog_set_website(self: ptr AboutDialog00; website: cstring) {.
    importc, libprag.}

proc setWebsite*(self: AboutDialog; website: cstring) =
  adw_about_dialog_set_website(cast[ptr AboutDialog00](self.impl), website)

proc `website=`*(self: AboutDialog; website: cstring) =
  adw_about_dialog_set_website(cast[ptr AboutDialog00](self.impl), website)

type
  Breakpoint* = ref object of gobject.Object
  Breakpoint00* = object of gobject.Object00

proc adw_breakpoint_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Breakpoint()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scApply*(self: Breakpoint;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "apply", cast[GCallback](p), xdata, nil, cf)

proc scUnapply*(self: Breakpoint;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "unapply", cast[GCallback](p), xdata, nil, cf)

proc adw_breakpoint_add_setter(self: ptr Breakpoint00; obj: ptr gobject.Object00;
    property: cstring; value: gobject.Value) {.
    importc, libprag.}

proc addSetter*(self: Breakpoint; obj: gobject.Object; property: cstring;
    value: gobject.Value) =
  adw_breakpoint_add_setter(cast[ptr Breakpoint00](self.impl), cast[ptr gobject.Object00](obj.impl), property, value)

proc adw_breakpoint_add_settersv(self: ptr Breakpoint00; nSetters: int32;
    objects: ptr ptr gobject.Object00; names: ptr cstring; values: ptr ptr gobject.Value) {.
    importc, libprag.}

proc addSetters*(self: Breakpoint; nSetters: int; objects: ptr ptr gobject.Object00;
    names: openArray[string]; values: ptr ptr gobject.Value) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_breakpoint_add_settersv(cast[ptr Breakpoint00](self.impl), int32(nSetters), objects, seq2CstringArray(names, fs469n23), values)

proc adw_dialog_add_breakpoint(self: ptr Dialog00; breakpoint: ptr Breakpoint00) {.
    importc, libprag.}

proc addBreakpoint*(self: Dialog; breakpoint: Breakpoint) =
  adw_dialog_add_breakpoint(cast[ptr Dialog00](self.impl), cast[ptr Breakpoint00](g_object_ref(breakpoint.impl)))

proc adw_dialog_get_current_breakpoint(self: ptr Dialog00): ptr Breakpoint00 {.
    importc, libprag.}

proc getCurrentBreakpoint*(self: Dialog): Breakpoint =
  let gobj = adw_dialog_get_current_breakpoint(cast[ptr Dialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentBreakpoint*(self: Dialog): Breakpoint =
  let gobj = adw_dialog_get_current_breakpoint(cast[ptr Dialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  BreakpointCondition00* {.pure.} = object
  BreakpointCondition* = ref object
    impl*: ptr BreakpointCondition00
    ignoreFinalizer*: bool

proc adw_breakpoint_condition_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeAdwBreakpointCondition*(self: BreakpointCondition) =
  if not self.ignoreFinalizer:
    boxedFree(adw_breakpoint_condition_get_type(), cast[ptr BreakpointCondition00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BreakpointCondition()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(adw_breakpoint_condition_get_type(), cast[ptr BreakpointCondition00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var BreakpointCondition) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeAdwBreakpointCondition)

proc adw_breakpoint_condition_free(self: ptr BreakpointCondition00) {.
    importc, libprag.}

proc free*(self: BreakpointCondition) =
  adw_breakpoint_condition_free(cast[ptr BreakpointCondition00](self.impl))

proc finalizerfree*(self: BreakpointCondition) =
  if not self.ignoreFinalizer:
    adw_breakpoint_condition_free(cast[ptr BreakpointCondition00](self.impl))

proc adw_breakpoint_condition_new_or(condition_1: ptr BreakpointCondition00;
    condition_2: ptr BreakpointCondition00): ptr BreakpointCondition00 {.
    importc, libprag.}

proc newBreakpointConditionOr*(condition_1: BreakpointCondition; condition_2: BreakpointCondition): BreakpointCondition =
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_or(cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_1.impl)), cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_2.impl)))

proc newBreakpointConditionOr*(tdesc: typedesc; condition_1: BreakpointCondition; condition_2: BreakpointCondition): tdesc =
  assert(result is BreakpointCondition)
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_or(cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_1.impl)), cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_2.impl)))

proc initBreakpointConditionOr*[T](result: var T; condition_1: BreakpointCondition; condition_2: BreakpointCondition) {.deprecated.} =
  assert(result is BreakpointCondition)
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_or(cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_1.impl)), cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_2.impl)))

proc adw_breakpoint_condition_copy(self: ptr BreakpointCondition00): ptr BreakpointCondition00 {.
    importc, libprag.}

proc copy*(self: BreakpointCondition): BreakpointCondition =
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_copy(cast[ptr BreakpointCondition00](self.impl))

proc adw_breakpoint_condition_new_and(condition_1: ptr BreakpointCondition00;
    condition_2: ptr BreakpointCondition00): ptr BreakpointCondition00 {.
    importc, libprag.}

proc newBreakpointConditionAnd*(condition_1: BreakpointCondition; condition_2: BreakpointCondition): BreakpointCondition =
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_and(cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_1.impl)), cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_2.impl)))

proc newBreakpointConditionAnd*(tdesc: typedesc; condition_1: BreakpointCondition; condition_2: BreakpointCondition): tdesc =
  assert(result is BreakpointCondition)
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_and(cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_1.impl)), cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_2.impl)))

proc initBreakpointConditionAnd*[T](result: var T; condition_1: BreakpointCondition; condition_2: BreakpointCondition) {.deprecated.} =
  assert(result is BreakpointCondition)
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_and(cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_1.impl)), cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition_2.impl)))

proc adw_breakpoint_condition_to_string(self: ptr BreakpointCondition00): cstring {.
    importc, libprag.}

proc toString*(self: BreakpointCondition): string =
  let resul0 = adw_breakpoint_condition_to_string(cast[ptr BreakpointCondition00](self.impl))
  result = $resul0
  cogfree(resul0)

proc adw_breakpoint_condition_parse(str: cstring): ptr BreakpointCondition00 {.
    importc, libprag.}

proc parse*(str: cstring): BreakpointCondition =
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_parse(str)

proc adw_breakpoint_new(condition: ptr BreakpointCondition00): ptr Breakpoint00 {.
    importc, libprag.}

proc newBreakpoint*(condition: BreakpointCondition): Breakpoint =
  let gobj = adw_breakpoint_new(cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newBreakpoint*(tdesc: typedesc; condition: BreakpointCondition): tdesc =
  assert(result is Breakpoint)
  let gobj = adw_breakpoint_new(cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBreakpoint*[T](result: var T; condition: BreakpointCondition) {.deprecated.} =
  assert(result is Breakpoint)
  let gobj = adw_breakpoint_new(cast[ptr BreakpointCondition00](g_boxed_copy(adw_breakpoint_condition_get_type(), condition.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_breakpoint_get_condition(self: ptr Breakpoint00): ptr BreakpointCondition00 {.
    importc, libprag.}

proc getCondition*(self: Breakpoint): BreakpointCondition =
  let impl0 = adw_breakpoint_get_condition(cast[ptr Breakpoint00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(adw_breakpoint_condition_get_type(), impl0))

proc condition*(self: Breakpoint): BreakpointCondition =
  let impl0 = adw_breakpoint_get_condition(cast[ptr Breakpoint00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(adw_breakpoint_condition_get_type(), impl0))

proc adw_breakpoint_set_condition(self: ptr Breakpoint00; condition: ptr BreakpointCondition00) {.
    importc, libprag.}

proc setCondition*(self: Breakpoint; condition: BreakpointCondition = nil) =
  adw_breakpoint_set_condition(cast[ptr Breakpoint00](self.impl), if condition.isNil: nil else: cast[ptr BreakpointCondition00](condition.impl))

proc `condition=`*(self: Breakpoint; condition: BreakpointCondition = nil) =
  adw_breakpoint_set_condition(cast[ptr Breakpoint00](self.impl), if condition.isNil: nil else: cast[ptr BreakpointCondition00](condition.impl))

type
  BreakpointConditionLengthType* {.size: sizeof(cint), pure.} = enum
    minWidth = 0
    maxWidth = 1
    minHeight = 2
    maxHeight = 3

type
  LengthUnit* {.size: sizeof(cint), pure.} = enum
    px = 0
    pt = 1
    sp = 2

proc adw_length_unit_from_px(unit: LengthUnit; value: cdouble; settings: ptr gtk4.Settings00): cdouble {.
    importc, libprag.}

proc fromPx*(unit: LengthUnit; value: cdouble; settings: gtk4.Settings = nil): cdouble =
  adw_length_unit_from_px(unit, value, if settings.isNil: nil else: cast[ptr gtk4.Settings00](settings.impl))

proc adw_length_unit_to_px(unit: LengthUnit; value: cdouble; settings: ptr gtk4.Settings00): cdouble {.
    importc, libprag.}

proc toPx*(unit: LengthUnit; value: cdouble; settings: gtk4.Settings = nil): cdouble =
  adw_length_unit_to_px(unit, value, if settings.isNil: nil else: cast[ptr gtk4.Settings00](settings.impl))

proc adw_breakpoint_condition_new_length(`type`: BreakpointConditionLengthType;
    value: cdouble; unit: LengthUnit): ptr BreakpointCondition00 {.
    importc, libprag.}

proc newBreakpointConditionLength*(`type`: BreakpointConditionLengthType;
    value: cdouble; unit: LengthUnit): BreakpointCondition =
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_length(`type`, value, unit)

proc newBreakpointConditionLength*(tdesc: typedesc; `type`: BreakpointConditionLengthType;
    value: cdouble; unit: LengthUnit): tdesc =
  assert(result is BreakpointCondition)
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_length(`type`, value, unit)

proc initBreakpointConditionLength*[T](result: var T; `type`: BreakpointConditionLengthType;
    value: cdouble; unit: LengthUnit) {.deprecated.} =
  assert(result is BreakpointCondition)
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_length(`type`, value, unit)

type
  BreakpointConditionRatioType* {.size: sizeof(cint), pure.} = enum
    minAspectRatio = 0
    maxAspectRatio = 1

proc adw_breakpoint_condition_new_ratio(`type`: BreakpointConditionRatioType;
    width: int32; height: int32): ptr BreakpointCondition00 {.
    importc, libprag.}

proc newBreakpointConditionRatio*(`type`: BreakpointConditionRatioType;
    width: int; height: int): BreakpointCondition =
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_ratio(`type`, int32(width), int32(height))

proc newBreakpointConditionRatio*(tdesc: typedesc; `type`: BreakpointConditionRatioType;
    width: int; height: int): tdesc =
  assert(result is BreakpointCondition)
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_ratio(`type`, int32(width), int32(height))

proc initBreakpointConditionRatio*[T](result: var T; `type`: BreakpointConditionRatioType;
    width: int; height: int) {.deprecated.} =
  assert(result is BreakpointCondition)
  fnew(result, gBoxedFreeAdwBreakpointCondition)
  result.impl = adw_breakpoint_condition_new_ratio(`type`, int32(width), int32(height))

type
  DialogPresentationMode* {.size: sizeof(cint), pure.} = enum
    auto = 0
    floating = 1
    bottomSheet = 2

proc adw_dialog_get_presentation_mode(self: ptr Dialog00): DialogPresentationMode {.
    importc, libprag.}

proc getPresentationMode*(self: Dialog): DialogPresentationMode =
  adw_dialog_get_presentation_mode(cast[ptr Dialog00](self.impl))

proc presentationMode*(self: Dialog): DialogPresentationMode =
  adw_dialog_get_presentation_mode(cast[ptr Dialog00](self.impl))

proc adw_dialog_set_presentation_mode(self: ptr Dialog00; presentationMode: DialogPresentationMode) {.
    importc, libprag.}

proc setPresentationMode*(self: Dialog; presentationMode: DialogPresentationMode) =
  adw_dialog_set_presentation_mode(cast[ptr Dialog00](self.impl), presentationMode)

proc `presentationMode=`*(self: Dialog; presentationMode: DialogPresentationMode) =
  adw_dialog_set_presentation_mode(cast[ptr Dialog00](self.impl), presentationMode)

type
  Window* = ref object of gtk4.Window
  Window00* = object of gtk4.Window00

proc adw_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Window()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_window_new(): ptr Window00 {.
    importc, libprag.}

proc newWindow*(): Window =
  let gobj = adw_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWindow*(tdesc: typedesc): tdesc =
  assert(result is Window)
  let gobj = adw_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWindow*[T](result: var T) {.deprecated.} =
  assert(result is Window)
  let gobj = adw_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_window_add_breakpoint(self: ptr Window00; breakpoint: ptr Breakpoint00) {.
    importc, libprag.}

proc addBreakpoint*(self: Window; breakpoint: Breakpoint) =
  adw_window_add_breakpoint(cast[ptr Window00](self.impl), cast[ptr Breakpoint00](g_object_ref(breakpoint.impl)))

proc adw_window_get_content(self: ptr Window00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getContent*(self: Window): gtk4.Widget =
  let gobj = adw_window_get_content(cast[ptr Window00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc content*(self: Window): gtk4.Widget =
  let gobj = adw_window_get_content(cast[ptr Window00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_window_get_current_breakpoint(self: ptr Window00): ptr Breakpoint00 {.
    importc, libprag.}

proc getCurrentBreakpoint*(self: Window): Breakpoint =
  let gobj = adw_window_get_current_breakpoint(cast[ptr Window00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentBreakpoint*(self: Window): Breakpoint =
  let gobj = adw_window_get_current_breakpoint(cast[ptr Window00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_window_get_dialogs(self: ptr Window00): ptr gio.ListModel00 {.
    importc, libprag.}

proc getDialogs*(self: Window): gio.ListModel =
  let gobj = adw_window_get_dialogs(cast[ptr Window00](self.impl))
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

proc dialogs*(self: Window): gio.ListModel =
  let gobj = adw_window_get_dialogs(cast[ptr Window00](self.impl))
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

proc adw_window_get_visible_dialog(self: ptr Window00): ptr Dialog00 {.
    importc, libprag.}

proc getVisibleDialog*(self: Window): Dialog =
  let gobj = adw_window_get_visible_dialog(cast[ptr Window00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visibleDialog*(self: Window): Dialog =
  let gobj = adw_window_get_visible_dialog(cast[ptr Window00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_window_set_content(self: ptr Window00; content: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setContent*(self: Window; content: gtk4.Widget = nil) =
  adw_window_set_content(cast[ptr Window00](self.impl), if content.isNil: nil else: cast[ptr gtk4.Widget00](content.impl))

proc `content=`*(self: Window; content: gtk4.Widget = nil) =
  adw_window_set_content(cast[ptr Window00](self.impl), if content.isNil: nil else: cast[ptr gtk4.Widget00](content.impl))

type
  AboutWindow* = ref object of Window
  AboutWindow00* = object of Window00

proc adw_about_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AboutWindow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActivateLink*(self: AboutWindow;  p: proc (self: ptr AboutWindow00; uri: cstring; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "activate-link", cast[GCallback](p), xdata, nil, cf)

proc adw_about_window_new(): ptr AboutWindow00 {.
    importc, libprag.}

proc newAboutWindow*(): AboutWindow =
  let gobj = adw_about_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAboutWindow*(tdesc: typedesc): tdesc =
  assert(result is AboutWindow)
  let gobj = adw_about_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAboutWindow*[T](result: var T) {.deprecated.} =
  assert(result is AboutWindow)
  let gobj = adw_about_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_about_window_new_from_appdata(resourcePath: cstring; releaseNotesVersion: cstring): ptr AboutWindow00 {.
    importc, libprag.}

proc newAboutWindowFromAppdata*(resourcePath: cstring; releaseNotesVersion: cstring = nil): AboutWindow =
  let gobj = adw_about_window_new_from_appdata(resourcePath, releaseNotesVersion)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAboutWindowFromAppdata*(tdesc: typedesc; resourcePath: cstring; releaseNotesVersion: cstring = nil): tdesc =
  assert(result is AboutWindow)
  let gobj = adw_about_window_new_from_appdata(resourcePath, releaseNotesVersion)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAboutWindowFromAppdata*[T](result: var T; resourcePath: cstring; releaseNotesVersion: cstring = nil) {.deprecated.} =
  assert(result is AboutWindow)
  let gobj = adw_about_window_new_from_appdata(resourcePath, releaseNotesVersion)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_about_window_add_acknowledgement_section(self: ptr AboutWindow00;
    name: cstring; people: ptr cstring) {.
    importc, libprag.}

proc addAcknowledgementSection*(self: AboutWindow; name: cstring = nil;
    people: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_window_add_acknowledgement_section(cast[ptr AboutWindow00](self.impl), name, seq2CstringArray(people, fs469n23))

proc adw_about_window_add_credit_section(self: ptr AboutWindow00; name: cstring;
    people: ptr cstring) {.
    importc, libprag.}

proc addCreditSection*(self: AboutWindow; name: cstring = nil;
    people: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_window_add_credit_section(cast[ptr AboutWindow00](self.impl), name, seq2CstringArray(people, fs469n23))

proc adw_about_window_add_legal_section(self: ptr AboutWindow00; title: cstring;
    copyright: cstring; licenseType: gtk4.License; license: cstring) {.
    importc, libprag.}

proc addLegalSection*(self: AboutWindow; title: cstring;
    copyright: cstring = nil; licenseType: gtk4.License; license: cstring = nil) =
  adw_about_window_add_legal_section(cast[ptr AboutWindow00](self.impl), title, copyright, licenseType, license)

proc adw_about_window_add_link(self: ptr AboutWindow00; title: cstring; url: cstring) {.
    importc, libprag.}

proc addLink*(self: AboutWindow; title: cstring; url: cstring) =
  adw_about_window_add_link(cast[ptr AboutWindow00](self.impl), title, url)

proc adw_about_window_get_application_icon(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getApplicationIcon*(self: AboutWindow): string =
  result = $adw_about_window_get_application_icon(cast[ptr AboutWindow00](self.impl))

proc applicationIcon*(self: AboutWindow): string =
  result = $adw_about_window_get_application_icon(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_application_name(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getApplicationName*(self: AboutWindow): string =
  result = $adw_about_window_get_application_name(cast[ptr AboutWindow00](self.impl))

proc applicationName*(self: AboutWindow): string =
  result = $adw_about_window_get_application_name(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_artists(self: ptr AboutWindow00): ptr cstring {.
    importc, libprag.}

proc getArtists*(self: AboutWindow): seq[string] =
  let resul0 = adw_about_window_get_artists(cast[ptr AboutWindow00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc artists*(self: AboutWindow): seq[string] =
  let resul0 = adw_about_window_get_artists(cast[ptr AboutWindow00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc adw_about_window_get_comments(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getComments*(self: AboutWindow): string =
  result = $adw_about_window_get_comments(cast[ptr AboutWindow00](self.impl))

proc comments*(self: AboutWindow): string =
  result = $adw_about_window_get_comments(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_copyright(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getCopyright*(self: AboutWindow): string =
  result = $adw_about_window_get_copyright(cast[ptr AboutWindow00](self.impl))

proc copyright*(self: AboutWindow): string =
  result = $adw_about_window_get_copyright(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_debug_info(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getDebugInfo*(self: AboutWindow): string =
  result = $adw_about_window_get_debug_info(cast[ptr AboutWindow00](self.impl))

proc debugInfo*(self: AboutWindow): string =
  result = $adw_about_window_get_debug_info(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_debug_info_filename(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getDebugInfoFilename*(self: AboutWindow): string =
  result = $adw_about_window_get_debug_info_filename(cast[ptr AboutWindow00](self.impl))

proc debugInfoFilename*(self: AboutWindow): string =
  result = $adw_about_window_get_debug_info_filename(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_designers(self: ptr AboutWindow00): ptr cstring {.
    importc, libprag.}

proc getDesigners*(self: AboutWindow): seq[string] =
  let resul0 = adw_about_window_get_designers(cast[ptr AboutWindow00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc designers*(self: AboutWindow): seq[string] =
  let resul0 = adw_about_window_get_designers(cast[ptr AboutWindow00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc adw_about_window_get_developer_name(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getDeveloperName*(self: AboutWindow): string =
  result = $adw_about_window_get_developer_name(cast[ptr AboutWindow00](self.impl))

proc developerName*(self: AboutWindow): string =
  result = $adw_about_window_get_developer_name(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_developers(self: ptr AboutWindow00): ptr cstring {.
    importc, libprag.}

proc getDevelopers*(self: AboutWindow): seq[string] =
  let resul0 = adw_about_window_get_developers(cast[ptr AboutWindow00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc developers*(self: AboutWindow): seq[string] =
  let resul0 = adw_about_window_get_developers(cast[ptr AboutWindow00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc adw_about_window_get_documenters(self: ptr AboutWindow00): ptr cstring {.
    importc, libprag.}

proc getDocumenters*(self: AboutWindow): seq[string] =
  let resul0 = adw_about_window_get_documenters(cast[ptr AboutWindow00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc documenters*(self: AboutWindow): seq[string] =
  let resul0 = adw_about_window_get_documenters(cast[ptr AboutWindow00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc adw_about_window_get_issue_url(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getIssueUrl*(self: AboutWindow): string =
  result = $adw_about_window_get_issue_url(cast[ptr AboutWindow00](self.impl))

proc issueUrl*(self: AboutWindow): string =
  result = $adw_about_window_get_issue_url(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_license(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getLicense*(self: AboutWindow): string =
  result = $adw_about_window_get_license(cast[ptr AboutWindow00](self.impl))

proc license*(self: AboutWindow): string =
  result = $adw_about_window_get_license(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_license_type(self: ptr AboutWindow00): gtk4.License {.
    importc, libprag.}

proc getLicenseType*(self: AboutWindow): gtk4.License =
  adw_about_window_get_license_type(cast[ptr AboutWindow00](self.impl))

proc licenseType*(self: AboutWindow): gtk4.License =
  adw_about_window_get_license_type(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_release_notes(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getReleaseNotes*(self: AboutWindow): string =
  result = $adw_about_window_get_release_notes(cast[ptr AboutWindow00](self.impl))

proc releaseNotes*(self: AboutWindow): string =
  result = $adw_about_window_get_release_notes(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_release_notes_version(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getReleaseNotesVersion*(self: AboutWindow): string =
  result = $adw_about_window_get_release_notes_version(cast[ptr AboutWindow00](self.impl))

proc releaseNotesVersion*(self: AboutWindow): string =
  result = $adw_about_window_get_release_notes_version(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_support_url(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getSupportUrl*(self: AboutWindow): string =
  result = $adw_about_window_get_support_url(cast[ptr AboutWindow00](self.impl))

proc supportUrl*(self: AboutWindow): string =
  result = $adw_about_window_get_support_url(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_translator_credits(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getTranslatorCredits*(self: AboutWindow): string =
  result = $adw_about_window_get_translator_credits(cast[ptr AboutWindow00](self.impl))

proc translatorCredits*(self: AboutWindow): string =
  result = $adw_about_window_get_translator_credits(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_version(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getVersion*(self: AboutWindow): string =
  result = $adw_about_window_get_version(cast[ptr AboutWindow00](self.impl))

proc version*(self: AboutWindow): string =
  result = $adw_about_window_get_version(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_get_website(self: ptr AboutWindow00): cstring {.
    importc, libprag.}

proc getWebsite*(self: AboutWindow): string =
  result = $adw_about_window_get_website(cast[ptr AboutWindow00](self.impl))

proc website*(self: AboutWindow): string =
  result = $adw_about_window_get_website(cast[ptr AboutWindow00](self.impl))

proc adw_about_window_set_application_icon(self: ptr AboutWindow00; applicationIcon: cstring) {.
    importc, libprag.}

proc setApplicationIcon*(self: AboutWindow; applicationIcon: cstring) =
  adw_about_window_set_application_icon(cast[ptr AboutWindow00](self.impl), applicationIcon)

proc `applicationIcon=`*(self: AboutWindow; applicationIcon: cstring) =
  adw_about_window_set_application_icon(cast[ptr AboutWindow00](self.impl), applicationIcon)

proc adw_about_window_set_application_name(self: ptr AboutWindow00; applicationName: cstring) {.
    importc, libprag.}

proc setApplicationName*(self: AboutWindow; applicationName: cstring) =
  adw_about_window_set_application_name(cast[ptr AboutWindow00](self.impl), applicationName)

proc `applicationName=`*(self: AboutWindow; applicationName: cstring) =
  adw_about_window_set_application_name(cast[ptr AboutWindow00](self.impl), applicationName)

proc adw_about_window_set_artists(self: ptr AboutWindow00; artists: ptr cstring) {.
    importc, libprag.}

proc setArtists*(self: AboutWindow; artists: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_window_set_artists(cast[ptr AboutWindow00](self.impl), seq2CstringArray(artists, fs469n23))

proc `artists=`*(self: AboutWindow; artists: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_window_set_artists(cast[ptr AboutWindow00](self.impl), seq2CstringArray(artists, fs469n23))

proc adw_about_window_set_comments(self: ptr AboutWindow00; comments: cstring) {.
    importc, libprag.}

proc setComments*(self: AboutWindow; comments: cstring) =
  adw_about_window_set_comments(cast[ptr AboutWindow00](self.impl), comments)

proc `comments=`*(self: AboutWindow; comments: cstring) =
  adw_about_window_set_comments(cast[ptr AboutWindow00](self.impl), comments)

proc adw_about_window_set_copyright(self: ptr AboutWindow00; copyright: cstring) {.
    importc, libprag.}

proc setCopyright*(self: AboutWindow; copyright: cstring) =
  adw_about_window_set_copyright(cast[ptr AboutWindow00](self.impl), copyright)

proc `copyright=`*(self: AboutWindow; copyright: cstring) =
  adw_about_window_set_copyright(cast[ptr AboutWindow00](self.impl), copyright)

proc adw_about_window_set_debug_info(self: ptr AboutWindow00; debugInfo: cstring) {.
    importc, libprag.}

proc setDebugInfo*(self: AboutWindow; debugInfo: cstring) =
  adw_about_window_set_debug_info(cast[ptr AboutWindow00](self.impl), debugInfo)

proc `debugInfo=`*(self: AboutWindow; debugInfo: cstring) =
  adw_about_window_set_debug_info(cast[ptr AboutWindow00](self.impl), debugInfo)

proc adw_about_window_set_debug_info_filename(self: ptr AboutWindow00; filename: cstring) {.
    importc, libprag.}

proc setDebugInfoFilename*(self: AboutWindow; filename: cstring) =
  adw_about_window_set_debug_info_filename(cast[ptr AboutWindow00](self.impl), filename)

proc `debugInfoFilename=`*(self: AboutWindow; filename: cstring) =
  adw_about_window_set_debug_info_filename(cast[ptr AboutWindow00](self.impl), filename)

proc adw_about_window_set_designers(self: ptr AboutWindow00; designers: ptr cstring) {.
    importc, libprag.}

proc setDesigners*(self: AboutWindow; designers: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_window_set_designers(cast[ptr AboutWindow00](self.impl), seq2CstringArray(designers, fs469n23))

proc `designers=`*(self: AboutWindow; designers: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_window_set_designers(cast[ptr AboutWindow00](self.impl), seq2CstringArray(designers, fs469n23))

proc adw_about_window_set_developer_name(self: ptr AboutWindow00; developerName: cstring) {.
    importc, libprag.}

proc setDeveloperName*(self: AboutWindow; developerName: cstring) =
  adw_about_window_set_developer_name(cast[ptr AboutWindow00](self.impl), developerName)

proc `developerName=`*(self: AboutWindow; developerName: cstring) =
  adw_about_window_set_developer_name(cast[ptr AboutWindow00](self.impl), developerName)

proc adw_about_window_set_developers(self: ptr AboutWindow00; developers: ptr cstring) {.
    importc, libprag.}

proc setDevelopers*(self: AboutWindow; developers: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_window_set_developers(cast[ptr AboutWindow00](self.impl), seq2CstringArray(developers, fs469n23))

proc `developers=`*(self: AboutWindow; developers: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_window_set_developers(cast[ptr AboutWindow00](self.impl), seq2CstringArray(developers, fs469n23))

proc adw_about_window_set_documenters(self: ptr AboutWindow00; documenters: ptr cstring) {.
    importc, libprag.}

proc setDocumenters*(self: AboutWindow; documenters: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_window_set_documenters(cast[ptr AboutWindow00](self.impl), seq2CstringArray(documenters, fs469n23))

proc `documenters=`*(self: AboutWindow; documenters: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_about_window_set_documenters(cast[ptr AboutWindow00](self.impl), seq2CstringArray(documenters, fs469n23))

proc adw_about_window_set_issue_url(self: ptr AboutWindow00; issueUrl: cstring) {.
    importc, libprag.}

proc setIssueUrl*(self: AboutWindow; issueUrl: cstring) =
  adw_about_window_set_issue_url(cast[ptr AboutWindow00](self.impl), issueUrl)

proc `issueUrl=`*(self: AboutWindow; issueUrl: cstring) =
  adw_about_window_set_issue_url(cast[ptr AboutWindow00](self.impl), issueUrl)

proc adw_about_window_set_license(self: ptr AboutWindow00; license: cstring) {.
    importc, libprag.}

proc setLicense*(self: AboutWindow; license: cstring) =
  adw_about_window_set_license(cast[ptr AboutWindow00](self.impl), license)

proc `license=`*(self: AboutWindow; license: cstring) =
  adw_about_window_set_license(cast[ptr AboutWindow00](self.impl), license)

proc adw_about_window_set_license_type(self: ptr AboutWindow00; licenseType: gtk4.License) {.
    importc, libprag.}

proc setLicenseType*(self: AboutWindow; licenseType: gtk4.License) =
  adw_about_window_set_license_type(cast[ptr AboutWindow00](self.impl), licenseType)

proc `licenseType=`*(self: AboutWindow; licenseType: gtk4.License) =
  adw_about_window_set_license_type(cast[ptr AboutWindow00](self.impl), licenseType)

proc adw_about_window_set_release_notes(self: ptr AboutWindow00; releaseNotes: cstring) {.
    importc, libprag.}

proc setReleaseNotes*(self: AboutWindow; releaseNotes: cstring) =
  adw_about_window_set_release_notes(cast[ptr AboutWindow00](self.impl), releaseNotes)

proc `releaseNotes=`*(self: AboutWindow; releaseNotes: cstring) =
  adw_about_window_set_release_notes(cast[ptr AboutWindow00](self.impl), releaseNotes)

proc adw_about_window_set_release_notes_version(self: ptr AboutWindow00;
    version: cstring) {.
    importc, libprag.}

proc setReleaseNotesVersion*(self: AboutWindow; version: cstring) =
  adw_about_window_set_release_notes_version(cast[ptr AboutWindow00](self.impl), version)

proc `releaseNotesVersion=`*(self: AboutWindow; version: cstring) =
  adw_about_window_set_release_notes_version(cast[ptr AboutWindow00](self.impl), version)

proc adw_about_window_set_support_url(self: ptr AboutWindow00; supportUrl: cstring) {.
    importc, libprag.}

proc setSupportUrl*(self: AboutWindow; supportUrl: cstring) =
  adw_about_window_set_support_url(cast[ptr AboutWindow00](self.impl), supportUrl)

proc `supportUrl=`*(self: AboutWindow; supportUrl: cstring) =
  adw_about_window_set_support_url(cast[ptr AboutWindow00](self.impl), supportUrl)

proc adw_about_window_set_translator_credits(self: ptr AboutWindow00; translatorCredits: cstring) {.
    importc, libprag.}

proc setTranslatorCredits*(self: AboutWindow; translatorCredits: cstring) =
  adw_about_window_set_translator_credits(cast[ptr AboutWindow00](self.impl), translatorCredits)

proc `translatorCredits=`*(self: AboutWindow; translatorCredits: cstring) =
  adw_about_window_set_translator_credits(cast[ptr AboutWindow00](self.impl), translatorCredits)

proc adw_about_window_set_version(self: ptr AboutWindow00; version: cstring) {.
    importc, libprag.}

proc setVersion*(self: AboutWindow; version: cstring) =
  adw_about_window_set_version(cast[ptr AboutWindow00](self.impl), version)

proc `version=`*(self: AboutWindow; version: cstring) =
  adw_about_window_set_version(cast[ptr AboutWindow00](self.impl), version)

proc adw_about_window_set_website(self: ptr AboutWindow00; website: cstring) {.
    importc, libprag.}

proc setWebsite*(self: AboutWindow; website: cstring) =
  adw_about_window_set_website(cast[ptr AboutWindow00](self.impl), website)

proc `website=`*(self: AboutWindow; website: cstring) =
  adw_about_window_set_website(cast[ptr AboutWindow00](self.impl), website)

type
  PreferencesRow* = ref object of gtk4.ListBoxRow
  PreferencesRow00* = object of gtk4.ListBoxRow00

proc adw_preferences_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PreferencesRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_preferences_row_new(): ptr PreferencesRow00 {.
    importc, libprag.}

proc newPreferencesRow*(): PreferencesRow =
  let gobj = adw_preferences_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPreferencesRow*(tdesc: typedesc): tdesc =
  assert(result is PreferencesRow)
  let gobj = adw_preferences_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPreferencesRow*[T](result: var T) {.deprecated.} =
  assert(result is PreferencesRow)
  let gobj = adw_preferences_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_preferences_row_get_title(self: ptr PreferencesRow00): cstring {.
    importc, libprag.}

proc getTitle*(self: PreferencesRow): string =
  result = $adw_preferences_row_get_title(cast[ptr PreferencesRow00](self.impl))

proc title*(self: PreferencesRow): string =
  result = $adw_preferences_row_get_title(cast[ptr PreferencesRow00](self.impl))

proc adw_preferences_row_get_title_selectable(self: ptr PreferencesRow00): gboolean {.
    importc, libprag.}

proc getTitleSelectable*(self: PreferencesRow): bool =
  toBool(adw_preferences_row_get_title_selectable(cast[ptr PreferencesRow00](self.impl)))

proc titleSelectable*(self: PreferencesRow): bool =
  toBool(adw_preferences_row_get_title_selectable(cast[ptr PreferencesRow00](self.impl)))

proc adw_preferences_row_get_use_markup(self: ptr PreferencesRow00): gboolean {.
    importc, libprag.}

proc getUseMarkup*(self: PreferencesRow): bool =
  toBool(adw_preferences_row_get_use_markup(cast[ptr PreferencesRow00](self.impl)))

proc useMarkup*(self: PreferencesRow): bool =
  toBool(adw_preferences_row_get_use_markup(cast[ptr PreferencesRow00](self.impl)))

proc adw_preferences_row_get_use_underline(self: ptr PreferencesRow00): gboolean {.
    importc, libprag.}

proc getUseUnderline*(self: PreferencesRow): bool =
  toBool(adw_preferences_row_get_use_underline(cast[ptr PreferencesRow00](self.impl)))

proc useUnderline*(self: PreferencesRow): bool =
  toBool(adw_preferences_row_get_use_underline(cast[ptr PreferencesRow00](self.impl)))

proc adw_preferences_row_set_title(self: ptr PreferencesRow00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: PreferencesRow; title: cstring) =
  adw_preferences_row_set_title(cast[ptr PreferencesRow00](self.impl), title)

proc `title=`*(self: PreferencesRow; title: cstring) =
  adw_preferences_row_set_title(cast[ptr PreferencesRow00](self.impl), title)

proc adw_preferences_row_set_title_selectable(self: ptr PreferencesRow00;
    titleSelectable: gboolean) {.
    importc, libprag.}

proc setTitleSelectable*(self: PreferencesRow; titleSelectable: bool = true) =
  adw_preferences_row_set_title_selectable(cast[ptr PreferencesRow00](self.impl), gboolean(titleSelectable))

proc `titleSelectable=`*(self: PreferencesRow; titleSelectable: bool) =
  adw_preferences_row_set_title_selectable(cast[ptr PreferencesRow00](self.impl), gboolean(titleSelectable))

proc adw_preferences_row_set_use_markup(self: ptr PreferencesRow00; useMarkup: gboolean) {.
    importc, libprag.}

proc setUseMarkup*(self: PreferencesRow; useMarkup: bool = true) =
  adw_preferences_row_set_use_markup(cast[ptr PreferencesRow00](self.impl), gboolean(useMarkup))

proc `useMarkup=`*(self: PreferencesRow; useMarkup: bool) =
  adw_preferences_row_set_use_markup(cast[ptr PreferencesRow00](self.impl), gboolean(useMarkup))

proc adw_preferences_row_set_use_underline(self: ptr PreferencesRow00; useUnderline: gboolean) {.
    importc, libprag.}

proc setUseUnderline*(self: PreferencesRow; useUnderline: bool = true) =
  adw_preferences_row_set_use_underline(cast[ptr PreferencesRow00](self.impl), gboolean(useUnderline))

proc `useUnderline=`*(self: PreferencesRow; useUnderline: bool) =
  adw_preferences_row_set_use_underline(cast[ptr PreferencesRow00](self.impl), gboolean(useUnderline))

type
  ActionRow* = ref object of PreferencesRow
  ActionRow00* = object of PreferencesRow00

proc adw_action_row_get_type*(): GType {.importc, libprag.}

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

proc adw_action_row_new(): ptr ActionRow00 {.
    importc, libprag.}

proc newActionRow*(): ActionRow =
  let gobj = adw_action_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newActionRow*(tdesc: typedesc): tdesc =
  assert(result is ActionRow)
  let gobj = adw_action_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initActionRow*[T](result: var T) {.deprecated.} =
  assert(result is ActionRow)
  let gobj = adw_action_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_action_row_activate(self: ptr ActionRow00) {.
    importc, libprag.}

proc activate*(self: ActionRow) =
  adw_action_row_activate(cast[ptr ActionRow00](self.impl))

proc adw_action_row_add_prefix(self: ptr ActionRow00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc addPrefix*(self: ActionRow; widget: gtk4.Widget) =
  adw_action_row_add_prefix(cast[ptr ActionRow00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_action_row_add_suffix(self: ptr ActionRow00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc addSuffix*(self: ActionRow; widget: gtk4.Widget) =
  adw_action_row_add_suffix(cast[ptr ActionRow00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_action_row_get_activatable_widget(self: ptr ActionRow00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getActivatableWidget*(self: ActionRow): gtk4.Widget =
  let gobj = adw_action_row_get_activatable_widget(cast[ptr ActionRow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc activatableWidget*(self: ActionRow): gtk4.Widget =
  let gobj = adw_action_row_get_activatable_widget(cast[ptr ActionRow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_action_row_get_icon_name(self: ptr ActionRow00): cstring {.
    importc, libprag.}

proc getIconName*(self: ActionRow): string =
  let resul0 = adw_action_row_get_icon_name(cast[ptr ActionRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: ActionRow): string =
  let resul0 = adw_action_row_get_icon_name(cast[ptr ActionRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_action_row_get_subtitle(self: ptr ActionRow00): cstring {.
    importc, libprag.}

proc getSubtitle*(self: ActionRow): string =
  let resul0 = adw_action_row_get_subtitle(cast[ptr ActionRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc subtitle*(self: ActionRow): string =
  let resul0 = adw_action_row_get_subtitle(cast[ptr ActionRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_action_row_get_subtitle_lines(self: ptr ActionRow00): int32 {.
    importc, libprag.}

proc getSubtitleLines*(self: ActionRow): int =
  int(adw_action_row_get_subtitle_lines(cast[ptr ActionRow00](self.impl)))

proc subtitleLines*(self: ActionRow): int =
  int(adw_action_row_get_subtitle_lines(cast[ptr ActionRow00](self.impl)))

proc adw_action_row_get_subtitle_selectable(self: ptr ActionRow00): gboolean {.
    importc, libprag.}

proc getSubtitleSelectable*(self: ActionRow): bool =
  toBool(adw_action_row_get_subtitle_selectable(cast[ptr ActionRow00](self.impl)))

proc subtitleSelectable*(self: ActionRow): bool =
  toBool(adw_action_row_get_subtitle_selectable(cast[ptr ActionRow00](self.impl)))

proc adw_action_row_get_title_lines(self: ptr ActionRow00): int32 {.
    importc, libprag.}

proc getTitleLines*(self: ActionRow): int =
  int(adw_action_row_get_title_lines(cast[ptr ActionRow00](self.impl)))

proc titleLines*(self: ActionRow): int =
  int(adw_action_row_get_title_lines(cast[ptr ActionRow00](self.impl)))

proc adw_action_row_remove(self: ptr ActionRow00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: ActionRow; widget: gtk4.Widget) =
  adw_action_row_remove(cast[ptr ActionRow00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_action_row_set_activatable_widget(self: ptr ActionRow00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setActivatableWidget*(self: ActionRow; widget: gtk4.Widget = nil) =
  adw_action_row_set_activatable_widget(cast[ptr ActionRow00](self.impl), if widget.isNil: nil else: cast[ptr gtk4.Widget00](widget.impl))

proc `activatableWidget=`*(self: ActionRow; widget: gtk4.Widget = nil) =
  adw_action_row_set_activatable_widget(cast[ptr ActionRow00](self.impl), if widget.isNil: nil else: cast[ptr gtk4.Widget00](widget.impl))

proc adw_action_row_set_icon_name(self: ptr ActionRow00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: ActionRow; iconName: cstring = nil) =
  adw_action_row_set_icon_name(cast[ptr ActionRow00](self.impl), iconName)

proc `iconName=`*(self: ActionRow; iconName: cstring = nil) =
  adw_action_row_set_icon_name(cast[ptr ActionRow00](self.impl), iconName)

proc adw_action_row_set_subtitle(self: ptr ActionRow00; subtitle: cstring) {.
    importc, libprag.}

proc setSubtitle*(self: ActionRow; subtitle: cstring) =
  adw_action_row_set_subtitle(cast[ptr ActionRow00](self.impl), subtitle)

proc `subtitle=`*(self: ActionRow; subtitle: cstring) =
  adw_action_row_set_subtitle(cast[ptr ActionRow00](self.impl), subtitle)

proc adw_action_row_set_subtitle_lines(self: ptr ActionRow00; subtitleLines: int32) {.
    importc, libprag.}

proc setSubtitleLines*(self: ActionRow; subtitleLines: int) =
  adw_action_row_set_subtitle_lines(cast[ptr ActionRow00](self.impl), int32(subtitleLines))

proc `subtitleLines=`*(self: ActionRow; subtitleLines: int) =
  adw_action_row_set_subtitle_lines(cast[ptr ActionRow00](self.impl), int32(subtitleLines))

proc adw_action_row_set_subtitle_selectable(self: ptr ActionRow00; subtitleSelectable: gboolean) {.
    importc, libprag.}

proc setSubtitleSelectable*(self: ActionRow; subtitleSelectable: bool = true) =
  adw_action_row_set_subtitle_selectable(cast[ptr ActionRow00](self.impl), gboolean(subtitleSelectable))

proc `subtitleSelectable=`*(self: ActionRow; subtitleSelectable: bool) =
  adw_action_row_set_subtitle_selectable(cast[ptr ActionRow00](self.impl), gboolean(subtitleSelectable))

proc adw_action_row_set_title_lines(self: ptr ActionRow00; titleLines: int32) {.
    importc, libprag.}

proc setTitleLines*(self: ActionRow; titleLines: int) =
  adw_action_row_set_title_lines(cast[ptr ActionRow00](self.impl), int32(titleLines))

proc `titleLines=`*(self: ActionRow; titleLines: int) =
  adw_action_row_set_title_lines(cast[ptr ActionRow00](self.impl), int32(titleLines))

type
  AlertDialog* = ref object of Dialog
  AlertDialog00* = object of Dialog00

proc adw_alert_dialog_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AlertDialog()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scResponse*(self: AlertDialog;  p: proc (self: ptr AlertDialog00; response: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "response", cast[GCallback](p), xdata, nil, cf)

proc adw_alert_dialog_new(heading: cstring; body: cstring): ptr AlertDialog00 {.
    importc, libprag.}

proc newAlertDialog*(heading: cstring = nil; body: cstring = nil): AlertDialog =
  let gobj = adw_alert_dialog_new(heading, body)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAlertDialog*(tdesc: typedesc; heading: cstring = nil; body: cstring = nil): tdesc =
  assert(result is AlertDialog)
  let gobj = adw_alert_dialog_new(heading, body)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAlertDialog*[T](result: var T; heading: cstring = nil; body: cstring = nil) {.deprecated.} =
  assert(result is AlertDialog)
  let gobj = adw_alert_dialog_new(heading, body)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_alert_dialog_add_response(self: ptr AlertDialog00; id: cstring;
    label: cstring) {.
    importc, libprag.}

proc addResponse*(self: AlertDialog; id: cstring; label: cstring) =
  adw_alert_dialog_add_response(cast[ptr AlertDialog00](self.impl), id, label)

proc adw_alert_dialog_choose(self: ptr AlertDialog00; parent: ptr gtk4.Widget00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc choose*(self: AlertDialog; parent: gtk4.Widget = nil;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  adw_alert_dialog_choose(cast[ptr AlertDialog00](self.impl), if parent.isNil: nil else: cast[ptr gtk4.Widget00](parent.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc adw_alert_dialog_choose_finish(self: ptr AlertDialog00; resu: ptr gio.AsyncResult00): cstring {.
    importc, libprag.}

proc chooseFinish*(self: AlertDialog; resu: gio.AsyncResult): string =
  result = $adw_alert_dialog_choose_finish(cast[ptr AlertDialog00](self.impl), cast[ptr gio.AsyncResult00](resu.impl))

proc adw_alert_dialog_get_body(self: ptr AlertDialog00): cstring {.
    importc, libprag.}

proc getBody*(self: AlertDialog): string =
  result = $adw_alert_dialog_get_body(cast[ptr AlertDialog00](self.impl))

proc body*(self: AlertDialog): string =
  result = $adw_alert_dialog_get_body(cast[ptr AlertDialog00](self.impl))

proc adw_alert_dialog_get_body_use_markup(self: ptr AlertDialog00): gboolean {.
    importc, libprag.}

proc getBodyUseMarkup*(self: AlertDialog): bool =
  toBool(adw_alert_dialog_get_body_use_markup(cast[ptr AlertDialog00](self.impl)))

proc bodyUseMarkup*(self: AlertDialog): bool =
  toBool(adw_alert_dialog_get_body_use_markup(cast[ptr AlertDialog00](self.impl)))

proc adw_alert_dialog_get_close_response(self: ptr AlertDialog00): cstring {.
    importc, libprag.}

proc getCloseResponse*(self: AlertDialog): string =
  result = $adw_alert_dialog_get_close_response(cast[ptr AlertDialog00](self.impl))

proc closeResponse*(self: AlertDialog): string =
  result = $adw_alert_dialog_get_close_response(cast[ptr AlertDialog00](self.impl))

proc adw_alert_dialog_get_default_response(self: ptr AlertDialog00): cstring {.
    importc, libprag.}

proc getDefaultResponse*(self: AlertDialog): string =
  let resul0 = adw_alert_dialog_get_default_response(cast[ptr AlertDialog00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc defaultResponse*(self: AlertDialog): string =
  let resul0 = adw_alert_dialog_get_default_response(cast[ptr AlertDialog00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_alert_dialog_get_extra_child(self: ptr AlertDialog00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getExtraChild*(self: AlertDialog): gtk4.Widget =
  let gobj = adw_alert_dialog_get_extra_child(cast[ptr AlertDialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc extraChild*(self: AlertDialog): gtk4.Widget =
  let gobj = adw_alert_dialog_get_extra_child(cast[ptr AlertDialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_alert_dialog_get_heading(self: ptr AlertDialog00): cstring {.
    importc, libprag.}

proc getHeading*(self: AlertDialog): string =
  let resul0 = adw_alert_dialog_get_heading(cast[ptr AlertDialog00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc heading*(self: AlertDialog): string =
  let resul0 = adw_alert_dialog_get_heading(cast[ptr AlertDialog00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_alert_dialog_get_heading_use_markup(self: ptr AlertDialog00): gboolean {.
    importc, libprag.}

proc getHeadingUseMarkup*(self: AlertDialog): bool =
  toBool(adw_alert_dialog_get_heading_use_markup(cast[ptr AlertDialog00](self.impl)))

proc headingUseMarkup*(self: AlertDialog): bool =
  toBool(adw_alert_dialog_get_heading_use_markup(cast[ptr AlertDialog00](self.impl)))

proc adw_alert_dialog_get_response_enabled(self: ptr AlertDialog00; response: cstring): gboolean {.
    importc, libprag.}

proc getResponseEnabled*(self: AlertDialog; response: cstring): bool =
  toBool(adw_alert_dialog_get_response_enabled(cast[ptr AlertDialog00](self.impl), response))

proc adw_alert_dialog_get_response_label(self: ptr AlertDialog00; response: cstring): cstring {.
    importc, libprag.}

proc getResponseLabel*(self: AlertDialog; response: cstring): string =
  result = $adw_alert_dialog_get_response_label(cast[ptr AlertDialog00](self.impl), response)

proc adw_alert_dialog_has_response(self: ptr AlertDialog00; response: cstring): gboolean {.
    importc, libprag.}

proc hasResponse*(self: AlertDialog; response: cstring): bool =
  toBool(adw_alert_dialog_has_response(cast[ptr AlertDialog00](self.impl), response))

proc adw_alert_dialog_remove_response(self: ptr AlertDialog00; id: cstring) {.
    importc, libprag.}

proc removeResponse*(self: AlertDialog; id: cstring) =
  adw_alert_dialog_remove_response(cast[ptr AlertDialog00](self.impl), id)

proc adw_alert_dialog_set_body(self: ptr AlertDialog00; body: cstring) {.
    importc, libprag.}

proc setBody*(self: AlertDialog; body: cstring) =
  adw_alert_dialog_set_body(cast[ptr AlertDialog00](self.impl), body)

proc `body=`*(self: AlertDialog; body: cstring) =
  adw_alert_dialog_set_body(cast[ptr AlertDialog00](self.impl), body)

proc adw_alert_dialog_set_body_use_markup(self: ptr AlertDialog00; useMarkup: gboolean) {.
    importc, libprag.}

proc setBodyUseMarkup*(self: AlertDialog; useMarkup: bool = true) =
  adw_alert_dialog_set_body_use_markup(cast[ptr AlertDialog00](self.impl), gboolean(useMarkup))

proc `bodyUseMarkup=`*(self: AlertDialog; useMarkup: bool) =
  adw_alert_dialog_set_body_use_markup(cast[ptr AlertDialog00](self.impl), gboolean(useMarkup))

proc adw_alert_dialog_set_close_response(self: ptr AlertDialog00; response: cstring) {.
    importc, libprag.}

proc setCloseResponse*(self: AlertDialog; response: cstring) =
  adw_alert_dialog_set_close_response(cast[ptr AlertDialog00](self.impl), response)

proc `closeResponse=`*(self: AlertDialog; response: cstring) =
  adw_alert_dialog_set_close_response(cast[ptr AlertDialog00](self.impl), response)

proc adw_alert_dialog_set_default_response(self: ptr AlertDialog00; response: cstring) {.
    importc, libprag.}

proc setDefaultResponse*(self: AlertDialog; response: cstring = nil) =
  adw_alert_dialog_set_default_response(cast[ptr AlertDialog00](self.impl), response)

proc `defaultResponse=`*(self: AlertDialog; response: cstring = nil) =
  adw_alert_dialog_set_default_response(cast[ptr AlertDialog00](self.impl), response)

proc adw_alert_dialog_set_extra_child(self: ptr AlertDialog00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setExtraChild*(self: AlertDialog; child: gtk4.Widget = nil) =
  adw_alert_dialog_set_extra_child(cast[ptr AlertDialog00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `extraChild=`*(self: AlertDialog; child: gtk4.Widget = nil) =
  adw_alert_dialog_set_extra_child(cast[ptr AlertDialog00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc adw_alert_dialog_set_heading(self: ptr AlertDialog00; heading: cstring) {.
    importc, libprag.}

proc setHeading*(self: AlertDialog; heading: cstring = nil) =
  adw_alert_dialog_set_heading(cast[ptr AlertDialog00](self.impl), heading)

proc `heading=`*(self: AlertDialog; heading: cstring = nil) =
  adw_alert_dialog_set_heading(cast[ptr AlertDialog00](self.impl), heading)

proc adw_alert_dialog_set_heading_use_markup(self: ptr AlertDialog00; useMarkup: gboolean) {.
    importc, libprag.}

proc setHeadingUseMarkup*(self: AlertDialog; useMarkup: bool = true) =
  adw_alert_dialog_set_heading_use_markup(cast[ptr AlertDialog00](self.impl), gboolean(useMarkup))

proc `headingUseMarkup=`*(self: AlertDialog; useMarkup: bool) =
  adw_alert_dialog_set_heading_use_markup(cast[ptr AlertDialog00](self.impl), gboolean(useMarkup))

proc adw_alert_dialog_set_response_enabled(self: ptr AlertDialog00; response: cstring;
    enabled: gboolean) {.
    importc, libprag.}

proc setResponseEnabled*(self: AlertDialog; response: cstring;
    enabled: bool) =
  adw_alert_dialog_set_response_enabled(cast[ptr AlertDialog00](self.impl), response, gboolean(enabled))

proc adw_alert_dialog_set_response_label(self: ptr AlertDialog00; response: cstring;
    label: cstring) {.
    importc, libprag.}

proc setResponseLabel*(self: AlertDialog; response: cstring;
    label: cstring) =
  adw_alert_dialog_set_response_label(cast[ptr AlertDialog00](self.impl), response, label)

type
  ResponseAppearance* {.size: sizeof(cint), pure.} = enum
    default = 0
    suggested = 1
    destructive = 2

proc adw_alert_dialog_get_response_appearance(self: ptr AlertDialog00; response: cstring): ResponseAppearance {.
    importc, libprag.}

proc getResponseAppearance*(self: AlertDialog; response: cstring): ResponseAppearance =
  adw_alert_dialog_get_response_appearance(cast[ptr AlertDialog00](self.impl), response)

proc adw_alert_dialog_set_response_appearance(self: ptr AlertDialog00; response: cstring;
    appearance: ResponseAppearance) {.
    importc, libprag.}

proc setResponseAppearance*(self: AlertDialog; response: cstring;
    appearance: ResponseAppearance) =
  adw_alert_dialog_set_response_appearance(cast[ptr AlertDialog00](self.impl), response, appearance)

type
  Animation* = ref object of gobject.Object
  Animation00* = object of gobject.Object00

proc adw_animation_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Animation()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDone*(self: Animation;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "done", cast[GCallback](p), xdata, nil, cf)

proc adw_animation_get_follow_enable_animations_setting(self: ptr Animation00): gboolean {.
    importc, libprag.}

proc getFollowEnableAnimationsSetting*(self: Animation): bool =
  toBool(adw_animation_get_follow_enable_animations_setting(cast[ptr Animation00](self.impl)))

proc followEnableAnimationsSetting*(self: Animation): bool =
  toBool(adw_animation_get_follow_enable_animations_setting(cast[ptr Animation00](self.impl)))

proc adw_animation_get_value(self: ptr Animation00): cdouble {.
    importc, libprag.}

proc getValue*(self: Animation): cdouble =
  adw_animation_get_value(cast[ptr Animation00](self.impl))

proc value*(self: Animation): cdouble =
  adw_animation_get_value(cast[ptr Animation00](self.impl))

proc adw_animation_get_widget(self: ptr Animation00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getWidget*(self: Animation): gtk4.Widget =
  let gobj = adw_animation_get_widget(cast[ptr Animation00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc widget*(self: Animation): gtk4.Widget =
  let gobj = adw_animation_get_widget(cast[ptr Animation00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_animation_pause(self: ptr Animation00) {.
    importc, libprag.}

proc pause*(self: Animation) =
  adw_animation_pause(cast[ptr Animation00](self.impl))

proc adw_animation_play(self: ptr Animation00) {.
    importc, libprag.}

proc play*(self: Animation) =
  adw_animation_play(cast[ptr Animation00](self.impl))

proc adw_animation_reset(self: ptr Animation00) {.
    importc, libprag.}

proc reset*(self: Animation) =
  adw_animation_reset(cast[ptr Animation00](self.impl))

proc adw_animation_resume(self: ptr Animation00) {.
    importc, libprag.}

proc resume*(self: Animation) =
  adw_animation_resume(cast[ptr Animation00](self.impl))

proc adw_animation_set_follow_enable_animations_setting(self: ptr Animation00;
    setting: gboolean) {.
    importc, libprag.}

proc setFollowEnableAnimationsSetting*(self: Animation;
    setting: bool = true) =
  adw_animation_set_follow_enable_animations_setting(cast[ptr Animation00](self.impl), gboolean(setting))

proc `followEnableAnimationsSetting=`*(self: Animation;
    setting: bool) =
  adw_animation_set_follow_enable_animations_setting(cast[ptr Animation00](self.impl), gboolean(setting))

proc adw_animation_skip(self: ptr Animation00) {.
    importc, libprag.}

proc skip*(self: Animation) =
  adw_animation_skip(cast[ptr Animation00](self.impl))

type
  AnimationState* {.size: sizeof(cint), pure.} = enum
    idle = 0
    paused = 1
    playing = 2
    finished = 3

proc adw_animation_get_state(self: ptr Animation00): AnimationState {.
    importc, libprag.}

proc getState*(self: Animation): AnimationState =
  adw_animation_get_state(cast[ptr Animation00](self.impl))

proc state*(self: Animation): AnimationState =
  adw_animation_get_state(cast[ptr Animation00](self.impl))

type
  AnimationTarget* = ref object of gobject.Object
  AnimationTarget00* = object of gobject.Object00

proc adw_animation_target_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnimationTarget()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_animation_get_target(self: ptr Animation00): ptr AnimationTarget00 {.
    importc, libprag.}

proc getTarget*(self: Animation): AnimationTarget =
  let gobj = adw_animation_get_target(cast[ptr Animation00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc target*(self: Animation): AnimationTarget =
  let gobj = adw_animation_get_target(cast[ptr Animation00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_animation_set_target(self: ptr Animation00; target: ptr AnimationTarget00) {.
    importc, libprag.}

proc setTarget*(self: Animation; target: AnimationTarget) =
  adw_animation_set_target(cast[ptr Animation00](self.impl), cast[ptr AnimationTarget00](target.impl))

proc `target=`*(self: Animation; target: AnimationTarget) =
  adw_animation_set_target(cast[ptr Animation00](self.impl), cast[ptr AnimationTarget00](target.impl))

type
  AnimationTargetFunc* = proc (value: cdouble; userData: pointer) {.cdecl.}

type
  Application* = ref object of gtk4.Application
  Application00* = object of gtk4.Application00

proc adw_application_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Application()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_application_new(applicationId: cstring; flags: gio.ApplicationFlags): ptr Application00 {.
    importc, libprag.}

proc newApplication*(applicationId: cstring = nil; flags: gio.ApplicationFlags): Application =
  let gobj = adw_application_new(applicationId, flags)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newApplication*(tdesc: typedesc; applicationId: cstring = nil; flags: gio.ApplicationFlags): tdesc =
  assert(result is Application)
  let gobj = adw_application_new(applicationId, flags)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initApplication*[T](result: var T; applicationId: cstring = nil; flags: gio.ApplicationFlags) {.deprecated.} =
  assert(result is Application)
  let gobj = adw_application_new(applicationId, flags)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  StyleManager* = ref object of gobject.Object
  StyleManager00* = object of gobject.Object00

proc adw_style_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_style_manager_get_default(): ptr StyleManager00 {.
    importc, libprag.}

proc getDefaultStyleManager*(): StyleManager =
  let gobj = adw_style_manager_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_style_manager_get_for_display(display: ptr gdk4.Display00): ptr StyleManager00 {.
    importc, libprag.}

proc getForDisplay*(display: gdk4.Display): StyleManager =
  let gobj = adw_style_manager_get_for_display(cast[ptr gdk4.Display00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc forDisplay*(display: gdk4.Display): StyleManager =
  let gobj = adw_style_manager_get_for_display(cast[ptr gdk4.Display00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_style_manager_get_dark(self: ptr StyleManager00): gboolean {.
    importc, libprag.}

proc getDark*(self: StyleManager): bool =
  toBool(adw_style_manager_get_dark(cast[ptr StyleManager00](self.impl)))

proc dark*(self: StyleManager): bool =
  toBool(adw_style_manager_get_dark(cast[ptr StyleManager00](self.impl)))

proc adw_style_manager_get_display(self: ptr StyleManager00): ptr gdk4.Display00 {.
    importc, libprag.}

proc getDisplay*(self: StyleManager): gdk4.Display =
  let gobj = adw_style_manager_get_display(cast[ptr StyleManager00](self.impl))
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

proc display*(self: StyleManager): gdk4.Display =
  let gobj = adw_style_manager_get_display(cast[ptr StyleManager00](self.impl))
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

proc adw_style_manager_get_high_contrast(self: ptr StyleManager00): gboolean {.
    importc, libprag.}

proc getHighContrast*(self: StyleManager): bool =
  toBool(adw_style_manager_get_high_contrast(cast[ptr StyleManager00](self.impl)))

proc highContrast*(self: StyleManager): bool =
  toBool(adw_style_manager_get_high_contrast(cast[ptr StyleManager00](self.impl)))

proc adw_style_manager_get_system_supports_color_schemes(self: ptr StyleManager00): gboolean {.
    importc, libprag.}

proc getSystemSupportsColorSchemes*(self: StyleManager): bool =
  toBool(adw_style_manager_get_system_supports_color_schemes(cast[ptr StyleManager00](self.impl)))

proc systemSupportsColorSchemes*(self: StyleManager): bool =
  toBool(adw_style_manager_get_system_supports_color_schemes(cast[ptr StyleManager00](self.impl)))

proc adw_application_get_style_manager(self: ptr Application00): ptr StyleManager00 {.
    importc, libprag.}

proc getStyleManager*(self: Application): StyleManager =
  let gobj = adw_application_get_style_manager(cast[ptr Application00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc styleManager*(self: Application): StyleManager =
  let gobj = adw_application_get_style_manager(cast[ptr Application00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ColorScheme* {.size: sizeof(cint), pure.} = enum
    default = 0
    forceLight = 1
    preferLight = 2
    preferDark = 3
    forceDark = 4

proc adw_style_manager_get_color_scheme(self: ptr StyleManager00): ColorScheme {.
    importc, libprag.}

proc getColorScheme*(self: StyleManager): ColorScheme =
  adw_style_manager_get_color_scheme(cast[ptr StyleManager00](self.impl))

proc colorScheme*(self: StyleManager): ColorScheme =
  adw_style_manager_get_color_scheme(cast[ptr StyleManager00](self.impl))

proc adw_style_manager_set_color_scheme(self: ptr StyleManager00; colorScheme: ColorScheme) {.
    importc, libprag.}

proc setColorScheme*(self: StyleManager; colorScheme: ColorScheme) =
  adw_style_manager_set_color_scheme(cast[ptr StyleManager00](self.impl), colorScheme)

proc `colorScheme=`*(self: StyleManager; colorScheme: ColorScheme) =
  adw_style_manager_set_color_scheme(cast[ptr StyleManager00](self.impl), colorScheme)

type
  ApplicationWindow* = ref object of gtk4.ApplicationWindow
  ApplicationWindow00* = object of gtk4.ApplicationWindow00

proc adw_application_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ApplicationWindow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_application_window_new(app: ptr gtk4.Application00): ptr ApplicationWindow00 {.
    importc, libprag.}

proc newApplicationWindow*(app: gtk4.Application): ApplicationWindow =
  let gobj = adw_application_window_new(cast[ptr gtk4.Application00](app.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newApplicationWindow*(tdesc: typedesc; app: gtk4.Application): tdesc =
  assert(result is ApplicationWindow)
  let gobj = adw_application_window_new(cast[ptr gtk4.Application00](app.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initApplicationWindow*[T](result: var T; app: gtk4.Application) {.deprecated.} =
  assert(result is ApplicationWindow)
  let gobj = adw_application_window_new(cast[ptr gtk4.Application00](app.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_application_window_add_breakpoint(self: ptr ApplicationWindow00;
    breakpoint: ptr Breakpoint00) {.
    importc, libprag.}

proc addBreakpoint*(self: ApplicationWindow; breakpoint: Breakpoint) =
  adw_application_window_add_breakpoint(cast[ptr ApplicationWindow00](self.impl), cast[ptr Breakpoint00](g_object_ref(breakpoint.impl)))

proc adw_application_window_get_content(self: ptr ApplicationWindow00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getContent*(self: ApplicationWindow): gtk4.Widget =
  let gobj = adw_application_window_get_content(cast[ptr ApplicationWindow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc content*(self: ApplicationWindow): gtk4.Widget =
  let gobj = adw_application_window_get_content(cast[ptr ApplicationWindow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_application_window_get_current_breakpoint(self: ptr ApplicationWindow00): ptr Breakpoint00 {.
    importc, libprag.}

proc getCurrentBreakpoint*(self: ApplicationWindow): Breakpoint =
  let gobj = adw_application_window_get_current_breakpoint(cast[ptr ApplicationWindow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentBreakpoint*(self: ApplicationWindow): Breakpoint =
  let gobj = adw_application_window_get_current_breakpoint(cast[ptr ApplicationWindow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_application_window_get_dialogs(self: ptr ApplicationWindow00): ptr gio.ListModel00 {.
    importc, libprag.}

proc getDialogs*(self: ApplicationWindow): gio.ListModel =
  let gobj = adw_application_window_get_dialogs(cast[ptr ApplicationWindow00](self.impl))
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

proc dialogs*(self: ApplicationWindow): gio.ListModel =
  let gobj = adw_application_window_get_dialogs(cast[ptr ApplicationWindow00](self.impl))
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

proc adw_application_window_get_visible_dialog(self: ptr ApplicationWindow00): ptr Dialog00 {.
    importc, libprag.}

proc getVisibleDialog*(self: ApplicationWindow): Dialog =
  let gobj = adw_application_window_get_visible_dialog(cast[ptr ApplicationWindow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visibleDialog*(self: ApplicationWindow): Dialog =
  let gobj = adw_application_window_get_visible_dialog(cast[ptr ApplicationWindow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_application_window_set_content(self: ptr ApplicationWindow00; content: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setContent*(self: ApplicationWindow; content: gtk4.Widget = nil) =
  adw_application_window_set_content(cast[ptr ApplicationWindow00](self.impl), if content.isNil: nil else: cast[ptr gtk4.Widget00](content.impl))

proc `content=`*(self: ApplicationWindow; content: gtk4.Widget = nil) =
  adw_application_window_set_content(cast[ptr ApplicationWindow00](self.impl), if content.isNil: nil else: cast[ptr gtk4.Widget00](content.impl))

type
  Avatar* = ref object of gtk4.Widget
  Avatar00* = object of gtk4.Widget00

proc adw_avatar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Avatar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_avatar_new(size: int32; text: cstring; showInitials: gboolean): ptr Avatar00 {.
    importc, libprag.}

proc newAvatar*(size: int; text: cstring = nil; showInitials: bool): Avatar =
  let gobj = adw_avatar_new(int32(size), text, gboolean(showInitials))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAvatar*(tdesc: typedesc; size: int; text: cstring = nil; showInitials: bool): tdesc =
  assert(result is Avatar)
  let gobj = adw_avatar_new(int32(size), text, gboolean(showInitials))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAvatar*[T](result: var T; size: int; text: cstring = nil; showInitials: bool) {.deprecated.} =
  assert(result is Avatar)
  let gobj = adw_avatar_new(int32(size), text, gboolean(showInitials))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_avatar_draw_to_texture(self: ptr Avatar00; scaleFactor: int32): ptr gdk4.Texture00 {.
    importc, libprag.}

proc drawToTexture*(self: Avatar; scaleFactor: int): gdk4.Texture =
  let gobj = adw_avatar_draw_to_texture(cast[ptr Avatar00](self.impl), int32(scaleFactor))
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

proc adw_avatar_get_custom_image(self: ptr Avatar00): ptr gdk4.Paintable00 {.
    importc, libprag.}

proc getCustomImage*(self: Avatar): gdk4.Paintable =
  let gobj = adw_avatar_get_custom_image(cast[ptr Avatar00](self.impl))
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

proc customImage*(self: Avatar): gdk4.Paintable =
  let gobj = adw_avatar_get_custom_image(cast[ptr Avatar00](self.impl))
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

proc adw_avatar_get_icon_name(self: ptr Avatar00): cstring {.
    importc, libprag.}

proc getIconName*(self: Avatar): string =
  let resul0 = adw_avatar_get_icon_name(cast[ptr Avatar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: Avatar): string =
  let resul0 = adw_avatar_get_icon_name(cast[ptr Avatar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_avatar_get_show_initials(self: ptr Avatar00): gboolean {.
    importc, libprag.}

proc getShowInitials*(self: Avatar): bool =
  toBool(adw_avatar_get_show_initials(cast[ptr Avatar00](self.impl)))

proc showInitials*(self: Avatar): bool =
  toBool(adw_avatar_get_show_initials(cast[ptr Avatar00](self.impl)))

proc adw_avatar_get_size(self: ptr Avatar00): int32 {.
    importc, libprag.}

proc getSize*(self: Avatar): int =
  int(adw_avatar_get_size(cast[ptr Avatar00](self.impl)))

proc size*(self: Avatar): int =
  int(adw_avatar_get_size(cast[ptr Avatar00](self.impl)))

proc adw_avatar_get_text(self: ptr Avatar00): cstring {.
    importc, libprag.}

proc getText*(self: Avatar): string =
  let resul0 = adw_avatar_get_text(cast[ptr Avatar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc text*(self: Avatar): string =
  let resul0 = adw_avatar_get_text(cast[ptr Avatar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_avatar_set_custom_image(self: ptr Avatar00; customImage: ptr gdk4.Paintable00) {.
    importc, libprag.}

proc setCustomImage*(self: Avatar; customImage: gdk4.Paintable = nil) =
  adw_avatar_set_custom_image(cast[ptr Avatar00](self.impl), if customImage.isNil: nil else: cast[ptr gdk4.Paintable00](customImage.impl))

proc `customImage=`*(self: Avatar; customImage: gdk4.Paintable = nil) =
  adw_avatar_set_custom_image(cast[ptr Avatar00](self.impl), if customImage.isNil: nil else: cast[ptr gdk4.Paintable00](customImage.impl))

proc adw_avatar_set_icon_name(self: ptr Avatar00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: Avatar; iconName: cstring = nil) =
  adw_avatar_set_icon_name(cast[ptr Avatar00](self.impl), iconName)

proc `iconName=`*(self: Avatar; iconName: cstring = nil) =
  adw_avatar_set_icon_name(cast[ptr Avatar00](self.impl), iconName)

proc adw_avatar_set_show_initials(self: ptr Avatar00; showInitials: gboolean) {.
    importc, libprag.}

proc setShowInitials*(self: Avatar; showInitials: bool = true) =
  adw_avatar_set_show_initials(cast[ptr Avatar00](self.impl), gboolean(showInitials))

proc `showInitials=`*(self: Avatar; showInitials: bool) =
  adw_avatar_set_show_initials(cast[ptr Avatar00](self.impl), gboolean(showInitials))

proc adw_avatar_set_size(self: ptr Avatar00; size: int32) {.
    importc, libprag.}

proc setSize*(self: Avatar; size: int) =
  adw_avatar_set_size(cast[ptr Avatar00](self.impl), int32(size))

proc `size=`*(self: Avatar; size: int) =
  adw_avatar_set_size(cast[ptr Avatar00](self.impl), int32(size))

proc adw_avatar_set_text(self: ptr Avatar00; text: cstring) {.
    importc, libprag.}

proc setText*(self: Avatar; text: cstring = nil) =
  adw_avatar_set_text(cast[ptr Avatar00](self.impl), text)

proc `text=`*(self: Avatar; text: cstring = nil) =
  adw_avatar_set_text(cast[ptr Avatar00](self.impl), text)

type
  Banner* = ref object of gtk4.Widget
  Banner00* = object of gtk4.Widget00

proc adw_banner_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Banner()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scButtonClicked*(self: Banner;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "button-clicked", cast[GCallback](p), xdata, nil, cf)

proc adw_banner_new(title: cstring): ptr Banner00 {.
    importc, libprag.}

proc newBanner*(title: cstring): Banner =
  let gobj = adw_banner_new(title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newBanner*(tdesc: typedesc; title: cstring): tdesc =
  assert(result is Banner)
  let gobj = adw_banner_new(title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBanner*[T](result: var T; title: cstring) {.deprecated.} =
  assert(result is Banner)
  let gobj = adw_banner_new(title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_banner_get_button_label(self: ptr Banner00): cstring {.
    importc, libprag.}

proc getButtonLabel*(self: Banner): string =
  let resul0 = adw_banner_get_button_label(cast[ptr Banner00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc buttonLabel*(self: Banner): string =
  let resul0 = adw_banner_get_button_label(cast[ptr Banner00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_banner_get_revealed(self: ptr Banner00): gboolean {.
    importc, libprag.}

proc getRevealed*(self: Banner): bool =
  toBool(adw_banner_get_revealed(cast[ptr Banner00](self.impl)))

proc revealed*(self: Banner): bool =
  toBool(adw_banner_get_revealed(cast[ptr Banner00](self.impl)))

proc adw_banner_get_title(self: ptr Banner00): cstring {.
    importc, libprag.}

proc getTitle*(self: Banner): string =
  result = $adw_banner_get_title(cast[ptr Banner00](self.impl))

proc title*(self: Banner): string =
  result = $adw_banner_get_title(cast[ptr Banner00](self.impl))

proc adw_banner_get_use_markup(self: ptr Banner00): gboolean {.
    importc, libprag.}

proc getUseMarkup*(self: Banner): bool =
  toBool(adw_banner_get_use_markup(cast[ptr Banner00](self.impl)))

proc useMarkup*(self: Banner): bool =
  toBool(adw_banner_get_use_markup(cast[ptr Banner00](self.impl)))

proc adw_banner_set_button_label(self: ptr Banner00; label: cstring) {.
    importc, libprag.}

proc setButtonLabel*(self: Banner; label: cstring = nil) =
  adw_banner_set_button_label(cast[ptr Banner00](self.impl), label)

proc `buttonLabel=`*(self: Banner; label: cstring = nil) =
  adw_banner_set_button_label(cast[ptr Banner00](self.impl), label)

proc adw_banner_set_revealed(self: ptr Banner00; revealed: gboolean) {.
    importc, libprag.}

proc setRevealed*(self: Banner; revealed: bool = true) =
  adw_banner_set_revealed(cast[ptr Banner00](self.impl), gboolean(revealed))

proc `revealed=`*(self: Banner; revealed: bool) =
  adw_banner_set_revealed(cast[ptr Banner00](self.impl), gboolean(revealed))

proc adw_banner_set_title(self: ptr Banner00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: Banner; title: cstring) =
  adw_banner_set_title(cast[ptr Banner00](self.impl), title)

proc `title=`*(self: Banner; title: cstring) =
  adw_banner_set_title(cast[ptr Banner00](self.impl), title)

proc adw_banner_set_use_markup(self: ptr Banner00; useMarkup: gboolean) {.
    importc, libprag.}

proc setUseMarkup*(self: Banner; useMarkup: bool = true) =
  adw_banner_set_use_markup(cast[ptr Banner00](self.impl), gboolean(useMarkup))

proc `useMarkup=`*(self: Banner; useMarkup: bool) =
  adw_banner_set_use_markup(cast[ptr Banner00](self.impl), gboolean(useMarkup))

type
  Bin* = ref object of gtk4.Widget
  Bin00* = object of gtk4.Widget00

proc adw_bin_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Bin()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_bin_new(): ptr Bin00 {.
    importc, libprag.}

proc newBin*(): Bin =
  let gobj = adw_bin_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newBin*(tdesc: typedesc): tdesc =
  assert(result is Bin)
  let gobj = adw_bin_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBin*[T](result: var T) {.deprecated.} =
  assert(result is Bin)
  let gobj = adw_bin_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_bin_get_child(self: ptr Bin00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: Bin): gtk4.Widget =
  let gobj = adw_bin_get_child(cast[ptr Bin00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: Bin): gtk4.Widget =
  let gobj = adw_bin_get_child(cast[ptr Bin00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_bin_set_child(self: ptr Bin00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setChild*(self: Bin; child: gtk4.Widget = nil) =
  adw_bin_set_child(cast[ptr Bin00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `child=`*(self: Bin; child: gtk4.Widget = nil) =
  adw_bin_set_child(cast[ptr Bin00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

type
  BreakpointBin* = ref object of gtk4.Widget
  BreakpointBin00* = object of gtk4.Widget00

proc adw_breakpoint_bin_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BreakpointBin()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_breakpoint_bin_new(): ptr BreakpointBin00 {.
    importc, libprag.}

proc newBreakpointBin*(): BreakpointBin =
  let gobj = adw_breakpoint_bin_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newBreakpointBin*(tdesc: typedesc): tdesc =
  assert(result is BreakpointBin)
  let gobj = adw_breakpoint_bin_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBreakpointBin*[T](result: var T) {.deprecated.} =
  assert(result is BreakpointBin)
  let gobj = adw_breakpoint_bin_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_breakpoint_bin_add_breakpoint(self: ptr BreakpointBin00; breakpoint: ptr Breakpoint00) {.
    importc, libprag.}

proc addBreakpoint*(self: BreakpointBin; breakpoint: Breakpoint) =
  adw_breakpoint_bin_add_breakpoint(cast[ptr BreakpointBin00](self.impl), cast[ptr Breakpoint00](g_object_ref(breakpoint.impl)))

proc adw_breakpoint_bin_get_child(self: ptr BreakpointBin00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: BreakpointBin): gtk4.Widget =
  let gobj = adw_breakpoint_bin_get_child(cast[ptr BreakpointBin00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: BreakpointBin): gtk4.Widget =
  let gobj = adw_breakpoint_bin_get_child(cast[ptr BreakpointBin00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_breakpoint_bin_get_current_breakpoint(self: ptr BreakpointBin00): ptr Breakpoint00 {.
    importc, libprag.}

proc getCurrentBreakpoint*(self: BreakpointBin): Breakpoint =
  let gobj = adw_breakpoint_bin_get_current_breakpoint(cast[ptr BreakpointBin00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentBreakpoint*(self: BreakpointBin): Breakpoint =
  let gobj = adw_breakpoint_bin_get_current_breakpoint(cast[ptr BreakpointBin00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_breakpoint_bin_remove_breakpoint(self: ptr BreakpointBin00; breakpoint: ptr Breakpoint00) {.
    importc, libprag.}

proc removeBreakpoint*(self: BreakpointBin; breakpoint: Breakpoint) =
  adw_breakpoint_bin_remove_breakpoint(cast[ptr BreakpointBin00](self.impl), cast[ptr Breakpoint00](breakpoint.impl))

proc adw_breakpoint_bin_set_child(self: ptr BreakpointBin00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setChild*(self: BreakpointBin; child: gtk4.Widget = nil) =
  adw_breakpoint_bin_set_child(cast[ptr BreakpointBin00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `child=`*(self: BreakpointBin; child: gtk4.Widget = nil) =
  adw_breakpoint_bin_set_child(cast[ptr BreakpointBin00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

type
  ButtonContent* = ref object of gtk4.Widget
  ButtonContent00* = object of gtk4.Widget00

proc adw_button_content_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ButtonContent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_button_content_new(): ptr ButtonContent00 {.
    importc, libprag.}

proc newButtonContent*(): ButtonContent =
  let gobj = adw_button_content_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newButtonContent*(tdesc: typedesc): tdesc =
  assert(result is ButtonContent)
  let gobj = adw_button_content_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initButtonContent*[T](result: var T) {.deprecated.} =
  assert(result is ButtonContent)
  let gobj = adw_button_content_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_button_content_get_can_shrink(self: ptr ButtonContent00): gboolean {.
    importc, libprag.}

proc getCanShrink*(self: ButtonContent): bool =
  toBool(adw_button_content_get_can_shrink(cast[ptr ButtonContent00](self.impl)))

proc canShrink*(self: ButtonContent): bool =
  toBool(adw_button_content_get_can_shrink(cast[ptr ButtonContent00](self.impl)))

proc adw_button_content_get_icon_name(self: ptr ButtonContent00): cstring {.
    importc, libprag.}

proc getIconName*(self: ButtonContent): string =
  result = $adw_button_content_get_icon_name(cast[ptr ButtonContent00](self.impl))

proc iconName*(self: ButtonContent): string =
  result = $adw_button_content_get_icon_name(cast[ptr ButtonContent00](self.impl))

proc adw_button_content_get_label(self: ptr ButtonContent00): cstring {.
    importc, libprag.}

proc getLabel*(self: ButtonContent): string =
  result = $adw_button_content_get_label(cast[ptr ButtonContent00](self.impl))

proc label*(self: ButtonContent): string =
  result = $adw_button_content_get_label(cast[ptr ButtonContent00](self.impl))

proc adw_button_content_get_use_underline(self: ptr ButtonContent00): gboolean {.
    importc, libprag.}

proc getUseUnderline*(self: ButtonContent): bool =
  toBool(adw_button_content_get_use_underline(cast[ptr ButtonContent00](self.impl)))

proc useUnderline*(self: ButtonContent): bool =
  toBool(adw_button_content_get_use_underline(cast[ptr ButtonContent00](self.impl)))

proc adw_button_content_set_can_shrink(self: ptr ButtonContent00; canShrink: gboolean) {.
    importc, libprag.}

proc setCanShrink*(self: ButtonContent; canShrink: bool = true) =
  adw_button_content_set_can_shrink(cast[ptr ButtonContent00](self.impl), gboolean(canShrink))

proc `canShrink=`*(self: ButtonContent; canShrink: bool) =
  adw_button_content_set_can_shrink(cast[ptr ButtonContent00](self.impl), gboolean(canShrink))

proc adw_button_content_set_icon_name(self: ptr ButtonContent00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: ButtonContent; iconName: cstring) =
  adw_button_content_set_icon_name(cast[ptr ButtonContent00](self.impl), iconName)

proc `iconName=`*(self: ButtonContent; iconName: cstring) =
  adw_button_content_set_icon_name(cast[ptr ButtonContent00](self.impl), iconName)

proc adw_button_content_set_label(self: ptr ButtonContent00; label: cstring) {.
    importc, libprag.}

proc setLabel*(self: ButtonContent; label: cstring) =
  adw_button_content_set_label(cast[ptr ButtonContent00](self.impl), label)

proc `label=`*(self: ButtonContent; label: cstring) =
  adw_button_content_set_label(cast[ptr ButtonContent00](self.impl), label)

proc adw_button_content_set_use_underline(self: ptr ButtonContent00; useUnderline: gboolean) {.
    importc, libprag.}

proc setUseUnderline*(self: ButtonContent; useUnderline: bool = true) =
  adw_button_content_set_use_underline(cast[ptr ButtonContent00](self.impl), gboolean(useUnderline))

proc `useUnderline=`*(self: ButtonContent; useUnderline: bool) =
  adw_button_content_set_use_underline(cast[ptr ButtonContent00](self.impl), gboolean(useUnderline))

type
  CallbackAnimationTarget* = ref object of AnimationTarget
  CallbackAnimationTarget00* = object of AnimationTarget00

proc adw_callback_animation_target_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CallbackAnimationTarget()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_callback_animation_target_new(callback: AnimationTargetFunc; userData: pointer;
    destroy: DestroyNotify): ptr CallbackAnimationTarget00 {.
    importc, libprag.}

proc newCallbackAnimationTarget*(callback: AnimationTargetFunc; userData: pointer;
    destroy: DestroyNotify): CallbackAnimationTarget =
  let gobj = adw_callback_animation_target_new(callback, userData, destroy)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCallbackAnimationTarget*(tdesc: typedesc; callback: AnimationTargetFunc; userData: pointer;
    destroy: DestroyNotify): tdesc =
  assert(result is CallbackAnimationTarget)
  let gobj = adw_callback_animation_target_new(callback, userData, destroy)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCallbackAnimationTarget*[T](result: var T; callback: AnimationTargetFunc; userData: pointer;
    destroy: DestroyNotify) {.deprecated.} =
  assert(result is CallbackAnimationTarget)
  let gobj = adw_callback_animation_target_new(callback, userData, destroy)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Carousel* = ref object of gtk4.Widget
  Carousel00* = object of gtk4.Widget00

proc adw_carousel_get_type*(): GType {.importc, libprag.}

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

proc adw_carousel_new(): ptr Carousel00 {.
    importc, libprag.}

proc newCarousel*(): Carousel =
  let gobj = adw_carousel_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCarousel*(tdesc: typedesc): tdesc =
  assert(result is Carousel)
  let gobj = adw_carousel_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCarousel*[T](result: var T) {.deprecated.} =
  assert(result is Carousel)
  let gobj = adw_carousel_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_carousel_append(self: ptr Carousel00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc append*(self: Carousel; child: gtk4.Widget) =
  adw_carousel_append(cast[ptr Carousel00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_carousel_get_allow_long_swipes(self: ptr Carousel00): gboolean {.
    importc, libprag.}

proc getAllowLongSwipes*(self: Carousel): bool =
  toBool(adw_carousel_get_allow_long_swipes(cast[ptr Carousel00](self.impl)))

proc allowLongSwipes*(self: Carousel): bool =
  toBool(adw_carousel_get_allow_long_swipes(cast[ptr Carousel00](self.impl)))

proc adw_carousel_get_allow_mouse_drag(self: ptr Carousel00): gboolean {.
    importc, libprag.}

proc getAllowMouseDrag*(self: Carousel): bool =
  toBool(adw_carousel_get_allow_mouse_drag(cast[ptr Carousel00](self.impl)))

proc allowMouseDrag*(self: Carousel): bool =
  toBool(adw_carousel_get_allow_mouse_drag(cast[ptr Carousel00](self.impl)))

proc adw_carousel_get_allow_scroll_wheel(self: ptr Carousel00): gboolean {.
    importc, libprag.}

proc getAllowScrollWheel*(self: Carousel): bool =
  toBool(adw_carousel_get_allow_scroll_wheel(cast[ptr Carousel00](self.impl)))

proc allowScrollWheel*(self: Carousel): bool =
  toBool(adw_carousel_get_allow_scroll_wheel(cast[ptr Carousel00](self.impl)))

proc adw_carousel_get_interactive(self: ptr Carousel00): gboolean {.
    importc, libprag.}

proc getInteractive*(self: Carousel): bool =
  toBool(adw_carousel_get_interactive(cast[ptr Carousel00](self.impl)))

proc interactive*(self: Carousel): bool =
  toBool(adw_carousel_get_interactive(cast[ptr Carousel00](self.impl)))

proc adw_carousel_get_n_pages(self: ptr Carousel00): uint32 {.
    importc, libprag.}

proc getNPages*(self: Carousel): int =
  int(adw_carousel_get_n_pages(cast[ptr Carousel00](self.impl)))

proc nPages*(self: Carousel): int =
  int(adw_carousel_get_n_pages(cast[ptr Carousel00](self.impl)))

proc adw_carousel_get_nth_page(self: ptr Carousel00; n: uint32): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getNthPage*(self: Carousel; n: int): gtk4.Widget =
  let gobj = adw_carousel_get_nth_page(cast[ptr Carousel00](self.impl), uint32(n))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_carousel_get_position(self: ptr Carousel00): cdouble {.
    importc, libprag.}

proc getPosition*(self: Carousel): cdouble =
  adw_carousel_get_position(cast[ptr Carousel00](self.impl))

proc position*(self: Carousel): cdouble =
  adw_carousel_get_position(cast[ptr Carousel00](self.impl))

proc adw_carousel_get_reveal_duration(self: ptr Carousel00): uint32 {.
    importc, libprag.}

proc getRevealDuration*(self: Carousel): int =
  int(adw_carousel_get_reveal_duration(cast[ptr Carousel00](self.impl)))

proc revealDuration*(self: Carousel): int =
  int(adw_carousel_get_reveal_duration(cast[ptr Carousel00](self.impl)))

proc adw_carousel_get_spacing(self: ptr Carousel00): uint32 {.
    importc, libprag.}

proc getSpacing*(self: Carousel): int =
  int(adw_carousel_get_spacing(cast[ptr Carousel00](self.impl)))

proc spacing*(self: Carousel): int =
  int(adw_carousel_get_spacing(cast[ptr Carousel00](self.impl)))

proc adw_carousel_insert(self: ptr Carousel00; child: ptr gtk4.Widget00;
    position: int32) {.
    importc, libprag.}

proc insert*(self: Carousel; child: gtk4.Widget; position: int) =
  adw_carousel_insert(cast[ptr Carousel00](self.impl), cast[ptr gtk4.Widget00](child.impl), int32(position))

proc adw_carousel_prepend(self: ptr Carousel00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc prepend*(self: Carousel; child: gtk4.Widget) =
  adw_carousel_prepend(cast[ptr Carousel00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_carousel_remove(self: ptr Carousel00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: Carousel; child: gtk4.Widget) =
  adw_carousel_remove(cast[ptr Carousel00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_carousel_reorder(self: ptr Carousel00; child: ptr gtk4.Widget00;
    position: int32) {.
    importc, libprag.}

proc reorder*(self: Carousel; child: gtk4.Widget; position: int) =
  adw_carousel_reorder(cast[ptr Carousel00](self.impl), cast[ptr gtk4.Widget00](child.impl), int32(position))

proc adw_carousel_scroll_to(self: ptr Carousel00; widget: ptr gtk4.Widget00;
    animate: gboolean) {.
    importc, libprag.}

proc scrollTo*(self: Carousel; widget: gtk4.Widget; animate: bool) =
  adw_carousel_scroll_to(cast[ptr Carousel00](self.impl), cast[ptr gtk4.Widget00](widget.impl), gboolean(animate))

proc adw_carousel_set_allow_long_swipes(self: ptr Carousel00; allowLongSwipes: gboolean) {.
    importc, libprag.}

proc setAllowLongSwipes*(self: Carousel; allowLongSwipes: bool = true) =
  adw_carousel_set_allow_long_swipes(cast[ptr Carousel00](self.impl), gboolean(allowLongSwipes))

proc `allowLongSwipes=`*(self: Carousel; allowLongSwipes: bool) =
  adw_carousel_set_allow_long_swipes(cast[ptr Carousel00](self.impl), gboolean(allowLongSwipes))

proc adw_carousel_set_allow_mouse_drag(self: ptr Carousel00; allowMouseDrag: gboolean) {.
    importc, libprag.}

proc setAllowMouseDrag*(self: Carousel; allowMouseDrag: bool = true) =
  adw_carousel_set_allow_mouse_drag(cast[ptr Carousel00](self.impl), gboolean(allowMouseDrag))

proc `allowMouseDrag=`*(self: Carousel; allowMouseDrag: bool) =
  adw_carousel_set_allow_mouse_drag(cast[ptr Carousel00](self.impl), gboolean(allowMouseDrag))

proc adw_carousel_set_allow_scroll_wheel(self: ptr Carousel00; allowScrollWheel: gboolean) {.
    importc, libprag.}

proc setAllowScrollWheel*(self: Carousel; allowScrollWheel: bool = true) =
  adw_carousel_set_allow_scroll_wheel(cast[ptr Carousel00](self.impl), gboolean(allowScrollWheel))

proc `allowScrollWheel=`*(self: Carousel; allowScrollWheel: bool) =
  adw_carousel_set_allow_scroll_wheel(cast[ptr Carousel00](self.impl), gboolean(allowScrollWheel))

proc adw_carousel_set_interactive(self: ptr Carousel00; interactive: gboolean) {.
    importc, libprag.}

proc setInteractive*(self: Carousel; interactive: bool = true) =
  adw_carousel_set_interactive(cast[ptr Carousel00](self.impl), gboolean(interactive))

proc `interactive=`*(self: Carousel; interactive: bool) =
  adw_carousel_set_interactive(cast[ptr Carousel00](self.impl), gboolean(interactive))

proc adw_carousel_set_reveal_duration(self: ptr Carousel00; revealDuration: uint32) {.
    importc, libprag.}

proc setRevealDuration*(self: Carousel; revealDuration: int) =
  adw_carousel_set_reveal_duration(cast[ptr Carousel00](self.impl), uint32(revealDuration))

proc `revealDuration=`*(self: Carousel; revealDuration: int) =
  adw_carousel_set_reveal_duration(cast[ptr Carousel00](self.impl), uint32(revealDuration))

proc adw_carousel_set_spacing(self: ptr Carousel00; spacing: uint32) {.
    importc, libprag.}

proc setSpacing*(self: Carousel; spacing: int) =
  adw_carousel_set_spacing(cast[ptr Carousel00](self.impl), uint32(spacing))

proc `spacing=`*(self: Carousel; spacing: int) =
  adw_carousel_set_spacing(cast[ptr Carousel00](self.impl), uint32(spacing))

type
  SpringParams00* {.pure.} = object
  SpringParams* = ref object
    impl*: ptr SpringParams00
    ignoreFinalizer*: bool

proc adw_spring_params_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeAdwSpringParams*(self: SpringParams) =
  if not self.ignoreFinalizer:
    boxedFree(adw_spring_params_get_type(), cast[ptr SpringParams00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SpringParams()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(adw_spring_params_get_type(), cast[ptr SpringParams00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SpringParams) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeAdwSpringParams)

proc adw_spring_params_unref(self: ptr SpringParams00) {.
    importc, libprag.}

proc unref*(self: SpringParams) =
  adw_spring_params_unref(cast[ptr SpringParams00](self.impl))

proc finalizerunref*(self: SpringParams) =
  if not self.ignoreFinalizer:
    adw_spring_params_unref(cast[ptr SpringParams00](self.impl))

proc adw_spring_params_new_full(damping: cdouble; mass: cdouble; stiffness: cdouble): ptr SpringParams00 {.
    importc, libprag.}

proc newSpringParamsFull*(damping: cdouble; mass: cdouble; stiffness: cdouble): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_spring_params_new_full(damping, mass, stiffness)

proc newSpringParamsFull*(tdesc: typedesc; damping: cdouble; mass: cdouble; stiffness: cdouble): tdesc =
  assert(result is SpringParams)
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_spring_params_new_full(damping, mass, stiffness)

proc initSpringParamsFull*[T](result: var T; damping: cdouble; mass: cdouble; stiffness: cdouble) {.deprecated.} =
  assert(result is SpringParams)
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_spring_params_new_full(damping, mass, stiffness)

proc adw_spring_params_get_damping(self: ptr SpringParams00): cdouble {.
    importc, libprag.}

proc getDamping*(self: SpringParams): cdouble =
  adw_spring_params_get_damping(cast[ptr SpringParams00](self.impl))

proc damping*(self: SpringParams): cdouble =
  adw_spring_params_get_damping(cast[ptr SpringParams00](self.impl))

proc adw_spring_params_get_damping_ratio(self: ptr SpringParams00): cdouble {.
    importc, libprag.}

proc getDampingRatio*(self: SpringParams): cdouble =
  adw_spring_params_get_damping_ratio(cast[ptr SpringParams00](self.impl))

proc dampingRatio*(self: SpringParams): cdouble =
  adw_spring_params_get_damping_ratio(cast[ptr SpringParams00](self.impl))

proc adw_spring_params_get_mass(self: ptr SpringParams00): cdouble {.
    importc, libprag.}

proc getMass*(self: SpringParams): cdouble =
  adw_spring_params_get_mass(cast[ptr SpringParams00](self.impl))

proc mass*(self: SpringParams): cdouble =
  adw_spring_params_get_mass(cast[ptr SpringParams00](self.impl))

proc adw_spring_params_get_stiffness(self: ptr SpringParams00): cdouble {.
    importc, libprag.}

proc getStiffness*(self: SpringParams): cdouble =
  adw_spring_params_get_stiffness(cast[ptr SpringParams00](self.impl))

proc stiffness*(self: SpringParams): cdouble =
  adw_spring_params_get_stiffness(cast[ptr SpringParams00](self.impl))

proc adw_spring_params_ref(self: ptr SpringParams00): ptr SpringParams00 {.
    importc, libprag.}

proc `ref`*(self: SpringParams): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_spring_params_ref(cast[ptr SpringParams00](self.impl))

proc adw_spring_params_new(dampingRatio: cdouble; mass: cdouble; stiffness: cdouble): ptr SpringParams00 {.
    importc, libprag.}

proc newSpringParams*(dampingRatio: cdouble; mass: cdouble; stiffness: cdouble): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_spring_params_new(dampingRatio, mass, stiffness)

proc newSpringParams*(tdesc: typedesc; dampingRatio: cdouble; mass: cdouble; stiffness: cdouble): tdesc =
  assert(result is SpringParams)
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_spring_params_new(dampingRatio, mass, stiffness)

proc initSpringParams*[T](result: var T; dampingRatio: cdouble; mass: cdouble; stiffness: cdouble) {.deprecated.} =
  assert(result is SpringParams)
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_spring_params_new(dampingRatio, mass, stiffness)

proc adw_carousel_get_scroll_params(self: ptr Carousel00): ptr SpringParams00 {.
    importc, libprag.}

proc getScrollParams*(self: Carousel): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_carousel_get_scroll_params(cast[ptr Carousel00](self.impl))

proc scrollParams*(self: Carousel): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_carousel_get_scroll_params(cast[ptr Carousel00](self.impl))

proc adw_carousel_set_scroll_params(self: ptr Carousel00; params: ptr SpringParams00) {.
    importc, libprag.}

proc setScrollParams*(self: Carousel; params: SpringParams) =
  adw_carousel_set_scroll_params(cast[ptr Carousel00](self.impl), cast[ptr SpringParams00](params.impl))

proc `scrollParams=`*(self: Carousel; params: SpringParams) =
  adw_carousel_set_scroll_params(cast[ptr Carousel00](self.impl), cast[ptr SpringParams00](params.impl))

type
  CarouselIndicatorDots* = ref object of gtk4.Widget
  CarouselIndicatorDots00* = object of gtk4.Widget00

proc adw_carousel_indicator_dots_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CarouselIndicatorDots()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_carousel_indicator_dots_new(): ptr CarouselIndicatorDots00 {.
    importc, libprag.}

proc newCarouselIndicatorDots*(): CarouselIndicatorDots =
  let gobj = adw_carousel_indicator_dots_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCarouselIndicatorDots*(tdesc: typedesc): tdesc =
  assert(result is CarouselIndicatorDots)
  let gobj = adw_carousel_indicator_dots_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCarouselIndicatorDots*[T](result: var T) {.deprecated.} =
  assert(result is CarouselIndicatorDots)
  let gobj = adw_carousel_indicator_dots_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_carousel_indicator_dots_get_carousel(self: ptr CarouselIndicatorDots00): ptr Carousel00 {.
    importc, libprag.}

proc getCarousel*(self: CarouselIndicatorDots): Carousel =
  let gobj = adw_carousel_indicator_dots_get_carousel(cast[ptr CarouselIndicatorDots00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc carousel*(self: CarouselIndicatorDots): Carousel =
  let gobj = adw_carousel_indicator_dots_get_carousel(cast[ptr CarouselIndicatorDots00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_carousel_indicator_dots_set_carousel(self: ptr CarouselIndicatorDots00;
    carousel: ptr Carousel00) {.
    importc, libprag.}

proc setCarousel*(self: CarouselIndicatorDots;
    carousel: Carousel = nil) =
  adw_carousel_indicator_dots_set_carousel(cast[ptr CarouselIndicatorDots00](self.impl), if carousel.isNil: nil else: cast[ptr Carousel00](carousel.impl))

proc `carousel=`*(self: CarouselIndicatorDots;
    carousel: Carousel = nil) =
  adw_carousel_indicator_dots_set_carousel(cast[ptr CarouselIndicatorDots00](self.impl), if carousel.isNil: nil else: cast[ptr Carousel00](carousel.impl))

type
  CarouselIndicatorLines* = ref object of gtk4.Widget
  CarouselIndicatorLines00* = object of gtk4.Widget00

proc adw_carousel_indicator_lines_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CarouselIndicatorLines()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_carousel_indicator_lines_new(): ptr CarouselIndicatorLines00 {.
    importc, libprag.}

proc newCarouselIndicatorLines*(): CarouselIndicatorLines =
  let gobj = adw_carousel_indicator_lines_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCarouselIndicatorLines*(tdesc: typedesc): tdesc =
  assert(result is CarouselIndicatorLines)
  let gobj = adw_carousel_indicator_lines_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCarouselIndicatorLines*[T](result: var T) {.deprecated.} =
  assert(result is CarouselIndicatorLines)
  let gobj = adw_carousel_indicator_lines_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_carousel_indicator_lines_get_carousel(self: ptr CarouselIndicatorLines00): ptr Carousel00 {.
    importc, libprag.}

proc getCarousel*(self: CarouselIndicatorLines): Carousel =
  let gobj = adw_carousel_indicator_lines_get_carousel(cast[ptr CarouselIndicatorLines00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc carousel*(self: CarouselIndicatorLines): Carousel =
  let gobj = adw_carousel_indicator_lines_get_carousel(cast[ptr CarouselIndicatorLines00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_carousel_indicator_lines_set_carousel(self: ptr CarouselIndicatorLines00;
    carousel: ptr Carousel00) {.
    importc, libprag.}

proc setCarousel*(self: CarouselIndicatorLines;
    carousel: Carousel = nil) =
  adw_carousel_indicator_lines_set_carousel(cast[ptr CarouselIndicatorLines00](self.impl), if carousel.isNil: nil else: cast[ptr Carousel00](carousel.impl))

proc `carousel=`*(self: CarouselIndicatorLines;
    carousel: Carousel = nil) =
  adw_carousel_indicator_lines_set_carousel(cast[ptr CarouselIndicatorLines00](self.impl), if carousel.isNil: nil else: cast[ptr Carousel00](carousel.impl))

type
  CenteringPolicy* {.size: sizeof(cint), pure.} = enum
    loose = 0
    strict = 1

type
  Clamp* = ref object of gtk4.Widget
  Clamp00* = object of gtk4.Widget00

proc adw_clamp_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Clamp()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_clamp_new(): ptr Clamp00 {.
    importc, libprag.}

proc newClamp*(): Clamp =
  let gobj = adw_clamp_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newClamp*(tdesc: typedesc): tdesc =
  assert(result is Clamp)
  let gobj = adw_clamp_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initClamp*[T](result: var T) {.deprecated.} =
  assert(result is Clamp)
  let gobj = adw_clamp_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_clamp_get_child(self: ptr Clamp00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: Clamp): gtk4.Widget =
  let gobj = adw_clamp_get_child(cast[ptr Clamp00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: Clamp): gtk4.Widget =
  let gobj = adw_clamp_get_child(cast[ptr Clamp00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_clamp_get_maximum_size(self: ptr Clamp00): int32 {.
    importc, libprag.}

proc getMaximumSize*(self: Clamp): int =
  int(adw_clamp_get_maximum_size(cast[ptr Clamp00](self.impl)))

proc maximumSize*(self: Clamp): int =
  int(adw_clamp_get_maximum_size(cast[ptr Clamp00](self.impl)))

proc adw_clamp_get_tightening_threshold(self: ptr Clamp00): int32 {.
    importc, libprag.}

proc getTighteningThreshold*(self: Clamp): int =
  int(adw_clamp_get_tightening_threshold(cast[ptr Clamp00](self.impl)))

proc tighteningThreshold*(self: Clamp): int =
  int(adw_clamp_get_tightening_threshold(cast[ptr Clamp00](self.impl)))

proc adw_clamp_get_unit(self: ptr Clamp00): LengthUnit {.
    importc, libprag.}

proc getUnit*(self: Clamp): LengthUnit =
  adw_clamp_get_unit(cast[ptr Clamp00](self.impl))

proc unit*(self: Clamp): LengthUnit =
  adw_clamp_get_unit(cast[ptr Clamp00](self.impl))

proc adw_clamp_set_child(self: ptr Clamp00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setChild*(self: Clamp; child: gtk4.Widget = nil) =
  adw_clamp_set_child(cast[ptr Clamp00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `child=`*(self: Clamp; child: gtk4.Widget = nil) =
  adw_clamp_set_child(cast[ptr Clamp00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc adw_clamp_set_maximum_size(self: ptr Clamp00; maximumSize: int32) {.
    importc, libprag.}

proc setMaximumSize*(self: Clamp; maximumSize: int) =
  adw_clamp_set_maximum_size(cast[ptr Clamp00](self.impl), int32(maximumSize))

proc `maximumSize=`*(self: Clamp; maximumSize: int) =
  adw_clamp_set_maximum_size(cast[ptr Clamp00](self.impl), int32(maximumSize))

proc adw_clamp_set_tightening_threshold(self: ptr Clamp00; tighteningThreshold: int32) {.
    importc, libprag.}

proc setTighteningThreshold*(self: Clamp; tighteningThreshold: int) =
  adw_clamp_set_tightening_threshold(cast[ptr Clamp00](self.impl), int32(tighteningThreshold))

proc `tighteningThreshold=`*(self: Clamp; tighteningThreshold: int) =
  adw_clamp_set_tightening_threshold(cast[ptr Clamp00](self.impl), int32(tighteningThreshold))

proc adw_clamp_set_unit(self: ptr Clamp00; unit: LengthUnit) {.
    importc, libprag.}

proc setUnit*(self: Clamp; unit: LengthUnit) =
  adw_clamp_set_unit(cast[ptr Clamp00](self.impl), unit)

proc `unit=`*(self: Clamp; unit: LengthUnit) =
  adw_clamp_set_unit(cast[ptr Clamp00](self.impl), unit)

type
  ClampLayout* = ref object of gtk4.LayoutManager
  ClampLayout00* = object of gtk4.LayoutManager00

proc adw_clamp_layout_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ClampLayout()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_clamp_layout_new(): ptr ClampLayout00 {.
    importc, libprag.}

proc newClampLayout*(): ClampLayout =
  let gobj = adw_clamp_layout_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newClampLayout*(tdesc: typedesc): tdesc =
  assert(result is ClampLayout)
  let gobj = adw_clamp_layout_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initClampLayout*[T](result: var T) {.deprecated.} =
  assert(result is ClampLayout)
  let gobj = adw_clamp_layout_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_clamp_layout_get_maximum_size(self: ptr ClampLayout00): int32 {.
    importc, libprag.}

proc getMaximumSize*(self: ClampLayout): int =
  int(adw_clamp_layout_get_maximum_size(cast[ptr ClampLayout00](self.impl)))

proc maximumSize*(self: ClampLayout): int =
  int(adw_clamp_layout_get_maximum_size(cast[ptr ClampLayout00](self.impl)))

proc adw_clamp_layout_get_tightening_threshold(self: ptr ClampLayout00): int32 {.
    importc, libprag.}

proc getTighteningThreshold*(self: ClampLayout): int =
  int(adw_clamp_layout_get_tightening_threshold(cast[ptr ClampLayout00](self.impl)))

proc tighteningThreshold*(self: ClampLayout): int =
  int(adw_clamp_layout_get_tightening_threshold(cast[ptr ClampLayout00](self.impl)))

proc adw_clamp_layout_get_unit(self: ptr ClampLayout00): LengthUnit {.
    importc, libprag.}

proc getUnit*(self: ClampLayout): LengthUnit =
  adw_clamp_layout_get_unit(cast[ptr ClampLayout00](self.impl))

proc unit*(self: ClampLayout): LengthUnit =
  adw_clamp_layout_get_unit(cast[ptr ClampLayout00](self.impl))

proc adw_clamp_layout_set_maximum_size(self: ptr ClampLayout00; maximumSize: int32) {.
    importc, libprag.}

proc setMaximumSize*(self: ClampLayout; maximumSize: int) =
  adw_clamp_layout_set_maximum_size(cast[ptr ClampLayout00](self.impl), int32(maximumSize))

proc `maximumSize=`*(self: ClampLayout; maximumSize: int) =
  adw_clamp_layout_set_maximum_size(cast[ptr ClampLayout00](self.impl), int32(maximumSize))

proc adw_clamp_layout_set_tightening_threshold(self: ptr ClampLayout00; tighteningThreshold: int32) {.
    importc, libprag.}

proc setTighteningThreshold*(self: ClampLayout; tighteningThreshold: int) =
  adw_clamp_layout_set_tightening_threshold(cast[ptr ClampLayout00](self.impl), int32(tighteningThreshold))

proc `tighteningThreshold=`*(self: ClampLayout; tighteningThreshold: int) =
  adw_clamp_layout_set_tightening_threshold(cast[ptr ClampLayout00](self.impl), int32(tighteningThreshold))

proc adw_clamp_layout_set_unit(self: ptr ClampLayout00; unit: LengthUnit) {.
    importc, libprag.}

proc setUnit*(self: ClampLayout; unit: LengthUnit) =
  adw_clamp_layout_set_unit(cast[ptr ClampLayout00](self.impl), unit)

proc `unit=`*(self: ClampLayout; unit: LengthUnit) =
  adw_clamp_layout_set_unit(cast[ptr ClampLayout00](self.impl), unit)

type
  ClampScrollable* = ref object of gtk4.Widget
  ClampScrollable00* = object of gtk4.Widget00

proc adw_clamp_scrollable_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ClampScrollable()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_clamp_scrollable_new(): ptr ClampScrollable00 {.
    importc, libprag.}

proc newClampScrollable*(): ClampScrollable =
  let gobj = adw_clamp_scrollable_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newClampScrollable*(tdesc: typedesc): tdesc =
  assert(result is ClampScrollable)
  let gobj = adw_clamp_scrollable_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initClampScrollable*[T](result: var T) {.deprecated.} =
  assert(result is ClampScrollable)
  let gobj = adw_clamp_scrollable_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_clamp_scrollable_get_child(self: ptr ClampScrollable00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: ClampScrollable): gtk4.Widget =
  let gobj = adw_clamp_scrollable_get_child(cast[ptr ClampScrollable00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: ClampScrollable): gtk4.Widget =
  let gobj = adw_clamp_scrollable_get_child(cast[ptr ClampScrollable00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_clamp_scrollable_get_maximum_size(self: ptr ClampScrollable00): int32 {.
    importc, libprag.}

proc getMaximumSize*(self: ClampScrollable): int =
  int(adw_clamp_scrollable_get_maximum_size(cast[ptr ClampScrollable00](self.impl)))

proc maximumSize*(self: ClampScrollable): int =
  int(adw_clamp_scrollable_get_maximum_size(cast[ptr ClampScrollable00](self.impl)))

proc adw_clamp_scrollable_get_tightening_threshold(self: ptr ClampScrollable00): int32 {.
    importc, libprag.}

proc getTighteningThreshold*(self: ClampScrollable): int =
  int(adw_clamp_scrollable_get_tightening_threshold(cast[ptr ClampScrollable00](self.impl)))

proc tighteningThreshold*(self: ClampScrollable): int =
  int(adw_clamp_scrollable_get_tightening_threshold(cast[ptr ClampScrollable00](self.impl)))

proc adw_clamp_scrollable_get_unit(self: ptr ClampScrollable00): LengthUnit {.
    importc, libprag.}

proc getUnit*(self: ClampScrollable): LengthUnit =
  adw_clamp_scrollable_get_unit(cast[ptr ClampScrollable00](self.impl))

proc unit*(self: ClampScrollable): LengthUnit =
  adw_clamp_scrollable_get_unit(cast[ptr ClampScrollable00](self.impl))

proc adw_clamp_scrollable_set_child(self: ptr ClampScrollable00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setChild*(self: ClampScrollable; child: gtk4.Widget = nil) =
  adw_clamp_scrollable_set_child(cast[ptr ClampScrollable00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `child=`*(self: ClampScrollable; child: gtk4.Widget = nil) =
  adw_clamp_scrollable_set_child(cast[ptr ClampScrollable00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc adw_clamp_scrollable_set_maximum_size(self: ptr ClampScrollable00; maximumSize: int32) {.
    importc, libprag.}

proc setMaximumSize*(self: ClampScrollable; maximumSize: int) =
  adw_clamp_scrollable_set_maximum_size(cast[ptr ClampScrollable00](self.impl), int32(maximumSize))

proc `maximumSize=`*(self: ClampScrollable; maximumSize: int) =
  adw_clamp_scrollable_set_maximum_size(cast[ptr ClampScrollable00](self.impl), int32(maximumSize))

proc adw_clamp_scrollable_set_tightening_threshold(self: ptr ClampScrollable00;
    tighteningThreshold: int32) {.
    importc, libprag.}

proc setTighteningThreshold*(self: ClampScrollable;
    tighteningThreshold: int) =
  adw_clamp_scrollable_set_tightening_threshold(cast[ptr ClampScrollable00](self.impl), int32(tighteningThreshold))

proc `tighteningThreshold=`*(self: ClampScrollable;
    tighteningThreshold: int) =
  adw_clamp_scrollable_set_tightening_threshold(cast[ptr ClampScrollable00](self.impl), int32(tighteningThreshold))

proc adw_clamp_scrollable_set_unit(self: ptr ClampScrollable00; unit: LengthUnit) {.
    importc, libprag.}

proc setUnit*(self: ClampScrollable; unit: LengthUnit) =
  adw_clamp_scrollable_set_unit(cast[ptr ClampScrollable00](self.impl), unit)

proc `unit=`*(self: ClampScrollable; unit: LengthUnit) =
  adw_clamp_scrollable_set_unit(cast[ptr ClampScrollable00](self.impl), unit)

type
  ComboRow* = ref object of ActionRow
  ComboRow00* = object of ActionRow00

proc adw_combo_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ComboRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_combo_row_new(): ptr ComboRow00 {.
    importc, libprag.}

proc newComboRow*(): ComboRow =
  let gobj = adw_combo_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newComboRow*(tdesc: typedesc): tdesc =
  assert(result is ComboRow)
  let gobj = adw_combo_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initComboRow*[T](result: var T) {.deprecated.} =
  assert(result is ComboRow)
  let gobj = adw_combo_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_combo_row_get_enable_search(self: ptr ComboRow00): gboolean {.
    importc, libprag.}

proc getEnableSearch*(self: ComboRow): bool =
  toBool(adw_combo_row_get_enable_search(cast[ptr ComboRow00](self.impl)))

proc enableSearch*(self: ComboRow): bool =
  toBool(adw_combo_row_get_enable_search(cast[ptr ComboRow00](self.impl)))

proc adw_combo_row_get_expression(self: ptr ComboRow00): ptr gtk4.Expression00 {.
    importc, libprag.}

proc getExpression*(self: ComboRow): gtk4.Expression =
  let impl0 = adw_combo_row_get_expression(cast[ptr ComboRow00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, generic_gtk_expression_unref)
  result.impl = cast[typeof(result.impl)](gtk_expression_ref(impl0))

proc expression*(self: ComboRow): gtk4.Expression =
  let impl0 = adw_combo_row_get_expression(cast[ptr ComboRow00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, generic_gtk_expression_unref)
  result.impl = cast[typeof(result.impl)](gtk_expression_ref(impl0))

proc adw_combo_row_get_factory(self: ptr ComboRow00): ptr gtk4.ListItemFactory00 {.
    importc, libprag.}

proc getFactory*(self: ComboRow): gtk4.ListItemFactory =
  let gobj = adw_combo_row_get_factory(cast[ptr ComboRow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc factory*(self: ComboRow): gtk4.ListItemFactory =
  let gobj = adw_combo_row_get_factory(cast[ptr ComboRow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_combo_row_get_list_factory(self: ptr ComboRow00): ptr gtk4.ListItemFactory00 {.
    importc, libprag.}

proc getListFactory*(self: ComboRow): gtk4.ListItemFactory =
  let gobj = adw_combo_row_get_list_factory(cast[ptr ComboRow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc listFactory*(self: ComboRow): gtk4.ListItemFactory =
  let gobj = adw_combo_row_get_list_factory(cast[ptr ComboRow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_combo_row_get_model(self: ptr ComboRow00): ptr gio.ListModel00 {.
    importc, libprag.}

proc getModel*(self: ComboRow): gio.ListModel =
  let gobj = adw_combo_row_get_model(cast[ptr ComboRow00](self.impl))
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
  let gobj = adw_combo_row_get_model(cast[ptr ComboRow00](self.impl))
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

proc adw_combo_row_get_selected(self: ptr ComboRow00): uint32 {.
    importc, libprag.}

proc getSelected*(self: ComboRow): int =
  int(adw_combo_row_get_selected(cast[ptr ComboRow00](self.impl)))

proc selected*(self: ComboRow): int =
  int(adw_combo_row_get_selected(cast[ptr ComboRow00](self.impl)))

proc adw_combo_row_get_selected_item(self: ptr ComboRow00): ptr gobject.Object00 {.
    importc, libprag.}

proc getSelectedItem*(self: ComboRow): gobject.Object =
  let gobj = adw_combo_row_get_selected_item(cast[ptr ComboRow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc selectedItem*(self: ComboRow): gobject.Object =
  let gobj = adw_combo_row_get_selected_item(cast[ptr ComboRow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_combo_row_get_use_subtitle(self: ptr ComboRow00): gboolean {.
    importc, libprag.}

proc getUseSubtitle*(self: ComboRow): bool =
  toBool(adw_combo_row_get_use_subtitle(cast[ptr ComboRow00](self.impl)))

proc useSubtitle*(self: ComboRow): bool =
  toBool(adw_combo_row_get_use_subtitle(cast[ptr ComboRow00](self.impl)))

proc adw_combo_row_set_enable_search(self: ptr ComboRow00; enableSearch: gboolean) {.
    importc, libprag.}

proc setEnableSearch*(self: ComboRow; enableSearch: bool = true) =
  adw_combo_row_set_enable_search(cast[ptr ComboRow00](self.impl), gboolean(enableSearch))

proc `enableSearch=`*(self: ComboRow; enableSearch: bool) =
  adw_combo_row_set_enable_search(cast[ptr ComboRow00](self.impl), gboolean(enableSearch))

proc adw_combo_row_set_expression(self: ptr ComboRow00; expression: ptr gtk4.Expression00) {.
    importc, libprag.}

proc setExpression*(self: ComboRow; expression: gtk4.Expression = nil) =
  adw_combo_row_set_expression(cast[ptr ComboRow00](self.impl), if expression.isNil: nil else: cast[ptr gtk4.Expression00](expression.impl))

proc `expression=`*(self: ComboRow; expression: gtk4.Expression = nil) =
  adw_combo_row_set_expression(cast[ptr ComboRow00](self.impl), if expression.isNil: nil else: cast[ptr gtk4.Expression00](expression.impl))

proc adw_combo_row_set_factory(self: ptr ComboRow00; factory: ptr gtk4.ListItemFactory00) {.
    importc, libprag.}

proc setFactory*(self: ComboRow; factory: gtk4.ListItemFactory = nil) =
  adw_combo_row_set_factory(cast[ptr ComboRow00](self.impl), if factory.isNil: nil else: cast[ptr gtk4.ListItemFactory00](factory.impl))

proc `factory=`*(self: ComboRow; factory: gtk4.ListItemFactory = nil) =
  adw_combo_row_set_factory(cast[ptr ComboRow00](self.impl), if factory.isNil: nil else: cast[ptr gtk4.ListItemFactory00](factory.impl))

proc adw_combo_row_set_list_factory(self: ptr ComboRow00; factory: ptr gtk4.ListItemFactory00) {.
    importc, libprag.}

proc setListFactory*(self: ComboRow; factory: gtk4.ListItemFactory = nil) =
  adw_combo_row_set_list_factory(cast[ptr ComboRow00](self.impl), if factory.isNil: nil else: cast[ptr gtk4.ListItemFactory00](factory.impl))

proc `listFactory=`*(self: ComboRow; factory: gtk4.ListItemFactory = nil) =
  adw_combo_row_set_list_factory(cast[ptr ComboRow00](self.impl), if factory.isNil: nil else: cast[ptr gtk4.ListItemFactory00](factory.impl))

proc adw_combo_row_set_model(self: ptr ComboRow00; model: ptr gio.ListModel00) {.
    importc, libprag.}

proc setModel*(self: ComboRow; model: gio.ListModel = nil) =
  adw_combo_row_set_model(cast[ptr ComboRow00](self.impl), if model.isNil: nil else: cast[ptr gio.ListModel00](model.impl))

proc `model=`*(self: ComboRow; model: gio.ListModel = nil) =
  adw_combo_row_set_model(cast[ptr ComboRow00](self.impl), if model.isNil: nil else: cast[ptr gio.ListModel00](model.impl))

proc adw_combo_row_set_selected(self: ptr ComboRow00; position: uint32) {.
    importc, libprag.}

proc setSelected*(self: ComboRow; position: int) =
  adw_combo_row_set_selected(cast[ptr ComboRow00](self.impl), uint32(position))

proc `selected=`*(self: ComboRow; position: int) =
  adw_combo_row_set_selected(cast[ptr ComboRow00](self.impl), uint32(position))

proc adw_combo_row_set_use_subtitle(self: ptr ComboRow00; useSubtitle: gboolean) {.
    importc, libprag.}

proc setUseSubtitle*(self: ComboRow; useSubtitle: bool = true) =
  adw_combo_row_set_use_subtitle(cast[ptr ComboRow00](self.impl), gboolean(useSubtitle))

proc `useSubtitle=`*(self: ComboRow; useSubtitle: bool) =
  adw_combo_row_set_use_subtitle(cast[ptr ComboRow00](self.impl), gboolean(useSubtitle))

const DURATION_INFINITE* = 4294967295'u32

type
  Easing* {.size: sizeof(cint), pure.} = enum
    linear = 0
    easeInQuad = 1
    easeOutQuad = 2
    easeInOutQuad = 3
    easeInCubic = 4
    easeOutCubic = 5
    easeInOutCubic = 6
    easeInQuart = 7
    easeOutQuart = 8
    easeInOutQuart = 9
    easeInQuint = 10
    easeOutQuint = 11
    easeInOutQuint = 12
    easeInSine = 13
    easeOutSine = 14
    easeInOutSine = 15
    easeInExpo = 16
    easeOutExpo = 17
    easeInOutExpo = 18
    easeInCirc = 19
    easeOutCirc = 20
    easeInOutCirc = 21
    easeInElastic = 22
    easeOutElastic = 23
    easeInOutElastic = 24
    easeInBack = 25
    easeOutBack = 26
    easeInOutBack = 27
    easeInBounce = 28
    easeOutBounce = 29
    easeInOutBounce = 30

proc ease*(self: Easing; value: cdouble): cdouble {.
    importc: "adw_easing_ease", libprag.}

type
  EntryRow* = ref object of PreferencesRow
  EntryRow00* = object of PreferencesRow00

proc adw_entry_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EntryRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scApply*(self: EntryRow;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "apply", cast[GCallback](p), xdata, nil, cf)

proc scEntryActivated*(self: EntryRow;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "entry-activated", cast[GCallback](p), xdata, nil, cf)

proc adw_entry_row_new(): ptr EntryRow00 {.
    importc, libprag.}

proc newEntryRow*(): EntryRow =
  let gobj = adw_entry_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newEntryRow*(tdesc: typedesc): tdesc =
  assert(result is EntryRow)
  let gobj = adw_entry_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initEntryRow*[T](result: var T) {.deprecated.} =
  assert(result is EntryRow)
  let gobj = adw_entry_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_entry_row_add_prefix(self: ptr EntryRow00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc addPrefix*(self: EntryRow; widget: gtk4.Widget) =
  adw_entry_row_add_prefix(cast[ptr EntryRow00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_entry_row_add_suffix(self: ptr EntryRow00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc addSuffix*(self: EntryRow; widget: gtk4.Widget) =
  adw_entry_row_add_suffix(cast[ptr EntryRow00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_entry_row_get_activates_default(self: ptr EntryRow00): gboolean {.
    importc, libprag.}

proc getActivatesDefault*(self: EntryRow): bool =
  toBool(adw_entry_row_get_activates_default(cast[ptr EntryRow00](self.impl)))

proc activatesDefault*(self: EntryRow): bool =
  toBool(adw_entry_row_get_activates_default(cast[ptr EntryRow00](self.impl)))

proc adw_entry_row_get_attributes(self: ptr EntryRow00): ptr pango.AttrList00 {.
    importc, libprag.}

proc getAttributes*(self: EntryRow): pango.AttrList =
  let impl0 = adw_entry_row_get_attributes(cast[ptr EntryRow00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = impl0

proc attributes*(self: EntryRow): pango.AttrList =
  let impl0 = adw_entry_row_get_attributes(cast[ptr EntryRow00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = impl0

proc adw_entry_row_get_enable_emoji_completion(self: ptr EntryRow00): gboolean {.
    importc, libprag.}

proc getEnableEmojiCompletion*(self: EntryRow): bool =
  toBool(adw_entry_row_get_enable_emoji_completion(cast[ptr EntryRow00](self.impl)))

proc enableEmojiCompletion*(self: EntryRow): bool =
  toBool(adw_entry_row_get_enable_emoji_completion(cast[ptr EntryRow00](self.impl)))

proc adw_entry_row_get_input_hints(self: ptr EntryRow00): gtk4.InputHints {.
    importc, libprag.}

proc getInputHints*(self: EntryRow): gtk4.InputHints =
  adw_entry_row_get_input_hints(cast[ptr EntryRow00](self.impl))

proc inputHints*(self: EntryRow): gtk4.InputHints =
  adw_entry_row_get_input_hints(cast[ptr EntryRow00](self.impl))

proc adw_entry_row_get_input_purpose(self: ptr EntryRow00): gtk4.InputPurpose {.
    importc, libprag.}

proc getInputPurpose*(self: EntryRow): gtk4.InputPurpose =
  adw_entry_row_get_input_purpose(cast[ptr EntryRow00](self.impl))

proc inputPurpose*(self: EntryRow): gtk4.InputPurpose =
  adw_entry_row_get_input_purpose(cast[ptr EntryRow00](self.impl))

proc adw_entry_row_get_show_apply_button(self: ptr EntryRow00): gboolean {.
    importc, libprag.}

proc getShowApplyButton*(self: EntryRow): bool =
  toBool(adw_entry_row_get_show_apply_button(cast[ptr EntryRow00](self.impl)))

proc showApplyButton*(self: EntryRow): bool =
  toBool(adw_entry_row_get_show_apply_button(cast[ptr EntryRow00](self.impl)))

proc adw_entry_row_get_text_length(self: ptr EntryRow00): uint32 {.
    importc, libprag.}

proc getTextLength*(self: EntryRow): int =
  int(adw_entry_row_get_text_length(cast[ptr EntryRow00](self.impl)))

proc textLength*(self: EntryRow): int =
  int(adw_entry_row_get_text_length(cast[ptr EntryRow00](self.impl)))

proc adw_entry_row_grab_focus_without_selecting(self: ptr EntryRow00): gboolean {.
    importc, libprag.}

proc grabFocusWithoutSelecting*(self: EntryRow): bool =
  toBool(adw_entry_row_grab_focus_without_selecting(cast[ptr EntryRow00](self.impl)))

proc adw_entry_row_remove(self: ptr EntryRow00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: EntryRow; widget: gtk4.Widget) =
  adw_entry_row_remove(cast[ptr EntryRow00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_entry_row_set_activates_default(self: ptr EntryRow00; activates: gboolean) {.
    importc, libprag.}

proc setActivatesDefault*(self: EntryRow; activates: bool = true) =
  adw_entry_row_set_activates_default(cast[ptr EntryRow00](self.impl), gboolean(activates))

proc `activatesDefault=`*(self: EntryRow; activates: bool) =
  adw_entry_row_set_activates_default(cast[ptr EntryRow00](self.impl), gboolean(activates))

proc adw_entry_row_set_attributes(self: ptr EntryRow00; attributes: ptr pango.AttrList00) {.
    importc, libprag.}

proc setAttributes*(self: EntryRow; attributes: pango.AttrList = nil) =
  adw_entry_row_set_attributes(cast[ptr EntryRow00](self.impl), if attributes.isNil: nil else: cast[ptr pango.AttrList00](attributes.impl))

proc `attributes=`*(self: EntryRow; attributes: pango.AttrList = nil) =
  adw_entry_row_set_attributes(cast[ptr EntryRow00](self.impl), if attributes.isNil: nil else: cast[ptr pango.AttrList00](attributes.impl))

proc adw_entry_row_set_enable_emoji_completion(self: ptr EntryRow00; enableEmojiCompletion: gboolean) {.
    importc, libprag.}

proc setEnableEmojiCompletion*(self: EntryRow; enableEmojiCompletion: bool = true) =
  adw_entry_row_set_enable_emoji_completion(cast[ptr EntryRow00](self.impl), gboolean(enableEmojiCompletion))

proc `enableEmojiCompletion=`*(self: EntryRow; enableEmojiCompletion: bool) =
  adw_entry_row_set_enable_emoji_completion(cast[ptr EntryRow00](self.impl), gboolean(enableEmojiCompletion))

proc adw_entry_row_set_input_hints(self: ptr EntryRow00; hints: gtk4.InputHints) {.
    importc, libprag.}

proc setInputHints*(self: EntryRow; hints: gtk4.InputHints) =
  adw_entry_row_set_input_hints(cast[ptr EntryRow00](self.impl), hints)

proc `inputHints=`*(self: EntryRow; hints: gtk4.InputHints) =
  adw_entry_row_set_input_hints(cast[ptr EntryRow00](self.impl), hints)

proc adw_entry_row_set_input_purpose(self: ptr EntryRow00; purpose: gtk4.InputPurpose) {.
    importc, libprag.}

proc setInputPurpose*(self: EntryRow; purpose: gtk4.InputPurpose) =
  adw_entry_row_set_input_purpose(cast[ptr EntryRow00](self.impl), purpose)

proc `inputPurpose=`*(self: EntryRow; purpose: gtk4.InputPurpose) =
  adw_entry_row_set_input_purpose(cast[ptr EntryRow00](self.impl), purpose)

proc adw_entry_row_set_show_apply_button(self: ptr EntryRow00; showApplyButton: gboolean) {.
    importc, libprag.}

proc setShowApplyButton*(self: EntryRow; showApplyButton: bool = true) =
  adw_entry_row_set_show_apply_button(cast[ptr EntryRow00](self.impl), gboolean(showApplyButton))

proc `showApplyButton=`*(self: EntryRow; showApplyButton: bool) =
  adw_entry_row_set_show_apply_button(cast[ptr EntryRow00](self.impl), gboolean(showApplyButton))

type
  EnumListItem* = ref object of gobject.Object
  EnumListItem00* = object of gobject.Object00

proc adw_enum_list_item_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EnumListItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_enum_list_item_get_name(self: ptr EnumListItem00): cstring {.
    importc, libprag.}

proc getName*(self: EnumListItem): string =
  result = $adw_enum_list_item_get_name(cast[ptr EnumListItem00](self.impl))

proc name*(self: EnumListItem): string =
  result = $adw_enum_list_item_get_name(cast[ptr EnumListItem00](self.impl))

proc adw_enum_list_item_get_nick(self: ptr EnumListItem00): cstring {.
    importc, libprag.}

proc getNick*(self: EnumListItem): string =
  result = $adw_enum_list_item_get_nick(cast[ptr EnumListItem00](self.impl))

proc nick*(self: EnumListItem): string =
  result = $adw_enum_list_item_get_nick(cast[ptr EnumListItem00](self.impl))

proc adw_enum_list_item_get_value(self: ptr EnumListItem00): int32 {.
    importc, libprag.}

proc getValue*(self: EnumListItem): int =
  int(adw_enum_list_item_get_value(cast[ptr EnumListItem00](self.impl)))

proc value*(self: EnumListItem): int =
  int(adw_enum_list_item_get_value(cast[ptr EnumListItem00](self.impl)))

type
  EnumListModel* = ref object of gobject.Object
  EnumListModel00* = object of gobject.Object00

proc adw_enum_list_model_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EnumListModel()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_enum_list_model_new(enumType: GType): ptr EnumListModel00 {.
    importc, libprag.}

proc newEnumListModel*(enumType: GType): EnumListModel =
  let gobj = adw_enum_list_model_new(enumType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newEnumListModel*(tdesc: typedesc; enumType: GType): tdesc =
  assert(result is EnumListModel)
  let gobj = adw_enum_list_model_new(enumType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initEnumListModel*[T](result: var T; enumType: GType) {.deprecated.} =
  assert(result is EnumListModel)
  let gobj = adw_enum_list_model_new(enumType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_enum_list_model_find_position(self: ptr EnumListModel00; value: int32): uint32 {.
    importc, libprag.}

proc findPosition*(self: EnumListModel; value: int): int =
  int(adw_enum_list_model_find_position(cast[ptr EnumListModel00](self.impl), int32(value)))

proc adw_enum_list_model_get_enum_type(self: ptr EnumListModel00): GType {.
    importc, libprag.}

proc getEnumType*(self: EnumListModel): GType =
  adw_enum_list_model_get_enum_type(cast[ptr EnumListModel00](self.impl))

proc enumType*(self: EnumListModel): GType =
  adw_enum_list_model_get_enum_type(cast[ptr EnumListModel00](self.impl))

type
  ExpanderRow* = ref object of PreferencesRow
  ExpanderRow00* = object of PreferencesRow00

proc adw_expander_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ExpanderRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_expander_row_new(): ptr ExpanderRow00 {.
    importc, libprag.}

proc newExpanderRow*(): ExpanderRow =
  let gobj = adw_expander_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newExpanderRow*(tdesc: typedesc): tdesc =
  assert(result is ExpanderRow)
  let gobj = adw_expander_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initExpanderRow*[T](result: var T) {.deprecated.} =
  assert(result is ExpanderRow)
  let gobj = adw_expander_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_expander_row_add_action(self: ptr ExpanderRow00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc addAction*(self: ExpanderRow; widget: gtk4.Widget) =
  adw_expander_row_add_action(cast[ptr ExpanderRow00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_expander_row_add_prefix(self: ptr ExpanderRow00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc addPrefix*(self: ExpanderRow; widget: gtk4.Widget) =
  adw_expander_row_add_prefix(cast[ptr ExpanderRow00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_expander_row_add_row(self: ptr ExpanderRow00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc addRow*(self: ExpanderRow; child: gtk4.Widget) =
  adw_expander_row_add_row(cast[ptr ExpanderRow00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_expander_row_add_suffix(self: ptr ExpanderRow00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc addSuffix*(self: ExpanderRow; widget: gtk4.Widget) =
  adw_expander_row_add_suffix(cast[ptr ExpanderRow00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_expander_row_get_enable_expansion(self: ptr ExpanderRow00): gboolean {.
    importc, libprag.}

proc getEnableExpansion*(self: ExpanderRow): bool =
  toBool(adw_expander_row_get_enable_expansion(cast[ptr ExpanderRow00](self.impl)))

proc enableExpansion*(self: ExpanderRow): bool =
  toBool(adw_expander_row_get_enable_expansion(cast[ptr ExpanderRow00](self.impl)))

proc adw_expander_row_get_expanded(self: ptr ExpanderRow00): gboolean {.
    importc, libprag.}

proc getExpanded*(self: ExpanderRow): bool =
  toBool(adw_expander_row_get_expanded(cast[ptr ExpanderRow00](self.impl)))

proc expanded*(self: ExpanderRow): bool =
  toBool(adw_expander_row_get_expanded(cast[ptr ExpanderRow00](self.impl)))

proc adw_expander_row_get_icon_name(self: ptr ExpanderRow00): cstring {.
    importc, libprag.}

proc getIconName*(self: ExpanderRow): string =
  let resul0 = adw_expander_row_get_icon_name(cast[ptr ExpanderRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: ExpanderRow): string =
  let resul0 = adw_expander_row_get_icon_name(cast[ptr ExpanderRow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_expander_row_get_show_enable_switch(self: ptr ExpanderRow00): gboolean {.
    importc, libprag.}

proc getShowEnableSwitch*(self: ExpanderRow): bool =
  toBool(adw_expander_row_get_show_enable_switch(cast[ptr ExpanderRow00](self.impl)))

proc showEnableSwitch*(self: ExpanderRow): bool =
  toBool(adw_expander_row_get_show_enable_switch(cast[ptr ExpanderRow00](self.impl)))

proc adw_expander_row_get_subtitle(self: ptr ExpanderRow00): cstring {.
    importc, libprag.}

proc getSubtitle*(self: ExpanderRow): string =
  result = $adw_expander_row_get_subtitle(cast[ptr ExpanderRow00](self.impl))

proc subtitle*(self: ExpanderRow): string =
  result = $adw_expander_row_get_subtitle(cast[ptr ExpanderRow00](self.impl))

proc adw_expander_row_get_subtitle_lines(self: ptr ExpanderRow00): gboolean {.
    importc, libprag.}

proc getSubtitleLines*(self: ExpanderRow): bool =
  toBool(adw_expander_row_get_subtitle_lines(cast[ptr ExpanderRow00](self.impl)))

proc subtitleLines*(self: ExpanderRow): bool =
  toBool(adw_expander_row_get_subtitle_lines(cast[ptr ExpanderRow00](self.impl)))

proc adw_expander_row_get_title_lines(self: ptr ExpanderRow00): gboolean {.
    importc, libprag.}

proc getTitleLines*(self: ExpanderRow): bool =
  toBool(adw_expander_row_get_title_lines(cast[ptr ExpanderRow00](self.impl)))

proc titleLines*(self: ExpanderRow): bool =
  toBool(adw_expander_row_get_title_lines(cast[ptr ExpanderRow00](self.impl)))

proc adw_expander_row_remove(self: ptr ExpanderRow00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: ExpanderRow; child: gtk4.Widget) =
  adw_expander_row_remove(cast[ptr ExpanderRow00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_expander_row_set_enable_expansion(self: ptr ExpanderRow00; enableExpansion: gboolean) {.
    importc, libprag.}

proc setEnableExpansion*(self: ExpanderRow; enableExpansion: bool = true) =
  adw_expander_row_set_enable_expansion(cast[ptr ExpanderRow00](self.impl), gboolean(enableExpansion))

proc `enableExpansion=`*(self: ExpanderRow; enableExpansion: bool) =
  adw_expander_row_set_enable_expansion(cast[ptr ExpanderRow00](self.impl), gboolean(enableExpansion))

proc adw_expander_row_set_expanded(self: ptr ExpanderRow00; expanded: gboolean) {.
    importc, libprag.}

proc setExpanded*(self: ExpanderRow; expanded: bool = true) =
  adw_expander_row_set_expanded(cast[ptr ExpanderRow00](self.impl), gboolean(expanded))

proc `expanded=`*(self: ExpanderRow; expanded: bool) =
  adw_expander_row_set_expanded(cast[ptr ExpanderRow00](self.impl), gboolean(expanded))

proc adw_expander_row_set_icon_name(self: ptr ExpanderRow00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: ExpanderRow; iconName: cstring = nil) =
  adw_expander_row_set_icon_name(cast[ptr ExpanderRow00](self.impl), iconName)

proc `iconName=`*(self: ExpanderRow; iconName: cstring = nil) =
  adw_expander_row_set_icon_name(cast[ptr ExpanderRow00](self.impl), iconName)

proc adw_expander_row_set_show_enable_switch(self: ptr ExpanderRow00; showEnableSwitch: gboolean) {.
    importc, libprag.}

proc setShowEnableSwitch*(self: ExpanderRow; showEnableSwitch: bool = true) =
  adw_expander_row_set_show_enable_switch(cast[ptr ExpanderRow00](self.impl), gboolean(showEnableSwitch))

proc `showEnableSwitch=`*(self: ExpanderRow; showEnableSwitch: bool) =
  adw_expander_row_set_show_enable_switch(cast[ptr ExpanderRow00](self.impl), gboolean(showEnableSwitch))

proc adw_expander_row_set_subtitle(self: ptr ExpanderRow00; subtitle: cstring) {.
    importc, libprag.}

proc setSubtitle*(self: ExpanderRow; subtitle: cstring) =
  adw_expander_row_set_subtitle(cast[ptr ExpanderRow00](self.impl), subtitle)

proc `subtitle=`*(self: ExpanderRow; subtitle: cstring) =
  adw_expander_row_set_subtitle(cast[ptr ExpanderRow00](self.impl), subtitle)

proc adw_expander_row_set_subtitle_lines(self: ptr ExpanderRow00; subtitleLines: int32) {.
    importc, libprag.}

proc setSubtitleLines*(self: ExpanderRow; subtitleLines: int) =
  adw_expander_row_set_subtitle_lines(cast[ptr ExpanderRow00](self.impl), int32(subtitleLines))

proc `subtitleLines=`*(self: ExpanderRow; subtitleLines: int) =
  adw_expander_row_set_subtitle_lines(cast[ptr ExpanderRow00](self.impl), int32(subtitleLines))

proc adw_expander_row_set_title_lines(self: ptr ExpanderRow00; titleLines: int32) {.
    importc, libprag.}

proc setTitleLines*(self: ExpanderRow; titleLines: int) =
  adw_expander_row_set_title_lines(cast[ptr ExpanderRow00](self.impl), int32(titleLines))

proc `titleLines=`*(self: ExpanderRow; titleLines: int) =
  adw_expander_row_set_title_lines(cast[ptr ExpanderRow00](self.impl), int32(titleLines))

type
  Flap* = ref object of gtk4.Widget
  Flap00* = object of gtk4.Widget00

proc adw_flap_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Flap()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_flap_new(): ptr Flap00 {.
    importc, libprag.}

proc newFlap*(): Flap {.deprecated.}  =
  let gobj = adw_flap_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFlap*(tdesc: typedesc): tdesc {.deprecated.}  =
  assert(result is Flap)
  let gobj = adw_flap_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFlap*[T](result: var T) {.deprecated.} =
  assert(result is Flap)
  let gobj = adw_flap_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_flap_get_content(self: ptr Flap00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getContent*(self: Flap): gtk4.Widget =
  let gobj = adw_flap_get_content(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc content*(self: Flap): gtk4.Widget =
  let gobj = adw_flap_get_content(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_flap_get_flap(self: ptr Flap00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getFlap*(self: Flap): gtk4.Widget =
  let gobj = adw_flap_get_flap(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc flap*(self: Flap): gtk4.Widget =
  let gobj = adw_flap_get_flap(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_flap_get_flap_position(self: ptr Flap00): gtk4.PackType {.
    importc, libprag.}

proc getFlapPosition*(self: Flap): gtk4.PackType =
  adw_flap_get_flap_position(cast[ptr Flap00](self.impl))

proc flapPosition*(self: Flap): gtk4.PackType =
  adw_flap_get_flap_position(cast[ptr Flap00](self.impl))

proc adw_flap_get_fold_duration(self: ptr Flap00): uint32 {.
    importc, libprag.}

proc getFoldDuration*(self: Flap): int =
  int(adw_flap_get_fold_duration(cast[ptr Flap00](self.impl)))

proc foldDuration*(self: Flap): int =
  int(adw_flap_get_fold_duration(cast[ptr Flap00](self.impl)))

proc adw_flap_get_folded(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getFolded*(self: Flap): bool =
  toBool(adw_flap_get_folded(cast[ptr Flap00](self.impl)))

proc folded*(self: Flap): bool =
  toBool(adw_flap_get_folded(cast[ptr Flap00](self.impl)))

proc adw_flap_get_locked(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getLocked*(self: Flap): bool =
  toBool(adw_flap_get_locked(cast[ptr Flap00](self.impl)))

proc locked*(self: Flap): bool =
  toBool(adw_flap_get_locked(cast[ptr Flap00](self.impl)))

proc adw_flap_get_modal(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getModal*(self: Flap): bool =
  toBool(adw_flap_get_modal(cast[ptr Flap00](self.impl)))

proc modal*(self: Flap): bool =
  toBool(adw_flap_get_modal(cast[ptr Flap00](self.impl)))

proc adw_flap_get_reveal_flap(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getRevealFlap*(self: Flap): bool =
  toBool(adw_flap_get_reveal_flap(cast[ptr Flap00](self.impl)))

proc revealFlap*(self: Flap): bool =
  toBool(adw_flap_get_reveal_flap(cast[ptr Flap00](self.impl)))

proc adw_flap_get_reveal_params(self: ptr Flap00): ptr SpringParams00 {.
    importc, libprag.}

proc getRevealParams*(self: Flap): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_flap_get_reveal_params(cast[ptr Flap00](self.impl))

proc revealParams*(self: Flap): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_flap_get_reveal_params(cast[ptr Flap00](self.impl))

proc adw_flap_get_reveal_progress(self: ptr Flap00): cdouble {.
    importc, libprag.}

proc getRevealProgress*(self: Flap): cdouble =
  adw_flap_get_reveal_progress(cast[ptr Flap00](self.impl))

proc revealProgress*(self: Flap): cdouble =
  adw_flap_get_reveal_progress(cast[ptr Flap00](self.impl))

proc adw_flap_get_separator(self: ptr Flap00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getSeparator*(self: Flap): gtk4.Widget =
  let gobj = adw_flap_get_separator(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc separator*(self: Flap): gtk4.Widget =
  let gobj = adw_flap_get_separator(cast[ptr Flap00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_flap_get_swipe_to_close(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getSwipeToClose*(self: Flap): bool =
  toBool(adw_flap_get_swipe_to_close(cast[ptr Flap00](self.impl)))

proc swipeToClose*(self: Flap): bool =
  toBool(adw_flap_get_swipe_to_close(cast[ptr Flap00](self.impl)))

proc adw_flap_get_swipe_to_open(self: ptr Flap00): gboolean {.
    importc, libprag.}

proc getSwipeToOpen*(self: Flap): bool =
  toBool(adw_flap_get_swipe_to_open(cast[ptr Flap00](self.impl)))

proc swipeToOpen*(self: Flap): bool =
  toBool(adw_flap_get_swipe_to_open(cast[ptr Flap00](self.impl)))

proc adw_flap_set_content(self: ptr Flap00; content: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setContent*(self: Flap; content: gtk4.Widget = nil) =
  adw_flap_set_content(cast[ptr Flap00](self.impl), if content.isNil: nil else: cast[ptr gtk4.Widget00](content.impl))

proc `content=`*(self: Flap; content: gtk4.Widget = nil) =
  adw_flap_set_content(cast[ptr Flap00](self.impl), if content.isNil: nil else: cast[ptr gtk4.Widget00](content.impl))

proc adw_flap_set_flap(self: ptr Flap00; flap: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setFlap*(self: Flap; flap: gtk4.Widget = nil) =
  adw_flap_set_flap(cast[ptr Flap00](self.impl), if flap.isNil: nil else: cast[ptr gtk4.Widget00](flap.impl))

proc `flap=`*(self: Flap; flap: gtk4.Widget = nil) =
  adw_flap_set_flap(cast[ptr Flap00](self.impl), if flap.isNil: nil else: cast[ptr gtk4.Widget00](flap.impl))

proc adw_flap_set_flap_position(self: ptr Flap00; position: gtk4.PackType) {.
    importc, libprag.}

proc setFlapPosition*(self: Flap; position: gtk4.PackType) =
  adw_flap_set_flap_position(cast[ptr Flap00](self.impl), position)

proc `flapPosition=`*(self: Flap; position: gtk4.PackType) =
  adw_flap_set_flap_position(cast[ptr Flap00](self.impl), position)

proc adw_flap_set_fold_duration(self: ptr Flap00; duration: uint32) {.
    importc, libprag.}

proc setFoldDuration*(self: Flap; duration: int) =
  adw_flap_set_fold_duration(cast[ptr Flap00](self.impl), uint32(duration))

proc `foldDuration=`*(self: Flap; duration: int) =
  adw_flap_set_fold_duration(cast[ptr Flap00](self.impl), uint32(duration))

proc adw_flap_set_locked(self: ptr Flap00; locked: gboolean) {.
    importc, libprag.}

proc setLocked*(self: Flap; locked: bool = true) =
  adw_flap_set_locked(cast[ptr Flap00](self.impl), gboolean(locked))

proc `locked=`*(self: Flap; locked: bool) =
  adw_flap_set_locked(cast[ptr Flap00](self.impl), gboolean(locked))

proc adw_flap_set_modal(self: ptr Flap00; modal: gboolean) {.
    importc, libprag.}

proc setModal*(self: Flap; modal: bool = true) =
  adw_flap_set_modal(cast[ptr Flap00](self.impl), gboolean(modal))

proc `modal=`*(self: Flap; modal: bool) =
  adw_flap_set_modal(cast[ptr Flap00](self.impl), gboolean(modal))

proc adw_flap_set_reveal_flap(self: ptr Flap00; revealFlap: gboolean) {.
    importc, libprag.}

proc setRevealFlap*(self: Flap; revealFlap: bool = true) =
  adw_flap_set_reveal_flap(cast[ptr Flap00](self.impl), gboolean(revealFlap))

proc `revealFlap=`*(self: Flap; revealFlap: bool) =
  adw_flap_set_reveal_flap(cast[ptr Flap00](self.impl), gboolean(revealFlap))

proc adw_flap_set_reveal_params(self: ptr Flap00; params: ptr SpringParams00) {.
    importc, libprag.}

proc setRevealParams*(self: Flap; params: SpringParams) =
  adw_flap_set_reveal_params(cast[ptr Flap00](self.impl), cast[ptr SpringParams00](params.impl))

proc `revealParams=`*(self: Flap; params: SpringParams) =
  adw_flap_set_reveal_params(cast[ptr Flap00](self.impl), cast[ptr SpringParams00](params.impl))

proc adw_flap_set_separator(self: ptr Flap00; separator: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setSeparator*(self: Flap; separator: gtk4.Widget = nil) =
  adw_flap_set_separator(cast[ptr Flap00](self.impl), if separator.isNil: nil else: cast[ptr gtk4.Widget00](separator.impl))

proc `separator=`*(self: Flap; separator: gtk4.Widget = nil) =
  adw_flap_set_separator(cast[ptr Flap00](self.impl), if separator.isNil: nil else: cast[ptr gtk4.Widget00](separator.impl))

proc adw_flap_set_swipe_to_close(self: ptr Flap00; swipeToClose: gboolean) {.
    importc, libprag.}

proc setSwipeToClose*(self: Flap; swipeToClose: bool = true) =
  adw_flap_set_swipe_to_close(cast[ptr Flap00](self.impl), gboolean(swipeToClose))

proc `swipeToClose=`*(self: Flap; swipeToClose: bool) =
  adw_flap_set_swipe_to_close(cast[ptr Flap00](self.impl), gboolean(swipeToClose))

proc adw_flap_set_swipe_to_open(self: ptr Flap00; swipeToOpen: gboolean) {.
    importc, libprag.}

proc setSwipeToOpen*(self: Flap; swipeToOpen: bool = true) =
  adw_flap_set_swipe_to_open(cast[ptr Flap00](self.impl), gboolean(swipeToOpen))

proc `swipeToOpen=`*(self: Flap; swipeToOpen: bool) =
  adw_flap_set_swipe_to_open(cast[ptr Flap00](self.impl), gboolean(swipeToOpen))

type
  FlapFoldPolicy* {.size: sizeof(cint), pure.} = enum
    never = 0
    always = 1
    auto = 2

proc adw_flap_get_fold_policy(self: ptr Flap00): FlapFoldPolicy {.
    importc, libprag.}

proc getFoldPolicy*(self: Flap): FlapFoldPolicy =
  adw_flap_get_fold_policy(cast[ptr Flap00](self.impl))

proc foldPolicy*(self: Flap): FlapFoldPolicy =
  adw_flap_get_fold_policy(cast[ptr Flap00](self.impl))

proc adw_flap_set_fold_policy(self: ptr Flap00; policy: FlapFoldPolicy) {.
    importc, libprag.}

proc setFoldPolicy*(self: Flap; policy: FlapFoldPolicy) =
  adw_flap_set_fold_policy(cast[ptr Flap00](self.impl), policy)

proc `foldPolicy=`*(self: Flap; policy: FlapFoldPolicy) =
  adw_flap_set_fold_policy(cast[ptr Flap00](self.impl), policy)

type
  FoldThresholdPolicy* {.size: sizeof(cint), pure.} = enum
    minimum = 0
    natural = 1

proc adw_flap_get_fold_threshold_policy(self: ptr Flap00): FoldThresholdPolicy {.
    importc, libprag.}

proc getFoldThresholdPolicy*(self: Flap): FoldThresholdPolicy =
  adw_flap_get_fold_threshold_policy(cast[ptr Flap00](self.impl))

proc foldThresholdPolicy*(self: Flap): FoldThresholdPolicy =
  adw_flap_get_fold_threshold_policy(cast[ptr Flap00](self.impl))

proc adw_flap_set_fold_threshold_policy(self: ptr Flap00; policy: FoldThresholdPolicy) {.
    importc, libprag.}

proc setFoldThresholdPolicy*(self: Flap; policy: FoldThresholdPolicy) =
  adw_flap_set_fold_threshold_policy(cast[ptr Flap00](self.impl), policy)

proc `foldThresholdPolicy=`*(self: Flap; policy: FoldThresholdPolicy) =
  adw_flap_set_fold_threshold_policy(cast[ptr Flap00](self.impl), policy)

type
  FlapTransitionType* {.size: sizeof(cint), pure.} = enum
    over = 0
    under = 1
    slide = 2

proc adw_flap_get_transition_type(self: ptr Flap00): FlapTransitionType {.
    importc, libprag.}

proc getTransitionType*(self: Flap): FlapTransitionType =
  adw_flap_get_transition_type(cast[ptr Flap00](self.impl))

proc transitionType*(self: Flap): FlapTransitionType =
  adw_flap_get_transition_type(cast[ptr Flap00](self.impl))

proc adw_flap_set_transition_type(self: ptr Flap00; transitionType: FlapTransitionType) {.
    importc, libprag.}

proc setTransitionType*(self: Flap; transitionType: FlapTransitionType) =
  adw_flap_set_transition_type(cast[ptr Flap00](self.impl), transitionType)

proc `transitionType=`*(self: Flap; transitionType: FlapTransitionType) =
  adw_flap_set_transition_type(cast[ptr Flap00](self.impl), transitionType)

type
  HeaderBar* = ref object of gtk4.Widget
  HeaderBar00* = object of gtk4.Widget00

proc adw_header_bar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HeaderBar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_header_bar_new(): ptr HeaderBar00 {.
    importc, libprag.}

proc newHeaderBar*(): HeaderBar =
  let gobj = adw_header_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHeaderBar*(tdesc: typedesc): tdesc =
  assert(result is HeaderBar)
  let gobj = adw_header_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHeaderBar*[T](result: var T) {.deprecated.} =
  assert(result is HeaderBar)
  let gobj = adw_header_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_header_bar_get_centering_policy(self: ptr HeaderBar00): CenteringPolicy {.
    importc, libprag.}

proc getCenteringPolicy*(self: HeaderBar): CenteringPolicy =
  adw_header_bar_get_centering_policy(cast[ptr HeaderBar00](self.impl))

proc centeringPolicy*(self: HeaderBar): CenteringPolicy =
  adw_header_bar_get_centering_policy(cast[ptr HeaderBar00](self.impl))

proc adw_header_bar_get_decoration_layout(self: ptr HeaderBar00): cstring {.
    importc, libprag.}

proc getDecorationLayout*(self: HeaderBar): string =
  let resul0 = adw_header_bar_get_decoration_layout(cast[ptr HeaderBar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc decorationLayout*(self: HeaderBar): string =
  let resul0 = adw_header_bar_get_decoration_layout(cast[ptr HeaderBar00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_header_bar_get_show_back_button(self: ptr HeaderBar00): gboolean {.
    importc, libprag.}

proc getShowBackButton*(self: HeaderBar): bool =
  toBool(adw_header_bar_get_show_back_button(cast[ptr HeaderBar00](self.impl)))

proc showBackButton*(self: HeaderBar): bool =
  toBool(adw_header_bar_get_show_back_button(cast[ptr HeaderBar00](self.impl)))

proc adw_header_bar_get_show_end_title_buttons(self: ptr HeaderBar00): gboolean {.
    importc, libprag.}

proc getShowEndTitleButtons*(self: HeaderBar): bool =
  toBool(adw_header_bar_get_show_end_title_buttons(cast[ptr HeaderBar00](self.impl)))

proc showEndTitleButtons*(self: HeaderBar): bool =
  toBool(adw_header_bar_get_show_end_title_buttons(cast[ptr HeaderBar00](self.impl)))

proc adw_header_bar_get_show_start_title_buttons(self: ptr HeaderBar00): gboolean {.
    importc, libprag.}

proc getShowStartTitleButtons*(self: HeaderBar): bool =
  toBool(adw_header_bar_get_show_start_title_buttons(cast[ptr HeaderBar00](self.impl)))

proc showStartTitleButtons*(self: HeaderBar): bool =
  toBool(adw_header_bar_get_show_start_title_buttons(cast[ptr HeaderBar00](self.impl)))

proc adw_header_bar_get_show_title(self: ptr HeaderBar00): gboolean {.
    importc, libprag.}

proc getShowTitle*(self: HeaderBar): bool =
  toBool(adw_header_bar_get_show_title(cast[ptr HeaderBar00](self.impl)))

proc showTitle*(self: HeaderBar): bool =
  toBool(adw_header_bar_get_show_title(cast[ptr HeaderBar00](self.impl)))

proc adw_header_bar_get_title_widget(self: ptr HeaderBar00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getTitleWidget*(self: HeaderBar): gtk4.Widget =
  let gobj = adw_header_bar_get_title_widget(cast[ptr HeaderBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc titleWidget*(self: HeaderBar): gtk4.Widget =
  let gobj = adw_header_bar_get_title_widget(cast[ptr HeaderBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_header_bar_pack_end(self: ptr HeaderBar00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc packEnd*(self: HeaderBar; child: gtk4.Widget) =
  adw_header_bar_pack_end(cast[ptr HeaderBar00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_header_bar_pack_start(self: ptr HeaderBar00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc packStart*(self: HeaderBar; child: gtk4.Widget) =
  adw_header_bar_pack_start(cast[ptr HeaderBar00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_header_bar_remove(self: ptr HeaderBar00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: HeaderBar; child: gtk4.Widget) =
  adw_header_bar_remove(cast[ptr HeaderBar00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_header_bar_set_centering_policy(self: ptr HeaderBar00; centeringPolicy: CenteringPolicy) {.
    importc, libprag.}

proc setCenteringPolicy*(self: HeaderBar; centeringPolicy: CenteringPolicy) =
  adw_header_bar_set_centering_policy(cast[ptr HeaderBar00](self.impl), centeringPolicy)

proc `centeringPolicy=`*(self: HeaderBar; centeringPolicy: CenteringPolicy) =
  adw_header_bar_set_centering_policy(cast[ptr HeaderBar00](self.impl), centeringPolicy)

proc adw_header_bar_set_decoration_layout(self: ptr HeaderBar00; layout: cstring) {.
    importc, libprag.}

proc setDecorationLayout*(self: HeaderBar; layout: cstring = nil) =
  adw_header_bar_set_decoration_layout(cast[ptr HeaderBar00](self.impl), layout)

proc `decorationLayout=`*(self: HeaderBar; layout: cstring = nil) =
  adw_header_bar_set_decoration_layout(cast[ptr HeaderBar00](self.impl), layout)

proc adw_header_bar_set_show_back_button(self: ptr HeaderBar00; showBackButton: gboolean) {.
    importc, libprag.}

proc setShowBackButton*(self: HeaderBar; showBackButton: bool = true) =
  adw_header_bar_set_show_back_button(cast[ptr HeaderBar00](self.impl), gboolean(showBackButton))

proc `showBackButton=`*(self: HeaderBar; showBackButton: bool) =
  adw_header_bar_set_show_back_button(cast[ptr HeaderBar00](self.impl), gboolean(showBackButton))

proc adw_header_bar_set_show_end_title_buttons(self: ptr HeaderBar00; setting: gboolean) {.
    importc, libprag.}

proc setShowEndTitleButtons*(self: HeaderBar; setting: bool = true) =
  adw_header_bar_set_show_end_title_buttons(cast[ptr HeaderBar00](self.impl), gboolean(setting))

proc `showEndTitleButtons=`*(self: HeaderBar; setting: bool) =
  adw_header_bar_set_show_end_title_buttons(cast[ptr HeaderBar00](self.impl), gboolean(setting))

proc adw_header_bar_set_show_start_title_buttons(self: ptr HeaderBar00; setting: gboolean) {.
    importc, libprag.}

proc setShowStartTitleButtons*(self: HeaderBar; setting: bool = true) =
  adw_header_bar_set_show_start_title_buttons(cast[ptr HeaderBar00](self.impl), gboolean(setting))

proc `showStartTitleButtons=`*(self: HeaderBar; setting: bool) =
  adw_header_bar_set_show_start_title_buttons(cast[ptr HeaderBar00](self.impl), gboolean(setting))

proc adw_header_bar_set_show_title(self: ptr HeaderBar00; showTitle: gboolean) {.
    importc, libprag.}

proc setShowTitle*(self: HeaderBar; showTitle: bool = true) =
  adw_header_bar_set_show_title(cast[ptr HeaderBar00](self.impl), gboolean(showTitle))

proc `showTitle=`*(self: HeaderBar; showTitle: bool) =
  adw_header_bar_set_show_title(cast[ptr HeaderBar00](self.impl), gboolean(showTitle))

proc adw_header_bar_set_title_widget(self: ptr HeaderBar00; titleWidget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setTitleWidget*(self: HeaderBar; titleWidget: gtk4.Widget = nil) =
  adw_header_bar_set_title_widget(cast[ptr HeaderBar00](self.impl), if titleWidget.isNil: nil else: cast[ptr gtk4.Widget00](titleWidget.impl))

proc `titleWidget=`*(self: HeaderBar; titleWidget: gtk4.Widget = nil) =
  adw_header_bar_set_title_widget(cast[ptr HeaderBar00](self.impl), if titleWidget.isNil: nil else: cast[ptr gtk4.Widget00](titleWidget.impl))

type
  Leaflet* = ref object of gtk4.Widget
  Leaflet00* = object of gtk4.Widget00

proc adw_leaflet_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Leaflet()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_leaflet_new(): ptr Leaflet00 {.
    importc, libprag.}

proc newLeaflet*(): Leaflet {.deprecated.}  =
  let gobj = adw_leaflet_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newLeaflet*(tdesc: typedesc): tdesc {.deprecated.}  =
  assert(result is Leaflet)
  let gobj = adw_leaflet_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initLeaflet*[T](result: var T) {.deprecated.} =
  assert(result is Leaflet)
  let gobj = adw_leaflet_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_leaflet_get_can_navigate_back(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getCanNavigateBack*(self: Leaflet): bool =
  toBool(adw_leaflet_get_can_navigate_back(cast[ptr Leaflet00](self.impl)))

proc canNavigateBack*(self: Leaflet): bool =
  toBool(adw_leaflet_get_can_navigate_back(cast[ptr Leaflet00](self.impl)))

proc adw_leaflet_get_can_navigate_forward(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getCanNavigateForward*(self: Leaflet): bool =
  toBool(adw_leaflet_get_can_navigate_forward(cast[ptr Leaflet00](self.impl)))

proc canNavigateForward*(self: Leaflet): bool =
  toBool(adw_leaflet_get_can_navigate_forward(cast[ptr Leaflet00](self.impl)))

proc adw_leaflet_get_can_unfold(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getCanUnfold*(self: Leaflet): bool =
  toBool(adw_leaflet_get_can_unfold(cast[ptr Leaflet00](self.impl)))

proc canUnfold*(self: Leaflet): bool =
  toBool(adw_leaflet_get_can_unfold(cast[ptr Leaflet00](self.impl)))

proc adw_leaflet_get_child_by_name(self: ptr Leaflet00; name: cstring): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChildByName*(self: Leaflet; name: cstring): gtk4.Widget =
  let gobj = adw_leaflet_get_child_by_name(cast[ptr Leaflet00](self.impl), name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_leaflet_get_child_transition_params(self: ptr Leaflet00): ptr SpringParams00 {.
    importc, libprag.}

proc getChildTransitionParams*(self: Leaflet): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_leaflet_get_child_transition_params(cast[ptr Leaflet00](self.impl))

proc childTransitionParams*(self: Leaflet): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_leaflet_get_child_transition_params(cast[ptr Leaflet00](self.impl))

proc adw_leaflet_get_child_transition_running(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getChildTransitionRunning*(self: Leaflet): bool =
  toBool(adw_leaflet_get_child_transition_running(cast[ptr Leaflet00](self.impl)))

proc childTransitionRunning*(self: Leaflet): bool =
  toBool(adw_leaflet_get_child_transition_running(cast[ptr Leaflet00](self.impl)))

proc adw_leaflet_get_fold_threshold_policy(self: ptr Leaflet00): FoldThresholdPolicy {.
    importc, libprag.}

proc getFoldThresholdPolicy*(self: Leaflet): FoldThresholdPolicy =
  adw_leaflet_get_fold_threshold_policy(cast[ptr Leaflet00](self.impl))

proc foldThresholdPolicy*(self: Leaflet): FoldThresholdPolicy =
  adw_leaflet_get_fold_threshold_policy(cast[ptr Leaflet00](self.impl))

proc adw_leaflet_get_folded(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getFolded*(self: Leaflet): bool =
  toBool(adw_leaflet_get_folded(cast[ptr Leaflet00](self.impl)))

proc folded*(self: Leaflet): bool =
  toBool(adw_leaflet_get_folded(cast[ptr Leaflet00](self.impl)))

proc adw_leaflet_get_homogeneous(self: ptr Leaflet00): gboolean {.
    importc, libprag.}

proc getHomogeneous*(self: Leaflet): bool =
  toBool(adw_leaflet_get_homogeneous(cast[ptr Leaflet00](self.impl)))

proc homogeneous*(self: Leaflet): bool =
  toBool(adw_leaflet_get_homogeneous(cast[ptr Leaflet00](self.impl)))

proc adw_leaflet_get_mode_transition_duration(self: ptr Leaflet00): uint32 {.
    importc, libprag.}

proc getModeTransitionDuration*(self: Leaflet): int =
  int(adw_leaflet_get_mode_transition_duration(cast[ptr Leaflet00](self.impl)))

proc modeTransitionDuration*(self: Leaflet): int =
  int(adw_leaflet_get_mode_transition_duration(cast[ptr Leaflet00](self.impl)))

proc adw_leaflet_get_pages(self: ptr Leaflet00): ptr gtk4.SelectionModel00 {.
    importc, libprag.}

proc getPages*(self: Leaflet): gtk4.SelectionModel =
  let gobj = adw_leaflet_get_pages(cast[ptr Leaflet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pages*(self: Leaflet): gtk4.SelectionModel =
  let gobj = adw_leaflet_get_pages(cast[ptr Leaflet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_leaflet_get_visible_child(self: ptr Leaflet00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getVisibleChild*(self: Leaflet): gtk4.Widget =
  let gobj = adw_leaflet_get_visible_child(cast[ptr Leaflet00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visibleChild*(self: Leaflet): gtk4.Widget =
  let gobj = adw_leaflet_get_visible_child(cast[ptr Leaflet00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_leaflet_get_visible_child_name(self: ptr Leaflet00): cstring {.
    importc, libprag.}

proc getVisibleChildName*(self: Leaflet): string =
  let resul0 = adw_leaflet_get_visible_child_name(cast[ptr Leaflet00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc visibleChildName*(self: Leaflet): string =
  let resul0 = adw_leaflet_get_visible_child_name(cast[ptr Leaflet00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_leaflet_remove(self: ptr Leaflet00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: Leaflet; child: gtk4.Widget) =
  adw_leaflet_remove(cast[ptr Leaflet00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_leaflet_reorder_child_after(self: ptr Leaflet00; child: ptr gtk4.Widget00;
    sibling: ptr gtk4.Widget00) {.
    importc, libprag.}

proc reorderChildAfter*(self: Leaflet; child: gtk4.Widget; sibling: gtk4.Widget = nil) =
  adw_leaflet_reorder_child_after(cast[ptr Leaflet00](self.impl), cast[ptr gtk4.Widget00](child.impl), if sibling.isNil: nil else: cast[ptr gtk4.Widget00](sibling.impl))

proc adw_leaflet_set_can_navigate_back(self: ptr Leaflet00; canNavigateBack: gboolean) {.
    importc, libprag.}

proc setCanNavigateBack*(self: Leaflet; canNavigateBack: bool = true) =
  adw_leaflet_set_can_navigate_back(cast[ptr Leaflet00](self.impl), gboolean(canNavigateBack))

proc `canNavigateBack=`*(self: Leaflet; canNavigateBack: bool) =
  adw_leaflet_set_can_navigate_back(cast[ptr Leaflet00](self.impl), gboolean(canNavigateBack))

proc adw_leaflet_set_can_navigate_forward(self: ptr Leaflet00; canNavigateForward: gboolean) {.
    importc, libprag.}

proc setCanNavigateForward*(self: Leaflet; canNavigateForward: bool = true) =
  adw_leaflet_set_can_navigate_forward(cast[ptr Leaflet00](self.impl), gboolean(canNavigateForward))

proc `canNavigateForward=`*(self: Leaflet; canNavigateForward: bool) =
  adw_leaflet_set_can_navigate_forward(cast[ptr Leaflet00](self.impl), gboolean(canNavigateForward))

proc adw_leaflet_set_can_unfold(self: ptr Leaflet00; canUnfold: gboolean) {.
    importc, libprag.}

proc setCanUnfold*(self: Leaflet; canUnfold: bool = true) =
  adw_leaflet_set_can_unfold(cast[ptr Leaflet00](self.impl), gboolean(canUnfold))

proc `canUnfold=`*(self: Leaflet; canUnfold: bool) =
  adw_leaflet_set_can_unfold(cast[ptr Leaflet00](self.impl), gboolean(canUnfold))

proc adw_leaflet_set_child_transition_params(self: ptr Leaflet00; params: ptr SpringParams00) {.
    importc, libprag.}

proc setChildTransitionParams*(self: Leaflet; params: SpringParams) =
  adw_leaflet_set_child_transition_params(cast[ptr Leaflet00](self.impl), cast[ptr SpringParams00](params.impl))

proc `childTransitionParams=`*(self: Leaflet; params: SpringParams) =
  adw_leaflet_set_child_transition_params(cast[ptr Leaflet00](self.impl), cast[ptr SpringParams00](params.impl))

proc adw_leaflet_set_fold_threshold_policy(self: ptr Leaflet00; policy: FoldThresholdPolicy) {.
    importc, libprag.}

proc setFoldThresholdPolicy*(self: Leaflet; policy: FoldThresholdPolicy) =
  adw_leaflet_set_fold_threshold_policy(cast[ptr Leaflet00](self.impl), policy)

proc `foldThresholdPolicy=`*(self: Leaflet; policy: FoldThresholdPolicy) =
  adw_leaflet_set_fold_threshold_policy(cast[ptr Leaflet00](self.impl), policy)

proc adw_leaflet_set_homogeneous(self: ptr Leaflet00; homogeneous: gboolean) {.
    importc, libprag.}

proc setHomogeneous*(self: Leaflet; homogeneous: bool = true) =
  adw_leaflet_set_homogeneous(cast[ptr Leaflet00](self.impl), gboolean(homogeneous))

proc `homogeneous=`*(self: Leaflet; homogeneous: bool) =
  adw_leaflet_set_homogeneous(cast[ptr Leaflet00](self.impl), gboolean(homogeneous))

proc adw_leaflet_set_mode_transition_duration(self: ptr Leaflet00; duration: uint32) {.
    importc, libprag.}

proc setModeTransitionDuration*(self: Leaflet; duration: int) =
  adw_leaflet_set_mode_transition_duration(cast[ptr Leaflet00](self.impl), uint32(duration))

proc `modeTransitionDuration=`*(self: Leaflet; duration: int) =
  adw_leaflet_set_mode_transition_duration(cast[ptr Leaflet00](self.impl), uint32(duration))

proc adw_leaflet_set_visible_child(self: ptr Leaflet00; visibleChild: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setVisibleChild*(self: Leaflet; visibleChild: gtk4.Widget) =
  adw_leaflet_set_visible_child(cast[ptr Leaflet00](self.impl), cast[ptr gtk4.Widget00](visibleChild.impl))

proc `visibleChild=`*(self: Leaflet; visibleChild: gtk4.Widget) =
  adw_leaflet_set_visible_child(cast[ptr Leaflet00](self.impl), cast[ptr gtk4.Widget00](visibleChild.impl))

proc adw_leaflet_set_visible_child_name(self: ptr Leaflet00; name: cstring) {.
    importc, libprag.}

proc setVisibleChildName*(self: Leaflet; name: cstring) =
  adw_leaflet_set_visible_child_name(cast[ptr Leaflet00](self.impl), name)

proc `visibleChildName=`*(self: Leaflet; name: cstring) =
  adw_leaflet_set_visible_child_name(cast[ptr Leaflet00](self.impl), name)

type
  NavigationDirection* {.size: sizeof(cint), pure.} = enum
    back = 0
    forward = 1

proc adw_leaflet_get_adjacent_child(self: ptr Leaflet00; direction: NavigationDirection): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getAdjacentChild*(self: Leaflet; direction: NavigationDirection): gtk4.Widget =
  let gobj = adw_leaflet_get_adjacent_child(cast[ptr Leaflet00](self.impl), direction)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_leaflet_navigate(self: ptr Leaflet00; direction: NavigationDirection): gboolean {.
    importc, libprag.}

proc navigate*(self: Leaflet; direction: NavigationDirection): bool =
  toBool(adw_leaflet_navigate(cast[ptr Leaflet00](self.impl), direction))

type
  LeafletPage* = ref object of gobject.Object
  LeafletPage00* = object of gobject.Object00

proc adw_leaflet_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LeafletPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_leaflet_page_get_child(self: ptr LeafletPage00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: LeafletPage): gtk4.Widget =
  let gobj = adw_leaflet_page_get_child(cast[ptr LeafletPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: LeafletPage): gtk4.Widget =
  let gobj = adw_leaflet_page_get_child(cast[ptr LeafletPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_leaflet_page_get_name(self: ptr LeafletPage00): cstring {.
    importc, libprag.}

proc getName*(self: LeafletPage): string =
  let resul0 = adw_leaflet_page_get_name(cast[ptr LeafletPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc name*(self: LeafletPage): string =
  let resul0 = adw_leaflet_page_get_name(cast[ptr LeafletPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_leaflet_page_get_navigatable(self: ptr LeafletPage00): gboolean {.
    importc, libprag.}

proc getNavigatable*(self: LeafletPage): bool =
  toBool(adw_leaflet_page_get_navigatable(cast[ptr LeafletPage00](self.impl)))

proc navigatable*(self: LeafletPage): bool =
  toBool(adw_leaflet_page_get_navigatable(cast[ptr LeafletPage00](self.impl)))

proc adw_leaflet_page_set_name(self: ptr LeafletPage00; name: cstring) {.
    importc, libprag.}

proc setName*(self: LeafletPage; name: cstring = nil) =
  adw_leaflet_page_set_name(cast[ptr LeafletPage00](self.impl), name)

proc `name=`*(self: LeafletPage; name: cstring = nil) =
  adw_leaflet_page_set_name(cast[ptr LeafletPage00](self.impl), name)

proc adw_leaflet_page_set_navigatable(self: ptr LeafletPage00; navigatable: gboolean) {.
    importc, libprag.}

proc setNavigatable*(self: LeafletPage; navigatable: bool = true) =
  adw_leaflet_page_set_navigatable(cast[ptr LeafletPage00](self.impl), gboolean(navigatable))

proc `navigatable=`*(self: LeafletPage; navigatable: bool) =
  adw_leaflet_page_set_navigatable(cast[ptr LeafletPage00](self.impl), gboolean(navigatable))

proc adw_leaflet_append(self: ptr Leaflet00; child: ptr gtk4.Widget00): ptr LeafletPage00 {.
    importc, libprag.}

proc append*(self: Leaflet; child: gtk4.Widget): LeafletPage =
  let gobj = adw_leaflet_append(cast[ptr Leaflet00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_leaflet_get_page(self: ptr Leaflet00; child: ptr gtk4.Widget00): ptr LeafletPage00 {.
    importc, libprag.}

proc getPage*(self: Leaflet; child: gtk4.Widget): LeafletPage =
  let gobj = adw_leaflet_get_page(cast[ptr Leaflet00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_leaflet_insert_child_after(self: ptr Leaflet00; child: ptr gtk4.Widget00;
    sibling: ptr gtk4.Widget00): ptr LeafletPage00 {.
    importc, libprag.}

proc insertChildAfter*(self: Leaflet; child: gtk4.Widget; sibling: gtk4.Widget = nil): LeafletPage =
  let gobj = adw_leaflet_insert_child_after(cast[ptr Leaflet00](self.impl), cast[ptr gtk4.Widget00](child.impl), if sibling.isNil: nil else: cast[ptr gtk4.Widget00](sibling.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_leaflet_prepend(self: ptr Leaflet00; child: ptr gtk4.Widget00): ptr LeafletPage00 {.
    importc, libprag.}

proc prepend*(self: Leaflet; child: gtk4.Widget): LeafletPage =
  let gobj = adw_leaflet_prepend(cast[ptr Leaflet00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  LeafletTransitionType* {.size: sizeof(cint), pure.} = enum
    over = 0
    under = 1
    slide = 2

proc adw_leaflet_get_transition_type(self: ptr Leaflet00): LeafletTransitionType {.
    importc, libprag.}

proc getTransitionType*(self: Leaflet): LeafletTransitionType =
  adw_leaflet_get_transition_type(cast[ptr Leaflet00](self.impl))

proc transitionType*(self: Leaflet): LeafletTransitionType =
  adw_leaflet_get_transition_type(cast[ptr Leaflet00](self.impl))

proc adw_leaflet_set_transition_type(self: ptr Leaflet00; transition: LeafletTransitionType) {.
    importc, libprag.}

proc setTransitionType*(self: Leaflet; transition: LeafletTransitionType) =
  adw_leaflet_set_transition_type(cast[ptr Leaflet00](self.impl), transition)

proc `transitionType=`*(self: Leaflet; transition: LeafletTransitionType) =
  adw_leaflet_set_transition_type(cast[ptr Leaflet00](self.impl), transition)

const MAJOR_VERSION* = 1'i32

const MICRO_VERSION* = 0'i32

const MINOR_VERSION* = 5'i32

type
  MessageDialog* = ref object of gtk4.Window
  MessageDialog00* = object of gtk4.Window00

proc adw_message_dialog_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MessageDialog()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scResponse*(self: MessageDialog;  p: proc (self: ptr MessageDialog00; response: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "response", cast[GCallback](p), xdata, nil, cf)

proc adw_message_dialog_new(parent: ptr gtk4.Window00; heading: cstring;
    body: cstring): ptr MessageDialog00 {.
    importc, libprag.}

proc newMessageDialog*(parent: gtk4.Window = nil; heading: cstring = nil;
    body: cstring = nil): MessageDialog =
  let gobj = adw_message_dialog_new(if parent.isNil: nil else: cast[ptr gtk4.Window00](parent.impl), heading, body)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newMessageDialog*(tdesc: typedesc; parent: gtk4.Window = nil; heading: cstring = nil;
    body: cstring = nil): tdesc =
  assert(result is MessageDialog)
  let gobj = adw_message_dialog_new(if parent.isNil: nil else: cast[ptr gtk4.Window00](parent.impl), heading, body)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMessageDialog*[T](result: var T; parent: gtk4.Window = nil; heading: cstring = nil;
    body: cstring = nil) {.deprecated.} =
  assert(result is MessageDialog)
  let gobj = adw_message_dialog_new(if parent.isNil: nil else: cast[ptr gtk4.Window00](parent.impl), heading, body)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_message_dialog_add_response(self: ptr MessageDialog00; id: cstring;
    label: cstring) {.
    importc, libprag.}

proc addResponse*(self: MessageDialog; id: cstring; label: cstring) =
  adw_message_dialog_add_response(cast[ptr MessageDialog00](self.impl), id, label)

proc adw_message_dialog_choose(self: ptr MessageDialog00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc choose*(self: MessageDialog; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  adw_message_dialog_choose(cast[ptr MessageDialog00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc adw_message_dialog_choose_finish(self: ptr MessageDialog00; resu: ptr gio.AsyncResult00): cstring {.
    importc, libprag.}

proc chooseFinish*(self: MessageDialog; resu: gio.AsyncResult): string =
  result = $adw_message_dialog_choose_finish(cast[ptr MessageDialog00](self.impl), cast[ptr gio.AsyncResult00](resu.impl))

proc adw_message_dialog_get_body(self: ptr MessageDialog00): cstring {.
    importc, libprag.}

proc getBody*(self: MessageDialog): string =
  result = $adw_message_dialog_get_body(cast[ptr MessageDialog00](self.impl))

proc body*(self: MessageDialog): string =
  result = $adw_message_dialog_get_body(cast[ptr MessageDialog00](self.impl))

proc adw_message_dialog_get_body_use_markup(self: ptr MessageDialog00): gboolean {.
    importc, libprag.}

proc getBodyUseMarkup*(self: MessageDialog): bool =
  toBool(adw_message_dialog_get_body_use_markup(cast[ptr MessageDialog00](self.impl)))

proc bodyUseMarkup*(self: MessageDialog): bool =
  toBool(adw_message_dialog_get_body_use_markup(cast[ptr MessageDialog00](self.impl)))

proc adw_message_dialog_get_close_response(self: ptr MessageDialog00): cstring {.
    importc, libprag.}

proc getCloseResponse*(self: MessageDialog): string =
  result = $adw_message_dialog_get_close_response(cast[ptr MessageDialog00](self.impl))

proc closeResponse*(self: MessageDialog): string =
  result = $adw_message_dialog_get_close_response(cast[ptr MessageDialog00](self.impl))

proc adw_message_dialog_get_default_response(self: ptr MessageDialog00): cstring {.
    importc, libprag.}

proc getDefaultResponse*(self: MessageDialog): string =
  let resul0 = adw_message_dialog_get_default_response(cast[ptr MessageDialog00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc defaultResponse*(self: MessageDialog): string =
  let resul0 = adw_message_dialog_get_default_response(cast[ptr MessageDialog00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_message_dialog_get_extra_child(self: ptr MessageDialog00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getExtraChild*(self: MessageDialog): gtk4.Widget =
  let gobj = adw_message_dialog_get_extra_child(cast[ptr MessageDialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc extraChild*(self: MessageDialog): gtk4.Widget =
  let gobj = adw_message_dialog_get_extra_child(cast[ptr MessageDialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_message_dialog_get_heading(self: ptr MessageDialog00): cstring {.
    importc, libprag.}

proc getHeading*(self: MessageDialog): string =
  let resul0 = adw_message_dialog_get_heading(cast[ptr MessageDialog00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc heading*(self: MessageDialog): string =
  let resul0 = adw_message_dialog_get_heading(cast[ptr MessageDialog00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_message_dialog_get_heading_use_markup(self: ptr MessageDialog00): gboolean {.
    importc, libprag.}

proc getHeadingUseMarkup*(self: MessageDialog): bool =
  toBool(adw_message_dialog_get_heading_use_markup(cast[ptr MessageDialog00](self.impl)))

proc headingUseMarkup*(self: MessageDialog): bool =
  toBool(adw_message_dialog_get_heading_use_markup(cast[ptr MessageDialog00](self.impl)))

proc adw_message_dialog_get_response_appearance(self: ptr MessageDialog00;
    response: cstring): ResponseAppearance {.
    importc, libprag.}

proc getResponseAppearance*(self: MessageDialog; response: cstring): ResponseAppearance =
  adw_message_dialog_get_response_appearance(cast[ptr MessageDialog00](self.impl), response)

proc adw_message_dialog_get_response_enabled(self: ptr MessageDialog00; response: cstring): gboolean {.
    importc, libprag.}

proc getResponseEnabled*(self: MessageDialog; response: cstring): bool =
  toBool(adw_message_dialog_get_response_enabled(cast[ptr MessageDialog00](self.impl), response))

proc adw_message_dialog_get_response_label(self: ptr MessageDialog00; response: cstring): cstring {.
    importc, libprag.}

proc getResponseLabel*(self: MessageDialog; response: cstring): string =
  result = $adw_message_dialog_get_response_label(cast[ptr MessageDialog00](self.impl), response)

proc adw_message_dialog_has_response(self: ptr MessageDialog00; response: cstring): gboolean {.
    importc, libprag.}

proc hasResponse*(self: MessageDialog; response: cstring): bool =
  toBool(adw_message_dialog_has_response(cast[ptr MessageDialog00](self.impl), response))

proc adw_message_dialog_remove_response(self: ptr MessageDialog00; id: cstring) {.
    importc, libprag.}

proc removeResponse*(self: MessageDialog; id: cstring) =
  adw_message_dialog_remove_response(cast[ptr MessageDialog00](self.impl), id)

proc adw_message_dialog_response(self: ptr MessageDialog00; response: cstring) {.
    importc, libprag.}

proc response*(self: MessageDialog; response: cstring) =
  adw_message_dialog_response(cast[ptr MessageDialog00](self.impl), response)

proc adw_message_dialog_set_body(self: ptr MessageDialog00; body: cstring) {.
    importc, libprag.}

proc setBody*(self: MessageDialog; body: cstring) =
  adw_message_dialog_set_body(cast[ptr MessageDialog00](self.impl), body)

proc `body=`*(self: MessageDialog; body: cstring) =
  adw_message_dialog_set_body(cast[ptr MessageDialog00](self.impl), body)

proc adw_message_dialog_set_body_use_markup(self: ptr MessageDialog00; useMarkup: gboolean) {.
    importc, libprag.}

proc setBodyUseMarkup*(self: MessageDialog; useMarkup: bool = true) =
  adw_message_dialog_set_body_use_markup(cast[ptr MessageDialog00](self.impl), gboolean(useMarkup))

proc `bodyUseMarkup=`*(self: MessageDialog; useMarkup: bool) =
  adw_message_dialog_set_body_use_markup(cast[ptr MessageDialog00](self.impl), gboolean(useMarkup))

proc adw_message_dialog_set_close_response(self: ptr MessageDialog00; response: cstring) {.
    importc, libprag.}

proc setCloseResponse*(self: MessageDialog; response: cstring) =
  adw_message_dialog_set_close_response(cast[ptr MessageDialog00](self.impl), response)

proc `closeResponse=`*(self: MessageDialog; response: cstring) =
  adw_message_dialog_set_close_response(cast[ptr MessageDialog00](self.impl), response)

proc adw_message_dialog_set_default_response(self: ptr MessageDialog00; response: cstring) {.
    importc, libprag.}

proc setDefaultResponse*(self: MessageDialog; response: cstring = nil) =
  adw_message_dialog_set_default_response(cast[ptr MessageDialog00](self.impl), response)

proc `defaultResponse=`*(self: MessageDialog; response: cstring = nil) =
  adw_message_dialog_set_default_response(cast[ptr MessageDialog00](self.impl), response)

proc adw_message_dialog_set_extra_child(self: ptr MessageDialog00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setExtraChild*(self: MessageDialog; child: gtk4.Widget = nil) =
  adw_message_dialog_set_extra_child(cast[ptr MessageDialog00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `extraChild=`*(self: MessageDialog; child: gtk4.Widget = nil) =
  adw_message_dialog_set_extra_child(cast[ptr MessageDialog00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc adw_message_dialog_set_heading(self: ptr MessageDialog00; heading: cstring) {.
    importc, libprag.}

proc setHeading*(self: MessageDialog; heading: cstring = nil) =
  adw_message_dialog_set_heading(cast[ptr MessageDialog00](self.impl), heading)

proc `heading=`*(self: MessageDialog; heading: cstring = nil) =
  adw_message_dialog_set_heading(cast[ptr MessageDialog00](self.impl), heading)

proc adw_message_dialog_set_heading_use_markup(self: ptr MessageDialog00;
    useMarkup: gboolean) {.
    importc, libprag.}

proc setHeadingUseMarkup*(self: MessageDialog; useMarkup: bool = true) =
  adw_message_dialog_set_heading_use_markup(cast[ptr MessageDialog00](self.impl), gboolean(useMarkup))

proc `headingUseMarkup=`*(self: MessageDialog; useMarkup: bool) =
  adw_message_dialog_set_heading_use_markup(cast[ptr MessageDialog00](self.impl), gboolean(useMarkup))

proc adw_message_dialog_set_response_appearance(self: ptr MessageDialog00;
    response: cstring; appearance: ResponseAppearance) {.
    importc, libprag.}

proc setResponseAppearance*(self: MessageDialog; response: cstring;
    appearance: ResponseAppearance) =
  adw_message_dialog_set_response_appearance(cast[ptr MessageDialog00](self.impl), response, appearance)

proc adw_message_dialog_set_response_enabled(self: ptr MessageDialog00; response: cstring;
    enabled: gboolean) {.
    importc, libprag.}

proc setResponseEnabled*(self: MessageDialog; response: cstring;
    enabled: bool) =
  adw_message_dialog_set_response_enabled(cast[ptr MessageDialog00](self.impl), response, gboolean(enabled))

proc adw_message_dialog_set_response_label(self: ptr MessageDialog00; response: cstring;
    label: cstring) {.
    importc, libprag.}

proc setResponseLabel*(self: MessageDialog; response: cstring;
    label: cstring) =
  adw_message_dialog_set_response_label(cast[ptr MessageDialog00](self.impl), response, label)

type
  NavigationPage* = ref object of gtk4.Widget
  NavigationPage00* = object of gtk4.Widget00

proc adw_navigation_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NavigationPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scHidden*(self: NavigationPage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "hidden", cast[GCallback](p), xdata, nil, cf)

proc scHiding*(self: NavigationPage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "hiding", cast[GCallback](p), xdata, nil, cf)

proc scShowing*(self: NavigationPage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "showing", cast[GCallback](p), xdata, nil, cf)

proc scShown*(self: NavigationPage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "shown", cast[GCallback](p), xdata, nil, cf)

proc adw_navigation_page_new(child: ptr gtk4.Widget00; title: cstring): ptr NavigationPage00 {.
    importc, libprag.}

proc newNavigationPage*(child: gtk4.Widget; title: cstring): NavigationPage =
  let gobj = adw_navigation_page_new(cast[ptr gtk4.Widget00](child.impl), title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNavigationPage*(tdesc: typedesc; child: gtk4.Widget; title: cstring): tdesc =
  assert(result is NavigationPage)
  let gobj = adw_navigation_page_new(cast[ptr gtk4.Widget00](child.impl), title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNavigationPage*[T](result: var T; child: gtk4.Widget; title: cstring) {.deprecated.} =
  assert(result is NavigationPage)
  let gobj = adw_navigation_page_new(cast[ptr gtk4.Widget00](child.impl), title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_navigation_page_new_with_tag(child: ptr gtk4.Widget00; title: cstring;
    tag: cstring): ptr NavigationPage00 {.
    importc, libprag.}

proc newNavigationPageWithTag*(child: gtk4.Widget; title: cstring;
    tag: cstring): NavigationPage =
  let gobj = adw_navigation_page_new_with_tag(cast[ptr gtk4.Widget00](child.impl), title, tag)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNavigationPageWithTag*(tdesc: typedesc; child: gtk4.Widget; title: cstring;
    tag: cstring): tdesc =
  assert(result is NavigationPage)
  let gobj = adw_navigation_page_new_with_tag(cast[ptr gtk4.Widget00](child.impl), title, tag)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNavigationPageWithTag*[T](result: var T; child: gtk4.Widget; title: cstring;
    tag: cstring) {.deprecated.} =
  assert(result is NavigationPage)
  let gobj = adw_navigation_page_new_with_tag(cast[ptr gtk4.Widget00](child.impl), title, tag)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_navigation_page_get_can_pop(self: ptr NavigationPage00): gboolean {.
    importc, libprag.}

proc getCanPop*(self: NavigationPage): bool =
  toBool(adw_navigation_page_get_can_pop(cast[ptr NavigationPage00](self.impl)))

proc canPop*(self: NavigationPage): bool =
  toBool(adw_navigation_page_get_can_pop(cast[ptr NavigationPage00](self.impl)))

proc adw_navigation_page_get_child(self: ptr NavigationPage00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: NavigationPage): gtk4.Widget =
  let gobj = adw_navigation_page_get_child(cast[ptr NavigationPage00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: NavigationPage): gtk4.Widget =
  let gobj = adw_navigation_page_get_child(cast[ptr NavigationPage00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_navigation_page_get_tag(self: ptr NavigationPage00): cstring {.
    importc, libprag.}

proc getTag*(self: NavigationPage): string =
  let resul0 = adw_navigation_page_get_tag(cast[ptr NavigationPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc tag*(self: NavigationPage): string =
  let resul0 = adw_navigation_page_get_tag(cast[ptr NavigationPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_navigation_page_get_title(self: ptr NavigationPage00): cstring {.
    importc, libprag.}

proc getTitle*(self: NavigationPage): string =
  result = $adw_navigation_page_get_title(cast[ptr NavigationPage00](self.impl))

proc title*(self: NavigationPage): string =
  result = $adw_navigation_page_get_title(cast[ptr NavigationPage00](self.impl))

proc adw_navigation_page_set_can_pop(self: ptr NavigationPage00; canPop: gboolean) {.
    importc, libprag.}

proc setCanPop*(self: NavigationPage; canPop: bool = true) =
  adw_navigation_page_set_can_pop(cast[ptr NavigationPage00](self.impl), gboolean(canPop))

proc `canPop=`*(self: NavigationPage; canPop: bool) =
  adw_navigation_page_set_can_pop(cast[ptr NavigationPage00](self.impl), gboolean(canPop))

proc adw_navigation_page_set_child(self: ptr NavigationPage00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setChild*(self: NavigationPage; child: gtk4.Widget = nil) =
  adw_navigation_page_set_child(cast[ptr NavigationPage00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `child=`*(self: NavigationPage; child: gtk4.Widget = nil) =
  adw_navigation_page_set_child(cast[ptr NavigationPage00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc adw_navigation_page_set_tag(self: ptr NavigationPage00; tag: cstring) {.
    importc, libprag.}

proc setTag*(self: NavigationPage; tag: cstring = nil) =
  adw_navigation_page_set_tag(cast[ptr NavigationPage00](self.impl), tag)

proc `tag=`*(self: NavigationPage; tag: cstring = nil) =
  adw_navigation_page_set_tag(cast[ptr NavigationPage00](self.impl), tag)

proc adw_navigation_page_set_title(self: ptr NavigationPage00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: NavigationPage; title: cstring) =
  adw_navigation_page_set_title(cast[ptr NavigationPage00](self.impl), title)

proc `title=`*(self: NavigationPage; title: cstring) =
  adw_navigation_page_set_title(cast[ptr NavigationPage00](self.impl), title)

type
  NavigationSplitView* = ref object of gtk4.Widget
  NavigationSplitView00* = object of gtk4.Widget00

proc adw_navigation_split_view_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NavigationSplitView()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_navigation_split_view_new(): ptr NavigationSplitView00 {.
    importc, libprag.}

proc newNavigationSplitView*(): NavigationSplitView =
  let gobj = adw_navigation_split_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNavigationSplitView*(tdesc: typedesc): tdesc =
  assert(result is NavigationSplitView)
  let gobj = adw_navigation_split_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNavigationSplitView*[T](result: var T) {.deprecated.} =
  assert(result is NavigationSplitView)
  let gobj = adw_navigation_split_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_navigation_split_view_get_collapsed(self: ptr NavigationSplitView00): gboolean {.
    importc, libprag.}

proc getCollapsed*(self: NavigationSplitView): bool =
  toBool(adw_navigation_split_view_get_collapsed(cast[ptr NavigationSplitView00](self.impl)))

proc collapsed*(self: NavigationSplitView): bool =
  toBool(adw_navigation_split_view_get_collapsed(cast[ptr NavigationSplitView00](self.impl)))

proc adw_navigation_split_view_get_content(self: ptr NavigationSplitView00): ptr NavigationPage00 {.
    importc, libprag.}

proc getContent*(self: NavigationSplitView): NavigationPage =
  let gobj = adw_navigation_split_view_get_content(cast[ptr NavigationSplitView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc content*(self: NavigationSplitView): NavigationPage =
  let gobj = adw_navigation_split_view_get_content(cast[ptr NavigationSplitView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_navigation_split_view_get_max_sidebar_width(self: ptr NavigationSplitView00): cdouble {.
    importc, libprag.}

proc getMaxSidebarWidth*(self: NavigationSplitView): cdouble =
  adw_navigation_split_view_get_max_sidebar_width(cast[ptr NavigationSplitView00](self.impl))

proc maxSidebarWidth*(self: NavigationSplitView): cdouble =
  adw_navigation_split_view_get_max_sidebar_width(cast[ptr NavigationSplitView00](self.impl))

proc adw_navigation_split_view_get_min_sidebar_width(self: ptr NavigationSplitView00): cdouble {.
    importc, libprag.}

proc getMinSidebarWidth*(self: NavigationSplitView): cdouble =
  adw_navigation_split_view_get_min_sidebar_width(cast[ptr NavigationSplitView00](self.impl))

proc minSidebarWidth*(self: NavigationSplitView): cdouble =
  adw_navigation_split_view_get_min_sidebar_width(cast[ptr NavigationSplitView00](self.impl))

proc adw_navigation_split_view_get_show_content(self: ptr NavigationSplitView00): gboolean {.
    importc, libprag.}

proc getShowContent*(self: NavigationSplitView): bool =
  toBool(adw_navigation_split_view_get_show_content(cast[ptr NavigationSplitView00](self.impl)))

proc showContent*(self: NavigationSplitView): bool =
  toBool(adw_navigation_split_view_get_show_content(cast[ptr NavigationSplitView00](self.impl)))

proc adw_navigation_split_view_get_sidebar(self: ptr NavigationSplitView00): ptr NavigationPage00 {.
    importc, libprag.}

proc getSidebar*(self: NavigationSplitView): NavigationPage =
  let gobj = adw_navigation_split_view_get_sidebar(cast[ptr NavigationSplitView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc sidebar*(self: NavigationSplitView): NavigationPage =
  let gobj = adw_navigation_split_view_get_sidebar(cast[ptr NavigationSplitView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_navigation_split_view_get_sidebar_width_fraction(self: ptr NavigationSplitView00): cdouble {.
    importc, libprag.}

proc getSidebarWidthFraction*(self: NavigationSplitView): cdouble =
  adw_navigation_split_view_get_sidebar_width_fraction(cast[ptr NavigationSplitView00](self.impl))

proc sidebarWidthFraction*(self: NavigationSplitView): cdouble =
  adw_navigation_split_view_get_sidebar_width_fraction(cast[ptr NavigationSplitView00](self.impl))

proc adw_navigation_split_view_get_sidebar_width_unit(self: ptr NavigationSplitView00): LengthUnit {.
    importc, libprag.}

proc getSidebarWidthUnit*(self: NavigationSplitView): LengthUnit =
  adw_navigation_split_view_get_sidebar_width_unit(cast[ptr NavigationSplitView00](self.impl))

proc sidebarWidthUnit*(self: NavigationSplitView): LengthUnit =
  adw_navigation_split_view_get_sidebar_width_unit(cast[ptr NavigationSplitView00](self.impl))

proc adw_navigation_split_view_set_collapsed(self: ptr NavigationSplitView00;
    collapsed: gboolean) {.
    importc, libprag.}

proc setCollapsed*(self: NavigationSplitView; collapsed: bool = true) =
  adw_navigation_split_view_set_collapsed(cast[ptr NavigationSplitView00](self.impl), gboolean(collapsed))

proc `collapsed=`*(self: NavigationSplitView; collapsed: bool) =
  adw_navigation_split_view_set_collapsed(cast[ptr NavigationSplitView00](self.impl), gboolean(collapsed))

proc adw_navigation_split_view_set_content(self: ptr NavigationSplitView00;
    content: ptr NavigationPage00) {.
    importc, libprag.}

proc setContent*(self: NavigationSplitView; content: NavigationPage = nil) =
  adw_navigation_split_view_set_content(cast[ptr NavigationSplitView00](self.impl), if content.isNil: nil else: cast[ptr NavigationPage00](content.impl))

proc `content=`*(self: NavigationSplitView; content: NavigationPage = nil) =
  adw_navigation_split_view_set_content(cast[ptr NavigationSplitView00](self.impl), if content.isNil: nil else: cast[ptr NavigationPage00](content.impl))

proc adw_navigation_split_view_set_max_sidebar_width(self: ptr NavigationSplitView00;
    width: cdouble) {.
    importc, libprag.}

proc setMaxSidebarWidth*(self: NavigationSplitView;
    width: cdouble) =
  adw_navigation_split_view_set_max_sidebar_width(cast[ptr NavigationSplitView00](self.impl), width)

proc `maxSidebarWidth=`*(self: NavigationSplitView;
    width: cdouble) =
  adw_navigation_split_view_set_max_sidebar_width(cast[ptr NavigationSplitView00](self.impl), width)

proc adw_navigation_split_view_set_min_sidebar_width(self: ptr NavigationSplitView00;
    width: cdouble) {.
    importc, libprag.}

proc setMinSidebarWidth*(self: NavigationSplitView;
    width: cdouble) =
  adw_navigation_split_view_set_min_sidebar_width(cast[ptr NavigationSplitView00](self.impl), width)

proc `minSidebarWidth=`*(self: NavigationSplitView;
    width: cdouble) =
  adw_navigation_split_view_set_min_sidebar_width(cast[ptr NavigationSplitView00](self.impl), width)

proc adw_navigation_split_view_set_show_content(self: ptr NavigationSplitView00;
    showContent: gboolean) {.
    importc, libprag.}

proc setShowContent*(self: NavigationSplitView;
    showContent: bool = true) =
  adw_navigation_split_view_set_show_content(cast[ptr NavigationSplitView00](self.impl), gboolean(showContent))

proc `showContent=`*(self: NavigationSplitView;
    showContent: bool) =
  adw_navigation_split_view_set_show_content(cast[ptr NavigationSplitView00](self.impl), gboolean(showContent))

proc adw_navigation_split_view_set_sidebar(self: ptr NavigationSplitView00;
    sidebar: ptr NavigationPage00) {.
    importc, libprag.}

proc setSidebar*(self: NavigationSplitView; sidebar: NavigationPage = nil) =
  adw_navigation_split_view_set_sidebar(cast[ptr NavigationSplitView00](self.impl), if sidebar.isNil: nil else: cast[ptr NavigationPage00](sidebar.impl))

proc `sidebar=`*(self: NavigationSplitView; sidebar: NavigationPage = nil) =
  adw_navigation_split_view_set_sidebar(cast[ptr NavigationSplitView00](self.impl), if sidebar.isNil: nil else: cast[ptr NavigationPage00](sidebar.impl))

proc adw_navigation_split_view_set_sidebar_width_fraction(self: ptr NavigationSplitView00;
    fraction: cdouble) {.
    importc, libprag.}

proc setSidebarWidthFraction*(self: NavigationSplitView;
    fraction: cdouble) =
  adw_navigation_split_view_set_sidebar_width_fraction(cast[ptr NavigationSplitView00](self.impl), fraction)

proc `sidebarWidthFraction=`*(self: NavigationSplitView;
    fraction: cdouble) =
  adw_navigation_split_view_set_sidebar_width_fraction(cast[ptr NavigationSplitView00](self.impl), fraction)

proc adw_navigation_split_view_set_sidebar_width_unit(self: ptr NavigationSplitView00;
    unit: LengthUnit) {.
    importc, libprag.}

proc setSidebarWidthUnit*(self: NavigationSplitView;
    unit: LengthUnit) =
  adw_navigation_split_view_set_sidebar_width_unit(cast[ptr NavigationSplitView00](self.impl), unit)

proc `sidebarWidthUnit=`*(self: NavigationSplitView;
    unit: LengthUnit) =
  adw_navigation_split_view_set_sidebar_width_unit(cast[ptr NavigationSplitView00](self.impl), unit)

type
  NavigationView* = ref object of gtk4.Widget
  NavigationView00* = object of gtk4.Widget00

proc adw_navigation_view_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NavigationView()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scGetNextPage*(self: NavigationView;  p: proc (self: ptr NavigationView00; xdata: pointer): ptr NavigationPage00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "get-next-page", cast[GCallback](p), xdata, nil, cf)

proc scPopped*(self: NavigationView;  p: proc (self: ptr NavigationView00; page: ptr NavigationPage00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "popped", cast[GCallback](p), xdata, nil, cf)

proc scPushed*(self: NavigationView;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "pushed", cast[GCallback](p), xdata, nil, cf)

proc scReplaced*(self: NavigationView;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "replaced", cast[GCallback](p), xdata, nil, cf)

proc adw_navigation_view_new(): ptr NavigationView00 {.
    importc, libprag.}

proc newNavigationView*(): NavigationView =
  let gobj = adw_navigation_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNavigationView*(tdesc: typedesc): tdesc =
  assert(result is NavigationView)
  let gobj = adw_navigation_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNavigationView*[T](result: var T) {.deprecated.} =
  assert(result is NavigationView)
  let gobj = adw_navigation_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_navigation_view_add(self: ptr NavigationView00; page: ptr NavigationPage00) {.
    importc, libprag.}

proc add*(self: NavigationView; page: NavigationPage) =
  adw_navigation_view_add(cast[ptr NavigationView00](self.impl), cast[ptr NavigationPage00](page.impl))

proc adw_navigation_view_find_page(self: ptr NavigationView00; tag: cstring): ptr NavigationPage00 {.
    importc, libprag.}

proc findPage*(self: NavigationView; tag: cstring): NavigationPage =
  let gobj = adw_navigation_view_find_page(cast[ptr NavigationView00](self.impl), tag)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_navigation_view_get_animate_transitions(self: ptr NavigationView00): gboolean {.
    importc, libprag.}

proc getAnimateTransitions*(self: NavigationView): bool =
  toBool(adw_navigation_view_get_animate_transitions(cast[ptr NavigationView00](self.impl)))

proc animateTransitions*(self: NavigationView): bool =
  toBool(adw_navigation_view_get_animate_transitions(cast[ptr NavigationView00](self.impl)))

proc adw_navigation_view_get_navigation_stack(self: ptr NavigationView00): ptr gio.ListModel00 {.
    importc, libprag.}

proc getNavigationStack*(self: NavigationView): gio.ListModel =
  let gobj = adw_navigation_view_get_navigation_stack(cast[ptr NavigationView00](self.impl))
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

proc navigationStack*(self: NavigationView): gio.ListModel =
  let gobj = adw_navigation_view_get_navigation_stack(cast[ptr NavigationView00](self.impl))
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

proc adw_navigation_view_get_pop_on_escape(self: ptr NavigationView00): gboolean {.
    importc, libprag.}

proc getPopOnEscape*(self: NavigationView): bool =
  toBool(adw_navigation_view_get_pop_on_escape(cast[ptr NavigationView00](self.impl)))

proc popOnEscape*(self: NavigationView): bool =
  toBool(adw_navigation_view_get_pop_on_escape(cast[ptr NavigationView00](self.impl)))

proc adw_navigation_view_get_previous_page(self: ptr NavigationView00; page: ptr NavigationPage00): ptr NavigationPage00 {.
    importc, libprag.}

proc getPreviousPage*(self: NavigationView; page: NavigationPage): NavigationPage =
  let gobj = adw_navigation_view_get_previous_page(cast[ptr NavigationView00](self.impl), cast[ptr NavigationPage00](page.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_navigation_view_get_visible_page(self: ptr NavigationView00): ptr NavigationPage00 {.
    importc, libprag.}

proc getVisiblePage*(self: NavigationView): NavigationPage =
  let gobj = adw_navigation_view_get_visible_page(cast[ptr NavigationView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visiblePage*(self: NavigationView): NavigationPage =
  let gobj = adw_navigation_view_get_visible_page(cast[ptr NavigationView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_navigation_view_pop(self: ptr NavigationView00): gboolean {.
    importc, libprag.}

proc pop*(self: NavigationView): bool =
  toBool(adw_navigation_view_pop(cast[ptr NavigationView00](self.impl)))

proc adw_navigation_view_pop_to_page(self: ptr NavigationView00; page: ptr NavigationPage00): gboolean {.
    importc, libprag.}

proc popToPage*(self: NavigationView; page: NavigationPage): bool =
  toBool(adw_navigation_view_pop_to_page(cast[ptr NavigationView00](self.impl), cast[ptr NavigationPage00](page.impl)))

proc adw_navigation_view_pop_to_tag(self: ptr NavigationView00; tag: cstring): gboolean {.
    importc, libprag.}

proc popToTag*(self: NavigationView; tag: cstring): bool =
  toBool(adw_navigation_view_pop_to_tag(cast[ptr NavigationView00](self.impl), tag))

proc adw_navigation_view_push(self: ptr NavigationView00; page: ptr NavigationPage00) {.
    importc, libprag.}

proc push*(self: NavigationView; page: NavigationPage) =
  adw_navigation_view_push(cast[ptr NavigationView00](self.impl), cast[ptr NavigationPage00](page.impl))

proc adw_navigation_view_push_by_tag(self: ptr NavigationView00; tag: cstring) {.
    importc, libprag.}

proc pushByTag*(self: NavigationView; tag: cstring) =
  adw_navigation_view_push_by_tag(cast[ptr NavigationView00](self.impl), tag)

proc adw_navigation_view_remove(self: ptr NavigationView00; page: ptr NavigationPage00) {.
    importc, libprag.}

proc remove*(self: NavigationView; page: NavigationPage) =
  adw_navigation_view_remove(cast[ptr NavigationView00](self.impl), cast[ptr NavigationPage00](page.impl))

proc adw_navigation_view_replace(self: ptr NavigationView00; pages: ptr ptr NavigationPage00;
    nPages: int32) {.
    importc, libprag.}

proc replace*(self: NavigationView; pages: ptr ptr NavigationPage00;
    nPages: int) =
  adw_navigation_view_replace(cast[ptr NavigationView00](self.impl), pages, int32(nPages))

proc adw_navigation_view_replace_with_tags(self: ptr NavigationView00; tags: ptr cstring;
    nTags: int32) {.
    importc, libprag.}

proc replaceWithTags*(self: NavigationView; tags: openArray[string];
    nTags: int) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  adw_navigation_view_replace_with_tags(cast[ptr NavigationView00](self.impl), seq2CstringArray(tags, fs469n23), int32(nTags))

proc adw_navigation_view_set_animate_transitions(self: ptr NavigationView00;
    animateTransitions: gboolean) {.
    importc, libprag.}

proc setAnimateTransitions*(self: NavigationView; animateTransitions: bool = true) =
  adw_navigation_view_set_animate_transitions(cast[ptr NavigationView00](self.impl), gboolean(animateTransitions))

proc `animateTransitions=`*(self: NavigationView; animateTransitions: bool) =
  adw_navigation_view_set_animate_transitions(cast[ptr NavigationView00](self.impl), gboolean(animateTransitions))

proc adw_navigation_view_set_pop_on_escape(self: ptr NavigationView00; popOnEscape: gboolean) {.
    importc, libprag.}

proc setPopOnEscape*(self: NavigationView; popOnEscape: bool = true) =
  adw_navigation_view_set_pop_on_escape(cast[ptr NavigationView00](self.impl), gboolean(popOnEscape))

proc `popOnEscape=`*(self: NavigationView; popOnEscape: bool) =
  adw_navigation_view_set_pop_on_escape(cast[ptr NavigationView00](self.impl), gboolean(popOnEscape))

type
  OverlaySplitView* = ref object of gtk4.Widget
  OverlaySplitView00* = object of gtk4.Widget00

proc adw_overlay_split_view_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(OverlaySplitView()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_overlay_split_view_new(): ptr OverlaySplitView00 {.
    importc, libprag.}

proc newOverlaySplitView*(): OverlaySplitView =
  let gobj = adw_overlay_split_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newOverlaySplitView*(tdesc: typedesc): tdesc =
  assert(result is OverlaySplitView)
  let gobj = adw_overlay_split_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initOverlaySplitView*[T](result: var T) {.deprecated.} =
  assert(result is OverlaySplitView)
  let gobj = adw_overlay_split_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_overlay_split_view_get_collapsed(self: ptr OverlaySplitView00): gboolean {.
    importc, libprag.}

proc getCollapsed*(self: OverlaySplitView): bool =
  toBool(adw_overlay_split_view_get_collapsed(cast[ptr OverlaySplitView00](self.impl)))

proc collapsed*(self: OverlaySplitView): bool =
  toBool(adw_overlay_split_view_get_collapsed(cast[ptr OverlaySplitView00](self.impl)))

proc adw_overlay_split_view_get_content(self: ptr OverlaySplitView00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getContent*(self: OverlaySplitView): gtk4.Widget =
  let gobj = adw_overlay_split_view_get_content(cast[ptr OverlaySplitView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc content*(self: OverlaySplitView): gtk4.Widget =
  let gobj = adw_overlay_split_view_get_content(cast[ptr OverlaySplitView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_overlay_split_view_get_enable_hide_gesture(self: ptr OverlaySplitView00): gboolean {.
    importc, libprag.}

proc getEnableHideGesture*(self: OverlaySplitView): bool =
  toBool(adw_overlay_split_view_get_enable_hide_gesture(cast[ptr OverlaySplitView00](self.impl)))

proc enableHideGesture*(self: OverlaySplitView): bool =
  toBool(adw_overlay_split_view_get_enable_hide_gesture(cast[ptr OverlaySplitView00](self.impl)))

proc adw_overlay_split_view_get_enable_show_gesture(self: ptr OverlaySplitView00): gboolean {.
    importc, libprag.}

proc getEnableShowGesture*(self: OverlaySplitView): bool =
  toBool(adw_overlay_split_view_get_enable_show_gesture(cast[ptr OverlaySplitView00](self.impl)))

proc enableShowGesture*(self: OverlaySplitView): bool =
  toBool(adw_overlay_split_view_get_enable_show_gesture(cast[ptr OverlaySplitView00](self.impl)))

proc adw_overlay_split_view_get_max_sidebar_width(self: ptr OverlaySplitView00): cdouble {.
    importc, libprag.}

proc getMaxSidebarWidth*(self: OverlaySplitView): cdouble =
  adw_overlay_split_view_get_max_sidebar_width(cast[ptr OverlaySplitView00](self.impl))

proc maxSidebarWidth*(self: OverlaySplitView): cdouble =
  adw_overlay_split_view_get_max_sidebar_width(cast[ptr OverlaySplitView00](self.impl))

proc adw_overlay_split_view_get_min_sidebar_width(self: ptr OverlaySplitView00): cdouble {.
    importc, libprag.}

proc getMinSidebarWidth*(self: OverlaySplitView): cdouble =
  adw_overlay_split_view_get_min_sidebar_width(cast[ptr OverlaySplitView00](self.impl))

proc minSidebarWidth*(self: OverlaySplitView): cdouble =
  adw_overlay_split_view_get_min_sidebar_width(cast[ptr OverlaySplitView00](self.impl))

proc adw_overlay_split_view_get_pin_sidebar(self: ptr OverlaySplitView00): gboolean {.
    importc, libprag.}

proc getPinSidebar*(self: OverlaySplitView): bool =
  toBool(adw_overlay_split_view_get_pin_sidebar(cast[ptr OverlaySplitView00](self.impl)))

proc pinSidebar*(self: OverlaySplitView): bool =
  toBool(adw_overlay_split_view_get_pin_sidebar(cast[ptr OverlaySplitView00](self.impl)))

proc adw_overlay_split_view_get_show_sidebar(self: ptr OverlaySplitView00): gboolean {.
    importc, libprag.}

proc getShowSidebar*(self: OverlaySplitView): bool =
  toBool(adw_overlay_split_view_get_show_sidebar(cast[ptr OverlaySplitView00](self.impl)))

proc showSidebar*(self: OverlaySplitView): bool =
  toBool(adw_overlay_split_view_get_show_sidebar(cast[ptr OverlaySplitView00](self.impl)))

proc adw_overlay_split_view_get_sidebar(self: ptr OverlaySplitView00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getSidebar*(self: OverlaySplitView): gtk4.Widget =
  let gobj = adw_overlay_split_view_get_sidebar(cast[ptr OverlaySplitView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc sidebar*(self: OverlaySplitView): gtk4.Widget =
  let gobj = adw_overlay_split_view_get_sidebar(cast[ptr OverlaySplitView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_overlay_split_view_get_sidebar_position(self: ptr OverlaySplitView00): gtk4.PackType {.
    importc, libprag.}

proc getSidebarPosition*(self: OverlaySplitView): gtk4.PackType =
  adw_overlay_split_view_get_sidebar_position(cast[ptr OverlaySplitView00](self.impl))

proc sidebarPosition*(self: OverlaySplitView): gtk4.PackType =
  adw_overlay_split_view_get_sidebar_position(cast[ptr OverlaySplitView00](self.impl))

proc adw_overlay_split_view_get_sidebar_width_fraction(self: ptr OverlaySplitView00): cdouble {.
    importc, libprag.}

proc getSidebarWidthFraction*(self: OverlaySplitView): cdouble =
  adw_overlay_split_view_get_sidebar_width_fraction(cast[ptr OverlaySplitView00](self.impl))

proc sidebarWidthFraction*(self: OverlaySplitView): cdouble =
  adw_overlay_split_view_get_sidebar_width_fraction(cast[ptr OverlaySplitView00](self.impl))

proc adw_overlay_split_view_get_sidebar_width_unit(self: ptr OverlaySplitView00): LengthUnit {.
    importc, libprag.}

proc getSidebarWidthUnit*(self: OverlaySplitView): LengthUnit =
  adw_overlay_split_view_get_sidebar_width_unit(cast[ptr OverlaySplitView00](self.impl))

proc sidebarWidthUnit*(self: OverlaySplitView): LengthUnit =
  adw_overlay_split_view_get_sidebar_width_unit(cast[ptr OverlaySplitView00](self.impl))

proc adw_overlay_split_view_set_collapsed(self: ptr OverlaySplitView00; collapsed: gboolean) {.
    importc, libprag.}

proc setCollapsed*(self: OverlaySplitView; collapsed: bool = true) =
  adw_overlay_split_view_set_collapsed(cast[ptr OverlaySplitView00](self.impl), gboolean(collapsed))

proc `collapsed=`*(self: OverlaySplitView; collapsed: bool) =
  adw_overlay_split_view_set_collapsed(cast[ptr OverlaySplitView00](self.impl), gboolean(collapsed))

proc adw_overlay_split_view_set_content(self: ptr OverlaySplitView00; content: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setContent*(self: OverlaySplitView; content: gtk4.Widget = nil) =
  adw_overlay_split_view_set_content(cast[ptr OverlaySplitView00](self.impl), if content.isNil: nil else: cast[ptr gtk4.Widget00](content.impl))

proc `content=`*(self: OverlaySplitView; content: gtk4.Widget = nil) =
  adw_overlay_split_view_set_content(cast[ptr OverlaySplitView00](self.impl), if content.isNil: nil else: cast[ptr gtk4.Widget00](content.impl))

proc adw_overlay_split_view_set_enable_hide_gesture(self: ptr OverlaySplitView00;
    enableHideGesture: gboolean) {.
    importc, libprag.}

proc setEnableHideGesture*(self: OverlaySplitView;
    enableHideGesture: bool = true) =
  adw_overlay_split_view_set_enable_hide_gesture(cast[ptr OverlaySplitView00](self.impl), gboolean(enableHideGesture))

proc `enableHideGesture=`*(self: OverlaySplitView;
    enableHideGesture: bool) =
  adw_overlay_split_view_set_enable_hide_gesture(cast[ptr OverlaySplitView00](self.impl), gboolean(enableHideGesture))

proc adw_overlay_split_view_set_enable_show_gesture(self: ptr OverlaySplitView00;
    enableShowGesture: gboolean) {.
    importc, libprag.}

proc setEnableShowGesture*(self: OverlaySplitView;
    enableShowGesture: bool = true) =
  adw_overlay_split_view_set_enable_show_gesture(cast[ptr OverlaySplitView00](self.impl), gboolean(enableShowGesture))

proc `enableShowGesture=`*(self: OverlaySplitView;
    enableShowGesture: bool) =
  adw_overlay_split_view_set_enable_show_gesture(cast[ptr OverlaySplitView00](self.impl), gboolean(enableShowGesture))

proc adw_overlay_split_view_set_max_sidebar_width(self: ptr OverlaySplitView00;
    width: cdouble) {.
    importc, libprag.}

proc setMaxSidebarWidth*(self: OverlaySplitView;
    width: cdouble) =
  adw_overlay_split_view_set_max_sidebar_width(cast[ptr OverlaySplitView00](self.impl), width)

proc `maxSidebarWidth=`*(self: OverlaySplitView;
    width: cdouble) =
  adw_overlay_split_view_set_max_sidebar_width(cast[ptr OverlaySplitView00](self.impl), width)

proc adw_overlay_split_view_set_min_sidebar_width(self: ptr OverlaySplitView00;
    width: cdouble) {.
    importc, libprag.}

proc setMinSidebarWidth*(self: OverlaySplitView;
    width: cdouble) =
  adw_overlay_split_view_set_min_sidebar_width(cast[ptr OverlaySplitView00](self.impl), width)

proc `minSidebarWidth=`*(self: OverlaySplitView;
    width: cdouble) =
  adw_overlay_split_view_set_min_sidebar_width(cast[ptr OverlaySplitView00](self.impl), width)

proc adw_overlay_split_view_set_pin_sidebar(self: ptr OverlaySplitView00;
    pinSidebar: gboolean) {.
    importc, libprag.}

proc setPinSidebar*(self: OverlaySplitView; pinSidebar: bool = true) =
  adw_overlay_split_view_set_pin_sidebar(cast[ptr OverlaySplitView00](self.impl), gboolean(pinSidebar))

proc `pinSidebar=`*(self: OverlaySplitView; pinSidebar: bool) =
  adw_overlay_split_view_set_pin_sidebar(cast[ptr OverlaySplitView00](self.impl), gboolean(pinSidebar))

proc adw_overlay_split_view_set_show_sidebar(self: ptr OverlaySplitView00;
    showSidebar: gboolean) {.
    importc, libprag.}

proc setShowSidebar*(self: OverlaySplitView; showSidebar: bool = true) =
  adw_overlay_split_view_set_show_sidebar(cast[ptr OverlaySplitView00](self.impl), gboolean(showSidebar))

proc `showSidebar=`*(self: OverlaySplitView; showSidebar: bool) =
  adw_overlay_split_view_set_show_sidebar(cast[ptr OverlaySplitView00](self.impl), gboolean(showSidebar))

proc adw_overlay_split_view_set_sidebar(self: ptr OverlaySplitView00; sidebar: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setSidebar*(self: OverlaySplitView; sidebar: gtk4.Widget = nil) =
  adw_overlay_split_view_set_sidebar(cast[ptr OverlaySplitView00](self.impl), if sidebar.isNil: nil else: cast[ptr gtk4.Widget00](sidebar.impl))

proc `sidebar=`*(self: OverlaySplitView; sidebar: gtk4.Widget = nil) =
  adw_overlay_split_view_set_sidebar(cast[ptr OverlaySplitView00](self.impl), if sidebar.isNil: nil else: cast[ptr gtk4.Widget00](sidebar.impl))

proc adw_overlay_split_view_set_sidebar_position(self: ptr OverlaySplitView00;
    position: gtk4.PackType) {.
    importc, libprag.}

proc setSidebarPosition*(self: OverlaySplitView;
    position: gtk4.PackType) =
  adw_overlay_split_view_set_sidebar_position(cast[ptr OverlaySplitView00](self.impl), position)

proc `sidebarPosition=`*(self: OverlaySplitView;
    position: gtk4.PackType) =
  adw_overlay_split_view_set_sidebar_position(cast[ptr OverlaySplitView00](self.impl), position)

proc adw_overlay_split_view_set_sidebar_width_fraction(self: ptr OverlaySplitView00;
    fraction: cdouble) {.
    importc, libprag.}

proc setSidebarWidthFraction*(self: OverlaySplitView;
    fraction: cdouble) =
  adw_overlay_split_view_set_sidebar_width_fraction(cast[ptr OverlaySplitView00](self.impl), fraction)

proc `sidebarWidthFraction=`*(self: OverlaySplitView;
    fraction: cdouble) =
  adw_overlay_split_view_set_sidebar_width_fraction(cast[ptr OverlaySplitView00](self.impl), fraction)

proc adw_overlay_split_view_set_sidebar_width_unit(self: ptr OverlaySplitView00;
    unit: LengthUnit) {.
    importc, libprag.}

proc setSidebarWidthUnit*(self: OverlaySplitView;
    unit: LengthUnit) =
  adw_overlay_split_view_set_sidebar_width_unit(cast[ptr OverlaySplitView00](self.impl), unit)

proc `sidebarWidthUnit=`*(self: OverlaySplitView;
    unit: LengthUnit) =
  adw_overlay_split_view_set_sidebar_width_unit(cast[ptr OverlaySplitView00](self.impl), unit)

type
  PasswordEntryRow* = ref object of EntryRow
  PasswordEntryRow00* = object of EntryRow00

proc adw_password_entry_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PasswordEntryRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_password_entry_row_new(): ptr PasswordEntryRow00 {.
    importc, libprag.}

proc newPasswordEntryRow*(): PasswordEntryRow =
  let gobj = adw_password_entry_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPasswordEntryRow*(tdesc: typedesc): tdesc =
  assert(result is PasswordEntryRow)
  let gobj = adw_password_entry_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPasswordEntryRow*[T](result: var T) {.deprecated.} =
  assert(result is PasswordEntryRow)
  let gobj = adw_password_entry_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PreferencesDialog* = ref object of Dialog
  PreferencesDialog00* = object of Dialog00

proc adw_preferences_dialog_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PreferencesDialog()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_preferences_dialog_new(): ptr PreferencesDialog00 {.
    importc, libprag.}

proc newPreferencesDialog*(): PreferencesDialog =
  let gobj = adw_preferences_dialog_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPreferencesDialog*(tdesc: typedesc): tdesc =
  assert(result is PreferencesDialog)
  let gobj = adw_preferences_dialog_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPreferencesDialog*[T](result: var T) {.deprecated.} =
  assert(result is PreferencesDialog)
  let gobj = adw_preferences_dialog_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_preferences_dialog_get_search_enabled(self: ptr PreferencesDialog00): gboolean {.
    importc, libprag.}

proc getSearchEnabled*(self: PreferencesDialog): bool =
  toBool(adw_preferences_dialog_get_search_enabled(cast[ptr PreferencesDialog00](self.impl)))

proc searchEnabled*(self: PreferencesDialog): bool =
  toBool(adw_preferences_dialog_get_search_enabled(cast[ptr PreferencesDialog00](self.impl)))

proc adw_preferences_dialog_get_visible_page_name(self: ptr PreferencesDialog00): cstring {.
    importc, libprag.}

proc getVisiblePageName*(self: PreferencesDialog): string =
  let resul0 = adw_preferences_dialog_get_visible_page_name(cast[ptr PreferencesDialog00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc visiblePageName*(self: PreferencesDialog): string =
  let resul0 = adw_preferences_dialog_get_visible_page_name(cast[ptr PreferencesDialog00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_preferences_dialog_pop_subpage(self: ptr PreferencesDialog00): gboolean {.
    importc, libprag.}

proc popSubpage*(self: PreferencesDialog): bool =
  toBool(adw_preferences_dialog_pop_subpage(cast[ptr PreferencesDialog00](self.impl)))

proc adw_preferences_dialog_push_subpage(self: ptr PreferencesDialog00; page: ptr NavigationPage00) {.
    importc, libprag.}

proc pushSubpage*(self: PreferencesDialog; page: NavigationPage) =
  adw_preferences_dialog_push_subpage(cast[ptr PreferencesDialog00](self.impl), cast[ptr NavigationPage00](page.impl))

proc adw_preferences_dialog_set_search_enabled(self: ptr PreferencesDialog00;
    searchEnabled: gboolean) {.
    importc, libprag.}

proc setSearchEnabled*(self: PreferencesDialog; searchEnabled: bool = true) =
  adw_preferences_dialog_set_search_enabled(cast[ptr PreferencesDialog00](self.impl), gboolean(searchEnabled))

proc `searchEnabled=`*(self: PreferencesDialog; searchEnabled: bool) =
  adw_preferences_dialog_set_search_enabled(cast[ptr PreferencesDialog00](self.impl), gboolean(searchEnabled))

proc adw_preferences_dialog_set_visible_page_name(self: ptr PreferencesDialog00;
    name: cstring) {.
    importc, libprag.}

proc setVisiblePageName*(self: PreferencesDialog;
    name: cstring) =
  adw_preferences_dialog_set_visible_page_name(cast[ptr PreferencesDialog00](self.impl), name)

proc `visiblePageName=`*(self: PreferencesDialog;
    name: cstring) =
  adw_preferences_dialog_set_visible_page_name(cast[ptr PreferencesDialog00](self.impl), name)

type
  Toast* = ref object of gobject.Object
  Toast00* = object of gobject.Object00

proc adw_toast_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Toast()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scButtonClicked*(self: Toast;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "button-clicked", cast[GCallback](p), xdata, nil, cf)

proc scDismissed*(self: Toast;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "dismissed", cast[GCallback](p), xdata, nil, cf)

proc adw_toast_new(title: cstring): ptr Toast00 {.
    importc, libprag.}

proc newToast*(title: cstring): Toast =
  let gobj = adw_toast_new(title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newToast*(tdesc: typedesc; title: cstring): tdesc =
  assert(result is Toast)
  let gobj = adw_toast_new(title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initToast*[T](result: var T; title: cstring) {.deprecated.} =
  assert(result is Toast)
  let gobj = adw_toast_new(title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_toast_dismiss(self: ptr Toast00) {.
    importc, libprag.}

proc dismiss*(self: Toast) =
  adw_toast_dismiss(cast[ptr Toast00](self.impl))

proc adw_toast_get_action_name(self: ptr Toast00): cstring {.
    importc, libprag.}

proc getActionName*(self: Toast): string =
  let resul0 = adw_toast_get_action_name(cast[ptr Toast00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc actionName*(self: Toast): string =
  let resul0 = adw_toast_get_action_name(cast[ptr Toast00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_toast_get_action_target_value(self: ptr Toast00): ptr glib.Variant00 {.
    importc, libprag.}

proc getActionTargetValue*(self: Toast): glib.Variant =
  let impl0 = adw_toast_get_action_target_value(cast[ptr Toast00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, finalizerunref)
  result.impl = impl0
  result.ignoreFinalizer = true # GVariant

proc actionTargetValue*(self: Toast): glib.Variant =
  let impl0 = adw_toast_get_action_target_value(cast[ptr Toast00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, finalizerunref)
  result.impl = impl0
  result.ignoreFinalizer = true # GVariant

proc adw_toast_get_button_label(self: ptr Toast00): cstring {.
    importc, libprag.}

proc getButtonLabel*(self: Toast): string =
  let resul0 = adw_toast_get_button_label(cast[ptr Toast00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc buttonLabel*(self: Toast): string =
  let resul0 = adw_toast_get_button_label(cast[ptr Toast00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_toast_get_custom_title(self: ptr Toast00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getCustomTitle*(self: Toast): gtk4.Widget =
  let gobj = adw_toast_get_custom_title(cast[ptr Toast00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc customTitle*(self: Toast): gtk4.Widget =
  let gobj = adw_toast_get_custom_title(cast[ptr Toast00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_toast_get_timeout(self: ptr Toast00): uint32 {.
    importc, libprag.}

proc getTimeout*(self: Toast): int =
  int(adw_toast_get_timeout(cast[ptr Toast00](self.impl)))

proc timeout*(self: Toast): int =
  int(adw_toast_get_timeout(cast[ptr Toast00](self.impl)))

proc adw_toast_get_title(self: ptr Toast00): cstring {.
    importc, libprag.}

proc getTitle*(self: Toast): string =
  let resul0 = adw_toast_get_title(cast[ptr Toast00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc title*(self: Toast): string =
  let resul0 = adw_toast_get_title(cast[ptr Toast00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_toast_get_use_markup(self: ptr Toast00): gboolean {.
    importc, libprag.}

proc getUseMarkup*(self: Toast): bool =
  toBool(adw_toast_get_use_markup(cast[ptr Toast00](self.impl)))

proc useMarkup*(self: Toast): bool =
  toBool(adw_toast_get_use_markup(cast[ptr Toast00](self.impl)))

proc adw_toast_set_action_name(self: ptr Toast00; actionName: cstring) {.
    importc, libprag.}

proc setActionName*(self: Toast; actionName: cstring = nil) =
  adw_toast_set_action_name(cast[ptr Toast00](self.impl), actionName)

proc `actionName=`*(self: Toast; actionName: cstring = nil) =
  adw_toast_set_action_name(cast[ptr Toast00](self.impl), actionName)

proc adw_toast_set_action_target_value(self: ptr Toast00; actionTarget: ptr glib.Variant00) {.
    importc, libprag.}

proc setActionTargetValue*(self: Toast; actionTarget: glib.Variant = nil) =
  adw_toast_set_action_target_value(cast[ptr Toast00](self.impl), if actionTarget.isNil: nil else: cast[ptr glib.Variant00](actionTarget.impl))

proc `actionTargetValue=`*(self: Toast; actionTarget: glib.Variant = nil) =
  adw_toast_set_action_target_value(cast[ptr Toast00](self.impl), if actionTarget.isNil: nil else: cast[ptr glib.Variant00](actionTarget.impl))

proc adw_toast_set_button_label(self: ptr Toast00; buttonLabel: cstring) {.
    importc, libprag.}

proc setButtonLabel*(self: Toast; buttonLabel: cstring = nil) =
  adw_toast_set_button_label(cast[ptr Toast00](self.impl), buttonLabel)

proc `buttonLabel=`*(self: Toast; buttonLabel: cstring = nil) =
  adw_toast_set_button_label(cast[ptr Toast00](self.impl), buttonLabel)

proc adw_toast_set_custom_title(self: ptr Toast00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setCustomTitle*(self: Toast; widget: gtk4.Widget = nil) =
  adw_toast_set_custom_title(cast[ptr Toast00](self.impl), if widget.isNil: nil else: cast[ptr gtk4.Widget00](widget.impl))

proc `customTitle=`*(self: Toast; widget: gtk4.Widget = nil) =
  adw_toast_set_custom_title(cast[ptr Toast00](self.impl), if widget.isNil: nil else: cast[ptr gtk4.Widget00](widget.impl))

proc adw_toast_set_detailed_action_name(self: ptr Toast00; detailedActionName: cstring) {.
    importc, libprag.}

proc setDetailedActionName*(self: Toast; detailedActionName: cstring = nil) =
  adw_toast_set_detailed_action_name(cast[ptr Toast00](self.impl), detailedActionName)

proc `detailedActionName=`*(self: Toast; detailedActionName: cstring = nil) =
  adw_toast_set_detailed_action_name(cast[ptr Toast00](self.impl), detailedActionName)

proc adw_toast_set_timeout(self: ptr Toast00; timeout: uint32) {.
    importc, libprag.}

proc setTimeout*(self: Toast; timeout: int) =
  adw_toast_set_timeout(cast[ptr Toast00](self.impl), uint32(timeout))

proc `timeout=`*(self: Toast; timeout: int) =
  adw_toast_set_timeout(cast[ptr Toast00](self.impl), uint32(timeout))

proc adw_toast_set_title(self: ptr Toast00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: Toast; title: cstring) =
  adw_toast_set_title(cast[ptr Toast00](self.impl), title)

proc `title=`*(self: Toast; title: cstring) =
  adw_toast_set_title(cast[ptr Toast00](self.impl), title)

proc adw_toast_set_use_markup(self: ptr Toast00; useMarkup: gboolean) {.
    importc, libprag.}

proc setUseMarkup*(self: Toast; useMarkup: bool = true) =
  adw_toast_set_use_markup(cast[ptr Toast00](self.impl), gboolean(useMarkup))

proc `useMarkup=`*(self: Toast; useMarkup: bool) =
  adw_toast_set_use_markup(cast[ptr Toast00](self.impl), gboolean(useMarkup))

proc adw_preferences_dialog_add_toast(self: ptr PreferencesDialog00; toast: ptr Toast00) {.
    importc, libprag.}

proc addToast*(self: PreferencesDialog; toast: Toast) =
  adw_preferences_dialog_add_toast(cast[ptr PreferencesDialog00](self.impl), cast[ptr Toast00](g_object_ref(toast.impl)))

type
  ToastPriority* {.size: sizeof(cint), pure.} = enum
    normal = 0
    high = 1

proc adw_toast_get_priority(self: ptr Toast00): ToastPriority {.
    importc, libprag.}

proc getPriority*(self: Toast): ToastPriority =
  adw_toast_get_priority(cast[ptr Toast00](self.impl))

proc priority*(self: Toast): ToastPriority =
  adw_toast_get_priority(cast[ptr Toast00](self.impl))

proc adw_toast_set_priority(self: ptr Toast00; priority: ToastPriority) {.
    importc, libprag.}

proc setPriority*(self: Toast; priority: ToastPriority) =
  adw_toast_set_priority(cast[ptr Toast00](self.impl), priority)

proc `priority=`*(self: Toast; priority: ToastPriority) =
  adw_toast_set_priority(cast[ptr Toast00](self.impl), priority)

type
  PreferencesPage* = ref object of gtk4.Widget
  PreferencesPage00* = object of gtk4.Widget00

proc adw_preferences_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PreferencesPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_preferences_page_new(): ptr PreferencesPage00 {.
    importc, libprag.}

proc newPreferencesPage*(): PreferencesPage =
  let gobj = adw_preferences_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPreferencesPage*(tdesc: typedesc): tdesc =
  assert(result is PreferencesPage)
  let gobj = adw_preferences_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPreferencesPage*[T](result: var T) {.deprecated.} =
  assert(result is PreferencesPage)
  let gobj = adw_preferences_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_preferences_page_get_description(self: ptr PreferencesPage00): cstring {.
    importc, libprag.}

proc getDescription*(self: PreferencesPage): string =
  result = $adw_preferences_page_get_description(cast[ptr PreferencesPage00](self.impl))

proc description*(self: PreferencesPage): string =
  result = $adw_preferences_page_get_description(cast[ptr PreferencesPage00](self.impl))

proc adw_preferences_page_get_icon_name(self: ptr PreferencesPage00): cstring {.
    importc, libprag.}

proc getIconName*(self: PreferencesPage): string =
  let resul0 = adw_preferences_page_get_icon_name(cast[ptr PreferencesPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: PreferencesPage): string =
  let resul0 = adw_preferences_page_get_icon_name(cast[ptr PreferencesPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_preferences_page_get_name(self: ptr PreferencesPage00): cstring {.
    importc, libprag.}

proc getName*(self: PreferencesPage): string =
  let resul0 = adw_preferences_page_get_name(cast[ptr PreferencesPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc name*(self: PreferencesPage): string =
  let resul0 = adw_preferences_page_get_name(cast[ptr PreferencesPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_preferences_page_get_title(self: ptr PreferencesPage00): cstring {.
    importc, libprag.}

proc getTitle*(self: PreferencesPage): string =
  result = $adw_preferences_page_get_title(cast[ptr PreferencesPage00](self.impl))

proc title*(self: PreferencesPage): string =
  result = $adw_preferences_page_get_title(cast[ptr PreferencesPage00](self.impl))

proc adw_preferences_page_get_use_underline(self: ptr PreferencesPage00): gboolean {.
    importc, libprag.}

proc getUseUnderline*(self: PreferencesPage): bool =
  toBool(adw_preferences_page_get_use_underline(cast[ptr PreferencesPage00](self.impl)))

proc useUnderline*(self: PreferencesPage): bool =
  toBool(adw_preferences_page_get_use_underline(cast[ptr PreferencesPage00](self.impl)))

proc adw_preferences_page_scroll_to_top(self: ptr PreferencesPage00) {.
    importc, libprag.}

proc scrollToTop*(self: PreferencesPage) =
  adw_preferences_page_scroll_to_top(cast[ptr PreferencesPage00](self.impl))

proc adw_preferences_page_set_description(self: ptr PreferencesPage00; description: cstring) {.
    importc, libprag.}

proc setDescription*(self: PreferencesPage; description: cstring) =
  adw_preferences_page_set_description(cast[ptr PreferencesPage00](self.impl), description)

proc `description=`*(self: PreferencesPage; description: cstring) =
  adw_preferences_page_set_description(cast[ptr PreferencesPage00](self.impl), description)

proc adw_preferences_page_set_icon_name(self: ptr PreferencesPage00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: PreferencesPage; iconName: cstring = nil) =
  adw_preferences_page_set_icon_name(cast[ptr PreferencesPage00](self.impl), iconName)

proc `iconName=`*(self: PreferencesPage; iconName: cstring = nil) =
  adw_preferences_page_set_icon_name(cast[ptr PreferencesPage00](self.impl), iconName)

proc adw_preferences_page_set_name(self: ptr PreferencesPage00; name: cstring) {.
    importc, libprag.}

proc setName*(self: PreferencesPage; name: cstring = nil) =
  adw_preferences_page_set_name(cast[ptr PreferencesPage00](self.impl), name)

proc `name=`*(self: PreferencesPage; name: cstring = nil) =
  adw_preferences_page_set_name(cast[ptr PreferencesPage00](self.impl), name)

proc adw_preferences_page_set_title(self: ptr PreferencesPage00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: PreferencesPage; title: cstring) =
  adw_preferences_page_set_title(cast[ptr PreferencesPage00](self.impl), title)

proc `title=`*(self: PreferencesPage; title: cstring) =
  adw_preferences_page_set_title(cast[ptr PreferencesPage00](self.impl), title)

proc adw_preferences_page_set_use_underline(self: ptr PreferencesPage00;
    useUnderline: gboolean) {.
    importc, libprag.}

proc setUseUnderline*(self: PreferencesPage; useUnderline: bool = true) =
  adw_preferences_page_set_use_underline(cast[ptr PreferencesPage00](self.impl), gboolean(useUnderline))

proc `useUnderline=`*(self: PreferencesPage; useUnderline: bool) =
  adw_preferences_page_set_use_underline(cast[ptr PreferencesPage00](self.impl), gboolean(useUnderline))

proc adw_preferences_dialog_add(self: ptr PreferencesDialog00; page: ptr PreferencesPage00) {.
    importc, libprag.}

proc add*(self: PreferencesDialog; page: PreferencesPage) =
  adw_preferences_dialog_add(cast[ptr PreferencesDialog00](self.impl), cast[ptr PreferencesPage00](page.impl))

proc adw_preferences_dialog_get_visible_page(self: ptr PreferencesDialog00): ptr PreferencesPage00 {.
    importc, libprag.}

proc getVisiblePage*(self: PreferencesDialog): PreferencesPage =
  let gobj = adw_preferences_dialog_get_visible_page(cast[ptr PreferencesDialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visiblePage*(self: PreferencesDialog): PreferencesPage =
  let gobj = adw_preferences_dialog_get_visible_page(cast[ptr PreferencesDialog00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_preferences_dialog_remove(self: ptr PreferencesDialog00; page: ptr PreferencesPage00) {.
    importc, libprag.}

proc remove*(self: PreferencesDialog; page: PreferencesPage) =
  adw_preferences_dialog_remove(cast[ptr PreferencesDialog00](self.impl), cast[ptr PreferencesPage00](page.impl))

proc adw_preferences_dialog_set_visible_page(self: ptr PreferencesDialog00;
    page: ptr PreferencesPage00) {.
    importc, libprag.}

proc setVisiblePage*(self: PreferencesDialog; page: PreferencesPage) =
  adw_preferences_dialog_set_visible_page(cast[ptr PreferencesDialog00](self.impl), cast[ptr PreferencesPage00](page.impl))

proc `visiblePage=`*(self: PreferencesDialog; page: PreferencesPage) =
  adw_preferences_dialog_set_visible_page(cast[ptr PreferencesDialog00](self.impl), cast[ptr PreferencesPage00](page.impl))

type
  PreferencesGroup* = ref object of gtk4.Widget
  PreferencesGroup00* = object of gtk4.Widget00

proc adw_preferences_group_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PreferencesGroup()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_preferences_group_new(): ptr PreferencesGroup00 {.
    importc, libprag.}

proc newPreferencesGroup*(): PreferencesGroup =
  let gobj = adw_preferences_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPreferencesGroup*(tdesc: typedesc): tdesc =
  assert(result is PreferencesGroup)
  let gobj = adw_preferences_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPreferencesGroup*[T](result: var T) {.deprecated.} =
  assert(result is PreferencesGroup)
  let gobj = adw_preferences_group_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_preferences_group_add(self: ptr PreferencesGroup00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc add*(self: PreferencesGroup; child: gtk4.Widget) =
  adw_preferences_group_add(cast[ptr PreferencesGroup00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_preferences_group_get_description(self: ptr PreferencesGroup00): cstring {.
    importc, libprag.}

proc getDescription*(self: PreferencesGroup): string =
  let resul0 = adw_preferences_group_get_description(cast[ptr PreferencesGroup00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc description*(self: PreferencesGroup): string =
  let resul0 = adw_preferences_group_get_description(cast[ptr PreferencesGroup00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_preferences_group_get_header_suffix(self: ptr PreferencesGroup00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getHeaderSuffix*(self: PreferencesGroup): gtk4.Widget =
  let gobj = adw_preferences_group_get_header_suffix(cast[ptr PreferencesGroup00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc headerSuffix*(self: PreferencesGroup): gtk4.Widget =
  let gobj = adw_preferences_group_get_header_suffix(cast[ptr PreferencesGroup00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_preferences_group_get_title(self: ptr PreferencesGroup00): cstring {.
    importc, libprag.}

proc getTitle*(self: PreferencesGroup): string =
  result = $adw_preferences_group_get_title(cast[ptr PreferencesGroup00](self.impl))

proc title*(self: PreferencesGroup): string =
  result = $adw_preferences_group_get_title(cast[ptr PreferencesGroup00](self.impl))

proc adw_preferences_group_remove(self: ptr PreferencesGroup00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: PreferencesGroup; child: gtk4.Widget) =
  adw_preferences_group_remove(cast[ptr PreferencesGroup00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_preferences_group_set_description(self: ptr PreferencesGroup00;
    description: cstring) {.
    importc, libprag.}

proc setDescription*(self: PreferencesGroup; description: cstring = nil) =
  adw_preferences_group_set_description(cast[ptr PreferencesGroup00](self.impl), description)

proc `description=`*(self: PreferencesGroup; description: cstring = nil) =
  adw_preferences_group_set_description(cast[ptr PreferencesGroup00](self.impl), description)

proc adw_preferences_group_set_header_suffix(self: ptr PreferencesGroup00;
    suffix: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setHeaderSuffix*(self: PreferencesGroup; suffix: gtk4.Widget = nil) =
  adw_preferences_group_set_header_suffix(cast[ptr PreferencesGroup00](self.impl), if suffix.isNil: nil else: cast[ptr gtk4.Widget00](suffix.impl))

proc `headerSuffix=`*(self: PreferencesGroup; suffix: gtk4.Widget = nil) =
  adw_preferences_group_set_header_suffix(cast[ptr PreferencesGroup00](self.impl), if suffix.isNil: nil else: cast[ptr gtk4.Widget00](suffix.impl))

proc adw_preferences_group_set_title(self: ptr PreferencesGroup00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: PreferencesGroup; title: cstring) =
  adw_preferences_group_set_title(cast[ptr PreferencesGroup00](self.impl), title)

proc `title=`*(self: PreferencesGroup; title: cstring) =
  adw_preferences_group_set_title(cast[ptr PreferencesGroup00](self.impl), title)

proc adw_preferences_page_add(self: ptr PreferencesPage00; group: ptr PreferencesGroup00) {.
    importc, libprag.}

proc add*(self: PreferencesPage; group: PreferencesGroup) =
  adw_preferences_page_add(cast[ptr PreferencesPage00](self.impl), cast[ptr PreferencesGroup00](group.impl))

proc adw_preferences_page_remove(self: ptr PreferencesPage00; group: ptr PreferencesGroup00) {.
    importc, libprag.}

proc remove*(self: PreferencesPage; group: PreferencesGroup) =
  adw_preferences_page_remove(cast[ptr PreferencesPage00](self.impl), cast[ptr PreferencesGroup00](group.impl))

type
  PreferencesWindow* = ref object of Window
  PreferencesWindow00* = object of Window00

proc adw_preferences_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PreferencesWindow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_preferences_window_new(): ptr PreferencesWindow00 {.
    importc, libprag.}

proc newPreferencesWindow*(): PreferencesWindow =
  let gobj = adw_preferences_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPreferencesWindow*(tdesc: typedesc): tdesc =
  assert(result is PreferencesWindow)
  let gobj = adw_preferences_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPreferencesWindow*[T](result: var T) {.deprecated.} =
  assert(result is PreferencesWindow)
  let gobj = adw_preferences_window_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_preferences_window_add(self: ptr PreferencesWindow00; page: ptr PreferencesPage00) {.
    importc, libprag.}

proc add*(self: PreferencesWindow; page: PreferencesPage) =
  adw_preferences_window_add(cast[ptr PreferencesWindow00](self.impl), cast[ptr PreferencesPage00](page.impl))

proc adw_preferences_window_add_toast(self: ptr PreferencesWindow00; toast: ptr Toast00) {.
    importc, libprag.}

proc addToast*(self: PreferencesWindow; toast: Toast) =
  adw_preferences_window_add_toast(cast[ptr PreferencesWindow00](self.impl), cast[ptr Toast00](g_object_ref(toast.impl)))

proc adw_preferences_window_close_subpage(self: ptr PreferencesWindow00) {.
    importc, libprag.}

proc closeSubpage*(self: PreferencesWindow) =
  adw_preferences_window_close_subpage(cast[ptr PreferencesWindow00](self.impl))

proc adw_preferences_window_get_can_navigate_back(self: ptr PreferencesWindow00): gboolean {.
    importc, libprag.}

proc getCanNavigateBack*(self: PreferencesWindow): bool =
  toBool(adw_preferences_window_get_can_navigate_back(cast[ptr PreferencesWindow00](self.impl)))

proc canNavigateBack*(self: PreferencesWindow): bool =
  toBool(adw_preferences_window_get_can_navigate_back(cast[ptr PreferencesWindow00](self.impl)))

proc adw_preferences_window_get_search_enabled(self: ptr PreferencesWindow00): gboolean {.
    importc, libprag.}

proc getSearchEnabled*(self: PreferencesWindow): bool =
  toBool(adw_preferences_window_get_search_enabled(cast[ptr PreferencesWindow00](self.impl)))

proc searchEnabled*(self: PreferencesWindow): bool =
  toBool(adw_preferences_window_get_search_enabled(cast[ptr PreferencesWindow00](self.impl)))

proc adw_preferences_window_get_visible_page(self: ptr PreferencesWindow00): ptr PreferencesPage00 {.
    importc, libprag.}

proc getVisiblePage*(self: PreferencesWindow): PreferencesPage =
  let gobj = adw_preferences_window_get_visible_page(cast[ptr PreferencesWindow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visiblePage*(self: PreferencesWindow): PreferencesPage =
  let gobj = adw_preferences_window_get_visible_page(cast[ptr PreferencesWindow00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_preferences_window_get_visible_page_name(self: ptr PreferencesWindow00): cstring {.
    importc, libprag.}

proc getVisiblePageName*(self: PreferencesWindow): string =
  let resul0 = adw_preferences_window_get_visible_page_name(cast[ptr PreferencesWindow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc visiblePageName*(self: PreferencesWindow): string =
  let resul0 = adw_preferences_window_get_visible_page_name(cast[ptr PreferencesWindow00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_preferences_window_pop_subpage(self: ptr PreferencesWindow00): gboolean {.
    importc, libprag.}

proc popSubpage*(self: PreferencesWindow): bool =
  toBool(adw_preferences_window_pop_subpage(cast[ptr PreferencesWindow00](self.impl)))

proc adw_preferences_window_present_subpage(self: ptr PreferencesWindow00;
    subpage: ptr gtk4.Widget00) {.
    importc, libprag.}

proc presentSubpage*(self: PreferencesWindow; subpage: gtk4.Widget) =
  adw_preferences_window_present_subpage(cast[ptr PreferencesWindow00](self.impl), cast[ptr gtk4.Widget00](subpage.impl))

proc adw_preferences_window_push_subpage(self: ptr PreferencesWindow00; page: ptr NavigationPage00) {.
    importc, libprag.}

proc pushSubpage*(self: PreferencesWindow; page: NavigationPage) =
  adw_preferences_window_push_subpage(cast[ptr PreferencesWindow00](self.impl), cast[ptr NavigationPage00](page.impl))

proc adw_preferences_window_remove(self: ptr PreferencesWindow00; page: ptr PreferencesPage00) {.
    importc, libprag.}

proc remove*(self: PreferencesWindow; page: PreferencesPage) =
  adw_preferences_window_remove(cast[ptr PreferencesWindow00](self.impl), cast[ptr PreferencesPage00](page.impl))

proc adw_preferences_window_set_can_navigate_back(self: ptr PreferencesWindow00;
    canNavigateBack: gboolean) {.
    importc, libprag.}

proc setCanNavigateBack*(self: PreferencesWindow;
    canNavigateBack: bool = true) =
  adw_preferences_window_set_can_navigate_back(cast[ptr PreferencesWindow00](self.impl), gboolean(canNavigateBack))

proc `canNavigateBack=`*(self: PreferencesWindow;
    canNavigateBack: bool) =
  adw_preferences_window_set_can_navigate_back(cast[ptr PreferencesWindow00](self.impl), gboolean(canNavigateBack))

proc adw_preferences_window_set_search_enabled(self: ptr PreferencesWindow00;
    searchEnabled: gboolean) {.
    importc, libprag.}

proc setSearchEnabled*(self: PreferencesWindow; searchEnabled: bool = true) =
  adw_preferences_window_set_search_enabled(cast[ptr PreferencesWindow00](self.impl), gboolean(searchEnabled))

proc `searchEnabled=`*(self: PreferencesWindow; searchEnabled: bool) =
  adw_preferences_window_set_search_enabled(cast[ptr PreferencesWindow00](self.impl), gboolean(searchEnabled))

proc adw_preferences_window_set_visible_page(self: ptr PreferencesWindow00;
    page: ptr PreferencesPage00) {.
    importc, libprag.}

proc setVisiblePage*(self: PreferencesWindow; page: PreferencesPage) =
  adw_preferences_window_set_visible_page(cast[ptr PreferencesWindow00](self.impl), cast[ptr PreferencesPage00](page.impl))

proc `visiblePage=`*(self: PreferencesWindow; page: PreferencesPage) =
  adw_preferences_window_set_visible_page(cast[ptr PreferencesWindow00](self.impl), cast[ptr PreferencesPage00](page.impl))

proc adw_preferences_window_set_visible_page_name(self: ptr PreferencesWindow00;
    name: cstring) {.
    importc, libprag.}

proc setVisiblePageName*(self: PreferencesWindow;
    name: cstring) =
  adw_preferences_window_set_visible_page_name(cast[ptr PreferencesWindow00](self.impl), name)

proc `visiblePageName=`*(self: PreferencesWindow;
    name: cstring) =
  adw_preferences_window_set_visible_page_name(cast[ptr PreferencesWindow00](self.impl), name)

type
  PropertyAnimationTarget* = ref object of AnimationTarget
  PropertyAnimationTarget00* = object of AnimationTarget00

proc adw_property_animation_target_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PropertyAnimationTarget()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_property_animation_target_new(obj: ptr gobject.Object00; propertyName: cstring): ptr PropertyAnimationTarget00 {.
    importc, libprag.}

proc newPropertyAnimationTarget*(obj: gobject.Object; propertyName: cstring): PropertyAnimationTarget =
  let gobj = adw_property_animation_target_new(cast[ptr gobject.Object00](obj.impl), propertyName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPropertyAnimationTarget*(tdesc: typedesc; obj: gobject.Object; propertyName: cstring): tdesc =
  assert(result is PropertyAnimationTarget)
  let gobj = adw_property_animation_target_new(cast[ptr gobject.Object00](obj.impl), propertyName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPropertyAnimationTarget*[T](result: var T; obj: gobject.Object; propertyName: cstring) {.deprecated.} =
  assert(result is PropertyAnimationTarget)
  let gobj = adw_property_animation_target_new(cast[ptr gobject.Object00](obj.impl), propertyName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_property_animation_target_new_for_pspec(obj: ptr gobject.Object00;
    pspec: ptr gobject.ParamSpec00): ptr PropertyAnimationTarget00 {.
    importc, libprag.}

proc newPropertyAnimationTargetForPspec*(obj: gobject.Object; pspec: gobject.ParamSpec): PropertyAnimationTarget =
  let gobj = adw_property_animation_target_new_for_pspec(cast[ptr gobject.Object00](obj.impl), cast[ptr gobject.ParamSpec00](pspec.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPropertyAnimationTargetForPspec*(tdesc: typedesc; obj: gobject.Object; pspec: gobject.ParamSpec): tdesc =
  assert(result is PropertyAnimationTarget)
  let gobj = adw_property_animation_target_new_for_pspec(cast[ptr gobject.Object00](obj.impl), cast[ptr gobject.ParamSpec00](pspec.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPropertyAnimationTargetForPspec*[T](result: var T; obj: gobject.Object; pspec: gobject.ParamSpec) {.deprecated.} =
  assert(result is PropertyAnimationTarget)
  let gobj = adw_property_animation_target_new_for_pspec(cast[ptr gobject.Object00](obj.impl), cast[ptr gobject.ParamSpec00](pspec.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_property_animation_target_get_object(self: ptr PropertyAnimationTarget00): ptr gobject.Object00 {.
    importc, libprag.}

proc getObject*(self: PropertyAnimationTarget): gobject.Object =
  let gobj = adw_property_animation_target_get_object(cast[ptr PropertyAnimationTarget00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_property_animation_target_get_pspec(self: ptr PropertyAnimationTarget00): ptr gobject.ParamSpec00 {.
    importc, libprag.}

proc getPspec*(self: PropertyAnimationTarget): gobject.ParamSpec =
  fnew(result, generic_g_param_spec_unref)
  result.impl = adw_property_animation_target_get_pspec(cast[ptr PropertyAnimationTarget00](self.impl))
  result.impl = cast[typeof(result.impl)](g_param_spec_ref_sink(result.impl))

proc pspec*(self: PropertyAnimationTarget): gobject.ParamSpec =
  fnew(result, generic_g_param_spec_unref)
  result.impl = adw_property_animation_target_get_pspec(cast[ptr PropertyAnimationTarget00](self.impl))
  result.impl = cast[typeof(result.impl)](g_param_spec_ref_sink(result.impl))

type
  SpinRow* = ref object of ActionRow
  SpinRow00* = object of ActionRow00

proc adw_spin_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SpinRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scInput*(self: SpinRow;  p: proc (self: ptr SpinRow00; newValue: var cdouble; xdata: pointer): int32 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "input", cast[GCallback](p), xdata, nil, cf)

proc scOutput*(self: SpinRow;  p: proc (self: ptr SpinRow00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "output", cast[GCallback](p), xdata, nil, cf)

proc scWrapped*(self: SpinRow;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrapped", cast[GCallback](p), xdata, nil, cf)

proc adw_spin_row_new(adjustment: ptr gtk4.Adjustment00; climbRate: cdouble;
    digits: uint32): ptr SpinRow00 {.
    importc, libprag.}

proc newSpinRow*(adjustment: gtk4.Adjustment = nil; climbRate: cdouble;
    digits: int): SpinRow =
  let gobj = adw_spin_row_new(if adjustment.isNil: nil else: cast[ptr gtk4.Adjustment00](adjustment.impl), climbRate, uint32(digits))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSpinRow*(tdesc: typedesc; adjustment: gtk4.Adjustment = nil; climbRate: cdouble;
    digits: int): tdesc =
  assert(result is SpinRow)
  let gobj = adw_spin_row_new(if adjustment.isNil: nil else: cast[ptr gtk4.Adjustment00](adjustment.impl), climbRate, uint32(digits))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSpinRow*[T](result: var T; adjustment: gtk4.Adjustment = nil; climbRate: cdouble;
    digits: int) {.deprecated.} =
  assert(result is SpinRow)
  let gobj = adw_spin_row_new(if adjustment.isNil: nil else: cast[ptr gtk4.Adjustment00](adjustment.impl), climbRate, uint32(digits))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_spin_row_new_with_range(min: cdouble; max: cdouble; step: cdouble): ptr SpinRow00 {.
    importc, libprag.}

proc newSpinRowWithRange*(min: cdouble; max: cdouble; step: cdouble): SpinRow =
  let gobj = adw_spin_row_new_with_range(min, max, step)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSpinRowWithRange*(tdesc: typedesc; min: cdouble; max: cdouble; step: cdouble): tdesc =
  assert(result is SpinRow)
  let gobj = adw_spin_row_new_with_range(min, max, step)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSpinRowWithRange*[T](result: var T; min: cdouble; max: cdouble; step: cdouble) {.deprecated.} =
  assert(result is SpinRow)
  let gobj = adw_spin_row_new_with_range(min, max, step)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_spin_row_configure(self: ptr SpinRow00; adjustment: ptr gtk4.Adjustment00;
    climbRate: cdouble; digits: uint32) {.
    importc, libprag.}

proc configure*(self: SpinRow; adjustment: gtk4.Adjustment = nil;
    climbRate: cdouble; digits: int) =
  adw_spin_row_configure(cast[ptr SpinRow00](self.impl), if adjustment.isNil: nil else: cast[ptr gtk4.Adjustment00](adjustment.impl), climbRate, uint32(digits))

proc adw_spin_row_get_adjustment(self: ptr SpinRow00): ptr gtk4.Adjustment00 {.
    importc, libprag.}

proc getAdjustment*(self: SpinRow): gtk4.Adjustment =
  let gobj = adw_spin_row_get_adjustment(cast[ptr SpinRow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adjustment*(self: SpinRow): gtk4.Adjustment =
  let gobj = adw_spin_row_get_adjustment(cast[ptr SpinRow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_spin_row_get_climb_rate(self: ptr SpinRow00): cdouble {.
    importc, libprag.}

proc getClimbRate*(self: SpinRow): cdouble =
  adw_spin_row_get_climb_rate(cast[ptr SpinRow00](self.impl))

proc climbRate*(self: SpinRow): cdouble =
  adw_spin_row_get_climb_rate(cast[ptr SpinRow00](self.impl))

proc adw_spin_row_get_digits(self: ptr SpinRow00): uint32 {.
    importc, libprag.}

proc getDigits*(self: SpinRow): int =
  int(adw_spin_row_get_digits(cast[ptr SpinRow00](self.impl)))

proc digits*(self: SpinRow): int =
  int(adw_spin_row_get_digits(cast[ptr SpinRow00](self.impl)))

proc adw_spin_row_get_numeric(self: ptr SpinRow00): gboolean {.
    importc, libprag.}

proc getNumeric*(self: SpinRow): bool =
  toBool(adw_spin_row_get_numeric(cast[ptr SpinRow00](self.impl)))

proc numeric*(self: SpinRow): bool =
  toBool(adw_spin_row_get_numeric(cast[ptr SpinRow00](self.impl)))

proc adw_spin_row_get_snap_to_ticks(self: ptr SpinRow00): gboolean {.
    importc, libprag.}

proc getSnapToTicks*(self: SpinRow): bool =
  toBool(adw_spin_row_get_snap_to_ticks(cast[ptr SpinRow00](self.impl)))

proc snapToTicks*(self: SpinRow): bool =
  toBool(adw_spin_row_get_snap_to_ticks(cast[ptr SpinRow00](self.impl)))

proc adw_spin_row_get_update_policy(self: ptr SpinRow00): gtk4.SpinButtonUpdatePolicy {.
    importc, libprag.}

proc getUpdatePolicy*(self: SpinRow): gtk4.SpinButtonUpdatePolicy =
  adw_spin_row_get_update_policy(cast[ptr SpinRow00](self.impl))

proc updatePolicy*(self: SpinRow): gtk4.SpinButtonUpdatePolicy =
  adw_spin_row_get_update_policy(cast[ptr SpinRow00](self.impl))

proc adw_spin_row_get_value(self: ptr SpinRow00): cdouble {.
    importc, libprag.}

proc getValue*(self: SpinRow): cdouble =
  adw_spin_row_get_value(cast[ptr SpinRow00](self.impl))

proc value*(self: SpinRow): cdouble =
  adw_spin_row_get_value(cast[ptr SpinRow00](self.impl))

proc adw_spin_row_get_wrap(self: ptr SpinRow00): gboolean {.
    importc, libprag.}

proc getWrap*(self: SpinRow): bool =
  toBool(adw_spin_row_get_wrap(cast[ptr SpinRow00](self.impl)))

proc wrap*(self: SpinRow): bool =
  toBool(adw_spin_row_get_wrap(cast[ptr SpinRow00](self.impl)))

proc adw_spin_row_set_adjustment(self: ptr SpinRow00; adjustment: ptr gtk4.Adjustment00) {.
    importc, libprag.}

proc setAdjustment*(self: SpinRow; adjustment: gtk4.Adjustment = nil) =
  adw_spin_row_set_adjustment(cast[ptr SpinRow00](self.impl), if adjustment.isNil: nil else: cast[ptr gtk4.Adjustment00](adjustment.impl))

proc `adjustment=`*(self: SpinRow; adjustment: gtk4.Adjustment = nil) =
  adw_spin_row_set_adjustment(cast[ptr SpinRow00](self.impl), if adjustment.isNil: nil else: cast[ptr gtk4.Adjustment00](adjustment.impl))

proc adw_spin_row_set_climb_rate(self: ptr SpinRow00; climbRate: cdouble) {.
    importc, libprag.}

proc setClimbRate*(self: SpinRow; climbRate: cdouble) =
  adw_spin_row_set_climb_rate(cast[ptr SpinRow00](self.impl), climbRate)

proc `climbRate=`*(self: SpinRow; climbRate: cdouble) =
  adw_spin_row_set_climb_rate(cast[ptr SpinRow00](self.impl), climbRate)

proc adw_spin_row_set_digits(self: ptr SpinRow00; digits: uint32) {.
    importc, libprag.}

proc setDigits*(self: SpinRow; digits: int) =
  adw_spin_row_set_digits(cast[ptr SpinRow00](self.impl), uint32(digits))

proc `digits=`*(self: SpinRow; digits: int) =
  adw_spin_row_set_digits(cast[ptr SpinRow00](self.impl), uint32(digits))

proc adw_spin_row_set_numeric(self: ptr SpinRow00; numeric: gboolean) {.
    importc, libprag.}

proc setNumeric*(self: SpinRow; numeric: bool = true) =
  adw_spin_row_set_numeric(cast[ptr SpinRow00](self.impl), gboolean(numeric))

proc `numeric=`*(self: SpinRow; numeric: bool) =
  adw_spin_row_set_numeric(cast[ptr SpinRow00](self.impl), gboolean(numeric))

proc adw_spin_row_set_range(self: ptr SpinRow00; min: cdouble; max: cdouble) {.
    importc, libprag.}

proc setRange*(self: SpinRow; min: cdouble; max: cdouble) =
  adw_spin_row_set_range(cast[ptr SpinRow00](self.impl), min, max)

proc adw_spin_row_set_snap_to_ticks(self: ptr SpinRow00; snapToTicks: gboolean) {.
    importc, libprag.}

proc setSnapToTicks*(self: SpinRow; snapToTicks: bool = true) =
  adw_spin_row_set_snap_to_ticks(cast[ptr SpinRow00](self.impl), gboolean(snapToTicks))

proc `snapToTicks=`*(self: SpinRow; snapToTicks: bool) =
  adw_spin_row_set_snap_to_ticks(cast[ptr SpinRow00](self.impl), gboolean(snapToTicks))

proc adw_spin_row_set_update_policy(self: ptr SpinRow00; policy: gtk4.SpinButtonUpdatePolicy) {.
    importc, libprag.}

proc setUpdatePolicy*(self: SpinRow; policy: gtk4.SpinButtonUpdatePolicy) =
  adw_spin_row_set_update_policy(cast[ptr SpinRow00](self.impl), policy)

proc `updatePolicy=`*(self: SpinRow; policy: gtk4.SpinButtonUpdatePolicy) =
  adw_spin_row_set_update_policy(cast[ptr SpinRow00](self.impl), policy)

proc adw_spin_row_set_value(self: ptr SpinRow00; value: cdouble) {.
    importc, libprag.}

proc setValue*(self: SpinRow; value: cdouble) =
  adw_spin_row_set_value(cast[ptr SpinRow00](self.impl), value)

proc `value=`*(self: SpinRow; value: cdouble) =
  adw_spin_row_set_value(cast[ptr SpinRow00](self.impl), value)

proc adw_spin_row_set_wrap(self: ptr SpinRow00; wrap: gboolean) {.
    importc, libprag.}

proc setWrap*(self: SpinRow; wrap: bool = true) =
  adw_spin_row_set_wrap(cast[ptr SpinRow00](self.impl), gboolean(wrap))

proc `wrap=`*(self: SpinRow; wrap: bool) =
  adw_spin_row_set_wrap(cast[ptr SpinRow00](self.impl), gboolean(wrap))

proc adw_spin_row_update(self: ptr SpinRow00) {.
    importc, libprag.}

proc update*(self: SpinRow) =
  adw_spin_row_update(cast[ptr SpinRow00](self.impl))

type
  SplitButton* = ref object of gtk4.Widget
  SplitButton00* = object of gtk4.Widget00

proc adw_split_button_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SplitButton()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActivate*(self: SplitButton;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "activate", cast[GCallback](p), xdata, nil, cf)

proc scClicked*(self: SplitButton;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "clicked", cast[GCallback](p), xdata, nil, cf)

proc adw_split_button_new(): ptr SplitButton00 {.
    importc, libprag.}

proc newSplitButton*(): SplitButton =
  let gobj = adw_split_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSplitButton*(tdesc: typedesc): tdesc =
  assert(result is SplitButton)
  let gobj = adw_split_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSplitButton*[T](result: var T) {.deprecated.} =
  assert(result is SplitButton)
  let gobj = adw_split_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_split_button_get_can_shrink(self: ptr SplitButton00): gboolean {.
    importc, libprag.}

proc getCanShrink*(self: SplitButton): bool =
  toBool(adw_split_button_get_can_shrink(cast[ptr SplitButton00](self.impl)))

proc canShrink*(self: SplitButton): bool =
  toBool(adw_split_button_get_can_shrink(cast[ptr SplitButton00](self.impl)))

proc adw_split_button_get_child(self: ptr SplitButton00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: SplitButton): gtk4.Widget =
  let gobj = adw_split_button_get_child(cast[ptr SplitButton00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: SplitButton): gtk4.Widget =
  let gobj = adw_split_button_get_child(cast[ptr SplitButton00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_split_button_get_direction(self: ptr SplitButton00): gtk4.ArrowType {.
    importc, libprag.}

proc getDirection*(self: SplitButton): gtk4.ArrowType =
  adw_split_button_get_direction(cast[ptr SplitButton00](self.impl))

proc direction*(self: SplitButton): gtk4.ArrowType =
  adw_split_button_get_direction(cast[ptr SplitButton00](self.impl))

proc adw_split_button_get_dropdown_tooltip(self: ptr SplitButton00): cstring {.
    importc, libprag.}

proc getDropdownTooltip*(self: SplitButton): string =
  result = $adw_split_button_get_dropdown_tooltip(cast[ptr SplitButton00](self.impl))

proc dropdownTooltip*(self: SplitButton): string =
  result = $adw_split_button_get_dropdown_tooltip(cast[ptr SplitButton00](self.impl))

proc adw_split_button_get_icon_name(self: ptr SplitButton00): cstring {.
    importc, libprag.}

proc getIconName*(self: SplitButton): string =
  let resul0 = adw_split_button_get_icon_name(cast[ptr SplitButton00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: SplitButton): string =
  let resul0 = adw_split_button_get_icon_name(cast[ptr SplitButton00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_split_button_get_label(self: ptr SplitButton00): cstring {.
    importc, libprag.}

proc getLabel*(self: SplitButton): string =
  let resul0 = adw_split_button_get_label(cast[ptr SplitButton00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc label*(self: SplitButton): string =
  let resul0 = adw_split_button_get_label(cast[ptr SplitButton00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_split_button_get_menu_model(self: ptr SplitButton00): ptr gio.MenuModel00 {.
    importc, libprag.}

proc getMenuModel*(self: SplitButton): gio.MenuModel =
  let gobj = adw_split_button_get_menu_model(cast[ptr SplitButton00](self.impl))
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

proc menuModel*(self: SplitButton): gio.MenuModel =
  let gobj = adw_split_button_get_menu_model(cast[ptr SplitButton00](self.impl))
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

proc adw_split_button_get_popover(self: ptr SplitButton00): ptr gtk4.Popover00 {.
    importc, libprag.}

proc getPopover*(self: SplitButton): gtk4.Popover =
  let gobj = adw_split_button_get_popover(cast[ptr SplitButton00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc popover*(self: SplitButton): gtk4.Popover =
  let gobj = adw_split_button_get_popover(cast[ptr SplitButton00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_split_button_get_use_underline(self: ptr SplitButton00): gboolean {.
    importc, libprag.}

proc getUseUnderline*(self: SplitButton): bool =
  toBool(adw_split_button_get_use_underline(cast[ptr SplitButton00](self.impl)))

proc useUnderline*(self: SplitButton): bool =
  toBool(adw_split_button_get_use_underline(cast[ptr SplitButton00](self.impl)))

proc adw_split_button_popdown(self: ptr SplitButton00) {.
    importc, libprag.}

proc popdown*(self: SplitButton) =
  adw_split_button_popdown(cast[ptr SplitButton00](self.impl))

proc adw_split_button_popup(self: ptr SplitButton00) {.
    importc, libprag.}

proc popup*(self: SplitButton) =
  adw_split_button_popup(cast[ptr SplitButton00](self.impl))

proc adw_split_button_set_can_shrink(self: ptr SplitButton00; canShrink: gboolean) {.
    importc, libprag.}

proc setCanShrink*(self: SplitButton; canShrink: bool = true) =
  adw_split_button_set_can_shrink(cast[ptr SplitButton00](self.impl), gboolean(canShrink))

proc `canShrink=`*(self: SplitButton; canShrink: bool) =
  adw_split_button_set_can_shrink(cast[ptr SplitButton00](self.impl), gboolean(canShrink))

proc adw_split_button_set_child(self: ptr SplitButton00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setChild*(self: SplitButton; child: gtk4.Widget = nil) =
  adw_split_button_set_child(cast[ptr SplitButton00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `child=`*(self: SplitButton; child: gtk4.Widget = nil) =
  adw_split_button_set_child(cast[ptr SplitButton00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc adw_split_button_set_direction(self: ptr SplitButton00; direction: gtk4.ArrowType) {.
    importc, libprag.}

proc setDirection*(self: SplitButton; direction: gtk4.ArrowType) =
  adw_split_button_set_direction(cast[ptr SplitButton00](self.impl), direction)

proc `direction=`*(self: SplitButton; direction: gtk4.ArrowType) =
  adw_split_button_set_direction(cast[ptr SplitButton00](self.impl), direction)

proc adw_split_button_set_dropdown_tooltip(self: ptr SplitButton00; tooltip: cstring) {.
    importc, libprag.}

proc setDropdownTooltip*(self: SplitButton; tooltip: cstring) =
  adw_split_button_set_dropdown_tooltip(cast[ptr SplitButton00](self.impl), tooltip)

proc `dropdownTooltip=`*(self: SplitButton; tooltip: cstring) =
  adw_split_button_set_dropdown_tooltip(cast[ptr SplitButton00](self.impl), tooltip)

proc adw_split_button_set_icon_name(self: ptr SplitButton00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: SplitButton; iconName: cstring) =
  adw_split_button_set_icon_name(cast[ptr SplitButton00](self.impl), iconName)

proc `iconName=`*(self: SplitButton; iconName: cstring) =
  adw_split_button_set_icon_name(cast[ptr SplitButton00](self.impl), iconName)

proc adw_split_button_set_label(self: ptr SplitButton00; label: cstring) {.
    importc, libprag.}

proc setLabel*(self: SplitButton; label: cstring) =
  adw_split_button_set_label(cast[ptr SplitButton00](self.impl), label)

proc `label=`*(self: SplitButton; label: cstring) =
  adw_split_button_set_label(cast[ptr SplitButton00](self.impl), label)

proc adw_split_button_set_menu_model(self: ptr SplitButton00; menuModel: ptr gio.MenuModel00) {.
    importc, libprag.}

proc setMenuModel*(self: SplitButton; menuModel: gio.MenuModel = nil) =
  adw_split_button_set_menu_model(cast[ptr SplitButton00](self.impl), if menuModel.isNil: nil else: cast[ptr gio.MenuModel00](menuModel.impl))

proc `menuModel=`*(self: SplitButton; menuModel: gio.MenuModel = nil) =
  adw_split_button_set_menu_model(cast[ptr SplitButton00](self.impl), if menuModel.isNil: nil else: cast[ptr gio.MenuModel00](menuModel.impl))

proc adw_split_button_set_popover(self: ptr SplitButton00; popover: ptr gtk4.Popover00) {.
    importc, libprag.}

proc setPopover*(self: SplitButton; popover: gtk4.Popover = nil) =
  adw_split_button_set_popover(cast[ptr SplitButton00](self.impl), if popover.isNil: nil else: cast[ptr gtk4.Popover00](popover.impl))

proc `popover=`*(self: SplitButton; popover: gtk4.Popover = nil) =
  adw_split_button_set_popover(cast[ptr SplitButton00](self.impl), if popover.isNil: nil else: cast[ptr gtk4.Popover00](popover.impl))

proc adw_split_button_set_use_underline(self: ptr SplitButton00; useUnderline: gboolean) {.
    importc, libprag.}

proc setUseUnderline*(self: SplitButton; useUnderline: bool = true) =
  adw_split_button_set_use_underline(cast[ptr SplitButton00](self.impl), gboolean(useUnderline))

proc `useUnderline=`*(self: SplitButton; useUnderline: bool) =
  adw_split_button_set_use_underline(cast[ptr SplitButton00](self.impl), gboolean(useUnderline))

type
  SpringAnimation* = ref object of Animation
  SpringAnimation00* = object of Animation00

proc adw_spring_animation_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SpringAnimation()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_spring_animation_new(widget: ptr gtk4.Widget00; `from`: cdouble;
    to: cdouble; springParams: ptr SpringParams00; target: ptr AnimationTarget00): ptr SpringAnimation00 {.
    importc, libprag.}

proc newSpringAnimation*(widget: gtk4.Widget; `from`: cdouble; to: cdouble;
    springParams: SpringParams; target: AnimationTarget): SpringAnimation =
  let gobj = adw_spring_animation_new(cast[ptr gtk4.Widget00](widget.impl), `from`, to, cast[ptr SpringParams00](g_boxed_copy(adw_spring_params_get_type(), springParams.impl)), cast[ptr AnimationTarget00](g_object_ref(target.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSpringAnimation*(tdesc: typedesc; widget: gtk4.Widget; `from`: cdouble; to: cdouble;
    springParams: SpringParams; target: AnimationTarget): tdesc =
  assert(result is SpringAnimation)
  let gobj = adw_spring_animation_new(cast[ptr gtk4.Widget00](widget.impl), `from`, to, cast[ptr SpringParams00](g_boxed_copy(adw_spring_params_get_type(), springParams.impl)), cast[ptr AnimationTarget00](g_object_ref(target.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSpringAnimation*[T](result: var T; widget: gtk4.Widget; `from`: cdouble; to: cdouble;
    springParams: SpringParams; target: AnimationTarget) {.deprecated.} =
  assert(result is SpringAnimation)
  let gobj = adw_spring_animation_new(cast[ptr gtk4.Widget00](widget.impl), `from`, to, cast[ptr SpringParams00](g_boxed_copy(adw_spring_params_get_type(), springParams.impl)), cast[ptr AnimationTarget00](g_object_ref(target.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_spring_animation_calculate_value(self: ptr SpringAnimation00; time: uint32): cdouble {.
    importc, libprag.}

proc calculateValue*(self: SpringAnimation; time: int): cdouble =
  adw_spring_animation_calculate_value(cast[ptr SpringAnimation00](self.impl), uint32(time))

proc adw_spring_animation_calculate_velocity(self: ptr SpringAnimation00;
    time: uint32): cdouble {.
    importc, libprag.}

proc calculateVelocity*(self: SpringAnimation; time: int): cdouble =
  adw_spring_animation_calculate_velocity(cast[ptr SpringAnimation00](self.impl), uint32(time))

proc adw_spring_animation_get_clamp(self: ptr SpringAnimation00): gboolean {.
    importc, libprag.}

proc getClamp*(self: SpringAnimation): bool =
  toBool(adw_spring_animation_get_clamp(cast[ptr SpringAnimation00](self.impl)))

proc clamp*(self: SpringAnimation): bool =
  toBool(adw_spring_animation_get_clamp(cast[ptr SpringAnimation00](self.impl)))

proc adw_spring_animation_get_epsilon(self: ptr SpringAnimation00): cdouble {.
    importc, libprag.}

proc getEpsilon*(self: SpringAnimation): cdouble =
  adw_spring_animation_get_epsilon(cast[ptr SpringAnimation00](self.impl))

proc epsilon*(self: SpringAnimation): cdouble =
  adw_spring_animation_get_epsilon(cast[ptr SpringAnimation00](self.impl))

proc adw_spring_animation_get_estimated_duration(self: ptr SpringAnimation00): uint32 {.
    importc, libprag.}

proc getEstimatedDuration*(self: SpringAnimation): int =
  int(adw_spring_animation_get_estimated_duration(cast[ptr SpringAnimation00](self.impl)))

proc estimatedDuration*(self: SpringAnimation): int =
  int(adw_spring_animation_get_estimated_duration(cast[ptr SpringAnimation00](self.impl)))

proc adw_spring_animation_get_initial_velocity(self: ptr SpringAnimation00): cdouble {.
    importc, libprag.}

proc getInitialVelocity*(self: SpringAnimation): cdouble =
  adw_spring_animation_get_initial_velocity(cast[ptr SpringAnimation00](self.impl))

proc initialVelocity*(self: SpringAnimation): cdouble =
  adw_spring_animation_get_initial_velocity(cast[ptr SpringAnimation00](self.impl))

proc adw_spring_animation_get_spring_params(self: ptr SpringAnimation00): ptr SpringParams00 {.
    importc, libprag.}

proc getSpringParams*(self: SpringAnimation): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_spring_animation_get_spring_params(cast[ptr SpringAnimation00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(adw_spring_params_get_type(), result.impl))

proc springParams*(self: SpringAnimation): SpringParams =
  fnew(result, gBoxedFreeAdwSpringParams)
  result.impl = adw_spring_animation_get_spring_params(cast[ptr SpringAnimation00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(adw_spring_params_get_type(), result.impl))

proc adw_spring_animation_get_value_from(self: ptr SpringAnimation00): cdouble {.
    importc, libprag.}

proc getValueFrom*(self: SpringAnimation): cdouble =
  adw_spring_animation_get_value_from(cast[ptr SpringAnimation00](self.impl))

proc valueFrom*(self: SpringAnimation): cdouble =
  adw_spring_animation_get_value_from(cast[ptr SpringAnimation00](self.impl))

proc adw_spring_animation_get_value_to(self: ptr SpringAnimation00): cdouble {.
    importc, libprag.}

proc getValueTo*(self: SpringAnimation): cdouble =
  adw_spring_animation_get_value_to(cast[ptr SpringAnimation00](self.impl))

proc valueTo*(self: SpringAnimation): cdouble =
  adw_spring_animation_get_value_to(cast[ptr SpringAnimation00](self.impl))

proc adw_spring_animation_get_velocity(self: ptr SpringAnimation00): cdouble {.
    importc, libprag.}

proc getVelocity*(self: SpringAnimation): cdouble =
  adw_spring_animation_get_velocity(cast[ptr SpringAnimation00](self.impl))

proc velocity*(self: SpringAnimation): cdouble =
  adw_spring_animation_get_velocity(cast[ptr SpringAnimation00](self.impl))

proc adw_spring_animation_set_clamp(self: ptr SpringAnimation00; clamp: gboolean) {.
    importc, libprag.}

proc setClamp*(self: SpringAnimation; clamp: bool = true) =
  adw_spring_animation_set_clamp(cast[ptr SpringAnimation00](self.impl), gboolean(clamp))

proc `clamp=`*(self: SpringAnimation; clamp: bool) =
  adw_spring_animation_set_clamp(cast[ptr SpringAnimation00](self.impl), gboolean(clamp))

proc adw_spring_animation_set_epsilon(self: ptr SpringAnimation00; epsilon: cdouble) {.
    importc, libprag.}

proc setEpsilon*(self: SpringAnimation; epsilon: cdouble) =
  adw_spring_animation_set_epsilon(cast[ptr SpringAnimation00](self.impl), epsilon)

proc `epsilon=`*(self: SpringAnimation; epsilon: cdouble) =
  adw_spring_animation_set_epsilon(cast[ptr SpringAnimation00](self.impl), epsilon)

proc adw_spring_animation_set_initial_velocity(self: ptr SpringAnimation00;
    velocity: cdouble) {.
    importc, libprag.}

proc setInitialVelocity*(self: SpringAnimation; velocity: cdouble) =
  adw_spring_animation_set_initial_velocity(cast[ptr SpringAnimation00](self.impl), velocity)

proc `initialVelocity=`*(self: SpringAnimation; velocity: cdouble) =
  adw_spring_animation_set_initial_velocity(cast[ptr SpringAnimation00](self.impl), velocity)

proc adw_spring_animation_set_spring_params(self: ptr SpringAnimation00;
    springParams: ptr SpringParams00) {.
    importc, libprag.}

proc setSpringParams*(self: SpringAnimation; springParams: SpringParams) =
  adw_spring_animation_set_spring_params(cast[ptr SpringAnimation00](self.impl), cast[ptr SpringParams00](springParams.impl))

proc `springParams=`*(self: SpringAnimation; springParams: SpringParams) =
  adw_spring_animation_set_spring_params(cast[ptr SpringAnimation00](self.impl), cast[ptr SpringParams00](springParams.impl))

proc adw_spring_animation_set_value_from(self: ptr SpringAnimation00; value: cdouble) {.
    importc, libprag.}

proc setValueFrom*(self: SpringAnimation; value: cdouble) =
  adw_spring_animation_set_value_from(cast[ptr SpringAnimation00](self.impl), value)

proc `valueFrom=`*(self: SpringAnimation; value: cdouble) =
  adw_spring_animation_set_value_from(cast[ptr SpringAnimation00](self.impl), value)

proc adw_spring_animation_set_value_to(self: ptr SpringAnimation00; value: cdouble) {.
    importc, libprag.}

proc setValueTo*(self: SpringAnimation; value: cdouble) =
  adw_spring_animation_set_value_to(cast[ptr SpringAnimation00](self.impl), value)

proc `valueTo=`*(self: SpringAnimation; value: cdouble) =
  adw_spring_animation_set_value_to(cast[ptr SpringAnimation00](self.impl), value)

type
  Squeezer* = ref object of gtk4.Widget
  Squeezer00* = object of gtk4.Widget00

proc adw_squeezer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Squeezer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_squeezer_new(): ptr Squeezer00 {.
    importc, libprag.}

proc newSqueezer*(): Squeezer {.deprecated.}  =
  let gobj = adw_squeezer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSqueezer*(tdesc: typedesc): tdesc {.deprecated.}  =
  assert(result is Squeezer)
  let gobj = adw_squeezer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSqueezer*[T](result: var T) {.deprecated.} =
  assert(result is Squeezer)
  let gobj = adw_squeezer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_squeezer_get_allow_none(self: ptr Squeezer00): gboolean {.
    importc, libprag.}

proc getAllowNone*(self: Squeezer): bool =
  toBool(adw_squeezer_get_allow_none(cast[ptr Squeezer00](self.impl)))

proc allowNone*(self: Squeezer): bool =
  toBool(adw_squeezer_get_allow_none(cast[ptr Squeezer00](self.impl)))

proc adw_squeezer_get_homogeneous(self: ptr Squeezer00): gboolean {.
    importc, libprag.}

proc getHomogeneous*(self: Squeezer): bool =
  toBool(adw_squeezer_get_homogeneous(cast[ptr Squeezer00](self.impl)))

proc homogeneous*(self: Squeezer): bool =
  toBool(adw_squeezer_get_homogeneous(cast[ptr Squeezer00](self.impl)))

proc adw_squeezer_get_interpolate_size(self: ptr Squeezer00): gboolean {.
    importc, libprag.}

proc getInterpolateSize*(self: Squeezer): bool =
  toBool(adw_squeezer_get_interpolate_size(cast[ptr Squeezer00](self.impl)))

proc interpolateSize*(self: Squeezer): bool =
  toBool(adw_squeezer_get_interpolate_size(cast[ptr Squeezer00](self.impl)))

proc adw_squeezer_get_pages(self: ptr Squeezer00): ptr gtk4.SelectionModel00 {.
    importc, libprag.}

proc getPages*(self: Squeezer): gtk4.SelectionModel =
  let gobj = adw_squeezer_get_pages(cast[ptr Squeezer00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pages*(self: Squeezer): gtk4.SelectionModel =
  let gobj = adw_squeezer_get_pages(cast[ptr Squeezer00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_squeezer_get_switch_threshold_policy(self: ptr Squeezer00): FoldThresholdPolicy {.
    importc, libprag.}

proc getSwitchThresholdPolicy*(self: Squeezer): FoldThresholdPolicy =
  adw_squeezer_get_switch_threshold_policy(cast[ptr Squeezer00](self.impl))

proc switchThresholdPolicy*(self: Squeezer): FoldThresholdPolicy =
  adw_squeezer_get_switch_threshold_policy(cast[ptr Squeezer00](self.impl))

proc adw_squeezer_get_transition_duration(self: ptr Squeezer00): uint32 {.
    importc, libprag.}

proc getTransitionDuration*(self: Squeezer): int =
  int(adw_squeezer_get_transition_duration(cast[ptr Squeezer00](self.impl)))

proc transitionDuration*(self: Squeezer): int =
  int(adw_squeezer_get_transition_duration(cast[ptr Squeezer00](self.impl)))

proc adw_squeezer_get_transition_running(self: ptr Squeezer00): gboolean {.
    importc, libprag.}

proc getTransitionRunning*(self: Squeezer): bool =
  toBool(adw_squeezer_get_transition_running(cast[ptr Squeezer00](self.impl)))

proc transitionRunning*(self: Squeezer): bool =
  toBool(adw_squeezer_get_transition_running(cast[ptr Squeezer00](self.impl)))

proc adw_squeezer_get_visible_child(self: ptr Squeezer00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getVisibleChild*(self: Squeezer): gtk4.Widget =
  let gobj = adw_squeezer_get_visible_child(cast[ptr Squeezer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visibleChild*(self: Squeezer): gtk4.Widget =
  let gobj = adw_squeezer_get_visible_child(cast[ptr Squeezer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_squeezer_get_xalign(self: ptr Squeezer00): cfloat {.
    importc, libprag.}

proc getXalign*(self: Squeezer): cfloat =
  adw_squeezer_get_xalign(cast[ptr Squeezer00](self.impl))

proc xalign*(self: Squeezer): cfloat =
  adw_squeezer_get_xalign(cast[ptr Squeezer00](self.impl))

proc adw_squeezer_get_yalign(self: ptr Squeezer00): cfloat {.
    importc, libprag.}

proc getYalign*(self: Squeezer): cfloat =
  adw_squeezer_get_yalign(cast[ptr Squeezer00](self.impl))

proc yalign*(self: Squeezer): cfloat =
  adw_squeezer_get_yalign(cast[ptr Squeezer00](self.impl))

proc adw_squeezer_remove(self: ptr Squeezer00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: Squeezer; child: gtk4.Widget) =
  adw_squeezer_remove(cast[ptr Squeezer00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_squeezer_set_allow_none(self: ptr Squeezer00; allowNone: gboolean) {.
    importc, libprag.}

proc setAllowNone*(self: Squeezer; allowNone: bool = true) =
  adw_squeezer_set_allow_none(cast[ptr Squeezer00](self.impl), gboolean(allowNone))

proc `allowNone=`*(self: Squeezer; allowNone: bool) =
  adw_squeezer_set_allow_none(cast[ptr Squeezer00](self.impl), gboolean(allowNone))

proc adw_squeezer_set_homogeneous(self: ptr Squeezer00; homogeneous: gboolean) {.
    importc, libprag.}

proc setHomogeneous*(self: Squeezer; homogeneous: bool = true) =
  adw_squeezer_set_homogeneous(cast[ptr Squeezer00](self.impl), gboolean(homogeneous))

proc `homogeneous=`*(self: Squeezer; homogeneous: bool) =
  adw_squeezer_set_homogeneous(cast[ptr Squeezer00](self.impl), gboolean(homogeneous))

proc adw_squeezer_set_interpolate_size(self: ptr Squeezer00; interpolateSize: gboolean) {.
    importc, libprag.}

proc setInterpolateSize*(self: Squeezer; interpolateSize: bool = true) =
  adw_squeezer_set_interpolate_size(cast[ptr Squeezer00](self.impl), gboolean(interpolateSize))

proc `interpolateSize=`*(self: Squeezer; interpolateSize: bool) =
  adw_squeezer_set_interpolate_size(cast[ptr Squeezer00](self.impl), gboolean(interpolateSize))

proc adw_squeezer_set_switch_threshold_policy(self: ptr Squeezer00; policy: FoldThresholdPolicy) {.
    importc, libprag.}

proc setSwitchThresholdPolicy*(self: Squeezer; policy: FoldThresholdPolicy) =
  adw_squeezer_set_switch_threshold_policy(cast[ptr Squeezer00](self.impl), policy)

proc `switchThresholdPolicy=`*(self: Squeezer; policy: FoldThresholdPolicy) =
  adw_squeezer_set_switch_threshold_policy(cast[ptr Squeezer00](self.impl), policy)

proc adw_squeezer_set_transition_duration(self: ptr Squeezer00; duration: uint32) {.
    importc, libprag.}

proc setTransitionDuration*(self: Squeezer; duration: int) =
  adw_squeezer_set_transition_duration(cast[ptr Squeezer00](self.impl), uint32(duration))

proc `transitionDuration=`*(self: Squeezer; duration: int) =
  adw_squeezer_set_transition_duration(cast[ptr Squeezer00](self.impl), uint32(duration))

proc adw_squeezer_set_xalign(self: ptr Squeezer00; xalign: cfloat) {.
    importc, libprag.}

proc setXalign*(self: Squeezer; xalign: cfloat) =
  adw_squeezer_set_xalign(cast[ptr Squeezer00](self.impl), xalign)

proc `xalign=`*(self: Squeezer; xalign: cfloat) =
  adw_squeezer_set_xalign(cast[ptr Squeezer00](self.impl), xalign)

proc adw_squeezer_set_yalign(self: ptr Squeezer00; yalign: cfloat) {.
    importc, libprag.}

proc setYalign*(self: Squeezer; yalign: cfloat) =
  adw_squeezer_set_yalign(cast[ptr Squeezer00](self.impl), yalign)

proc `yalign=`*(self: Squeezer; yalign: cfloat) =
  adw_squeezer_set_yalign(cast[ptr Squeezer00](self.impl), yalign)

type
  SqueezerPage* = ref object of gobject.Object
  SqueezerPage00* = object of gobject.Object00

proc adw_squeezer_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SqueezerPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_squeezer_page_get_child(self: ptr SqueezerPage00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: SqueezerPage): gtk4.Widget =
  let gobj = adw_squeezer_page_get_child(cast[ptr SqueezerPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: SqueezerPage): gtk4.Widget =
  let gobj = adw_squeezer_page_get_child(cast[ptr SqueezerPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_squeezer_page_get_enabled(self: ptr SqueezerPage00): gboolean {.
    importc, libprag.}

proc getEnabled*(self: SqueezerPage): bool =
  toBool(adw_squeezer_page_get_enabled(cast[ptr SqueezerPage00](self.impl)))

proc enabled*(self: SqueezerPage): bool =
  toBool(adw_squeezer_page_get_enabled(cast[ptr SqueezerPage00](self.impl)))

proc adw_squeezer_page_set_enabled(self: ptr SqueezerPage00; enabled: gboolean) {.
    importc, libprag.}

proc setEnabled*(self: SqueezerPage; enabled: bool = true) =
  adw_squeezer_page_set_enabled(cast[ptr SqueezerPage00](self.impl), gboolean(enabled))

proc `enabled=`*(self: SqueezerPage; enabled: bool) =
  adw_squeezer_page_set_enabled(cast[ptr SqueezerPage00](self.impl), gboolean(enabled))

proc adw_squeezer_add(self: ptr Squeezer00; child: ptr gtk4.Widget00): ptr SqueezerPage00 {.
    importc, libprag.}

proc add*(self: Squeezer; child: gtk4.Widget): SqueezerPage =
  let gobj = adw_squeezer_add(cast[ptr Squeezer00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_squeezer_get_page(self: ptr Squeezer00; child: ptr gtk4.Widget00): ptr SqueezerPage00 {.
    importc, libprag.}

proc getPage*(self: Squeezer; child: gtk4.Widget): SqueezerPage =
  let gobj = adw_squeezer_get_page(cast[ptr Squeezer00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SqueezerTransitionType* {.size: sizeof(cint), pure.} = enum
    none = 0
    crossfade = 1

proc adw_squeezer_get_transition_type(self: ptr Squeezer00): SqueezerTransitionType {.
    importc, libprag.}

proc getTransitionType*(self: Squeezer): SqueezerTransitionType =
  adw_squeezer_get_transition_type(cast[ptr Squeezer00](self.impl))

proc transitionType*(self: Squeezer): SqueezerTransitionType =
  adw_squeezer_get_transition_type(cast[ptr Squeezer00](self.impl))

proc adw_squeezer_set_transition_type(self: ptr Squeezer00; transition: SqueezerTransitionType) {.
    importc, libprag.}

proc setTransitionType*(self: Squeezer; transition: SqueezerTransitionType) =
  adw_squeezer_set_transition_type(cast[ptr Squeezer00](self.impl), transition)

proc `transitionType=`*(self: Squeezer; transition: SqueezerTransitionType) =
  adw_squeezer_set_transition_type(cast[ptr Squeezer00](self.impl), transition)

type
  StatusPage* = ref object of gtk4.Widget
  StatusPage00* = object of gtk4.Widget00

proc adw_status_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StatusPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_status_page_new(): ptr StatusPage00 {.
    importc, libprag.}

proc newStatusPage*(): StatusPage =
  let gobj = adw_status_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newStatusPage*(tdesc: typedesc): tdesc =
  assert(result is StatusPage)
  let gobj = adw_status_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initStatusPage*[T](result: var T) {.deprecated.} =
  assert(result is StatusPage)
  let gobj = adw_status_page_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_status_page_get_child(self: ptr StatusPage00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: StatusPage): gtk4.Widget =
  let gobj = adw_status_page_get_child(cast[ptr StatusPage00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: StatusPage): gtk4.Widget =
  let gobj = adw_status_page_get_child(cast[ptr StatusPage00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_status_page_get_description(self: ptr StatusPage00): cstring {.
    importc, libprag.}

proc getDescription*(self: StatusPage): string =
  let resul0 = adw_status_page_get_description(cast[ptr StatusPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc description*(self: StatusPage): string =
  let resul0 = adw_status_page_get_description(cast[ptr StatusPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_status_page_get_icon_name(self: ptr StatusPage00): cstring {.
    importc, libprag.}

proc getIconName*(self: StatusPage): string =
  let resul0 = adw_status_page_get_icon_name(cast[ptr StatusPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: StatusPage): string =
  let resul0 = adw_status_page_get_icon_name(cast[ptr StatusPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_status_page_get_paintable(self: ptr StatusPage00): ptr gdk4.Paintable00 {.
    importc, libprag.}

proc getPaintable*(self: StatusPage): gdk4.Paintable =
  let gobj = adw_status_page_get_paintable(cast[ptr StatusPage00](self.impl))
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

proc paintable*(self: StatusPage): gdk4.Paintable =
  let gobj = adw_status_page_get_paintable(cast[ptr StatusPage00](self.impl))
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

proc adw_status_page_get_title(self: ptr StatusPage00): cstring {.
    importc, libprag.}

proc getTitle*(self: StatusPage): string =
  result = $adw_status_page_get_title(cast[ptr StatusPage00](self.impl))

proc title*(self: StatusPage): string =
  result = $adw_status_page_get_title(cast[ptr StatusPage00](self.impl))

proc adw_status_page_set_child(self: ptr StatusPage00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setChild*(self: StatusPage; child: gtk4.Widget = nil) =
  adw_status_page_set_child(cast[ptr StatusPage00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `child=`*(self: StatusPage; child: gtk4.Widget = nil) =
  adw_status_page_set_child(cast[ptr StatusPage00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc adw_status_page_set_description(self: ptr StatusPage00; description: cstring) {.
    importc, libprag.}

proc setDescription*(self: StatusPage; description: cstring = nil) =
  adw_status_page_set_description(cast[ptr StatusPage00](self.impl), description)

proc `description=`*(self: StatusPage; description: cstring = nil) =
  adw_status_page_set_description(cast[ptr StatusPage00](self.impl), description)

proc adw_status_page_set_icon_name(self: ptr StatusPage00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: StatusPage; iconName: cstring = nil) =
  adw_status_page_set_icon_name(cast[ptr StatusPage00](self.impl), iconName)

proc `iconName=`*(self: StatusPage; iconName: cstring = nil) =
  adw_status_page_set_icon_name(cast[ptr StatusPage00](self.impl), iconName)

proc adw_status_page_set_paintable(self: ptr StatusPage00; paintable: ptr gdk4.Paintable00) {.
    importc, libprag.}

proc setPaintable*(self: StatusPage; paintable: gdk4.Paintable = nil) =
  adw_status_page_set_paintable(cast[ptr StatusPage00](self.impl), if paintable.isNil: nil else: cast[ptr gdk4.Paintable00](paintable.impl))

proc `paintable=`*(self: StatusPage; paintable: gdk4.Paintable = nil) =
  adw_status_page_set_paintable(cast[ptr StatusPage00](self.impl), if paintable.isNil: nil else: cast[ptr gdk4.Paintable00](paintable.impl))

proc adw_status_page_set_title(self: ptr StatusPage00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: StatusPage; title: cstring) =
  adw_status_page_set_title(cast[ptr StatusPage00](self.impl), title)

proc `title=`*(self: StatusPage; title: cstring) =
  adw_status_page_set_title(cast[ptr StatusPage00](self.impl), title)

type
  SwipeTracker* = ref object of gobject.Object
  SwipeTracker00* = object of gobject.Object00

proc adw_swipe_tracker_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SwipeTracker()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scBeginSwipe*(self: SwipeTracker;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "begin-swipe", cast[GCallback](p), xdata, nil, cf)

proc scEndSwipe*(self: SwipeTracker;  p: proc (self: ptr SwipeTracker00; velocity: cdouble; to: cdouble; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "end-swipe", cast[GCallback](p), xdata, nil, cf)

proc scPrepare*(self: SwipeTracker;  p: proc (self: ptr SwipeTracker00; direction: NavigationDirection; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "prepare", cast[GCallback](p), xdata, nil, cf)

proc scUpdateSwipe*(self: SwipeTracker;  p: proc (self: ptr SwipeTracker00; progress: cdouble; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "update-swipe", cast[GCallback](p), xdata, nil, cf)

proc adw_swipe_tracker_get_allow_long_swipes(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getAllowLongSwipes*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_allow_long_swipes(cast[ptr SwipeTracker00](self.impl)))

proc allowLongSwipes*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_allow_long_swipes(cast[ptr SwipeTracker00](self.impl)))

proc adw_swipe_tracker_get_allow_mouse_drag(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getAllowMouseDrag*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_allow_mouse_drag(cast[ptr SwipeTracker00](self.impl)))

proc allowMouseDrag*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_allow_mouse_drag(cast[ptr SwipeTracker00](self.impl)))

proc adw_swipe_tracker_get_allow_window_handle(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getAllowWindowHandle*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_allow_window_handle(cast[ptr SwipeTracker00](self.impl)))

proc allowWindowHandle*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_allow_window_handle(cast[ptr SwipeTracker00](self.impl)))

proc adw_swipe_tracker_get_enabled(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getEnabled*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_enabled(cast[ptr SwipeTracker00](self.impl)))

proc enabled*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_enabled(cast[ptr SwipeTracker00](self.impl)))

proc adw_swipe_tracker_get_lower_overshoot(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getLowerOvershoot*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_lower_overshoot(cast[ptr SwipeTracker00](self.impl)))

proc lowerOvershoot*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_lower_overshoot(cast[ptr SwipeTracker00](self.impl)))

proc adw_swipe_tracker_get_reversed(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getReversed*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_reversed(cast[ptr SwipeTracker00](self.impl)))

proc reversed*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_reversed(cast[ptr SwipeTracker00](self.impl)))

proc adw_swipe_tracker_get_upper_overshoot(self: ptr SwipeTracker00): gboolean {.
    importc, libprag.}

proc getUpperOvershoot*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_upper_overshoot(cast[ptr SwipeTracker00](self.impl)))

proc upperOvershoot*(self: SwipeTracker): bool =
  toBool(adw_swipe_tracker_get_upper_overshoot(cast[ptr SwipeTracker00](self.impl)))

proc adw_swipe_tracker_set_allow_long_swipes(self: ptr SwipeTracker00; allowLongSwipes: gboolean) {.
    importc, libprag.}

proc setAllowLongSwipes*(self: SwipeTracker; allowLongSwipes: bool = true) =
  adw_swipe_tracker_set_allow_long_swipes(cast[ptr SwipeTracker00](self.impl), gboolean(allowLongSwipes))

proc `allowLongSwipes=`*(self: SwipeTracker; allowLongSwipes: bool) =
  adw_swipe_tracker_set_allow_long_swipes(cast[ptr SwipeTracker00](self.impl), gboolean(allowLongSwipes))

proc adw_swipe_tracker_set_allow_mouse_drag(self: ptr SwipeTracker00; allowMouseDrag: gboolean) {.
    importc, libprag.}

proc setAllowMouseDrag*(self: SwipeTracker; allowMouseDrag: bool = true) =
  adw_swipe_tracker_set_allow_mouse_drag(cast[ptr SwipeTracker00](self.impl), gboolean(allowMouseDrag))

proc `allowMouseDrag=`*(self: SwipeTracker; allowMouseDrag: bool) =
  adw_swipe_tracker_set_allow_mouse_drag(cast[ptr SwipeTracker00](self.impl), gboolean(allowMouseDrag))

proc adw_swipe_tracker_set_allow_window_handle(self: ptr SwipeTracker00;
    allowWindowHandle: gboolean) {.
    importc, libprag.}

proc setAllowWindowHandle*(self: SwipeTracker; allowWindowHandle: bool = true) =
  adw_swipe_tracker_set_allow_window_handle(cast[ptr SwipeTracker00](self.impl), gboolean(allowWindowHandle))

proc `allowWindowHandle=`*(self: SwipeTracker; allowWindowHandle: bool) =
  adw_swipe_tracker_set_allow_window_handle(cast[ptr SwipeTracker00](self.impl), gboolean(allowWindowHandle))

proc adw_swipe_tracker_set_enabled(self: ptr SwipeTracker00; enabled: gboolean) {.
    importc, libprag.}

proc setEnabled*(self: SwipeTracker; enabled: bool = true) =
  adw_swipe_tracker_set_enabled(cast[ptr SwipeTracker00](self.impl), gboolean(enabled))

proc `enabled=`*(self: SwipeTracker; enabled: bool) =
  adw_swipe_tracker_set_enabled(cast[ptr SwipeTracker00](self.impl), gboolean(enabled))

proc adw_swipe_tracker_set_lower_overshoot(self: ptr SwipeTracker00; overshoot: gboolean) {.
    importc, libprag.}

proc setLowerOvershoot*(self: SwipeTracker; overshoot: bool = true) =
  adw_swipe_tracker_set_lower_overshoot(cast[ptr SwipeTracker00](self.impl), gboolean(overshoot))

proc `lowerOvershoot=`*(self: SwipeTracker; overshoot: bool) =
  adw_swipe_tracker_set_lower_overshoot(cast[ptr SwipeTracker00](self.impl), gboolean(overshoot))

proc adw_swipe_tracker_set_reversed(self: ptr SwipeTracker00; reversed: gboolean) {.
    importc, libprag.}

proc setReversed*(self: SwipeTracker; reversed: bool = true) =
  adw_swipe_tracker_set_reversed(cast[ptr SwipeTracker00](self.impl), gboolean(reversed))

proc `reversed=`*(self: SwipeTracker; reversed: bool) =
  adw_swipe_tracker_set_reversed(cast[ptr SwipeTracker00](self.impl), gboolean(reversed))

proc adw_swipe_tracker_set_upper_overshoot(self: ptr SwipeTracker00; overshoot: gboolean) {.
    importc, libprag.}

proc setUpperOvershoot*(self: SwipeTracker; overshoot: bool = true) =
  adw_swipe_tracker_set_upper_overshoot(cast[ptr SwipeTracker00](self.impl), gboolean(overshoot))

proc `upperOvershoot=`*(self: SwipeTracker; overshoot: bool) =
  adw_swipe_tracker_set_upper_overshoot(cast[ptr SwipeTracker00](self.impl), gboolean(overshoot))

proc adw_swipe_tracker_shift_position(self: ptr SwipeTracker00; delta: cdouble) {.
    importc, libprag.}

proc shiftPosition*(self: SwipeTracker; delta: cdouble) =
  adw_swipe_tracker_shift_position(cast[ptr SwipeTracker00](self.impl), delta)

type
  Swipeable00* = object of gobject.Object00
  Swipeable* = ref object of gobject.Object

proc adw_swipeable_get_cancel_progress(self: ptr Swipeable00): cdouble {.
    importc, libprag.}

proc getCancelProgress*(self: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet): cdouble =
  adw_swipeable_get_cancel_progress(cast[ptr Swipeable00](self.impl))

proc cancelProgress*(self: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet): cdouble =
  adw_swipeable_get_cancel_progress(cast[ptr Swipeable00](self.impl))

proc adw_swipeable_get_distance(self: ptr Swipeable00): cdouble {.
    importc, libprag.}

proc getDistance*(self: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet): cdouble =
  adw_swipeable_get_distance(cast[ptr Swipeable00](self.impl))

proc distance*(self: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet): cdouble =
  adw_swipeable_get_distance(cast[ptr Swipeable00](self.impl))

proc adw_swipeable_get_progress(self: ptr Swipeable00): cdouble {.
    importc, libprag.}

proc getProgress*(self: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet): cdouble =
  adw_swipeable_get_progress(cast[ptr Swipeable00](self.impl))

proc progress*(self: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet): cdouble =
  adw_swipeable_get_progress(cast[ptr Swipeable00](self.impl))

proc adw_swipeable_get_snap_points(self: ptr Swipeable00; nSnapPoints: var int32): ptr cdouble {.
    importc, libprag.}

proc getSnapPoints*(self: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet;
    nSnapPoints: var int): ptr cdouble =
  var nSnapPoints_00: int32
  let resul0 = adw_swipeable_get_snap_points(cast[ptr Swipeable00](self.impl), nSnapPoints_00)
  result = resul0
  if nSnapPoints.addr != nil:
    nSnapPoints = int(nSnapPoints_00)

proc adw_swipeable_get_swipe_area(self: ptr Swipeable00; navigationDirection: NavigationDirection;
    isDrag: gboolean; rect: var gdk4.Rectangle) {.
    importc, libprag.}

proc getSwipeArea*(self: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet;
    navigationDirection: NavigationDirection; isDrag: bool; rect: var gdk4.Rectangle) =
  adw_swipeable_get_swipe_area(cast[ptr Swipeable00](self.impl), navigationDirection, gboolean(isDrag), rect)

proc adw_swipe_tracker_new(swipeable: ptr Swipeable00): ptr SwipeTracker00 {.
    importc, libprag.}

proc newSwipeTracker*(swipeable: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet): SwipeTracker =
  let gobj = adw_swipe_tracker_new(cast[ptr Swipeable00](swipeable.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSwipeTracker*(tdesc: typedesc; swipeable: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet): tdesc =
  assert(result is SwipeTracker)
  let gobj = adw_swipe_tracker_new(cast[ptr Swipeable00](swipeable.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSwipeTracker*[T](result: var T; swipeable: Swipeable | Flap | OverlaySplitView | Carousel | NavigationView | Leaflet) {.deprecated.} =
  assert(result is SwipeTracker)
  let gobj = adw_swipe_tracker_new(cast[ptr Swipeable00](swipeable.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_swipe_tracker_get_swipeable(self: ptr SwipeTracker00): ptr Swipeable00 {.
    importc, libprag.}

proc getSwipeable*(self: SwipeTracker): Swipeable =
  let gobj = adw_swipe_tracker_get_swipeable(cast[ptr SwipeTracker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc swipeable*(self: SwipeTracker): Swipeable =
  let gobj = adw_swipe_tracker_get_swipeable(cast[ptr SwipeTracker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SwitchRow* = ref object of ActionRow
  SwitchRow00* = object of ActionRow00

proc adw_switch_row_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SwitchRow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_switch_row_new(): ptr SwitchRow00 {.
    importc, libprag.}

proc newSwitchRow*(): SwitchRow =
  let gobj = adw_switch_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSwitchRow*(tdesc: typedesc): tdesc =
  assert(result is SwitchRow)
  let gobj = adw_switch_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSwitchRow*[T](result: var T) {.deprecated.} =
  assert(result is SwitchRow)
  let gobj = adw_switch_row_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_switch_row_get_active(self: ptr SwitchRow00): gboolean {.
    importc, libprag.}

proc getActive*(self: SwitchRow): bool =
  toBool(adw_switch_row_get_active(cast[ptr SwitchRow00](self.impl)))

proc active*(self: SwitchRow): bool =
  toBool(adw_switch_row_get_active(cast[ptr SwitchRow00](self.impl)))

proc adw_switch_row_set_active(self: ptr SwitchRow00; isActive: gboolean) {.
    importc, libprag.}

proc setActive*(self: SwitchRow; isActive: bool = true) =
  adw_switch_row_set_active(cast[ptr SwitchRow00](self.impl), gboolean(isActive))

proc `active=`*(self: SwitchRow; isActive: bool) =
  adw_switch_row_set_active(cast[ptr SwitchRow00](self.impl), gboolean(isActive))

type
  TabPage* = ref object of gobject.Object
  TabPage00* = object of gobject.Object00

proc adw_tab_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TabPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_tab_page_get_child(self: ptr TabPage00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: TabPage): gtk4.Widget =
  let gobj = adw_tab_page_get_child(cast[ptr TabPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: TabPage): gtk4.Widget =
  let gobj = adw_tab_page_get_child(cast[ptr TabPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_page_get_icon(self: ptr TabPage00): ptr gio.Icon00 {.
    importc, libprag.}

proc getIcon*(self: TabPage): gio.Icon =
  let gobj = adw_tab_page_get_icon(cast[ptr TabPage00](self.impl))
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
  let gobj = adw_tab_page_get_icon(cast[ptr TabPage00](self.impl))
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

proc adw_tab_page_get_indicator_activatable(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getIndicatorActivatable*(self: TabPage): bool =
  toBool(adw_tab_page_get_indicator_activatable(cast[ptr TabPage00](self.impl)))

proc indicatorActivatable*(self: TabPage): bool =
  toBool(adw_tab_page_get_indicator_activatable(cast[ptr TabPage00](self.impl)))

proc adw_tab_page_get_indicator_icon(self: ptr TabPage00): ptr gio.Icon00 {.
    importc, libprag.}

proc getIndicatorIcon*(self: TabPage): gio.Icon =
  let gobj = adw_tab_page_get_indicator_icon(cast[ptr TabPage00](self.impl))
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
  let gobj = adw_tab_page_get_indicator_icon(cast[ptr TabPage00](self.impl))
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

proc adw_tab_page_get_indicator_tooltip(self: ptr TabPage00): cstring {.
    importc, libprag.}

proc getIndicatorTooltip*(self: TabPage): string =
  result = $adw_tab_page_get_indicator_tooltip(cast[ptr TabPage00](self.impl))

proc indicatorTooltip*(self: TabPage): string =
  result = $adw_tab_page_get_indicator_tooltip(cast[ptr TabPage00](self.impl))

proc adw_tab_page_get_keyword(self: ptr TabPage00): cstring {.
    importc, libprag.}

proc getKeyword*(self: TabPage): string =
  let resul0 = adw_tab_page_get_keyword(cast[ptr TabPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc keyword*(self: TabPage): string =
  let resul0 = adw_tab_page_get_keyword(cast[ptr TabPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_tab_page_get_live_thumbnail(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getLiveThumbnail*(self: TabPage): bool =
  toBool(adw_tab_page_get_live_thumbnail(cast[ptr TabPage00](self.impl)))

proc liveThumbnail*(self: TabPage): bool =
  toBool(adw_tab_page_get_live_thumbnail(cast[ptr TabPage00](self.impl)))

proc adw_tab_page_get_loading(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getLoading*(self: TabPage): bool =
  toBool(adw_tab_page_get_loading(cast[ptr TabPage00](self.impl)))

proc loading*(self: TabPage): bool =
  toBool(adw_tab_page_get_loading(cast[ptr TabPage00](self.impl)))

proc adw_tab_page_get_needs_attention(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getNeedsAttention*(self: TabPage): bool =
  toBool(adw_tab_page_get_needs_attention(cast[ptr TabPage00](self.impl)))

proc needsAttention*(self: TabPage): bool =
  toBool(adw_tab_page_get_needs_attention(cast[ptr TabPage00](self.impl)))

proc adw_tab_page_get_parent(self: ptr TabPage00): ptr TabPage00 {.
    importc, libprag.}

proc getParent*(self: TabPage): TabPage =
  let gobj = adw_tab_page_get_parent(cast[ptr TabPage00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parent*(self: TabPage): TabPage =
  let gobj = adw_tab_page_get_parent(cast[ptr TabPage00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_page_get_pinned(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getPinned*(self: TabPage): bool =
  toBool(adw_tab_page_get_pinned(cast[ptr TabPage00](self.impl)))

proc pinned*(self: TabPage): bool =
  toBool(adw_tab_page_get_pinned(cast[ptr TabPage00](self.impl)))

proc adw_tab_page_get_selected(self: ptr TabPage00): gboolean {.
    importc, libprag.}

proc getSelected*(self: TabPage): bool =
  toBool(adw_tab_page_get_selected(cast[ptr TabPage00](self.impl)))

proc selected*(self: TabPage): bool =
  toBool(adw_tab_page_get_selected(cast[ptr TabPage00](self.impl)))

proc adw_tab_page_get_thumbnail_xalign(self: ptr TabPage00): cfloat {.
    importc, libprag.}

proc getThumbnailXalign*(self: TabPage): cfloat =
  adw_tab_page_get_thumbnail_xalign(cast[ptr TabPage00](self.impl))

proc thumbnailXalign*(self: TabPage): cfloat =
  adw_tab_page_get_thumbnail_xalign(cast[ptr TabPage00](self.impl))

proc adw_tab_page_get_thumbnail_yalign(self: ptr TabPage00): cfloat {.
    importc, libprag.}

proc getThumbnailYalign*(self: TabPage): cfloat =
  adw_tab_page_get_thumbnail_yalign(cast[ptr TabPage00](self.impl))

proc thumbnailYalign*(self: TabPage): cfloat =
  adw_tab_page_get_thumbnail_yalign(cast[ptr TabPage00](self.impl))

proc adw_tab_page_get_title(self: ptr TabPage00): cstring {.
    importc, libprag.}

proc getTitle*(self: TabPage): string =
  result = $adw_tab_page_get_title(cast[ptr TabPage00](self.impl))

proc title*(self: TabPage): string =
  result = $adw_tab_page_get_title(cast[ptr TabPage00](self.impl))

proc adw_tab_page_get_tooltip(self: ptr TabPage00): cstring {.
    importc, libprag.}

proc getTooltip*(self: TabPage): string =
  let resul0 = adw_tab_page_get_tooltip(cast[ptr TabPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc tooltip*(self: TabPage): string =
  let resul0 = adw_tab_page_get_tooltip(cast[ptr TabPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_tab_page_invalidate_thumbnail(self: ptr TabPage00) {.
    importc, libprag.}

proc invalidateThumbnail*(self: TabPage) =
  adw_tab_page_invalidate_thumbnail(cast[ptr TabPage00](self.impl))

proc adw_tab_page_set_icon(self: ptr TabPage00; icon: ptr gio.Icon00) {.
    importc, libprag.}

proc setIcon*(self: TabPage; icon: gio.Icon = nil) =
  adw_tab_page_set_icon(cast[ptr TabPage00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc `icon=`*(self: TabPage; icon: gio.Icon = nil) =
  adw_tab_page_set_icon(cast[ptr TabPage00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc adw_tab_page_set_indicator_activatable(self: ptr TabPage00; activatable: gboolean) {.
    importc, libprag.}

proc setIndicatorActivatable*(self: TabPage; activatable: bool = true) =
  adw_tab_page_set_indicator_activatable(cast[ptr TabPage00](self.impl), gboolean(activatable))

proc `indicatorActivatable=`*(self: TabPage; activatable: bool) =
  adw_tab_page_set_indicator_activatable(cast[ptr TabPage00](self.impl), gboolean(activatable))

proc adw_tab_page_set_indicator_icon(self: ptr TabPage00; indicatorIcon: ptr gio.Icon00) {.
    importc, libprag.}

proc setIndicatorIcon*(self: TabPage; indicatorIcon: gio.Icon = nil) =
  adw_tab_page_set_indicator_icon(cast[ptr TabPage00](self.impl), if indicatorIcon.isNil: nil else: cast[ptr gio.Icon00](indicatorIcon.impl))

proc `indicatorIcon=`*(self: TabPage; indicatorIcon: gio.Icon = nil) =
  adw_tab_page_set_indicator_icon(cast[ptr TabPage00](self.impl), if indicatorIcon.isNil: nil else: cast[ptr gio.Icon00](indicatorIcon.impl))

proc adw_tab_page_set_indicator_tooltip(self: ptr TabPage00; tooltip: cstring) {.
    importc, libprag.}

proc setIndicatorTooltip*(self: TabPage; tooltip: cstring) =
  adw_tab_page_set_indicator_tooltip(cast[ptr TabPage00](self.impl), tooltip)

proc `indicatorTooltip=`*(self: TabPage; tooltip: cstring) =
  adw_tab_page_set_indicator_tooltip(cast[ptr TabPage00](self.impl), tooltip)

proc adw_tab_page_set_keyword(self: ptr TabPage00; keyword: cstring) {.
    importc, libprag.}

proc setKeyword*(self: TabPage; keyword: cstring) =
  adw_tab_page_set_keyword(cast[ptr TabPage00](self.impl), keyword)

proc `keyword=`*(self: TabPage; keyword: cstring) =
  adw_tab_page_set_keyword(cast[ptr TabPage00](self.impl), keyword)

proc adw_tab_page_set_live_thumbnail(self: ptr TabPage00; liveThumbnail: gboolean) {.
    importc, libprag.}

proc setLiveThumbnail*(self: TabPage; liveThumbnail: bool = true) =
  adw_tab_page_set_live_thumbnail(cast[ptr TabPage00](self.impl), gboolean(liveThumbnail))

proc `liveThumbnail=`*(self: TabPage; liveThumbnail: bool) =
  adw_tab_page_set_live_thumbnail(cast[ptr TabPage00](self.impl), gboolean(liveThumbnail))

proc adw_tab_page_set_loading(self: ptr TabPage00; loading: gboolean) {.
    importc, libprag.}

proc setLoading*(self: TabPage; loading: bool = true) =
  adw_tab_page_set_loading(cast[ptr TabPage00](self.impl), gboolean(loading))

proc `loading=`*(self: TabPage; loading: bool) =
  adw_tab_page_set_loading(cast[ptr TabPage00](self.impl), gboolean(loading))

proc adw_tab_page_set_needs_attention(self: ptr TabPage00; needsAttention: gboolean) {.
    importc, libprag.}

proc setNeedsAttention*(self: TabPage; needsAttention: bool = true) =
  adw_tab_page_set_needs_attention(cast[ptr TabPage00](self.impl), gboolean(needsAttention))

proc `needsAttention=`*(self: TabPage; needsAttention: bool) =
  adw_tab_page_set_needs_attention(cast[ptr TabPage00](self.impl), gboolean(needsAttention))

proc adw_tab_page_set_thumbnail_xalign(self: ptr TabPage00; xalign: cfloat) {.
    importc, libprag.}

proc setThumbnailXalign*(self: TabPage; xalign: cfloat) =
  adw_tab_page_set_thumbnail_xalign(cast[ptr TabPage00](self.impl), xalign)

proc `thumbnailXalign=`*(self: TabPage; xalign: cfloat) =
  adw_tab_page_set_thumbnail_xalign(cast[ptr TabPage00](self.impl), xalign)

proc adw_tab_page_set_thumbnail_yalign(self: ptr TabPage00; yalign: cfloat) {.
    importc, libprag.}

proc setThumbnailYalign*(self: TabPage; yalign: cfloat) =
  adw_tab_page_set_thumbnail_yalign(cast[ptr TabPage00](self.impl), yalign)

proc `thumbnailYalign=`*(self: TabPage; yalign: cfloat) =
  adw_tab_page_set_thumbnail_yalign(cast[ptr TabPage00](self.impl), yalign)

proc adw_tab_page_set_title(self: ptr TabPage00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: TabPage; title: cstring) =
  adw_tab_page_set_title(cast[ptr TabPage00](self.impl), title)

proc `title=`*(self: TabPage; title: cstring) =
  adw_tab_page_set_title(cast[ptr TabPage00](self.impl), title)

proc adw_tab_page_set_tooltip(self: ptr TabPage00; tooltip: cstring) {.
    importc, libprag.}

proc setTooltip*(self: TabPage; tooltip: cstring) =
  adw_tab_page_set_tooltip(cast[ptr TabPage00](self.impl), tooltip)

proc `tooltip=`*(self: TabPage; tooltip: cstring) =
  adw_tab_page_set_tooltip(cast[ptr TabPage00](self.impl), tooltip)

type
  TabBar* = ref object of gtk4.Widget
  TabBar00* = object of gtk4.Widget00

proc adw_tab_bar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TabBar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scExtraDragDrop*(self: TabBar;  p: proc (self: ptr TabBar00; page: ptr TabPage00; value: gobject.Value; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "extra-drag-drop", cast[GCallback](p), xdata, nil, cf)

proc scExtraDragValue*(self: TabBar;  p: proc (self: ptr TabBar00; page: ptr TabPage00; value: gobject.Value; xdata: pointer): gdk4.DragAction {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "extra-drag-value", cast[GCallback](p), xdata, nil, cf)

proc adw_tab_bar_new(): ptr TabBar00 {.
    importc, libprag.}

proc newTabBar*(): TabBar =
  let gobj = adw_tab_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTabBar*(tdesc: typedesc): tdesc =
  assert(result is TabBar)
  let gobj = adw_tab_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTabBar*[T](result: var T) {.deprecated.} =
  assert(result is TabBar)
  let gobj = adw_tab_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_bar_get_autohide(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getAutohide*(self: TabBar): bool =
  toBool(adw_tab_bar_get_autohide(cast[ptr TabBar00](self.impl)))

proc autohide*(self: TabBar): bool =
  toBool(adw_tab_bar_get_autohide(cast[ptr TabBar00](self.impl)))

proc adw_tab_bar_get_end_action_widget(self: ptr TabBar00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getEndActionWidget*(self: TabBar): gtk4.Widget =
  let gobj = adw_tab_bar_get_end_action_widget(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc endActionWidget*(self: TabBar): gtk4.Widget =
  let gobj = adw_tab_bar_get_end_action_widget(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_bar_get_expand_tabs(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getExpandTabs*(self: TabBar): bool =
  toBool(adw_tab_bar_get_expand_tabs(cast[ptr TabBar00](self.impl)))

proc expandTabs*(self: TabBar): bool =
  toBool(adw_tab_bar_get_expand_tabs(cast[ptr TabBar00](self.impl)))

proc adw_tab_bar_get_extra_drag_preferred_action(self: ptr TabBar00): gdk4.DragAction {.
    importc, libprag.}

proc getExtraDragPreferredAction*(self: TabBar): gdk4.DragAction =
  adw_tab_bar_get_extra_drag_preferred_action(cast[ptr TabBar00](self.impl))

proc extraDragPreferredAction*(self: TabBar): gdk4.DragAction =
  adw_tab_bar_get_extra_drag_preferred_action(cast[ptr TabBar00](self.impl))

proc adw_tab_bar_get_extra_drag_preload(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getExtraDragPreload*(self: TabBar): bool =
  toBool(adw_tab_bar_get_extra_drag_preload(cast[ptr TabBar00](self.impl)))

proc extraDragPreload*(self: TabBar): bool =
  toBool(adw_tab_bar_get_extra_drag_preload(cast[ptr TabBar00](self.impl)))

proc adw_tab_bar_get_inverted(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getInverted*(self: TabBar): bool =
  toBool(adw_tab_bar_get_inverted(cast[ptr TabBar00](self.impl)))

proc inverted*(self: TabBar): bool =
  toBool(adw_tab_bar_get_inverted(cast[ptr TabBar00](self.impl)))

proc adw_tab_bar_get_is_overflowing(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getIsOverflowing*(self: TabBar): bool =
  toBool(adw_tab_bar_get_is_overflowing(cast[ptr TabBar00](self.impl)))

proc isOverflowing*(self: TabBar): bool =
  toBool(adw_tab_bar_get_is_overflowing(cast[ptr TabBar00](self.impl)))

proc adw_tab_bar_get_start_action_widget(self: ptr TabBar00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getStartActionWidget*(self: TabBar): gtk4.Widget =
  let gobj = adw_tab_bar_get_start_action_widget(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc startActionWidget*(self: TabBar): gtk4.Widget =
  let gobj = adw_tab_bar_get_start_action_widget(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_bar_get_tabs_revealed(self: ptr TabBar00): gboolean {.
    importc, libprag.}

proc getTabsRevealed*(self: TabBar): bool =
  toBool(adw_tab_bar_get_tabs_revealed(cast[ptr TabBar00](self.impl)))

proc tabsRevealed*(self: TabBar): bool =
  toBool(adw_tab_bar_get_tabs_revealed(cast[ptr TabBar00](self.impl)))

proc adw_tab_bar_set_autohide(self: ptr TabBar00; autohide: gboolean) {.
    importc, libprag.}

proc setAutohide*(self: TabBar; autohide: bool = true) =
  adw_tab_bar_set_autohide(cast[ptr TabBar00](self.impl), gboolean(autohide))

proc `autohide=`*(self: TabBar; autohide: bool) =
  adw_tab_bar_set_autohide(cast[ptr TabBar00](self.impl), gboolean(autohide))

proc adw_tab_bar_set_end_action_widget(self: ptr TabBar00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setEndActionWidget*(self: TabBar; widget: gtk4.Widget = nil) =
  adw_tab_bar_set_end_action_widget(cast[ptr TabBar00](self.impl), if widget.isNil: nil else: cast[ptr gtk4.Widget00](widget.impl))

proc `endActionWidget=`*(self: TabBar; widget: gtk4.Widget = nil) =
  adw_tab_bar_set_end_action_widget(cast[ptr TabBar00](self.impl), if widget.isNil: nil else: cast[ptr gtk4.Widget00](widget.impl))

proc adw_tab_bar_set_expand_tabs(self: ptr TabBar00; expandTabs: gboolean) {.
    importc, libprag.}

proc setExpandTabs*(self: TabBar; expandTabs: bool = true) =
  adw_tab_bar_set_expand_tabs(cast[ptr TabBar00](self.impl), gboolean(expandTabs))

proc `expandTabs=`*(self: TabBar; expandTabs: bool) =
  adw_tab_bar_set_expand_tabs(cast[ptr TabBar00](self.impl), gboolean(expandTabs))

proc adw_tab_bar_set_extra_drag_preload(self: ptr TabBar00; preload: gboolean) {.
    importc, libprag.}

proc setExtraDragPreload*(self: TabBar; preload: bool = true) =
  adw_tab_bar_set_extra_drag_preload(cast[ptr TabBar00](self.impl), gboolean(preload))

proc `extraDragPreload=`*(self: TabBar; preload: bool) =
  adw_tab_bar_set_extra_drag_preload(cast[ptr TabBar00](self.impl), gboolean(preload))

proc adw_tab_bar_set_inverted(self: ptr TabBar00; inverted: gboolean) {.
    importc, libprag.}

proc setInverted*(self: TabBar; inverted: bool = true) =
  adw_tab_bar_set_inverted(cast[ptr TabBar00](self.impl), gboolean(inverted))

proc `inverted=`*(self: TabBar; inverted: bool) =
  adw_tab_bar_set_inverted(cast[ptr TabBar00](self.impl), gboolean(inverted))

proc adw_tab_bar_set_start_action_widget(self: ptr TabBar00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setStartActionWidget*(self: TabBar; widget: gtk4.Widget = nil) =
  adw_tab_bar_set_start_action_widget(cast[ptr TabBar00](self.impl), if widget.isNil: nil else: cast[ptr gtk4.Widget00](widget.impl))

proc `startActionWidget=`*(self: TabBar; widget: gtk4.Widget = nil) =
  adw_tab_bar_set_start_action_widget(cast[ptr TabBar00](self.impl), if widget.isNil: nil else: cast[ptr gtk4.Widget00](widget.impl))

proc adw_tab_bar_setup_extra_drop_target(self: ptr TabBar00; actions: gdk4.DragAction;
    types: ptr GType; nTypes: uint64) {.
    importc, libprag.}

proc setupExtraDropTarget*(self: TabBar; actions: gdk4.DragAction;
    types: ptr GType; nTypes: uint64) =
  adw_tab_bar_setup_extra_drop_target(cast[ptr TabBar00](self.impl), actions, types, nTypes)

type
  TabView* = ref object of gtk4.Widget
  TabView00* = object of gtk4.Widget00

proc adw_tab_view_get_type*(): GType {.importc, libprag.}

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

proc adw_tab_view_new(): ptr TabView00 {.
    importc, libprag.}

proc newTabView*(): TabView =
  let gobj = adw_tab_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTabView*(tdesc: typedesc): tdesc =
  assert(result is TabView)
  let gobj = adw_tab_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTabView*[T](result: var T) {.deprecated.} =
  assert(result is TabView)
  let gobj = adw_tab_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_add_page(self: ptr TabView00; child: ptr gtk4.Widget00;
    parent: ptr TabPage00): ptr TabPage00 {.
    importc, libprag.}

proc addPage*(self: TabView; child: gtk4.Widget; parent: TabPage = nil): TabPage =
  let gobj = adw_tab_view_add_page(cast[ptr TabView00](self.impl), cast[ptr gtk4.Widget00](child.impl), if parent.isNil: nil else: cast[ptr TabPage00](parent.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_append(self: ptr TabView00; child: ptr gtk4.Widget00): ptr TabPage00 {.
    importc, libprag.}

proc append*(self: TabView; child: gtk4.Widget): TabPage =
  let gobj = adw_tab_view_append(cast[ptr TabView00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_append_pinned(self: ptr TabView00; child: ptr gtk4.Widget00): ptr TabPage00 {.
    importc, libprag.}

proc appendPinned*(self: TabView; child: gtk4.Widget): TabPage =
  let gobj = adw_tab_view_append_pinned(cast[ptr TabView00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_close_other_pages(self: ptr TabView00; page: ptr TabPage00) {.
    importc, libprag.}

proc closeOtherPages*(self: TabView; page: TabPage) =
  adw_tab_view_close_other_pages(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl))

proc adw_tab_view_close_page(self: ptr TabView00; page: ptr TabPage00) {.
    importc, libprag.}

proc closePage*(self: TabView; page: TabPage) =
  adw_tab_view_close_page(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl))

proc adw_tab_view_close_page_finish(self: ptr TabView00; page: ptr TabPage00;
    confirm: gboolean) {.
    importc, libprag.}

proc closePageFinish*(self: TabView; page: TabPage; confirm: bool) =
  adw_tab_view_close_page_finish(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl), gboolean(confirm))

proc adw_tab_view_close_pages_after(self: ptr TabView00; page: ptr TabPage00) {.
    importc, libprag.}

proc closePagesAfter*(self: TabView; page: TabPage) =
  adw_tab_view_close_pages_after(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl))

proc adw_tab_view_close_pages_before(self: ptr TabView00; page: ptr TabPage00) {.
    importc, libprag.}

proc closePagesBefore*(self: TabView; page: TabPage) =
  adw_tab_view_close_pages_before(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl))

proc adw_tab_view_get_default_icon(self: ptr TabView00): ptr gio.Icon00 {.
    importc, libprag.}

proc getDefaultIcon*(self: TabView): gio.Icon =
  let gobj = adw_tab_view_get_default_icon(cast[ptr TabView00](self.impl))
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
  let gobj = adw_tab_view_get_default_icon(cast[ptr TabView00](self.impl))
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

proc adw_tab_view_get_is_transferring_page(self: ptr TabView00): gboolean {.
    importc, libprag.}

proc getIsTransferringPage*(self: TabView): bool =
  toBool(adw_tab_view_get_is_transferring_page(cast[ptr TabView00](self.impl)))

proc isTransferringPage*(self: TabView): bool =
  toBool(adw_tab_view_get_is_transferring_page(cast[ptr TabView00](self.impl)))

proc adw_tab_view_get_menu_model(self: ptr TabView00): ptr gio.MenuModel00 {.
    importc, libprag.}

proc getMenuModel*(self: TabView): gio.MenuModel =
  let gobj = adw_tab_view_get_menu_model(cast[ptr TabView00](self.impl))
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
  let gobj = adw_tab_view_get_menu_model(cast[ptr TabView00](self.impl))
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

proc adw_tab_view_get_n_pages(self: ptr TabView00): int32 {.
    importc, libprag.}

proc getNPages*(self: TabView): int =
  int(adw_tab_view_get_n_pages(cast[ptr TabView00](self.impl)))

proc nPages*(self: TabView): int =
  int(adw_tab_view_get_n_pages(cast[ptr TabView00](self.impl)))

proc adw_tab_view_get_n_pinned_pages(self: ptr TabView00): int32 {.
    importc, libprag.}

proc getNPinnedPages*(self: TabView): int =
  int(adw_tab_view_get_n_pinned_pages(cast[ptr TabView00](self.impl)))

proc nPinnedPages*(self: TabView): int =
  int(adw_tab_view_get_n_pinned_pages(cast[ptr TabView00](self.impl)))

proc adw_tab_view_get_nth_page(self: ptr TabView00; position: int32): ptr TabPage00 {.
    importc, libprag.}

proc getNthPage*(self: TabView; position: int): TabPage =
  let gobj = adw_tab_view_get_nth_page(cast[ptr TabView00](self.impl), int32(position))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_get_page(self: ptr TabView00; child: ptr gtk4.Widget00): ptr TabPage00 {.
    importc, libprag.}

proc getPage*(self: TabView; child: gtk4.Widget): TabPage =
  let gobj = adw_tab_view_get_page(cast[ptr TabView00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_get_page_position(self: ptr TabView00; page: ptr TabPage00): int32 {.
    importc, libprag.}

proc getPagePosition*(self: TabView; page: TabPage): int =
  int(adw_tab_view_get_page_position(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl)))

proc adw_tab_view_get_pages(self: ptr TabView00): ptr gtk4.SelectionModel00 {.
    importc, libprag.}

proc getPages*(self: TabView): gtk4.SelectionModel =
  let gobj = adw_tab_view_get_pages(cast[ptr TabView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pages*(self: TabView): gtk4.SelectionModel =
  let gobj = adw_tab_view_get_pages(cast[ptr TabView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_get_selected_page(self: ptr TabView00): ptr TabPage00 {.
    importc, libprag.}

proc getSelectedPage*(self: TabView): TabPage =
  let gobj = adw_tab_view_get_selected_page(cast[ptr TabView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc selectedPage*(self: TabView): TabPage =
  let gobj = adw_tab_view_get_selected_page(cast[ptr TabView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_insert(self: ptr TabView00; child: ptr gtk4.Widget00; position: int32): ptr TabPage00 {.
    importc, libprag.}

proc insert*(self: TabView; child: gtk4.Widget; position: int): TabPage =
  let gobj = adw_tab_view_insert(cast[ptr TabView00](self.impl), cast[ptr gtk4.Widget00](child.impl), int32(position))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_insert_pinned(self: ptr TabView00; child: ptr gtk4.Widget00;
    position: int32): ptr TabPage00 {.
    importc, libprag.}

proc insertPinned*(self: TabView; child: gtk4.Widget; position: int): TabPage =
  let gobj = adw_tab_view_insert_pinned(cast[ptr TabView00](self.impl), cast[ptr gtk4.Widget00](child.impl), int32(position))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_invalidate_thumbnails(self: ptr TabView00) {.
    importc, libprag.}

proc invalidateThumbnails*(self: TabView) =
  adw_tab_view_invalidate_thumbnails(cast[ptr TabView00](self.impl))

proc adw_tab_view_prepend(self: ptr TabView00; child: ptr gtk4.Widget00): ptr TabPage00 {.
    importc, libprag.}

proc prepend*(self: TabView; child: gtk4.Widget): TabPage =
  let gobj = adw_tab_view_prepend(cast[ptr TabView00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_prepend_pinned(self: ptr TabView00; child: ptr gtk4.Widget00): ptr TabPage00 {.
    importc, libprag.}

proc prependPinned*(self: TabView; child: gtk4.Widget): TabPage =
  let gobj = adw_tab_view_prepend_pinned(cast[ptr TabView00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_view_reorder_backward(self: ptr TabView00; page: ptr TabPage00): gboolean {.
    importc, libprag.}

proc reorderBackward*(self: TabView; page: TabPage): bool =
  toBool(adw_tab_view_reorder_backward(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl)))

proc adw_tab_view_reorder_first(self: ptr TabView00; page: ptr TabPage00): gboolean {.
    importc, libprag.}

proc reorderFirst*(self: TabView; page: TabPage): bool =
  toBool(adw_tab_view_reorder_first(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl)))

proc adw_tab_view_reorder_forward(self: ptr TabView00; page: ptr TabPage00): gboolean {.
    importc, libprag.}

proc reorderForward*(self: TabView; page: TabPage): bool =
  toBool(adw_tab_view_reorder_forward(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl)))

proc adw_tab_view_reorder_last(self: ptr TabView00; page: ptr TabPage00): gboolean {.
    importc, libprag.}

proc reorderLast*(self: TabView; page: TabPage): bool =
  toBool(adw_tab_view_reorder_last(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl)))

proc adw_tab_view_reorder_page(self: ptr TabView00; page: ptr TabPage00;
    position: int32): gboolean {.
    importc, libprag.}

proc reorderPage*(self: TabView; page: TabPage; position: int): bool =
  toBool(adw_tab_view_reorder_page(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl), int32(position)))

proc adw_tab_view_select_next_page(self: ptr TabView00): gboolean {.
    importc, libprag.}

proc selectNextPage*(self: TabView): bool =
  toBool(adw_tab_view_select_next_page(cast[ptr TabView00](self.impl)))

proc adw_tab_view_select_previous_page(self: ptr TabView00): gboolean {.
    importc, libprag.}

proc selectPreviousPage*(self: TabView): bool =
  toBool(adw_tab_view_select_previous_page(cast[ptr TabView00](self.impl)))

proc adw_tab_view_set_default_icon(self: ptr TabView00; defaultIcon: ptr gio.Icon00) {.
    importc, libprag.}

proc setDefaultIcon*(self: TabView; defaultIcon: gio.Icon) =
  adw_tab_view_set_default_icon(cast[ptr TabView00](self.impl), cast[ptr gio.Icon00](defaultIcon.impl))

proc `defaultIcon=`*(self: TabView; defaultIcon: gio.Icon) =
  adw_tab_view_set_default_icon(cast[ptr TabView00](self.impl), cast[ptr gio.Icon00](defaultIcon.impl))

proc adw_tab_view_set_menu_model(self: ptr TabView00; menuModel: ptr gio.MenuModel00) {.
    importc, libprag.}

proc setMenuModel*(self: TabView; menuModel: gio.MenuModel = nil) =
  adw_tab_view_set_menu_model(cast[ptr TabView00](self.impl), if menuModel.isNil: nil else: cast[ptr gio.MenuModel00](menuModel.impl))

proc `menuModel=`*(self: TabView; menuModel: gio.MenuModel = nil) =
  adw_tab_view_set_menu_model(cast[ptr TabView00](self.impl), if menuModel.isNil: nil else: cast[ptr gio.MenuModel00](menuModel.impl))

proc adw_tab_view_set_page_pinned(self: ptr TabView00; page: ptr TabPage00;
    pinned: gboolean) {.
    importc, libprag.}

proc setPagePinned*(self: TabView; page: TabPage; pinned: bool) =
  adw_tab_view_set_page_pinned(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl), gboolean(pinned))

proc adw_tab_view_set_selected_page(self: ptr TabView00; selectedPage: ptr TabPage00) {.
    importc, libprag.}

proc setSelectedPage*(self: TabView; selectedPage: TabPage) =
  adw_tab_view_set_selected_page(cast[ptr TabView00](self.impl), cast[ptr TabPage00](selectedPage.impl))

proc `selectedPage=`*(self: TabView; selectedPage: TabPage) =
  adw_tab_view_set_selected_page(cast[ptr TabView00](self.impl), cast[ptr TabPage00](selectedPage.impl))

proc adw_tab_view_transfer_page(self: ptr TabView00; page: ptr TabPage00;
    otherView: ptr TabView00; position: int32) {.
    importc, libprag.}

proc transferPage*(self: TabView; page: TabPage; otherView: TabView;
    position: int) =
  adw_tab_view_transfer_page(cast[ptr TabView00](self.impl), cast[ptr TabPage00](page.impl), cast[ptr TabView00](otherView.impl), int32(position))

proc adw_tab_bar_get_view(self: ptr TabBar00): ptr TabView00 {.
    importc, libprag.}

proc getView*(self: TabBar): TabView =
  let gobj = adw_tab_bar_get_view(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: TabBar): TabView =
  let gobj = adw_tab_bar_get_view(cast[ptr TabBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_bar_set_view(self: ptr TabBar00; view: ptr TabView00) {.
    importc, libprag.}

proc setView*(self: TabBar; view: TabView = nil) =
  adw_tab_bar_set_view(cast[ptr TabBar00](self.impl), if view.isNil: nil else: cast[ptr TabView00](view.impl))

proc `view=`*(self: TabBar; view: TabView = nil) =
  adw_tab_bar_set_view(cast[ptr TabBar00](self.impl), if view.isNil: nil else: cast[ptr TabView00](view.impl))

type
  TabViewShortcuts* {.size: sizeof(cint), pure.} = enum
    none = 0
    controlTab = 1
    controlShiftTab = 2
    controlPageUp = 4
    controlPageDown = 8
    controlHome = 16
    controlEnd = 32
    controlShiftPageUp = 64
    controlShiftPageDown = 128
    controlShiftHome = 256
    controlShiftEnd = 512
    altDigits = 1024
    altZero = 2048
    allShortcuts = 4095

proc adw_tab_view_add_shortcuts(self: ptr TabView00; shortcuts: TabViewShortcuts) {.
    importc, libprag.}

proc addShortcuts*(self: TabView; shortcuts: TabViewShortcuts) =
  adw_tab_view_add_shortcuts(cast[ptr TabView00](self.impl), shortcuts)

proc adw_tab_view_get_shortcuts(self: ptr TabView00): TabViewShortcuts {.
    importc, libprag.}

proc getShortcuts*(self: TabView): TabViewShortcuts =
  adw_tab_view_get_shortcuts(cast[ptr TabView00](self.impl))

proc shortcuts*(self: TabView): TabViewShortcuts =
  adw_tab_view_get_shortcuts(cast[ptr TabView00](self.impl))

proc adw_tab_view_remove_shortcuts(self: ptr TabView00; shortcuts: TabViewShortcuts) {.
    importc, libprag.}

proc removeShortcuts*(self: TabView; shortcuts: TabViewShortcuts) =
  adw_tab_view_remove_shortcuts(cast[ptr TabView00](self.impl), shortcuts)

proc adw_tab_view_set_shortcuts(self: ptr TabView00; shortcuts: TabViewShortcuts) {.
    importc, libprag.}

proc setShortcuts*(self: TabView; shortcuts: TabViewShortcuts) =
  adw_tab_view_set_shortcuts(cast[ptr TabView00](self.impl), shortcuts)

proc `shortcuts=`*(self: TabView; shortcuts: TabViewShortcuts) =
  adw_tab_view_set_shortcuts(cast[ptr TabView00](self.impl), shortcuts)

type
  TabButton* = ref object of gtk4.Widget
  TabButton00* = object of gtk4.Widget00

proc adw_tab_button_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TabButton()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActivate*(self: TabButton;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "activate", cast[GCallback](p), xdata, nil, cf)

proc scClicked*(self: TabButton;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "clicked", cast[GCallback](p), xdata, nil, cf)

proc adw_tab_button_new(): ptr TabButton00 {.
    importc, libprag.}

proc newTabButton*(): TabButton =
  let gobj = adw_tab_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTabButton*(tdesc: typedesc): tdesc =
  assert(result is TabButton)
  let gobj = adw_tab_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTabButton*[T](result: var T) {.deprecated.} =
  assert(result is TabButton)
  let gobj = adw_tab_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_button_get_view(self: ptr TabButton00): ptr TabView00 {.
    importc, libprag.}

proc getView*(self: TabButton): TabView =
  let gobj = adw_tab_button_get_view(cast[ptr TabButton00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: TabButton): TabView =
  let gobj = adw_tab_button_get_view(cast[ptr TabButton00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_button_set_view(self: ptr TabButton00; view: ptr TabView00) {.
    importc, libprag.}

proc setView*(self: TabButton; view: TabView = nil) =
  adw_tab_button_set_view(cast[ptr TabButton00](self.impl), if view.isNil: nil else: cast[ptr TabView00](view.impl))

proc `view=`*(self: TabButton; view: TabView = nil) =
  adw_tab_button_set_view(cast[ptr TabButton00](self.impl), if view.isNil: nil else: cast[ptr TabView00](view.impl))

type
  TabOverview* = ref object of gtk4.Widget
  TabOverview00* = object of gtk4.Widget00

proc adw_tab_overview_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TabOverview()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCreateTab*(self: TabOverview;  p: proc (self: ptr TabOverview00; xdata: pointer): ptr TabPage00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "create-tab", cast[GCallback](p), xdata, nil, cf)

proc scExtraDragDrop*(self: TabOverview;  p: proc (self: ptr TabOverview00; page: ptr TabPage00; value: gobject.Value; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "extra-drag-drop", cast[GCallback](p), xdata, nil, cf)

proc scExtraDragValue*(self: TabOverview;  p: proc (self: ptr TabOverview00; page: ptr TabPage00; value: gobject.Value; xdata: pointer): gdk4.DragAction {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "extra-drag-value", cast[GCallback](p), xdata, nil, cf)

proc adw_tab_overview_new(): ptr TabOverview00 {.
    importc, libprag.}

proc newTabOverview*(): TabOverview =
  let gobj = adw_tab_overview_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTabOverview*(tdesc: typedesc): tdesc =
  assert(result is TabOverview)
  let gobj = adw_tab_overview_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTabOverview*[T](result: var T) {.deprecated.} =
  assert(result is TabOverview)
  let gobj = adw_tab_overview_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_overview_get_child(self: ptr TabOverview00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: TabOverview): gtk4.Widget =
  let gobj = adw_tab_overview_get_child(cast[ptr TabOverview00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: TabOverview): gtk4.Widget =
  let gobj = adw_tab_overview_get_child(cast[ptr TabOverview00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_overview_get_enable_new_tab(self: ptr TabOverview00): gboolean {.
    importc, libprag.}

proc getEnableNewTab*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_enable_new_tab(cast[ptr TabOverview00](self.impl)))

proc enableNewTab*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_enable_new_tab(cast[ptr TabOverview00](self.impl)))

proc adw_tab_overview_get_enable_search(self: ptr TabOverview00): gboolean {.
    importc, libprag.}

proc getEnableSearch*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_enable_search(cast[ptr TabOverview00](self.impl)))

proc enableSearch*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_enable_search(cast[ptr TabOverview00](self.impl)))

proc adw_tab_overview_get_extra_drag_preferred_action(self: ptr TabOverview00): gdk4.DragAction {.
    importc, libprag.}

proc getExtraDragPreferredAction*(self: TabOverview): gdk4.DragAction =
  adw_tab_overview_get_extra_drag_preferred_action(cast[ptr TabOverview00](self.impl))

proc extraDragPreferredAction*(self: TabOverview): gdk4.DragAction =
  adw_tab_overview_get_extra_drag_preferred_action(cast[ptr TabOverview00](self.impl))

proc adw_tab_overview_get_extra_drag_preload(self: ptr TabOverview00): gboolean {.
    importc, libprag.}

proc getExtraDragPreload*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_extra_drag_preload(cast[ptr TabOverview00](self.impl)))

proc extraDragPreload*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_extra_drag_preload(cast[ptr TabOverview00](self.impl)))

proc adw_tab_overview_get_inverted(self: ptr TabOverview00): gboolean {.
    importc, libprag.}

proc getInverted*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_inverted(cast[ptr TabOverview00](self.impl)))

proc inverted*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_inverted(cast[ptr TabOverview00](self.impl)))

proc adw_tab_overview_get_open(self: ptr TabOverview00): gboolean {.
    importc, libprag.}

proc getOpen*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_open(cast[ptr TabOverview00](self.impl)))

proc open*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_open(cast[ptr TabOverview00](self.impl)))

proc adw_tab_overview_get_search_active(self: ptr TabOverview00): gboolean {.
    importc, libprag.}

proc getSearchActive*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_search_active(cast[ptr TabOverview00](self.impl)))

proc searchActive*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_search_active(cast[ptr TabOverview00](self.impl)))

proc adw_tab_overview_get_secondary_menu(self: ptr TabOverview00): ptr gio.MenuModel00 {.
    importc, libprag.}

proc getSecondaryMenu*(self: TabOverview): gio.MenuModel =
  let gobj = adw_tab_overview_get_secondary_menu(cast[ptr TabOverview00](self.impl))
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

proc secondaryMenu*(self: TabOverview): gio.MenuModel =
  let gobj = adw_tab_overview_get_secondary_menu(cast[ptr TabOverview00](self.impl))
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

proc adw_tab_overview_get_show_end_title_buttons(self: ptr TabOverview00): gboolean {.
    importc, libprag.}

proc getShowEndTitleButtons*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_show_end_title_buttons(cast[ptr TabOverview00](self.impl)))

proc showEndTitleButtons*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_show_end_title_buttons(cast[ptr TabOverview00](self.impl)))

proc adw_tab_overview_get_show_start_title_buttons(self: ptr TabOverview00): gboolean {.
    importc, libprag.}

proc getShowStartTitleButtons*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_show_start_title_buttons(cast[ptr TabOverview00](self.impl)))

proc showStartTitleButtons*(self: TabOverview): bool =
  toBool(adw_tab_overview_get_show_start_title_buttons(cast[ptr TabOverview00](self.impl)))

proc adw_tab_overview_get_view(self: ptr TabOverview00): ptr TabView00 {.
    importc, libprag.}

proc getView*(self: TabOverview): TabView =
  let gobj = adw_tab_overview_get_view(cast[ptr TabOverview00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: TabOverview): TabView =
  let gobj = adw_tab_overview_get_view(cast[ptr TabOverview00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_tab_overview_set_child(self: ptr TabOverview00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setChild*(self: TabOverview; child: gtk4.Widget = nil) =
  adw_tab_overview_set_child(cast[ptr TabOverview00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `child=`*(self: TabOverview; child: gtk4.Widget = nil) =
  adw_tab_overview_set_child(cast[ptr TabOverview00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc adw_tab_overview_set_enable_new_tab(self: ptr TabOverview00; enableNewTab: gboolean) {.
    importc, libprag.}

proc setEnableNewTab*(self: TabOverview; enableNewTab: bool = true) =
  adw_tab_overview_set_enable_new_tab(cast[ptr TabOverview00](self.impl), gboolean(enableNewTab))

proc `enableNewTab=`*(self: TabOverview; enableNewTab: bool) =
  adw_tab_overview_set_enable_new_tab(cast[ptr TabOverview00](self.impl), gboolean(enableNewTab))

proc adw_tab_overview_set_enable_search(self: ptr TabOverview00; enableSearch: gboolean) {.
    importc, libprag.}

proc setEnableSearch*(self: TabOverview; enableSearch: bool = true) =
  adw_tab_overview_set_enable_search(cast[ptr TabOverview00](self.impl), gboolean(enableSearch))

proc `enableSearch=`*(self: TabOverview; enableSearch: bool) =
  adw_tab_overview_set_enable_search(cast[ptr TabOverview00](self.impl), gboolean(enableSearch))

proc adw_tab_overview_set_extra_drag_preload(self: ptr TabOverview00; preload: gboolean) {.
    importc, libprag.}

proc setExtraDragPreload*(self: TabOverview; preload: bool = true) =
  adw_tab_overview_set_extra_drag_preload(cast[ptr TabOverview00](self.impl), gboolean(preload))

proc `extraDragPreload=`*(self: TabOverview; preload: bool) =
  adw_tab_overview_set_extra_drag_preload(cast[ptr TabOverview00](self.impl), gboolean(preload))

proc adw_tab_overview_set_inverted(self: ptr TabOverview00; inverted: gboolean) {.
    importc, libprag.}

proc setInverted*(self: TabOverview; inverted: bool = true) =
  adw_tab_overview_set_inverted(cast[ptr TabOverview00](self.impl), gboolean(inverted))

proc `inverted=`*(self: TabOverview; inverted: bool) =
  adw_tab_overview_set_inverted(cast[ptr TabOverview00](self.impl), gboolean(inverted))

proc adw_tab_overview_set_open(self: ptr TabOverview00; open: gboolean) {.
    importc, libprag.}

proc setOpen*(self: TabOverview; open: bool = true) =
  adw_tab_overview_set_open(cast[ptr TabOverview00](self.impl), gboolean(open))

proc `open=`*(self: TabOverview; open: bool) =
  adw_tab_overview_set_open(cast[ptr TabOverview00](self.impl), gboolean(open))

proc adw_tab_overview_set_secondary_menu(self: ptr TabOverview00; secondaryMenu: ptr gio.MenuModel00) {.
    importc, libprag.}

proc setSecondaryMenu*(self: TabOverview; secondaryMenu: gio.MenuModel = nil) =
  adw_tab_overview_set_secondary_menu(cast[ptr TabOverview00](self.impl), if secondaryMenu.isNil: nil else: cast[ptr gio.MenuModel00](secondaryMenu.impl))

proc `secondaryMenu=`*(self: TabOverview; secondaryMenu: gio.MenuModel = nil) =
  adw_tab_overview_set_secondary_menu(cast[ptr TabOverview00](self.impl), if secondaryMenu.isNil: nil else: cast[ptr gio.MenuModel00](secondaryMenu.impl))

proc adw_tab_overview_set_show_end_title_buttons(self: ptr TabOverview00;
    showEndTitleButtons: gboolean) {.
    importc, libprag.}

proc setShowEndTitleButtons*(self: TabOverview; showEndTitleButtons: bool = true) =
  adw_tab_overview_set_show_end_title_buttons(cast[ptr TabOverview00](self.impl), gboolean(showEndTitleButtons))

proc `showEndTitleButtons=`*(self: TabOverview; showEndTitleButtons: bool) =
  adw_tab_overview_set_show_end_title_buttons(cast[ptr TabOverview00](self.impl), gboolean(showEndTitleButtons))

proc adw_tab_overview_set_show_start_title_buttons(self: ptr TabOverview00;
    showStartTitleButtons: gboolean) {.
    importc, libprag.}

proc setShowStartTitleButtons*(self: TabOverview; showStartTitleButtons: bool = true) =
  adw_tab_overview_set_show_start_title_buttons(cast[ptr TabOverview00](self.impl), gboolean(showStartTitleButtons))

proc `showStartTitleButtons=`*(self: TabOverview; showStartTitleButtons: bool) =
  adw_tab_overview_set_show_start_title_buttons(cast[ptr TabOverview00](self.impl), gboolean(showStartTitleButtons))

proc adw_tab_overview_set_view(self: ptr TabOverview00; view: ptr TabView00) {.
    importc, libprag.}

proc setView*(self: TabOverview; view: TabView = nil) =
  adw_tab_overview_set_view(cast[ptr TabOverview00](self.impl), if view.isNil: nil else: cast[ptr TabView00](view.impl))

proc `view=`*(self: TabOverview; view: TabView = nil) =
  adw_tab_overview_set_view(cast[ptr TabOverview00](self.impl), if view.isNil: nil else: cast[ptr TabView00](view.impl))

proc adw_tab_overview_setup_extra_drop_target(self: ptr TabOverview00; actions: gdk4.DragAction;
    types: ptr GType; nTypes: uint64) {.
    importc, libprag.}

proc setupExtraDropTarget*(self: TabOverview; actions: gdk4.DragAction;
    types: ptr GType; nTypes: uint64) =
  adw_tab_overview_setup_extra_drop_target(cast[ptr TabOverview00](self.impl), actions, types, nTypes)

type
  TimedAnimation* = ref object of Animation
  TimedAnimation00* = object of Animation00

proc adw_timed_animation_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TimedAnimation()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_timed_animation_new(widget: ptr gtk4.Widget00; `from`: cdouble;
    to: cdouble; duration: uint32; target: ptr AnimationTarget00): ptr TimedAnimation00 {.
    importc, libprag.}

proc newTimedAnimation*(widget: gtk4.Widget; `from`: cdouble; to: cdouble;
    duration: int; target: AnimationTarget): TimedAnimation =
  let gobj = adw_timed_animation_new(cast[ptr gtk4.Widget00](widget.impl), `from`, to, uint32(duration), cast[ptr AnimationTarget00](g_object_ref(target.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTimedAnimation*(tdesc: typedesc; widget: gtk4.Widget; `from`: cdouble; to: cdouble;
    duration: int; target: AnimationTarget): tdesc =
  assert(result is TimedAnimation)
  let gobj = adw_timed_animation_new(cast[ptr gtk4.Widget00](widget.impl), `from`, to, uint32(duration), cast[ptr AnimationTarget00](g_object_ref(target.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTimedAnimation*[T](result: var T; widget: gtk4.Widget; `from`: cdouble; to: cdouble;
    duration: int; target: AnimationTarget) {.deprecated.} =
  assert(result is TimedAnimation)
  let gobj = adw_timed_animation_new(cast[ptr gtk4.Widget00](widget.impl), `from`, to, uint32(duration), cast[ptr AnimationTarget00](g_object_ref(target.impl)))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_timed_animation_get_alternate(self: ptr TimedAnimation00): gboolean {.
    importc, libprag.}

proc getAlternate*(self: TimedAnimation): bool =
  toBool(adw_timed_animation_get_alternate(cast[ptr TimedAnimation00](self.impl)))

proc alternate*(self: TimedAnimation): bool =
  toBool(adw_timed_animation_get_alternate(cast[ptr TimedAnimation00](self.impl)))

proc adw_timed_animation_get_duration(self: ptr TimedAnimation00): uint32 {.
    importc, libprag.}

proc getDuration*(self: TimedAnimation): int =
  int(adw_timed_animation_get_duration(cast[ptr TimedAnimation00](self.impl)))

proc duration*(self: TimedAnimation): int =
  int(adw_timed_animation_get_duration(cast[ptr TimedAnimation00](self.impl)))

proc adw_timed_animation_get_easing(self: ptr TimedAnimation00): Easing {.
    importc, libprag.}

proc getEasing*(self: TimedAnimation): Easing =
  adw_timed_animation_get_easing(cast[ptr TimedAnimation00](self.impl))

proc easing*(self: TimedAnimation): Easing =
  adw_timed_animation_get_easing(cast[ptr TimedAnimation00](self.impl))

proc adw_timed_animation_get_repeat_count(self: ptr TimedAnimation00): uint32 {.
    importc, libprag.}

proc getRepeatCount*(self: TimedAnimation): int =
  int(adw_timed_animation_get_repeat_count(cast[ptr TimedAnimation00](self.impl)))

proc repeatCount*(self: TimedAnimation): int =
  int(adw_timed_animation_get_repeat_count(cast[ptr TimedAnimation00](self.impl)))

proc adw_timed_animation_get_reverse(self: ptr TimedAnimation00): gboolean {.
    importc, libprag.}

proc getReverse*(self: TimedAnimation): bool =
  toBool(adw_timed_animation_get_reverse(cast[ptr TimedAnimation00](self.impl)))

proc reverse*(self: TimedAnimation): bool =
  toBool(adw_timed_animation_get_reverse(cast[ptr TimedAnimation00](self.impl)))

proc adw_timed_animation_get_value_from(self: ptr TimedAnimation00): cdouble {.
    importc, libprag.}

proc getValueFrom*(self: TimedAnimation): cdouble =
  adw_timed_animation_get_value_from(cast[ptr TimedAnimation00](self.impl))

proc valueFrom*(self: TimedAnimation): cdouble =
  adw_timed_animation_get_value_from(cast[ptr TimedAnimation00](self.impl))

proc adw_timed_animation_get_value_to(self: ptr TimedAnimation00): cdouble {.
    importc, libprag.}

proc getValueTo*(self: TimedAnimation): cdouble =
  adw_timed_animation_get_value_to(cast[ptr TimedAnimation00](self.impl))

proc valueTo*(self: TimedAnimation): cdouble =
  adw_timed_animation_get_value_to(cast[ptr TimedAnimation00](self.impl))

proc adw_timed_animation_set_alternate(self: ptr TimedAnimation00; alternate: gboolean) {.
    importc, libprag.}

proc setAlternate*(self: TimedAnimation; alternate: bool = true) =
  adw_timed_animation_set_alternate(cast[ptr TimedAnimation00](self.impl), gboolean(alternate))

proc `alternate=`*(self: TimedAnimation; alternate: bool) =
  adw_timed_animation_set_alternate(cast[ptr TimedAnimation00](self.impl), gboolean(alternate))

proc adw_timed_animation_set_duration(self: ptr TimedAnimation00; duration: uint32) {.
    importc, libprag.}

proc setDuration*(self: TimedAnimation; duration: int) =
  adw_timed_animation_set_duration(cast[ptr TimedAnimation00](self.impl), uint32(duration))

proc `duration=`*(self: TimedAnimation; duration: int) =
  adw_timed_animation_set_duration(cast[ptr TimedAnimation00](self.impl), uint32(duration))

proc adw_timed_animation_set_easing(self: ptr TimedAnimation00; easing: Easing) {.
    importc, libprag.}

proc setEasing*(self: TimedAnimation; easing: Easing) =
  adw_timed_animation_set_easing(cast[ptr TimedAnimation00](self.impl), easing)

proc `easing=`*(self: TimedAnimation; easing: Easing) =
  adw_timed_animation_set_easing(cast[ptr TimedAnimation00](self.impl), easing)

proc adw_timed_animation_set_repeat_count(self: ptr TimedAnimation00; repeatCount: uint32) {.
    importc, libprag.}

proc setRepeatCount*(self: TimedAnimation; repeatCount: int) =
  adw_timed_animation_set_repeat_count(cast[ptr TimedAnimation00](self.impl), uint32(repeatCount))

proc `repeatCount=`*(self: TimedAnimation; repeatCount: int) =
  adw_timed_animation_set_repeat_count(cast[ptr TimedAnimation00](self.impl), uint32(repeatCount))

proc adw_timed_animation_set_reverse(self: ptr TimedAnimation00; reverse: gboolean) {.
    importc, libprag.}

proc setReverse*(self: TimedAnimation; reverse: bool = true) =
  adw_timed_animation_set_reverse(cast[ptr TimedAnimation00](self.impl), gboolean(reverse))

proc `reverse=`*(self: TimedAnimation; reverse: bool) =
  adw_timed_animation_set_reverse(cast[ptr TimedAnimation00](self.impl), gboolean(reverse))

proc adw_timed_animation_set_value_from(self: ptr TimedAnimation00; value: cdouble) {.
    importc, libprag.}

proc setValueFrom*(self: TimedAnimation; value: cdouble) =
  adw_timed_animation_set_value_from(cast[ptr TimedAnimation00](self.impl), value)

proc `valueFrom=`*(self: TimedAnimation; value: cdouble) =
  adw_timed_animation_set_value_from(cast[ptr TimedAnimation00](self.impl), value)

proc adw_timed_animation_set_value_to(self: ptr TimedAnimation00; value: cdouble) {.
    importc, libprag.}

proc setValueTo*(self: TimedAnimation; value: cdouble) =
  adw_timed_animation_set_value_to(cast[ptr TimedAnimation00](self.impl), value)

proc `valueTo=`*(self: TimedAnimation; value: cdouble) =
  adw_timed_animation_set_value_to(cast[ptr TimedAnimation00](self.impl), value)

type
  ToastOverlay* = ref object of gtk4.Widget
  ToastOverlay00* = object of gtk4.Widget00

proc adw_toast_overlay_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ToastOverlay()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_toast_overlay_new(): ptr ToastOverlay00 {.
    importc, libprag.}

proc newToastOverlay*(): ToastOverlay =
  let gobj = adw_toast_overlay_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newToastOverlay*(tdesc: typedesc): tdesc =
  assert(result is ToastOverlay)
  let gobj = adw_toast_overlay_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initToastOverlay*[T](result: var T) {.deprecated.} =
  assert(result is ToastOverlay)
  let gobj = adw_toast_overlay_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_toast_overlay_add_toast(self: ptr ToastOverlay00; toast: ptr Toast00) {.
    importc, libprag.}

proc addToast*(self: ToastOverlay; toast: Toast) =
  adw_toast_overlay_add_toast(cast[ptr ToastOverlay00](self.impl), cast[ptr Toast00](g_object_ref(toast.impl)))

proc adw_toast_overlay_get_child(self: ptr ToastOverlay00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: ToastOverlay): gtk4.Widget =
  let gobj = adw_toast_overlay_get_child(cast[ptr ToastOverlay00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: ToastOverlay): gtk4.Widget =
  let gobj = adw_toast_overlay_get_child(cast[ptr ToastOverlay00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_toast_overlay_set_child(self: ptr ToastOverlay00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setChild*(self: ToastOverlay; child: gtk4.Widget = nil) =
  adw_toast_overlay_set_child(cast[ptr ToastOverlay00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

proc `child=`*(self: ToastOverlay; child: gtk4.Widget = nil) =
  adw_toast_overlay_set_child(cast[ptr ToastOverlay00](self.impl), if child.isNil: nil else: cast[ptr gtk4.Widget00](child.impl))

type
  ToolbarStyle* {.size: sizeof(cint), pure.} = enum
    flat = 0
    raised = 1
    raisedBorder = 2

type
  ToolbarView* = ref object of gtk4.Widget
  ToolbarView00* = object of gtk4.Widget00

proc adw_toolbar_view_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ToolbarView()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_toolbar_view_new(): ptr ToolbarView00 {.
    importc, libprag.}

proc newToolbarView*(): ToolbarView =
  let gobj = adw_toolbar_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newToolbarView*(tdesc: typedesc): tdesc =
  assert(result is ToolbarView)
  let gobj = adw_toolbar_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initToolbarView*[T](result: var T) {.deprecated.} =
  assert(result is ToolbarView)
  let gobj = adw_toolbar_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_toolbar_view_add_bottom_bar(self: ptr ToolbarView00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc addBottomBar*(self: ToolbarView; widget: gtk4.Widget) =
  adw_toolbar_view_add_bottom_bar(cast[ptr ToolbarView00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_toolbar_view_add_top_bar(self: ptr ToolbarView00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc addTopBar*(self: ToolbarView; widget: gtk4.Widget) =
  adw_toolbar_view_add_top_bar(cast[ptr ToolbarView00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_toolbar_view_get_bottom_bar_height(self: ptr ToolbarView00): int32 {.
    importc, libprag.}

proc getBottomBarHeight*(self: ToolbarView): int =
  int(adw_toolbar_view_get_bottom_bar_height(cast[ptr ToolbarView00](self.impl)))

proc bottomBarHeight*(self: ToolbarView): int =
  int(adw_toolbar_view_get_bottom_bar_height(cast[ptr ToolbarView00](self.impl)))

proc adw_toolbar_view_get_bottom_bar_style(self: ptr ToolbarView00): ToolbarStyle {.
    importc, libprag.}

proc getBottomBarStyle*(self: ToolbarView): ToolbarStyle =
  adw_toolbar_view_get_bottom_bar_style(cast[ptr ToolbarView00](self.impl))

proc bottomBarStyle*(self: ToolbarView): ToolbarStyle =
  adw_toolbar_view_get_bottom_bar_style(cast[ptr ToolbarView00](self.impl))

proc adw_toolbar_view_get_content(self: ptr ToolbarView00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getContent*(self: ToolbarView): gtk4.Widget =
  let gobj = adw_toolbar_view_get_content(cast[ptr ToolbarView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc content*(self: ToolbarView): gtk4.Widget =
  let gobj = adw_toolbar_view_get_content(cast[ptr ToolbarView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_toolbar_view_get_extend_content_to_bottom_edge(self: ptr ToolbarView00): gboolean {.
    importc, libprag.}

proc getExtendContentToBottomEdge*(self: ToolbarView): bool =
  toBool(adw_toolbar_view_get_extend_content_to_bottom_edge(cast[ptr ToolbarView00](self.impl)))

proc extendContentToBottomEdge*(self: ToolbarView): bool =
  toBool(adw_toolbar_view_get_extend_content_to_bottom_edge(cast[ptr ToolbarView00](self.impl)))

proc adw_toolbar_view_get_extend_content_to_top_edge(self: ptr ToolbarView00): gboolean {.
    importc, libprag.}

proc getExtendContentToTopEdge*(self: ToolbarView): bool =
  toBool(adw_toolbar_view_get_extend_content_to_top_edge(cast[ptr ToolbarView00](self.impl)))

proc extendContentToTopEdge*(self: ToolbarView): bool =
  toBool(adw_toolbar_view_get_extend_content_to_top_edge(cast[ptr ToolbarView00](self.impl)))

proc adw_toolbar_view_get_reveal_bottom_bars(self: ptr ToolbarView00): gboolean {.
    importc, libprag.}

proc getRevealBottomBars*(self: ToolbarView): bool =
  toBool(adw_toolbar_view_get_reveal_bottom_bars(cast[ptr ToolbarView00](self.impl)))

proc revealBottomBars*(self: ToolbarView): bool =
  toBool(adw_toolbar_view_get_reveal_bottom_bars(cast[ptr ToolbarView00](self.impl)))

proc adw_toolbar_view_get_reveal_top_bars(self: ptr ToolbarView00): gboolean {.
    importc, libprag.}

proc getRevealTopBars*(self: ToolbarView): bool =
  toBool(adw_toolbar_view_get_reveal_top_bars(cast[ptr ToolbarView00](self.impl)))

proc revealTopBars*(self: ToolbarView): bool =
  toBool(adw_toolbar_view_get_reveal_top_bars(cast[ptr ToolbarView00](self.impl)))

proc adw_toolbar_view_get_top_bar_height(self: ptr ToolbarView00): int32 {.
    importc, libprag.}

proc getTopBarHeight*(self: ToolbarView): int =
  int(adw_toolbar_view_get_top_bar_height(cast[ptr ToolbarView00](self.impl)))

proc topBarHeight*(self: ToolbarView): int =
  int(adw_toolbar_view_get_top_bar_height(cast[ptr ToolbarView00](self.impl)))

proc adw_toolbar_view_get_top_bar_style(self: ptr ToolbarView00): ToolbarStyle {.
    importc, libprag.}

proc getTopBarStyle*(self: ToolbarView): ToolbarStyle =
  adw_toolbar_view_get_top_bar_style(cast[ptr ToolbarView00](self.impl))

proc topBarStyle*(self: ToolbarView): ToolbarStyle =
  adw_toolbar_view_get_top_bar_style(cast[ptr ToolbarView00](self.impl))

proc adw_toolbar_view_remove(self: ptr ToolbarView00; widget: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: ToolbarView; widget: gtk4.Widget) =
  adw_toolbar_view_remove(cast[ptr ToolbarView00](self.impl), cast[ptr gtk4.Widget00](widget.impl))

proc adw_toolbar_view_set_bottom_bar_style(self: ptr ToolbarView00; style: ToolbarStyle) {.
    importc, libprag.}

proc setBottomBarStyle*(self: ToolbarView; style: ToolbarStyle) =
  adw_toolbar_view_set_bottom_bar_style(cast[ptr ToolbarView00](self.impl), style)

proc `bottomBarStyle=`*(self: ToolbarView; style: ToolbarStyle) =
  adw_toolbar_view_set_bottom_bar_style(cast[ptr ToolbarView00](self.impl), style)

proc adw_toolbar_view_set_content(self: ptr ToolbarView00; content: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setContent*(self: ToolbarView; content: gtk4.Widget = nil) =
  adw_toolbar_view_set_content(cast[ptr ToolbarView00](self.impl), if content.isNil: nil else: cast[ptr gtk4.Widget00](content.impl))

proc `content=`*(self: ToolbarView; content: gtk4.Widget = nil) =
  adw_toolbar_view_set_content(cast[ptr ToolbarView00](self.impl), if content.isNil: nil else: cast[ptr gtk4.Widget00](content.impl))

proc adw_toolbar_view_set_extend_content_to_bottom_edge(self: ptr ToolbarView00;
    extend: gboolean) {.
    importc, libprag.}

proc setExtendContentToBottomEdge*(self: ToolbarView;
    extend: bool = true) =
  adw_toolbar_view_set_extend_content_to_bottom_edge(cast[ptr ToolbarView00](self.impl), gboolean(extend))

proc `extendContentToBottomEdge=`*(self: ToolbarView;
    extend: bool) =
  adw_toolbar_view_set_extend_content_to_bottom_edge(cast[ptr ToolbarView00](self.impl), gboolean(extend))

proc adw_toolbar_view_set_extend_content_to_top_edge(self: ptr ToolbarView00;
    extend: gboolean) {.
    importc, libprag.}

proc setExtendContentToTopEdge*(self: ToolbarView; extend: bool = true) =
  adw_toolbar_view_set_extend_content_to_top_edge(cast[ptr ToolbarView00](self.impl), gboolean(extend))

proc `extendContentToTopEdge=`*(self: ToolbarView; extend: bool) =
  adw_toolbar_view_set_extend_content_to_top_edge(cast[ptr ToolbarView00](self.impl), gboolean(extend))

proc adw_toolbar_view_set_reveal_bottom_bars(self: ptr ToolbarView00; reveal: gboolean) {.
    importc, libprag.}

proc setRevealBottomBars*(self: ToolbarView; reveal: bool = true) =
  adw_toolbar_view_set_reveal_bottom_bars(cast[ptr ToolbarView00](self.impl), gboolean(reveal))

proc `revealBottomBars=`*(self: ToolbarView; reveal: bool) =
  adw_toolbar_view_set_reveal_bottom_bars(cast[ptr ToolbarView00](self.impl), gboolean(reveal))

proc adw_toolbar_view_set_reveal_top_bars(self: ptr ToolbarView00; reveal: gboolean) {.
    importc, libprag.}

proc setRevealTopBars*(self: ToolbarView; reveal: bool = true) =
  adw_toolbar_view_set_reveal_top_bars(cast[ptr ToolbarView00](self.impl), gboolean(reveal))

proc `revealTopBars=`*(self: ToolbarView; reveal: bool) =
  adw_toolbar_view_set_reveal_top_bars(cast[ptr ToolbarView00](self.impl), gboolean(reveal))

proc adw_toolbar_view_set_top_bar_style(self: ptr ToolbarView00; style: ToolbarStyle) {.
    importc, libprag.}

proc setTopBarStyle*(self: ToolbarView; style: ToolbarStyle) =
  adw_toolbar_view_set_top_bar_style(cast[ptr ToolbarView00](self.impl), style)

proc `topBarStyle=`*(self: ToolbarView; style: ToolbarStyle) =
  adw_toolbar_view_set_top_bar_style(cast[ptr ToolbarView00](self.impl), style)

const VERSION_S* = "1.5.0"

type
  ViewStack* = ref object of gtk4.Widget
  ViewStack00* = object of gtk4.Widget00

proc adw_view_stack_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ViewStack()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_view_stack_new(): ptr ViewStack00 {.
    importc, libprag.}

proc newViewStack*(): ViewStack =
  let gobj = adw_view_stack_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newViewStack*(tdesc: typedesc): tdesc =
  assert(result is ViewStack)
  let gobj = adw_view_stack_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initViewStack*[T](result: var T) {.deprecated.} =
  assert(result is ViewStack)
  let gobj = adw_view_stack_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_stack_get_child_by_name(self: ptr ViewStack00; name: cstring): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChildByName*(self: ViewStack; name: cstring): gtk4.Widget =
  let gobj = adw_view_stack_get_child_by_name(cast[ptr ViewStack00](self.impl), name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_stack_get_hhomogeneous(self: ptr ViewStack00): gboolean {.
    importc, libprag.}

proc getHhomogeneous*(self: ViewStack): bool =
  toBool(adw_view_stack_get_hhomogeneous(cast[ptr ViewStack00](self.impl)))

proc hhomogeneous*(self: ViewStack): bool =
  toBool(adw_view_stack_get_hhomogeneous(cast[ptr ViewStack00](self.impl)))

proc adw_view_stack_get_pages(self: ptr ViewStack00): ptr gtk4.SelectionModel00 {.
    importc, libprag.}

proc getPages*(self: ViewStack): gtk4.SelectionModel =
  let gobj = adw_view_stack_get_pages(cast[ptr ViewStack00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pages*(self: ViewStack): gtk4.SelectionModel =
  let gobj = adw_view_stack_get_pages(cast[ptr ViewStack00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_stack_get_vhomogeneous(self: ptr ViewStack00): gboolean {.
    importc, libprag.}

proc getVhomogeneous*(self: ViewStack): bool =
  toBool(adw_view_stack_get_vhomogeneous(cast[ptr ViewStack00](self.impl)))

proc vhomogeneous*(self: ViewStack): bool =
  toBool(adw_view_stack_get_vhomogeneous(cast[ptr ViewStack00](self.impl)))

proc adw_view_stack_get_visible_child(self: ptr ViewStack00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getVisibleChild*(self: ViewStack): gtk4.Widget =
  let gobj = adw_view_stack_get_visible_child(cast[ptr ViewStack00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visibleChild*(self: ViewStack): gtk4.Widget =
  let gobj = adw_view_stack_get_visible_child(cast[ptr ViewStack00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_stack_get_visible_child_name(self: ptr ViewStack00): cstring {.
    importc, libprag.}

proc getVisibleChildName*(self: ViewStack): string =
  let resul0 = adw_view_stack_get_visible_child_name(cast[ptr ViewStack00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc visibleChildName*(self: ViewStack): string =
  let resul0 = adw_view_stack_get_visible_child_name(cast[ptr ViewStack00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_view_stack_remove(self: ptr ViewStack00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: ViewStack; child: gtk4.Widget) =
  adw_view_stack_remove(cast[ptr ViewStack00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_view_stack_set_hhomogeneous(self: ptr ViewStack00; hhomogeneous: gboolean) {.
    importc, libprag.}

proc setHhomogeneous*(self: ViewStack; hhomogeneous: bool = true) =
  adw_view_stack_set_hhomogeneous(cast[ptr ViewStack00](self.impl), gboolean(hhomogeneous))

proc `hhomogeneous=`*(self: ViewStack; hhomogeneous: bool) =
  adw_view_stack_set_hhomogeneous(cast[ptr ViewStack00](self.impl), gboolean(hhomogeneous))

proc adw_view_stack_set_vhomogeneous(self: ptr ViewStack00; vhomogeneous: gboolean) {.
    importc, libprag.}

proc setVhomogeneous*(self: ViewStack; vhomogeneous: bool = true) =
  adw_view_stack_set_vhomogeneous(cast[ptr ViewStack00](self.impl), gboolean(vhomogeneous))

proc `vhomogeneous=`*(self: ViewStack; vhomogeneous: bool) =
  adw_view_stack_set_vhomogeneous(cast[ptr ViewStack00](self.impl), gboolean(vhomogeneous))

proc adw_view_stack_set_visible_child(self: ptr ViewStack00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setVisibleChild*(self: ViewStack; child: gtk4.Widget) =
  adw_view_stack_set_visible_child(cast[ptr ViewStack00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc `visibleChild=`*(self: ViewStack; child: gtk4.Widget) =
  adw_view_stack_set_visible_child(cast[ptr ViewStack00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc adw_view_stack_set_visible_child_name(self: ptr ViewStack00; name: cstring) {.
    importc, libprag.}

proc setVisibleChildName*(self: ViewStack; name: cstring) =
  adw_view_stack_set_visible_child_name(cast[ptr ViewStack00](self.impl), name)

proc `visibleChildName=`*(self: ViewStack; name: cstring) =
  adw_view_stack_set_visible_child_name(cast[ptr ViewStack00](self.impl), name)

type
  ViewStackPage* = ref object of gobject.Object
  ViewStackPage00* = object of gobject.Object00

proc adw_view_stack_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ViewStackPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_view_stack_page_get_badge_number(self: ptr ViewStackPage00): uint32 {.
    importc, libprag.}

proc getBadgeNumber*(self: ViewStackPage): int =
  int(adw_view_stack_page_get_badge_number(cast[ptr ViewStackPage00](self.impl)))

proc badgeNumber*(self: ViewStackPage): int =
  int(adw_view_stack_page_get_badge_number(cast[ptr ViewStackPage00](self.impl)))

proc adw_view_stack_page_get_child(self: ptr ViewStackPage00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getChild*(self: ViewStackPage): gtk4.Widget =
  let gobj = adw_view_stack_page_get_child(cast[ptr ViewStackPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc child*(self: ViewStackPage): gtk4.Widget =
  let gobj = adw_view_stack_page_get_child(cast[ptr ViewStackPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_stack_page_get_icon_name(self: ptr ViewStackPage00): cstring {.
    importc, libprag.}

proc getIconName*(self: ViewStackPage): string =
  let resul0 = adw_view_stack_page_get_icon_name(cast[ptr ViewStackPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: ViewStackPage): string =
  let resul0 = adw_view_stack_page_get_icon_name(cast[ptr ViewStackPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_view_stack_page_get_name(self: ptr ViewStackPage00): cstring {.
    importc, libprag.}

proc getName*(self: ViewStackPage): string =
  let resul0 = adw_view_stack_page_get_name(cast[ptr ViewStackPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc name*(self: ViewStackPage): string =
  let resul0 = adw_view_stack_page_get_name(cast[ptr ViewStackPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_view_stack_page_get_needs_attention(self: ptr ViewStackPage00): gboolean {.
    importc, libprag.}

proc getNeedsAttention*(self: ViewStackPage): bool =
  toBool(adw_view_stack_page_get_needs_attention(cast[ptr ViewStackPage00](self.impl)))

proc needsAttention*(self: ViewStackPage): bool =
  toBool(adw_view_stack_page_get_needs_attention(cast[ptr ViewStackPage00](self.impl)))

proc adw_view_stack_page_get_title(self: ptr ViewStackPage00): cstring {.
    importc, libprag.}

proc getTitle*(self: ViewStackPage): string =
  let resul0 = adw_view_stack_page_get_title(cast[ptr ViewStackPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc title*(self: ViewStackPage): string =
  let resul0 = adw_view_stack_page_get_title(cast[ptr ViewStackPage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc adw_view_stack_page_get_use_underline(self: ptr ViewStackPage00): gboolean {.
    importc, libprag.}

proc getUseUnderline*(self: ViewStackPage): bool =
  toBool(adw_view_stack_page_get_use_underline(cast[ptr ViewStackPage00](self.impl)))

proc useUnderline*(self: ViewStackPage): bool =
  toBool(adw_view_stack_page_get_use_underline(cast[ptr ViewStackPage00](self.impl)))

proc adw_view_stack_page_get_visible(self: ptr ViewStackPage00): gboolean {.
    importc, libprag.}

proc getVisible*(self: ViewStackPage): bool =
  toBool(adw_view_stack_page_get_visible(cast[ptr ViewStackPage00](self.impl)))

proc visible*(self: ViewStackPage): bool =
  toBool(adw_view_stack_page_get_visible(cast[ptr ViewStackPage00](self.impl)))

proc adw_view_stack_page_set_badge_number(self: ptr ViewStackPage00; badgeNumber: uint32) {.
    importc, libprag.}

proc setBadgeNumber*(self: ViewStackPage; badgeNumber: int) =
  adw_view_stack_page_set_badge_number(cast[ptr ViewStackPage00](self.impl), uint32(badgeNumber))

proc `badgeNumber=`*(self: ViewStackPage; badgeNumber: int) =
  adw_view_stack_page_set_badge_number(cast[ptr ViewStackPage00](self.impl), uint32(badgeNumber))

proc adw_view_stack_page_set_icon_name(self: ptr ViewStackPage00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: ViewStackPage; iconName: cstring = nil) =
  adw_view_stack_page_set_icon_name(cast[ptr ViewStackPage00](self.impl), iconName)

proc `iconName=`*(self: ViewStackPage; iconName: cstring = nil) =
  adw_view_stack_page_set_icon_name(cast[ptr ViewStackPage00](self.impl), iconName)

proc adw_view_stack_page_set_name(self: ptr ViewStackPage00; name: cstring) {.
    importc, libprag.}

proc setName*(self: ViewStackPage; name: cstring = nil) =
  adw_view_stack_page_set_name(cast[ptr ViewStackPage00](self.impl), name)

proc `name=`*(self: ViewStackPage; name: cstring = nil) =
  adw_view_stack_page_set_name(cast[ptr ViewStackPage00](self.impl), name)

proc adw_view_stack_page_set_needs_attention(self: ptr ViewStackPage00; needsAttention: gboolean) {.
    importc, libprag.}

proc setNeedsAttention*(self: ViewStackPage; needsAttention: bool = true) =
  adw_view_stack_page_set_needs_attention(cast[ptr ViewStackPage00](self.impl), gboolean(needsAttention))

proc `needsAttention=`*(self: ViewStackPage; needsAttention: bool) =
  adw_view_stack_page_set_needs_attention(cast[ptr ViewStackPage00](self.impl), gboolean(needsAttention))

proc adw_view_stack_page_set_title(self: ptr ViewStackPage00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: ViewStackPage; title: cstring = nil) =
  adw_view_stack_page_set_title(cast[ptr ViewStackPage00](self.impl), title)

proc `title=`*(self: ViewStackPage; title: cstring = nil) =
  adw_view_stack_page_set_title(cast[ptr ViewStackPage00](self.impl), title)

proc adw_view_stack_page_set_use_underline(self: ptr ViewStackPage00; useUnderline: gboolean) {.
    importc, libprag.}

proc setUseUnderline*(self: ViewStackPage; useUnderline: bool = true) =
  adw_view_stack_page_set_use_underline(cast[ptr ViewStackPage00](self.impl), gboolean(useUnderline))

proc `useUnderline=`*(self: ViewStackPage; useUnderline: bool) =
  adw_view_stack_page_set_use_underline(cast[ptr ViewStackPage00](self.impl), gboolean(useUnderline))

proc adw_view_stack_page_set_visible(self: ptr ViewStackPage00; visible: gboolean) {.
    importc, libprag.}

proc setVisible*(self: ViewStackPage; visible: bool = true) =
  adw_view_stack_page_set_visible(cast[ptr ViewStackPage00](self.impl), gboolean(visible))

proc `visible=`*(self: ViewStackPage; visible: bool) =
  adw_view_stack_page_set_visible(cast[ptr ViewStackPage00](self.impl), gboolean(visible))

proc adw_view_stack_add(self: ptr ViewStack00; child: ptr gtk4.Widget00): ptr ViewStackPage00 {.
    importc, libprag.}

proc add*(self: ViewStack; child: gtk4.Widget): ViewStackPage =
  let gobj = adw_view_stack_add(cast[ptr ViewStack00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_stack_add_named(self: ptr ViewStack00; child: ptr gtk4.Widget00;
    name: cstring): ptr ViewStackPage00 {.
    importc, libprag.}

proc addNamed*(self: ViewStack; child: gtk4.Widget; name: cstring = nil): ViewStackPage =
  let gobj = adw_view_stack_add_named(cast[ptr ViewStack00](self.impl), cast[ptr gtk4.Widget00](child.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_stack_add_titled(self: ptr ViewStack00; child: ptr gtk4.Widget00;
    name: cstring; title: cstring): ptr ViewStackPage00 {.
    importc, libprag.}

proc addTitled*(self: ViewStack; child: gtk4.Widget; name: cstring = nil;
    title: cstring): ViewStackPage =
  let gobj = adw_view_stack_add_titled(cast[ptr ViewStack00](self.impl), cast[ptr gtk4.Widget00](child.impl), name, title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_stack_add_titled_with_icon(self: ptr ViewStack00; child: ptr gtk4.Widget00;
    name: cstring; title: cstring; iconName: cstring): ptr ViewStackPage00 {.
    importc, libprag.}

proc addTitledWithIcon*(self: ViewStack; child: gtk4.Widget;
    name: cstring = nil; title: cstring; iconName: cstring): ViewStackPage =
  let gobj = adw_view_stack_add_titled_with_icon(cast[ptr ViewStack00](self.impl), cast[ptr gtk4.Widget00](child.impl), name, title, iconName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_stack_get_page(self: ptr ViewStack00; child: ptr gtk4.Widget00): ptr ViewStackPage00 {.
    importc, libprag.}

proc getPage*(self: ViewStack; child: gtk4.Widget): ViewStackPage =
  let gobj = adw_view_stack_get_page(cast[ptr ViewStack00](self.impl), cast[ptr gtk4.Widget00](child.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ViewStackPages* = ref object of gobject.Object
  ViewStackPages00* = object of gobject.Object00

proc adw_view_stack_pages_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ViewStackPages()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_view_stack_pages_get_selected_page(self: ptr ViewStackPages00): ptr ViewStackPage00 {.
    importc, libprag.}

proc getSelectedPage*(self: ViewStackPages): ViewStackPage =
  let gobj = adw_view_stack_pages_get_selected_page(cast[ptr ViewStackPages00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc selectedPage*(self: ViewStackPages): ViewStackPage =
  let gobj = adw_view_stack_pages_get_selected_page(cast[ptr ViewStackPages00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_stack_pages_set_selected_page(self: ptr ViewStackPages00; page: ptr ViewStackPage00) {.
    importc, libprag.}

proc setSelectedPage*(self: ViewStackPages; page: ViewStackPage) =
  adw_view_stack_pages_set_selected_page(cast[ptr ViewStackPages00](self.impl), cast[ptr ViewStackPage00](page.impl))

proc `selectedPage=`*(self: ViewStackPages; page: ViewStackPage) =
  adw_view_stack_pages_set_selected_page(cast[ptr ViewStackPages00](self.impl), cast[ptr ViewStackPage00](page.impl))

type
  ViewSwitcher* = ref object of gtk4.Widget
  ViewSwitcher00* = object of gtk4.Widget00

proc adw_view_switcher_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ViewSwitcher()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_view_switcher_new(): ptr ViewSwitcher00 {.
    importc, libprag.}

proc newViewSwitcher*(): ViewSwitcher =
  let gobj = adw_view_switcher_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newViewSwitcher*(tdesc: typedesc): tdesc =
  assert(result is ViewSwitcher)
  let gobj = adw_view_switcher_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initViewSwitcher*[T](result: var T) {.deprecated.} =
  assert(result is ViewSwitcher)
  let gobj = adw_view_switcher_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_switcher_get_stack(self: ptr ViewSwitcher00): ptr ViewStack00 {.
    importc, libprag.}

proc getStack*(self: ViewSwitcher): ViewStack =
  let gobj = adw_view_switcher_get_stack(cast[ptr ViewSwitcher00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc stack*(self: ViewSwitcher): ViewStack =
  let gobj = adw_view_switcher_get_stack(cast[ptr ViewSwitcher00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_switcher_set_stack(self: ptr ViewSwitcher00; stack: ptr ViewStack00) {.
    importc, libprag.}

proc setStack*(self: ViewSwitcher; stack: ViewStack = nil) =
  adw_view_switcher_set_stack(cast[ptr ViewSwitcher00](self.impl), if stack.isNil: nil else: cast[ptr ViewStack00](stack.impl))

proc `stack=`*(self: ViewSwitcher; stack: ViewStack = nil) =
  adw_view_switcher_set_stack(cast[ptr ViewSwitcher00](self.impl), if stack.isNil: nil else: cast[ptr ViewStack00](stack.impl))

type
  ViewSwitcherPolicy* {.size: sizeof(cint), pure.} = enum
    narrow = 0
    wide = 1

proc adw_view_switcher_get_policy(self: ptr ViewSwitcher00): ViewSwitcherPolicy {.
    importc, libprag.}

proc getPolicy*(self: ViewSwitcher): ViewSwitcherPolicy =
  adw_view_switcher_get_policy(cast[ptr ViewSwitcher00](self.impl))

proc policy*(self: ViewSwitcher): ViewSwitcherPolicy =
  adw_view_switcher_get_policy(cast[ptr ViewSwitcher00](self.impl))

proc adw_view_switcher_set_policy(self: ptr ViewSwitcher00; policy: ViewSwitcherPolicy) {.
    importc, libprag.}

proc setPolicy*(self: ViewSwitcher; policy: ViewSwitcherPolicy) =
  adw_view_switcher_set_policy(cast[ptr ViewSwitcher00](self.impl), policy)

proc `policy=`*(self: ViewSwitcher; policy: ViewSwitcherPolicy) =
  adw_view_switcher_set_policy(cast[ptr ViewSwitcher00](self.impl), policy)

type
  ViewSwitcherBar* = ref object of gtk4.Widget
  ViewSwitcherBar00* = object of gtk4.Widget00

proc adw_view_switcher_bar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ViewSwitcherBar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_view_switcher_bar_new(): ptr ViewSwitcherBar00 {.
    importc, libprag.}

proc newViewSwitcherBar*(): ViewSwitcherBar =
  let gobj = adw_view_switcher_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newViewSwitcherBar*(tdesc: typedesc): tdesc =
  assert(result is ViewSwitcherBar)
  let gobj = adw_view_switcher_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initViewSwitcherBar*[T](result: var T) {.deprecated.} =
  assert(result is ViewSwitcherBar)
  let gobj = adw_view_switcher_bar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_switcher_bar_get_reveal(self: ptr ViewSwitcherBar00): gboolean {.
    importc, libprag.}

proc getReveal*(self: ViewSwitcherBar): bool =
  toBool(adw_view_switcher_bar_get_reveal(cast[ptr ViewSwitcherBar00](self.impl)))

proc reveal*(self: ViewSwitcherBar): bool =
  toBool(adw_view_switcher_bar_get_reveal(cast[ptr ViewSwitcherBar00](self.impl)))

proc adw_view_switcher_bar_get_stack(self: ptr ViewSwitcherBar00): ptr ViewStack00 {.
    importc, libprag.}

proc getStack*(self: ViewSwitcherBar): ViewStack =
  let gobj = adw_view_switcher_bar_get_stack(cast[ptr ViewSwitcherBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc stack*(self: ViewSwitcherBar): ViewStack =
  let gobj = adw_view_switcher_bar_get_stack(cast[ptr ViewSwitcherBar00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_switcher_bar_set_reveal(self: ptr ViewSwitcherBar00; reveal: gboolean) {.
    importc, libprag.}

proc setReveal*(self: ViewSwitcherBar; reveal: bool = true) =
  adw_view_switcher_bar_set_reveal(cast[ptr ViewSwitcherBar00](self.impl), gboolean(reveal))

proc `reveal=`*(self: ViewSwitcherBar; reveal: bool) =
  adw_view_switcher_bar_set_reveal(cast[ptr ViewSwitcherBar00](self.impl), gboolean(reveal))

proc adw_view_switcher_bar_set_stack(self: ptr ViewSwitcherBar00; stack: ptr ViewStack00) {.
    importc, libprag.}

proc setStack*(self: ViewSwitcherBar; stack: ViewStack = nil) =
  adw_view_switcher_bar_set_stack(cast[ptr ViewSwitcherBar00](self.impl), if stack.isNil: nil else: cast[ptr ViewStack00](stack.impl))

proc `stack=`*(self: ViewSwitcherBar; stack: ViewStack = nil) =
  adw_view_switcher_bar_set_stack(cast[ptr ViewSwitcherBar00](self.impl), if stack.isNil: nil else: cast[ptr ViewStack00](stack.impl))

type
  ViewSwitcherTitle* = ref object of gtk4.Widget
  ViewSwitcherTitle00* = object of gtk4.Widget00

proc adw_view_switcher_title_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ViewSwitcherTitle()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_view_switcher_title_new(): ptr ViewSwitcherTitle00 {.
    importc, libprag.}

proc newViewSwitcherTitle*(): ViewSwitcherTitle {.deprecated.}  =
  let gobj = adw_view_switcher_title_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newViewSwitcherTitle*(tdesc: typedesc): tdesc {.deprecated.}  =
  assert(result is ViewSwitcherTitle)
  let gobj = adw_view_switcher_title_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initViewSwitcherTitle*[T](result: var T) {.deprecated.} =
  assert(result is ViewSwitcherTitle)
  let gobj = adw_view_switcher_title_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_switcher_title_get_stack(self: ptr ViewSwitcherTitle00): ptr ViewStack00 {.
    importc, libprag.}

proc getStack*(self: ViewSwitcherTitle): ViewStack =
  let gobj = adw_view_switcher_title_get_stack(cast[ptr ViewSwitcherTitle00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc stack*(self: ViewSwitcherTitle): ViewStack =
  let gobj = adw_view_switcher_title_get_stack(cast[ptr ViewSwitcherTitle00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, adw.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_view_switcher_title_get_subtitle(self: ptr ViewSwitcherTitle00): cstring {.
    importc, libprag.}

proc getSubtitle*(self: ViewSwitcherTitle): string =
  result = $adw_view_switcher_title_get_subtitle(cast[ptr ViewSwitcherTitle00](self.impl))

proc subtitle*(self: ViewSwitcherTitle): string =
  result = $adw_view_switcher_title_get_subtitle(cast[ptr ViewSwitcherTitle00](self.impl))

proc adw_view_switcher_title_get_title(self: ptr ViewSwitcherTitle00): cstring {.
    importc, libprag.}

proc getTitle*(self: ViewSwitcherTitle): string =
  result = $adw_view_switcher_title_get_title(cast[ptr ViewSwitcherTitle00](self.impl))

proc title*(self: ViewSwitcherTitle): string =
  result = $adw_view_switcher_title_get_title(cast[ptr ViewSwitcherTitle00](self.impl))

proc adw_view_switcher_title_get_title_visible(self: ptr ViewSwitcherTitle00): gboolean {.
    importc, libprag.}

proc getTitleVisible*(self: ViewSwitcherTitle): bool =
  toBool(adw_view_switcher_title_get_title_visible(cast[ptr ViewSwitcherTitle00](self.impl)))

proc titleVisible*(self: ViewSwitcherTitle): bool =
  toBool(adw_view_switcher_title_get_title_visible(cast[ptr ViewSwitcherTitle00](self.impl)))

proc adw_view_switcher_title_get_view_switcher_enabled(self: ptr ViewSwitcherTitle00): gboolean {.
    importc, libprag.}

proc getViewSwitcherEnabled*(self: ViewSwitcherTitle): bool =
  toBool(adw_view_switcher_title_get_view_switcher_enabled(cast[ptr ViewSwitcherTitle00](self.impl)))

proc viewSwitcherEnabled*(self: ViewSwitcherTitle): bool =
  toBool(adw_view_switcher_title_get_view_switcher_enabled(cast[ptr ViewSwitcherTitle00](self.impl)))

proc adw_view_switcher_title_set_stack(self: ptr ViewSwitcherTitle00; stack: ptr ViewStack00) {.
    importc, libprag.}

proc setStack*(self: ViewSwitcherTitle; stack: ViewStack = nil) =
  adw_view_switcher_title_set_stack(cast[ptr ViewSwitcherTitle00](self.impl), if stack.isNil: nil else: cast[ptr ViewStack00](stack.impl))

proc `stack=`*(self: ViewSwitcherTitle; stack: ViewStack = nil) =
  adw_view_switcher_title_set_stack(cast[ptr ViewSwitcherTitle00](self.impl), if stack.isNil: nil else: cast[ptr ViewStack00](stack.impl))

proc adw_view_switcher_title_set_subtitle(self: ptr ViewSwitcherTitle00;
    subtitle: cstring) {.
    importc, libprag.}

proc setSubtitle*(self: ViewSwitcherTitle; subtitle: cstring) =
  adw_view_switcher_title_set_subtitle(cast[ptr ViewSwitcherTitle00](self.impl), subtitle)

proc `subtitle=`*(self: ViewSwitcherTitle; subtitle: cstring) =
  adw_view_switcher_title_set_subtitle(cast[ptr ViewSwitcherTitle00](self.impl), subtitle)

proc adw_view_switcher_title_set_title(self: ptr ViewSwitcherTitle00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: ViewSwitcherTitle; title: cstring) =
  adw_view_switcher_title_set_title(cast[ptr ViewSwitcherTitle00](self.impl), title)

proc `title=`*(self: ViewSwitcherTitle; title: cstring) =
  adw_view_switcher_title_set_title(cast[ptr ViewSwitcherTitle00](self.impl), title)

proc adw_view_switcher_title_set_view_switcher_enabled(self: ptr ViewSwitcherTitle00;
    enabled: gboolean) {.
    importc, libprag.}

proc setViewSwitcherEnabled*(self: ViewSwitcherTitle;
    enabled: bool = true) =
  adw_view_switcher_title_set_view_switcher_enabled(cast[ptr ViewSwitcherTitle00](self.impl), gboolean(enabled))

proc `viewSwitcherEnabled=`*(self: ViewSwitcherTitle;
    enabled: bool) =
  adw_view_switcher_title_set_view_switcher_enabled(cast[ptr ViewSwitcherTitle00](self.impl), gboolean(enabled))

type
  WindowTitle* = ref object of gtk4.Widget
  WindowTitle00* = object of gtk4.Widget00

proc adw_window_title_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WindowTitle()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc adw_window_title_new(title: cstring; subtitle: cstring): ptr WindowTitle00 {.
    importc, libprag.}

proc newWindowTitle*(title: cstring; subtitle: cstring): WindowTitle =
  let gobj = adw_window_title_new(title, subtitle)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWindowTitle*(tdesc: typedesc; title: cstring; subtitle: cstring): tdesc =
  assert(result is WindowTitle)
  let gobj = adw_window_title_new(title, subtitle)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWindowTitle*[T](result: var T; title: cstring; subtitle: cstring) {.deprecated.} =
  assert(result is WindowTitle)
  let gobj = adw_window_title_new(title, subtitle)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc adw_window_title_get_subtitle(self: ptr WindowTitle00): cstring {.
    importc, libprag.}

proc getSubtitle*(self: WindowTitle): string =
  result = $adw_window_title_get_subtitle(cast[ptr WindowTitle00](self.impl))

proc subtitle*(self: WindowTitle): string =
  result = $adw_window_title_get_subtitle(cast[ptr WindowTitle00](self.impl))

proc adw_window_title_get_title(self: ptr WindowTitle00): cstring {.
    importc, libprag.}

proc getTitle*(self: WindowTitle): string =
  result = $adw_window_title_get_title(cast[ptr WindowTitle00](self.impl))

proc title*(self: WindowTitle): string =
  result = $adw_window_title_get_title(cast[ptr WindowTitle00](self.impl))

proc adw_window_title_set_subtitle(self: ptr WindowTitle00; subtitle: cstring) {.
    importc, libprag.}

proc setSubtitle*(self: WindowTitle; subtitle: cstring) =
  adw_window_title_set_subtitle(cast[ptr WindowTitle00](self.impl), subtitle)

proc `subtitle=`*(self: WindowTitle; subtitle: cstring) =
  adw_window_title_set_subtitle(cast[ptr WindowTitle00](self.impl), subtitle)

proc adw_window_title_set_title(self: ptr WindowTitle00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: WindowTitle; title: cstring) =
  adw_window_title_set_title(cast[ptr WindowTitle00](self.impl), title)

proc `title=`*(self: WindowTitle; title: cstring) =
  adw_window_title_set_title(cast[ptr WindowTitle00](self.impl), title)

proc adw_get_enable_animations(widget: ptr gtk4.Widget00): gboolean {.
    importc, libprag.}

proc getEnableAnimations*(widget: gtk4.Widget): bool =
  toBool(adw_get_enable_animations(cast[ptr gtk4.Widget00](widget.impl)))

proc enableAnimations*(widget: gtk4.Widget): bool =
  toBool(adw_get_enable_animations(cast[ptr gtk4.Widget00](widget.impl)))

proc adw_get_major_version(): uint32 {.
    importc, libprag.}

proc getMajorVersion*(): int =
  int(adw_get_major_version())

proc adw_get_micro_version(): uint32 {.
    importc, libprag.}

proc getMicroVersion*(): int =
  int(adw_get_micro_version())

proc adw_get_minor_version(): uint32 {.
    importc, libprag.}

proc getMinorVersion*(): int =
  int(adw_get_minor_version())

proc init*() {.
    importc: "adw_init", libprag.}

proc adw_is_initialized(): gboolean {.
    importc, libprag.}

proc isInitialized*(): bool =
  toBool(adw_is_initialized())

proc lerp*(a: cdouble; b: cdouble; t: cdouble): cdouble {.
    importc: "adw_lerp", libprag.}
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc accessible*(x: adw.AboutDialog): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.AboutDialog): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.AboutDialog): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.AboutWindow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.AboutWindow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.AboutWindow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc native*(x: adw.AboutWindow): gtk4.Native = cast[gtk4.Native](x)

proc root*(x: adw.AboutWindow): gtk4.Root = cast[gtk4.Root](x)

proc shortcutManager*(x: adw.AboutWindow): gtk4.ShortcutManager = cast[gtk4.ShortcutManager](x)

proc accessible*(x: adw.ActionRow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.ActionRow): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.ActionRow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ActionRow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.AlertDialog): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.AlertDialog): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.AlertDialog): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc actionGroup*(x: adw.Application): gio.ActionGroup = cast[gio.ActionGroup](x)

proc actionMap*(x: adw.Application): gio.ActionMap = cast[gio.ActionMap](x)

proc actionGroup*(x: adw.ApplicationWindow): gio.ActionGroup = cast[gio.ActionGroup](x)

proc actionMap*(x: adw.ApplicationWindow): gio.ActionMap = cast[gio.ActionMap](x)

proc accessible*(x: adw.ApplicationWindow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.ApplicationWindow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ApplicationWindow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc native*(x: adw.ApplicationWindow): gtk4.Native = cast[gtk4.Native](x)

proc root*(x: adw.ApplicationWindow): gtk4.Root = cast[gtk4.Root](x)

proc shortcutManager*(x: adw.ApplicationWindow): gtk4.ShortcutManager = cast[gtk4.ShortcutManager](x)

proc accessible*(x: adw.Avatar): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.Avatar): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.Avatar): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.Banner): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.Banner): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.Banner): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.Banner): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.Bin): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.Bin): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.Bin): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc buildable*(x: adw.Breakpoint): gtk4.Buildable = cast[gtk4.Buildable](x)

proc accessible*(x: adw.BreakpointBin): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.BreakpointBin): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.BreakpointBin): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.ButtonContent): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.ButtonContent): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ButtonContent): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.Carousel): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.Carousel): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.Carousel): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc orientable*(x: adw.Carousel): gtk4.Orientable = cast[gtk4.Orientable](x)

proc accessible*(x: adw.CarouselIndicatorDots): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.CarouselIndicatorDots): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.CarouselIndicatorDots): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc orientable*(x: adw.CarouselIndicatorDots): gtk4.Orientable = cast[gtk4.Orientable](x)

proc accessible*(x: adw.CarouselIndicatorLines): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.CarouselIndicatorLines): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.CarouselIndicatorLines): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc orientable*(x: adw.CarouselIndicatorLines): gtk4.Orientable = cast[gtk4.Orientable](x)

proc accessible*(x: adw.Clamp): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.Clamp): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.Clamp): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc orientable*(x: adw.Clamp): gtk4.Orientable = cast[gtk4.Orientable](x)

proc orientable*(x: adw.ClampLayout): gtk4.Orientable = cast[gtk4.Orientable](x)

proc accessible*(x: adw.ClampScrollable): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.ClampScrollable): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ClampScrollable): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc orientable*(x: adw.ClampScrollable): gtk4.Orientable = cast[gtk4.Orientable](x)

proc scrollable*(x: adw.ClampScrollable): gtk4.Scrollable = cast[gtk4.Scrollable](x)

proc accessible*(x: adw.ComboRow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.ComboRow): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.ComboRow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ComboRow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.Dialog): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.Dialog): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.Dialog): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.EntryRow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.EntryRow): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.EntryRow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.EntryRow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc editable*(x: adw.EntryRow): gtk4.Editable = cast[gtk4.Editable](x)

proc listModel*(x: adw.EnumListModel): gio.ListModel = cast[gio.ListModel](x)

proc accessible*(x: adw.ExpanderRow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.ExpanderRow): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.ExpanderRow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ExpanderRow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.Flap): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.Flap): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.Flap): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc orientable*(x: adw.Flap): gtk4.Orientable = cast[gtk4.Orientable](x)

proc accessible*(x: adw.HeaderBar): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.HeaderBar): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.HeaderBar): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.Leaflet): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.Leaflet): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.Leaflet): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc orientable*(x: adw.Leaflet): gtk4.Orientable = cast[gtk4.Orientable](x)

proc accessible*(x: adw.MessageDialog): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.MessageDialog): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.MessageDialog): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc native*(x: adw.MessageDialog): gtk4.Native = cast[gtk4.Native](x)

proc root*(x: adw.MessageDialog): gtk4.Root = cast[gtk4.Root](x)

proc shortcutManager*(x: adw.MessageDialog): gtk4.ShortcutManager = cast[gtk4.ShortcutManager](x)

proc accessible*(x: adw.NavigationPage): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.NavigationPage): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.NavigationPage): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.NavigationSplitView): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.NavigationSplitView): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.NavigationSplitView): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.NavigationView): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.NavigationView): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.NavigationView): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.OverlaySplitView): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.OverlaySplitView): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.OverlaySplitView): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.PasswordEntryRow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.PasswordEntryRow): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.PasswordEntryRow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.PasswordEntryRow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc editable*(x: adw.PasswordEntryRow): gtk4.Editable = cast[gtk4.Editable](x)

proc accessible*(x: adw.PreferencesDialog): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.PreferencesDialog): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.PreferencesDialog): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.PreferencesGroup): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.PreferencesGroup): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.PreferencesGroup): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.PreferencesPage): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.PreferencesPage): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.PreferencesPage): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.PreferencesRow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.PreferencesRow): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.PreferencesRow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.PreferencesRow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.PreferencesWindow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.PreferencesWindow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.PreferencesWindow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc native*(x: adw.PreferencesWindow): gtk4.Native = cast[gtk4.Native](x)

proc root*(x: adw.PreferencesWindow): gtk4.Root = cast[gtk4.Root](x)

proc shortcutManager*(x: adw.PreferencesWindow): gtk4.ShortcutManager = cast[gtk4.ShortcutManager](x)

proc accessible*(x: adw.SpinRow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.SpinRow): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.SpinRow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.SpinRow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc editable*(x: adw.SpinRow): gtk4.Editable = cast[gtk4.Editable](x)

proc accessible*(x: adw.SplitButton): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.SplitButton): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.SplitButton): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.SplitButton): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.Squeezer): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.Squeezer): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.Squeezer): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc orientable*(x: adw.Squeezer): gtk4.Orientable = cast[gtk4.Orientable](x)

proc accessible*(x: adw.StatusPage): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.StatusPage): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.StatusPage): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc orientable*(x: adw.SwipeTracker): gtk4.Orientable = cast[gtk4.Orientable](x)

proc accessible*(x: adw.SwitchRow): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.SwitchRow): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.SwitchRow): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.SwitchRow): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.TabBar): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.TabBar): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.TabBar): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.TabButton): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: adw.TabButton): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: adw.TabButton): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.TabButton): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.TabOverview): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.TabOverview): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.TabOverview): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.TabPage): gtk4.Accessible = cast[gtk4.Accessible](x)

proc accessible*(x: adw.TabView): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.TabView): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.TabView): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.ToastOverlay): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.ToastOverlay): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ToastOverlay): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.ToolbarView): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.ToolbarView): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ToolbarView): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.ViewStack): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.ViewStack): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ViewStack): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.ViewStackPage): gtk4.Accessible = cast[gtk4.Accessible](x)

proc listModel*(x: adw.ViewStackPages): gio.ListModel = cast[gio.ListModel](x)

proc selectionModel*(x: adw.ViewStackPages): gtk4.SelectionModel = cast[gtk4.SelectionModel](x)

proc accessible*(x: adw.ViewSwitcher): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.ViewSwitcher): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ViewSwitcher): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.ViewSwitcherBar): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.ViewSwitcherBar): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ViewSwitcherBar): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.ViewSwitcherTitle): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.ViewSwitcherTitle): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.ViewSwitcherTitle): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: adw.Window): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.Window): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.Window): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc native*(x: adw.Window): gtk4.Native = cast[gtk4.Native](x)

proc root*(x: adw.Window): gtk4.Root = cast[gtk4.Root](x)

proc shortcutManager*(x: adw.Window): gtk4.ShortcutManager = cast[gtk4.ShortcutManager](x)

proc accessible*(x: adw.WindowTitle): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: adw.WindowTitle): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: adw.WindowTitle): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

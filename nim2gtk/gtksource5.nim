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
# libraries:
# libgtksourceview-5.so.0
{.warning[UnusedImport]: off.}
import pangocairo, gtk4, freetype2, glib, gdkpixbuf, harfbuzz, gmodule, cairo, graphene, gsk, gobject, gdk4, gio, pango
const Lib = "libgtksourceview-5.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
import glib

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  BackgroundPatternType* {.size: sizeof(cint), pure.} = enum
    none = 0
    grid = 1

type
  BracketMatchType* {.size: sizeof(cint), pure.} = enum
    none = 0
    outOfRange = 1
    notFound = 2
    found = 3

type
  Buffer* = ref object of gtk4.TextBuffer
  Buffer00* = object of gtk4.TextBuffer00

proc gtk_source_buffer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Buffer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scBracketMatched*(self: Buffer;  p: proc (self: ptr Buffer00; iter: gtk4.TextIter; state: BracketMatchType; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "bracket-matched", cast[GCallback](p), xdata, nil, cf)

proc scCursorMoved*(self: Buffer;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "cursor-moved", cast[GCallback](p), xdata, nil, cf)

proc scHighlightUpdated*(self: Buffer;  p: proc (self: ptr Buffer00; start: gtk4.TextIter; `end`: gtk4.TextIter; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "highlight-updated", cast[GCallback](p), xdata, nil, cf)

proc scSourceMarkUpdated*(self: Buffer;  p: proc (self: ptr Buffer00; mark: ptr gtk4.TextMark00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "source-mark-updated", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_buffer_new(table: ptr gtk4.TextTagTable00): ptr Buffer00 {.
    importc, libprag.}

proc newBuffer*(table: gtk4.TextTagTable = nil): Buffer =
  let gobj = gtk_source_buffer_new(if table.isNil: nil else: cast[ptr gtk4.TextTagTable00](table.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newBuffer*(tdesc: typedesc; table: gtk4.TextTagTable = nil): tdesc =
  assert(result is Buffer)
  let gobj = gtk_source_buffer_new(if table.isNil: nil else: cast[ptr gtk4.TextTagTable00](table.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBuffer*[T](result: var T; table: gtk4.TextTagTable = nil) {.deprecated.} =
  assert(result is Buffer)
  let gobj = gtk_source_buffer_new(if table.isNil: nil else: cast[ptr gtk4.TextTagTable00](table.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_backward_iter_to_source_mark(self: ptr Buffer00; iter: var gtk4.TextIter;
    category: cstring): gboolean {.
    importc, libprag.}

proc backwardIterToSourceMark*(self: Buffer; iter: var gtk4.TextIter;
    category: cstring = nil): bool =
  toBool(gtk_source_buffer_backward_iter_to_source_mark(cast[ptr Buffer00](self.impl), iter, category))

proc gtk_source_buffer_ensure_highlight(self: ptr Buffer00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc ensureHighlight*(self: Buffer; start: gtk4.TextIter;
    `end`: gtk4.TextIter) =
  gtk_source_buffer_ensure_highlight(cast[ptr Buffer00](self.impl), start, `end`)

proc gtk_source_buffer_forward_iter_to_source_mark(self: ptr Buffer00; iter: var gtk4.TextIter;
    category: cstring): gboolean {.
    importc, libprag.}

proc forwardIterToSourceMark*(self: Buffer; iter: var gtk4.TextIter;
    category: cstring = nil): bool =
  toBool(gtk_source_buffer_forward_iter_to_source_mark(cast[ptr Buffer00](self.impl), iter, category))

proc gtk_source_buffer_get_context_classes_at_iter(self: ptr Buffer00; iter: gtk4.TextIter): ptr cstring {.
    importc, libprag.}

proc getContextClassesAtIter*(self: Buffer; iter: gtk4.TextIter): seq[string] =
  let resul0 = gtk_source_buffer_get_context_classes_at_iter(cast[ptr Buffer00](self.impl), iter)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gtk_source_buffer_get_highlight_matching_brackets(self: ptr Buffer00): gboolean {.
    importc, libprag.}

proc getHighlightMatchingBrackets*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_highlight_matching_brackets(cast[ptr Buffer00](self.impl)))

proc highlightMatchingBrackets*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_highlight_matching_brackets(cast[ptr Buffer00](self.impl)))

proc gtk_source_buffer_get_highlight_syntax(self: ptr Buffer00): gboolean {.
    importc, libprag.}

proc getHighlightSyntax*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_highlight_syntax(cast[ptr Buffer00](self.impl)))

proc highlightSyntax*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_highlight_syntax(cast[ptr Buffer00](self.impl)))

proc gtk_source_buffer_get_implicit_trailing_newline(self: ptr Buffer00): gboolean {.
    importc, libprag.}

proc getImplicitTrailingNewline*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_implicit_trailing_newline(cast[ptr Buffer00](self.impl)))

proc implicitTrailingNewline*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_implicit_trailing_newline(cast[ptr Buffer00](self.impl)))

proc gtk_source_buffer_get_loading(self: ptr Buffer00): gboolean {.
    importc, libprag.}

proc getLoading*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_loading(cast[ptr Buffer00](self.impl)))

proc loading*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_loading(cast[ptr Buffer00](self.impl)))

proc gtk_source_buffer_iter_backward_to_context_class_toggle(self: ptr Buffer00;
    iter: var gtk4.TextIter; contextClass: cstring): gboolean {.
    importc, libprag.}

proc iterBackwardToContextClassToggle*(self: Buffer;
    iter: var gtk4.TextIter; contextClass: cstring): bool =
  toBool(gtk_source_buffer_iter_backward_to_context_class_toggle(cast[ptr Buffer00](self.impl), iter, contextClass))

proc gtk_source_buffer_iter_forward_to_context_class_toggle(self: ptr Buffer00;
    iter: var gtk4.TextIter; contextClass: cstring): gboolean {.
    importc, libprag.}

proc iterForwardToContextClassToggle*(self: Buffer;
    iter: var gtk4.TextIter; contextClass: cstring): bool =
  toBool(gtk_source_buffer_iter_forward_to_context_class_toggle(cast[ptr Buffer00](self.impl), iter, contextClass))

proc gtk_source_buffer_iter_has_context_class(self: ptr Buffer00; iter: gtk4.TextIter;
    contextClass: cstring): gboolean {.
    importc, libprag.}

proc iterHasContextClass*(self: Buffer; iter: gtk4.TextIter;
    contextClass: cstring): bool =
  toBool(gtk_source_buffer_iter_has_context_class(cast[ptr Buffer00](self.impl), iter, contextClass))

proc gtk_source_buffer_join_lines(self: ptr Buffer00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc joinLines*(self: Buffer; start: gtk4.TextIter; `end`: gtk4.TextIter) =
  gtk_source_buffer_join_lines(cast[ptr Buffer00](self.impl), start, `end`)

proc gtk_source_buffer_remove_source_marks(self: ptr Buffer00; start: gtk4.TextIter;
    `end`: gtk4.TextIter; category: cstring) {.
    importc, libprag.}

proc removeSourceMarks*(self: Buffer; start: gtk4.TextIter;
    `end`: gtk4.TextIter; category: cstring = nil) =
  gtk_source_buffer_remove_source_marks(cast[ptr Buffer00](self.impl), start, `end`, category)

proc gtk_source_buffer_set_highlight_matching_brackets(self: ptr Buffer00;
    highlight: gboolean) {.
    importc, libprag.}

proc setHighlightMatchingBrackets*(self: Buffer; highlight: bool = true) =
  gtk_source_buffer_set_highlight_matching_brackets(cast[ptr Buffer00](self.impl), gboolean(highlight))

proc `highlightMatchingBrackets=`*(self: Buffer; highlight: bool) =
  gtk_source_buffer_set_highlight_matching_brackets(cast[ptr Buffer00](self.impl), gboolean(highlight))

proc gtk_source_buffer_set_highlight_syntax(self: ptr Buffer00; highlight: gboolean) {.
    importc, libprag.}

proc setHighlightSyntax*(self: Buffer; highlight: bool = true) =
  gtk_source_buffer_set_highlight_syntax(cast[ptr Buffer00](self.impl), gboolean(highlight))

proc `highlightSyntax=`*(self: Buffer; highlight: bool) =
  gtk_source_buffer_set_highlight_syntax(cast[ptr Buffer00](self.impl), gboolean(highlight))

proc gtk_source_buffer_set_implicit_trailing_newline(self: ptr Buffer00;
    implicitTrailingNewline: gboolean) {.
    importc, libprag.}

proc setImplicitTrailingNewline*(self: Buffer; implicitTrailingNewline: bool = true) =
  gtk_source_buffer_set_implicit_trailing_newline(cast[ptr Buffer00](self.impl), gboolean(implicitTrailingNewline))

proc `implicitTrailingNewline=`*(self: Buffer; implicitTrailingNewline: bool) =
  gtk_source_buffer_set_implicit_trailing_newline(cast[ptr Buffer00](self.impl), gboolean(implicitTrailingNewline))

type
  ChangeCaseType* {.size: sizeof(cint), pure.} = enum
    lower = 0
    upper = 1
    toggle = 2
    title = 3

proc gtk_source_buffer_change_case(self: ptr Buffer00; caseType: ChangeCaseType;
    start: gtk4.TextIter; `end`: gtk4.TextIter) {.
    importc, libprag.}

proc changeCase*(self: Buffer; caseType: ChangeCaseType;
    start: gtk4.TextIter; `end`: gtk4.TextIter) =
  gtk_source_buffer_change_case(cast[ptr Buffer00](self.impl), caseType, start, `end`)

type
  Mark* = ref object of gtk4.TextMark
  Mark00* = object of gtk4.TextMark00

proc gtk_source_mark_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Mark()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_mark_new(name: cstring; category: cstring): ptr Mark00 {.
    importc, libprag.}

proc newMark*(name: cstring = nil; category: cstring): Mark =
  let gobj = gtk_source_mark_new(name, category)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newMark*(tdesc: typedesc; name: cstring = nil; category: cstring): tdesc =
  assert(result is Mark)
  let gobj = gtk_source_mark_new(name, category)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMark*[T](result: var T; name: cstring = nil; category: cstring) {.deprecated.} =
  assert(result is Mark)
  let gobj = gtk_source_mark_new(name, category)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_mark_get_category(self: ptr Mark00): cstring {.
    importc, libprag.}

proc getCategory*(self: Mark): string =
  result = $gtk_source_mark_get_category(cast[ptr Mark00](self.impl))

proc category*(self: Mark): string =
  result = $gtk_source_mark_get_category(cast[ptr Mark00](self.impl))

proc gtk_source_mark_next(self: ptr Mark00; category: cstring): ptr Mark00 {.
    importc, libprag.}

proc next*(self: Mark; category: cstring = nil): Mark =
  let gobj = gtk_source_mark_next(cast[ptr Mark00](self.impl), category)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_mark_prev(self: ptr Mark00; category: cstring): ptr Mark00 {.
    importc, libprag.}

proc prev*(self: Mark; category: cstring = nil): Mark =
  let gobj = gtk_source_mark_prev(cast[ptr Mark00](self.impl), category)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_create_source_mark(self: ptr Buffer00; name: cstring;
    category: cstring; where: gtk4.TextIter): ptr Mark00 {.
    importc, libprag.}

proc createSourceMark*(self: Buffer; name: cstring = nil;
    category: cstring; where: gtk4.TextIter): Mark =
  let gobj = gtk_source_buffer_create_source_mark(cast[ptr Buffer00](self.impl), name, category, where)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_get_source_marks_at_iter(self: ptr Buffer00; iter: gtk4.TextIter;
    category: cstring): ptr glib.SList {.
    importc, libprag.}

proc getSourceMarksAtIter*(self: Buffer; iter: gtk4.TextIter;
    category: cstring = nil): seq[Mark] =
  let resul0 = gtk_source_buffer_get_source_marks_at_iter(cast[ptr Buffer00](self.impl), iter, category)
  result = gslistObjects2seq(Mark, resul0, false)
  g_slist_free(resul0)

proc gtk_source_buffer_get_source_marks_at_line(self: ptr Buffer00; line: int32;
    category: cstring): ptr glib.SList {.
    importc, libprag.}

proc getSourceMarksAtLine*(self: Buffer; line: int;
    category: cstring = nil): seq[Mark] =
  let resul0 = gtk_source_buffer_get_source_marks_at_line(cast[ptr Buffer00](self.impl), int32(line), category)
  result = gslistObjects2seq(Mark, resul0, false)
  g_slist_free(resul0)

type
  Language* = ref object of gobject.Object
  Language00* = object of gobject.Object00

proc gtk_source_language_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Language()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_language_get_globs(self: ptr Language00): ptr cstring {.
    importc, libprag.}

proc getGlobs*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_globs(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc globs*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_globs(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gtk_source_language_get_hidden(self: ptr Language00): gboolean {.
    importc, libprag.}

proc getHidden*(self: Language): bool =
  toBool(gtk_source_language_get_hidden(cast[ptr Language00](self.impl)))

proc hidden*(self: Language): bool =
  toBool(gtk_source_language_get_hidden(cast[ptr Language00](self.impl)))

proc gtk_source_language_get_id(self: ptr Language00): cstring {.
    importc, libprag.}

proc getId*(self: Language): string =
  result = $gtk_source_language_get_id(cast[ptr Language00](self.impl))

proc id*(self: Language): string =
  result = $gtk_source_language_get_id(cast[ptr Language00](self.impl))

proc gtk_source_language_get_metadata(self: ptr Language00; name: cstring): cstring {.
    importc, libprag.}

proc getMetadata*(self: Language; name: cstring): string =
  let resul0 = gtk_source_language_get_metadata(cast[ptr Language00](self.impl), name)
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_language_get_mime_types(self: ptr Language00): ptr cstring {.
    importc, libprag.}

proc getMimeTypes*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_mime_types(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc mimeTypes*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_mime_types(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gtk_source_language_get_name(self: ptr Language00): cstring {.
    importc, libprag.}

proc getName*(self: Language): string =
  result = $gtk_source_language_get_name(cast[ptr Language00](self.impl))

proc name*(self: Language): string =
  result = $gtk_source_language_get_name(cast[ptr Language00](self.impl))

proc gtk_source_language_get_section(self: ptr Language00): cstring {.
    importc, libprag.}

proc getSection*(self: Language): string =
  result = $gtk_source_language_get_section(cast[ptr Language00](self.impl))

proc section*(self: Language): string =
  result = $gtk_source_language_get_section(cast[ptr Language00](self.impl))

proc gtk_source_language_get_style_fallback(self: ptr Language00; styleId: cstring): cstring {.
    importc, libprag.}

proc getStyleFallback*(self: Language; styleId: cstring): string =
  let resul0 = gtk_source_language_get_style_fallback(cast[ptr Language00](self.impl), styleId)
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_language_get_style_ids(self: ptr Language00): ptr cstring {.
    importc, libprag.}

proc getStyleIds*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_style_ids(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc styleIds*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_style_ids(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gtk_source_language_get_style_name(self: ptr Language00; styleId: cstring): cstring {.
    importc, libprag.}

proc getStyleName*(self: Language; styleId: cstring): string =
  let resul0 = gtk_source_language_get_style_name(cast[ptr Language00](self.impl), styleId)
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_buffer_new_with_language(language: ptr Language00): ptr Buffer00 {.
    importc, libprag.}

proc newBufferWithLanguage*(language: Language): Buffer =
  let gobj = gtk_source_buffer_new_with_language(cast[ptr Language00](language.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newBufferWithLanguage*(tdesc: typedesc; language: Language): tdesc =
  assert(result is Buffer)
  let gobj = gtk_source_buffer_new_with_language(cast[ptr Language00](language.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBufferWithLanguage*[T](result: var T; language: Language) {.deprecated.} =
  assert(result is Buffer)
  let gobj = gtk_source_buffer_new_with_language(cast[ptr Language00](language.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_get_language(self: ptr Buffer00): ptr Language00 {.
    importc, libprag.}

proc getLanguage*(self: Buffer): Language =
  let gobj = gtk_source_buffer_get_language(cast[ptr Buffer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc language*(self: Buffer): Language =
  let gobj = gtk_source_buffer_get_language(cast[ptr Buffer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_set_language(self: ptr Buffer00; language: ptr Language00) {.
    importc, libprag.}

proc setLanguage*(self: Buffer; language: Language = nil) =
  gtk_source_buffer_set_language(cast[ptr Buffer00](self.impl), if language.isNil: nil else: cast[ptr Language00](language.impl))

proc `language=`*(self: Buffer; language: Language = nil) =
  gtk_source_buffer_set_language(cast[ptr Buffer00](self.impl), if language.isNil: nil else: cast[ptr Language00](language.impl))

type
  StyleScheme* = ref object of gobject.Object
  StyleScheme00* = object of gobject.Object00

proc gtk_source_style_scheme_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleScheme()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_style_scheme_get_authors(self: ptr StyleScheme00): ptr cstring {.
    importc, libprag.}

proc getAuthors*(self: StyleScheme): seq[string] =
  let resul0 = gtk_source_style_scheme_get_authors(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc authors*(self: StyleScheme): seq[string] =
  let resul0 = gtk_source_style_scheme_get_authors(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc gtk_source_style_scheme_get_description(self: ptr StyleScheme00): cstring {.
    importc, libprag.}

proc getDescription*(self: StyleScheme): string =
  let resul0 = gtk_source_style_scheme_get_description(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc description*(self: StyleScheme): string =
  let resul0 = gtk_source_style_scheme_get_description(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_style_scheme_get_filename(self: ptr StyleScheme00): cstring {.
    importc, libprag.}

proc getFilename*(self: StyleScheme): string =
  let resul0 = gtk_source_style_scheme_get_filename(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc filename*(self: StyleScheme): string =
  let resul0 = gtk_source_style_scheme_get_filename(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_style_scheme_get_id(self: ptr StyleScheme00): cstring {.
    importc, libprag.}

proc getId*(self: StyleScheme): string =
  result = $gtk_source_style_scheme_get_id(cast[ptr StyleScheme00](self.impl))

proc id*(self: StyleScheme): string =
  result = $gtk_source_style_scheme_get_id(cast[ptr StyleScheme00](self.impl))

proc gtk_source_style_scheme_get_metadata(self: ptr StyleScheme00; name: cstring): cstring {.
    importc, libprag.}

proc getMetadata*(self: StyleScheme; name: cstring): string =
  let resul0 = gtk_source_style_scheme_get_metadata(cast[ptr StyleScheme00](self.impl), name)
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_style_scheme_get_name(self: ptr StyleScheme00): cstring {.
    importc, libprag.}

proc getName*(self: StyleScheme): string =
  result = $gtk_source_style_scheme_get_name(cast[ptr StyleScheme00](self.impl))

proc name*(self: StyleScheme): string =
  result = $gtk_source_style_scheme_get_name(cast[ptr StyleScheme00](self.impl))

proc gtk_source_buffer_get_style_scheme(self: ptr Buffer00): ptr StyleScheme00 {.
    importc, libprag.}

proc getStyleScheme*(self: Buffer): StyleScheme =
  let gobj = gtk_source_buffer_get_style_scheme(cast[ptr Buffer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc styleScheme*(self: Buffer): StyleScheme =
  let gobj = gtk_source_buffer_get_style_scheme(cast[ptr Buffer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_set_style_scheme(self: ptr Buffer00; scheme: ptr StyleScheme00) {.
    importc, libprag.}

proc setStyleScheme*(self: Buffer; scheme: StyleScheme = nil) =
  gtk_source_buffer_set_style_scheme(cast[ptr Buffer00](self.impl), if scheme.isNil: nil else: cast[ptr StyleScheme00](scheme.impl))

proc `styleScheme=`*(self: Buffer; scheme: StyleScheme = nil) =
  gtk_source_buffer_set_style_scheme(cast[ptr Buffer00](self.impl), if scheme.isNil: nil else: cast[ptr StyleScheme00](scheme.impl))

type
  Style* = ref object of gobject.Object
  Style00* = object of gobject.Object00

proc gtk_source_style_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Style()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_style_apply(self: ptr Style00; tag: ptr gtk4.TextTag00) {.
    importc, libprag.}

proc apply*(self: Style; tag: gtk4.TextTag) =
  gtk_source_style_apply(cast[ptr Style00](self.impl), cast[ptr gtk4.TextTag00](tag.impl))

proc gtk_source_style_copy(self: ptr Style00): ptr Style00 {.
    importc, libprag.}

proc copy*(self: Style): Style =
  let gobj = gtk_source_style_copy(cast[ptr Style00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_get_style(self: ptr StyleScheme00; styleId: cstring): ptr Style00 {.
    importc, libprag.}

proc getStyle*(self: StyleScheme; styleId: cstring): Style =
  let gobj = gtk_source_style_scheme_get_style(cast[ptr StyleScheme00](self.impl), styleId)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SortFlag* {.size: sizeof(cint), pure.} = enum
    caseSensitive = 0
    reverseOrder = 1
    removeDuplicates = 2

  SortFlags* = set[SortFlag]

const
  SortFlagsNone* = SortFlags({})
proc none*(t: typedesc[SortFlags]): SortFlags = SortFlags({})

proc gtk_source_buffer_sort_lines(self: ptr Buffer00; start: gtk4.TextIter;
    `end`: gtk4.TextIter; flags: SortFlags; column: int32) {.
    importc, libprag.}

proc sortLines*(self: Buffer; start: gtk4.TextIter; `end`: gtk4.TextIter;
    flags: SortFlags; column: int) =
  gtk_source_buffer_sort_lines(cast[ptr Buffer00](self.impl), start, `end`, flags, int32(column))

type
  CompletionProvider00* = object of gobject.Object00
  CompletionProvider* = ref object of gobject.Object

type
  Completion* = ref object of gobject.Object
  Completion00* = object of gobject.Object00

proc gtk_source_completion_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Completion()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scHide*(self: Completion;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "hide", cast[GCallback](p), xdata, nil, cf)

proc scProviderAdded*(self: Completion;  p: proc (self: ptr Completion00; provider: ptr CompletionProvider00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "provider-added", cast[GCallback](p), xdata, nil, cf)

proc scProviderRemoved*(self: Completion;  p: proc (self: ptr Completion00; provider: ptr CompletionProvider00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "provider-removed", cast[GCallback](p), xdata, nil, cf)

proc scShow*(self: Completion;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "show", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_completion_fuzzy_highlight(haystack: cstring; casefoldQuery: cstring): ptr pango.AttrList00 {.
    importc, libprag.}

proc fuzzyHighlight*(haystack: cstring; casefoldQuery: cstring): pango.AttrList =
  let impl0 = gtk_source_completion_fuzzy_highlight(haystack, casefoldQuery)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = impl0

proc gtk_source_completion_fuzzy_match(haystack: cstring; casefoldNeedle: cstring;
    priority: var uint32): gboolean {.
    importc, libprag.}

proc fuzzyMatch*(haystack: cstring = nil; casefoldNeedle: cstring;
    priority: var int = cast[var int](nil)): bool =
  var priority_00: uint32
  result = toBool(gtk_source_completion_fuzzy_match(haystack, casefoldNeedle, priority_00))
  if priority.addr != nil:
    priority = int(priority_00)

proc gtk_source_completion_block_interactive(self: ptr Completion00) {.
    importc, libprag.}

proc blockInteractive*(self: Completion) =
  gtk_source_completion_block_interactive(cast[ptr Completion00](self.impl))

proc gtk_source_completion_get_buffer(self: ptr Completion00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: Completion): Buffer =
  let gobj = gtk_source_completion_get_buffer(cast[ptr Completion00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: Completion): Buffer =
  let gobj = gtk_source_completion_get_buffer(cast[ptr Completion00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_get_page_size(self: ptr Completion00): uint32 {.
    importc, libprag.}

proc getPageSize*(self: Completion): int =
  int(gtk_source_completion_get_page_size(cast[ptr Completion00](self.impl)))

proc pageSize*(self: Completion): int =
  int(gtk_source_completion_get_page_size(cast[ptr Completion00](self.impl)))

proc gtk_source_completion_hide(self: ptr Completion00) {.
    importc, libprag.}

proc hide*(self: Completion) =
  gtk_source_completion_hide(cast[ptr Completion00](self.impl))

proc gtk_source_completion_set_page_size(self: ptr Completion00; pageSize: uint32) {.
    importc, libprag.}

proc setPageSize*(self: Completion; pageSize: int) =
  gtk_source_completion_set_page_size(cast[ptr Completion00](self.impl), uint32(pageSize))

proc `pageSize=`*(self: Completion; pageSize: int) =
  gtk_source_completion_set_page_size(cast[ptr Completion00](self.impl), uint32(pageSize))

proc gtk_source_completion_show(self: ptr Completion00) {.
    importc, libprag.}

proc show*(self: Completion) =
  gtk_source_completion_show(cast[ptr Completion00](self.impl))

proc gtk_source_completion_unblock_interactive(self: ptr Completion00) {.
    importc, libprag.}

proc unblockInteractive*(self: Completion) =
  gtk_source_completion_unblock_interactive(cast[ptr Completion00](self.impl))

type
  CompletionContext* = ref object of gobject.Object
  CompletionContext00* = object of gobject.Object00

proc gtk_source_completion_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CompletionContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scProviderModelChanged*(self: CompletionContext;  p: proc (self: ptr CompletionContext00; provider: ptr CompletionProvider00; model: ptr gio.ListModel00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "provider-model-changed", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_completion_context_get_bounds(self: ptr CompletionContext00;
    begin: var gtk4.TextIter; `end`: var gtk4.TextIter): gboolean {.
    importc, libprag.}

proc getBounds*(self: CompletionContext; begin: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    `end`: var gtk4.TextIter = cast[var gtk4.TextIter](nil)): bool =
  toBool(gtk_source_completion_context_get_bounds(cast[ptr CompletionContext00](self.impl), begin, `end`))

proc gtk_source_completion_context_get_buffer(self: ptr CompletionContext00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: CompletionContext): Buffer =
  let gobj = gtk_source_completion_context_get_buffer(cast[ptr CompletionContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: CompletionContext): Buffer =
  let gobj = gtk_source_completion_context_get_buffer(cast[ptr CompletionContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_context_get_busy(self: ptr CompletionContext00): gboolean {.
    importc, libprag.}

proc getBusy*(self: CompletionContext): bool =
  toBool(gtk_source_completion_context_get_busy(cast[ptr CompletionContext00](self.impl)))

proc busy*(self: CompletionContext): bool =
  toBool(gtk_source_completion_context_get_busy(cast[ptr CompletionContext00](self.impl)))

proc gtk_source_completion_context_get_completion(self: ptr CompletionContext00): ptr Completion00 {.
    importc, libprag.}

proc getCompletion*(self: CompletionContext): Completion =
  let gobj = gtk_source_completion_context_get_completion(cast[ptr CompletionContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc completion*(self: CompletionContext): Completion =
  let gobj = gtk_source_completion_context_get_completion(cast[ptr CompletionContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_context_get_empty(self: ptr CompletionContext00): gboolean {.
    importc, libprag.}

proc getEmpty*(self: CompletionContext): bool =
  toBool(gtk_source_completion_context_get_empty(cast[ptr CompletionContext00](self.impl)))

proc empty*(self: CompletionContext): bool =
  toBool(gtk_source_completion_context_get_empty(cast[ptr CompletionContext00](self.impl)))

proc gtk_source_completion_context_get_language(self: ptr CompletionContext00): ptr Language00 {.
    importc, libprag.}

proc getLanguage*(self: CompletionContext): Language =
  let gobj = gtk_source_completion_context_get_language(cast[ptr CompletionContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc language*(self: CompletionContext): Language =
  let gobj = gtk_source_completion_context_get_language(cast[ptr CompletionContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_context_get_word(self: ptr CompletionContext00): cstring {.
    importc, libprag.}

proc getWord*(self: CompletionContext): string =
  let resul0 = gtk_source_completion_context_get_word(cast[ptr CompletionContext00](self.impl))
  result = $resul0
  cogfree(resul0)

proc word*(self: CompletionContext): string =
  let resul0 = gtk_source_completion_context_get_word(cast[ptr CompletionContext00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_completion_context_list_providers(self: ptr CompletionContext00): ptr gio.ListModel00 {.
    importc, libprag.}

proc listProviders*(self: CompletionContext): gio.ListModel =
  let gobj = gtk_source_completion_context_list_providers(cast[ptr CompletionContext00](self.impl))
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
  CompletionProposal00* = object of gobject.Object00
  CompletionProposal* = ref object of gobject.Object

proc gtk_source_completion_proposal_get_typed_text(self: ptr CompletionProposal00): cstring {.
    importc, libprag.}

proc getTypedText*(self: CompletionProposal): string =
  let resul0 = gtk_source_completion_proposal_get_typed_text(cast[ptr CompletionProposal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc typedText*(self: CompletionProposal): string =
  let resul0 = gtk_source_completion_proposal_get_typed_text(cast[ptr CompletionProposal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

type
  CompletionCell* = ref object of gtk4.Widget
  CompletionCell00* = object of gtk4.Widget00

proc gtk_source_completion_cell_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CompletionCell()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_completion_cell_get_widget(self: ptr CompletionCell00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getWidget*(self: CompletionCell): gtk4.Widget =
  let gobj = gtk_source_completion_cell_get_widget(cast[ptr CompletionCell00](self.impl))
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

proc widget*(self: CompletionCell): gtk4.Widget =
  let gobj = gtk_source_completion_cell_get_widget(cast[ptr CompletionCell00](self.impl))
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

proc gtk_source_completion_cell_set_gicon(self: ptr CompletionCell00; gicon: ptr gio.Icon00) {.
    importc, libprag.}

proc setGicon*(self: CompletionCell; gicon: gio.Icon) =
  gtk_source_completion_cell_set_gicon(cast[ptr CompletionCell00](self.impl), cast[ptr gio.Icon00](gicon.impl))

proc `gicon=`*(self: CompletionCell; gicon: gio.Icon) =
  gtk_source_completion_cell_set_gicon(cast[ptr CompletionCell00](self.impl), cast[ptr gio.Icon00](gicon.impl))

proc gtk_source_completion_cell_set_icon_name(self: ptr CompletionCell00;
    iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: CompletionCell; iconName: cstring) =
  gtk_source_completion_cell_set_icon_name(cast[ptr CompletionCell00](self.impl), iconName)

proc `iconName=`*(self: CompletionCell; iconName: cstring) =
  gtk_source_completion_cell_set_icon_name(cast[ptr CompletionCell00](self.impl), iconName)

proc gtk_source_completion_cell_set_markup(self: ptr CompletionCell00; markup: cstring) {.
    importc, libprag.}

proc setMarkup*(self: CompletionCell; markup: cstring) =
  gtk_source_completion_cell_set_markup(cast[ptr CompletionCell00](self.impl), markup)

proc `markup=`*(self: CompletionCell; markup: cstring) =
  gtk_source_completion_cell_set_markup(cast[ptr CompletionCell00](self.impl), markup)

proc gtk_source_completion_cell_set_paintable(self: ptr CompletionCell00;
    paintable: ptr gdk4.Paintable00) {.
    importc, libprag.}

proc setPaintable*(self: CompletionCell; paintable: gdk4.Paintable) =
  gtk_source_completion_cell_set_paintable(cast[ptr CompletionCell00](self.impl), cast[ptr gdk4.Paintable00](paintable.impl))

proc `paintable=`*(self: CompletionCell; paintable: gdk4.Paintable) =
  gtk_source_completion_cell_set_paintable(cast[ptr CompletionCell00](self.impl), cast[ptr gdk4.Paintable00](paintable.impl))

proc gtk_source_completion_cell_set_text(self: ptr CompletionCell00; text: cstring) {.
    importc, libprag.}

proc setText*(self: CompletionCell; text: cstring = nil) =
  gtk_source_completion_cell_set_text(cast[ptr CompletionCell00](self.impl), text)

proc `text=`*(self: CompletionCell; text: cstring = nil) =
  gtk_source_completion_cell_set_text(cast[ptr CompletionCell00](self.impl), text)

proc gtk_source_completion_cell_set_text_with_attributes(self: ptr CompletionCell00;
    text: cstring; attrs: ptr pango.AttrList00) {.
    importc, libprag.}

proc setTextWithAttributes*(self: CompletionCell;
    text: cstring; attrs: pango.AttrList) =
  gtk_source_completion_cell_set_text_with_attributes(cast[ptr CompletionCell00](self.impl), text, cast[ptr pango.AttrList00](attrs.impl))

proc gtk_source_completion_cell_set_widget(self: ptr CompletionCell00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc setWidget*(self: CompletionCell; child: gtk4.Widget) =
  gtk_source_completion_cell_set_widget(cast[ptr CompletionCell00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc `widget=`*(self: CompletionCell; child: gtk4.Widget) =
  gtk_source_completion_cell_set_widget(cast[ptr CompletionCell00](self.impl), cast[ptr gtk4.Widget00](child.impl))

type
  CompletionColumn* {.size: sizeof(cint), pure.} = enum
    icon = 0
    before = 1
    typedText = 2
    after = 3
    comment = 4
    details = 5

proc gtk_source_completion_cell_get_column(self: ptr CompletionCell00): CompletionColumn {.
    importc, libprag.}

proc getColumn*(self: CompletionCell): CompletionColumn =
  gtk_source_completion_cell_get_column(cast[ptr CompletionCell00](self.impl))

proc column*(self: CompletionCell): CompletionColumn =
  gtk_source_completion_cell_get_column(cast[ptr CompletionCell00](self.impl))

type
  CompletionActivation* {.size: sizeof(cint), pure.} = enum
    none = 0
    interactive = 1
    userRequested = 2

proc gtk_source_completion_context_get_activation(self: ptr CompletionContext00): CompletionActivation {.
    importc, libprag.}

proc getActivation*(self: CompletionContext): CompletionActivation =
  gtk_source_completion_context_get_activation(cast[ptr CompletionContext00](self.impl))

proc activation*(self: CompletionContext): CompletionActivation =
  gtk_source_completion_context_get_activation(cast[ptr CompletionContext00](self.impl))

type
  Snippet* = ref object of gobject.Object
  Snippet00* = object of gobject.Object00

proc gtk_source_snippet_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Snippet()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_snippet_new(trigger: cstring; languageId: cstring): ptr Snippet00 {.
    importc, libprag.}

proc newSnippet*(trigger: cstring = nil; languageId: cstring = nil): Snippet =
  let gobj = gtk_source_snippet_new(trigger, languageId)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSnippet*(tdesc: typedesc; trigger: cstring = nil; languageId: cstring = nil): tdesc =
  assert(result is Snippet)
  let gobj = gtk_source_snippet_new(trigger, languageId)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSnippet*[T](result: var T; trigger: cstring = nil; languageId: cstring = nil) {.deprecated.} =
  assert(result is Snippet)
  let gobj = gtk_source_snippet_new(trigger, languageId)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_snippet_new_parsed(text: cstring; error: ptr ptr glib.Error = nil): ptr Snippet00 {.
    importc, libprag.}

proc newSnippetParsed*(text: cstring): Snippet =
  var gerror: ptr glib.Error
  let gobj = gtk_source_snippet_new_parsed(text, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSnippetParsed*(tdesc: typedesc; text: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is Snippet)
  let gobj = gtk_source_snippet_new_parsed(text, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSnippetParsed*[T](result: var T; text: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Snippet)
  let gobj = gtk_source_snippet_new_parsed(text, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_snippet_copy(self: ptr Snippet00): ptr Snippet00 {.
    importc, libprag.}

proc copy*(self: Snippet): Snippet =
  let gobj = gtk_source_snippet_copy(cast[ptr Snippet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_snippet_get_description(self: ptr Snippet00): cstring {.
    importc, libprag.}

proc getDescription*(self: Snippet): string =
  result = $gtk_source_snippet_get_description(cast[ptr Snippet00](self.impl))

proc description*(self: Snippet): string =
  result = $gtk_source_snippet_get_description(cast[ptr Snippet00](self.impl))

proc gtk_source_snippet_get_focus_position(self: ptr Snippet00): int32 {.
    importc, libprag.}

proc getFocusPosition*(self: Snippet): int =
  int(gtk_source_snippet_get_focus_position(cast[ptr Snippet00](self.impl)))

proc focusPosition*(self: Snippet): int =
  int(gtk_source_snippet_get_focus_position(cast[ptr Snippet00](self.impl)))

proc gtk_source_snippet_get_language_id(self: ptr Snippet00): cstring {.
    importc, libprag.}

proc getLanguageId*(self: Snippet): string =
  result = $gtk_source_snippet_get_language_id(cast[ptr Snippet00](self.impl))

proc languageId*(self: Snippet): string =
  result = $gtk_source_snippet_get_language_id(cast[ptr Snippet00](self.impl))

proc gtk_source_snippet_get_n_chunks(self: ptr Snippet00): uint32 {.
    importc, libprag.}

proc getNChunks*(self: Snippet): int =
  int(gtk_source_snippet_get_n_chunks(cast[ptr Snippet00](self.impl)))

proc nChunks*(self: Snippet): int =
  int(gtk_source_snippet_get_n_chunks(cast[ptr Snippet00](self.impl)))

proc gtk_source_snippet_get_name(self: ptr Snippet00): cstring {.
    importc, libprag.}

proc getName*(self: Snippet): string =
  result = $gtk_source_snippet_get_name(cast[ptr Snippet00](self.impl))

proc name*(self: Snippet): string =
  result = $gtk_source_snippet_get_name(cast[ptr Snippet00](self.impl))

proc gtk_source_snippet_get_trigger(self: ptr Snippet00): cstring {.
    importc, libprag.}

proc getTrigger*(self: Snippet): string =
  let resul0 = gtk_source_snippet_get_trigger(cast[ptr Snippet00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc trigger*(self: Snippet): string =
  let resul0 = gtk_source_snippet_get_trigger(cast[ptr Snippet00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_snippet_set_description(self: ptr Snippet00; description: cstring) {.
    importc, libprag.}

proc setDescription*(self: Snippet; description: cstring) =
  gtk_source_snippet_set_description(cast[ptr Snippet00](self.impl), description)

proc `description=`*(self: Snippet; description: cstring) =
  gtk_source_snippet_set_description(cast[ptr Snippet00](self.impl), description)

proc gtk_source_snippet_set_language_id(self: ptr Snippet00; languageId: cstring) {.
    importc, libprag.}

proc setLanguageId*(self: Snippet; languageId: cstring) =
  gtk_source_snippet_set_language_id(cast[ptr Snippet00](self.impl), languageId)

proc `languageId=`*(self: Snippet; languageId: cstring) =
  gtk_source_snippet_set_language_id(cast[ptr Snippet00](self.impl), languageId)

proc gtk_source_snippet_set_name(self: ptr Snippet00; name: cstring) {.
    importc, libprag.}

proc setName*(self: Snippet; name: cstring) =
  gtk_source_snippet_set_name(cast[ptr Snippet00](self.impl), name)

proc `name=`*(self: Snippet; name: cstring) =
  gtk_source_snippet_set_name(cast[ptr Snippet00](self.impl), name)

proc gtk_source_snippet_set_trigger(self: ptr Snippet00; trigger: cstring) {.
    importc, libprag.}

proc setTrigger*(self: Snippet; trigger: cstring) =
  gtk_source_snippet_set_trigger(cast[ptr Snippet00](self.impl), trigger)

proc `trigger=`*(self: Snippet; trigger: cstring) =
  gtk_source_snippet_set_trigger(cast[ptr Snippet00](self.impl), trigger)

type
  View* = ref object of gtk4.TextView
  View00* = object of gtk4.TextView00

proc gtk_source_view_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(View()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChangeCase*(self: View;  p: proc (self: ptr View00; caseType: ChangeCaseType; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "change-case", cast[GCallback](p), xdata, nil, cf)

proc scChangeNumber*(self: View;  p: proc (self: ptr View00; count: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "change-number", cast[GCallback](p), xdata, nil, cf)

proc scJoinLines*(self: View;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "join-lines", cast[GCallback](p), xdata, nil, cf)

proc scLineMarkActivated*(self: View;  p: proc (self: ptr View00; iter: gtk4.TextIter; button: uint32; state: gdk4.ModifierType; nPresses: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "line-mark-activated", cast[GCallback](p), xdata, nil, cf)

proc scMoveLines*(self: View;  p: proc (self: ptr View00; down: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "move-lines", cast[GCallback](p), xdata, nil, cf)

proc scMoveToMatchingBracket*(self: View;  p: proc (self: ptr View00; extendSelection: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "move-to-matching-bracket", cast[GCallback](p), xdata, nil, cf)

proc scMoveWords*(self: View;  p: proc (self: ptr View00; count: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "move-words", cast[GCallback](p), xdata, nil, cf)

proc scPushSnippet*(self: View;  p: proc (self: ptr View00; snippet: ptr Snippet00; location: var gtk4.TextIter; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "push-snippet", cast[GCallback](p), xdata, nil, cf)

proc scShowCompletion*(self: View;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "show-completion", cast[GCallback](p), xdata, nil, cf)

proc scSmartHomeEnd*(self: View;  p: proc (self: ptr View00; iter: gtk4.TextIter; count: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "smart-home-end", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_view_new(): ptr View00 {.
    importc, libprag.}

proc newView*(): View =
  let gobj = gtk_source_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newView*(tdesc: typedesc): tdesc =
  assert(result is View)
  let gobj = gtk_source_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initView*[T](result: var T) {.deprecated.} =
  assert(result is View)
  let gobj = gtk_source_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_view_new_with_buffer(buffer: ptr Buffer00): ptr View00 {.
    importc, libprag.}

proc newViewWithBuffer*(buffer: Buffer): View =
  let gobj = gtk_source_view_new_with_buffer(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newViewWithBuffer*(tdesc: typedesc; buffer: Buffer): tdesc =
  assert(result is View)
  let gobj = gtk_source_view_new_with_buffer(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initViewWithBuffer*[T](result: var T; buffer: Buffer) {.deprecated.} =
  assert(result is View)
  let gobj = gtk_source_view_new_with_buffer(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_view_get_auto_indent(self: ptr View00): gboolean {.
    importc, libprag.}

proc getAutoIndent*(self: View): bool =
  toBool(gtk_source_view_get_auto_indent(cast[ptr View00](self.impl)))

proc autoIndent*(self: View): bool =
  toBool(gtk_source_view_get_auto_indent(cast[ptr View00](self.impl)))

proc gtk_source_view_get_background_pattern(self: ptr View00): BackgroundPatternType {.
    importc, libprag.}

proc getBackgroundPattern*(self: View): BackgroundPatternType =
  gtk_source_view_get_background_pattern(cast[ptr View00](self.impl))

proc backgroundPattern*(self: View): BackgroundPatternType =
  gtk_source_view_get_background_pattern(cast[ptr View00](self.impl))

proc gtk_source_view_get_completion(self: ptr View00): ptr Completion00 {.
    importc, libprag.}

proc getCompletion*(self: View): Completion =
  let gobj = gtk_source_view_get_completion(cast[ptr View00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc completion*(self: View): Completion =
  let gobj = gtk_source_view_get_completion(cast[ptr View00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_view_get_enable_snippets(self: ptr View00): gboolean {.
    importc, libprag.}

proc getEnableSnippets*(self: View): bool =
  toBool(gtk_source_view_get_enable_snippets(cast[ptr View00](self.impl)))

proc enableSnippets*(self: View): bool =
  toBool(gtk_source_view_get_enable_snippets(cast[ptr View00](self.impl)))

proc gtk_source_view_get_highlight_current_line(self: ptr View00): gboolean {.
    importc, libprag.}

proc getHighlightCurrentLine*(self: View): bool =
  toBool(gtk_source_view_get_highlight_current_line(cast[ptr View00](self.impl)))

proc highlightCurrentLine*(self: View): bool =
  toBool(gtk_source_view_get_highlight_current_line(cast[ptr View00](self.impl)))

proc gtk_source_view_get_indent_on_tab(self: ptr View00): gboolean {.
    importc, libprag.}

proc getIndentOnTab*(self: View): bool =
  toBool(gtk_source_view_get_indent_on_tab(cast[ptr View00](self.impl)))

proc indentOnTab*(self: View): bool =
  toBool(gtk_source_view_get_indent_on_tab(cast[ptr View00](self.impl)))

proc gtk_source_view_get_indent_width(self: ptr View00): int32 {.
    importc, libprag.}

proc getIndentWidth*(self: View): int =
  int(gtk_source_view_get_indent_width(cast[ptr View00](self.impl)))

proc indentWidth*(self: View): int =
  int(gtk_source_view_get_indent_width(cast[ptr View00](self.impl)))

proc gtk_source_view_get_insert_spaces_instead_of_tabs(self: ptr View00): gboolean {.
    importc, libprag.}

proc getInsertSpacesInsteadOfTabs*(self: View): bool =
  toBool(gtk_source_view_get_insert_spaces_instead_of_tabs(cast[ptr View00](self.impl)))

proc insertSpacesInsteadOfTabs*(self: View): bool =
  toBool(gtk_source_view_get_insert_spaces_instead_of_tabs(cast[ptr View00](self.impl)))

proc gtk_source_view_get_right_margin_position(self: ptr View00): uint32 {.
    importc, libprag.}

proc getRightMarginPosition*(self: View): int =
  int(gtk_source_view_get_right_margin_position(cast[ptr View00](self.impl)))

proc rightMarginPosition*(self: View): int =
  int(gtk_source_view_get_right_margin_position(cast[ptr View00](self.impl)))

proc gtk_source_view_get_show_line_marks(self: ptr View00): gboolean {.
    importc, libprag.}

proc getShowLineMarks*(self: View): bool =
  toBool(gtk_source_view_get_show_line_marks(cast[ptr View00](self.impl)))

proc showLineMarks*(self: View): bool =
  toBool(gtk_source_view_get_show_line_marks(cast[ptr View00](self.impl)))

proc gtk_source_view_get_show_line_numbers(self: ptr View00): gboolean {.
    importc, libprag.}

proc getShowLineNumbers*(self: View): bool =
  toBool(gtk_source_view_get_show_line_numbers(cast[ptr View00](self.impl)))

proc showLineNumbers*(self: View): bool =
  toBool(gtk_source_view_get_show_line_numbers(cast[ptr View00](self.impl)))

proc gtk_source_view_get_show_right_margin(self: ptr View00): gboolean {.
    importc, libprag.}

proc getShowRightMargin*(self: View): bool =
  toBool(gtk_source_view_get_show_right_margin(cast[ptr View00](self.impl)))

proc showRightMargin*(self: View): bool =
  toBool(gtk_source_view_get_show_right_margin(cast[ptr View00](self.impl)))

proc gtk_source_view_get_smart_backspace(self: ptr View00): gboolean {.
    importc, libprag.}

proc getSmartBackspace*(self: View): bool =
  toBool(gtk_source_view_get_smart_backspace(cast[ptr View00](self.impl)))

proc smartBackspace*(self: View): bool =
  toBool(gtk_source_view_get_smart_backspace(cast[ptr View00](self.impl)))

proc gtk_source_view_get_tab_width(self: ptr View00): uint32 {.
    importc, libprag.}

proc getTabWidth*(self: View): int =
  int(gtk_source_view_get_tab_width(cast[ptr View00](self.impl)))

proc tabWidth*(self: View): int =
  int(gtk_source_view_get_tab_width(cast[ptr View00](self.impl)))

proc gtk_source_view_get_visual_column(self: ptr View00; iter: gtk4.TextIter): uint32 {.
    importc, libprag.}

proc getVisualColumn*(self: View; iter: gtk4.TextIter): int =
  int(gtk_source_view_get_visual_column(cast[ptr View00](self.impl), iter))

proc gtk_source_view_indent_lines(self: ptr View00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc indentLines*(self: View; start: gtk4.TextIter; `end`: gtk4.TextIter) =
  gtk_source_view_indent_lines(cast[ptr View00](self.impl), start, `end`)

proc gtk_source_view_push_snippet(self: ptr View00; snippet: ptr Snippet00;
    location: gtk4.TextIter) {.
    importc, libprag.}

proc pushSnippet*(self: View; snippet: Snippet; location: gtk4.TextIter = cast[var gtk4.TextIter](nil)) =
  gtk_source_view_push_snippet(cast[ptr View00](self.impl), cast[ptr Snippet00](snippet.impl), location)

proc gtk_source_view_set_auto_indent(self: ptr View00; enable: gboolean) {.
    importc, libprag.}

proc setAutoIndent*(self: View; enable: bool = true) =
  gtk_source_view_set_auto_indent(cast[ptr View00](self.impl), gboolean(enable))

proc `autoIndent=`*(self: View; enable: bool) =
  gtk_source_view_set_auto_indent(cast[ptr View00](self.impl), gboolean(enable))

proc gtk_source_view_set_background_pattern(self: ptr View00; backgroundPattern: BackgroundPatternType) {.
    importc, libprag.}

proc setBackgroundPattern*(self: View; backgroundPattern: BackgroundPatternType) =
  gtk_source_view_set_background_pattern(cast[ptr View00](self.impl), backgroundPattern)

proc `backgroundPattern=`*(self: View; backgroundPattern: BackgroundPatternType) =
  gtk_source_view_set_background_pattern(cast[ptr View00](self.impl), backgroundPattern)

proc gtk_source_view_set_enable_snippets(self: ptr View00; enableSnippets: gboolean) {.
    importc, libprag.}

proc setEnableSnippets*(self: View; enableSnippets: bool = true) =
  gtk_source_view_set_enable_snippets(cast[ptr View00](self.impl), gboolean(enableSnippets))

proc `enableSnippets=`*(self: View; enableSnippets: bool) =
  gtk_source_view_set_enable_snippets(cast[ptr View00](self.impl), gboolean(enableSnippets))

proc gtk_source_view_set_highlight_current_line(self: ptr View00; highlight: gboolean) {.
    importc, libprag.}

proc setHighlightCurrentLine*(self: View; highlight: bool = true) =
  gtk_source_view_set_highlight_current_line(cast[ptr View00](self.impl), gboolean(highlight))

proc `highlightCurrentLine=`*(self: View; highlight: bool) =
  gtk_source_view_set_highlight_current_line(cast[ptr View00](self.impl), gboolean(highlight))

proc gtk_source_view_set_indent_on_tab(self: ptr View00; enable: gboolean) {.
    importc, libprag.}

proc setIndentOnTab*(self: View; enable: bool = true) =
  gtk_source_view_set_indent_on_tab(cast[ptr View00](self.impl), gboolean(enable))

proc `indentOnTab=`*(self: View; enable: bool) =
  gtk_source_view_set_indent_on_tab(cast[ptr View00](self.impl), gboolean(enable))

proc gtk_source_view_set_indent_width(self: ptr View00; width: int32) {.
    importc, libprag.}

proc setIndentWidth*(self: View; width: int) =
  gtk_source_view_set_indent_width(cast[ptr View00](self.impl), int32(width))

proc `indentWidth=`*(self: View; width: int) =
  gtk_source_view_set_indent_width(cast[ptr View00](self.impl), int32(width))

proc gtk_source_view_set_insert_spaces_instead_of_tabs(self: ptr View00;
    enable: gboolean) {.
    importc, libprag.}

proc setInsertSpacesInsteadOfTabs*(self: View; enable: bool = true) =
  gtk_source_view_set_insert_spaces_instead_of_tabs(cast[ptr View00](self.impl), gboolean(enable))

proc `insertSpacesInsteadOfTabs=`*(self: View; enable: bool) =
  gtk_source_view_set_insert_spaces_instead_of_tabs(cast[ptr View00](self.impl), gboolean(enable))

proc gtk_source_view_set_right_margin_position(self: ptr View00; pos: uint32) {.
    importc, libprag.}

proc setRightMarginPosition*(self: View; pos: int) =
  gtk_source_view_set_right_margin_position(cast[ptr View00](self.impl), uint32(pos))

proc `rightMarginPosition=`*(self: View; pos: int) =
  gtk_source_view_set_right_margin_position(cast[ptr View00](self.impl), uint32(pos))

proc gtk_source_view_set_show_line_marks(self: ptr View00; show: gboolean) {.
    importc, libprag.}

proc setShowLineMarks*(self: View; show: bool = true) =
  gtk_source_view_set_show_line_marks(cast[ptr View00](self.impl), gboolean(show))

proc `showLineMarks=`*(self: View; show: bool) =
  gtk_source_view_set_show_line_marks(cast[ptr View00](self.impl), gboolean(show))

proc gtk_source_view_set_show_line_numbers(self: ptr View00; show: gboolean) {.
    importc, libprag.}

proc setShowLineNumbers*(self: View; show: bool = true) =
  gtk_source_view_set_show_line_numbers(cast[ptr View00](self.impl), gboolean(show))

proc `showLineNumbers=`*(self: View; show: bool) =
  gtk_source_view_set_show_line_numbers(cast[ptr View00](self.impl), gboolean(show))

proc gtk_source_view_set_show_right_margin(self: ptr View00; show: gboolean) {.
    importc, libprag.}

proc setShowRightMargin*(self: View; show: bool = true) =
  gtk_source_view_set_show_right_margin(cast[ptr View00](self.impl), gboolean(show))

proc `showRightMargin=`*(self: View; show: bool) =
  gtk_source_view_set_show_right_margin(cast[ptr View00](self.impl), gboolean(show))

proc gtk_source_view_set_smart_backspace(self: ptr View00; smartBackspace: gboolean) {.
    importc, libprag.}

proc setSmartBackspace*(self: View; smartBackspace: bool = true) =
  gtk_source_view_set_smart_backspace(cast[ptr View00](self.impl), gboolean(smartBackspace))

proc `smartBackspace=`*(self: View; smartBackspace: bool) =
  gtk_source_view_set_smart_backspace(cast[ptr View00](self.impl), gboolean(smartBackspace))

proc gtk_source_view_set_tab_width(self: ptr View00; width: uint32) {.
    importc, libprag.}

proc setTabWidth*(self: View; width: int) =
  gtk_source_view_set_tab_width(cast[ptr View00](self.impl), uint32(width))

proc `tabWidth=`*(self: View; width: int) =
  gtk_source_view_set_tab_width(cast[ptr View00](self.impl), uint32(width))

proc gtk_source_view_unindent_lines(self: ptr View00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc unindentLines*(self: View; start: gtk4.TextIter; `end`: gtk4.TextIter) =
  gtk_source_view_unindent_lines(cast[ptr View00](self.impl), start, `end`)

proc gtk_source_completion_get_view(self: ptr Completion00): ptr View00 {.
    importc, libprag.}

proc getView*(self: Completion): View =
  let gobj = gtk_source_completion_get_view(cast[ptr Completion00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: Completion): View =
  let gobj = gtk_source_completion_get_view(cast[ptr Completion00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_context_get_view(self: ptr CompletionContext00): ptr View00 {.
    importc, libprag.}

proc getView*(self: CompletionContext): View =
  let gobj = gtk_source_completion_context_get_view(cast[ptr CompletionContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: CompletionContext): View =
  let gobj = gtk_source_completion_context_get_view(cast[ptr CompletionContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SnippetContext* = ref object of gobject.Object
  SnippetContext00* = object of gobject.Object00

proc gtk_source_snippet_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SnippetContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChanged*(self: SnippetContext;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_snippet_context_new(): ptr SnippetContext00 {.
    importc, libprag.}

proc newSnippetContext*(): SnippetContext =
  let gobj = gtk_source_snippet_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSnippetContext*(tdesc: typedesc): tdesc =
  assert(result is SnippetContext)
  let gobj = gtk_source_snippet_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSnippetContext*[T](result: var T) {.deprecated.} =
  assert(result is SnippetContext)
  let gobj = gtk_source_snippet_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_snippet_context_clear_variables(self: ptr SnippetContext00) {.
    importc, libprag.}

proc clearVariables*(self: SnippetContext) =
  gtk_source_snippet_context_clear_variables(cast[ptr SnippetContext00](self.impl))

proc gtk_source_snippet_context_expand(self: ptr SnippetContext00; input: cstring): cstring {.
    importc, libprag.}

proc expand*(self: SnippetContext; input: cstring): string =
  let resul0 = gtk_source_snippet_context_expand(cast[ptr SnippetContext00](self.impl), input)
  result = $resul0
  cogfree(resul0)

proc gtk_source_snippet_context_get_variable(self: ptr SnippetContext00;
    key: cstring): cstring {.
    importc, libprag.}

proc getVariable*(self: SnippetContext; key: cstring): string =
  let resul0 = gtk_source_snippet_context_get_variable(cast[ptr SnippetContext00](self.impl), key)
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_snippet_context_set_constant(self: ptr SnippetContext00;
    key: cstring; value: cstring) {.
    importc, libprag.}

proc setConstant*(self: SnippetContext; key: cstring;
    value: cstring) =
  gtk_source_snippet_context_set_constant(cast[ptr SnippetContext00](self.impl), key, value)

proc gtk_source_snippet_context_set_line_prefix(self: ptr SnippetContext00;
    linePrefix: cstring) {.
    importc, libprag.}

proc setLinePrefix*(self: SnippetContext; linePrefix: cstring) =
  gtk_source_snippet_context_set_line_prefix(cast[ptr SnippetContext00](self.impl), linePrefix)

proc `linePrefix=`*(self: SnippetContext; linePrefix: cstring) =
  gtk_source_snippet_context_set_line_prefix(cast[ptr SnippetContext00](self.impl), linePrefix)

proc gtk_source_snippet_context_set_tab_width(self: ptr SnippetContext00;
    tabWidth: int32) {.
    importc, libprag.}

proc setTabWidth*(self: SnippetContext; tabWidth: int) =
  gtk_source_snippet_context_set_tab_width(cast[ptr SnippetContext00](self.impl), int32(tabWidth))

proc `tabWidth=`*(self: SnippetContext; tabWidth: int) =
  gtk_source_snippet_context_set_tab_width(cast[ptr SnippetContext00](self.impl), int32(tabWidth))

proc gtk_source_snippet_context_set_use_spaces(self: ptr SnippetContext00;
    useSpaces: gboolean) {.
    importc, libprag.}

proc setUseSpaces*(self: SnippetContext; useSpaces: bool = true) =
  gtk_source_snippet_context_set_use_spaces(cast[ptr SnippetContext00](self.impl), gboolean(useSpaces))

proc `useSpaces=`*(self: SnippetContext; useSpaces: bool) =
  gtk_source_snippet_context_set_use_spaces(cast[ptr SnippetContext00](self.impl), gboolean(useSpaces))

proc gtk_source_snippet_context_set_variable(self: ptr SnippetContext00;
    key: cstring; value: cstring) {.
    importc, libprag.}

proc setVariable*(self: SnippetContext; key: cstring;
    value: cstring) =
  gtk_source_snippet_context_set_variable(cast[ptr SnippetContext00](self.impl), key, value)

proc gtk_source_snippet_get_context(self: ptr Snippet00): ptr SnippetContext00 {.
    importc, libprag.}

proc getContext*(self: Snippet): SnippetContext =
  let gobj = gtk_source_snippet_get_context(cast[ptr Snippet00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc context*(self: Snippet): SnippetContext =
  let gobj = gtk_source_snippet_get_context(cast[ptr Snippet00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SnippetChunk* = ref object of gobject.InitiallyUnowned
  SnippetChunk00* = object of gobject.InitiallyUnowned00

proc gtk_source_snippet_chunk_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SnippetChunk()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_snippet_chunk_new(): ptr SnippetChunk00 {.
    importc, libprag.}

proc newSnippetChunk*(): SnippetChunk =
  let gobj = gtk_source_snippet_chunk_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSnippetChunk*(tdesc: typedesc): tdesc =
  assert(result is SnippetChunk)
  let gobj = gtk_source_snippet_chunk_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSnippetChunk*[T](result: var T) {.deprecated.} =
  assert(result is SnippetChunk)
  let gobj = gtk_source_snippet_chunk_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_snippet_chunk_copy(self: ptr SnippetChunk00): ptr SnippetChunk00 {.
    importc, libprag.}

proc copy*(self: SnippetChunk): SnippetChunk =
  let gobj = gtk_source_snippet_chunk_copy(cast[ptr SnippetChunk00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_snippet_chunk_get_context(self: ptr SnippetChunk00): ptr SnippetContext00 {.
    importc, libprag.}

proc getContext*(self: SnippetChunk): SnippetContext =
  let gobj = gtk_source_snippet_chunk_get_context(cast[ptr SnippetChunk00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc context*(self: SnippetChunk): SnippetContext =
  let gobj = gtk_source_snippet_chunk_get_context(cast[ptr SnippetChunk00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_snippet_chunk_get_focus_position(self: ptr SnippetChunk00): int32 {.
    importc, libprag.}

proc getFocusPosition*(self: SnippetChunk): int =
  int(gtk_source_snippet_chunk_get_focus_position(cast[ptr SnippetChunk00](self.impl)))

proc focusPosition*(self: SnippetChunk): int =
  int(gtk_source_snippet_chunk_get_focus_position(cast[ptr SnippetChunk00](self.impl)))

proc gtk_source_snippet_chunk_get_spec(self: ptr SnippetChunk00): cstring {.
    importc, libprag.}

proc getSpec*(self: SnippetChunk): string =
  let resul0 = gtk_source_snippet_chunk_get_spec(cast[ptr SnippetChunk00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc spec*(self: SnippetChunk): string =
  let resul0 = gtk_source_snippet_chunk_get_spec(cast[ptr SnippetChunk00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_snippet_chunk_get_text(self: ptr SnippetChunk00): cstring {.
    importc, libprag.}

proc getText*(self: SnippetChunk): string =
  result = $gtk_source_snippet_chunk_get_text(cast[ptr SnippetChunk00](self.impl))

proc text*(self: SnippetChunk): string =
  result = $gtk_source_snippet_chunk_get_text(cast[ptr SnippetChunk00](self.impl))

proc gtk_source_snippet_chunk_get_text_set(self: ptr SnippetChunk00): gboolean {.
    importc, libprag.}

proc getTextSet*(self: SnippetChunk): bool =
  toBool(gtk_source_snippet_chunk_get_text_set(cast[ptr SnippetChunk00](self.impl)))

proc textSet*(self: SnippetChunk): bool =
  toBool(gtk_source_snippet_chunk_get_text_set(cast[ptr SnippetChunk00](self.impl)))

proc gtk_source_snippet_chunk_get_tooltip_text(self: ptr SnippetChunk00): cstring {.
    importc, libprag.}

proc getTooltipText*(self: SnippetChunk): string =
  result = $gtk_source_snippet_chunk_get_tooltip_text(cast[ptr SnippetChunk00](self.impl))

proc tooltipText*(self: SnippetChunk): string =
  result = $gtk_source_snippet_chunk_get_tooltip_text(cast[ptr SnippetChunk00](self.impl))

proc gtk_source_snippet_chunk_set_context(self: ptr SnippetChunk00; context: ptr SnippetContext00) {.
    importc, libprag.}

proc setContext*(self: SnippetChunk; context: SnippetContext) =
  gtk_source_snippet_chunk_set_context(cast[ptr SnippetChunk00](self.impl), cast[ptr SnippetContext00](context.impl))

proc `context=`*(self: SnippetChunk; context: SnippetContext) =
  gtk_source_snippet_chunk_set_context(cast[ptr SnippetChunk00](self.impl), cast[ptr SnippetContext00](context.impl))

proc gtk_source_snippet_chunk_set_focus_position(self: ptr SnippetChunk00;
    focusPosition: int32) {.
    importc, libprag.}

proc setFocusPosition*(self: SnippetChunk; focusPosition: int) =
  gtk_source_snippet_chunk_set_focus_position(cast[ptr SnippetChunk00](self.impl), int32(focusPosition))

proc `focusPosition=`*(self: SnippetChunk; focusPosition: int) =
  gtk_source_snippet_chunk_set_focus_position(cast[ptr SnippetChunk00](self.impl), int32(focusPosition))

proc gtk_source_snippet_chunk_set_spec(self: ptr SnippetChunk00; spec: cstring) {.
    importc, libprag.}

proc setSpec*(self: SnippetChunk; spec: cstring) =
  gtk_source_snippet_chunk_set_spec(cast[ptr SnippetChunk00](self.impl), spec)

proc `spec=`*(self: SnippetChunk; spec: cstring) =
  gtk_source_snippet_chunk_set_spec(cast[ptr SnippetChunk00](self.impl), spec)

proc gtk_source_snippet_chunk_set_text(self: ptr SnippetChunk00; text: cstring) {.
    importc, libprag.}

proc setText*(self: SnippetChunk; text: cstring) =
  gtk_source_snippet_chunk_set_text(cast[ptr SnippetChunk00](self.impl), text)

proc `text=`*(self: SnippetChunk; text: cstring) =
  gtk_source_snippet_chunk_set_text(cast[ptr SnippetChunk00](self.impl), text)

proc gtk_source_snippet_chunk_set_text_set(self: ptr SnippetChunk00; textSet: gboolean) {.
    importc, libprag.}

proc setTextSet*(self: SnippetChunk; textSet: bool = true) =
  gtk_source_snippet_chunk_set_text_set(cast[ptr SnippetChunk00](self.impl), gboolean(textSet))

proc `textSet=`*(self: SnippetChunk; textSet: bool) =
  gtk_source_snippet_chunk_set_text_set(cast[ptr SnippetChunk00](self.impl), gboolean(textSet))

proc gtk_source_snippet_chunk_set_tooltip_text(self: ptr SnippetChunk00;
    tooltipText: cstring) {.
    importc, libprag.}

proc setTooltipText*(self: SnippetChunk; tooltipText: cstring) =
  gtk_source_snippet_chunk_set_tooltip_text(cast[ptr SnippetChunk00](self.impl), tooltipText)

proc `tooltipText=`*(self: SnippetChunk; tooltipText: cstring) =
  gtk_source_snippet_chunk_set_tooltip_text(cast[ptr SnippetChunk00](self.impl), tooltipText)

proc gtk_source_snippet_add_chunk(self: ptr Snippet00; chunk: ptr SnippetChunk00) {.
    importc, libprag.}

proc addChunk*(self: Snippet; chunk: SnippetChunk) =
  gtk_source_snippet_add_chunk(cast[ptr Snippet00](self.impl), cast[ptr SnippetChunk00](chunk.impl))

proc gtk_source_snippet_get_nth_chunk(self: ptr Snippet00; nth: uint32): ptr SnippetChunk00 {.
    importc, libprag.}

proc getNthChunk*(self: Snippet; nth: int): SnippetChunk =
  let gobj = gtk_source_snippet_get_nth_chunk(cast[ptr Snippet00](self.impl), uint32(nth))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Gutter* = ref object of gtk4.Widget
  Gutter00* = object of gtk4.Widget00

proc gtk_source_gutter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Gutter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_gutter_get_view(self: ptr Gutter00): ptr View00 {.
    importc, libprag.}

proc getView*(self: Gutter): View =
  let gobj = gtk_source_gutter_get_view(cast[ptr Gutter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: Gutter): View =
  let gobj = gtk_source_gutter_get_view(cast[ptr Gutter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_view_get_gutter(self: ptr View00; windowType: gtk4.TextWindowType): ptr Gutter00 {.
    importc, libprag.}

proc getGutter*(self: View; windowType: gtk4.TextWindowType): Gutter =
  let gobj = gtk_source_view_get_gutter(cast[ptr View00](self.impl), windowType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  GutterRenderer* = ref object of gtk4.Widget
  GutterRenderer00* = object of gtk4.Widget00

proc gtk_source_gutter_renderer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GutterRenderer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActivate*(self: GutterRenderer;  p: proc (self: ptr GutterRenderer00; iter: gtk4.TextIter; area: gdk4.Rectangle; button: uint32; state: gdk4.ModifierType;
    nPresses: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "activate", cast[GCallback](p), xdata, nil, cf)

proc scQueryActivatable*(self: GutterRenderer;  p: proc (self: ptr GutterRenderer00; iter: gtk4.TextIter; area: gdk4.Rectangle; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "query-activatable", cast[GCallback](p), xdata, nil, cf)

proc scQueryData*(self: GutterRenderer;  p: proc (self: ptr GutterRenderer00; obj: ptr gobject.Object00; p0: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "query-data", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_gutter_renderer_activate(self: ptr GutterRenderer00; iter: gtk4.TextIter;
    area: gdk4.Rectangle; button: uint32; state: gdk4.ModifierType; nPresses: int32) {.
    importc, libprag.}

proc activate*(self: GutterRenderer; iter: gtk4.TextIter;
    area: gdk4.Rectangle; button: int; state: gdk4.ModifierType; nPresses: int) =
  gtk_source_gutter_renderer_activate(cast[ptr GutterRenderer00](self.impl), iter, area, uint32(button), state, int32(nPresses))

proc gtk_source_gutter_renderer_align_cell(self: ptr GutterRenderer00; line: uint32;
    width: cfloat; height: cfloat; x: var cfloat; y: var cfloat) {.
    importc, libprag.}

proc alignCell*(self: GutterRenderer; line: int;
    width: cfloat; height: cfloat; x: var cfloat; y: var cfloat) =
  gtk_source_gutter_renderer_align_cell(cast[ptr GutterRenderer00](self.impl), uint32(line), width, height, x, y)

proc gtk_source_gutter_renderer_get_buffer(self: ptr GutterRenderer00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: GutterRenderer): Buffer =
  let gobj = gtk_source_gutter_renderer_get_buffer(cast[ptr GutterRenderer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: GutterRenderer): Buffer =
  let gobj = gtk_source_gutter_renderer_get_buffer(cast[ptr GutterRenderer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_renderer_get_view(self: ptr GutterRenderer00): ptr View00 {.
    importc, libprag.}

proc getView*(self: GutterRenderer): View =
  let gobj = gtk_source_gutter_renderer_get_view(cast[ptr GutterRenderer00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: GutterRenderer): View =
  let gobj = gtk_source_gutter_renderer_get_view(cast[ptr GutterRenderer00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_renderer_get_xalign(self: ptr GutterRenderer00): cfloat {.
    importc, libprag.}

proc getXalign*(self: GutterRenderer): cfloat =
  gtk_source_gutter_renderer_get_xalign(cast[ptr GutterRenderer00](self.impl))

proc xalign*(self: GutterRenderer): cfloat =
  gtk_source_gutter_renderer_get_xalign(cast[ptr GutterRenderer00](self.impl))

proc gtk_source_gutter_renderer_get_xpad(self: ptr GutterRenderer00): int32 {.
    importc, libprag.}

proc getXpad*(self: GutterRenderer): int =
  int(gtk_source_gutter_renderer_get_xpad(cast[ptr GutterRenderer00](self.impl)))

proc xpad*(self: GutterRenderer): int =
  int(gtk_source_gutter_renderer_get_xpad(cast[ptr GutterRenderer00](self.impl)))

proc gtk_source_gutter_renderer_get_yalign(self: ptr GutterRenderer00): cfloat {.
    importc, libprag.}

proc getYalign*(self: GutterRenderer): cfloat =
  gtk_source_gutter_renderer_get_yalign(cast[ptr GutterRenderer00](self.impl))

proc yalign*(self: GutterRenderer): cfloat =
  gtk_source_gutter_renderer_get_yalign(cast[ptr GutterRenderer00](self.impl))

proc gtk_source_gutter_renderer_get_ypad(self: ptr GutterRenderer00): int32 {.
    importc, libprag.}

proc getYpad*(self: GutterRenderer): int =
  int(gtk_source_gutter_renderer_get_ypad(cast[ptr GutterRenderer00](self.impl)))

proc ypad*(self: GutterRenderer): int =
  int(gtk_source_gutter_renderer_get_ypad(cast[ptr GutterRenderer00](self.impl)))

proc gtk_source_gutter_renderer_query_activatable(self: ptr GutterRenderer00;
    iter: gtk4.TextIter; area: gdk4.Rectangle): gboolean {.
    importc, libprag.}

proc queryActivatable*(self: GutterRenderer; iter: gtk4.TextIter;
    area: gdk4.Rectangle): bool =
  toBool(gtk_source_gutter_renderer_query_activatable(cast[ptr GutterRenderer00](self.impl), iter, area))

proc gtk_source_gutter_renderer_set_xalign(self: ptr GutterRenderer00; xalign: cfloat) {.
    importc, libprag.}

proc setXalign*(self: GutterRenderer; xalign: cfloat) =
  gtk_source_gutter_renderer_set_xalign(cast[ptr GutterRenderer00](self.impl), xalign)

proc `xalign=`*(self: GutterRenderer; xalign: cfloat) =
  gtk_source_gutter_renderer_set_xalign(cast[ptr GutterRenderer00](self.impl), xalign)

proc gtk_source_gutter_renderer_set_xpad(self: ptr GutterRenderer00; xpad: int32) {.
    importc, libprag.}

proc setXpad*(self: GutterRenderer; xpad: int) =
  gtk_source_gutter_renderer_set_xpad(cast[ptr GutterRenderer00](self.impl), int32(xpad))

proc `xpad=`*(self: GutterRenderer; xpad: int) =
  gtk_source_gutter_renderer_set_xpad(cast[ptr GutterRenderer00](self.impl), int32(xpad))

proc gtk_source_gutter_renderer_set_yalign(self: ptr GutterRenderer00; yalign: cfloat) {.
    importc, libprag.}

proc setYalign*(self: GutterRenderer; yalign: cfloat) =
  gtk_source_gutter_renderer_set_yalign(cast[ptr GutterRenderer00](self.impl), yalign)

proc `yalign=`*(self: GutterRenderer; yalign: cfloat) =
  gtk_source_gutter_renderer_set_yalign(cast[ptr GutterRenderer00](self.impl), yalign)

proc gtk_source_gutter_renderer_set_ypad(self: ptr GutterRenderer00; ypad: int32) {.
    importc, libprag.}

proc setYpad*(self: GutterRenderer; ypad: int) =
  gtk_source_gutter_renderer_set_ypad(cast[ptr GutterRenderer00](self.impl), int32(ypad))

proc `ypad=`*(self: GutterRenderer; ypad: int) =
  gtk_source_gutter_renderer_set_ypad(cast[ptr GutterRenderer00](self.impl), int32(ypad))

proc gtk_source_gutter_insert(self: ptr Gutter00; renderer: ptr GutterRenderer00;
    position: int32): gboolean {.
    importc, libprag.}

proc insert*(self: Gutter; renderer: GutterRenderer; position: int): bool =
  toBool(gtk_source_gutter_insert(cast[ptr Gutter00](self.impl), cast[ptr GutterRenderer00](renderer.impl), int32(position)))

proc gtk_source_gutter_remove(self: ptr Gutter00; renderer: ptr GutterRenderer00) {.
    importc, libprag.}

proc remove*(self: Gutter; renderer: GutterRenderer) =
  gtk_source_gutter_remove(cast[ptr Gutter00](self.impl), cast[ptr GutterRenderer00](renderer.impl))

proc gtk_source_gutter_reorder(self: ptr Gutter00; renderer: ptr GutterRenderer00;
    position: int32) {.
    importc, libprag.}

proc reorder*(self: Gutter; renderer: GutterRenderer; position: int) =
  gtk_source_gutter_reorder(cast[ptr Gutter00](self.impl), cast[ptr GutterRenderer00](renderer.impl), int32(position))

type
  GutterRendererAlignmentMode* {.size: sizeof(cint), pure.} = enum
    cell = 0
    first = 1
    last = 2

proc gtk_source_gutter_renderer_get_alignment_mode(self: ptr GutterRenderer00): GutterRendererAlignmentMode {.
    importc, libprag.}

proc getAlignmentMode*(self: GutterRenderer): GutterRendererAlignmentMode =
  gtk_source_gutter_renderer_get_alignment_mode(cast[ptr GutterRenderer00](self.impl))

proc alignmentMode*(self: GutterRenderer): GutterRendererAlignmentMode =
  gtk_source_gutter_renderer_get_alignment_mode(cast[ptr GutterRenderer00](self.impl))

proc gtk_source_gutter_renderer_set_alignment_mode(self: ptr GutterRenderer00;
    mode: GutterRendererAlignmentMode) {.
    importc, libprag.}

proc setAlignmentMode*(self: GutterRenderer;
    mode: GutterRendererAlignmentMode) =
  gtk_source_gutter_renderer_set_alignment_mode(cast[ptr GutterRenderer00](self.impl), mode)

proc `alignmentMode=`*(self: GutterRenderer;
    mode: GutterRendererAlignmentMode) =
  gtk_source_gutter_renderer_set_alignment_mode(cast[ptr GutterRenderer00](self.impl), mode)

type
  Hover* = ref object of gobject.Object
  Hover00* = object of gobject.Object00

proc gtk_source_hover_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Hover()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_view_get_hover(self: ptr View00): ptr Hover00 {.
    importc, libprag.}

proc getHover*(self: View): Hover =
  let gobj = gtk_source_view_get_hover(cast[ptr View00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hover*(self: View): Hover =
  let gobj = gtk_source_view_get_hover(cast[ptr View00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  HoverProvider00* = object of gobject.Object00
  HoverProvider* = ref object of gobject.Object

proc gtk_source_hover_provider_populate_finish(self: ptr HoverProvider00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc populateFinish*(self: HoverProvider; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_hover_provider_populate_finish(cast[ptr HoverProvider00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gtk_source_hover_add_provider(self: ptr Hover00; provider: ptr HoverProvider00) {.
    importc, libprag.}

proc addProvider*(self: Hover; provider: HoverProvider) =
  gtk_source_hover_add_provider(cast[ptr Hover00](self.impl), cast[ptr HoverProvider00](provider.impl))

proc gtk_source_hover_remove_provider(self: ptr Hover00; provider: ptr HoverProvider00) {.
    importc, libprag.}

proc removeProvider*(self: Hover; provider: HoverProvider) =
  gtk_source_hover_remove_provider(cast[ptr Hover00](self.impl), cast[ptr HoverProvider00](provider.impl))

type
  HoverContext* = ref object of gobject.Object
  HoverContext00* = object of gobject.Object00

proc gtk_source_hover_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HoverContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_hover_context_get_bounds(self: ptr HoverContext00; begin: var gtk4.TextIter;
    `end`: var gtk4.TextIter): gboolean {.
    importc, libprag.}

proc getBounds*(self: HoverContext; begin: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    `end`: var gtk4.TextIter = cast[var gtk4.TextIter](nil)): bool =
  toBool(gtk_source_hover_context_get_bounds(cast[ptr HoverContext00](self.impl), begin, `end`))

proc gtk_source_hover_context_get_buffer(self: ptr HoverContext00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: HoverContext): Buffer =
  let gobj = gtk_source_hover_context_get_buffer(cast[ptr HoverContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: HoverContext): Buffer =
  let gobj = gtk_source_hover_context_get_buffer(cast[ptr HoverContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_hover_context_get_iter(self: ptr HoverContext00; iter: gtk4.TextIter): gboolean {.
    importc, libprag.}

proc getIter*(self: HoverContext; iter: gtk4.TextIter): bool =
  toBool(gtk_source_hover_context_get_iter(cast[ptr HoverContext00](self.impl), iter))

proc gtk_source_hover_context_get_view(self: ptr HoverContext00): ptr View00 {.
    importc, libprag.}

proc getView*(self: HoverContext): View =
  let gobj = gtk_source_hover_context_get_view(cast[ptr HoverContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: HoverContext): View =
  let gobj = gtk_source_hover_context_get_view(cast[ptr HoverContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  HoverDisplay* = ref object of gtk4.Widget
  HoverDisplay00* = object of gtk4.Widget00

proc gtk_source_hover_display_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HoverDisplay()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_hover_display_append(self: ptr HoverDisplay00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc append*(self: HoverDisplay; child: gtk4.Widget) =
  gtk_source_hover_display_append(cast[ptr HoverDisplay00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc gtk_source_hover_display_insert_after(self: ptr HoverDisplay00; child: ptr gtk4.Widget00;
    sibling: ptr gtk4.Widget00) {.
    importc, libprag.}

proc insertAfter*(self: HoverDisplay; child: gtk4.Widget;
    sibling: gtk4.Widget) =
  gtk_source_hover_display_insert_after(cast[ptr HoverDisplay00](self.impl), cast[ptr gtk4.Widget00](child.impl), cast[ptr gtk4.Widget00](sibling.impl))

proc gtk_source_hover_display_prepend(self: ptr HoverDisplay00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc prepend*(self: HoverDisplay; child: gtk4.Widget) =
  gtk_source_hover_display_prepend(cast[ptr HoverDisplay00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc gtk_source_hover_display_remove(self: ptr HoverDisplay00; child: ptr gtk4.Widget00) {.
    importc, libprag.}

proc remove*(self: HoverDisplay; child: gtk4.Widget) =
  gtk_source_hover_display_remove(cast[ptr HoverDisplay00](self.impl), cast[ptr gtk4.Widget00](child.impl))

proc gtk_source_hover_provider_populate_async(self: ptr HoverProvider00;
    context: ptr HoverContext00; display: ptr HoverDisplay00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc populateAsync*(self: HoverProvider; context: HoverContext;
    display: HoverDisplay; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  gtk_source_hover_provider_populate_async(cast[ptr HoverProvider00](self.impl), cast[ptr HoverContext00](context.impl), cast[ptr HoverDisplay00](display.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

type
  SpaceDrawer* = ref object of gobject.Object
  SpaceDrawer00* = object of gobject.Object00

proc gtk_source_space_drawer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SpaceDrawer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_space_drawer_new(): ptr SpaceDrawer00 {.
    importc, libprag.}

proc newSpaceDrawer*(): SpaceDrawer =
  let gobj = gtk_source_space_drawer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSpaceDrawer*(tdesc: typedesc): tdesc =
  assert(result is SpaceDrawer)
  let gobj = gtk_source_space_drawer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSpaceDrawer*[T](result: var T) {.deprecated.} =
  assert(result is SpaceDrawer)
  let gobj = gtk_source_space_drawer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_space_drawer_bind_matrix_setting(self: ptr SpaceDrawer00;
    settings: ptr gio.Settings00; key: cstring; flags: gio.SettingsBindFlags) {.
    importc, libprag.}

proc bindMatrixSetting*(self: SpaceDrawer; settings: gio.Settings;
    key: cstring; flags: gio.SettingsBindFlags) =
  gtk_source_space_drawer_bind_matrix_setting(cast[ptr SpaceDrawer00](self.impl), cast[ptr gio.Settings00](settings.impl), key, flags)

proc gtk_source_space_drawer_get_enable_matrix(self: ptr SpaceDrawer00): gboolean {.
    importc, libprag.}

proc getEnableMatrix*(self: SpaceDrawer): bool =
  toBool(gtk_source_space_drawer_get_enable_matrix(cast[ptr SpaceDrawer00](self.impl)))

proc enableMatrix*(self: SpaceDrawer): bool =
  toBool(gtk_source_space_drawer_get_enable_matrix(cast[ptr SpaceDrawer00](self.impl)))

proc gtk_source_space_drawer_get_matrix(self: ptr SpaceDrawer00): ptr glib.Variant00 {.
    importc, libprag.}

proc getMatrix*(self: SpaceDrawer): glib.Variant =
  fnew(result, finalizerunref)
  result.impl = gtk_source_space_drawer_get_matrix(cast[ptr SpaceDrawer00](self.impl))

proc matrix*(self: SpaceDrawer): glib.Variant =
  fnew(result, finalizerunref)
  result.impl = gtk_source_space_drawer_get_matrix(cast[ptr SpaceDrawer00](self.impl))

proc gtk_source_space_drawer_set_enable_matrix(self: ptr SpaceDrawer00; enableMatrix: gboolean) {.
    importc, libprag.}

proc setEnableMatrix*(self: SpaceDrawer; enableMatrix: bool = true) =
  gtk_source_space_drawer_set_enable_matrix(cast[ptr SpaceDrawer00](self.impl), gboolean(enableMatrix))

proc `enableMatrix=`*(self: SpaceDrawer; enableMatrix: bool) =
  gtk_source_space_drawer_set_enable_matrix(cast[ptr SpaceDrawer00](self.impl), gboolean(enableMatrix))

proc gtk_source_space_drawer_set_matrix(self: ptr SpaceDrawer00; matrix: ptr glib.Variant00) {.
    importc, libprag.}

proc setMatrix*(self: SpaceDrawer; matrix: glib.Variant = nil) =
  gtk_source_space_drawer_set_matrix(cast[ptr SpaceDrawer00](self.impl), if matrix.isNil: nil else: cast[ptr glib.Variant00](matrix.impl))

proc `matrix=`*(self: SpaceDrawer; matrix: glib.Variant = nil) =
  gtk_source_space_drawer_set_matrix(cast[ptr SpaceDrawer00](self.impl), if matrix.isNil: nil else: cast[ptr glib.Variant00](matrix.impl))

proc gtk_source_view_get_space_drawer(self: ptr View00): ptr SpaceDrawer00 {.
    importc, libprag.}

proc getSpaceDrawer*(self: View): SpaceDrawer =
  let gobj = gtk_source_view_get_space_drawer(cast[ptr View00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc spaceDrawer*(self: View): SpaceDrawer =
  let gobj = gtk_source_view_get_space_drawer(cast[ptr View00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SpaceLocationFlags* {.size: sizeof(cint), pure.} = enum
    none = 0
    leading = 1
    insideText = 2
    trailing = 4
    all = 7

type
  SpaceTypeFlags* {.size: sizeof(cint), pure.} = enum
    none = 0
    space = 1
    tab = 2
    newline = 4
    nbsp = 8
    all = 15

proc gtk_source_space_drawer_get_types_for_locations(self: ptr SpaceDrawer00;
    locations: SpaceLocationFlags): SpaceTypeFlags {.
    importc, libprag.}

proc getTypesForLocations*(self: SpaceDrawer; locations: SpaceLocationFlags): SpaceTypeFlags =
  gtk_source_space_drawer_get_types_for_locations(cast[ptr SpaceDrawer00](self.impl), locations)

proc gtk_source_space_drawer_set_types_for_locations(self: ptr SpaceDrawer00;
    locations: SpaceLocationFlags; types: SpaceTypeFlags) {.
    importc, libprag.}

proc setTypesForLocations*(self: SpaceDrawer; locations: SpaceLocationFlags;
    types: SpaceTypeFlags) =
  gtk_source_space_drawer_set_types_for_locations(cast[ptr SpaceDrawer00](self.impl), locations, types)

type
  Indenter00* = object of gobject.Object00
  Indenter* = ref object of gobject.Object

proc gtk_source_indenter_indent(self: ptr Indenter00; view: ptr View00; iter: var gtk4.TextIter) {.
    importc, libprag.}

proc indent*(self: Indenter; view: View; iter: var gtk4.TextIter) =
  gtk_source_indenter_indent(cast[ptr Indenter00](self.impl), cast[ptr View00](view.impl), iter)

proc gtk_source_indenter_is_trigger(self: ptr Indenter00; view: ptr View00;
    location: gtk4.TextIter; state: gdk4.ModifierType; keyval: uint32): gboolean {.
    importc, libprag.}

proc isTrigger*(self: Indenter; view: View; location: gtk4.TextIter;
    state: gdk4.ModifierType; keyval: int): bool =
  toBool(gtk_source_indenter_is_trigger(cast[ptr Indenter00](self.impl), cast[ptr View00](view.impl), location, state, uint32(keyval)))

proc gtk_source_view_get_indenter(self: ptr View00): ptr Indenter00 {.
    importc, libprag.}

proc getIndenter*(self: View): Indenter =
  let gobj = gtk_source_view_get_indenter(cast[ptr View00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc indenter*(self: View): Indenter =
  let gobj = gtk_source_view_get_indenter(cast[ptr View00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_view_set_indenter(self: ptr View00; indenter: ptr Indenter00) {.
    importc, libprag.}

proc setIndenter*(self: View; indenter: Indenter = nil) =
  gtk_source_view_set_indenter(cast[ptr View00](self.impl), if indenter.isNil: nil else: cast[ptr Indenter00](indenter.impl))

proc `indenter=`*(self: View; indenter: Indenter = nil) =
  gtk_source_view_set_indenter(cast[ptr View00](self.impl), if indenter.isNil: nil else: cast[ptr Indenter00](indenter.impl))

type
  MarkAttributes* = ref object of gobject.Object
  MarkAttributes00* = object of gobject.Object00

proc gtk_source_mark_attributes_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MarkAttributes()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scQueryTooltipMarkup*(self: MarkAttributes;  p: proc (self: ptr MarkAttributes00; mark: ptr Mark00; xdata: pointer): cstring {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "query-tooltip-markup", cast[GCallback](p), xdata, nil, cf)

proc scQueryTooltipText*(self: MarkAttributes;  p: proc (self: ptr MarkAttributes00; mark: ptr Mark00; xdata: pointer): cstring {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "query-tooltip-text", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_mark_attributes_new(): ptr MarkAttributes00 {.
    importc, libprag.}

proc newMarkAttributes*(): MarkAttributes =
  let gobj = gtk_source_mark_attributes_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newMarkAttributes*(tdesc: typedesc): tdesc =
  assert(result is MarkAttributes)
  let gobj = gtk_source_mark_attributes_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMarkAttributes*[T](result: var T) {.deprecated.} =
  assert(result is MarkAttributes)
  let gobj = gtk_source_mark_attributes_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_mark_attributes_get_background(self: ptr MarkAttributes00;
    background: var gdk4.RGBA): gboolean {.
    importc, libprag.}

proc getBackground*(self: MarkAttributes; background: var gdk4.RGBA): bool =
  toBool(gtk_source_mark_attributes_get_background(cast[ptr MarkAttributes00](self.impl), background))

proc gtk_source_mark_attributes_get_gicon(self: ptr MarkAttributes00): ptr gio.Icon00 {.
    importc, libprag.}

proc getGicon*(self: MarkAttributes): gio.Icon =
  let gobj = gtk_source_mark_attributes_get_gicon(cast[ptr MarkAttributes00](self.impl))
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

proc gicon*(self: MarkAttributes): gio.Icon =
  let gobj = gtk_source_mark_attributes_get_gicon(cast[ptr MarkAttributes00](self.impl))
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

proc gtk_source_mark_attributes_get_icon_name(self: ptr MarkAttributes00): cstring {.
    importc, libprag.}

proc getIconName*(self: MarkAttributes): string =
  result = $gtk_source_mark_attributes_get_icon_name(cast[ptr MarkAttributes00](self.impl))

proc iconName*(self: MarkAttributes): string =
  result = $gtk_source_mark_attributes_get_icon_name(cast[ptr MarkAttributes00](self.impl))

proc gtk_source_mark_attributes_get_pixbuf(self: ptr MarkAttributes00): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc getPixbuf*(self: MarkAttributes): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_mark_attributes_get_pixbuf(cast[ptr MarkAttributes00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pixbuf*(self: MarkAttributes): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_mark_attributes_get_pixbuf(cast[ptr MarkAttributes00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_mark_attributes_get_tooltip_markup(self: ptr MarkAttributes00;
    mark: ptr Mark00): cstring {.
    importc, libprag.}

proc getTooltipMarkup*(self: MarkAttributes;
    mark: Mark): string =
  let resul0 = gtk_source_mark_attributes_get_tooltip_markup(cast[ptr MarkAttributes00](self.impl), cast[ptr Mark00](mark.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_mark_attributes_get_tooltip_text(self: ptr MarkAttributes00;
    mark: ptr Mark00): cstring {.
    importc, libprag.}

proc getTooltipText*(self: MarkAttributes; mark: Mark): string =
  let resul0 = gtk_source_mark_attributes_get_tooltip_text(cast[ptr MarkAttributes00](self.impl), cast[ptr Mark00](mark.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_mark_attributes_render_icon(self: ptr MarkAttributes00; widget: ptr gtk4.Widget00;
    size: int32): ptr gdk4.Paintable00 {.
    importc, libprag.}

proc renderIcon*(self: MarkAttributes; widget: gtk4.Widget;
    size: int): gdk4.Paintable =
  let gobj = gtk_source_mark_attributes_render_icon(cast[ptr MarkAttributes00](self.impl), cast[ptr gtk4.Widget00](widget.impl), int32(size))
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

proc gtk_source_mark_attributes_set_background(self: ptr MarkAttributes00;
    background: gdk4.RGBA) {.
    importc, libprag.}

proc setBackground*(self: MarkAttributes; background: gdk4.RGBA) =
  gtk_source_mark_attributes_set_background(cast[ptr MarkAttributes00](self.impl), background)

proc `background=`*(self: MarkAttributes; background: gdk4.RGBA) =
  gtk_source_mark_attributes_set_background(cast[ptr MarkAttributes00](self.impl), background)

proc gtk_source_mark_attributes_set_gicon(self: ptr MarkAttributes00; gicon: ptr gio.Icon00) {.
    importc, libprag.}

proc setGicon*(self: MarkAttributes; gicon: gio.Icon) =
  gtk_source_mark_attributes_set_gicon(cast[ptr MarkAttributes00](self.impl), cast[ptr gio.Icon00](gicon.impl))

proc `gicon=`*(self: MarkAttributes; gicon: gio.Icon) =
  gtk_source_mark_attributes_set_gicon(cast[ptr MarkAttributes00](self.impl), cast[ptr gio.Icon00](gicon.impl))

proc gtk_source_mark_attributes_set_icon_name(self: ptr MarkAttributes00;
    iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: MarkAttributes; iconName: cstring) =
  gtk_source_mark_attributes_set_icon_name(cast[ptr MarkAttributes00](self.impl), iconName)

proc `iconName=`*(self: MarkAttributes; iconName: cstring) =
  gtk_source_mark_attributes_set_icon_name(cast[ptr MarkAttributes00](self.impl), iconName)

proc gtk_source_mark_attributes_set_pixbuf(self: ptr MarkAttributes00; pixbuf: ptr gdkpixbuf.Pixbuf00) {.
    importc, libprag.}

proc setPixbuf*(self: MarkAttributes; pixbuf: gdkpixbuf.Pixbuf) =
  gtk_source_mark_attributes_set_pixbuf(cast[ptr MarkAttributes00](self.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))

proc `pixbuf=`*(self: MarkAttributes; pixbuf: gdkpixbuf.Pixbuf) =
  gtk_source_mark_attributes_set_pixbuf(cast[ptr MarkAttributes00](self.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))

proc gtk_source_view_get_mark_attributes(self: ptr View00; category: cstring;
    priority: ptr int32): ptr MarkAttributes00 {.
    importc, libprag.}

proc getMarkAttributes*(self: View; category: cstring; priority: ptr int32): MarkAttributes =
  let gobj = gtk_source_view_get_mark_attributes(cast[ptr View00](self.impl), category, priority)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_view_set_mark_attributes(self: ptr View00; category: cstring;
    attributes: ptr MarkAttributes00; priority: int32) {.
    importc, libprag.}

proc setMarkAttributes*(self: View; category: cstring; attributes: MarkAttributes;
    priority: int) =
  gtk_source_view_set_mark_attributes(cast[ptr View00](self.impl), category, cast[ptr MarkAttributes00](attributes.impl), int32(priority))

type
  SmartHomeEndType* {.size: sizeof(cint), pure.} = enum
    disabled = 0
    before = 1
    after = 2
    always = 3

proc gtk_source_view_get_smart_home_end(self: ptr View00): SmartHomeEndType {.
    importc, libprag.}

proc getSmartHomeEnd*(self: View): SmartHomeEndType =
  gtk_source_view_get_smart_home_end(cast[ptr View00](self.impl))

proc smartHomeEnd*(self: View): SmartHomeEndType =
  gtk_source_view_get_smart_home_end(cast[ptr View00](self.impl))

proc gtk_source_view_set_smart_home_end(self: ptr View00; smartHomeEnd: SmartHomeEndType) {.
    importc, libprag.}

proc setSmartHomeEnd*(self: View; smartHomeEnd: SmartHomeEndType) =
  gtk_source_view_set_smart_home_end(cast[ptr View00](self.impl), smartHomeEnd)

proc `smartHomeEnd=`*(self: View; smartHomeEnd: SmartHomeEndType) =
  gtk_source_view_set_smart_home_end(cast[ptr View00](self.impl), smartHomeEnd)

type
  CompletionWords* = ref object of gobject.Object
  CompletionWords00* = object of gobject.Object00

proc gtk_source_completion_words_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CompletionWords()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_completion_words_new(title: cstring): ptr CompletionWords00 {.
    importc, libprag.}

proc newCompletionWords*(title: cstring = nil): CompletionWords =
  let gobj = gtk_source_completion_words_new(title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCompletionWords*(tdesc: typedesc; title: cstring = nil): tdesc =
  assert(result is CompletionWords)
  let gobj = gtk_source_completion_words_new(title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCompletionWords*[T](result: var T; title: cstring = nil) {.deprecated.} =
  assert(result is CompletionWords)
  let gobj = gtk_source_completion_words_new(title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_words_register(self: ptr CompletionWords00; buffer: ptr gtk4.TextBuffer00) {.
    importc, libprag.}

proc registerCompletionWords*(self: CompletionWords; buffer: gtk4.TextBuffer) =
  gtk_source_completion_words_register(cast[ptr CompletionWords00](self.impl), cast[ptr gtk4.TextBuffer00](buffer.impl))

proc gtk_source_completion_words_unregister(self: ptr CompletionWords00;
    buffer: ptr gtk4.TextBuffer00) {.
    importc, libprag.}

proc unregister*(self: CompletionWords; buffer: gtk4.TextBuffer) =
  gtk_source_completion_words_unregister(cast[ptr CompletionWords00](self.impl), cast[ptr gtk4.TextBuffer00](buffer.impl))

type
  CompletionSnippets* = ref object of gobject.Object
  CompletionSnippets00* = object of gobject.Object00

proc gtk_source_completion_snippets_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CompletionSnippets()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_completion_snippets_new(): ptr CompletionSnippets00 {.
    importc, libprag.}

proc newCompletionSnippets*(): CompletionSnippets =
  let gobj = gtk_source_completion_snippets_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCompletionSnippets*(tdesc: typedesc): tdesc =
  assert(result is CompletionSnippets)
  let gobj = gtk_source_completion_snippets_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCompletionSnippets*[T](result: var T) {.deprecated.} =
  assert(result is CompletionSnippets)
  let gobj = gtk_source_completion_snippets_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_provider_activate(self: ptr CompletionProvider00;
    context: ptr CompletionContext00; proposal: ptr CompletionProposal00) {.
    importc, libprag.}

proc activate*(self: CompletionProvider | CompletionWords | CompletionSnippets;
    context: CompletionContext; proposal: CompletionProposal) =
  gtk_source_completion_provider_activate(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionContext00](context.impl), cast[ptr CompletionProposal00](proposal.impl))

proc gtk_source_completion_provider_display(self: ptr CompletionProvider00;
    context: ptr CompletionContext00; proposal: ptr CompletionProposal00; cell: ptr CompletionCell00) {.
    importc, libprag.}

proc display*(self: CompletionProvider | CompletionWords | CompletionSnippets;
    context: CompletionContext; proposal: CompletionProposal; cell: CompletionCell) =
  gtk_source_completion_provider_display(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionContext00](context.impl), cast[ptr CompletionProposal00](proposal.impl), cast[ptr CompletionCell00](cell.impl))

proc gtk_source_completion_provider_get_priority(self: ptr CompletionProvider00;
    context: ptr CompletionContext00): int32 {.
    importc, libprag.}

proc getPriority*(self: CompletionProvider | CompletionWords | CompletionSnippets;
    context: CompletionContext): int =
  int(gtk_source_completion_provider_get_priority(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionContext00](context.impl)))

proc gtk_source_completion_provider_get_title(self: ptr CompletionProvider00): cstring {.
    importc, libprag.}

proc getTitle*(self: CompletionProvider | CompletionWords | CompletionSnippets): string =
  let resul0 = gtk_source_completion_provider_get_title(cast[ptr CompletionProvider00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc title*(self: CompletionProvider | CompletionWords | CompletionSnippets): string =
  let resul0 = gtk_source_completion_provider_get_title(cast[ptr CompletionProvider00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gtk_source_completion_provider_is_trigger(self: ptr CompletionProvider00;
    iter: gtk4.TextIter; ch: gunichar): gboolean {.
    importc, libprag.}

proc isTrigger*(self: CompletionProvider | CompletionWords | CompletionSnippets;
    iter: gtk4.TextIter; ch: gunichar): bool =
  toBool(gtk_source_completion_provider_is_trigger(cast[ptr CompletionProvider00](self.impl), iter, ch))

proc gtk_source_completion_provider_key_activates(self: ptr CompletionProvider00;
    context: ptr CompletionContext00; proposal: ptr CompletionProposal00; keyval: uint32;
    state: gdk4.ModifierType): gboolean {.
    importc, libprag.}

proc keyActivates*(self: CompletionProvider | CompletionWords | CompletionSnippets;
    context: CompletionContext; proposal: CompletionProposal; keyval: int;
    state: gdk4.ModifierType): bool =
  toBool(gtk_source_completion_provider_key_activates(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionContext00](context.impl), cast[ptr CompletionProposal00](proposal.impl), uint32(keyval), state))

proc gtk_source_completion_provider_list_alternates(self: ptr CompletionProvider00;
    context: ptr CompletionContext00; proposal: ptr CompletionProposal00): ptr PtrArray00 {.
    importc, libprag.}

proc listAlternates*(self: CompletionProvider | CompletionWords | CompletionSnippets;
    context: CompletionContext; proposal: CompletionProposal): ptr PtrArray00 =
  gtk_source_completion_provider_list_alternates(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionContext00](context.impl), cast[ptr CompletionProposal00](proposal.impl))

proc gtk_source_completion_provider_populate_async(self: ptr CompletionProvider00;
    context: ptr CompletionContext00; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc populateAsync*(self: CompletionProvider | CompletionWords | CompletionSnippets;
    context: CompletionContext; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  gtk_source_completion_provider_populate_async(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionContext00](context.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gtk_source_completion_provider_populate_finish(self: ptr CompletionProvider00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr gio.ListModel00 {.
    importc, libprag.}

proc populateFinish*(self: CompletionProvider | CompletionWords | CompletionSnippets;
    resu: gio.AsyncResult): gio.ListModel =
  var gerror: ptr glib.Error
  let gobj = gtk_source_completion_provider_populate_finish(cast[ptr CompletionProvider00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
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

proc gtk_source_completion_provider_refilter(self: ptr CompletionProvider00;
    context: ptr CompletionContext00; model: ptr gio.ListModel00) {.
    importc, libprag.}

proc refilter*(self: CompletionProvider | CompletionWords | CompletionSnippets;
    context: CompletionContext; model: gio.ListModel) =
  gtk_source_completion_provider_refilter(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionContext00](context.impl), cast[ptr gio.ListModel00](model.impl))

proc gtk_source_completion_add_provider(self: ptr Completion00; provider: ptr CompletionProvider00) {.
    importc, libprag.}

proc addProvider*(self: Completion; provider: CompletionProvider | CompletionWords | CompletionSnippets) =
  gtk_source_completion_add_provider(cast[ptr Completion00](self.impl), cast[ptr CompletionProvider00](provider.impl))

proc gtk_source_completion_remove_provider(self: ptr Completion00; provider: ptr CompletionProvider00) {.
    importc, libprag.}

proc removeProvider*(self: Completion; provider: CompletionProvider | CompletionWords | CompletionSnippets) =
  gtk_source_completion_remove_provider(cast[ptr Completion00](self.impl), cast[ptr CompletionProvider00](provider.impl))

proc gtk_source_completion_context_get_proposals_for_provider(self: ptr CompletionContext00;
    provider: ptr CompletionProvider00): ptr gio.ListModel00 {.
    importc, libprag.}

proc getProposalsForProvider*(self: CompletionContext;
    provider: CompletionProvider | CompletionWords | CompletionSnippets): gio.ListModel =
  let gobj = gtk_source_completion_context_get_proposals_for_provider(cast[ptr CompletionContext00](self.impl), cast[ptr CompletionProvider00](provider.impl))
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

proc gtk_source_completion_context_set_proposals_for_provider(self: ptr CompletionContext00;
    provider: ptr CompletionProvider00; results: ptr gio.ListModel00) {.
    importc, libprag.}

proc setProposalsForProvider*(self: CompletionContext;
    provider: CompletionProvider | CompletionWords | CompletionSnippets; results: gio.ListModel = nil) =
  gtk_source_completion_context_set_proposals_for_provider(cast[ptr CompletionContext00](self.impl), cast[ptr CompletionProvider00](provider.impl), if results.isNil: nil else: cast[ptr gio.ListModel00](results.impl))

type
  CompressionType* {.size: sizeof(cint), pure.} = enum
    none = 0
    gzip = 1

type
  Encoding00* {.pure.} = object
  Encoding* = ref object
    impl*: ptr Encoding00
    ignoreFinalizer*: bool

proc gtk_source_encoding_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGtkSourceEncoding*(self: Encoding) =
  if not self.ignoreFinalizer:
    boxedFree(gtk_source_encoding_get_type(), cast[ptr Encoding00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Encoding()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gtk_source_encoding_get_type(), cast[ptr Encoding00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Encoding) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGtkSourceEncoding)

proc gtk_source_encoding_free(self: ptr Encoding00) {.
    importc, libprag.}

proc free*(self: Encoding) =
  gtk_source_encoding_free(cast[ptr Encoding00](self.impl))

proc finalizerfree*(self: Encoding) =
  if not self.ignoreFinalizer:
    gtk_source_encoding_free(cast[ptr Encoding00](self.impl))

proc gtk_source_encoding_copy(self: ptr Encoding00): ptr Encoding00 {.
    importc, libprag.}

proc copy*(self: Encoding): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_encoding_copy(cast[ptr Encoding00](self.impl))

proc gtk_source_encoding_get_charset(self: ptr Encoding00): cstring {.
    importc, libprag.}

proc getCharset*(self: Encoding): string =
  result = $gtk_source_encoding_get_charset(cast[ptr Encoding00](self.impl))

proc charset*(self: Encoding): string =
  result = $gtk_source_encoding_get_charset(cast[ptr Encoding00](self.impl))

proc gtk_source_encoding_get_name(self: ptr Encoding00): cstring {.
    importc, libprag.}

proc getName*(self: Encoding): string =
  result = $gtk_source_encoding_get_name(cast[ptr Encoding00](self.impl))

proc name*(self: Encoding): string =
  result = $gtk_source_encoding_get_name(cast[ptr Encoding00](self.impl))

proc gtk_source_encoding_to_string(self: ptr Encoding00): cstring {.
    importc, libprag.}

proc toString*(self: Encoding): string =
  let resul0 = gtk_source_encoding_to_string(cast[ptr Encoding00](self.impl))
  result = $resul0
  cogfree(resul0)

proc getAll*(): ptr glib.SList {.
    importc: "gtk_source_encoding_get_all", libprag.}

proc gtk_source_encoding_get_current(): ptr Encoding00 {.
    importc, libprag.}

proc getCurrent*(): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_encoding_get_current()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc getDefaultCandidates*(): ptr glib.SList {.
    importc: "gtk_source_encoding_get_default_candidates", libprag.}

proc gtk_source_encoding_get_from_charset(charset: cstring): ptr Encoding00 {.
    importc, libprag.}

proc getFromCharset*(charset: cstring): Encoding =
  let impl0 = gtk_source_encoding_get_from_charset(charset)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), impl0))

proc fromCharset*(charset: cstring): Encoding =
  let impl0 = gtk_source_encoding_get_from_charset(charset)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), impl0))

proc gtk_source_encoding_get_utf8(): ptr Encoding00 {.
    importc, libprag.}

proc getUtf8*(): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_encoding_get_utf8()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

type
  File* = ref object of gobject.Object
  File00* = object of gobject.Object00

proc gtk_source_file_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(File()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_file_new(): ptr File00 {.
    importc, libprag.}

proc newFile*(): File =
  let gobj = gtk_source_file_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFile*(tdesc: typedesc): tdesc =
  assert(result is File)
  let gobj = gtk_source_file_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFile*[T](result: var T) {.deprecated.} =
  assert(result is File)
  let gobj = gtk_source_file_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_check_file_on_disk(self: ptr File00) {.
    importc, libprag.}

proc checkFileOnDisk*(self: File) =
  gtk_source_file_check_file_on_disk(cast[ptr File00](self.impl))

proc gtk_source_file_get_compression_type(self: ptr File00): CompressionType {.
    importc, libprag.}

proc getCompressionType*(self: File): CompressionType =
  gtk_source_file_get_compression_type(cast[ptr File00](self.impl))

proc compressionType*(self: File): CompressionType =
  gtk_source_file_get_compression_type(cast[ptr File00](self.impl))

proc gtk_source_file_get_encoding(self: ptr File00): ptr Encoding00 {.
    importc, libprag.}

proc getEncoding*(self: File): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_get_encoding(cast[ptr File00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc encoding*(self: File): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_get_encoding(cast[ptr File00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc gtk_source_file_get_location(self: ptr File00): ptr gio.GFile00 {.
    importc, libprag.}

proc getLocation*(self: File): gio.GFile =
  let gobj = gtk_source_file_get_location(cast[ptr File00](self.impl))
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

proc location*(self: File): gio.GFile =
  let gobj = gtk_source_file_get_location(cast[ptr File00](self.impl))
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

proc gtk_source_file_is_deleted(self: ptr File00): gboolean {.
    importc, libprag.}

proc isDeleted*(self: File): bool =
  toBool(gtk_source_file_is_deleted(cast[ptr File00](self.impl)))

proc gtk_source_file_is_externally_modified(self: ptr File00): gboolean {.
    importc, libprag.}

proc isExternallyModified*(self: File): bool =
  toBool(gtk_source_file_is_externally_modified(cast[ptr File00](self.impl)))

proc gtk_source_file_is_local(self: ptr File00): gboolean {.
    importc, libprag.}

proc isLocal*(self: File): bool =
  toBool(gtk_source_file_is_local(cast[ptr File00](self.impl)))

proc gtk_source_file_is_readonly(self: ptr File00): gboolean {.
    importc, libprag.}

proc isReadonly*(self: File): bool =
  toBool(gtk_source_file_is_readonly(cast[ptr File00](self.impl)))

proc gtk_source_file_set_location(self: ptr File00; location: ptr gio.GFile00) {.
    importc, libprag.}

proc setLocation*(self: File; location: gio.GFile = nil) =
  gtk_source_file_set_location(cast[ptr File00](self.impl), if location.isNil: nil else: cast[ptr gio.GFile00](location.impl))

proc `location=`*(self: File; location: gio.GFile = nil) =
  gtk_source_file_set_location(cast[ptr File00](self.impl), if location.isNil: nil else: cast[ptr gio.GFile00](location.impl))

type
  NewlineType* {.size: sizeof(cint), pure.} = enum
    lf = 0
    cr = 1
    crLf = 2

proc gtk_source_file_get_newline_type(self: ptr File00): NewlineType {.
    importc, libprag.}

proc getNewlineType*(self: File): NewlineType =
  gtk_source_file_get_newline_type(cast[ptr File00](self.impl))

proc newlineType*(self: File): NewlineType =
  gtk_source_file_get_newline_type(cast[ptr File00](self.impl))

type
  FileLoader* = ref object of gobject.Object
  FileLoader00* = object of gobject.Object00

proc gtk_source_file_loader_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FileLoader()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_file_loader_new(buffer: ptr Buffer00; file: ptr File00): ptr FileLoader00 {.
    importc, libprag.}

proc newFileLoader*(buffer: Buffer; file: File): FileLoader =
  let gobj = gtk_source_file_loader_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFileLoader*(tdesc: typedesc; buffer: Buffer; file: File): tdesc =
  assert(result is FileLoader)
  let gobj = gtk_source_file_loader_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileLoader*[T](result: var T; buffer: Buffer; file: File) {.deprecated.} =
  assert(result is FileLoader)
  let gobj = gtk_source_file_loader_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_loader_new_from_stream(buffer: ptr Buffer00; file: ptr File00;
    stream: ptr gio.InputStream00): ptr FileLoader00 {.
    importc, libprag.}

proc newFileLoaderFromStream*(buffer: Buffer; file: File; stream: gio.InputStream): FileLoader =
  let gobj = gtk_source_file_loader_new_from_stream(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.InputStream00](stream.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFileLoaderFromStream*(tdesc: typedesc; buffer: Buffer; file: File; stream: gio.InputStream): tdesc =
  assert(result is FileLoader)
  let gobj = gtk_source_file_loader_new_from_stream(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.InputStream00](stream.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileLoaderFromStream*[T](result: var T; buffer: Buffer; file: File; stream: gio.InputStream) {.deprecated.} =
  assert(result is FileLoader)
  let gobj = gtk_source_file_loader_new_from_stream(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.InputStream00](stream.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_loader_get_buffer(self: ptr FileLoader00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: FileLoader): Buffer =
  let gobj = gtk_source_file_loader_get_buffer(cast[ptr FileLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: FileLoader): Buffer =
  let gobj = gtk_source_file_loader_get_buffer(cast[ptr FileLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_loader_get_compression_type(self: ptr FileLoader00): CompressionType {.
    importc, libprag.}

proc getCompressionType*(self: FileLoader): CompressionType =
  gtk_source_file_loader_get_compression_type(cast[ptr FileLoader00](self.impl))

proc compressionType*(self: FileLoader): CompressionType =
  gtk_source_file_loader_get_compression_type(cast[ptr FileLoader00](self.impl))

proc gtk_source_file_loader_get_encoding(self: ptr FileLoader00): ptr Encoding00 {.
    importc, libprag.}

proc getEncoding*(self: FileLoader): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_loader_get_encoding(cast[ptr FileLoader00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc encoding*(self: FileLoader): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_loader_get_encoding(cast[ptr FileLoader00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc gtk_source_file_loader_get_file(self: ptr FileLoader00): ptr File00 {.
    importc, libprag.}

proc getFile*(self: FileLoader): File =
  let gobj = gtk_source_file_loader_get_file(cast[ptr FileLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc file*(self: FileLoader): File =
  let gobj = gtk_source_file_loader_get_file(cast[ptr FileLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_loader_get_input_stream(self: ptr FileLoader00): ptr gio.InputStream00 {.
    importc, libprag.}

proc getInputStream*(self: FileLoader): gio.InputStream =
  let gobj = gtk_source_file_loader_get_input_stream(cast[ptr FileLoader00](self.impl))
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

proc inputStream*(self: FileLoader): gio.InputStream =
  let gobj = gtk_source_file_loader_get_input_stream(cast[ptr FileLoader00](self.impl))
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

proc gtk_source_file_loader_get_location(self: ptr FileLoader00): ptr gio.GFile00 {.
    importc, libprag.}

proc getLocation*(self: FileLoader): gio.GFile =
  let gobj = gtk_source_file_loader_get_location(cast[ptr FileLoader00](self.impl))
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

proc location*(self: FileLoader): gio.GFile =
  let gobj = gtk_source_file_loader_get_location(cast[ptr FileLoader00](self.impl))
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

proc gtk_source_file_loader_get_newline_type(self: ptr FileLoader00): NewlineType {.
    importc, libprag.}

proc getNewlineType*(self: FileLoader): NewlineType =
  gtk_source_file_loader_get_newline_type(cast[ptr FileLoader00](self.impl))

proc newlineType*(self: FileLoader): NewlineType =
  gtk_source_file_loader_get_newline_type(cast[ptr FileLoader00](self.impl))

proc gtk_source_file_loader_load_async(self: ptr FileLoader00; ioPriority: int32;
    cancellable: ptr gio.Cancellable00; progressCallback: FileProgressCallback;
    progressCallbackData: pointer; progressCallbackNotify: DestroyNotify; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc loadAsync*(self: FileLoader; ioPriority: int;
    cancellable: gio.Cancellable = nil; progressCallback: FileProgressCallback;
    progressCallbackData: pointer; progressCallbackNotify: DestroyNotify; callback: AsyncReadyCallback;
    userData: pointer) =
  gtk_source_file_loader_load_async(cast[ptr FileLoader00](self.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), progressCallback, progressCallbackData, progressCallbackNotify, callback, userData)

proc gtk_source_file_loader_load_finish(self: ptr FileLoader00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc loadFinish*(self: FileLoader; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_file_loader_load_finish(cast[ptr FileLoader00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gtk_source_file_loader_set_candidate_encodings(self: ptr FileLoader00;
    candidateEncodings: ptr glib.SList) {.
    importc, libprag.}

proc setCandidateEncodings*(self: FileLoader; candidateEncodings: seq[Encoding]) =
  var tempResGL = seq2GSList(candidateEncodings)
  gtk_source_file_loader_set_candidate_encodings(cast[ptr FileLoader00](self.impl), tempResGL)
  g_slist_free(tempResGL)

proc `candidateEncodings=`*(self: FileLoader; candidateEncodings: seq[Encoding]) =
  var tempResGL = seq2GSList(candidateEncodings)
  gtk_source_file_loader_set_candidate_encodings(cast[ptr FileLoader00](self.impl), tempResGL)
  g_slist_free(tempResGL)

type
  FileLoaderError* {.size: sizeof(cint), pure.} = enum
    tooBig = 0
    encodingAutoDetectionFailed = 1
    conversionFallback = 2

type
  FileSaver* = ref object of gobject.Object
  FileSaver00* = object of gobject.Object00

proc gtk_source_file_saver_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FileSaver()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_file_saver_new(buffer: ptr Buffer00; file: ptr File00): ptr FileSaver00 {.
    importc, libprag.}

proc newFileSaver*(buffer: Buffer; file: File): FileSaver =
  let gobj = gtk_source_file_saver_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFileSaver*(tdesc: typedesc; buffer: Buffer; file: File): tdesc =
  assert(result is FileSaver)
  let gobj = gtk_source_file_saver_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileSaver*[T](result: var T; buffer: Buffer; file: File) {.deprecated.} =
  assert(result is FileSaver)
  let gobj = gtk_source_file_saver_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_saver_new_with_target(buffer: ptr Buffer00; file: ptr File00;
    targetLocation: ptr gio.GFile00): ptr FileSaver00 {.
    importc, libprag.}

proc newFileSaverWithTarget*(buffer: Buffer; file: File; targetLocation: gio.GFile): FileSaver =
  let gobj = gtk_source_file_saver_new_with_target(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.GFile00](targetLocation.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFileSaverWithTarget*(tdesc: typedesc; buffer: Buffer; file: File; targetLocation: gio.GFile): tdesc =
  assert(result is FileSaver)
  let gobj = gtk_source_file_saver_new_with_target(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.GFile00](targetLocation.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileSaverWithTarget*[T](result: var T; buffer: Buffer; file: File; targetLocation: gio.GFile) {.deprecated.} =
  assert(result is FileSaver)
  let gobj = gtk_source_file_saver_new_with_target(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.GFile00](targetLocation.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_saver_get_buffer(self: ptr FileSaver00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: FileSaver): Buffer =
  let gobj = gtk_source_file_saver_get_buffer(cast[ptr FileSaver00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: FileSaver): Buffer =
  let gobj = gtk_source_file_saver_get_buffer(cast[ptr FileSaver00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_saver_get_compression_type(self: ptr FileSaver00): CompressionType {.
    importc, libprag.}

proc getCompressionType*(self: FileSaver): CompressionType =
  gtk_source_file_saver_get_compression_type(cast[ptr FileSaver00](self.impl))

proc compressionType*(self: FileSaver): CompressionType =
  gtk_source_file_saver_get_compression_type(cast[ptr FileSaver00](self.impl))

proc gtk_source_file_saver_get_encoding(self: ptr FileSaver00): ptr Encoding00 {.
    importc, libprag.}

proc getEncoding*(self: FileSaver): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_saver_get_encoding(cast[ptr FileSaver00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc encoding*(self: FileSaver): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_saver_get_encoding(cast[ptr FileSaver00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc gtk_source_file_saver_get_file(self: ptr FileSaver00): ptr File00 {.
    importc, libprag.}

proc getFile*(self: FileSaver): File =
  let gobj = gtk_source_file_saver_get_file(cast[ptr FileSaver00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc file*(self: FileSaver): File =
  let gobj = gtk_source_file_saver_get_file(cast[ptr FileSaver00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_saver_get_location(self: ptr FileSaver00): ptr gio.GFile00 {.
    importc, libprag.}

proc getLocation*(self: FileSaver): gio.GFile =
  let gobj = gtk_source_file_saver_get_location(cast[ptr FileSaver00](self.impl))
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

proc location*(self: FileSaver): gio.GFile =
  let gobj = gtk_source_file_saver_get_location(cast[ptr FileSaver00](self.impl))
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

proc gtk_source_file_saver_get_newline_type(self: ptr FileSaver00): NewlineType {.
    importc, libprag.}

proc getNewlineType*(self: FileSaver): NewlineType =
  gtk_source_file_saver_get_newline_type(cast[ptr FileSaver00](self.impl))

proc newlineType*(self: FileSaver): NewlineType =
  gtk_source_file_saver_get_newline_type(cast[ptr FileSaver00](self.impl))

proc gtk_source_file_saver_save_async(self: ptr FileSaver00; ioPriority: int32;
    cancellable: ptr gio.Cancellable00; progressCallback: FileProgressCallback;
    progressCallbackData: pointer; progressCallbackNotify: DestroyNotify; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc saveAsync*(self: FileSaver; ioPriority: int; cancellable: gio.Cancellable = nil;
    progressCallback: FileProgressCallback; progressCallbackData: pointer;
    progressCallbackNotify: DestroyNotify; callback: AsyncReadyCallback; userData: pointer) =
  gtk_source_file_saver_save_async(cast[ptr FileSaver00](self.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), progressCallback, progressCallbackData, progressCallbackNotify, callback, userData)

proc gtk_source_file_saver_save_finish(self: ptr FileSaver00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveFinish*(self: FileSaver; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_file_saver_save_finish(cast[ptr FileSaver00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gtk_source_file_saver_set_compression_type(self: ptr FileSaver00; compressionType: CompressionType) {.
    importc, libprag.}

proc setCompressionType*(self: FileSaver; compressionType: CompressionType) =
  gtk_source_file_saver_set_compression_type(cast[ptr FileSaver00](self.impl), compressionType)

proc `compressionType=`*(self: FileSaver; compressionType: CompressionType) =
  gtk_source_file_saver_set_compression_type(cast[ptr FileSaver00](self.impl), compressionType)

proc gtk_source_file_saver_set_encoding(self: ptr FileSaver00; encoding: ptr Encoding00) {.
    importc, libprag.}

proc setEncoding*(self: FileSaver; encoding: Encoding = nil) =
  gtk_source_file_saver_set_encoding(cast[ptr FileSaver00](self.impl), if encoding.isNil: nil else: cast[ptr Encoding00](encoding.impl))

proc `encoding=`*(self: FileSaver; encoding: Encoding = nil) =
  gtk_source_file_saver_set_encoding(cast[ptr FileSaver00](self.impl), if encoding.isNil: nil else: cast[ptr Encoding00](encoding.impl))

proc gtk_source_file_saver_set_newline_type(self: ptr FileSaver00; newlineType: NewlineType) {.
    importc, libprag.}

proc setNewlineType*(self: FileSaver; newlineType: NewlineType) =
  gtk_source_file_saver_set_newline_type(cast[ptr FileSaver00](self.impl), newlineType)

proc `newlineType=`*(self: FileSaver; newlineType: NewlineType) =
  gtk_source_file_saver_set_newline_type(cast[ptr FileSaver00](self.impl), newlineType)

type
  FileSaverFlag* {.size: sizeof(cint), pure.} = enum
    ignoreInvalidChars = 0
    ignoreModificationTime = 1
    createBackup = 2

  FileSaverFlags* = set[FileSaverFlag]

const
  FileSaverFlagsNone* = FileSaverFlags({})
proc none*(t: typedesc[FileSaverFlags]): FileSaverFlags = FileSaverFlags({})

proc gtk_source_file_saver_get_flags(self: ptr FileSaver00): FileSaverFlags {.
    importc, libprag.}

proc getFlags*(self: FileSaver): FileSaverFlags =
  gtk_source_file_saver_get_flags(cast[ptr FileSaver00](self.impl))

proc flags*(self: FileSaver): FileSaverFlags =
  gtk_source_file_saver_get_flags(cast[ptr FileSaver00](self.impl))

proc gtk_source_file_saver_set_flags(self: ptr FileSaver00; flags: FileSaverFlags) {.
    importc, libprag.}

proc setFlags*(self: FileSaver; flags: FileSaverFlags) =
  gtk_source_file_saver_set_flags(cast[ptr FileSaver00](self.impl), flags)

proc `flags=`*(self: FileSaver; flags: FileSaverFlags) =
  gtk_source_file_saver_set_flags(cast[ptr FileSaver00](self.impl), flags)

type
  FileSaverError* {.size: sizeof(cint), pure.} = enum
    invalidChars = 0
    externallyModified = 1

type
  GutterLines* = ref object of gobject.Object
  GutterLines00* = object of gobject.Object00

proc gtk_source_gutter_lines_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GutterLines()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_gutter_lines_add_class(self: ptr GutterLines00; line: uint32;
    name: cstring) {.
    importc, libprag.}

proc addClass*(self: GutterLines; line: int; name: cstring) =
  gtk_source_gutter_lines_add_class(cast[ptr GutterLines00](self.impl), uint32(line), name)

proc gtk_source_gutter_lines_add_qclass(self: ptr GutterLines00; line: uint32;
    qname: uint32) {.
    importc, libprag.}

proc addQclass*(self: GutterLines; line: int; qname: int) =
  gtk_source_gutter_lines_add_qclass(cast[ptr GutterLines00](self.impl), uint32(line), uint32(qname))

proc gtk_source_gutter_lines_get_buffer(self: ptr GutterLines00): ptr gtk4.TextBuffer00 {.
    importc, libprag.}

proc getBuffer*(self: GutterLines): gtk4.TextBuffer =
  let gobj = gtk_source_gutter_lines_get_buffer(cast[ptr GutterLines00](self.impl))
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

proc buffer*(self: GutterLines): gtk4.TextBuffer =
  let gobj = gtk_source_gutter_lines_get_buffer(cast[ptr GutterLines00](self.impl))
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

proc gtk_source_gutter_lines_get_first(self: ptr GutterLines00): uint32 {.
    importc, libprag.}

proc getFirst*(self: GutterLines): int =
  int(gtk_source_gutter_lines_get_first(cast[ptr GutterLines00](self.impl)))

proc first*(self: GutterLines): int =
  int(gtk_source_gutter_lines_get_first(cast[ptr GutterLines00](self.impl)))

proc gtk_source_gutter_lines_get_iter_at_line(self: ptr GutterLines00; iter: var gtk4.TextIter;
    line: uint32) {.
    importc, libprag.}

proc getIterAtLine*(self: GutterLines; iter: var gtk4.TextIter;
    line: int) =
  gtk_source_gutter_lines_get_iter_at_line(cast[ptr GutterLines00](self.impl), iter, uint32(line))

proc gtk_source_gutter_lines_get_last(self: ptr GutterLines00): uint32 {.
    importc, libprag.}

proc getLast*(self: GutterLines): int =
  int(gtk_source_gutter_lines_get_last(cast[ptr GutterLines00](self.impl)))

proc last*(self: GutterLines): int =
  int(gtk_source_gutter_lines_get_last(cast[ptr GutterLines00](self.impl)))

proc gtk_source_gutter_lines_get_line_yrange(self: ptr GutterLines00; line: uint32;
    mode: GutterRendererAlignmentMode; y: var int32; height: var int32) {.
    importc, libprag.}

proc getLineYrange*(self: GutterLines; line: int;
    mode: GutterRendererAlignmentMode; y: var int; height: var int) =
  var height_00: int32
  var y_00: int32
  gtk_source_gutter_lines_get_line_yrange(cast[ptr GutterLines00](self.impl), uint32(line), mode, y_00, height_00)
  if height.addr != nil:
    height = int(height_00)
  if y.addr != nil:
    y = int(y_00)

proc gtk_source_gutter_lines_get_view(self: ptr GutterLines00): ptr gtk4.TextView00 {.
    importc, libprag.}

proc getView*(self: GutterLines): gtk4.TextView =
  let gobj = gtk_source_gutter_lines_get_view(cast[ptr GutterLines00](self.impl))
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

proc view*(self: GutterLines): gtk4.TextView =
  let gobj = gtk_source_gutter_lines_get_view(cast[ptr GutterLines00](self.impl))
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

proc gtk_source_gutter_lines_has_any_class(self: ptr GutterLines00; line: uint32): gboolean {.
    importc, libprag.}

proc hasAnyClass*(self: GutterLines; line: int): bool =
  toBool(gtk_source_gutter_lines_has_any_class(cast[ptr GutterLines00](self.impl), uint32(line)))

proc gtk_source_gutter_lines_has_class(self: ptr GutterLines00; line: uint32;
    name: cstring): gboolean {.
    importc, libprag.}

proc hasClass*(self: GutterLines; line: int; name: cstring): bool =
  toBool(gtk_source_gutter_lines_has_class(cast[ptr GutterLines00](self.impl), uint32(line), name))

proc gtk_source_gutter_lines_has_qclass(self: ptr GutterLines00; line: uint32;
    qname: uint32): gboolean {.
    importc, libprag.}

proc hasQclass*(self: GutterLines; line: int; qname: int): bool =
  toBool(gtk_source_gutter_lines_has_qclass(cast[ptr GutterLines00](self.impl), uint32(line), uint32(qname)))

proc gtk_source_gutter_lines_is_cursor(self: ptr GutterLines00; line: uint32): gboolean {.
    importc, libprag.}

proc isCursor*(self: GutterLines; line: int): bool =
  toBool(gtk_source_gutter_lines_is_cursor(cast[ptr GutterLines00](self.impl), uint32(line)))

proc gtk_source_gutter_lines_is_prelit(self: ptr GutterLines00; line: uint32): gboolean {.
    importc, libprag.}

proc isPrelit*(self: GutterLines; line: int): bool =
  toBool(gtk_source_gutter_lines_is_prelit(cast[ptr GutterLines00](self.impl), uint32(line)))

proc gtk_source_gutter_lines_is_selected(self: ptr GutterLines00; line: uint32): gboolean {.
    importc, libprag.}

proc isSelected*(self: GutterLines; line: int): bool =
  toBool(gtk_source_gutter_lines_is_selected(cast[ptr GutterLines00](self.impl), uint32(line)))

proc gtk_source_gutter_lines_remove_class(self: ptr GutterLines00; line: uint32;
    name: cstring) {.
    importc, libprag.}

proc removeClass*(self: GutterLines; line: int; name: cstring) =
  gtk_source_gutter_lines_remove_class(cast[ptr GutterLines00](self.impl), uint32(line), name)

proc gtk_source_gutter_lines_remove_qclass(self: ptr GutterLines00; line: uint32;
    qname: uint32) {.
    importc, libprag.}

proc removeQclass*(self: GutterLines; line: int;
    qname: int) =
  gtk_source_gutter_lines_remove_qclass(cast[ptr GutterLines00](self.impl), uint32(line), uint32(qname))

type
  GutterRendererPixbuf* = ref object of GutterRenderer
  GutterRendererPixbuf00* = object of GutterRenderer00

proc gtk_source_gutter_renderer_pixbuf_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GutterRendererPixbuf()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_gutter_renderer_pixbuf_new(): ptr GutterRendererPixbuf00 {.
    importc, libprag.}

proc newGutterRendererPixbuf*(): GutterRendererPixbuf =
  let gobj = gtk_source_gutter_renderer_pixbuf_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGutterRendererPixbuf*(tdesc: typedesc): tdesc =
  assert(result is GutterRendererPixbuf)
  let gobj = gtk_source_gutter_renderer_pixbuf_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGutterRendererPixbuf*[T](result: var T) {.deprecated.} =
  assert(result is GutterRendererPixbuf)
  let gobj = gtk_source_gutter_renderer_pixbuf_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_renderer_pixbuf_get_gicon(self: ptr GutterRendererPixbuf00): ptr gio.Icon00 {.
    importc, libprag.}

proc getGicon*(self: GutterRendererPixbuf): gio.Icon =
  let gobj = gtk_source_gutter_renderer_pixbuf_get_gicon(cast[ptr GutterRendererPixbuf00](self.impl))
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

proc gicon*(self: GutterRendererPixbuf): gio.Icon =
  let gobj = gtk_source_gutter_renderer_pixbuf_get_gicon(cast[ptr GutterRendererPixbuf00](self.impl))
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

proc gtk_source_gutter_renderer_pixbuf_get_icon_name(self: ptr GutterRendererPixbuf00): cstring {.
    importc, libprag.}

proc getIconName*(self: GutterRendererPixbuf): string =
  result = $gtk_source_gutter_renderer_pixbuf_get_icon_name(cast[ptr GutterRendererPixbuf00](self.impl))

proc iconName*(self: GutterRendererPixbuf): string =
  result = $gtk_source_gutter_renderer_pixbuf_get_icon_name(cast[ptr GutterRendererPixbuf00](self.impl))

proc gtk_source_gutter_renderer_pixbuf_get_paintable(self: ptr GutterRendererPixbuf00): ptr gdk4.Paintable00 {.
    importc, libprag.}

proc getPaintable*(self: GutterRendererPixbuf): gdk4.Paintable =
  let gobj = gtk_source_gutter_renderer_pixbuf_get_paintable(cast[ptr GutterRendererPixbuf00](self.impl))
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

proc paintable*(self: GutterRendererPixbuf): gdk4.Paintable =
  let gobj = gtk_source_gutter_renderer_pixbuf_get_paintable(cast[ptr GutterRendererPixbuf00](self.impl))
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

proc gtk_source_gutter_renderer_pixbuf_get_pixbuf(self: ptr GutterRendererPixbuf00): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc getPixbuf*(self: GutterRendererPixbuf): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_gutter_renderer_pixbuf_get_pixbuf(cast[ptr GutterRendererPixbuf00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pixbuf*(self: GutterRendererPixbuf): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_gutter_renderer_pixbuf_get_pixbuf(cast[ptr GutterRendererPixbuf00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_renderer_pixbuf_overlay_paintable(self: ptr GutterRendererPixbuf00;
    paintable: ptr gdk4.Paintable00) {.
    importc, libprag.}

proc overlayPaintable*(self: GutterRendererPixbuf;
    paintable: gdk4.Paintable) =
  gtk_source_gutter_renderer_pixbuf_overlay_paintable(cast[ptr GutterRendererPixbuf00](self.impl), cast[ptr gdk4.Paintable00](paintable.impl))

proc gtk_source_gutter_renderer_pixbuf_set_gicon(self: ptr GutterRendererPixbuf00;
    icon: ptr gio.Icon00) {.
    importc, libprag.}

proc setGicon*(self: GutterRendererPixbuf;
    icon: gio.Icon = nil) =
  gtk_source_gutter_renderer_pixbuf_set_gicon(cast[ptr GutterRendererPixbuf00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc `gicon=`*(self: GutterRendererPixbuf;
    icon: gio.Icon = nil) =
  gtk_source_gutter_renderer_pixbuf_set_gicon(cast[ptr GutterRendererPixbuf00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc gtk_source_gutter_renderer_pixbuf_set_icon_name(self: ptr GutterRendererPixbuf00;
    iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: GutterRendererPixbuf;
    iconName: cstring = nil) =
  gtk_source_gutter_renderer_pixbuf_set_icon_name(cast[ptr GutterRendererPixbuf00](self.impl), iconName)

proc `iconName=`*(self: GutterRendererPixbuf;
    iconName: cstring = nil) =
  gtk_source_gutter_renderer_pixbuf_set_icon_name(cast[ptr GutterRendererPixbuf00](self.impl), iconName)

proc gtk_source_gutter_renderer_pixbuf_set_paintable(self: ptr GutterRendererPixbuf00;
    paintable: ptr gdk4.Paintable00) {.
    importc, libprag.}

proc setPaintable*(self: GutterRendererPixbuf;
    paintable: gdk4.Paintable = nil) =
  gtk_source_gutter_renderer_pixbuf_set_paintable(cast[ptr GutterRendererPixbuf00](self.impl), if paintable.isNil: nil else: cast[ptr gdk4.Paintable00](paintable.impl))

proc `paintable=`*(self: GutterRendererPixbuf;
    paintable: gdk4.Paintable = nil) =
  gtk_source_gutter_renderer_pixbuf_set_paintable(cast[ptr GutterRendererPixbuf00](self.impl), if paintable.isNil: nil else: cast[ptr gdk4.Paintable00](paintable.impl))

proc gtk_source_gutter_renderer_pixbuf_set_pixbuf(self: ptr GutterRendererPixbuf00;
    pixbuf: ptr gdkpixbuf.Pixbuf00) {.
    importc, libprag.}

proc setPixbuf*(self: GutterRendererPixbuf;
    pixbuf: gdkpixbuf.Pixbuf = nil) =
  gtk_source_gutter_renderer_pixbuf_set_pixbuf(cast[ptr GutterRendererPixbuf00](self.impl), if pixbuf.isNil: nil else: cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))

proc `pixbuf=`*(self: GutterRendererPixbuf;
    pixbuf: gdkpixbuf.Pixbuf = nil) =
  gtk_source_gutter_renderer_pixbuf_set_pixbuf(cast[ptr GutterRendererPixbuf00](self.impl), if pixbuf.isNil: nil else: cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))

type
  GutterRendererText* = ref object of GutterRenderer
  GutterRendererText00* = object of GutterRenderer00

proc gtk_source_gutter_renderer_text_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GutterRendererText()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_gutter_renderer_text_new(): ptr GutterRendererText00 {.
    importc, libprag.}

proc newGutterRendererText*(): GutterRendererText =
  let gobj = gtk_source_gutter_renderer_text_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGutterRendererText*(tdesc: typedesc): tdesc =
  assert(result is GutterRendererText)
  let gobj = gtk_source_gutter_renderer_text_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGutterRendererText*[T](result: var T) {.deprecated.} =
  assert(result is GutterRendererText)
  let gobj = gtk_source_gutter_renderer_text_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_renderer_text_measure(self: ptr GutterRendererText00;
    text: cstring; width: var int32; height: var int32) {.
    importc, libprag.}

proc measure*(self: GutterRendererText; text: cstring;
    width: var int = cast[var int](nil); height: var int = cast[var int](nil)) =
  var height_00: int32
  var width_00: int32
  gtk_source_gutter_renderer_text_measure(cast[ptr GutterRendererText00](self.impl), text, width_00, height_00)
  if height.addr != nil:
    height = int(height_00)
  if width.addr != nil:
    width = int(width_00)

proc gtk_source_gutter_renderer_text_measure_markup(self: ptr GutterRendererText00;
    markup: cstring; width: var int32; height: var int32) {.
    importc, libprag.}

proc measureMarkup*(self: GutterRendererText;
    markup: cstring; width: var int = cast[var int](nil); height: var int = cast[var int](nil)) =
  var height_00: int32
  var width_00: int32
  gtk_source_gutter_renderer_text_measure_markup(cast[ptr GutterRendererText00](self.impl), markup, width_00, height_00)
  if height.addr != nil:
    height = int(height_00)
  if width.addr != nil:
    width = int(width_00)

proc gtk_source_gutter_renderer_text_set_markup(self: ptr GutterRendererText00;
    markup: cstring; length: int32) {.
    importc, libprag.}

proc setMarkup*(self: GutterRendererText;
    markup: cstring; length: int) =
  gtk_source_gutter_renderer_text_set_markup(cast[ptr GutterRendererText00](self.impl), markup, int32(length))

proc gtk_source_gutter_renderer_text_set_text(self: ptr GutterRendererText00;
    text: cstring; length: int32) {.
    importc, libprag.}

proc setText*(self: GutterRendererText; text: cstring;
    length: int) =
  gtk_source_gutter_renderer_text_set_text(cast[ptr GutterRendererText00](self.impl), text, int32(length))

type
  LanguageManager* = ref object of gobject.Object
  LanguageManager00* = object of gobject.Object00

proc gtk_source_language_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LanguageManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_language_manager_new(): ptr LanguageManager00 {.
    importc, libprag.}

proc newLanguageManager*(): LanguageManager =
  let gobj = gtk_source_language_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newLanguageManager*(tdesc: typedesc): tdesc =
  assert(result is LanguageManager)
  let gobj = gtk_source_language_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initLanguageManager*[T](result: var T) {.deprecated.} =
  assert(result is LanguageManager)
  let gobj = gtk_source_language_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_language_manager_get_default(): ptr LanguageManager00 {.
    importc, libprag.}

proc getDefaultLanguageManager*(): LanguageManager =
  let gobj = gtk_source_language_manager_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_language_manager_append_search_path(self: ptr LanguageManager00;
    path: cstring) {.
    importc, libprag.}

proc appendSearchPath*(self: LanguageManager;
    path: cstring) =
  gtk_source_language_manager_append_search_path(cast[ptr LanguageManager00](self.impl), path)

proc gtk_source_language_manager_get_language(self: ptr LanguageManager00;
    id: cstring): ptr Language00 {.
    importc, libprag.}

proc getLanguage*(self: LanguageManager; id: cstring): Language =
  let gobj = gtk_source_language_manager_get_language(cast[ptr LanguageManager00](self.impl), id)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_language_manager_get_language_ids(self: ptr LanguageManager00): ptr cstring {.
    importc, libprag.}

proc getLanguageIds*(self: LanguageManager): seq[string] =
  let resul0 = gtk_source_language_manager_get_language_ids(cast[ptr LanguageManager00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc languageIds*(self: LanguageManager): seq[string] =
  let resul0 = gtk_source_language_manager_get_language_ids(cast[ptr LanguageManager00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc gtk_source_language_manager_get_search_path(self: ptr LanguageManager00): ptr cstring {.
    importc, libprag.}

proc getSearchPath*(self: LanguageManager): seq[string] =
  cstringArrayToSeq(gtk_source_language_manager_get_search_path(cast[ptr LanguageManager00](self.impl)))

proc searchPath*(self: LanguageManager): seq[string] =
  cstringArrayToSeq(gtk_source_language_manager_get_search_path(cast[ptr LanguageManager00](self.impl)))

proc gtk_source_language_manager_guess_language(self: ptr LanguageManager00;
    filename: cstring; contentType: cstring): ptr Language00 {.
    importc, libprag.}

proc guessLanguage*(self: LanguageManager; filename: cstring = nil;
    contentType: cstring = nil): Language =
  let gobj = gtk_source_language_manager_guess_language(cast[ptr LanguageManager00](self.impl), filename, contentType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_language_manager_prepend_search_path(self: ptr LanguageManager00;
    path: cstring) {.
    importc, libprag.}

proc prependSearchPath*(self: LanguageManager;
    path: cstring) =
  gtk_source_language_manager_prepend_search_path(cast[ptr LanguageManager00](self.impl), path)

proc gtk_source_language_manager_set_search_path(self: ptr LanguageManager00;
    dirs: ptr cstring) {.
    importc, libprag.}

proc setSearchPath*(self: LanguageManager; dirs: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gtk_source_language_manager_set_search_path(cast[ptr LanguageManager00](self.impl), seq2CstringArray(dirs, fs469n23))

proc `searchPath=`*(self: LanguageManager; dirs: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gtk_source_language_manager_set_search_path(cast[ptr LanguageManager00](self.impl), seq2CstringArray(dirs, fs469n23))

const MAJOR_VERSION* = 5'i32

const MICRO_VERSION* = 0'i32

const MINOR_VERSION* = 12'i32

type
  Map* = ref object of View
  Map00* = object of View00

proc gtk_source_map_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Map()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_map_new(): ptr Map00 {.
    importc, libprag.}

proc newMap*(): Map =
  let gobj = gtk_source_map_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newMap*(tdesc: typedesc): tdesc =
  assert(result is Map)
  let gobj = gtk_source_map_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMap*[T](result: var T) {.deprecated.} =
  assert(result is Map)
  let gobj = gtk_source_map_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_map_get_view(self: ptr Map00): ptr View00 {.
    importc, libprag.}

proc getView*(self: Map): View =
  let gobj = gtk_source_map_get_view(cast[ptr Map00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: Map): View =
  let gobj = gtk_source_map_get_view(cast[ptr Map00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_map_set_view(self: ptr Map00; view: ptr View00) {.
    importc, libprag.}

proc setView*(self: Map; view: View) =
  gtk_source_map_set_view(cast[ptr Map00](self.impl), cast[ptr View00](view.impl))

proc `view=`*(self: Map; view: View) =
  gtk_source_map_set_view(cast[ptr Map00](self.impl), cast[ptr View00](view.impl))

type
  PrintCompositor* = ref object of gobject.Object
  PrintCompositor00* = object of gobject.Object00

proc gtk_source_print_compositor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PrintCompositor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_print_compositor_new(buffer: ptr Buffer00): ptr PrintCompositor00 {.
    importc, libprag.}

proc newPrintCompositor*(buffer: Buffer): PrintCompositor =
  let gobj = gtk_source_print_compositor_new(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPrintCompositor*(tdesc: typedesc; buffer: Buffer): tdesc =
  assert(result is PrintCompositor)
  let gobj = gtk_source_print_compositor_new(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPrintCompositor*[T](result: var T; buffer: Buffer) {.deprecated.} =
  assert(result is PrintCompositor)
  let gobj = gtk_source_print_compositor_new(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_print_compositor_new_from_view(view: ptr View00): ptr PrintCompositor00 {.
    importc, libprag.}

proc newPrintCompositorFromView*(view: View): PrintCompositor =
  let gobj = gtk_source_print_compositor_new_from_view(cast[ptr View00](view.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPrintCompositorFromView*(tdesc: typedesc; view: View): tdesc =
  assert(result is PrintCompositor)
  let gobj = gtk_source_print_compositor_new_from_view(cast[ptr View00](view.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPrintCompositorFromView*[T](result: var T; view: View) {.deprecated.} =
  assert(result is PrintCompositor)
  let gobj = gtk_source_print_compositor_new_from_view(cast[ptr View00](view.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_print_compositor_draw_page(self: ptr PrintCompositor00; context: ptr gtk4.PrintContext00;
    pageNr: int32) {.
    importc, libprag.}

proc drawPage*(self: PrintCompositor; context: gtk4.PrintContext;
    pageNr: int) =
  gtk_source_print_compositor_draw_page(cast[ptr PrintCompositor00](self.impl), cast[ptr gtk4.PrintContext00](context.impl), int32(pageNr))

proc gtk_source_print_compositor_get_body_font_name(self: ptr PrintCompositor00): cstring {.
    importc, libprag.}

proc getBodyFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_body_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc bodyFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_body_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_print_compositor_get_bottom_margin(self: ptr PrintCompositor00;
    unit: gtk4.Unit): cdouble {.
    importc, libprag.}

proc getBottomMargin*(self: PrintCompositor;
    unit: gtk4.Unit): cdouble =
  gtk_source_print_compositor_get_bottom_margin(cast[ptr PrintCompositor00](self.impl), unit)

proc gtk_source_print_compositor_get_buffer(self: ptr PrintCompositor00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: PrintCompositor): Buffer =
  let gobj = gtk_source_print_compositor_get_buffer(cast[ptr PrintCompositor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: PrintCompositor): Buffer =
  let gobj = gtk_source_print_compositor_get_buffer(cast[ptr PrintCompositor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_print_compositor_get_footer_font_name(self: ptr PrintCompositor00): cstring {.
    importc, libprag.}

proc getFooterFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_footer_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc footerFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_footer_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_print_compositor_get_header_font_name(self: ptr PrintCompositor00): cstring {.
    importc, libprag.}

proc getHeaderFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_header_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc headerFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_header_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_print_compositor_get_highlight_syntax(self: ptr PrintCompositor00): gboolean {.
    importc, libprag.}

proc getHighlightSyntax*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_highlight_syntax(cast[ptr PrintCompositor00](self.impl)))

proc highlightSyntax*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_highlight_syntax(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_left_margin(self: ptr PrintCompositor00;
    unit: gtk4.Unit): cdouble {.
    importc, libprag.}

proc getLeftMargin*(self: PrintCompositor; unit: gtk4.Unit): cdouble =
  gtk_source_print_compositor_get_left_margin(cast[ptr PrintCompositor00](self.impl), unit)

proc gtk_source_print_compositor_get_line_numbers_font_name(self: ptr PrintCompositor00): cstring {.
    importc, libprag.}

proc getLineNumbersFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_line_numbers_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc lineNumbersFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_line_numbers_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_print_compositor_get_n_pages(self: ptr PrintCompositor00): int32 {.
    importc, libprag.}

proc getNPages*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_n_pages(cast[ptr PrintCompositor00](self.impl)))

proc nPages*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_n_pages(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_pagination_progress(self: ptr PrintCompositor00): cdouble {.
    importc, libprag.}

proc getPaginationProgress*(self: PrintCompositor): cdouble =
  gtk_source_print_compositor_get_pagination_progress(cast[ptr PrintCompositor00](self.impl))

proc paginationProgress*(self: PrintCompositor): cdouble =
  gtk_source_print_compositor_get_pagination_progress(cast[ptr PrintCompositor00](self.impl))

proc gtk_source_print_compositor_get_print_footer(self: ptr PrintCompositor00): gboolean {.
    importc, libprag.}

proc getPrintFooter*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_print_footer(cast[ptr PrintCompositor00](self.impl)))

proc printFooter*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_print_footer(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_print_header(self: ptr PrintCompositor00): gboolean {.
    importc, libprag.}

proc getPrintHeader*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_print_header(cast[ptr PrintCompositor00](self.impl)))

proc printHeader*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_print_header(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_print_line_numbers(self: ptr PrintCompositor00): uint32 {.
    importc, libprag.}

proc getPrintLineNumbers*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_print_line_numbers(cast[ptr PrintCompositor00](self.impl)))

proc printLineNumbers*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_print_line_numbers(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_right_margin(self: ptr PrintCompositor00;
    unit: gtk4.Unit): cdouble {.
    importc, libprag.}

proc getRightMargin*(self: PrintCompositor;
    unit: gtk4.Unit): cdouble =
  gtk_source_print_compositor_get_right_margin(cast[ptr PrintCompositor00](self.impl), unit)

proc gtk_source_print_compositor_get_tab_width(self: ptr PrintCompositor00): uint32 {.
    importc, libprag.}

proc getTabWidth*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_tab_width(cast[ptr PrintCompositor00](self.impl)))

proc tabWidth*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_tab_width(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_top_margin(self: ptr PrintCompositor00;
    unit: gtk4.Unit): cdouble {.
    importc, libprag.}

proc getTopMargin*(self: PrintCompositor; unit: gtk4.Unit): cdouble =
  gtk_source_print_compositor_get_top_margin(cast[ptr PrintCompositor00](self.impl), unit)

proc gtk_source_print_compositor_get_wrap_mode(self: ptr PrintCompositor00): gtk4.WrapMode {.
    importc, libprag.}

proc getWrapMode*(self: PrintCompositor): gtk4.WrapMode =
  gtk_source_print_compositor_get_wrap_mode(cast[ptr PrintCompositor00](self.impl))

proc wrapMode*(self: PrintCompositor): gtk4.WrapMode =
  gtk_source_print_compositor_get_wrap_mode(cast[ptr PrintCompositor00](self.impl))

proc gtk_source_print_compositor_ignore_tag(self: ptr PrintCompositor00;
    tag: ptr gtk4.TextTag00) {.
    importc, libprag.}

proc ignoreTag*(self: PrintCompositor; tag: gtk4.TextTag) =
  gtk_source_print_compositor_ignore_tag(cast[ptr PrintCompositor00](self.impl), cast[ptr gtk4.TextTag00](tag.impl))

proc gtk_source_print_compositor_paginate(self: ptr PrintCompositor00; context: ptr gtk4.PrintContext00): gboolean {.
    importc, libprag.}

proc paginate*(self: PrintCompositor; context: gtk4.PrintContext): bool =
  toBool(gtk_source_print_compositor_paginate(cast[ptr PrintCompositor00](self.impl), cast[ptr gtk4.PrintContext00](context.impl)))

proc gtk_source_print_compositor_set_body_font_name(self: ptr PrintCompositor00;
    fontName: cstring) {.
    importc, libprag.}

proc setBodyFontName*(self: PrintCompositor;
    fontName: cstring) =
  gtk_source_print_compositor_set_body_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc `bodyFontName=`*(self: PrintCompositor;
    fontName: cstring) =
  gtk_source_print_compositor_set_body_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc gtk_source_print_compositor_set_bottom_margin(self: ptr PrintCompositor00;
    margin: cdouble; unit: gtk4.Unit) {.
    importc, libprag.}

proc setBottomMargin*(self: PrintCompositor;
    margin: cdouble; unit: gtk4.Unit) =
  gtk_source_print_compositor_set_bottom_margin(cast[ptr PrintCompositor00](self.impl), margin, unit)

proc gtk_source_print_compositor_set_footer_font_name(self: ptr PrintCompositor00;
    fontName: cstring) {.
    importc, libprag.}

proc setFooterFontName*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_footer_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc `footerFontName=`*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_footer_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc gtk_source_print_compositor_set_footer_format(self: ptr PrintCompositor00;
    separator: gboolean; left: cstring; center: cstring; right: cstring) {.
    importc, libprag.}

proc setFooterFormat*(self: PrintCompositor;
    separator: bool; left: cstring = nil; center: cstring = nil; right: cstring = nil) =
  gtk_source_print_compositor_set_footer_format(cast[ptr PrintCompositor00](self.impl), gboolean(separator), left, center, right)

proc gtk_source_print_compositor_set_header_font_name(self: ptr PrintCompositor00;
    fontName: cstring) {.
    importc, libprag.}

proc setHeaderFontName*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_header_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc `headerFontName=`*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_header_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc gtk_source_print_compositor_set_header_format(self: ptr PrintCompositor00;
    separator: gboolean; left: cstring; center: cstring; right: cstring) {.
    importc, libprag.}

proc setHeaderFormat*(self: PrintCompositor;
    separator: bool; left: cstring = nil; center: cstring = nil; right: cstring = nil) =
  gtk_source_print_compositor_set_header_format(cast[ptr PrintCompositor00](self.impl), gboolean(separator), left, center, right)

proc gtk_source_print_compositor_set_highlight_syntax(self: ptr PrintCompositor00;
    highlight: gboolean) {.
    importc, libprag.}

proc setHighlightSyntax*(self: PrintCompositor;
    highlight: bool = true) =
  gtk_source_print_compositor_set_highlight_syntax(cast[ptr PrintCompositor00](self.impl), gboolean(highlight))

proc `highlightSyntax=`*(self: PrintCompositor;
    highlight: bool) =
  gtk_source_print_compositor_set_highlight_syntax(cast[ptr PrintCompositor00](self.impl), gboolean(highlight))

proc gtk_source_print_compositor_set_left_margin(self: ptr PrintCompositor00;
    margin: cdouble; unit: gtk4.Unit) {.
    importc, libprag.}

proc setLeftMargin*(self: PrintCompositor; margin: cdouble;
    unit: gtk4.Unit) =
  gtk_source_print_compositor_set_left_margin(cast[ptr PrintCompositor00](self.impl), margin, unit)

proc gtk_source_print_compositor_set_line_numbers_font_name(self: ptr PrintCompositor00;
    fontName: cstring) {.
    importc, libprag.}

proc setLineNumbersFontName*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_line_numbers_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc `lineNumbersFontName=`*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_line_numbers_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc gtk_source_print_compositor_set_print_footer(self: ptr PrintCompositor00;
    print: gboolean) {.
    importc, libprag.}

proc setPrintFooter*(self: PrintCompositor;
    print: bool = true) =
  gtk_source_print_compositor_set_print_footer(cast[ptr PrintCompositor00](self.impl), gboolean(print))

proc `printFooter=`*(self: PrintCompositor;
    print: bool) =
  gtk_source_print_compositor_set_print_footer(cast[ptr PrintCompositor00](self.impl), gboolean(print))

proc gtk_source_print_compositor_set_print_header(self: ptr PrintCompositor00;
    print: gboolean) {.
    importc, libprag.}

proc setPrintHeader*(self: PrintCompositor;
    print: bool = true) =
  gtk_source_print_compositor_set_print_header(cast[ptr PrintCompositor00](self.impl), gboolean(print))

proc `printHeader=`*(self: PrintCompositor;
    print: bool) =
  gtk_source_print_compositor_set_print_header(cast[ptr PrintCompositor00](self.impl), gboolean(print))

proc gtk_source_print_compositor_set_print_line_numbers(self: ptr PrintCompositor00;
    interval: uint32) {.
    importc, libprag.}

proc setPrintLineNumbers*(self: PrintCompositor;
    interval: int) =
  gtk_source_print_compositor_set_print_line_numbers(cast[ptr PrintCompositor00](self.impl), uint32(interval))

proc `printLineNumbers=`*(self: PrintCompositor;
    interval: int) =
  gtk_source_print_compositor_set_print_line_numbers(cast[ptr PrintCompositor00](self.impl), uint32(interval))

proc gtk_source_print_compositor_set_right_margin(self: ptr PrintCompositor00;
    margin: cdouble; unit: gtk4.Unit) {.
    importc, libprag.}

proc setRightMargin*(self: PrintCompositor;
    margin: cdouble; unit: gtk4.Unit) =
  gtk_source_print_compositor_set_right_margin(cast[ptr PrintCompositor00](self.impl), margin, unit)

proc gtk_source_print_compositor_set_tab_width(self: ptr PrintCompositor00;
    width: uint32) {.
    importc, libprag.}

proc setTabWidth*(self: PrintCompositor; width: int) =
  gtk_source_print_compositor_set_tab_width(cast[ptr PrintCompositor00](self.impl), uint32(width))

proc `tabWidth=`*(self: PrintCompositor; width: int) =
  gtk_source_print_compositor_set_tab_width(cast[ptr PrintCompositor00](self.impl), uint32(width))

proc gtk_source_print_compositor_set_top_margin(self: ptr PrintCompositor00;
    margin: cdouble; unit: gtk4.Unit) {.
    importc, libprag.}

proc setTopMargin*(self: PrintCompositor; margin: cdouble;
    unit: gtk4.Unit) =
  gtk_source_print_compositor_set_top_margin(cast[ptr PrintCompositor00](self.impl), margin, unit)

proc gtk_source_print_compositor_set_wrap_mode(self: ptr PrintCompositor00;
    wrapMode: gtk4.WrapMode) {.
    importc, libprag.}

proc setWrapMode*(self: PrintCompositor; wrapMode: gtk4.WrapMode) =
  gtk_source_print_compositor_set_wrap_mode(cast[ptr PrintCompositor00](self.impl), wrapMode)

proc `wrapMode=`*(self: PrintCompositor; wrapMode: gtk4.WrapMode) =
  gtk_source_print_compositor_set_wrap_mode(cast[ptr PrintCompositor00](self.impl), wrapMode)

type
  Region* = ref object of gobject.Object
  Region00* = object of gobject.Object00

proc gtk_source_region_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Region()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_region_new(buffer: ptr gtk4.TextBuffer00): ptr Region00 {.
    importc, libprag.}

proc newRegion*(buffer: gtk4.TextBuffer): Region =
  let gobj = gtk_source_region_new(cast[ptr gtk4.TextBuffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newRegion*(tdesc: typedesc; buffer: gtk4.TextBuffer): tdesc =
  assert(result is Region)
  let gobj = gtk_source_region_new(cast[ptr gtk4.TextBuffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initRegion*[T](result: var T; buffer: gtk4.TextBuffer) {.deprecated.} =
  assert(result is Region)
  let gobj = gtk_source_region_new(cast[ptr gtk4.TextBuffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_region_add_region(self: ptr Region00; regionToAdd: ptr Region00) {.
    importc, libprag.}

proc addRegion*(self: Region; regionToAdd: Region = nil) =
  gtk_source_region_add_region(cast[ptr Region00](self.impl), if regionToAdd.isNil: nil else: cast[ptr Region00](regionToAdd.impl))

proc gtk_source_region_add_subregion(self: ptr Region00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc addSubregion*(self: Region; start: gtk4.TextIter;
    `end`: gtk4.TextIter) =
  gtk_source_region_add_subregion(cast[ptr Region00](self.impl), start, `end`)

proc gtk_source_region_get_bounds(self: ptr Region00; start: var gtk4.TextIter;
    `end`: var gtk4.TextIter): gboolean {.
    importc, libprag.}

proc getBounds*(self: Region; start: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    `end`: var gtk4.TextIter = cast[var gtk4.TextIter](nil)): bool =
  toBool(gtk_source_region_get_bounds(cast[ptr Region00](self.impl), start, `end`))

proc gtk_source_region_get_buffer(self: ptr Region00): ptr gtk4.TextBuffer00 {.
    importc, libprag.}

proc getBuffer*(self: Region): gtk4.TextBuffer =
  let gobj = gtk_source_region_get_buffer(cast[ptr Region00](self.impl))
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

proc buffer*(self: Region): gtk4.TextBuffer =
  let gobj = gtk_source_region_get_buffer(cast[ptr Region00](self.impl))
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

proc gtk_source_region_intersect_region(self: ptr Region00; region2: ptr Region00): ptr Region00 {.
    importc, libprag.}

proc intersectRegion*(self: Region; region2: Region = nil): Region =
  let gobj = gtk_source_region_intersect_region(cast[ptr Region00](self.impl), if region2.isNil: nil else: cast[ptr Region00](region2.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_region_intersect_subregion(self: ptr Region00; start: gtk4.TextIter;
    `end`: gtk4.TextIter): ptr Region00 {.
    importc, libprag.}

proc intersectSubregion*(self: Region; start: gtk4.TextIter;
    `end`: gtk4.TextIter): Region =
  let gobj = gtk_source_region_intersect_subregion(cast[ptr Region00](self.impl), start, `end`)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_region_is_empty(self: ptr Region00): gboolean {.
    importc, libprag.}

proc isEmpty*(self: Region): bool =
  toBool(gtk_source_region_is_empty(cast[ptr Region00](self.impl)))

proc gtk_source_region_subtract_region(self: ptr Region00; regionToSubtract: ptr Region00) {.
    importc, libprag.}

proc subtractRegion*(self: Region; regionToSubtract: Region = nil) =
  gtk_source_region_subtract_region(cast[ptr Region00](self.impl), if regionToSubtract.isNil: nil else: cast[ptr Region00](regionToSubtract.impl))

proc gtk_source_region_subtract_subregion(self: ptr Region00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc subtractSubregion*(self: Region; start: gtk4.TextIter;
    `end`: gtk4.TextIter) =
  gtk_source_region_subtract_subregion(cast[ptr Region00](self.impl), start, `end`)

proc gtk_source_region_to_string(self: ptr Region00): cstring {.
    importc, libprag.}

proc toString*(self: Region): string =
  let resul0 = gtk_source_region_to_string(cast[ptr Region00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

type
  RegionIter* {.pure, byRef.} = object
    dummy1*: pointer
    dummy2*: uint32
    dummy3*: pointer

proc gtk_source_region_iter_get_subregion(self: RegionIter; start: var gtk4.TextIter;
    `end`: var gtk4.TextIter): gboolean {.
    importc, libprag.}

proc getSubregion*(self: RegionIter; start: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    `end`: var gtk4.TextIter = cast[var gtk4.TextIter](nil)): bool =
  toBool(gtk_source_region_iter_get_subregion(self, start, `end`))

proc gtk_source_region_iter_is_end(self: RegionIter): gboolean {.
    importc, libprag.}

proc isEnd*(self: RegionIter): bool =
  toBool(gtk_source_region_iter_is_end(self))

proc gtk_source_region_iter_next(self: RegionIter): gboolean {.
    importc, libprag.}

proc next*(self: RegionIter): bool =
  toBool(gtk_source_region_iter_next(self))

proc gtk_source_region_get_start_region_iter(self: ptr Region00; iter: var RegionIter) {.
    importc, libprag.}

proc getStartRegionIter*(self: Region; iter: var RegionIter) =
  gtk_source_region_get_start_region_iter(cast[ptr Region00](self.impl), iter)

proc getStartRegionIter*(self: Region): RegionIter =
  gtk_source_region_get_start_region_iter(cast[ptr Region00](self.impl), result)

type
  SchedulerCallback* = proc (deadline: int64; userData: pointer): gboolean {.cdecl.}

type
  SearchContext* = ref object of gobject.Object
  SearchContext00* = object of gobject.Object00

proc gtk_source_search_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SearchContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_search_context_backward(self: ptr SearchContext00; iter: gtk4.TextIter;
    matchStart: var gtk4.TextIter; matchEnd: var gtk4.TextIter; hasWrappedAround: var gboolean): gboolean {.
    importc, libprag.}

proc backward*(self: SearchContext; iter: gtk4.TextIter;
    matchStart: var gtk4.TextIter = cast[var gtk4.TextIter](nil); matchEnd: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    hasWrappedAround: var bool = cast[var bool](nil)): bool =
  var hasWrappedAround_00: gboolean
  result = toBool(gtk_source_search_context_backward(cast[ptr SearchContext00](self.impl), iter, matchStart, matchEnd, hasWrappedAround_00))
  if hasWrappedAround.addr != nil:
    hasWrappedAround = toBool(hasWrappedAround_00)

proc gtk_source_search_context_backward_async(self: ptr SearchContext00;
    iter: gtk4.TextIter; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc backwardAsync*(self: SearchContext; iter: gtk4.TextIter;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  gtk_source_search_context_backward_async(cast[ptr SearchContext00](self.impl), iter, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gtk_source_search_context_backward_finish(self: ptr SearchContext00;
    resu: ptr gio.AsyncResult00; matchStart: var gtk4.TextIter; matchEnd: var gtk4.TextIter;
    hasWrappedAround: var gboolean; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc backwardFinish*(self: SearchContext; resu: gio.AsyncResult;
    matchStart: var gtk4.TextIter = cast[var gtk4.TextIter](nil); matchEnd: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    hasWrappedAround: var bool = cast[var bool](nil)): bool =
  var gerror: ptr glib.Error
  var hasWrappedAround_00: gboolean
  let resul0 = gtk_source_search_context_backward_finish(cast[ptr SearchContext00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), matchStart, matchEnd, hasWrappedAround_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if hasWrappedAround.addr != nil:
    hasWrappedAround = toBool(hasWrappedAround_00)

proc gtk_source_search_context_forward(self: ptr SearchContext00; iter: gtk4.TextIter;
    matchStart: var gtk4.TextIter; matchEnd: var gtk4.TextIter; hasWrappedAround: var gboolean): gboolean {.
    importc, libprag.}

proc forward*(self: SearchContext; iter: gtk4.TextIter;
    matchStart: var gtk4.TextIter = cast[var gtk4.TextIter](nil); matchEnd: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    hasWrappedAround: var bool = cast[var bool](nil)): bool =
  var hasWrappedAround_00: gboolean
  result = toBool(gtk_source_search_context_forward(cast[ptr SearchContext00](self.impl), iter, matchStart, matchEnd, hasWrappedAround_00))
  if hasWrappedAround.addr != nil:
    hasWrappedAround = toBool(hasWrappedAround_00)

proc gtk_source_search_context_forward_async(self: ptr SearchContext00; iter: gtk4.TextIter;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc forwardAsync*(self: SearchContext; iter: gtk4.TextIter;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  gtk_source_search_context_forward_async(cast[ptr SearchContext00](self.impl), iter, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gtk_source_search_context_forward_finish(self: ptr SearchContext00;
    resu: ptr gio.AsyncResult00; matchStart: var gtk4.TextIter; matchEnd: var gtk4.TextIter;
    hasWrappedAround: var gboolean; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc forwardFinish*(self: SearchContext; resu: gio.AsyncResult;
    matchStart: var gtk4.TextIter = cast[var gtk4.TextIter](nil); matchEnd: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    hasWrappedAround: var bool = cast[var bool](nil)): bool =
  var gerror: ptr glib.Error
  var hasWrappedAround_00: gboolean
  let resul0 = gtk_source_search_context_forward_finish(cast[ptr SearchContext00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), matchStart, matchEnd, hasWrappedAround_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if hasWrappedAround.addr != nil:
    hasWrappedAround = toBool(hasWrappedAround_00)

proc gtk_source_search_context_get_buffer(self: ptr SearchContext00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: SearchContext): Buffer =
  let gobj = gtk_source_search_context_get_buffer(cast[ptr SearchContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: SearchContext): Buffer =
  let gobj = gtk_source_search_context_get_buffer(cast[ptr SearchContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_search_context_get_highlight(self: ptr SearchContext00): gboolean {.
    importc, libprag.}

proc getHighlight*(self: SearchContext): bool =
  toBool(gtk_source_search_context_get_highlight(cast[ptr SearchContext00](self.impl)))

proc highlight*(self: SearchContext): bool =
  toBool(gtk_source_search_context_get_highlight(cast[ptr SearchContext00](self.impl)))

proc gtk_source_search_context_get_match_style(self: ptr SearchContext00): ptr Style00 {.
    importc, libprag.}

proc getMatchStyle*(self: SearchContext): Style =
  let gobj = gtk_source_search_context_get_match_style(cast[ptr SearchContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc matchStyle*(self: SearchContext): Style =
  let gobj = gtk_source_search_context_get_match_style(cast[ptr SearchContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_search_context_get_occurrence_position(self: ptr SearchContext00;
    matchStart: gtk4.TextIter; matchEnd: gtk4.TextIter): int32 {.
    importc, libprag.}

proc getOccurrencePosition*(self: SearchContext;
    matchStart: gtk4.TextIter; matchEnd: gtk4.TextIter): int =
  int(gtk_source_search_context_get_occurrence_position(cast[ptr SearchContext00](self.impl), matchStart, matchEnd))

proc gtk_source_search_context_get_occurrences_count(self: ptr SearchContext00): int32 {.
    importc, libprag.}

proc getOccurrencesCount*(self: SearchContext): int =
  int(gtk_source_search_context_get_occurrences_count(cast[ptr SearchContext00](self.impl)))

proc occurrencesCount*(self: SearchContext): int =
  int(gtk_source_search_context_get_occurrences_count(cast[ptr SearchContext00](self.impl)))

proc gtk_source_search_context_get_regex_error(self: ptr SearchContext00): ptr glib.Error {.
    importc, libprag.}

proc getRegexError*(self: SearchContext): ptr glib.Error =
  gtk_source_search_context_get_regex_error(cast[ptr SearchContext00](self.impl))

proc regexError*(self: SearchContext): ptr glib.Error =
  gtk_source_search_context_get_regex_error(cast[ptr SearchContext00](self.impl))

proc gtk_source_search_context_replace(self: ptr SearchContext00; matchStart: gtk4.TextIter;
    matchEnd: gtk4.TextIter; replace: cstring; replaceLength: int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc replace*(self: SearchContext; matchStart: gtk4.TextIter;
    matchEnd: gtk4.TextIter; replace: cstring; replaceLength: int): bool =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_search_context_replace(cast[ptr SearchContext00](self.impl), matchStart, matchEnd, replace, int32(replaceLength), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gtk_source_search_context_replace_all(self: ptr SearchContext00; replace: cstring;
    replaceLength: int32; error: ptr ptr glib.Error = nil): uint32 {.
    importc, libprag.}

proc replaceAll*(self: SearchContext; replace: cstring;
    replaceLength: int): int =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_search_context_replace_all(cast[ptr SearchContext00](self.impl), replace, int32(replaceLength), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = int(resul0)

proc gtk_source_search_context_set_highlight(self: ptr SearchContext00; highlight: gboolean) {.
    importc, libprag.}

proc setHighlight*(self: SearchContext; highlight: bool = true) =
  gtk_source_search_context_set_highlight(cast[ptr SearchContext00](self.impl), gboolean(highlight))

proc `highlight=`*(self: SearchContext; highlight: bool) =
  gtk_source_search_context_set_highlight(cast[ptr SearchContext00](self.impl), gboolean(highlight))

proc gtk_source_search_context_set_match_style(self: ptr SearchContext00;
    matchStyle: ptr Style00) {.
    importc, libprag.}

proc setMatchStyle*(self: SearchContext; matchStyle: Style = nil) =
  gtk_source_search_context_set_match_style(cast[ptr SearchContext00](self.impl), if matchStyle.isNil: nil else: cast[ptr Style00](matchStyle.impl))

proc `matchStyle=`*(self: SearchContext; matchStyle: Style = nil) =
  gtk_source_search_context_set_match_style(cast[ptr SearchContext00](self.impl), if matchStyle.isNil: nil else: cast[ptr Style00](matchStyle.impl))

type
  SearchSettings* = ref object of gobject.Object
  SearchSettings00* = object of gobject.Object00

proc gtk_source_search_settings_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SearchSettings()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_search_settings_new(): ptr SearchSettings00 {.
    importc, libprag.}

proc newSearchSettings*(): SearchSettings =
  let gobj = gtk_source_search_settings_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSearchSettings*(tdesc: typedesc): tdesc =
  assert(result is SearchSettings)
  let gobj = gtk_source_search_settings_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSearchSettings*[T](result: var T) {.deprecated.} =
  assert(result is SearchSettings)
  let gobj = gtk_source_search_settings_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_search_settings_get_at_word_boundaries(self: ptr SearchSettings00): gboolean {.
    importc, libprag.}

proc getAtWordBoundaries*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_at_word_boundaries(cast[ptr SearchSettings00](self.impl)))

proc atWordBoundaries*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_at_word_boundaries(cast[ptr SearchSettings00](self.impl)))

proc gtk_source_search_settings_get_case_sensitive(self: ptr SearchSettings00): gboolean {.
    importc, libprag.}

proc getCaseSensitive*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_case_sensitive(cast[ptr SearchSettings00](self.impl)))

proc caseSensitive*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_case_sensitive(cast[ptr SearchSettings00](self.impl)))

proc gtk_source_search_settings_get_regex_enabled(self: ptr SearchSettings00): gboolean {.
    importc, libprag.}

proc getRegexEnabled*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_regex_enabled(cast[ptr SearchSettings00](self.impl)))

proc regexEnabled*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_regex_enabled(cast[ptr SearchSettings00](self.impl)))

proc gtk_source_search_settings_get_search_text(self: ptr SearchSettings00): cstring {.
    importc, libprag.}

proc getSearchText*(self: SearchSettings): string =
  let resul0 = gtk_source_search_settings_get_search_text(cast[ptr SearchSettings00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc searchText*(self: SearchSettings): string =
  let resul0 = gtk_source_search_settings_get_search_text(cast[ptr SearchSettings00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_search_settings_get_visible_only(self: ptr SearchSettings00): gboolean {.
    importc, libprag.}

proc getVisibleOnly*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_visible_only(cast[ptr SearchSettings00](self.impl)))

proc visibleOnly*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_visible_only(cast[ptr SearchSettings00](self.impl)))

proc gtk_source_search_settings_get_wrap_around(self: ptr SearchSettings00): gboolean {.
    importc, libprag.}

proc getWrapAround*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_wrap_around(cast[ptr SearchSettings00](self.impl)))

proc wrapAround*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_wrap_around(cast[ptr SearchSettings00](self.impl)))

proc gtk_source_search_settings_set_at_word_boundaries(self: ptr SearchSettings00;
    atWordBoundaries: gboolean) {.
    importc, libprag.}

proc setAtWordBoundaries*(self: SearchSettings;
    atWordBoundaries: bool = true) =
  gtk_source_search_settings_set_at_word_boundaries(cast[ptr SearchSettings00](self.impl), gboolean(atWordBoundaries))

proc `atWordBoundaries=`*(self: SearchSettings;
    atWordBoundaries: bool) =
  gtk_source_search_settings_set_at_word_boundaries(cast[ptr SearchSettings00](self.impl), gboolean(atWordBoundaries))

proc gtk_source_search_settings_set_case_sensitive(self: ptr SearchSettings00;
    caseSensitive: gboolean) {.
    importc, libprag.}

proc setCaseSensitive*(self: SearchSettings;
    caseSensitive: bool = true) =
  gtk_source_search_settings_set_case_sensitive(cast[ptr SearchSettings00](self.impl), gboolean(caseSensitive))

proc `caseSensitive=`*(self: SearchSettings;
    caseSensitive: bool) =
  gtk_source_search_settings_set_case_sensitive(cast[ptr SearchSettings00](self.impl), gboolean(caseSensitive))

proc gtk_source_search_settings_set_regex_enabled(self: ptr SearchSettings00;
    regexEnabled: gboolean) {.
    importc, libprag.}

proc setRegexEnabled*(self: SearchSettings; regexEnabled: bool = true) =
  gtk_source_search_settings_set_regex_enabled(cast[ptr SearchSettings00](self.impl), gboolean(regexEnabled))

proc `regexEnabled=`*(self: SearchSettings; regexEnabled: bool) =
  gtk_source_search_settings_set_regex_enabled(cast[ptr SearchSettings00](self.impl), gboolean(regexEnabled))

proc gtk_source_search_settings_set_search_text(self: ptr SearchSettings00;
    searchText: cstring) {.
    importc, libprag.}

proc setSearchText*(self: SearchSettings; searchText: cstring = nil) =
  gtk_source_search_settings_set_search_text(cast[ptr SearchSettings00](self.impl), searchText)

proc `searchText=`*(self: SearchSettings; searchText: cstring = nil) =
  gtk_source_search_settings_set_search_text(cast[ptr SearchSettings00](self.impl), searchText)

proc gtk_source_search_settings_set_visible_only(self: ptr SearchSettings00;
    visibleOnly: gboolean) {.
    importc, libprag.}

proc setVisibleOnly*(self: SearchSettings; visibleOnly: bool = true) =
  gtk_source_search_settings_set_visible_only(cast[ptr SearchSettings00](self.impl), gboolean(visibleOnly))

proc `visibleOnly=`*(self: SearchSettings; visibleOnly: bool) =
  gtk_source_search_settings_set_visible_only(cast[ptr SearchSettings00](self.impl), gboolean(visibleOnly))

proc gtk_source_search_settings_set_wrap_around(self: ptr SearchSettings00;
    wrapAround: gboolean) {.
    importc, libprag.}

proc setWrapAround*(self: SearchSettings; wrapAround: bool = true) =
  gtk_source_search_settings_set_wrap_around(cast[ptr SearchSettings00](self.impl), gboolean(wrapAround))

proc `wrapAround=`*(self: SearchSettings; wrapAround: bool) =
  gtk_source_search_settings_set_wrap_around(cast[ptr SearchSettings00](self.impl), gboolean(wrapAround))

proc gtk_source_search_context_new(buffer: ptr Buffer00; settings: ptr SearchSettings00): ptr SearchContext00 {.
    importc, libprag.}

proc newSearchContext*(buffer: Buffer; settings: SearchSettings = nil): SearchContext =
  let gobj = gtk_source_search_context_new(cast[ptr Buffer00](buffer.impl), if settings.isNil: nil else: cast[ptr SearchSettings00](settings.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSearchContext*(tdesc: typedesc; buffer: Buffer; settings: SearchSettings = nil): tdesc =
  assert(result is SearchContext)
  let gobj = gtk_source_search_context_new(cast[ptr Buffer00](buffer.impl), if settings.isNil: nil else: cast[ptr SearchSettings00](settings.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSearchContext*[T](result: var T; buffer: Buffer; settings: SearchSettings = nil) {.deprecated.} =
  assert(result is SearchContext)
  let gobj = gtk_source_search_context_new(cast[ptr Buffer00](buffer.impl), if settings.isNil: nil else: cast[ptr SearchSettings00](settings.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_search_context_get_settings(self: ptr SearchContext00): ptr SearchSettings00 {.
    importc, libprag.}

proc getSettings*(self: SearchContext): SearchSettings =
  let gobj = gtk_source_search_context_get_settings(cast[ptr SearchContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SnippetManager* = ref object of gobject.Object
  SnippetManager00* = object of gobject.Object00

proc gtk_source_snippet_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SnippetManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_snippet_manager_get_default(): ptr SnippetManager00 {.
    importc, libprag.}

proc getDefaultSnippetManager*(): SnippetManager =
  let gobj = gtk_source_snippet_manager_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_snippet_manager_get_search_path(self: ptr SnippetManager00): ptr cstring {.
    importc, libprag.}

proc getSearchPath*(self: SnippetManager): seq[string] =
  cstringArrayToSeq(gtk_source_snippet_manager_get_search_path(cast[ptr SnippetManager00](self.impl)))

proc searchPath*(self: SnippetManager): seq[string] =
  cstringArrayToSeq(gtk_source_snippet_manager_get_search_path(cast[ptr SnippetManager00](self.impl)))

proc gtk_source_snippet_manager_get_snippet(self: ptr SnippetManager00; group: cstring;
    languageId: cstring; trigger: cstring): ptr Snippet00 {.
    importc, libprag.}

proc getSnippet*(self: SnippetManager; group: cstring = nil;
    languageId: cstring = nil; trigger: cstring): Snippet =
  let gobj = gtk_source_snippet_manager_get_snippet(cast[ptr SnippetManager00](self.impl), group, languageId, trigger)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_snippet_manager_list_all(self: ptr SnippetManager00): ptr gio.ListModel00 {.
    importc, libprag.}

proc listAll*(self: SnippetManager): gio.ListModel =
  let gobj = gtk_source_snippet_manager_list_all(cast[ptr SnippetManager00](self.impl))
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

proc gtk_source_snippet_manager_list_groups(self: ptr SnippetManager00): ptr cstring {.
    importc, libprag.}

proc listGroups*(self: SnippetManager): seq[string] =
  cstringArrayToSeq(gtk_source_snippet_manager_list_groups(cast[ptr SnippetManager00](self.impl)))

proc gtk_source_snippet_manager_list_matching(self: ptr SnippetManager00;
    group: cstring; languageId: cstring; triggerPrefix: cstring): ptr gio.ListModel00 {.
    importc, libprag.}

proc listMatching*(self: SnippetManager; group: cstring = nil;
    languageId: cstring = nil; triggerPrefix: cstring = nil): gio.ListModel =
  let gobj = gtk_source_snippet_manager_list_matching(cast[ptr SnippetManager00](self.impl), group, languageId, triggerPrefix)
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

proc gtk_source_snippet_manager_set_search_path(self: ptr SnippetManager00;
    dirs: ptr cstring) {.
    importc, libprag.}

proc setSearchPath*(self: SnippetManager; dirs: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gtk_source_snippet_manager_set_search_path(cast[ptr SnippetManager00](self.impl), seq2CstringArray(dirs, fs469n23))

proc `searchPath=`*(self: SnippetManager; dirs: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gtk_source_snippet_manager_set_search_path(cast[ptr SnippetManager00](self.impl), seq2CstringArray(dirs, fs469n23))

type
  StyleSchemeChooser00* = object of gobject.Object00
  StyleSchemeChooser* = ref object of gobject.Object

type
  StyleSchemeChooserButton* = ref object of gtk4.Button
  StyleSchemeChooserButton00* = object of gtk4.Button00

proc gtk_source_style_scheme_chooser_button_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleSchemeChooserButton()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_style_scheme_chooser_button_new(): ptr StyleSchemeChooserButton00 {.
    importc, libprag.}

proc newStyleSchemeChooserButton*(): StyleSchemeChooserButton =
  let gobj = gtk_source_style_scheme_chooser_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newStyleSchemeChooserButton*(tdesc: typedesc): tdesc =
  assert(result is StyleSchemeChooserButton)
  let gobj = gtk_source_style_scheme_chooser_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initStyleSchemeChooserButton*[T](result: var T) {.deprecated.} =
  assert(result is StyleSchemeChooserButton)
  let gobj = gtk_source_style_scheme_chooser_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  StyleSchemeChooserWidget* = ref object of gtk4.Widget
  StyleSchemeChooserWidget00* = object of gtk4.Widget00

proc gtk_source_style_scheme_chooser_widget_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleSchemeChooserWidget()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_style_scheme_chooser_widget_new(): ptr StyleSchemeChooserWidget00 {.
    importc, libprag.}

proc newStyleSchemeChooserWidget*(): StyleSchemeChooserWidget =
  let gobj = gtk_source_style_scheme_chooser_widget_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newStyleSchemeChooserWidget*(tdesc: typedesc): tdesc =
  assert(result is StyleSchemeChooserWidget)
  let gobj = gtk_source_style_scheme_chooser_widget_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initStyleSchemeChooserWidget*[T](result: var T) {.deprecated.} =
  assert(result is StyleSchemeChooserWidget)
  let gobj = gtk_source_style_scheme_chooser_widget_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_chooser_get_style_scheme(self: ptr StyleSchemeChooser00): ptr StyleScheme00 {.
    importc, libprag.}

proc getStyleScheme*(self: StyleSchemeChooser | StyleSchemeChooserButton | StyleSchemeChooserWidget): StyleScheme =
  let gobj = gtk_source_style_scheme_chooser_get_style_scheme(cast[ptr StyleSchemeChooser00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc styleScheme*(self: StyleSchemeChooser | StyleSchemeChooserButton | StyleSchemeChooserWidget): StyleScheme =
  let gobj = gtk_source_style_scheme_chooser_get_style_scheme(cast[ptr StyleSchemeChooser00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_chooser_set_style_scheme(self: ptr StyleSchemeChooser00;
    scheme: ptr StyleScheme00) {.
    importc, libprag.}

proc setStyleScheme*(self: StyleSchemeChooser | StyleSchemeChooserButton | StyleSchemeChooserWidget;
    scheme: StyleScheme) =
  gtk_source_style_scheme_chooser_set_style_scheme(cast[ptr StyleSchemeChooser00](self.impl), cast[ptr StyleScheme00](scheme.impl))

proc `styleScheme=`*(self: StyleSchemeChooser | StyleSchemeChooserButton | StyleSchemeChooserWidget;
    scheme: StyleScheme) =
  gtk_source_style_scheme_chooser_set_style_scheme(cast[ptr StyleSchemeChooser00](self.impl), cast[ptr StyleScheme00](scheme.impl))

type
  StyleSchemeManager* = ref object of gobject.Object
  StyleSchemeManager00* = object of gobject.Object00

proc gtk_source_style_scheme_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleSchemeManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_style_scheme_manager_new(): ptr StyleSchemeManager00 {.
    importc, libprag.}

proc newStyleSchemeManager*(): StyleSchemeManager =
  let gobj = gtk_source_style_scheme_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newStyleSchemeManager*(tdesc: typedesc): tdesc =
  assert(result is StyleSchemeManager)
  let gobj = gtk_source_style_scheme_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initStyleSchemeManager*[T](result: var T) {.deprecated.} =
  assert(result is StyleSchemeManager)
  let gobj = gtk_source_style_scheme_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_manager_get_default(): ptr StyleSchemeManager00 {.
    importc, libprag.}

proc getDefaultStyleSchemeManager*(): StyleSchemeManager =
  let gobj = gtk_source_style_scheme_manager_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_manager_append_search_path(self: ptr StyleSchemeManager00;
    path: cstring) {.
    importc, libprag.}

proc appendSearchPath*(self: StyleSchemeManager;
    path: cstring) =
  gtk_source_style_scheme_manager_append_search_path(cast[ptr StyleSchemeManager00](self.impl), path)

proc gtk_source_style_scheme_manager_force_rescan(self: ptr StyleSchemeManager00) {.
    importc, libprag.}

proc forceRescan*(self: StyleSchemeManager) =
  gtk_source_style_scheme_manager_force_rescan(cast[ptr StyleSchemeManager00](self.impl))

proc gtk_source_style_scheme_manager_get_scheme(self: ptr StyleSchemeManager00;
    schemeId: cstring): ptr StyleScheme00 {.
    importc, libprag.}

proc getScheme*(self: StyleSchemeManager;
    schemeId: cstring): StyleScheme =
  let gobj = gtk_source_style_scheme_manager_get_scheme(cast[ptr StyleSchemeManager00](self.impl), schemeId)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_manager_get_scheme_ids(self: ptr StyleSchemeManager00): ptr cstring {.
    importc, libprag.}

proc getSchemeIds*(self: StyleSchemeManager): seq[string] =
  let resul0 = gtk_source_style_scheme_manager_get_scheme_ids(cast[ptr StyleSchemeManager00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc schemeIds*(self: StyleSchemeManager): seq[string] =
  let resul0 = gtk_source_style_scheme_manager_get_scheme_ids(cast[ptr StyleSchemeManager00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc gtk_source_style_scheme_manager_get_search_path(self: ptr StyleSchemeManager00): ptr cstring {.
    importc, libprag.}

proc getSearchPath*(self: StyleSchemeManager): seq[string] =
  cstringArrayToSeq(gtk_source_style_scheme_manager_get_search_path(cast[ptr StyleSchemeManager00](self.impl)))

proc searchPath*(self: StyleSchemeManager): seq[string] =
  cstringArrayToSeq(gtk_source_style_scheme_manager_get_search_path(cast[ptr StyleSchemeManager00](self.impl)))

proc gtk_source_style_scheme_manager_prepend_search_path(self: ptr StyleSchemeManager00;
    path: cstring) {.
    importc, libprag.}

proc prependSearchPath*(self: StyleSchemeManager;
    path: cstring) =
  gtk_source_style_scheme_manager_prepend_search_path(cast[ptr StyleSchemeManager00](self.impl), path)

proc gtk_source_style_scheme_manager_set_search_path(self: ptr StyleSchemeManager00;
    path: ptr cstring) {.
    importc, libprag.}

proc setSearchPath*(self: StyleSchemeManager;
    path: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gtk_source_style_scheme_manager_set_search_path(cast[ptr StyleSchemeManager00](self.impl), seq2CstringArray(path, fs469n23))

proc `searchPath=`*(self: StyleSchemeManager;
    path: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gtk_source_style_scheme_manager_set_search_path(cast[ptr StyleSchemeManager00](self.impl), seq2CstringArray(path, fs469n23))

type
  StyleSchemePreview* = ref object of gtk4.Widget
  StyleSchemePreview00* = object of gtk4.Widget00

proc gtk_source_style_scheme_preview_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleSchemePreview()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActivate*(self: StyleSchemePreview;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "activate", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_style_scheme_preview_new(scheme: ptr StyleScheme00): ptr StyleSchemePreview00 {.
    importc, libprag.}

proc newStyleSchemePreview*(scheme: StyleScheme): StyleSchemePreview =
  let gobj = gtk_source_style_scheme_preview_new(cast[ptr StyleScheme00](scheme.impl))
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

proc newStyleSchemePreview*(tdesc: typedesc; scheme: StyleScheme): tdesc =
  assert(result is StyleSchemePreview)
  let gobj = gtk_source_style_scheme_preview_new(cast[ptr StyleScheme00](scheme.impl))
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

proc initStyleSchemePreview*[T](result: var T; scheme: StyleScheme) {.deprecated.} =
  assert(result is StyleSchemePreview)
  let gobj = gtk_source_style_scheme_preview_new(cast[ptr StyleScheme00](scheme.impl))
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

proc gtk_source_style_scheme_preview_get_scheme(self: ptr StyleSchemePreview00): ptr StyleScheme00 {.
    importc, libprag.}

proc getScheme*(self: StyleSchemePreview): StyleScheme =
  let gobj = gtk_source_style_scheme_preview_get_scheme(cast[ptr StyleSchemePreview00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc scheme*(self: StyleSchemePreview): StyleScheme =
  let gobj = gtk_source_style_scheme_preview_get_scheme(cast[ptr StyleSchemePreview00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_preview_get_selected(self: ptr StyleSchemePreview00): gboolean {.
    importc, libprag.}

proc getSelected*(self: StyleSchemePreview): bool =
  toBool(gtk_source_style_scheme_preview_get_selected(cast[ptr StyleSchemePreview00](self.impl)))

proc selected*(self: StyleSchemePreview): bool =
  toBool(gtk_source_style_scheme_preview_get_selected(cast[ptr StyleSchemePreview00](self.impl)))

proc gtk_source_style_scheme_preview_set_selected(self: ptr StyleSchemePreview00;
    selected: gboolean) {.
    importc, libprag.}

proc setSelected*(self: StyleSchemePreview;
    selected: bool = true) =
  gtk_source_style_scheme_preview_set_selected(cast[ptr StyleSchemePreview00](self.impl), gboolean(selected))

proc `selected=`*(self: StyleSchemePreview;
    selected: bool) =
  gtk_source_style_scheme_preview_set_selected(cast[ptr StyleSchemePreview00](self.impl), gboolean(selected))

type
  Tag* = ref object of gtk4.TextTag
  Tag00* = object of gtk4.TextTag00

proc gtk_source_tag_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Tag()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_tag_new(name: cstring): ptr Tag00 {.
    importc, libprag.}

proc newTag*(name: cstring = nil): Tag =
  let gobj = gtk_source_tag_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTag*(tdesc: typedesc; name: cstring = nil): tdesc =
  assert(result is Tag)
  let gobj = gtk_source_tag_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTag*[T](result: var T; name: cstring = nil) {.deprecated.} =
  assert(result is Tag)
  let gobj = gtk_source_tag_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ViewGutterPosition* {.size: sizeof(cint), pure.} = enum
    lines = -30
    marks = -20

type
  VimIMContext* = ref object of gtk4.IMContext
  VimIMContext00* = object of gtk4.IMContext00

proc gtk_source_vim_im_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VimIMContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scEdit*(self: VimIMContext;  p: proc (self: ptr VimIMContext00; view: ptr View00; path: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "edit", cast[GCallback](p), xdata, nil, cf)

proc scExecuteCommand*(self: VimIMContext;  p: proc (self: ptr VimIMContext00; command: cstring; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "execute-command", cast[GCallback](p), xdata, nil, cf)

proc scFormatText*(self: VimIMContext;  p: proc (self: ptr VimIMContext00; begin: gtk4.TextIter; `end`: gtk4.TextIter; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "format-text", cast[GCallback](p), xdata, nil, cf)

proc scWrite*(self: VimIMContext;  p: proc (self: ptr VimIMContext00; view: ptr View00; path: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "write", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_vim_im_context_new(): ptr VimIMContext00 {.
    importc, libprag.}

proc newVimIMContext*(): VimIMContext =
  let gobj = gtk_source_vim_im_context_new()
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

proc newVimIMContext*(tdesc: typedesc): tdesc =
  assert(result is VimIMContext)
  let gobj = gtk_source_vim_im_context_new()
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

proc initVimIMContext*[T](result: var T) {.deprecated.} =
  assert(result is VimIMContext)
  let gobj = gtk_source_vim_im_context_new()
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

proc gtk_source_vim_im_context_execute_command(self: ptr VimIMContext00;
    command: cstring) {.
    importc, libprag.}

proc executeCommand*(self: VimIMContext; command: cstring) =
  gtk_source_vim_im_context_execute_command(cast[ptr VimIMContext00](self.impl), command)

proc gtk_source_vim_im_context_get_command_bar_text(self: ptr VimIMContext00): cstring {.
    importc, libprag.}

proc getCommandBarText*(self: VimIMContext): string =
  result = $gtk_source_vim_im_context_get_command_bar_text(cast[ptr VimIMContext00](self.impl))

proc commandBarText*(self: VimIMContext): string =
  result = $gtk_source_vim_im_context_get_command_bar_text(cast[ptr VimIMContext00](self.impl))

proc gtk_source_vim_im_context_get_command_text(self: ptr VimIMContext00): cstring {.
    importc, libprag.}

proc getCommandText*(self: VimIMContext): string =
  result = $gtk_source_vim_im_context_get_command_text(cast[ptr VimIMContext00](self.impl))

proc commandText*(self: VimIMContext): string =
  result = $gtk_source_vim_im_context_get_command_text(cast[ptr VimIMContext00](self.impl))

proc gtk_source_check_version(major: uint32; minor: uint32; micro: uint32): gboolean {.
    importc, libprag.}

proc checkVersion*(major: int; minor: int; micro: int): bool =
  toBool(gtk_source_check_version(uint32(major), uint32(minor), uint32(micro)))

proc finalize*() {.
    importc: "gtk_source_finalize", libprag.}

proc gtk_source_get_major_version(): uint32 {.
    importc, libprag.}

proc getMajorVersion*(): int =
  int(gtk_source_get_major_version())

proc gtk_source_get_micro_version(): uint32 {.
    importc, libprag.}

proc getMicroVersion*(): int =
  int(gtk_source_get_micro_version())

proc gtk_source_get_minor_version(): uint32 {.
    importc, libprag.}

proc getMinorVersion*(): int =
  int(gtk_source_get_minor_version())

proc init*() {.
    importc: "gtk_source_init", libprag.}

proc schedulerAdd*(callback: SchedulerCallback; userData: pointer): uint64 {.
    importc: "gtk_source_scheduler_add", libprag.}

proc schedulerAddFull*(callback: SchedulerCallback; userData: pointer;
    notify: DestroyNotify): uint64 {.
    importc: "gtk_source_scheduler_add_full", libprag.}

proc schedulerRemove*(handlerId: uint64) {.
    importc: "gtk_source_scheduler_remove", libprag.}

proc gtk_source_utils_escape_search_text(text: cstring): cstring {.
    importc, libprag.}

proc utilsEscapeSearchText*(text: cstring): string =
  let resul0 = gtk_source_utils_escape_search_text(text)
  result = $resul0
  cogfree(resul0)

proc gtk_source_utils_unescape_search_text(text: cstring): cstring {.
    importc, libprag.}

proc utilsUnescapeSearchText*(text: cstring): string =
  let resul0 = gtk_source_utils_unescape_search_text(text)
  result = $resul0
  cogfree(resul0)
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc accessible*(x: gtksource5.CompletionCell): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: gtksource5.CompletionCell): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.CompletionCell): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc listModel*(x: gtksource5.CompletionContext): gio.ListModel = cast[gio.ListModel](x)

proc accessible*(x: gtksource5.Gutter): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: gtksource5.Gutter): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.Gutter): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: gtksource5.GutterRenderer): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: gtksource5.GutterRenderer): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.GutterRenderer): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: gtksource5.GutterRendererPixbuf): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: gtksource5.GutterRendererPixbuf): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.GutterRendererPixbuf): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: gtksource5.GutterRendererText): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: gtksource5.GutterRendererText): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.GutterRendererText): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: gtksource5.HoverDisplay): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: gtksource5.HoverDisplay): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.HoverDisplay): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: gtksource5.Map): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: gtksource5.Map): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.Map): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc scrollable*(x: gtksource5.Map): gtk4.Scrollable = cast[gtk4.Scrollable](x)

proc accessible*(x: gtksource5.StyleSchemeChooserButton): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: gtksource5.StyleSchemeChooserButton): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: gtksource5.StyleSchemeChooserButton): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.StyleSchemeChooserButton): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: gtksource5.StyleSchemeChooserWidget): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: gtksource5.StyleSchemeChooserWidget): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.StyleSchemeChooserWidget): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: gtksource5.StyleSchemePreview): gtk4.Accessible = cast[gtk4.Accessible](x)

proc actionable*(x: gtksource5.StyleSchemePreview): gtk4.Actionable = cast[gtk4.Actionable](x)

proc buildable*(x: gtksource5.StyleSchemePreview): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.StyleSchemePreview): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc accessible*(x: gtksource5.View): gtk4.Accessible = cast[gtk4.Accessible](x)

proc buildable*(x: gtksource5.View): gtk4.Buildable = cast[gtk4.Buildable](x)

proc constraintTarget*(x: gtksource5.View): gtk4.ConstraintTarget = cast[gtk4.ConstraintTarget](x)

proc scrollable*(x: gtksource5.View): gtk4.Scrollable = cast[gtk4.Scrollable](x)

proc getView*(builder: Builder; name: string): View =
  let gt = g_type_from_name("GSource")
  assert(gt != g_type_invalid_get_type())
  let gobj = gtk_builder_get_object(cast[ptr Builder00](builder.impl), name)
  assert(gobj != nil)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[type(result)](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    result.ignoreFinalizer = true
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  assert(toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](result.impl), gt)))

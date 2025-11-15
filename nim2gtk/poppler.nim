# dependencies:
# GObject-2.0
# cairo-1.0
# GLib-2.0
# GModule-2.0
# Gio-2.0
# immediate dependencies:
# cairo-1.0
# Gio-2.0
# GObject-2.0
# libraries:
# libpoppler-glib.so.8,libpoppler.so.134
{.warning[UnusedImport]: off.}
import gobject, cairo, glib, gmodule, gio
const Lib = "libpoppler-glib.so.8"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const ANNOT_TEXT_ICON_CIRCLE* = "Circle"

const ANNOT_TEXT_ICON_COMMENT* = "Comment"

const ANNOT_TEXT_ICON_CROSS* = "Cross"

const ANNOT_TEXT_ICON_HELP* = "Help"

const ANNOT_TEXT_ICON_INSERT* = "Insert"

const ANNOT_TEXT_ICON_KEY* = "Key"

const ANNOT_TEXT_ICON_NEW_PARAGRAPH* = "NewParagraph"

const ANNOT_TEXT_ICON_NOTE* = "Note"

const ANNOT_TEXT_ICON_PARAGRAPH* = "Paragraph"

type
  Action00* {.pure, union.} = object
  Action* = ref object
    impl*: ptr Action00
    ignoreFinalizer*: bool

proc poppler_action_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerAction*(self: Action) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_action_get_type(), cast[ptr Action00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Action()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_action_get_type(), cast[ptr Action00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Action) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerAction)

proc poppler_action_free(self: ptr Action00) {.
    importc, libprag.}

proc free*(self: Action) =
  poppler_action_free(cast[ptr Action00](self.impl))

proc finalizerfree*(self: Action) =
  if not self.ignoreFinalizer:
    poppler_action_free(cast[ptr Action00](self.impl))

proc poppler_action_copy(self: ptr Action00): ptr Action00 {.
    importc, libprag.}

proc copy*(self: Action): Action =
  fnew(result, gBoxedFreePopplerAction)
  result.impl = poppler_action_copy(cast[ptr Action00](self.impl))

type
  ActionAny00* {.pure.} = object
  ActionAny* = ref object
    impl*: ptr ActionAny00
    ignoreFinalizer*: bool

type
  ActionGotoDest00* {.pure.} = object
  ActionGotoDest* = ref object
    impl*: ptr ActionGotoDest00
    ignoreFinalizer*: bool

type
  ActionGotoRemote00* {.pure.} = object
  ActionGotoRemote* = ref object
    impl*: ptr ActionGotoRemote00
    ignoreFinalizer*: bool

type
  ActionJavascript00* {.pure.} = object
  ActionJavascript* = ref object
    impl*: ptr ActionJavascript00
    ignoreFinalizer*: bool

type
  ActionLaunch00* {.pure.} = object
  ActionLaunch* = ref object
    impl*: ptr ActionLaunch00
    ignoreFinalizer*: bool

type
  ActionLayer00* {.pure.} = object
  ActionLayer* = ref object
    impl*: ptr ActionLayer00
    ignoreFinalizer*: bool

type
  ActionLayerAction* {.size: sizeof(cint), pure.} = enum
    on = 0
    off = 1
    toggle = 2

type
  ActionMovie00* {.pure.} = object
  ActionMovie* = ref object
    impl*: ptr ActionMovie00
    ignoreFinalizer*: bool

type
  ActionMovieOperation* {.size: sizeof(cint), pure.} = enum
    play = 0
    pause = 1
    resume = 2
    stop = 3

type
  ActionNamed00* {.pure.} = object
  ActionNamed* = ref object
    impl*: ptr ActionNamed00
    ignoreFinalizer*: bool

type
  ActionOCGState00* {.pure.} = object
  ActionOCGState* = ref object
    impl*: ptr ActionOCGState00
    ignoreFinalizer*: bool

type
  ActionRendition00* {.pure.} = object
  ActionRendition* = ref object
    impl*: ptr ActionRendition00
    ignoreFinalizer*: bool

type
  ActionResetForm00* {.pure.} = object
  ActionResetForm* = ref object
    impl*: ptr ActionResetForm00
    ignoreFinalizer*: bool

type
  ActionType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    none = 1
    gotoDest = 2
    gotoRemote = 3
    launch = 4
    uri = 5
    named = 6
    movie = 7
    rendition = 8
    ocgState = 9
    javascript = 10
    resetForm = 11

type
  ActionUri00* {.pure.} = object
  ActionUri* = ref object
    impl*: ptr ActionUri00
    ignoreFinalizer*: bool

type
  AdditionalActionType* {.size: sizeof(cint), pure.} = enum
    fieldModified = 0
    formatField = 1
    validateField = 2
    calculateField = 3

type
  Annot* = ref object of gobject.Object
  Annot00* = object of gobject.Object00

proc poppler_annot_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Annot()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_get_contents(self: ptr Annot00): cstring {.
    importc, libprag.}

proc getContents*(self: Annot): string =
  let resul0 = poppler_annot_get_contents(cast[ptr Annot00](self.impl))
  result = $resul0
  cogfree(resul0)

proc contents*(self: Annot): string =
  let resul0 = poppler_annot_get_contents(cast[ptr Annot00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_annot_get_modified(self: ptr Annot00): cstring {.
    importc, libprag.}

proc getModified*(self: Annot): string =
  let resul0 = poppler_annot_get_modified(cast[ptr Annot00](self.impl))
  result = $resul0
  cogfree(resul0)

proc modified*(self: Annot): string =
  let resul0 = poppler_annot_get_modified(cast[ptr Annot00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_annot_get_name(self: ptr Annot00): cstring {.
    importc, libprag.}

proc getName*(self: Annot): string =
  let resul0 = poppler_annot_get_name(cast[ptr Annot00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: Annot): string =
  let resul0 = poppler_annot_get_name(cast[ptr Annot00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_annot_get_page_index(self: ptr Annot00): int32 {.
    importc, libprag.}

proc getPageIndex*(self: Annot): int =
  int(poppler_annot_get_page_index(cast[ptr Annot00](self.impl)))

proc pageIndex*(self: Annot): int =
  int(poppler_annot_get_page_index(cast[ptr Annot00](self.impl)))

proc poppler_annot_set_contents(self: ptr Annot00; contents: cstring) {.
    importc, libprag.}

proc setContents*(self: Annot; contents: cstring) =
  poppler_annot_set_contents(cast[ptr Annot00](self.impl), contents)

proc `contents=`*(self: Annot; contents: cstring) =
  poppler_annot_set_contents(cast[ptr Annot00](self.impl), contents)

type
  AnnotType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    text = 1
    link = 2
    freeText = 3
    line = 4
    square = 5
    circle = 6
    polygon = 7
    polyLine = 8
    highlight = 9
    underline = 10
    squiggly = 11
    strikeOut = 12
    stamp = 13
    caret = 14
    ink = 15
    popup = 16
    fileAttachment = 17
    sound = 18
    movie = 19
    widget = 20
    screen = 21
    printerMark = 22
    trapNet = 23
    watermark = 24
    d3 = 25

proc poppler_annot_get_annot_type(self: ptr Annot00): AnnotType {.
    importc, libprag.}

proc getAnnotType*(self: Annot): AnnotType =
  poppler_annot_get_annot_type(cast[ptr Annot00](self.impl))

proc annotType*(self: Annot): AnnotType =
  poppler_annot_get_annot_type(cast[ptr Annot00](self.impl))

type
  Color00* {.pure.} = object
  Color* = ref object
    impl*: ptr Color00
    ignoreFinalizer*: bool

proc poppler_color_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerColor*(self: Color) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_color_get_type(), cast[ptr Color00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Color()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_color_get_type(), cast[ptr Color00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Color) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerColor)

proc poppler_color_free(self: ptr Color00) {.
    importc, libprag.}

proc free*(self: Color) =
  poppler_color_free(cast[ptr Color00](self.impl))

proc finalizerfree*(self: Color) =
  if not self.ignoreFinalizer:
    poppler_color_free(cast[ptr Color00](self.impl))

proc poppler_color_copy(self: ptr Color00): ptr Color00 {.
    importc, libprag.}

proc copy*(self: Color): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_color_copy(cast[ptr Color00](self.impl))

proc poppler_color_new(): ptr Color00 {.
    importc, libprag.}

proc newColor*(): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_color_new()

proc newColor*(tdesc: typedesc): tdesc =
  assert(result is Color)
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_color_new()

proc initColor*[T](result: var T) {.deprecated.} =
  assert(result is Color)
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_color_new()

proc poppler_annot_get_color(self: ptr Annot00): ptr Color00 {.
    importc, libprag.}

proc getColor*(self: Annot): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_annot_get_color(cast[ptr Annot00](self.impl))

proc color*(self: Annot): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_annot_get_color(cast[ptr Annot00](self.impl))

proc poppler_annot_set_color(self: ptr Annot00; popplerColor: ptr Color00) {.
    importc, libprag.}

proc setColor*(self: Annot; popplerColor: Color = nil) =
  poppler_annot_set_color(cast[ptr Annot00](self.impl), if popplerColor.isNil: nil else: cast[ptr Color00](popplerColor.impl))

proc `color=`*(self: Annot; popplerColor: Color = nil) =
  poppler_annot_set_color(cast[ptr Annot00](self.impl), if popplerColor.isNil: nil else: cast[ptr Color00](popplerColor.impl))

type
  AnnotFlagFlag* {.size: sizeof(cint), pure.} = enum
    invisible = 0
    hidden = 1
    print = 2
    noZoom = 3
    noRotate = 4
    noView = 5
    readOnly = 6
    locked = 7
    toggleNoView = 8
    lockedContents = 9

  AnnotFlag* = set[AnnotFlagFlag]

const
  AnnotFlagUnknown* = AnnotFlag({})
proc unknown*(t: typedesc[AnnotFlag]): AnnotFlag = AnnotFlag({})

proc poppler_annot_get_flags(self: ptr Annot00): AnnotFlag {.
    importc, libprag.}

proc getFlags*(self: Annot): AnnotFlag =
  poppler_annot_get_flags(cast[ptr Annot00](self.impl))

proc flags*(self: Annot): AnnotFlag =
  poppler_annot_get_flags(cast[ptr Annot00](self.impl))

proc poppler_annot_set_flags(self: ptr Annot00; flags: AnnotFlag) {.
    importc, libprag.}

proc setFlags*(self: Annot; flags: AnnotFlag) =
  poppler_annot_set_flags(cast[ptr Annot00](self.impl), flags)

proc `flags=`*(self: Annot; flags: AnnotFlag) =
  poppler_annot_set_flags(cast[ptr Annot00](self.impl), flags)

type
  Rectangle00* {.pure.} = object
    x1*: cdouble
    y1*: cdouble
    x2*: cdouble
    y2*: cdouble
  Rectangle* = ref object
    impl*: ptr Rectangle00
    ignoreFinalizer*: bool

proc poppler_rectangle_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerRectangle*(self: Rectangle) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_rectangle_get_type(), cast[ptr Rectangle00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Rectangle()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_rectangle_get_type(), cast[ptr Rectangle00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Rectangle) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerRectangle)

proc poppler_rectangle_free(self: ptr Rectangle00) {.
    importc, libprag.}

proc free*(self: Rectangle) =
  poppler_rectangle_free(cast[ptr Rectangle00](self.impl))

proc finalizerfree*(self: Rectangle) =
  if not self.ignoreFinalizer:
    poppler_rectangle_free(cast[ptr Rectangle00](self.impl))

proc poppler_rectangle_copy(self: ptr Rectangle00): ptr Rectangle00 {.
    importc, libprag.}

proc copy*(self: Rectangle): Rectangle =
  fnew(result, gBoxedFreePopplerRectangle)
  result.impl = poppler_rectangle_copy(cast[ptr Rectangle00](self.impl))

proc poppler_rectangle_find_get_ignored_hyphen(self: ptr Rectangle00): gboolean {.
    importc, libprag.}

proc findGetIgnoredHyphen*(self: Rectangle): bool =
  toBool(poppler_rectangle_find_get_ignored_hyphen(cast[ptr Rectangle00](self.impl)))

proc poppler_rectangle_find_get_match_continued(self: ptr Rectangle00): gboolean {.
    importc, libprag.}

proc findGetMatchContinued*(self: Rectangle): bool =
  toBool(poppler_rectangle_find_get_match_continued(cast[ptr Rectangle00](self.impl)))

proc poppler_rectangle_new(): ptr Rectangle00 {.
    importc, libprag.}

proc newRectangle*(): Rectangle =
  fnew(result, gBoxedFreePopplerRectangle)
  result.impl = poppler_rectangle_new()

proc newRectangle*(tdesc: typedesc): tdesc =
  assert(result is Rectangle)
  fnew(result, gBoxedFreePopplerRectangle)
  result.impl = poppler_rectangle_new()

proc initRectangle*[T](result: var T) {.deprecated.} =
  assert(result is Rectangle)
  fnew(result, gBoxedFreePopplerRectangle)
  result.impl = poppler_rectangle_new()

proc poppler_annot_get_rectangle(self: ptr Annot00; popplerRect: var Rectangle00) {.
    importc, libprag.}

proc getRectangle*(self: Annot; popplerRect: var Rectangle00) =
  poppler_annot_get_rectangle(cast[ptr Annot00](self.impl), popplerRect)

proc getRectangle*(self: Annot): Rectangle00 =
  poppler_annot_get_rectangle(cast[ptr Annot00](self.impl), result)

proc poppler_annot_set_rectangle(self: ptr Annot00; popplerRect: ptr Rectangle00) {.
    importc, libprag.}

proc setRectangle*(self: Annot; popplerRect: Rectangle) =
  poppler_annot_set_rectangle(cast[ptr Annot00](self.impl), cast[ptr Rectangle00](popplerRect.impl))

proc `rectangle=`*(self: Annot; popplerRect: Rectangle) =
  poppler_annot_set_rectangle(cast[ptr Annot00](self.impl), cast[ptr Rectangle00](popplerRect.impl))

type
  AnnotCalloutLine00* {.pure.} = object
  AnnotCalloutLine* = ref object
    impl*: ptr AnnotCalloutLine00
    ignoreFinalizer*: bool

proc poppler_annot_callout_line_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerAnnotCalloutLine*(self: AnnotCalloutLine) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_annot_callout_line_get_type(), cast[ptr AnnotCalloutLine00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotCalloutLine()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_annot_callout_line_get_type(), cast[ptr AnnotCalloutLine00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AnnotCalloutLine) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerAnnotCalloutLine)

proc poppler_annot_callout_line_free(self: ptr AnnotCalloutLine00) {.
    importc, libprag.}

proc free*(self: AnnotCalloutLine) =
  poppler_annot_callout_line_free(cast[ptr AnnotCalloutLine00](self.impl))

proc finalizerfree*(self: AnnotCalloutLine) =
  if not self.ignoreFinalizer:
    poppler_annot_callout_line_free(cast[ptr AnnotCalloutLine00](self.impl))

proc poppler_annot_callout_line_copy(self: ptr AnnotCalloutLine00): ptr AnnotCalloutLine00 {.
    importc, libprag.}

proc copy*(self: AnnotCalloutLine): AnnotCalloutLine =
  fnew(result, gBoxedFreePopplerAnnotCalloutLine)
  result.impl = poppler_annot_callout_line_copy(cast[ptr AnnotCalloutLine00](self.impl))

proc poppler_annot_callout_line_new(): ptr AnnotCalloutLine00 {.
    importc, libprag.}

proc newAnnotCalloutLine*(): AnnotCalloutLine =
  fnew(result, gBoxedFreePopplerAnnotCalloutLine)
  result.impl = poppler_annot_callout_line_new()

proc newAnnotCalloutLine*(tdesc: typedesc): tdesc =
  assert(result is AnnotCalloutLine)
  fnew(result, gBoxedFreePopplerAnnotCalloutLine)
  result.impl = poppler_annot_callout_line_new()

proc initAnnotCalloutLine*[T](result: var T) {.deprecated.} =
  assert(result is AnnotCalloutLine)
  fnew(result, gBoxedFreePopplerAnnotCalloutLine)
  result.impl = poppler_annot_callout_line_new()

type
  AnnotMarkup* = ref object of Annot
  AnnotMarkup00* = object of Annot00

proc poppler_annot_markup_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotMarkup()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_markup_get_date(self: ptr AnnotMarkup00): ptr glib.Date00 {.
    importc, libprag.}

proc getDate*(self: AnnotMarkup): glib.Date =
  fnew(result, gBoxedFreeGDate)
  result.impl = poppler_annot_markup_get_date(cast[ptr AnnotMarkup00](self.impl))

proc date*(self: AnnotMarkup): glib.Date =
  fnew(result, gBoxedFreeGDate)
  result.impl = poppler_annot_markup_get_date(cast[ptr AnnotMarkup00](self.impl))

proc poppler_annot_markup_get_label(self: ptr AnnotMarkup00): cstring {.
    importc, libprag.}

proc getLabel*(self: AnnotMarkup): string =
  let resul0 = poppler_annot_markup_get_label(cast[ptr AnnotMarkup00](self.impl))
  result = $resul0
  cogfree(resul0)

proc label*(self: AnnotMarkup): string =
  let resul0 = poppler_annot_markup_get_label(cast[ptr AnnotMarkup00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_annot_markup_get_opacity(self: ptr AnnotMarkup00): cdouble {.
    importc, libprag.}

proc getOpacity*(self: AnnotMarkup): cdouble =
  poppler_annot_markup_get_opacity(cast[ptr AnnotMarkup00](self.impl))

proc opacity*(self: AnnotMarkup): cdouble =
  poppler_annot_markup_get_opacity(cast[ptr AnnotMarkup00](self.impl))

proc poppler_annot_markup_get_popup_is_open(self: ptr AnnotMarkup00): gboolean {.
    importc, libprag.}

proc getPopupIsOpen*(self: AnnotMarkup): bool =
  toBool(poppler_annot_markup_get_popup_is_open(cast[ptr AnnotMarkup00](self.impl)))

proc popupIsOpen*(self: AnnotMarkup): bool =
  toBool(poppler_annot_markup_get_popup_is_open(cast[ptr AnnotMarkup00](self.impl)))

proc poppler_annot_markup_get_popup_rectangle(self: ptr AnnotMarkup00; popplerRect: var Rectangle00): gboolean {.
    importc, libprag.}

proc getPopupRectangle*(self: AnnotMarkup; popplerRect: var Rectangle00): bool =
  toBool(poppler_annot_markup_get_popup_rectangle(cast[ptr AnnotMarkup00](self.impl), popplerRect))

proc poppler_annot_markup_get_subject(self: ptr AnnotMarkup00): cstring {.
    importc, libprag.}

proc getSubject*(self: AnnotMarkup): string =
  let resul0 = poppler_annot_markup_get_subject(cast[ptr AnnotMarkup00](self.impl))
  result = $resul0
  cogfree(resul0)

proc subject*(self: AnnotMarkup): string =
  let resul0 = poppler_annot_markup_get_subject(cast[ptr AnnotMarkup00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_annot_markup_has_popup(self: ptr AnnotMarkup00): gboolean {.
    importc, libprag.}

proc hasPopup*(self: AnnotMarkup): bool =
  toBool(poppler_annot_markup_has_popup(cast[ptr AnnotMarkup00](self.impl)))

proc poppler_annot_markup_set_label(self: ptr AnnotMarkup00; label: cstring) {.
    importc, libprag.}

proc setLabel*(self: AnnotMarkup; label: cstring = nil) =
  poppler_annot_markup_set_label(cast[ptr AnnotMarkup00](self.impl), label)

proc `label=`*(self: AnnotMarkup; label: cstring = nil) =
  poppler_annot_markup_set_label(cast[ptr AnnotMarkup00](self.impl), label)

proc poppler_annot_markup_set_opacity(self: ptr AnnotMarkup00; opacity: cdouble) {.
    importc, libprag.}

proc setOpacity*(self: AnnotMarkup; opacity: cdouble) =
  poppler_annot_markup_set_opacity(cast[ptr AnnotMarkup00](self.impl), opacity)

proc `opacity=`*(self: AnnotMarkup; opacity: cdouble) =
  poppler_annot_markup_set_opacity(cast[ptr AnnotMarkup00](self.impl), opacity)

proc poppler_annot_markup_set_popup(self: ptr AnnotMarkup00; popupRect: ptr Rectangle00) {.
    importc, libprag.}

proc setPopup*(self: AnnotMarkup; popupRect: Rectangle) =
  poppler_annot_markup_set_popup(cast[ptr AnnotMarkup00](self.impl), cast[ptr Rectangle00](popupRect.impl))

proc `popup=`*(self: AnnotMarkup; popupRect: Rectangle) =
  poppler_annot_markup_set_popup(cast[ptr AnnotMarkup00](self.impl), cast[ptr Rectangle00](popupRect.impl))

proc poppler_annot_markup_set_popup_is_open(self: ptr AnnotMarkup00; isOpen: gboolean) {.
    importc, libprag.}

proc setPopupIsOpen*(self: AnnotMarkup; isOpen: bool = true) =
  poppler_annot_markup_set_popup_is_open(cast[ptr AnnotMarkup00](self.impl), gboolean(isOpen))

proc `popupIsOpen=`*(self: AnnotMarkup; isOpen: bool) =
  poppler_annot_markup_set_popup_is_open(cast[ptr AnnotMarkup00](self.impl), gboolean(isOpen))

proc poppler_annot_markup_set_popup_rectangle(self: ptr AnnotMarkup00; popplerRect: ptr Rectangle00) {.
    importc, libprag.}

proc setPopupRectangle*(self: AnnotMarkup; popplerRect: Rectangle) =
  poppler_annot_markup_set_popup_rectangle(cast[ptr AnnotMarkup00](self.impl), cast[ptr Rectangle00](popplerRect.impl))

proc `popupRectangle=`*(self: AnnotMarkup; popplerRect: Rectangle) =
  poppler_annot_markup_set_popup_rectangle(cast[ptr AnnotMarkup00](self.impl), cast[ptr Rectangle00](popplerRect.impl))

type
  AnnotCircle* = ref object of AnnotMarkup
  AnnotCircle00* = object of AnnotMarkup00

proc poppler_annot_circle_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotCircle()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_circle_get_interior_color(self: ptr AnnotCircle00): ptr Color00 {.
    importc, libprag.}

proc getInteriorColor*(self: AnnotCircle): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_annot_circle_get_interior_color(cast[ptr AnnotCircle00](self.impl))

proc interiorColor*(self: AnnotCircle): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_annot_circle_get_interior_color(cast[ptr AnnotCircle00](self.impl))

proc poppler_annot_circle_set_interior_color(self: ptr AnnotCircle00; popplerColor: ptr Color00) {.
    importc, libprag.}

proc setInteriorColor*(self: AnnotCircle; popplerColor: Color = nil) =
  poppler_annot_circle_set_interior_color(cast[ptr AnnotCircle00](self.impl), if popplerColor.isNil: nil else: cast[ptr Color00](popplerColor.impl))

proc `interiorColor=`*(self: AnnotCircle; popplerColor: Color = nil) =
  poppler_annot_circle_set_interior_color(cast[ptr AnnotCircle00](self.impl), if popplerColor.isNil: nil else: cast[ptr Color00](popplerColor.impl))

type
  AnnotExternalDataType* {.size: sizeof(cint), pure.} = enum
    d3 = 0
    unknown = 1

proc poppler_annot_markup_get_external_data(self: ptr AnnotMarkup00): AnnotExternalDataType {.
    importc, libprag.}

proc getExternalData*(self: AnnotMarkup): AnnotExternalDataType =
  poppler_annot_markup_get_external_data(cast[ptr AnnotMarkup00](self.impl))

proc externalData*(self: AnnotMarkup): AnnotExternalDataType =
  poppler_annot_markup_get_external_data(cast[ptr AnnotMarkup00](self.impl))

type
  AnnotMarkupReplyType* {.size: sizeof(cint), pure.} = enum
    r = 0
    group = 1

proc poppler_annot_markup_get_reply_to(self: ptr AnnotMarkup00): AnnotMarkupReplyType {.
    importc, libprag.}

proc getReplyTo*(self: AnnotMarkup): AnnotMarkupReplyType =
  poppler_annot_markup_get_reply_to(cast[ptr AnnotMarkup00](self.impl))

proc replyTo*(self: AnnotMarkup): AnnotMarkupReplyType =
  poppler_annot_markup_get_reply_to(cast[ptr AnnotMarkup00](self.impl))

type
  Document* = ref object of gobject.Object
  Document00* = object of gobject.Object00

proc poppler_document_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Document()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_document_new_from_bytes(bytes: ptr glib.Bytes00; password: cstring;
    error: ptr ptr glib.Error = nil): ptr Document00 {.
    importc, libprag.}

proc newDocumentFromBytes*(bytes: glib.Bytes; password: cstring = nil): Document =
  var gerror: ptr glib.Error
  let gobj = poppler_document_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl), password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newDocumentFromBytes*(tdesc: typedesc; bytes: glib.Bytes; password: cstring = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl), password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDocumentFromBytes*[T](result: var T; bytes: glib.Bytes; password: cstring = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl), password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_document_new_from_data(data: ptr uint8; length: int32; password: cstring;
    error: ptr ptr glib.Error = nil): ptr Document00 {.
    importc, libprag.}

proc newDocumentFromData*(data: seq[uint8] | string; password: cstring = nil): Document {.deprecated.}  =
  let length = int(data.len)
  var gerror: ptr glib.Error
  let gobj = poppler_document_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), int32(length), password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newDocumentFromData*(tdesc: typedesc; data: seq[uint8] | string; password: cstring = nil): tdesc {.deprecated.}  =
  let length = int(data.len)
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), int32(length), password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDocumentFromData*[T](result: var T; data: seq[uint8] | string; password: cstring = nil) {.deprecated.} =
  let length = int(data.len)
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), int32(length), password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_document_new_from_fd(fd: int32; password: cstring; error: ptr ptr glib.Error = nil): ptr Document00 {.
    importc, libprag.}

proc newDocumentFromFd*(fd: int; password: cstring = nil): Document =
  var gerror: ptr glib.Error
  let gobj = poppler_document_new_from_fd(int32(fd), password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newDocumentFromFd*(tdesc: typedesc; fd: int; password: cstring = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_fd(int32(fd), password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDocumentFromFd*[T](result: var T; fd: int; password: cstring = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_fd(int32(fd), password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_document_new_from_file(uri: cstring; password: cstring; error: ptr ptr glib.Error = nil): ptr Document00 {.
    importc, libprag.}

proc newDocumentFromFile*(uri: cstring; password: cstring = nil): Document =
  var gerror: ptr glib.Error
  let gobj = poppler_document_new_from_file(uri, password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newDocumentFromFile*(tdesc: typedesc; uri: cstring; password: cstring = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_file(uri, password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDocumentFromFile*[T](result: var T; uri: cstring; password: cstring = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_file(uri, password, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_document_new_from_gfile(file: ptr gio.GFile00; password: cstring;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): ptr Document00 {.
    importc, libprag.}

proc newDocumentFromGfile*(file: gio.GFile; password: cstring = nil;
    cancellable: gio.Cancellable = nil): Document =
  var gerror: ptr glib.Error
  let gobj = poppler_document_new_from_gfile(cast[ptr gio.GFile00](file.impl), password, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newDocumentFromGfile*(tdesc: typedesc; file: gio.GFile; password: cstring = nil;
    cancellable: gio.Cancellable = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_gfile(cast[ptr gio.GFile00](file.impl), password, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDocumentFromGfile*[T](result: var T; file: gio.GFile; password: cstring = nil;
    cancellable: gio.Cancellable = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_gfile(cast[ptr gio.GFile00](file.impl), password, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_document_new_from_stream(stream: ptr gio.InputStream00; length: int64;
    password: cstring; cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): ptr Document00 {.
    importc, libprag.}

proc newDocumentFromStream*(stream: gio.InputStream; length: int64;
    password: cstring = nil; cancellable: gio.Cancellable = nil): Document =
  var gerror: ptr glib.Error
  let gobj = poppler_document_new_from_stream(cast[ptr gio.InputStream00](stream.impl), length, password, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newDocumentFromStream*(tdesc: typedesc; stream: gio.InputStream; length: int64;
    password: cstring = nil; cancellable: gio.Cancellable = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_stream(cast[ptr gio.InputStream00](stream.impl), length, password, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDocumentFromStream*[T](result: var T; stream: gio.InputStream; length: int64;
    password: cstring = nil; cancellable: gio.Cancellable = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Document)
  let gobj = poppler_document_new_from_stream(cast[ptr gio.InputStream00](stream.impl), length, password, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_document_create_dests_tree(self: ptr Document00): ptr glib.Tree00 {.
    importc, libprag.}

proc createDestsTree*(self: Document): glib.Tree =
  let impl0 = poppler_document_create_dests_tree(cast[ptr Document00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGTree)
  result.impl = impl0

proc poppler_document_get_author(self: ptr Document00): cstring {.
    importc, libprag.}

proc getAuthor*(self: Document): string =
  let resul0 = poppler_document_get_author(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc author*(self: Document): string =
  let resul0 = poppler_document_get_author(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_document_get_creation_date(self: ptr Document00): int64 {.
    importc, libprag.}

proc getCreationDate*(self: Document): int64 =
  poppler_document_get_creation_date(cast[ptr Document00](self.impl))

proc creationDate*(self: Document): int64 =
  poppler_document_get_creation_date(cast[ptr Document00](self.impl))

proc poppler_document_get_creation_date_time(self: ptr Document00): ptr glib.DateTime00 {.
    importc, libprag.}

proc getCreationDateTime*(self: Document): glib.DateTime =
  let impl0 = poppler_document_get_creation_date_time(cast[ptr Document00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc creationDateTime*(self: Document): glib.DateTime =
  let impl0 = poppler_document_get_creation_date_time(cast[ptr Document00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc poppler_document_get_creator(self: ptr Document00): cstring {.
    importc, libprag.}

proc getCreator*(self: Document): string =
  let resul0 = poppler_document_get_creator(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc creator*(self: Document): string =
  let resul0 = poppler_document_get_creator(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_document_get_id(self: ptr Document00; permanentId: var cstring;
    updateId: var cstring): gboolean {.
    importc, libprag.}

proc getId*(self: Document; permanentId: var string = cast[var string](nil);
    updateId: var string = cast[var string](nil)): bool =
  var updateId_00: cstring
  var permanentId_00: cstring
  result = toBool(poppler_document_get_id(cast[ptr Document00](self.impl), permanentId_00, updateId_00))
  if updateId.addr != nil:
    updateId = $(updateId_00)
  if permanentId.addr != nil:
    permanentId = $(permanentId_00)

proc poppler_document_get_keywords(self: ptr Document00): cstring {.
    importc, libprag.}

proc getKeywords*(self: Document): string =
  let resul0 = poppler_document_get_keywords(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc keywords*(self: Document): string =
  let resul0 = poppler_document_get_keywords(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_document_get_metadata(self: ptr Document00): cstring {.
    importc, libprag.}

proc getMetadata*(self: Document): string =
  let resul0 = poppler_document_get_metadata(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc metadata*(self: Document): string =
  let resul0 = poppler_document_get_metadata(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_document_get_modification_date(self: ptr Document00): int64 {.
    importc, libprag.}

proc getModificationDate*(self: Document): int64 =
  poppler_document_get_modification_date(cast[ptr Document00](self.impl))

proc modificationDate*(self: Document): int64 =
  poppler_document_get_modification_date(cast[ptr Document00](self.impl))

proc poppler_document_get_modification_date_time(self: ptr Document00): ptr glib.DateTime00 {.
    importc, libprag.}

proc getModificationDateTime*(self: Document): glib.DateTime =
  let impl0 = poppler_document_get_modification_date_time(cast[ptr Document00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc modificationDateTime*(self: Document): glib.DateTime =
  let impl0 = poppler_document_get_modification_date_time(cast[ptr Document00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc poppler_document_get_n_attachments(self: ptr Document00): uint32 {.
    importc, libprag.}

proc getNAttachments*(self: Document): int =
  int(poppler_document_get_n_attachments(cast[ptr Document00](self.impl)))

proc nAttachments*(self: Document): int =
  int(poppler_document_get_n_attachments(cast[ptr Document00](self.impl)))

proc poppler_document_get_n_pages(self: ptr Document00): int32 {.
    importc, libprag.}

proc getNPages*(self: Document): int =
  int(poppler_document_get_n_pages(cast[ptr Document00](self.impl)))

proc nPages*(self: Document): int =
  int(poppler_document_get_n_pages(cast[ptr Document00](self.impl)))

proc poppler_document_get_n_signatures(self: ptr Document00): int32 {.
    importc, libprag.}

proc getNSignatures*(self: Document): int =
  int(poppler_document_get_n_signatures(cast[ptr Document00](self.impl)))

proc nSignatures*(self: Document): int =
  int(poppler_document_get_n_signatures(cast[ptr Document00](self.impl)))

proc poppler_document_get_pdf_subtype_string(self: ptr Document00): cstring {.
    importc, libprag.}

proc getPdfSubtypeString*(self: Document): string =
  let resul0 = poppler_document_get_pdf_subtype_string(cast[ptr Document00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc pdfSubtypeString*(self: Document): string =
  let resul0 = poppler_document_get_pdf_subtype_string(cast[ptr Document00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc poppler_document_get_pdf_version(self: ptr Document00; majorVersion: var uint32;
    minorVersion: var uint32) {.
    importc, libprag.}

proc getPdfVersion*(self: Document; majorVersion: var int;
    minorVersion: var int) =
  var minorVersion_00: uint32
  var majorVersion_00: uint32
  poppler_document_get_pdf_version(cast[ptr Document00](self.impl), majorVersion_00, minorVersion_00)
  if minorVersion.addr != nil:
    minorVersion = int(minorVersion_00)
  if majorVersion.addr != nil:
    majorVersion = int(majorVersion_00)

proc poppler_document_get_pdf_version_string(self: ptr Document00): cstring {.
    importc, libprag.}

proc getPdfVersionString*(self: Document): string =
  let resul0 = poppler_document_get_pdf_version_string(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc pdfVersionString*(self: Document): string =
  let resul0 = poppler_document_get_pdf_version_string(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_document_get_print_n_copies(self: ptr Document00): int32 {.
    importc, libprag.}

proc getPrintNCopies*(self: Document): int =
  int(poppler_document_get_print_n_copies(cast[ptr Document00](self.impl)))

proc printNCopies*(self: Document): int =
  int(poppler_document_get_print_n_copies(cast[ptr Document00](self.impl)))

proc poppler_document_get_producer(self: ptr Document00): cstring {.
    importc, libprag.}

proc getProducer*(self: Document): string =
  let resul0 = poppler_document_get_producer(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc producer*(self: Document): string =
  let resul0 = poppler_document_get_producer(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_document_get_subject(self: ptr Document00): cstring {.
    importc, libprag.}

proc getSubject*(self: Document): string =
  let resul0 = poppler_document_get_subject(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc subject*(self: Document): string =
  let resul0 = poppler_document_get_subject(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_document_get_title(self: ptr Document00): cstring {.
    importc, libprag.}

proc getTitle*(self: Document): string =
  let resul0 = poppler_document_get_title(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc title*(self: Document): string =
  let resul0 = poppler_document_get_title(cast[ptr Document00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_document_has_attachments(self: ptr Document00): gboolean {.
    importc, libprag.}

proc hasAttachments*(self: Document): bool =
  toBool(poppler_document_has_attachments(cast[ptr Document00](self.impl)))

proc poppler_document_has_javascript(self: ptr Document00): gboolean {.
    importc, libprag.}

proc hasJavascript*(self: Document): bool =
  toBool(poppler_document_has_javascript(cast[ptr Document00](self.impl)))

proc poppler_document_is_linearized(self: ptr Document00): gboolean {.
    importc, libprag.}

proc isLinearized*(self: Document): bool =
  toBool(poppler_document_is_linearized(cast[ptr Document00](self.impl)))

proc poppler_document_reset_form(self: ptr Document00; fields: ptr glib.List;
    excludeFields: gboolean) {.
    importc, libprag.}

proc resetForm*(self: Document; fields: seq[cstring]; excludeFields: bool) =
  var tempResGL = seq2GList(fields)
  poppler_document_reset_form(cast[ptr Document00](self.impl), tempResGL, gboolean(excludeFields))
  g_list_free(tempResGL)

proc poppler_document_save(self: ptr Document00; uri: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc save*(self: Document; uri: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_document_save(cast[ptr Document00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc poppler_document_save_a_copy(self: ptr Document00; uri: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveACopy*(self: Document; uri: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_document_save_a_copy(cast[ptr Document00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc poppler_document_save_to_fd(self: ptr Document00; fd: int32; includeChanges: gboolean;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToFd*(self: Document; fd: int; includeChanges: bool): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_document_save_to_fd(cast[ptr Document00](self.impl), int32(fd), gboolean(includeChanges), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc poppler_document_set_author(self: ptr Document00; author: cstring) {.
    importc, libprag.}

proc setAuthor*(self: Document; author: cstring) =
  poppler_document_set_author(cast[ptr Document00](self.impl), author)

proc `author=`*(self: Document; author: cstring) =
  poppler_document_set_author(cast[ptr Document00](self.impl), author)

proc poppler_document_set_creation_date(self: ptr Document00; creationDate: int64) {.
    importc, libprag.}

proc setCreationDate*(self: Document; creationDate: int64) =
  poppler_document_set_creation_date(cast[ptr Document00](self.impl), creationDate)

proc `creationDate=`*(self: Document; creationDate: int64) =
  poppler_document_set_creation_date(cast[ptr Document00](self.impl), creationDate)

proc poppler_document_set_creation_date_time(self: ptr Document00; creationDatetime: ptr glib.DateTime00) {.
    importc, libprag.}

proc setCreationDateTime*(self: Document; creationDatetime: glib.DateTime = nil) =
  poppler_document_set_creation_date_time(cast[ptr Document00](self.impl), if creationDatetime.isNil: nil else: cast[ptr glib.DateTime00](creationDatetime.impl))

proc `creationDateTime=`*(self: Document; creationDatetime: glib.DateTime = nil) =
  poppler_document_set_creation_date_time(cast[ptr Document00](self.impl), if creationDatetime.isNil: nil else: cast[ptr glib.DateTime00](creationDatetime.impl))

proc poppler_document_set_creator(self: ptr Document00; creator: cstring) {.
    importc, libprag.}

proc setCreator*(self: Document; creator: cstring) =
  poppler_document_set_creator(cast[ptr Document00](self.impl), creator)

proc `creator=`*(self: Document; creator: cstring) =
  poppler_document_set_creator(cast[ptr Document00](self.impl), creator)

proc poppler_document_set_keywords(self: ptr Document00; keywords: cstring) {.
    importc, libprag.}

proc setKeywords*(self: Document; keywords: cstring) =
  poppler_document_set_keywords(cast[ptr Document00](self.impl), keywords)

proc `keywords=`*(self: Document; keywords: cstring) =
  poppler_document_set_keywords(cast[ptr Document00](self.impl), keywords)

proc poppler_document_set_modification_date(self: ptr Document00; modificationDate: int64) {.
    importc, libprag.}

proc setModificationDate*(self: Document; modificationDate: int64) =
  poppler_document_set_modification_date(cast[ptr Document00](self.impl), modificationDate)

proc `modificationDate=`*(self: Document; modificationDate: int64) =
  poppler_document_set_modification_date(cast[ptr Document00](self.impl), modificationDate)

proc poppler_document_set_modification_date_time(self: ptr Document00; modificationDatetime: ptr glib.DateTime00) {.
    importc, libprag.}

proc setModificationDateTime*(self: Document; modificationDatetime: glib.DateTime = nil) =
  poppler_document_set_modification_date_time(cast[ptr Document00](self.impl), if modificationDatetime.isNil: nil else: cast[ptr glib.DateTime00](modificationDatetime.impl))

proc `modificationDateTime=`*(self: Document; modificationDatetime: glib.DateTime = nil) =
  poppler_document_set_modification_date_time(cast[ptr Document00](self.impl), if modificationDatetime.isNil: nil else: cast[ptr glib.DateTime00](modificationDatetime.impl))

proc poppler_document_set_producer(self: ptr Document00; producer: cstring) {.
    importc, libprag.}

proc setProducer*(self: Document; producer: cstring) =
  poppler_document_set_producer(cast[ptr Document00](self.impl), producer)

proc `producer=`*(self: Document; producer: cstring) =
  poppler_document_set_producer(cast[ptr Document00](self.impl), producer)

proc poppler_document_set_subject(self: ptr Document00; subject: cstring) {.
    importc, libprag.}

proc setSubject*(self: Document; subject: cstring) =
  poppler_document_set_subject(cast[ptr Document00](self.impl), subject)

proc `subject=`*(self: Document; subject: cstring) =
  poppler_document_set_subject(cast[ptr Document00](self.impl), subject)

proc poppler_document_set_title(self: ptr Document00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: Document; title: cstring) =
  poppler_document_set_title(cast[ptr Document00](self.impl), title)

proc `title=`*(self: Document; title: cstring) =
  poppler_document_set_title(cast[ptr Document00](self.impl), title)

proc poppler_document_sign_finish(self: ptr Document00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc signFinish*(self: Document; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_document_sign_finish(cast[ptr Document00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc poppler_annot_circle_new(doc: ptr Document00; rect: ptr Rectangle00): ptr AnnotCircle00 {.
    importc, libprag.}

proc newAnnotCircle*(doc: Document; rect: Rectangle): AnnotCircle =
  let gobj = poppler_annot_circle_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAnnotCircle*(tdesc: typedesc; doc: Document; rect: Rectangle): tdesc =
  assert(result is AnnotCircle)
  let gobj = poppler_annot_circle_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAnnotCircle*[T](result: var T; doc: Document; rect: Rectangle) {.deprecated.} =
  assert(result is AnnotCircle)
  let gobj = poppler_annot_circle_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Dest00* {.pure.} = object
  Dest* = ref object
    impl*: ptr Dest00
    ignoreFinalizer*: bool

proc poppler_dest_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerDest*(self: Dest) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_dest_get_type(), cast[ptr Dest00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Dest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_dest_get_type(), cast[ptr Dest00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Dest) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerDest)

proc poppler_dest_free(self: ptr Dest00) {.
    importc, libprag.}

proc free*(self: Dest) =
  poppler_dest_free(cast[ptr Dest00](self.impl))

proc finalizerfree*(self: Dest) =
  if not self.ignoreFinalizer:
    poppler_dest_free(cast[ptr Dest00](self.impl))

proc poppler_dest_copy(self: ptr Dest00): ptr Dest00 {.
    importc, libprag.}

proc copy*(self: Dest): Dest =
  fnew(result, gBoxedFreePopplerDest)
  result.impl = poppler_dest_copy(cast[ptr Dest00](self.impl))

proc poppler_document_find_dest(self: ptr Document00; linkName: cstring): ptr Dest00 {.
    importc, libprag.}

proc findDest*(self: Document; linkName: cstring): Dest =
  fnew(result, gBoxedFreePopplerDest)
  result.impl = poppler_document_find_dest(cast[ptr Document00](self.impl), linkName)

type
  Attachment* = ref object of gobject.Object
  Attachment00* = object of gobject.Object00

proc poppler_attachment_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Attachment()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_attachment_get_checksum(self: ptr Attachment00): ptr glib.String {.
    importc, libprag.}

proc getChecksum*(self: Attachment): ptr glib.String =
  poppler_attachment_get_checksum(cast[ptr Attachment00](self.impl))

proc checksum*(self: Attachment): ptr glib.String =
  poppler_attachment_get_checksum(cast[ptr Attachment00](self.impl))

proc poppler_attachment_get_ctime(self: ptr Attachment00): ptr glib.DateTime00 {.
    importc, libprag.}

proc getCtime*(self: Attachment): glib.DateTime =
  let impl0 = poppler_attachment_get_ctime(cast[ptr Attachment00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), impl0))

proc ctime*(self: Attachment): glib.DateTime =
  let impl0 = poppler_attachment_get_ctime(cast[ptr Attachment00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), impl0))

proc poppler_attachment_get_description(self: ptr Attachment00): cstring {.
    importc, libprag.}

proc getDescription*(self: Attachment): string =
  result = $poppler_attachment_get_description(cast[ptr Attachment00](self.impl))

proc description*(self: Attachment): string =
  result = $poppler_attachment_get_description(cast[ptr Attachment00](self.impl))

proc poppler_attachment_get_mtime(self: ptr Attachment00): ptr glib.DateTime00 {.
    importc, libprag.}

proc getMtime*(self: Attachment): glib.DateTime =
  let impl0 = poppler_attachment_get_mtime(cast[ptr Attachment00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), impl0))

proc mtime*(self: Attachment): glib.DateTime =
  let impl0 = poppler_attachment_get_mtime(cast[ptr Attachment00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), impl0))

proc poppler_attachment_get_name(self: ptr Attachment00): cstring {.
    importc, libprag.}

proc getName*(self: Attachment): string =
  result = $poppler_attachment_get_name(cast[ptr Attachment00](self.impl))

proc name*(self: Attachment): string =
  result = $poppler_attachment_get_name(cast[ptr Attachment00](self.impl))

proc poppler_attachment_get_size(self: ptr Attachment00): uint64 {.
    importc, libprag.}

proc getSize*(self: Attachment): uint64 =
  poppler_attachment_get_size(cast[ptr Attachment00](self.impl))

proc size*(self: Attachment): uint64 =
  poppler_attachment_get_size(cast[ptr Attachment00](self.impl))

proc poppler_attachment_save(self: ptr Attachment00; filename: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc save*(self: Attachment; filename: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_attachment_save(cast[ptr Attachment00](self.impl), filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc poppler_attachment_save_to_fd(self: ptr Attachment00; fd: int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToFd*(self: Attachment; fd: int): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_attachment_save_to_fd(cast[ptr Attachment00](self.impl), int32(fd), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc poppler_document_get_attachments(self: ptr Document00): ptr glib.List {.
    importc, libprag.}

proc getAttachments*(self: Document): seq[Attachment] =
  let resul0 = poppler_document_get_attachments(cast[ptr Document00](self.impl))
  result = glistObjects2seq(Attachment, resul0, true)
  g_list_free(resul0)

proc attachments*(self: Document): seq[Attachment] =
  let resul0 = poppler_document_get_attachments(cast[ptr Document00](self.impl))
  result = glistObjects2seq(Attachment, resul0, true)
  g_list_free(resul0)

type
  Page* = ref object of gobject.Object
  Page00* = object of gobject.Object00

proc poppler_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Page()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc selectionRegionFree*(region: ptr glib.List) {.
    importc: "poppler_page_selection_region_free", libprag.}

proc poppler_page_add_annot(self: ptr Page00; annot: ptr Annot00) {.
    importc, libprag.}

proc addAnnot*(self: Page; annot: Annot) =
  poppler_page_add_annot(cast[ptr Page00](self.impl), cast[ptr Annot00](annot.impl))

proc poppler_page_find_text(self: ptr Page00; text: cstring): ptr glib.List {.
    importc, libprag.}

proc findText*(self: Page; text: cstring): seq[Rectangle] =
  let resul0 = poppler_page_find_text(cast[ptr Page00](self.impl), text)
  result = glistStructs2seq[Rectangle](resul0, false)
  g_list_free(resul0)

proc poppler_page_get_bounding_box(self: ptr Page00; rect: ptr Rectangle00): gboolean {.
    importc, libprag.}

proc getBoundingBox*(self: Page; rect: Rectangle): bool =
  toBool(poppler_page_get_bounding_box(cast[ptr Page00](self.impl), cast[ptr Rectangle00](rect.impl)))

proc poppler_page_get_crop_box(self: ptr Page00; rect: var Rectangle00) {.
    importc, libprag.}

proc getCropBox*(self: Page; rect: var Rectangle00) =
  poppler_page_get_crop_box(cast[ptr Page00](self.impl), rect)

proc getCropBox*(self: Page): Rectangle00 =
  poppler_page_get_crop_box(cast[ptr Page00](self.impl), result)

proc poppler_page_get_duration(self: ptr Page00): cdouble {.
    importc, libprag.}

proc getDuration*(self: Page): cdouble =
  poppler_page_get_duration(cast[ptr Page00](self.impl))

proc duration*(self: Page): cdouble =
  poppler_page_get_duration(cast[ptr Page00](self.impl))

proc poppler_page_get_image(self: ptr Page00; imageId: int32): ptr cairo.Surface00 {.
    importc, libprag.}

proc getImage*(self: Page; imageId: int): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = poppler_page_get_image(cast[ptr Page00](self.impl), int32(imageId))

proc poppler_page_get_index(self: ptr Page00): int32 {.
    importc, libprag.}

proc getIndex*(self: Page): int =
  int(poppler_page_get_index(cast[ptr Page00](self.impl)))

proc index*(self: Page): int =
  int(poppler_page_get_index(cast[ptr Page00](self.impl)))

proc poppler_page_get_label(self: ptr Page00): cstring {.
    importc, libprag.}

proc getLabel*(self: Page): string =
  let resul0 = poppler_page_get_label(cast[ptr Page00](self.impl))
  result = $resul0
  cogfree(resul0)

proc label*(self: Page): string =
  let resul0 = poppler_page_get_label(cast[ptr Page00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_page_get_size(self: ptr Page00; width: var cdouble; height: var cdouble) {.
    importc, libprag.}

proc getSize*(self: Page; width: var cdouble = cast[var cdouble](nil);
    height: var cdouble = cast[var cdouble](nil)) =
  poppler_page_get_size(cast[ptr Page00](self.impl), width, height)

proc poppler_page_get_text(self: ptr Page00): cstring {.
    importc, libprag.}

proc getText*(self: Page): string =
  let resul0 = poppler_page_get_text(cast[ptr Page00](self.impl))
  result = $resul0
  cogfree(resul0)

proc text*(self: Page): string =
  let resul0 = poppler_page_get_text(cast[ptr Page00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_page_get_text_for_area(self: ptr Page00; area: ptr Rectangle00): cstring {.
    importc, libprag.}

proc getTextForArea*(self: Page; area: Rectangle): string =
  let resul0 = poppler_page_get_text_for_area(cast[ptr Page00](self.impl), cast[ptr Rectangle00](area.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_page_get_text_layout(self: ptr Page00; rectangles: var ptr Rectangle00;
    nRectangles: var uint32): gboolean {.
    importc, libprag.}

proc getTextLayout*(self: Page; rectangles: var ptr Rectangle00;
    nRectangles: var int): bool =
  var nRectangles_00: uint32
  result = toBool(poppler_page_get_text_layout(cast[ptr Page00](self.impl), rectangles, nRectangles_00))
  if nRectangles.addr != nil:
    nRectangles = int(nRectangles_00)

proc poppler_page_get_text_layout_for_area(self: ptr Page00; area: ptr Rectangle00;
    rectangles: var ptr Rectangle00; nRectangles: var uint32): gboolean {.
    importc, libprag.}

proc getTextLayoutForArea*(self: Page; area: Rectangle; rectangles: var ptr Rectangle00;
    nRectangles: var int): bool =
  var nRectangles_00: uint32
  result = toBool(poppler_page_get_text_layout_for_area(cast[ptr Page00](self.impl), cast[ptr Rectangle00](area.impl), rectangles, nRectangles_00))
  if nRectangles.addr != nil:
    nRectangles = int(nRectangles_00)

proc poppler_page_get_thumbnail(self: ptr Page00): ptr cairo.Surface00 {.
    importc, libprag.}

proc getThumbnail*(self: Page): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = poppler_page_get_thumbnail(cast[ptr Page00](self.impl))

proc thumbnail*(self: Page): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = poppler_page_get_thumbnail(cast[ptr Page00](self.impl))

proc poppler_page_get_thumbnail_size(self: ptr Page00; width: var int32;
    height: var int32): gboolean {.
    importc, libprag.}

proc getThumbnailSize*(self: Page; width: var int; height: var int): bool =
  var height_00: int32
  var width_00: int32
  result = toBool(poppler_page_get_thumbnail_size(cast[ptr Page00](self.impl), width_00, height_00))
  if height.addr != nil:
    height = int(height_00)
  if width.addr != nil:
    width = int(width_00)

proc poppler_page_remove_annot(self: ptr Page00; annot: ptr Annot00) {.
    importc, libprag.}

proc removeAnnot*(self: Page; annot: Annot) =
  poppler_page_remove_annot(cast[ptr Page00](self.impl), cast[ptr Annot00](annot.impl))

proc poppler_page_render(self: ptr Page00; ct: ptr cairo.Context00) {.
    importc, libprag.}

proc render*(self: Page; ct: cairo.Context) =
  poppler_page_render(cast[ptr Page00](self.impl), cast[ptr cairo.Context00](ct.impl))

proc poppler_page_render_for_printing(self: ptr Page00; ct: ptr cairo.Context00) {.
    importc, libprag.}

proc renderForPrinting*(self: Page; ct: cairo.Context) =
  poppler_page_render_for_printing(cast[ptr Page00](self.impl), cast[ptr cairo.Context00](ct.impl))

proc poppler_document_get_page(self: ptr Document00; index: int32): ptr Page00 {.
    importc, libprag.}

proc getPage*(self: Document; index: int): Page =
  let gobj = poppler_document_get_page(cast[ptr Document00](self.impl), int32(index))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_document_get_page_by_label(self: ptr Document00; label: cstring): ptr Page00 {.
    importc, libprag.}

proc getPageByLabel*(self: Document; label: cstring): Page =
  let gobj = poppler_document_get_page_by_label(cast[ptr Document00](self.impl), label)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  FindFlag* {.size: sizeof(cint), pure.} = enum
    caseSensitive = 0
    backwards = 1
    wholeWordsOnly = 2
    ignoreDiacritics = 3
    multiline = 4

  FindFlags* = set[FindFlag]

const
  FindFlagsDefault* = FindFlags({})
proc default*(t: typedesc[FindFlags]): FindFlags = FindFlags({})

proc poppler_page_find_text_with_options(self: ptr Page00; text: cstring;
    options: FindFlags): ptr glib.List {.
    importc, libprag.}

proc findTextWithOptions*(self: Page; text: cstring; options: FindFlags): seq[Rectangle] =
  let resul0 = poppler_page_find_text_with_options(cast[ptr Page00](self.impl), text, options)
  result = glistStructs2seq[Rectangle](resul0, false)
  g_list_free(resul0)

type
  AnnotMapping00* {.pure.} = object
  AnnotMapping* = ref object
    impl*: ptr AnnotMapping00
    ignoreFinalizer*: bool

proc poppler_annot_mapping_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerAnnotMapping*(self: AnnotMapping) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_annot_mapping_get_type(), cast[ptr AnnotMapping00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotMapping()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_annot_mapping_get_type(), cast[ptr AnnotMapping00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AnnotMapping) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerAnnotMapping)

proc poppler_annot_mapping_free(self: ptr AnnotMapping00) {.
    importc, libprag.}

proc free*(self: AnnotMapping) =
  poppler_annot_mapping_free(cast[ptr AnnotMapping00](self.impl))

proc finalizerfree*(self: AnnotMapping) =
  if not self.ignoreFinalizer:
    poppler_annot_mapping_free(cast[ptr AnnotMapping00](self.impl))

proc poppler_annot_mapping_copy(self: ptr AnnotMapping00): ptr AnnotMapping00 {.
    importc, libprag.}

proc copy*(self: AnnotMapping): AnnotMapping =
  fnew(result, gBoxedFreePopplerAnnotMapping)
  result.impl = poppler_annot_mapping_copy(cast[ptr AnnotMapping00](self.impl))

proc poppler_annot_mapping_new(): ptr AnnotMapping00 {.
    importc, libprag.}

proc newAnnotMapping*(): AnnotMapping =
  fnew(result, gBoxedFreePopplerAnnotMapping)
  result.impl = poppler_annot_mapping_new()

proc newAnnotMapping*(tdesc: typedesc): tdesc =
  assert(result is AnnotMapping)
  fnew(result, gBoxedFreePopplerAnnotMapping)
  result.impl = poppler_annot_mapping_new()

proc initAnnotMapping*[T](result: var T) {.deprecated.} =
  assert(result is AnnotMapping)
  fnew(result, gBoxedFreePopplerAnnotMapping)
  result.impl = poppler_annot_mapping_new()

proc freeAnnotMapping*(list: ptr glib.List) {.
    importc: "poppler_page_free_annot_mapping", libprag.}

proc poppler_page_get_annot_mapping(self: ptr Page00): ptr glib.List {.
    importc, libprag.}

proc getAnnotMapping*(self: Page): seq[AnnotMapping] =
  let resul0 = poppler_page_get_annot_mapping(cast[ptr Page00](self.impl))
  result = glistStructs2seq[AnnotMapping](resul0, false)
  g_list_free(resul0)

proc annotMapping*(self: Page): seq[AnnotMapping] =
  let resul0 = poppler_page_get_annot_mapping(cast[ptr Page00](self.impl))
  result = glistStructs2seq[AnnotMapping](resul0, false)
  g_list_free(resul0)

type
  FormFieldMapping00* {.pure.} = object
  FormFieldMapping* = ref object
    impl*: ptr FormFieldMapping00
    ignoreFinalizer*: bool

proc poppler_form_field_mapping_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerFormFieldMapping*(self: FormFieldMapping) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_form_field_mapping_get_type(), cast[ptr FormFieldMapping00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FormFieldMapping()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_form_field_mapping_get_type(), cast[ptr FormFieldMapping00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var FormFieldMapping) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerFormFieldMapping)

proc poppler_form_field_mapping_free(self: ptr FormFieldMapping00) {.
    importc, libprag.}

proc free*(self: FormFieldMapping) =
  poppler_form_field_mapping_free(cast[ptr FormFieldMapping00](self.impl))

proc finalizerfree*(self: FormFieldMapping) =
  if not self.ignoreFinalizer:
    poppler_form_field_mapping_free(cast[ptr FormFieldMapping00](self.impl))

proc poppler_form_field_mapping_copy(self: ptr FormFieldMapping00): ptr FormFieldMapping00 {.
    importc, libprag.}

proc copy*(self: FormFieldMapping): FormFieldMapping =
  fnew(result, gBoxedFreePopplerFormFieldMapping)
  result.impl = poppler_form_field_mapping_copy(cast[ptr FormFieldMapping00](self.impl))

proc poppler_form_field_mapping_new(): ptr FormFieldMapping00 {.
    importc, libprag.}

proc newFormFieldMapping*(): FormFieldMapping =
  fnew(result, gBoxedFreePopplerFormFieldMapping)
  result.impl = poppler_form_field_mapping_new()

proc newFormFieldMapping*(tdesc: typedesc): tdesc =
  assert(result is FormFieldMapping)
  fnew(result, gBoxedFreePopplerFormFieldMapping)
  result.impl = poppler_form_field_mapping_new()

proc initFormFieldMapping*[T](result: var T) {.deprecated.} =
  assert(result is FormFieldMapping)
  fnew(result, gBoxedFreePopplerFormFieldMapping)
  result.impl = poppler_form_field_mapping_new()

proc freeFormFieldMapping*(list: ptr glib.List) {.
    importc: "poppler_page_free_form_field_mapping", libprag.}

proc poppler_page_get_form_field_mapping(self: ptr Page00): ptr glib.List {.
    importc, libprag.}

proc getFormFieldMapping*(self: Page): seq[FormFieldMapping] =
  let resul0 = poppler_page_get_form_field_mapping(cast[ptr Page00](self.impl))
  result = glistStructs2seq[FormFieldMapping](resul0, false)
  g_list_free(resul0)

proc formFieldMapping*(self: Page): seq[FormFieldMapping] =
  let resul0 = poppler_page_get_form_field_mapping(cast[ptr Page00](self.impl))
  result = glistStructs2seq[FormFieldMapping](resul0, false)
  g_list_free(resul0)

type
  ImageMapping00* {.pure.} = object
    area*: Rectangle00
    imageId*: int32
  ImageMapping* = ref object
    impl*: ptr ImageMapping00
    ignoreFinalizer*: bool

proc poppler_image_mapping_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerImageMapping*(self: ImageMapping) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_image_mapping_get_type(), cast[ptr ImageMapping00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ImageMapping()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_image_mapping_get_type(), cast[ptr ImageMapping00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ImageMapping) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerImageMapping)

proc poppler_image_mapping_free(self: ptr ImageMapping00) {.
    importc, libprag.}

proc free*(self: ImageMapping) =
  poppler_image_mapping_free(cast[ptr ImageMapping00](self.impl))

proc finalizerfree*(self: ImageMapping) =
  if not self.ignoreFinalizer:
    poppler_image_mapping_free(cast[ptr ImageMapping00](self.impl))

proc poppler_image_mapping_copy(self: ptr ImageMapping00): ptr ImageMapping00 {.
    importc, libprag.}

proc copy*(self: ImageMapping): ImageMapping =
  fnew(result, gBoxedFreePopplerImageMapping)
  result.impl = poppler_image_mapping_copy(cast[ptr ImageMapping00](self.impl))

proc poppler_image_mapping_new(): ptr ImageMapping00 {.
    importc, libprag.}

proc newImageMapping*(): ImageMapping =
  fnew(result, gBoxedFreePopplerImageMapping)
  result.impl = poppler_image_mapping_new()

proc newImageMapping*(tdesc: typedesc): tdesc =
  assert(result is ImageMapping)
  fnew(result, gBoxedFreePopplerImageMapping)
  result.impl = poppler_image_mapping_new()

proc initImageMapping*[T](result: var T) {.deprecated.} =
  assert(result is ImageMapping)
  fnew(result, gBoxedFreePopplerImageMapping)
  result.impl = poppler_image_mapping_new()

proc freeImageMapping*(list: ptr glib.List) {.
    importc: "poppler_page_free_image_mapping", libprag.}

proc poppler_page_get_image_mapping(self: ptr Page00): ptr glib.List {.
    importc, libprag.}

proc getImageMapping*(self: Page): seq[ImageMapping] =
  let resul0 = poppler_page_get_image_mapping(cast[ptr Page00](self.impl))
  result = glistStructs2seq[ImageMapping](resul0, false)
  g_list_free(resul0)

proc imageMapping*(self: Page): seq[ImageMapping] =
  let resul0 = poppler_page_get_image_mapping(cast[ptr Page00](self.impl))
  result = glistStructs2seq[ImageMapping](resul0, false)
  g_list_free(resul0)

type
  LinkMapping00* {.pure.} = object
  LinkMapping* = ref object
    impl*: ptr LinkMapping00
    ignoreFinalizer*: bool

proc poppler_link_mapping_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerLinkMapping*(self: LinkMapping) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_link_mapping_get_type(), cast[ptr LinkMapping00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LinkMapping()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_link_mapping_get_type(), cast[ptr LinkMapping00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var LinkMapping) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerLinkMapping)

proc poppler_link_mapping_free(self: ptr LinkMapping00) {.
    importc, libprag.}

proc free*(self: LinkMapping) =
  poppler_link_mapping_free(cast[ptr LinkMapping00](self.impl))

proc finalizerfree*(self: LinkMapping) =
  if not self.ignoreFinalizer:
    poppler_link_mapping_free(cast[ptr LinkMapping00](self.impl))

proc poppler_link_mapping_copy(self: ptr LinkMapping00): ptr LinkMapping00 {.
    importc, libprag.}

proc copy*(self: LinkMapping): LinkMapping =
  fnew(result, gBoxedFreePopplerLinkMapping)
  result.impl = poppler_link_mapping_copy(cast[ptr LinkMapping00](self.impl))

proc poppler_link_mapping_new(): ptr LinkMapping00 {.
    importc, libprag.}

proc newLinkMapping*(): LinkMapping =
  fnew(result, gBoxedFreePopplerLinkMapping)
  result.impl = poppler_link_mapping_new()

proc newLinkMapping*(tdesc: typedesc): tdesc =
  assert(result is LinkMapping)
  fnew(result, gBoxedFreePopplerLinkMapping)
  result.impl = poppler_link_mapping_new()

proc initLinkMapping*[T](result: var T) {.deprecated.} =
  assert(result is LinkMapping)
  fnew(result, gBoxedFreePopplerLinkMapping)
  result.impl = poppler_link_mapping_new()

proc freeLinkMapping*(list: ptr glib.List) {.
    importc: "poppler_page_free_link_mapping", libprag.}

proc poppler_page_get_link_mapping(self: ptr Page00): ptr glib.List {.
    importc, libprag.}

proc getLinkMapping*(self: Page): seq[LinkMapping] =
  let resul0 = poppler_page_get_link_mapping(cast[ptr Page00](self.impl))
  result = glistStructs2seq[LinkMapping](resul0, false)
  g_list_free(resul0)

proc linkMapping*(self: Page): seq[LinkMapping] =
  let resul0 = poppler_page_get_link_mapping(cast[ptr Page00](self.impl))
  result = glistStructs2seq[LinkMapping](resul0, false)
  g_list_free(resul0)

type
  TextAttributes00* {.pure.} = object
  TextAttributes* = ref object
    impl*: ptr TextAttributes00
    ignoreFinalizer*: bool

proc poppler_text_attributes_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerTextAttributes*(self: TextAttributes) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_text_attributes_get_type(), cast[ptr TextAttributes00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TextAttributes()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_text_attributes_get_type(), cast[ptr TextAttributes00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var TextAttributes) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerTextAttributes)

proc poppler_text_attributes_free(self: ptr TextAttributes00) {.
    importc, libprag.}

proc free*(self: TextAttributes) =
  poppler_text_attributes_free(cast[ptr TextAttributes00](self.impl))

proc finalizerfree*(self: TextAttributes) =
  if not self.ignoreFinalizer:
    poppler_text_attributes_free(cast[ptr TextAttributes00](self.impl))

proc poppler_text_attributes_copy(self: ptr TextAttributes00): ptr TextAttributes00 {.
    importc, libprag.}

proc copy*(self: TextAttributes): TextAttributes =
  fnew(result, gBoxedFreePopplerTextAttributes)
  result.impl = poppler_text_attributes_copy(cast[ptr TextAttributes00](self.impl))

proc poppler_text_attributes_new(): ptr TextAttributes00 {.
    importc, libprag.}

proc newTextAttributes*(): TextAttributes =
  fnew(result, gBoxedFreePopplerTextAttributes)
  result.impl = poppler_text_attributes_new()

proc newTextAttributes*(tdesc: typedesc): tdesc =
  assert(result is TextAttributes)
  fnew(result, gBoxedFreePopplerTextAttributes)
  result.impl = poppler_text_attributes_new()

proc initTextAttributes*[T](result: var T) {.deprecated.} =
  assert(result is TextAttributes)
  fnew(result, gBoxedFreePopplerTextAttributes)
  result.impl = poppler_text_attributes_new()

proc freeTextAttributes*(list: ptr glib.List) {.
    importc: "poppler_page_free_text_attributes", libprag.}

proc poppler_page_get_text_attributes(self: ptr Page00): ptr glib.List {.
    importc, libprag.}

proc getTextAttributes*(self: Page): seq[TextAttributes] =
  let resul0 = poppler_page_get_text_attributes(cast[ptr Page00](self.impl))
  result = glistStructs2seq[TextAttributes](resul0, false)
  g_list_free(resul0)

proc textAttributes*(self: Page): seq[TextAttributes] =
  let resul0 = poppler_page_get_text_attributes(cast[ptr Page00](self.impl))
  result = glistStructs2seq[TextAttributes](resul0, false)
  g_list_free(resul0)

proc poppler_page_get_text_attributes_for_area(self: ptr Page00; area: ptr Rectangle00): ptr glib.List {.
    importc, libprag.}

proc getTextAttributesForArea*(self: Page; area: Rectangle): seq[TextAttributes] =
  let resul0 = poppler_page_get_text_attributes_for_area(cast[ptr Page00](self.impl), cast[ptr Rectangle00](area.impl))
  result = glistStructs2seq[TextAttributes](resul0, false)
  g_list_free(resul0)

type
  PageTransition00* {.pure.} = object
  PageTransition* = ref object
    impl*: ptr PageTransition00
    ignoreFinalizer*: bool

proc poppler_page_transition_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerPageTransition*(self: PageTransition) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_page_transition_get_type(), cast[ptr PageTransition00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PageTransition()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_page_transition_get_type(), cast[ptr PageTransition00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PageTransition) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerPageTransition)

proc poppler_page_transition_free(self: ptr PageTransition00) {.
    importc, libprag.}

proc free*(self: PageTransition) =
  poppler_page_transition_free(cast[ptr PageTransition00](self.impl))

proc finalizerfree*(self: PageTransition) =
  if not self.ignoreFinalizer:
    poppler_page_transition_free(cast[ptr PageTransition00](self.impl))

proc poppler_page_transition_copy(self: ptr PageTransition00): ptr PageTransition00 {.
    importc, libprag.}

proc copy*(self: PageTransition): PageTransition =
  fnew(result, gBoxedFreePopplerPageTransition)
  result.impl = poppler_page_transition_copy(cast[ptr PageTransition00](self.impl))

proc poppler_page_transition_new(): ptr PageTransition00 {.
    importc, libprag.}

proc newPageTransition*(): PageTransition =
  fnew(result, gBoxedFreePopplerPageTransition)
  result.impl = poppler_page_transition_new()

proc newPageTransition*(tdesc: typedesc): tdesc =
  assert(result is PageTransition)
  fnew(result, gBoxedFreePopplerPageTransition)
  result.impl = poppler_page_transition_new()

proc initPageTransition*[T](result: var T) {.deprecated.} =
  assert(result is PageTransition)
  fnew(result, gBoxedFreePopplerPageTransition)
  result.impl = poppler_page_transition_new()

proc poppler_page_get_transition(self: ptr Page00): ptr PageTransition00 {.
    importc, libprag.}

proc getTransition*(self: Page): PageTransition =
  fnew(result, gBoxedFreePopplerPageTransition)
  result.impl = poppler_page_get_transition(cast[ptr Page00](self.impl))

proc transition*(self: Page): PageTransition =
  fnew(result, gBoxedFreePopplerPageTransition)
  result.impl = poppler_page_get_transition(cast[ptr Page00](self.impl))

type
  PrintFlag* {.size: sizeof(cint), pure.} = enum
    all = 0
    stampAnnotsOnly = 1

  PrintFlags* = set[PrintFlag]

const
  PrintMarkupAnnots* = PrintFlag.all
  PrintFlagsDocument* = PrintFlags({})
proc document*(t: typedesc[PrintFlags]): PrintFlags = PrintFlags({})

proc poppler_page_render_for_printing_with_options(self: ptr Page00; ct: ptr cairo.Context00;
    options: PrintFlags) {.
    importc, libprag.}

proc renderForPrintingWithOptions*(self: Page; ct: cairo.Context;
    options: PrintFlags) =
  poppler_page_render_for_printing_with_options(cast[ptr Page00](self.impl), cast[ptr cairo.Context00](ct.impl), options)

type
  SelectionStyle* {.size: sizeof(cint), pure.} = enum
    glyph = 0
    word = 1
    line = 2

proc poppler_page_get_selected_region(self: ptr Page00; scale: cdouble; style: SelectionStyle;
    selection: ptr Rectangle00): ptr cairo.Region00 {.
    importc, libprag.}

proc getSelectedRegion*(self: Page; scale: cdouble; style: SelectionStyle;
    selection: Rectangle): cairo.Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = poppler_page_get_selected_region(cast[ptr Page00](self.impl), scale, style, cast[ptr Rectangle00](selection.impl))

proc poppler_page_get_selected_text(self: ptr Page00; style: SelectionStyle;
    selection: ptr Rectangle00): cstring {.
    importc, libprag.}

proc getSelectedText*(self: Page; style: SelectionStyle; selection: Rectangle): string =
  let resul0 = poppler_page_get_selected_text(cast[ptr Page00](self.impl), style, cast[ptr Rectangle00](selection.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_page_get_selection_region(self: ptr Page00; scale: cdouble;
    style: SelectionStyle; selection: ptr Rectangle00): ptr glib.List {.
    importc, libprag.}

proc getSelectionRegion*(self: Page; scale: cdouble; style: SelectionStyle;
    selection: Rectangle): seq[Rectangle] =
  let resul0 = poppler_page_get_selection_region(cast[ptr Page00](self.impl), scale, style, cast[ptr Rectangle00](selection.impl))
  result = glistStructs2seq[Rectangle](resul0, false)
  g_list_free(resul0)

proc poppler_page_render_selection(self: ptr Page00; ct: ptr cairo.Context00;
    selection: ptr Rectangle00; oldSelection: ptr Rectangle00; style: SelectionStyle;
    glyphColor: ptr Color00; backgroundColor: ptr Color00) {.
    importc, libprag.}

proc renderSelection*(self: Page; ct: cairo.Context; selection: Rectangle;
    oldSelection: Rectangle; style: SelectionStyle; glyphColor: Color; backgroundColor: Color) =
  poppler_page_render_selection(cast[ptr Page00](self.impl), cast[ptr cairo.Context00](ct.impl), cast[ptr Rectangle00](selection.impl), cast[ptr Rectangle00](oldSelection.impl), style, cast[ptr Color00](glyphColor.impl), cast[ptr Color00](backgroundColor.impl))

type
  PSFile* = ref object of gobject.Object
  PSFile00* = object of gobject.Object00

proc poppler_ps_file_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PSFile()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_ps_file_new(document: ptr Document00; filename: cstring; firstPage: int32;
    nPages: int32): ptr PSFile00 {.
    importc, libprag.}

proc newPSFile*(document: Document; filename: cstring; firstPage: int;
    nPages: int): PSFile =
  let gobj = poppler_ps_file_new(cast[ptr Document00](document.impl), filename, int32(firstPage), int32(nPages))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPSFile*(tdesc: typedesc; document: Document; filename: cstring; firstPage: int;
    nPages: int): tdesc =
  assert(result is PSFile)
  let gobj = poppler_ps_file_new(cast[ptr Document00](document.impl), filename, int32(firstPage), int32(nPages))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPSFile*[T](result: var T; document: Document; filename: cstring; firstPage: int;
    nPages: int) {.deprecated.} =
  assert(result is PSFile)
  let gobj = poppler_ps_file_new(cast[ptr Document00](document.impl), filename, int32(firstPage), int32(nPages))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_ps_file_new_fd(document: ptr Document00; fd: int32; firstPage: int32;
    nPages: int32): ptr PSFile00 {.
    importc, libprag.}

proc newPSFileFd*(document: Document; fd: int; firstPage: int;
    nPages: int): PSFile =
  let gobj = poppler_ps_file_new_fd(cast[ptr Document00](document.impl), int32(fd), int32(firstPage), int32(nPages))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPSFileFd*(tdesc: typedesc; document: Document; fd: int; firstPage: int;
    nPages: int): tdesc =
  assert(result is PSFile)
  let gobj = poppler_ps_file_new_fd(cast[ptr Document00](document.impl), int32(fd), int32(firstPage), int32(nPages))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPSFileFd*[T](result: var T; document: Document; fd: int; firstPage: int;
    nPages: int) {.deprecated.} =
  assert(result is PSFile)
  let gobj = poppler_ps_file_new_fd(cast[ptr Document00](document.impl), int32(fd), int32(firstPage), int32(nPages))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_ps_file_free(self: ptr PSFile00) {.
    importc, libprag.}

proc free*(self: PSFile) =
  poppler_ps_file_free(cast[ptr PSFile00](self.impl))

proc poppler_ps_file_set_duplex(self: ptr PSFile00; duplex: gboolean) {.
    importc, libprag.}

proc setDuplex*(self: PSFile; duplex: bool = true) =
  poppler_ps_file_set_duplex(cast[ptr PSFile00](self.impl), gboolean(duplex))

proc `duplex=`*(self: PSFile; duplex: bool) =
  poppler_ps_file_set_duplex(cast[ptr PSFile00](self.impl), gboolean(duplex))

proc poppler_ps_file_set_paper_size(self: ptr PSFile00; width: cdouble; height: cdouble) {.
    importc, libprag.}

proc setPaperSize*(self: PSFile; width: cdouble; height: cdouble) =
  poppler_ps_file_set_paper_size(cast[ptr PSFile00](self.impl), width, height)

proc poppler_page_render_to_ps(self: ptr Page00; psFile: ptr PSFile00) {.
    importc, libprag.}

proc renderToPs*(self: Page; psFile: PSFile) =
  poppler_page_render_to_ps(cast[ptr Page00](self.impl), cast[ptr PSFile00](psFile.impl))

type
  PageLayout* {.size: sizeof(cint), pure.} = enum
    unset = 0
    singlePage = 1
    oneColumn = 2
    twoColumnLeft = 3
    twoColumnRight = 4
    twoPageLeft = 5
    twoPageRight = 6

proc poppler_document_get_page_layout(self: ptr Document00): PageLayout {.
    importc, libprag.}

proc getPageLayout*(self: Document): PageLayout =
  poppler_document_get_page_layout(cast[ptr Document00](self.impl))

proc pageLayout*(self: Document): PageLayout =
  poppler_document_get_page_layout(cast[ptr Document00](self.impl))

type
  PageMode* {.size: sizeof(cint), pure.} = enum
    unset = 0
    none = 1
    useOutlines = 2
    useThumbs = 3
    fullScreen = 4
    useOc = 5
    useAttachments = 6

proc poppler_document_get_page_mode(self: ptr Document00): PageMode {.
    importc, libprag.}

proc getPageMode*(self: Document): PageMode =
  poppler_document_get_page_mode(cast[ptr Document00](self.impl))

proc pageMode*(self: Document): PageMode =
  poppler_document_get_page_mode(cast[ptr Document00](self.impl))

type
  PDFConformance* {.size: sizeof(cint), pure.} = enum
    unset = 0
    a = 1
    b = 2
    g = 3
    n = 4
    p = 5
    pg = 6
    u = 7
    none = 8

proc poppler_document_get_pdf_conformance(self: ptr Document00): PDFConformance {.
    importc, libprag.}

proc getPdfConformance*(self: Document): PDFConformance =
  poppler_document_get_pdf_conformance(cast[ptr Document00](self.impl))

proc pdfConformance*(self: Document): PDFConformance =
  poppler_document_get_pdf_conformance(cast[ptr Document00](self.impl))

type
  PDFPart* {.size: sizeof(cint), pure.} = enum
    unset = 0
    enum1 = 1
    enum2 = 2
    enum3 = 3
    enum4 = 4
    enum5 = 5
    enum6 = 6
    enum7 = 7
    enum8 = 8
    none = 9

proc poppler_document_get_pdf_part(self: ptr Document00): PDFPart {.
    importc, libprag.}

proc getPdfPart*(self: Document): PDFPart =
  poppler_document_get_pdf_part(cast[ptr Document00](self.impl))

proc pdfPart*(self: Document): PDFPart =
  poppler_document_get_pdf_part(cast[ptr Document00](self.impl))

type
  PDFSubtype* {.size: sizeof(cint), pure.} = enum
    unset = 0
    pdfA = 1
    pdfE = 2
    pdfUa = 3
    pdfVt = 4
    pdfX = 5
    none = 6

proc poppler_document_get_pdf_subtype(self: ptr Document00): PDFSubtype {.
    importc, libprag.}

proc getPdfSubtype*(self: Document): PDFSubtype =
  poppler_document_get_pdf_subtype(cast[ptr Document00](self.impl))

proc pdfSubtype*(self: Document): PDFSubtype =
  poppler_document_get_pdf_subtype(cast[ptr Document00](self.impl))

type
  Permissions* {.size: sizeof(cint), pure.} = enum
    okToPrint = 1
    okToModify = 2
    okToCopy = 4
    okToAddNotes = 8
    okToFillForm = 16
    okToExtractContents = 32
    okToAssemble = 64
    okToPrintHighResolution = 128
    full = 255

proc poppler_document_get_permissions(self: ptr Document00): Permissions {.
    importc, libprag.}

proc getPermissions*(self: Document): Permissions =
  poppler_document_get_permissions(cast[ptr Document00](self.impl))

proc permissions*(self: Document): Permissions =
  poppler_document_get_permissions(cast[ptr Document00](self.impl))

type
  PrintDuplex* {.size: sizeof(cint), pure.} = enum
    none = 0
    simplex = 1
    duplexFlipShortEdge = 2
    duplexFlipLongEdge = 3

proc poppler_document_get_print_duplex(self: ptr Document00): PrintDuplex {.
    importc, libprag.}

proc getPrintDuplex*(self: Document): PrintDuplex =
  poppler_document_get_print_duplex(cast[ptr Document00](self.impl))

proc printDuplex*(self: Document): PrintDuplex =
  poppler_document_get_print_duplex(cast[ptr Document00](self.impl))

type
  PageRange00* {.pure.} = object
  PageRange* = ref object
    impl*: ptr PageRange00
    ignoreFinalizer*: bool

proc seq2PageRangeArray(s: openarray[PageRange]; a: var cstringArray):  ptr PageRange =
  assert s.high < 256
  let x = cast[ptr UncheckedArray[ptr PageRange]](a)
  for i in 0 .. s.high:
    x[i] = unsafeaddr(s[i])
  return cast[ptr PageRange](x)

proc pageRangeArrayToSeq(s: ptr PageRange; n: int):  seq[PageRange] =
  let a = cast[ptr UncheckedArray[ptr PageRange]](s)
  for i in 0 ..< n:
    result.add(a[i][])
  cogfree(s)



proc poppler_document_get_print_page_ranges(self: ptr Document00; nRanges: var int32): ptr PageRange00 {.
    importc, libprag.}

proc getPrintPageRanges*(self: Document; nRanges: var int): ptr PageRange00 =
  var nRanges_00: int32
  let resul0 = poppler_document_get_print_page_ranges(cast[ptr Document00](self.impl), nRanges_00)
  result = resul0
  if nRanges.addr != nil:
    nRanges = int(nRanges_00)

type
  PrintScaling* {.size: sizeof(cint), pure.} = enum
    appDefault = 0
    none = 1

proc poppler_document_get_print_scaling(self: ptr Document00): PrintScaling {.
    importc, libprag.}

proc getPrintScaling*(self: Document): PrintScaling =
  poppler_document_get_print_scaling(cast[ptr Document00](self.impl))

proc printScaling*(self: Document): PrintScaling =
  poppler_document_get_print_scaling(cast[ptr Document00](self.impl))

type
  FormField* = ref object of gobject.Object
  FormField00* = object of gobject.Object00

proc poppler_form_field_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FormField()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_form_field_button_get_state(self: ptr FormField00): gboolean {.
    importc, libprag.}

proc buttonGetState*(self: FormField): bool =
  toBool(poppler_form_field_button_get_state(cast[ptr FormField00](self.impl)))

proc poppler_form_field_button_set_state(self: ptr FormField00; state: gboolean) {.
    importc, libprag.}

proc buttonSetState*(self: FormField; state: bool = true) =
  poppler_form_field_button_set_state(cast[ptr FormField00](self.impl), gboolean(state))

proc poppler_form_field_choice_can_select_multiple(self: ptr FormField00): gboolean {.
    importc, libprag.}

proc choiceCanSelectMultiple*(self: FormField): bool =
  toBool(poppler_form_field_choice_can_select_multiple(cast[ptr FormField00](self.impl)))

proc poppler_form_field_choice_commit_on_change(self: ptr FormField00): gboolean {.
    importc, libprag.}

proc choiceCommitOnChange*(self: FormField): bool =
  toBool(poppler_form_field_choice_commit_on_change(cast[ptr FormField00](self.impl)))

proc poppler_form_field_choice_do_spell_check(self: ptr FormField00): gboolean {.
    importc, libprag.}

proc choiceDoSpellCheck*(self: FormField): bool =
  toBool(poppler_form_field_choice_do_spell_check(cast[ptr FormField00](self.impl)))

proc poppler_form_field_choice_get_item(self: ptr FormField00; index: int32): cstring {.
    importc, libprag.}

proc choiceGetItem*(self: FormField; index: int): string =
  let resul0 = poppler_form_field_choice_get_item(cast[ptr FormField00](self.impl), int32(index))
  result = $resul0
  cogfree(resul0)

proc poppler_form_field_choice_get_n_items(self: ptr FormField00): int32 {.
    importc, libprag.}

proc choiceGetNItems*(self: FormField): int =
  int(poppler_form_field_choice_get_n_items(cast[ptr FormField00](self.impl)))

proc poppler_form_field_choice_get_text(self: ptr FormField00): cstring {.
    importc, libprag.}

proc choiceGetText*(self: FormField): string =
  let resul0 = poppler_form_field_choice_get_text(cast[ptr FormField00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_form_field_choice_is_editable(self: ptr FormField00): gboolean {.
    importc, libprag.}

proc choiceIsEditable*(self: FormField): bool =
  toBool(poppler_form_field_choice_is_editable(cast[ptr FormField00](self.impl)))

proc poppler_form_field_choice_is_item_selected(self: ptr FormField00; index: int32): gboolean {.
    importc, libprag.}

proc choiceIsItemSelected*(self: FormField; index: int): bool =
  toBool(poppler_form_field_choice_is_item_selected(cast[ptr FormField00](self.impl), int32(index)))

proc poppler_form_field_choice_select_item(self: ptr FormField00; index: int32) {.
    importc, libprag.}

proc choiceSelectItem*(self: FormField; index: int) =
  poppler_form_field_choice_select_item(cast[ptr FormField00](self.impl), int32(index))

proc poppler_form_field_choice_set_text(self: ptr FormField00; text: cstring) {.
    importc, libprag.}

proc choiceSetText*(self: FormField; text: cstring) =
  poppler_form_field_choice_set_text(cast[ptr FormField00](self.impl), text)

proc poppler_form_field_choice_toggle_item(self: ptr FormField00; index: int32) {.
    importc, libprag.}

proc choiceToggleItem*(self: FormField; index: int) =
  poppler_form_field_choice_toggle_item(cast[ptr FormField00](self.impl), int32(index))

proc poppler_form_field_choice_unselect_all(self: ptr FormField00) {.
    importc, libprag.}

proc choiceUnselectAll*(self: FormField) =
  poppler_form_field_choice_unselect_all(cast[ptr FormField00](self.impl))

proc poppler_form_field_get_action(self: ptr FormField00): ptr Action00 {.
    importc, libprag.}

proc getAction*(self: FormField): Action =
  fnew(result, gBoxedFreePopplerAction)
  result.impl = poppler_form_field_get_action(cast[ptr FormField00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_action_get_type(), result.impl))

proc action*(self: FormField): Action =
  fnew(result, gBoxedFreePopplerAction)
  result.impl = poppler_form_field_get_action(cast[ptr FormField00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_action_get_type(), result.impl))

proc poppler_form_field_get_additional_action(self: ptr FormField00; `type`: AdditionalActionType): ptr Action00 {.
    importc, libprag.}

proc getAdditionalAction*(self: FormField; `type`: AdditionalActionType): Action =
  fnew(result, gBoxedFreePopplerAction)
  result.impl = poppler_form_field_get_additional_action(cast[ptr FormField00](self.impl), `type`)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_action_get_type(), result.impl))

proc poppler_form_field_get_alternate_ui_name(self: ptr FormField00): cstring {.
    importc, libprag.}

proc getAlternateUiName*(self: FormField): string =
  let resul0 = poppler_form_field_get_alternate_ui_name(cast[ptr FormField00](self.impl))
  result = $resul0
  cogfree(resul0)

proc alternateUiName*(self: FormField): string =
  let resul0 = poppler_form_field_get_alternate_ui_name(cast[ptr FormField00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_form_field_get_font_size(self: ptr FormField00): cdouble {.
    importc, libprag.}

proc getFontSize*(self: FormField): cdouble =
  poppler_form_field_get_font_size(cast[ptr FormField00](self.impl))

proc fontSize*(self: FormField): cdouble =
  poppler_form_field_get_font_size(cast[ptr FormField00](self.impl))

proc poppler_form_field_get_id(self: ptr FormField00): int32 {.
    importc, libprag.}

proc getId*(self: FormField): int =
  int(poppler_form_field_get_id(cast[ptr FormField00](self.impl)))

proc id*(self: FormField): int =
  int(poppler_form_field_get_id(cast[ptr FormField00](self.impl)))

proc poppler_form_field_get_mapping_name(self: ptr FormField00): cstring {.
    importc, libprag.}

proc getMappingName*(self: FormField): string =
  let resul0 = poppler_form_field_get_mapping_name(cast[ptr FormField00](self.impl))
  result = $resul0
  cogfree(resul0)

proc mappingName*(self: FormField): string =
  let resul0 = poppler_form_field_get_mapping_name(cast[ptr FormField00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_form_field_get_name(self: ptr FormField00): cstring {.
    importc, libprag.}

proc getName*(self: FormField): string =
  let resul0 = poppler_form_field_get_name(cast[ptr FormField00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: FormField): string =
  let resul0 = poppler_form_field_get_name(cast[ptr FormField00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_form_field_get_partial_name(self: ptr FormField00): cstring {.
    importc, libprag.}

proc getPartialName*(self: FormField): string =
  let resul0 = poppler_form_field_get_partial_name(cast[ptr FormField00](self.impl))
  result = $resul0
  cogfree(resul0)

proc partialName*(self: FormField): string =
  let resul0 = poppler_form_field_get_partial_name(cast[ptr FormField00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_form_field_is_read_only(self: ptr FormField00): gboolean {.
    importc, libprag.}

proc isReadOnly*(self: FormField): bool =
  toBool(poppler_form_field_is_read_only(cast[ptr FormField00](self.impl)))

proc poppler_form_field_text_do_scroll(self: ptr FormField00): gboolean {.
    importc, libprag.}

proc textDoScroll*(self: FormField): bool =
  toBool(poppler_form_field_text_do_scroll(cast[ptr FormField00](self.impl)))

proc poppler_form_field_text_do_spell_check(self: ptr FormField00): gboolean {.
    importc, libprag.}

proc textDoSpellCheck*(self: FormField): bool =
  toBool(poppler_form_field_text_do_spell_check(cast[ptr FormField00](self.impl)))

proc poppler_form_field_text_get_max_len(self: ptr FormField00): int32 {.
    importc, libprag.}

proc textGetMaxLen*(self: FormField): int =
  int(poppler_form_field_text_get_max_len(cast[ptr FormField00](self.impl)))

proc poppler_form_field_text_get_text(self: ptr FormField00): cstring {.
    importc, libprag.}

proc textGetText*(self: FormField): string =
  let resul0 = poppler_form_field_text_get_text(cast[ptr FormField00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_form_field_text_is_password(self: ptr FormField00): gboolean {.
    importc, libprag.}

proc textIsPassword*(self: FormField): bool =
  toBool(poppler_form_field_text_is_password(cast[ptr FormField00](self.impl)))

proc poppler_form_field_text_is_rich_text(self: ptr FormField00): gboolean {.
    importc, libprag.}

proc textIsRichText*(self: FormField): bool =
  toBool(poppler_form_field_text_is_rich_text(cast[ptr FormField00](self.impl)))

proc poppler_form_field_text_set_text(self: ptr FormField00; text: cstring) {.
    importc, libprag.}

proc textSetText*(self: FormField; text: cstring) =
  poppler_form_field_text_set_text(cast[ptr FormField00](self.impl), text)

proc poppler_document_get_form_field(self: ptr Document00; id: int32): ptr FormField00 {.
    importc, libprag.}

proc getFormField*(self: Document; id: int): FormField =
  let gobj = poppler_document_get_form_field(cast[ptr Document00](self.impl), int32(id))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_document_get_signature_fields(self: ptr Document00): ptr glib.List {.
    importc, libprag.}

proc getSignatureFields*(self: Document): seq[FormField] =
  let resul0 = poppler_document_get_signature_fields(cast[ptr Document00](self.impl))
  result = glistObjects2seq(FormField, resul0, true)
  g_list_free(resul0)

proc signatureFields*(self: Document): seq[FormField] =
  let resul0 = poppler_document_get_signature_fields(cast[ptr Document00](self.impl))
  result = glistObjects2seq(FormField, resul0, true)
  g_list_free(resul0)

type
  FormButtonType* {.size: sizeof(cint), pure.} = enum
    push = 0
    check = 1
    radio = 2

proc poppler_form_field_button_get_button_type(self: ptr FormField00): FormButtonType {.
    importc, libprag.}

proc buttonGetButtonType*(self: FormField): FormButtonType =
  poppler_form_field_button_get_button_type(cast[ptr FormField00](self.impl))

type
  FormChoiceType* {.size: sizeof(cint), pure.} = enum
    combo = 0
    list = 1

proc poppler_form_field_choice_get_choice_type(self: ptr FormField00): FormChoiceType {.
    importc, libprag.}

proc choiceGetChoiceType*(self: FormField): FormChoiceType =
  poppler_form_field_choice_get_choice_type(cast[ptr FormField00](self.impl))

type
  FormFieldType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    button = 1
    text = 2
    choice = 3
    signature = 4

proc poppler_form_field_get_field_type(self: ptr FormField00): FormFieldType {.
    importc, libprag.}

proc getFieldType*(self: FormField): FormFieldType =
  poppler_form_field_get_field_type(cast[ptr FormField00](self.impl))

proc fieldType*(self: FormField): FormFieldType =
  poppler_form_field_get_field_type(cast[ptr FormField00](self.impl))

type
  SignatureInfo00* {.pure.} = object
  SignatureInfo* = ref object
    impl*: ptr SignatureInfo00
    ignoreFinalizer*: bool

proc poppler_signature_info_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerSignatureInfo*(self: SignatureInfo) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_signature_info_get_type(), cast[ptr SignatureInfo00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SignatureInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_signature_info_get_type(), cast[ptr SignatureInfo00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SignatureInfo) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerSignatureInfo)

proc poppler_signature_info_free(self: ptr SignatureInfo00) {.
    importc, libprag.}

proc free*(self: SignatureInfo) =
  poppler_signature_info_free(cast[ptr SignatureInfo00](self.impl))

proc finalizerfree*(self: SignatureInfo) =
  if not self.ignoreFinalizer:
    poppler_signature_info_free(cast[ptr SignatureInfo00](self.impl))

proc poppler_signature_info_copy(self: ptr SignatureInfo00): ptr SignatureInfo00 {.
    importc, libprag.}

proc copy*(self: SignatureInfo): SignatureInfo =
  fnew(result, gBoxedFreePopplerSignatureInfo)
  result.impl = poppler_signature_info_copy(cast[ptr SignatureInfo00](self.impl))

proc poppler_signature_info_get_local_signing_time(self: ptr SignatureInfo00): ptr glib.DateTime00 {.
    importc, libprag.}

proc getLocalSigningTime*(self: SignatureInfo): glib.DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = poppler_signature_info_get_local_signing_time(cast[ptr SignatureInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), result.impl))

proc localSigningTime*(self: SignatureInfo): glib.DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = poppler_signature_info_get_local_signing_time(cast[ptr SignatureInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), result.impl))

proc poppler_signature_info_get_signer_name(self: ptr SignatureInfo00): cstring {.
    importc, libprag.}

proc getSignerName*(self: SignatureInfo): string =
  result = $poppler_signature_info_get_signer_name(cast[ptr SignatureInfo00](self.impl))

proc signerName*(self: SignatureInfo): string =
  result = $poppler_signature_info_get_signer_name(cast[ptr SignatureInfo00](self.impl))

proc poppler_form_field_signature_validate_finish(self: ptr FormField00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr SignatureInfo00 {.
    importc, libprag.}

proc signatureValidateFinish*(self: FormField; resu: gio.AsyncResult): SignatureInfo =
  var gerror: ptr glib.Error
  let impl0 = poppler_form_field_signature_validate_finish(cast[ptr FormField00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreePopplerSignatureInfo)
  result.impl = impl0

type
  CertificateInfo00* {.pure.} = object
  CertificateInfo* = ref object
    impl*: ptr CertificateInfo00
    ignoreFinalizer*: bool

proc poppler_certificate_info_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerCertificateInfo*(self: CertificateInfo) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_certificate_info_get_type(), cast[ptr CertificateInfo00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CertificateInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_certificate_info_get_type(), cast[ptr CertificateInfo00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var CertificateInfo) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerCertificateInfo)

proc poppler_certificate_info_free(self: ptr CertificateInfo00) {.
    importc, libprag.}

proc free*(self: CertificateInfo) =
  poppler_certificate_info_free(cast[ptr CertificateInfo00](self.impl))

proc finalizerfree*(self: CertificateInfo) =
  if not self.ignoreFinalizer:
    poppler_certificate_info_free(cast[ptr CertificateInfo00](self.impl))

proc poppler_certificate_info_copy(self: ptr CertificateInfo00): ptr CertificateInfo00 {.
    importc, libprag.}

proc copy*(self: CertificateInfo): CertificateInfo =
  fnew(result, gBoxedFreePopplerCertificateInfo)
  result.impl = poppler_certificate_info_copy(cast[ptr CertificateInfo00](self.impl))

proc poppler_certificate_info_new(): ptr CertificateInfo00 {.
    importc, libprag.}

proc newCertificateInfo*(): CertificateInfo =
  fnew(result, gBoxedFreePopplerCertificateInfo)
  result.impl = poppler_certificate_info_new()

proc newCertificateInfo*(tdesc: typedesc): tdesc =
  assert(result is CertificateInfo)
  fnew(result, gBoxedFreePopplerCertificateInfo)
  result.impl = poppler_certificate_info_new()

proc initCertificateInfo*[T](result: var T) {.deprecated.} =
  assert(result is CertificateInfo)
  fnew(result, gBoxedFreePopplerCertificateInfo)
  result.impl = poppler_certificate_info_new()

proc poppler_certificate_info_get_expiration_time(self: ptr CertificateInfo00): ptr glib.DateTime00 {.
    importc, libprag.}

proc getExpirationTime*(self: CertificateInfo): glib.DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = poppler_certificate_info_get_expiration_time(cast[ptr CertificateInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), result.impl))

proc expirationTime*(self: CertificateInfo): glib.DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = poppler_certificate_info_get_expiration_time(cast[ptr CertificateInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), result.impl))

proc poppler_certificate_info_get_id(self: ptr CertificateInfo00): cstring {.
    importc, libprag.}

proc getId*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_id(cast[ptr CertificateInfo00](self.impl))

proc id*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_id(cast[ptr CertificateInfo00](self.impl))

proc poppler_certificate_info_get_issuance_time(self: ptr CertificateInfo00): ptr glib.DateTime00 {.
    importc, libprag.}

proc getIssuanceTime*(self: CertificateInfo): glib.DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = poppler_certificate_info_get_issuance_time(cast[ptr CertificateInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), result.impl))

proc issuanceTime*(self: CertificateInfo): glib.DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = poppler_certificate_info_get_issuance_time(cast[ptr CertificateInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), result.impl))

proc poppler_certificate_info_get_issuer_common_name(self: ptr CertificateInfo00): cstring {.
    importc, libprag.}

proc getIssuerCommonName*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_issuer_common_name(cast[ptr CertificateInfo00](self.impl))

proc issuerCommonName*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_issuer_common_name(cast[ptr CertificateInfo00](self.impl))

proc poppler_certificate_info_get_issuer_email(self: ptr CertificateInfo00): cstring {.
    importc, libprag.}

proc getIssuerEmail*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_issuer_email(cast[ptr CertificateInfo00](self.impl))

proc issuerEmail*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_issuer_email(cast[ptr CertificateInfo00](self.impl))

proc poppler_certificate_info_get_issuer_organization(self: ptr CertificateInfo00): cstring {.
    importc, libprag.}

proc getIssuerOrganization*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_issuer_organization(cast[ptr CertificateInfo00](self.impl))

proc issuerOrganization*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_issuer_organization(cast[ptr CertificateInfo00](self.impl))

proc poppler_certificate_info_get_subject_common_name(self: ptr CertificateInfo00): cstring {.
    importc, libprag.}

proc getSubjectCommonName*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_subject_common_name(cast[ptr CertificateInfo00](self.impl))

proc subjectCommonName*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_subject_common_name(cast[ptr CertificateInfo00](self.impl))

proc poppler_certificate_info_get_subject_email(self: ptr CertificateInfo00): cstring {.
    importc, libprag.}

proc getSubjectEmail*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_subject_email(cast[ptr CertificateInfo00](self.impl))

proc subjectEmail*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_subject_email(cast[ptr CertificateInfo00](self.impl))

proc poppler_certificate_info_get_subject_organization(self: ptr CertificateInfo00): cstring {.
    importc, libprag.}

proc getSubjectOrganization*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_subject_organization(cast[ptr CertificateInfo00](self.impl))

proc subjectOrganization*(self: CertificateInfo): string =
  result = $poppler_certificate_info_get_subject_organization(cast[ptr CertificateInfo00](self.impl))

proc poppler_signature_info_get_certificate_info(self: ptr SignatureInfo00): ptr CertificateInfo00 {.
    importc, libprag.}

proc getCertificateInfo*(self: SignatureInfo): CertificateInfo =
  fnew(result, gBoxedFreePopplerCertificateInfo)
  result.impl = poppler_signature_info_get_certificate_info(cast[ptr SignatureInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_certificate_info_get_type(), result.impl))

proc certificateInfo*(self: SignatureInfo): CertificateInfo =
  fnew(result, gBoxedFreePopplerCertificateInfo)
  result.impl = poppler_signature_info_get_certificate_info(cast[ptr SignatureInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_certificate_info_get_type(), result.impl))

type
  CertificateStatus* {.size: sizeof(cint), pure.} = enum
    trusted = 0
    untrustedIssuer = 1
    unknownIssuer = 2
    revoked = 3
    expired = 4
    genericError = 5
    notVerified = 6

proc poppler_signature_info_get_certificate_status(self: ptr SignatureInfo00): CertificateStatus {.
    importc, libprag.}

proc getCertificateStatus*(self: SignatureInfo): CertificateStatus =
  poppler_signature_info_get_certificate_status(cast[ptr SignatureInfo00](self.impl))

proc certificateStatus*(self: SignatureInfo): CertificateStatus =
  poppler_signature_info_get_certificate_status(cast[ptr SignatureInfo00](self.impl))

type
  SignatureStatus* {.size: sizeof(cint), pure.} = enum
    valid = 0
    invalid = 1
    digestMismatch = 2
    decodingError = 3
    genericError = 4
    notFound = 5
    notVerified = 6

proc poppler_signature_info_get_signature_status(self: ptr SignatureInfo00): SignatureStatus {.
    importc, libprag.}

proc getSignatureStatus*(self: SignatureInfo): SignatureStatus =
  poppler_signature_info_get_signature_status(cast[ptr SignatureInfo00](self.impl))

proc signatureStatus*(self: SignatureInfo): SignatureStatus =
  poppler_signature_info_get_signature_status(cast[ptr SignatureInfo00](self.impl))

type
  SignatureValidationFlag* {.size: sizeof(cint), pure.} = enum
    validateCertificate = 0
    withoutOcspRevocationCheck = 1
    useAiaCertificateFetch = 2

  SignatureValidationFlags* = set[SignatureValidationFlag]

proc poppler_form_field_signature_validate_async(self: ptr FormField00; flags: SignatureValidationFlags;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc signatureValidateAsync*(self: FormField; flags: SignatureValidationFlags;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  poppler_form_field_signature_validate_async(cast[ptr FormField00](self.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc poppler_form_field_signature_validate_sync(self: ptr FormField00; flags: SignatureValidationFlags;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): ptr SignatureInfo00 {.
    importc, libprag.}

proc signatureValidateSync*(self: FormField; flags: SignatureValidationFlags;
    cancellable: gio.Cancellable = nil): SignatureInfo =
  var gerror: ptr glib.Error
  let impl0 = poppler_form_field_signature_validate_sync(cast[ptr FormField00](self.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreePopplerSignatureInfo)
  result.impl = impl0

type
  FormTextType* {.size: sizeof(cint), pure.} = enum
    normal = 0
    multiline = 1
    fileSelect = 2

proc poppler_form_field_text_get_text_type(self: ptr FormField00): FormTextType {.
    importc, libprag.}

proc textGetTextType*(self: FormField): FormTextType =
  poppler_form_field_text_get_text_type(cast[ptr FormField00](self.impl))

type
  SigningData00* {.pure.} = object
  SigningData* = ref object
    impl*: ptr SigningData00
    ignoreFinalizer*: bool

proc poppler_signing_data_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerSigningData*(self: SigningData) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_signing_data_get_type(), cast[ptr SigningData00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SigningData()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_signing_data_get_type(), cast[ptr SigningData00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SigningData) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerSigningData)

proc poppler_signing_data_free(self: ptr SigningData00) {.
    importc, libprag.}

proc free*(self: SigningData) =
  poppler_signing_data_free(cast[ptr SigningData00](self.impl))

proc finalizerfree*(self: SigningData) =
  if not self.ignoreFinalizer:
    poppler_signing_data_free(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_copy(self: ptr SigningData00): ptr SigningData00 {.
    importc, libprag.}

proc copy*(self: SigningData): SigningData =
  fnew(result, gBoxedFreePopplerSigningData)
  result.impl = poppler_signing_data_copy(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_new(): ptr SigningData00 {.
    importc, libprag.}

proc newSigningData*(): SigningData =
  fnew(result, gBoxedFreePopplerSigningData)
  result.impl = poppler_signing_data_new()

proc newSigningData*(tdesc: typedesc): tdesc =
  assert(result is SigningData)
  fnew(result, gBoxedFreePopplerSigningData)
  result.impl = poppler_signing_data_new()

proc initSigningData*[T](result: var T) {.deprecated.} =
  assert(result is SigningData)
  fnew(result, gBoxedFreePopplerSigningData)
  result.impl = poppler_signing_data_new()

proc poppler_signing_data_get_background_color(self: ptr SigningData00): ptr Color00 {.
    importc, libprag.}

proc getBackgroundColor*(self: SigningData): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_signing_data_get_background_color(cast[ptr SigningData00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_color_get_type(), result.impl))

proc backgroundColor*(self: SigningData): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_signing_data_get_background_color(cast[ptr SigningData00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_color_get_type(), result.impl))

proc poppler_signing_data_get_border_color(self: ptr SigningData00): ptr Color00 {.
    importc, libprag.}

proc getBorderColor*(self: SigningData): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_signing_data_get_border_color(cast[ptr SigningData00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_color_get_type(), result.impl))

proc borderColor*(self: SigningData): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_signing_data_get_border_color(cast[ptr SigningData00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_color_get_type(), result.impl))

proc poppler_signing_data_get_border_width(self: ptr SigningData00): cdouble {.
    importc, libprag.}

proc getBorderWidth*(self: SigningData): cdouble =
  poppler_signing_data_get_border_width(cast[ptr SigningData00](self.impl))

proc borderWidth*(self: SigningData): cdouble =
  poppler_signing_data_get_border_width(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_certificate_info(self: ptr SigningData00): ptr CertificateInfo00 {.
    importc, libprag.}

proc getCertificateInfo*(self: SigningData): CertificateInfo =
  fnew(result, gBoxedFreePopplerCertificateInfo)
  result.impl = poppler_signing_data_get_certificate_info(cast[ptr SigningData00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_certificate_info_get_type(), result.impl))

proc certificateInfo*(self: SigningData): CertificateInfo =
  fnew(result, gBoxedFreePopplerCertificateInfo)
  result.impl = poppler_signing_data_get_certificate_info(cast[ptr SigningData00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_certificate_info_get_type(), result.impl))

proc poppler_signing_data_get_destination_filename(self: ptr SigningData00): cstring {.
    importc, libprag.}

proc getDestinationFilename*(self: SigningData): string =
  result = $poppler_signing_data_get_destination_filename(cast[ptr SigningData00](self.impl))

proc destinationFilename*(self: SigningData): string =
  result = $poppler_signing_data_get_destination_filename(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_document_owner_password(self: ptr SigningData00): cstring {.
    importc, libprag.}

proc getDocumentOwnerPassword*(self: SigningData): string =
  result = $poppler_signing_data_get_document_owner_password(cast[ptr SigningData00](self.impl))

proc documentOwnerPassword*(self: SigningData): string =
  result = $poppler_signing_data_get_document_owner_password(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_document_user_password(self: ptr SigningData00): cstring {.
    importc, libprag.}

proc getDocumentUserPassword*(self: SigningData): string =
  result = $poppler_signing_data_get_document_user_password(cast[ptr SigningData00](self.impl))

proc documentUserPassword*(self: SigningData): string =
  result = $poppler_signing_data_get_document_user_password(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_field_partial_name(self: ptr SigningData00): cstring {.
    importc, libprag.}

proc getFieldPartialName*(self: SigningData): string =
  result = $poppler_signing_data_get_field_partial_name(cast[ptr SigningData00](self.impl))

proc fieldPartialName*(self: SigningData): string =
  result = $poppler_signing_data_get_field_partial_name(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_font_color(self: ptr SigningData00): ptr Color00 {.
    importc, libprag.}

proc getFontColor*(self: SigningData): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_signing_data_get_font_color(cast[ptr SigningData00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_color_get_type(), result.impl))

proc fontColor*(self: SigningData): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_signing_data_get_font_color(cast[ptr SigningData00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_color_get_type(), result.impl))

proc poppler_signing_data_get_font_size(self: ptr SigningData00): cdouble {.
    importc, libprag.}

proc getFontSize*(self: SigningData): cdouble =
  poppler_signing_data_get_font_size(cast[ptr SigningData00](self.impl))

proc fontSize*(self: SigningData): cdouble =
  poppler_signing_data_get_font_size(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_image_path(self: ptr SigningData00): cstring {.
    importc, libprag.}

proc getImagePath*(self: SigningData): string =
  result = $poppler_signing_data_get_image_path(cast[ptr SigningData00](self.impl))

proc imagePath*(self: SigningData): string =
  result = $poppler_signing_data_get_image_path(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_left_font_size(self: ptr SigningData00): cdouble {.
    importc, libprag.}

proc getLeftFontSize*(self: SigningData): cdouble =
  poppler_signing_data_get_left_font_size(cast[ptr SigningData00](self.impl))

proc leftFontSize*(self: SigningData): cdouble =
  poppler_signing_data_get_left_font_size(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_location(self: ptr SigningData00): cstring {.
    importc, libprag.}

proc getLocation*(self: SigningData): string =
  result = $poppler_signing_data_get_location(cast[ptr SigningData00](self.impl))

proc location*(self: SigningData): string =
  result = $poppler_signing_data_get_location(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_page(self: ptr SigningData00): int32 {.
    importc, libprag.}

proc getPage*(self: SigningData): int =
  int(poppler_signing_data_get_page(cast[ptr SigningData00](self.impl)))

proc page*(self: SigningData): int =
  int(poppler_signing_data_get_page(cast[ptr SigningData00](self.impl)))

proc poppler_signing_data_get_password(self: ptr SigningData00): cstring {.
    importc, libprag.}

proc getPassword*(self: SigningData): string =
  result = $poppler_signing_data_get_password(cast[ptr SigningData00](self.impl))

proc password*(self: SigningData): string =
  result = $poppler_signing_data_get_password(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_reason(self: ptr SigningData00): cstring {.
    importc, libprag.}

proc getReason*(self: SigningData): string =
  result = $poppler_signing_data_get_reason(cast[ptr SigningData00](self.impl))

proc reason*(self: SigningData): string =
  result = $poppler_signing_data_get_reason(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_signature_rectangle(self: ptr SigningData00): ptr Rectangle00 {.
    importc, libprag.}

proc getSignatureRectangle*(self: SigningData): Rectangle =
  fnew(result, gBoxedFreePopplerRectangle)
  result.impl = poppler_signing_data_get_signature_rectangle(cast[ptr SigningData00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_rectangle_get_type(), result.impl))

proc signatureRectangle*(self: SigningData): Rectangle =
  fnew(result, gBoxedFreePopplerRectangle)
  result.impl = poppler_signing_data_get_signature_rectangle(cast[ptr SigningData00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_rectangle_get_type(), result.impl))

proc poppler_signing_data_get_signature_text(self: ptr SigningData00): cstring {.
    importc, libprag.}

proc getSignatureText*(self: SigningData): string =
  result = $poppler_signing_data_get_signature_text(cast[ptr SigningData00](self.impl))

proc signatureText*(self: SigningData): string =
  result = $poppler_signing_data_get_signature_text(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_get_signature_text_left(self: ptr SigningData00): cstring {.
    importc, libprag.}

proc getSignatureTextLeft*(self: SigningData): string =
  result = $poppler_signing_data_get_signature_text_left(cast[ptr SigningData00](self.impl))

proc signatureTextLeft*(self: SigningData): string =
  result = $poppler_signing_data_get_signature_text_left(cast[ptr SigningData00](self.impl))

proc poppler_signing_data_set_background_color(self: ptr SigningData00; backgroundColor: ptr Color00) {.
    importc, libprag.}

proc setBackgroundColor*(self: SigningData; backgroundColor: Color) =
  poppler_signing_data_set_background_color(cast[ptr SigningData00](self.impl), cast[ptr Color00](backgroundColor.impl))

proc `backgroundColor=`*(self: SigningData; backgroundColor: Color) =
  poppler_signing_data_set_background_color(cast[ptr SigningData00](self.impl), cast[ptr Color00](backgroundColor.impl))

proc poppler_signing_data_set_border_color(self: ptr SigningData00; borderColor: ptr Color00) {.
    importc, libprag.}

proc setBorderColor*(self: SigningData; borderColor: Color) =
  poppler_signing_data_set_border_color(cast[ptr SigningData00](self.impl), cast[ptr Color00](borderColor.impl))

proc `borderColor=`*(self: SigningData; borderColor: Color) =
  poppler_signing_data_set_border_color(cast[ptr SigningData00](self.impl), cast[ptr Color00](borderColor.impl))

proc poppler_signing_data_set_border_width(self: ptr SigningData00; borderWidth: cdouble) {.
    importc, libprag.}

proc setBorderWidth*(self: SigningData; borderWidth: cdouble) =
  poppler_signing_data_set_border_width(cast[ptr SigningData00](self.impl), borderWidth)

proc `borderWidth=`*(self: SigningData; borderWidth: cdouble) =
  poppler_signing_data_set_border_width(cast[ptr SigningData00](self.impl), borderWidth)

proc poppler_signing_data_set_certificate_info(self: ptr SigningData00; certificateInfo: ptr CertificateInfo00) {.
    importc, libprag.}

proc setCertificateInfo*(self: SigningData; certificateInfo: CertificateInfo) =
  poppler_signing_data_set_certificate_info(cast[ptr SigningData00](self.impl), cast[ptr CertificateInfo00](certificateInfo.impl))

proc `certificateInfo=`*(self: SigningData; certificateInfo: CertificateInfo) =
  poppler_signing_data_set_certificate_info(cast[ptr SigningData00](self.impl), cast[ptr CertificateInfo00](certificateInfo.impl))

proc poppler_signing_data_set_destination_filename(self: ptr SigningData00;
    filename: cstring) {.
    importc, libprag.}

proc setDestinationFilename*(self: SigningData; filename: cstring) =
  poppler_signing_data_set_destination_filename(cast[ptr SigningData00](self.impl), filename)

proc `destinationFilename=`*(self: SigningData; filename: cstring) =
  poppler_signing_data_set_destination_filename(cast[ptr SigningData00](self.impl), filename)

proc poppler_signing_data_set_document_owner_password(self: ptr SigningData00;
    documentOwnerPassword: cstring) {.
    importc, libprag.}

proc setDocumentOwnerPassword*(self: SigningData;
    documentOwnerPassword: cstring) =
  poppler_signing_data_set_document_owner_password(cast[ptr SigningData00](self.impl), documentOwnerPassword)

proc `documentOwnerPassword=`*(self: SigningData;
    documentOwnerPassword: cstring) =
  poppler_signing_data_set_document_owner_password(cast[ptr SigningData00](self.impl), documentOwnerPassword)

proc poppler_signing_data_set_document_user_password(self: ptr SigningData00;
    documentUserPassword: cstring) {.
    importc, libprag.}

proc setDocumentUserPassword*(self: SigningData; documentUserPassword: cstring) =
  poppler_signing_data_set_document_user_password(cast[ptr SigningData00](self.impl), documentUserPassword)

proc `documentUserPassword=`*(self: SigningData; documentUserPassword: cstring) =
  poppler_signing_data_set_document_user_password(cast[ptr SigningData00](self.impl), documentUserPassword)

proc poppler_signing_data_set_field_partial_name(self: ptr SigningData00;
    fieldPartialName: cstring) {.
    importc, libprag.}

proc setFieldPartialName*(self: SigningData; fieldPartialName: cstring) =
  poppler_signing_data_set_field_partial_name(cast[ptr SigningData00](self.impl), fieldPartialName)

proc `fieldPartialName=`*(self: SigningData; fieldPartialName: cstring) =
  poppler_signing_data_set_field_partial_name(cast[ptr SigningData00](self.impl), fieldPartialName)

proc poppler_signing_data_set_font_color(self: ptr SigningData00; fontColor: ptr Color00) {.
    importc, libprag.}

proc setFontColor*(self: SigningData; fontColor: Color) =
  poppler_signing_data_set_font_color(cast[ptr SigningData00](self.impl), cast[ptr Color00](fontColor.impl))

proc `fontColor=`*(self: SigningData; fontColor: Color) =
  poppler_signing_data_set_font_color(cast[ptr SigningData00](self.impl), cast[ptr Color00](fontColor.impl))

proc poppler_signing_data_set_font_size(self: ptr SigningData00; fontSize: cdouble) {.
    importc, libprag.}

proc setFontSize*(self: SigningData; fontSize: cdouble) =
  poppler_signing_data_set_font_size(cast[ptr SigningData00](self.impl), fontSize)

proc `fontSize=`*(self: SigningData; fontSize: cdouble) =
  poppler_signing_data_set_font_size(cast[ptr SigningData00](self.impl), fontSize)

proc poppler_signing_data_set_image_path(self: ptr SigningData00; imagePath: cstring) {.
    importc, libprag.}

proc setImagePath*(self: SigningData; imagePath: cstring) =
  poppler_signing_data_set_image_path(cast[ptr SigningData00](self.impl), imagePath)

proc `imagePath=`*(self: SigningData; imagePath: cstring) =
  poppler_signing_data_set_image_path(cast[ptr SigningData00](self.impl), imagePath)

proc poppler_signing_data_set_left_font_size(self: ptr SigningData00; fontSize: cdouble) {.
    importc, libprag.}

proc setLeftFontSize*(self: SigningData; fontSize: cdouble) =
  poppler_signing_data_set_left_font_size(cast[ptr SigningData00](self.impl), fontSize)

proc `leftFontSize=`*(self: SigningData; fontSize: cdouble) =
  poppler_signing_data_set_left_font_size(cast[ptr SigningData00](self.impl), fontSize)

proc poppler_signing_data_set_location(self: ptr SigningData00; location: cstring) {.
    importc, libprag.}

proc setLocation*(self: SigningData; location: cstring) =
  poppler_signing_data_set_location(cast[ptr SigningData00](self.impl), location)

proc `location=`*(self: SigningData; location: cstring) =
  poppler_signing_data_set_location(cast[ptr SigningData00](self.impl), location)

proc poppler_signing_data_set_page(self: ptr SigningData00; page: int32) {.
    importc, libprag.}

proc setPage*(self: SigningData; page: int) =
  poppler_signing_data_set_page(cast[ptr SigningData00](self.impl), int32(page))

proc `page=`*(self: SigningData; page: int) =
  poppler_signing_data_set_page(cast[ptr SigningData00](self.impl), int32(page))

proc poppler_signing_data_set_password(self: ptr SigningData00; password: cstring) {.
    importc, libprag.}

proc setPassword*(self: SigningData; password: cstring) =
  poppler_signing_data_set_password(cast[ptr SigningData00](self.impl), password)

proc `password=`*(self: SigningData; password: cstring) =
  poppler_signing_data_set_password(cast[ptr SigningData00](self.impl), password)

proc poppler_signing_data_set_reason(self: ptr SigningData00; reason: cstring) {.
    importc, libprag.}

proc setReason*(self: SigningData; reason: cstring) =
  poppler_signing_data_set_reason(cast[ptr SigningData00](self.impl), reason)

proc `reason=`*(self: SigningData; reason: cstring) =
  poppler_signing_data_set_reason(cast[ptr SigningData00](self.impl), reason)

proc poppler_signing_data_set_signature_rectangle(self: ptr SigningData00;
    signatureRect: ptr Rectangle00) {.
    importc, libprag.}

proc setSignatureRectangle*(self: SigningData; signatureRect: Rectangle) =
  poppler_signing_data_set_signature_rectangle(cast[ptr SigningData00](self.impl), cast[ptr Rectangle00](signatureRect.impl))

proc `signatureRectangle=`*(self: SigningData; signatureRect: Rectangle) =
  poppler_signing_data_set_signature_rectangle(cast[ptr SigningData00](self.impl), cast[ptr Rectangle00](signatureRect.impl))

proc poppler_signing_data_set_signature_text(self: ptr SigningData00; signatureText: cstring) {.
    importc, libprag.}

proc setSignatureText*(self: SigningData; signatureText: cstring) =
  poppler_signing_data_set_signature_text(cast[ptr SigningData00](self.impl), signatureText)

proc `signatureText=`*(self: SigningData; signatureText: cstring) =
  poppler_signing_data_set_signature_text(cast[ptr SigningData00](self.impl), signatureText)

proc poppler_signing_data_set_signature_text_left(self: ptr SigningData00;
    signatureTextLeft: cstring) {.
    importc, libprag.}

proc setSignatureTextLeft*(self: SigningData; signatureTextLeft: cstring) =
  poppler_signing_data_set_signature_text_left(cast[ptr SigningData00](self.impl), signatureTextLeft)

proc `signatureTextLeft=`*(self: SigningData; signatureTextLeft: cstring) =
  poppler_signing_data_set_signature_text_left(cast[ptr SigningData00](self.impl), signatureTextLeft)

proc poppler_document_sign(self: ptr Document00; signingData: ptr SigningData00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc sign*(self: Document; signingData: SigningData; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  poppler_document_sign(cast[ptr Document00](self.impl), cast[ptr SigningData00](signingData.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

type
  AnnotFileAttachment* = ref object of AnnotMarkup
  AnnotFileAttachment00* = object of AnnotMarkup00

proc poppler_annot_file_attachment_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotFileAttachment()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_file_attachment_get_attachment(self: ptr AnnotFileAttachment00): ptr Attachment00 {.
    importc, libprag.}

proc getAttachment*(self: AnnotFileAttachment): Attachment =
  let gobj = poppler_annot_file_attachment_get_attachment(cast[ptr AnnotFileAttachment00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc attachment*(self: AnnotFileAttachment): Attachment =
  let gobj = poppler_annot_file_attachment_get_attachment(cast[ptr AnnotFileAttachment00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_annot_file_attachment_get_name(self: ptr AnnotFileAttachment00): cstring {.
    importc, libprag.}

proc getName*(self: AnnotFileAttachment): string =
  let resul0 = poppler_annot_file_attachment_get_name(cast[ptr AnnotFileAttachment00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: AnnotFileAttachment): string =
  let resul0 = poppler_annot_file_attachment_get_name(cast[ptr AnnotFileAttachment00](self.impl))
  result = $resul0
  cogfree(resul0)

type
  AnnotFreeText* = ref object of AnnotMarkup
  AnnotFreeText00* = object of AnnotMarkup00

proc poppler_annot_free_text_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotFreeText()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_free_text_get_callout_line(self: ptr AnnotFreeText00): ptr AnnotCalloutLine00 {.
    importc, libprag.}

proc getCalloutLine*(self: AnnotFreeText): AnnotCalloutLine =
  fnew(result, gBoxedFreePopplerAnnotCalloutLine)
  result.impl = poppler_annot_free_text_get_callout_line(cast[ptr AnnotFreeText00](self.impl))

proc calloutLine*(self: AnnotFreeText): AnnotCalloutLine =
  fnew(result, gBoxedFreePopplerAnnotCalloutLine)
  result.impl = poppler_annot_free_text_get_callout_line(cast[ptr AnnotFreeText00](self.impl))

type
  AnnotFreeTextQuadding* {.size: sizeof(cint), pure.} = enum
    leftJustified = 0
    centered = 1
    rightJustified = 2

proc poppler_annot_free_text_get_quadding(self: ptr AnnotFreeText00): AnnotFreeTextQuadding {.
    importc, libprag.}

proc getQuadding*(self: AnnotFreeText): AnnotFreeTextQuadding =
  poppler_annot_free_text_get_quadding(cast[ptr AnnotFreeText00](self.impl))

proc quadding*(self: AnnotFreeText): AnnotFreeTextQuadding =
  poppler_annot_free_text_get_quadding(cast[ptr AnnotFreeText00](self.impl))

type
  AnnotLine* = ref object of AnnotMarkup
  AnnotLine00* = object of AnnotMarkup00

proc poppler_annot_line_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotLine()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  Point00* {.pure.} = object
  Point* = ref object
    impl*: ptr Point00
    ignoreFinalizer*: bool

proc poppler_point_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerPoint*(self: Point) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_point_get_type(), cast[ptr Point00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Point()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_point_get_type(), cast[ptr Point00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Point) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerPoint)

proc poppler_point_free(self: ptr Point00) {.
    importc, libprag.}

proc free*(self: Point) =
  poppler_point_free(cast[ptr Point00](self.impl))

proc finalizerfree*(self: Point) =
  if not self.ignoreFinalizer:
    poppler_point_free(cast[ptr Point00](self.impl))

proc poppler_point_copy(self: ptr Point00): ptr Point00 {.
    importc, libprag.}

proc copy*(self: Point): Point =
  fnew(result, gBoxedFreePopplerPoint)
  result.impl = poppler_point_copy(cast[ptr Point00](self.impl))

proc poppler_point_new(): ptr Point00 {.
    importc, libprag.}

proc newPoint*(): Point =
  fnew(result, gBoxedFreePopplerPoint)
  result.impl = poppler_point_new()

proc newPoint*(tdesc: typedesc): tdesc =
  assert(result is Point)
  fnew(result, gBoxedFreePopplerPoint)
  result.impl = poppler_point_new()

proc initPoint*[T](result: var T) {.deprecated.} =
  assert(result is Point)
  fnew(result, gBoxedFreePopplerPoint)
  result.impl = poppler_point_new()

proc poppler_annot_line_new(doc: ptr Document00; rect: ptr Rectangle00; start: ptr Point00;
    `end`: ptr Point00): ptr AnnotLine00 {.
    importc, libprag.}

proc newAnnotLine*(doc: Document; rect: Rectangle; start: Point;
    `end`: Point): AnnotLine =
  let gobj = poppler_annot_line_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), cast[ptr Point00](start.impl), cast[ptr Point00](`end`.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAnnotLine*(tdesc: typedesc; doc: Document; rect: Rectangle; start: Point;
    `end`: Point): tdesc =
  assert(result is AnnotLine)
  let gobj = poppler_annot_line_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), cast[ptr Point00](start.impl), cast[ptr Point00](`end`.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAnnotLine*[T](result: var T; doc: Document; rect: Rectangle; start: Point;
    `end`: Point) {.deprecated.} =
  assert(result is AnnotLine)
  let gobj = poppler_annot_line_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), cast[ptr Point00](start.impl), cast[ptr Point00](`end`.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_annot_line_set_vertices(self: ptr AnnotLine00; start: ptr Point00;
    `end`: ptr Point00) {.
    importc, libprag.}

proc setVertices*(self: AnnotLine; start: Point; `end`: Point) =
  poppler_annot_line_set_vertices(cast[ptr AnnotLine00](self.impl), cast[ptr Point00](start.impl), cast[ptr Point00](`end`.impl))

type
  AnnotMovie* = ref object of Annot
  AnnotMovie00* = object of Annot00

proc poppler_annot_movie_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotMovie()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_movie_get_title(self: ptr AnnotMovie00): cstring {.
    importc, libprag.}

proc getTitle*(self: AnnotMovie): string =
  let resul0 = poppler_annot_movie_get_title(cast[ptr AnnotMovie00](self.impl))
  result = $resul0
  cogfree(resul0)

proc title*(self: AnnotMovie): string =
  let resul0 = poppler_annot_movie_get_title(cast[ptr AnnotMovie00](self.impl))
  result = $resul0
  cogfree(resul0)

type
  Movie* = ref object of gobject.Object
  Movie00* = object of gobject.Object00

proc poppler_movie_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Movie()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_movie_get_aspect(self: ptr Movie00; width: ptr int32; height: ptr int32) {.
    importc, libprag.}

proc getAspect*(self: Movie; width: ptr int32; height: ptr int32) =
  poppler_movie_get_aspect(cast[ptr Movie00](self.impl), width, height)

proc poppler_movie_get_duration(self: ptr Movie00): uint64 {.
    importc, libprag.}

proc getDuration*(self: Movie): uint64 =
  poppler_movie_get_duration(cast[ptr Movie00](self.impl))

proc duration*(self: Movie): uint64 =
  poppler_movie_get_duration(cast[ptr Movie00](self.impl))

proc poppler_movie_get_filename(self: ptr Movie00): cstring {.
    importc, libprag.}

proc getFilename*(self: Movie): string =
  result = $poppler_movie_get_filename(cast[ptr Movie00](self.impl))

proc filename*(self: Movie): string =
  result = $poppler_movie_get_filename(cast[ptr Movie00](self.impl))

proc poppler_movie_get_rate(self: ptr Movie00): cdouble {.
    importc, libprag.}

proc getRate*(self: Movie): cdouble =
  poppler_movie_get_rate(cast[ptr Movie00](self.impl))

proc rate*(self: Movie): cdouble =
  poppler_movie_get_rate(cast[ptr Movie00](self.impl))

proc poppler_movie_get_rotation_angle(self: ptr Movie00): uint16 {.
    importc, libprag.}

proc getRotationAngle*(self: Movie): uint16 =
  poppler_movie_get_rotation_angle(cast[ptr Movie00](self.impl))

proc rotationAngle*(self: Movie): uint16 =
  poppler_movie_get_rotation_angle(cast[ptr Movie00](self.impl))

proc poppler_movie_get_start(self: ptr Movie00): uint64 {.
    importc, libprag.}

proc getStart*(self: Movie): uint64 =
  poppler_movie_get_start(cast[ptr Movie00](self.impl))

proc start*(self: Movie): uint64 =
  poppler_movie_get_start(cast[ptr Movie00](self.impl))

proc poppler_movie_get_volume(self: ptr Movie00): cdouble {.
    importc, libprag.}

proc getVolume*(self: Movie): cdouble =
  poppler_movie_get_volume(cast[ptr Movie00](self.impl))

proc volume*(self: Movie): cdouble =
  poppler_movie_get_volume(cast[ptr Movie00](self.impl))

proc poppler_movie_is_synchronous(self: ptr Movie00): gboolean {.
    importc, libprag.}

proc isSynchronous*(self: Movie): bool =
  toBool(poppler_movie_is_synchronous(cast[ptr Movie00](self.impl)))

proc poppler_movie_need_poster(self: ptr Movie00): gboolean {.
    importc, libprag.}

proc needPoster*(self: Movie): bool =
  toBool(poppler_movie_need_poster(cast[ptr Movie00](self.impl)))

proc poppler_movie_show_controls(self: ptr Movie00): gboolean {.
    importc, libprag.}

proc showControls*(self: Movie): bool =
  toBool(poppler_movie_show_controls(cast[ptr Movie00](self.impl)))

proc poppler_annot_movie_get_movie(self: ptr AnnotMovie00): ptr Movie00 {.
    importc, libprag.}

proc getMovie*(self: AnnotMovie): Movie =
  let gobj = poppler_annot_movie_get_movie(cast[ptr AnnotMovie00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc movie*(self: AnnotMovie): Movie =
  let gobj = poppler_annot_movie_get_movie(cast[ptr AnnotMovie00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  MoviePlayMode* {.size: sizeof(cint), pure.} = enum
    once = 0
    open = 1
    repeat = 2
    palindrome = 3

proc poppler_movie_get_play_mode(self: ptr Movie00): MoviePlayMode {.
    importc, libprag.}

proc getPlayMode*(self: Movie): MoviePlayMode =
  poppler_movie_get_play_mode(cast[ptr Movie00](self.impl))

proc playMode*(self: Movie): MoviePlayMode =
  poppler_movie_get_play_mode(cast[ptr Movie00](self.impl))

type
  AnnotScreen* = ref object of Annot
  AnnotScreen00* = object of Annot00

proc poppler_annot_screen_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotScreen()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_screen_get_action(self: ptr AnnotScreen00): ptr Action00 {.
    importc, libprag.}

proc getAction*(self: AnnotScreen): Action =
  fnew(result, gBoxedFreePopplerAction)
  result.impl = poppler_annot_screen_get_action(cast[ptr AnnotScreen00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_action_get_type(), result.impl))

proc action*(self: AnnotScreen): Action =
  fnew(result, gBoxedFreePopplerAction)
  result.impl = poppler_annot_screen_get_action(cast[ptr AnnotScreen00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(poppler_action_get_type(), result.impl))

type
  AnnotSquare* = ref object of AnnotMarkup
  AnnotSquare00* = object of AnnotMarkup00

proc poppler_annot_square_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotSquare()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_square_new(doc: ptr Document00; rect: ptr Rectangle00): ptr AnnotSquare00 {.
    importc, libprag.}

proc newAnnotSquare*(doc: Document; rect: Rectangle): AnnotSquare =
  let gobj = poppler_annot_square_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAnnotSquare*(tdesc: typedesc; doc: Document; rect: Rectangle): tdesc =
  assert(result is AnnotSquare)
  let gobj = poppler_annot_square_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAnnotSquare*[T](result: var T; doc: Document; rect: Rectangle) {.deprecated.} =
  assert(result is AnnotSquare)
  let gobj = poppler_annot_square_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_annot_square_get_interior_color(self: ptr AnnotSquare00): ptr Color00 {.
    importc, libprag.}

proc getInteriorColor*(self: AnnotSquare): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_annot_square_get_interior_color(cast[ptr AnnotSquare00](self.impl))

proc interiorColor*(self: AnnotSquare): Color =
  fnew(result, gBoxedFreePopplerColor)
  result.impl = poppler_annot_square_get_interior_color(cast[ptr AnnotSquare00](self.impl))

proc poppler_annot_square_set_interior_color(self: ptr AnnotSquare00; popplerColor: ptr Color00) {.
    importc, libprag.}

proc setInteriorColor*(self: AnnotSquare; popplerColor: Color = nil) =
  poppler_annot_square_set_interior_color(cast[ptr AnnotSquare00](self.impl), if popplerColor.isNil: nil else: cast[ptr Color00](popplerColor.impl))

proc `interiorColor=`*(self: AnnotSquare; popplerColor: Color = nil) =
  poppler_annot_square_set_interior_color(cast[ptr AnnotSquare00](self.impl), if popplerColor.isNil: nil else: cast[ptr Color00](popplerColor.impl))

type
  AnnotStamp* = ref object of Annot
  AnnotStamp00* = object of Annot00

proc poppler_annot_stamp_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotStamp()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_stamp_new(doc: ptr Document00; rect: ptr Rectangle00): ptr AnnotStamp00 {.
    importc, libprag.}

proc newAnnotStamp*(doc: Document; rect: Rectangle): AnnotStamp =
  let gobj = poppler_annot_stamp_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAnnotStamp*(tdesc: typedesc; doc: Document; rect: Rectangle): tdesc =
  assert(result is AnnotStamp)
  let gobj = poppler_annot_stamp_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAnnotStamp*[T](result: var T; doc: Document; rect: Rectangle) {.deprecated.} =
  assert(result is AnnotStamp)
  let gobj = poppler_annot_stamp_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_annot_stamp_set_custom_image(self: ptr AnnotStamp00; image: ptr cairo.Surface00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setCustomImage*(self: AnnotStamp; image: cairo.Surface): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_annot_stamp_set_custom_image(cast[ptr AnnotStamp00](self.impl), cast[ptr cairo.Surface00](image.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  AnnotStampIcon* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    approved = 1
    asIs = 2
    confidential = 3
    final = 4
    experimental = 5
    expired = 6
    notApproved = 7
    notForPublicRelease = 8
    sold = 9
    departmental = 10
    forComment = 11
    forPublicRelease = 12
    topSecret = 13
    none = 14

proc poppler_annot_stamp_get_icon(self: ptr AnnotStamp00): AnnotStampIcon {.
    importc, libprag.}

proc getIcon*(self: AnnotStamp): AnnotStampIcon =
  poppler_annot_stamp_get_icon(cast[ptr AnnotStamp00](self.impl))

proc icon*(self: AnnotStamp): AnnotStampIcon =
  poppler_annot_stamp_get_icon(cast[ptr AnnotStamp00](self.impl))

proc poppler_annot_stamp_set_icon(self: ptr AnnotStamp00; icon: AnnotStampIcon) {.
    importc, libprag.}

proc setIcon*(self: AnnotStamp; icon: AnnotStampIcon) =
  poppler_annot_stamp_set_icon(cast[ptr AnnotStamp00](self.impl), icon)

proc `icon=`*(self: AnnotStamp; icon: AnnotStampIcon) =
  poppler_annot_stamp_set_icon(cast[ptr AnnotStamp00](self.impl), icon)

type
  AnnotText* = ref object of AnnotMarkup
  AnnotText00* = object of AnnotMarkup00

proc poppler_annot_text_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotText()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_text_new(doc: ptr Document00; rect: ptr Rectangle00): ptr AnnotText00 {.
    importc, libprag.}

proc newAnnotText*(doc: Document; rect: Rectangle): AnnotText =
  let gobj = poppler_annot_text_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAnnotText*(tdesc: typedesc; doc: Document; rect: Rectangle): tdesc =
  assert(result is AnnotText)
  let gobj = poppler_annot_text_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAnnotText*[T](result: var T; doc: Document; rect: Rectangle) {.deprecated.} =
  assert(result is AnnotText)
  let gobj = poppler_annot_text_new(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_annot_text_get_icon(self: ptr AnnotText00): cstring {.
    importc, libprag.}

proc getIcon*(self: AnnotText): string =
  let resul0 = poppler_annot_text_get_icon(cast[ptr AnnotText00](self.impl))
  result = $resul0
  cogfree(resul0)

proc icon*(self: AnnotText): string =
  let resul0 = poppler_annot_text_get_icon(cast[ptr AnnotText00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_annot_text_get_is_open(self: ptr AnnotText00): gboolean {.
    importc, libprag.}

proc getIsOpen*(self: AnnotText): bool =
  toBool(poppler_annot_text_get_is_open(cast[ptr AnnotText00](self.impl)))

proc isOpen*(self: AnnotText): bool =
  toBool(poppler_annot_text_get_is_open(cast[ptr AnnotText00](self.impl)))

proc poppler_annot_text_set_icon(self: ptr AnnotText00; icon: cstring) {.
    importc, libprag.}

proc setIcon*(self: AnnotText; icon: cstring) =
  poppler_annot_text_set_icon(cast[ptr AnnotText00](self.impl), icon)

proc `icon=`*(self: AnnotText; icon: cstring) =
  poppler_annot_text_set_icon(cast[ptr AnnotText00](self.impl), icon)

proc poppler_annot_text_set_is_open(self: ptr AnnotText00; isOpen: gboolean) {.
    importc, libprag.}

proc setIsOpen*(self: AnnotText; isOpen: bool = true) =
  poppler_annot_text_set_is_open(cast[ptr AnnotText00](self.impl), gboolean(isOpen))

proc `isOpen=`*(self: AnnotText; isOpen: bool) =
  poppler_annot_text_set_is_open(cast[ptr AnnotText00](self.impl), gboolean(isOpen))

type
  AnnotTextState* {.size: sizeof(cint), pure.} = enum
    marked = 0
    unmarked = 1
    accepted = 2
    rejected = 3
    cancelled = 4
    completed = 5
    none = 6
    unknown = 7

proc poppler_annot_text_get_state(self: ptr AnnotText00): AnnotTextState {.
    importc, libprag.}

proc getState*(self: AnnotText): AnnotTextState =
  poppler_annot_text_get_state(cast[ptr AnnotText00](self.impl))

proc state*(self: AnnotText): AnnotTextState =
  poppler_annot_text_get_state(cast[ptr AnnotText00](self.impl))

type
  AnnotTextMarkup* = ref object of AnnotMarkup
  AnnotTextMarkup00* = object of AnnotMarkup00

proc poppler_annot_text_markup_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AnnotTextMarkup()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_annot_text_markup_new_highlight(doc: ptr Document00; rect: ptr Rectangle00;
    quadrilaterals: ptr GArray00): ptr AnnotTextMarkup00 {.
    importc, libprag.}

proc newAnnotTextMarkupHighlight*(doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00): AnnotTextMarkup =
  let gobj = poppler_annot_text_markup_new_highlight(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAnnotTextMarkupHighlight*(tdesc: typedesc; doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00): tdesc =
  assert(result is AnnotTextMarkup)
  let gobj = poppler_annot_text_markup_new_highlight(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAnnotTextMarkupHighlight*[T](result: var T; doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00) {.deprecated.} =
  assert(result is AnnotTextMarkup)
  let gobj = poppler_annot_text_markup_new_highlight(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_annot_text_markup_new_squiggly(doc: ptr Document00; rect: ptr Rectangle00;
    quadrilaterals: ptr GArray00): ptr AnnotTextMarkup00 {.
    importc, libprag.}

proc newAnnotTextMarkupSquiggly*(doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00): AnnotTextMarkup =
  let gobj = poppler_annot_text_markup_new_squiggly(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAnnotTextMarkupSquiggly*(tdesc: typedesc; doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00): tdesc =
  assert(result is AnnotTextMarkup)
  let gobj = poppler_annot_text_markup_new_squiggly(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAnnotTextMarkupSquiggly*[T](result: var T; doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00) {.deprecated.} =
  assert(result is AnnotTextMarkup)
  let gobj = poppler_annot_text_markup_new_squiggly(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_annot_text_markup_new_strikeout(doc: ptr Document00; rect: ptr Rectangle00;
    quadrilaterals: ptr GArray00): ptr AnnotTextMarkup00 {.
    importc, libprag.}

proc newAnnotTextMarkupStrikeout*(doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00): AnnotTextMarkup =
  let gobj = poppler_annot_text_markup_new_strikeout(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAnnotTextMarkupStrikeout*(tdesc: typedesc; doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00): tdesc =
  assert(result is AnnotTextMarkup)
  let gobj = poppler_annot_text_markup_new_strikeout(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAnnotTextMarkupStrikeout*[T](result: var T; doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00) {.deprecated.} =
  assert(result is AnnotTextMarkup)
  let gobj = poppler_annot_text_markup_new_strikeout(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_annot_text_markup_new_underline(doc: ptr Document00; rect: ptr Rectangle00;
    quadrilaterals: ptr GArray00): ptr AnnotTextMarkup00 {.
    importc, libprag.}

proc newAnnotTextMarkupUnderline*(doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00): AnnotTextMarkup =
  let gobj = poppler_annot_text_markup_new_underline(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAnnotTextMarkupUnderline*(tdesc: typedesc; doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00): tdesc =
  assert(result is AnnotTextMarkup)
  let gobj = poppler_annot_text_markup_new_underline(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAnnotTextMarkupUnderline*[T](result: var T; doc: Document; rect: Rectangle;
    quadrilaterals: ptr GArray00) {.deprecated.} =
  assert(result is AnnotTextMarkup)
  let gobj = poppler_annot_text_markup_new_underline(cast[ptr Document00](doc.impl), cast[ptr Rectangle00](rect.impl), quadrilaterals)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_annot_text_markup_get_quadrilaterals(self: ptr AnnotTextMarkup00): ptr GArray00 {.
    importc, libprag.}

proc getQuadrilaterals*(self: AnnotTextMarkup): ptr GArray00 =
  poppler_annot_text_markup_get_quadrilaterals(cast[ptr AnnotTextMarkup00](self.impl))

proc quadrilaterals*(self: AnnotTextMarkup): ptr GArray00 =
  poppler_annot_text_markup_get_quadrilaterals(cast[ptr AnnotTextMarkup00](self.impl))

proc poppler_annot_text_markup_set_quadrilaterals(self: ptr AnnotTextMarkup00;
    quadrilaterals: ptr GArray00) {.
    importc, libprag.}

proc setQuadrilaterals*(self: AnnotTextMarkup;
    quadrilaterals: ptr GArray00) =
  poppler_annot_text_markup_set_quadrilaterals(cast[ptr AnnotTextMarkup00](self.impl), quadrilaterals)

proc `quadrilaterals=`*(self: AnnotTextMarkup;
    quadrilaterals: ptr GArray00) =
  poppler_annot_text_markup_set_quadrilaterals(cast[ptr AnnotTextMarkup00](self.impl), quadrilaterals)

type
  AttachmentSaveFunc* = proc (buf: ptr uint8; count: uint64; data: pointer; error: ptr ptr glib.Error = nil): gboolean {.cdecl.}

proc poppler_attachment_save_to_callback(self: ptr Attachment00; saveFunc: AttachmentSaveFunc;
    userData: pointer; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToCallback*(self: Attachment; saveFunc: AttachmentSaveFunc;
    userData: pointer): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_attachment_save_to_callback(cast[ptr Attachment00](self.impl), saveFunc, userData, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  Backend* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    splash = 1
    ct = 2

type
  DestType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    xyz = 1
    fit = 2
    fith = 3
    fitv = 4
    fitr = 5
    fitb = 6
    fitbh = 7
    fitbv = 8
    named = 9

type
  Error* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    encrypted = 1
    openFile = 2
    badCatalog = 3
    damaged = 4
    signing = 5

type
  FontInfo* = ref object of gobject.Object
  FontInfo00* = object of gobject.Object00

proc poppler_font_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_font_info_new(document: ptr Document00): ptr FontInfo00 {.
    importc, libprag.}

proc newFontInfo*(document: Document): FontInfo =
  let gobj = poppler_font_info_new(cast[ptr Document00](document.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFontInfo*(tdesc: typedesc; document: Document): tdesc =
  assert(result is FontInfo)
  let gobj = poppler_font_info_new(cast[ptr Document00](document.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFontInfo*[T](result: var T; document: Document) {.deprecated.} =
  assert(result is FontInfo)
  let gobj = poppler_font_info_new(cast[ptr Document00](document.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_font_info_free(self: ptr FontInfo00) {.
    importc, libprag.}

proc free*(self: FontInfo) =
  poppler_font_info_free(cast[ptr FontInfo00](self.impl))

type
  FontsIter00* {.pure.} = object
  FontsIter* = ref object
    impl*: ptr FontsIter00
    ignoreFinalizer*: bool

proc poppler_fonts_iter_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerFontsIter*(self: FontsIter) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_fonts_iter_get_type(), cast[ptr FontsIter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontsIter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_fonts_iter_get_type(), cast[ptr FontsIter00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var FontsIter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerFontsIter)

proc poppler_fonts_iter_free(self: ptr FontsIter00) {.
    importc, libprag.}

proc free*(self: FontsIter) =
  poppler_fonts_iter_free(cast[ptr FontsIter00](self.impl))

proc finalizerfree*(self: FontsIter) =
  if not self.ignoreFinalizer:
    poppler_fonts_iter_free(cast[ptr FontsIter00](self.impl))

proc poppler_fonts_iter_copy(self: ptr FontsIter00): ptr FontsIter00 {.
    importc, libprag.}

proc copy*(self: FontsIter): FontsIter =
  fnew(result, gBoxedFreePopplerFontsIter)
  result.impl = poppler_fonts_iter_copy(cast[ptr FontsIter00](self.impl))

proc poppler_fonts_iter_get_encoding(self: ptr FontsIter00): cstring {.
    importc, libprag.}

proc getEncoding*(self: FontsIter): string =
  result = $poppler_fonts_iter_get_encoding(cast[ptr FontsIter00](self.impl))

proc encoding*(self: FontsIter): string =
  result = $poppler_fonts_iter_get_encoding(cast[ptr FontsIter00](self.impl))

proc poppler_fonts_iter_get_file_name(self: ptr FontsIter00): cstring {.
    importc, libprag.}

proc getFileName*(self: FontsIter): string =
  result = $poppler_fonts_iter_get_file_name(cast[ptr FontsIter00](self.impl))

proc fileName*(self: FontsIter): string =
  result = $poppler_fonts_iter_get_file_name(cast[ptr FontsIter00](self.impl))

proc poppler_fonts_iter_get_full_name(self: ptr FontsIter00): cstring {.
    importc, libprag.}

proc getFullName*(self: FontsIter): string =
  result = $poppler_fonts_iter_get_full_name(cast[ptr FontsIter00](self.impl))

proc fullName*(self: FontsIter): string =
  result = $poppler_fonts_iter_get_full_name(cast[ptr FontsIter00](self.impl))

proc poppler_fonts_iter_get_name(self: ptr FontsIter00): cstring {.
    importc, libprag.}

proc getName*(self: FontsIter): string =
  result = $poppler_fonts_iter_get_name(cast[ptr FontsIter00](self.impl))

proc name*(self: FontsIter): string =
  result = $poppler_fonts_iter_get_name(cast[ptr FontsIter00](self.impl))

proc poppler_fonts_iter_get_substitute_name(self: ptr FontsIter00): cstring {.
    importc, libprag.}

proc getSubstituteName*(self: FontsIter): string =
  result = $poppler_fonts_iter_get_substitute_name(cast[ptr FontsIter00](self.impl))

proc substituteName*(self: FontsIter): string =
  result = $poppler_fonts_iter_get_substitute_name(cast[ptr FontsIter00](self.impl))

proc poppler_fonts_iter_is_embedded(self: ptr FontsIter00): gboolean {.
    importc, libprag.}

proc isEmbedded*(self: FontsIter): bool =
  toBool(poppler_fonts_iter_is_embedded(cast[ptr FontsIter00](self.impl)))

proc poppler_fonts_iter_is_subset(self: ptr FontsIter00): gboolean {.
    importc, libprag.}

proc isSubset*(self: FontsIter): bool =
  toBool(poppler_fonts_iter_is_subset(cast[ptr FontsIter00](self.impl)))

proc poppler_fonts_iter_next(self: ptr FontsIter00): gboolean {.
    importc, libprag.}

proc next*(self: FontsIter): bool =
  toBool(poppler_fonts_iter_next(cast[ptr FontsIter00](self.impl)))

proc poppler_font_info_scan(self: ptr FontInfo00; nPages: int32; iter: var ptr FontsIter00): gboolean {.
    importc, libprag.}

proc scan*(self: FontInfo; nPages: int; iter: var FontsIter): bool =
  fnew(iter, gBoxedFreePopplerFontsIter)
  toBool(poppler_font_info_scan(cast[ptr FontInfo00](self.impl), int32(nPages), cast[var ptr FontsIter00](addr iter.impl)))

type
  FontType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    type1 = 1
    type1c = 2
    type1cot = 3
    type3 = 4
    truetype = 5
    truetypeot = 6
    cidType0 = 7
    cidType0c = 8
    cidType0cot = 9
    cidType2 = 10
    cidType2ot = 11

proc poppler_fonts_iter_get_font_type(self: ptr FontsIter00): FontType {.
    importc, libprag.}

proc getFontType*(self: FontsIter): FontType =
  poppler_fonts_iter_get_font_type(cast[ptr FontsIter00](self.impl))

proc fontType*(self: FontsIter): FontType =
  poppler_fonts_iter_get_font_type(cast[ptr FontsIter00](self.impl))

const HAS_CAIRO* = 1'i32

type
  IndexIter00* {.pure.} = object
  IndexIter* = ref object
    impl*: ptr IndexIter00
    ignoreFinalizer*: bool

proc poppler_index_iter_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerIndexIter*(self: IndexIter) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_index_iter_get_type(), cast[ptr IndexIter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(IndexIter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_index_iter_get_type(), cast[ptr IndexIter00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var IndexIter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerIndexIter)

proc poppler_index_iter_free(self: ptr IndexIter00) {.
    importc, libprag.}

proc free*(self: IndexIter) =
  poppler_index_iter_free(cast[ptr IndexIter00](self.impl))

proc finalizerfree*(self: IndexIter) =
  if not self.ignoreFinalizer:
    poppler_index_iter_free(cast[ptr IndexIter00](self.impl))

proc poppler_index_iter_copy(self: ptr IndexIter00): ptr IndexIter00 {.
    importc, libprag.}

proc copy*(self: IndexIter): IndexIter =
  fnew(result, gBoxedFreePopplerIndexIter)
  result.impl = poppler_index_iter_copy(cast[ptr IndexIter00](self.impl))

proc poppler_index_iter_new(document: ptr Document00): ptr IndexIter00 {.
    importc, libprag.}

proc newIndexIter*(document: Document): IndexIter =
  fnew(result, gBoxedFreePopplerIndexIter)
  result.impl = poppler_index_iter_new(cast[ptr Document00](document.impl))

proc newIndexIter*(tdesc: typedesc; document: Document): tdesc =
  assert(result is IndexIter)
  fnew(result, gBoxedFreePopplerIndexIter)
  result.impl = poppler_index_iter_new(cast[ptr Document00](document.impl))

proc initIndexIter*[T](result: var T; document: Document) {.deprecated.} =
  assert(result is IndexIter)
  fnew(result, gBoxedFreePopplerIndexIter)
  result.impl = poppler_index_iter_new(cast[ptr Document00](document.impl))

proc poppler_index_iter_get_action(self: ptr IndexIter00): ptr Action00 {.
    importc, libprag.}

proc getAction*(self: IndexIter): Action =
  fnew(result, gBoxedFreePopplerAction)
  result.impl = poppler_index_iter_get_action(cast[ptr IndexIter00](self.impl))

proc action*(self: IndexIter): Action =
  fnew(result, gBoxedFreePopplerAction)
  result.impl = poppler_index_iter_get_action(cast[ptr IndexIter00](self.impl))

proc poppler_index_iter_get_child(self: ptr IndexIter00): ptr IndexIter00 {.
    importc, libprag.}

proc getChild*(self: IndexIter): IndexIter =
  fnew(result, gBoxedFreePopplerIndexIter)
  result.impl = poppler_index_iter_get_child(cast[ptr IndexIter00](self.impl))

proc child*(self: IndexIter): IndexIter =
  fnew(result, gBoxedFreePopplerIndexIter)
  result.impl = poppler_index_iter_get_child(cast[ptr IndexIter00](self.impl))

proc poppler_index_iter_is_open(self: ptr IndexIter00): gboolean {.
    importc, libprag.}

proc isOpen*(self: IndexIter): bool =
  toBool(poppler_index_iter_is_open(cast[ptr IndexIter00](self.impl)))

proc poppler_index_iter_next(self: ptr IndexIter00): gboolean {.
    importc, libprag.}

proc next*(self: IndexIter): bool =
  toBool(poppler_index_iter_next(cast[ptr IndexIter00](self.impl)))

type
  Layer* = ref object of gobject.Object
  Layer00* = object of gobject.Object00

proc poppler_layer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Layer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_layer_get_radio_button_group_id(self: ptr Layer00): int32 {.
    importc, libprag.}

proc getRadioButtonGroupId*(self: Layer): int =
  int(poppler_layer_get_radio_button_group_id(cast[ptr Layer00](self.impl)))

proc radioButtonGroupId*(self: Layer): int =
  int(poppler_layer_get_radio_button_group_id(cast[ptr Layer00](self.impl)))

proc poppler_layer_get_title(self: ptr Layer00): cstring {.
    importc, libprag.}

proc getTitle*(self: Layer): string =
  result = $poppler_layer_get_title(cast[ptr Layer00](self.impl))

proc title*(self: Layer): string =
  result = $poppler_layer_get_title(cast[ptr Layer00](self.impl))

proc poppler_layer_hide(self: ptr Layer00) {.
    importc, libprag.}

proc hide*(self: Layer) =
  poppler_layer_hide(cast[ptr Layer00](self.impl))

proc poppler_layer_is_parent(self: ptr Layer00): gboolean {.
    importc, libprag.}

proc isParent*(self: Layer): bool =
  toBool(poppler_layer_is_parent(cast[ptr Layer00](self.impl)))

proc poppler_layer_is_visible(self: ptr Layer00): gboolean {.
    importc, libprag.}

proc isVisible*(self: Layer): bool =
  toBool(poppler_layer_is_visible(cast[ptr Layer00](self.impl)))

proc poppler_layer_show(self: ptr Layer00) {.
    importc, libprag.}

proc show*(self: Layer) =
  poppler_layer_show(cast[ptr Layer00](self.impl))

type
  LayersIter00* {.pure.} = object
  LayersIter* = ref object
    impl*: ptr LayersIter00
    ignoreFinalizer*: bool

proc poppler_layers_iter_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerLayersIter*(self: LayersIter) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_layers_iter_get_type(), cast[ptr LayersIter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LayersIter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_layers_iter_get_type(), cast[ptr LayersIter00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var LayersIter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerLayersIter)

proc poppler_layers_iter_free(self: ptr LayersIter00) {.
    importc, libprag.}

proc free*(self: LayersIter) =
  poppler_layers_iter_free(cast[ptr LayersIter00](self.impl))

proc finalizerfree*(self: LayersIter) =
  if not self.ignoreFinalizer:
    poppler_layers_iter_free(cast[ptr LayersIter00](self.impl))

proc poppler_layers_iter_copy(self: ptr LayersIter00): ptr LayersIter00 {.
    importc, libprag.}

proc copy*(self: LayersIter): LayersIter =
  fnew(result, gBoxedFreePopplerLayersIter)
  result.impl = poppler_layers_iter_copy(cast[ptr LayersIter00](self.impl))

proc poppler_layers_iter_new(document: ptr Document00): ptr LayersIter00 {.
    importc, libprag.}

proc newLayersIter*(document: Document): LayersIter =
  fnew(result, gBoxedFreePopplerLayersIter)
  result.impl = poppler_layers_iter_new(cast[ptr Document00](document.impl))

proc newLayersIter*(tdesc: typedesc; document: Document): tdesc =
  assert(result is LayersIter)
  fnew(result, gBoxedFreePopplerLayersIter)
  result.impl = poppler_layers_iter_new(cast[ptr Document00](document.impl))

proc initLayersIter*[T](result: var T; document: Document) {.deprecated.} =
  assert(result is LayersIter)
  fnew(result, gBoxedFreePopplerLayersIter)
  result.impl = poppler_layers_iter_new(cast[ptr Document00](document.impl))

proc poppler_layers_iter_get_child(self: ptr LayersIter00): ptr LayersIter00 {.
    importc, libprag.}

proc getChild*(self: LayersIter): LayersIter =
  fnew(result, gBoxedFreePopplerLayersIter)
  result.impl = poppler_layers_iter_get_child(cast[ptr LayersIter00](self.impl))

proc child*(self: LayersIter): LayersIter =
  fnew(result, gBoxedFreePopplerLayersIter)
  result.impl = poppler_layers_iter_get_child(cast[ptr LayersIter00](self.impl))

proc poppler_layers_iter_get_layer(self: ptr LayersIter00): ptr Layer00 {.
    importc, libprag.}

proc getLayer*(self: LayersIter): Layer =
  let gobj = poppler_layers_iter_get_layer(cast[ptr LayersIter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc layer*(self: LayersIter): Layer =
  let gobj = poppler_layers_iter_get_layer(cast[ptr LayersIter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_layers_iter_get_title(self: ptr LayersIter00): cstring {.
    importc, libprag.}

proc getTitle*(self: LayersIter): string =
  let resul0 = poppler_layers_iter_get_title(cast[ptr LayersIter00](self.impl))
  result = $resul0
  cogfree(resul0)

proc title*(self: LayersIter): string =
  let resul0 = poppler_layers_iter_get_title(cast[ptr LayersIter00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_layers_iter_next(self: ptr LayersIter00): gboolean {.
    importc, libprag.}

proc next*(self: LayersIter): bool =
  toBool(poppler_layers_iter_next(cast[ptr LayersIter00](self.impl)))

const MAJOR_VERSION* = 24'i32

const MICRO_VERSION* = 0'i32

const MINOR_VERSION* = 2'i32

type
  Media* = ref object of gobject.Object
  Media00* = object of gobject.Object00

proc poppler_media_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Media()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_media_get_auto_play(self: ptr Media00): gboolean {.
    importc, libprag.}

proc getAutoPlay*(self: Media): bool =
  toBool(poppler_media_get_auto_play(cast[ptr Media00](self.impl)))

proc autoPlay*(self: Media): bool =
  toBool(poppler_media_get_auto_play(cast[ptr Media00](self.impl)))

proc poppler_media_get_filename(self: ptr Media00): cstring {.
    importc, libprag.}

proc getFilename*(self: Media): string =
  result = $poppler_media_get_filename(cast[ptr Media00](self.impl))

proc filename*(self: Media): string =
  result = $poppler_media_get_filename(cast[ptr Media00](self.impl))

proc poppler_media_get_mime_type(self: ptr Media00): cstring {.
    importc, libprag.}

proc getMimeType*(self: Media): string =
  result = $poppler_media_get_mime_type(cast[ptr Media00](self.impl))

proc mimeType*(self: Media): string =
  result = $poppler_media_get_mime_type(cast[ptr Media00](self.impl))

proc poppler_media_get_repeat_count(self: ptr Media00): cfloat {.
    importc, libprag.}

proc getRepeatCount*(self: Media): cfloat =
  poppler_media_get_repeat_count(cast[ptr Media00](self.impl))

proc repeatCount*(self: Media): cfloat =
  poppler_media_get_repeat_count(cast[ptr Media00](self.impl))

proc poppler_media_get_show_controls(self: ptr Media00): gboolean {.
    importc, libprag.}

proc getShowControls*(self: Media): bool =
  toBool(poppler_media_get_show_controls(cast[ptr Media00](self.impl)))

proc showControls*(self: Media): bool =
  toBool(poppler_media_get_show_controls(cast[ptr Media00](self.impl)))

proc poppler_media_is_embedded(self: ptr Media00): gboolean {.
    importc, libprag.}

proc isEmbedded*(self: Media): bool =
  toBool(poppler_media_is_embedded(cast[ptr Media00](self.impl)))

proc poppler_media_save(self: ptr Media00; filename: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc save*(self: Media; filename: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_media_save(cast[ptr Media00](self.impl), filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc poppler_media_save_to_fd(self: ptr Media00; fd: int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToFd*(self: Media; fd: int): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_media_save_to_fd(cast[ptr Media00](self.impl), int32(fd), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  MediaSaveFunc* = proc (buf: ptr uint8; count: uint64; data: pointer; error: ptr ptr glib.Error = nil): gboolean {.cdecl.}

proc poppler_media_save_to_callback(self: ptr Media00; saveFunc: MediaSaveFunc;
    userData: pointer; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToCallback*(self: Media; saveFunc: MediaSaveFunc;
    userData: pointer): bool =
  var gerror: ptr glib.Error
  let resul0 = poppler_media_save_to_callback(cast[ptr Media00](self.impl), saveFunc, userData, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  NssPasswordFunc* = proc (text: cstring): cstring {.cdecl.}

type
  PageTransitionAlignment* {.size: sizeof(cint), pure.} = enum
    horizontal = 0
    vertical = 1

type
  PageTransitionDirection* {.size: sizeof(cint), pure.} = enum
    inward = 0
    outward = 1

type
  PageTransitionType* {.size: sizeof(cint), pure.} = enum
    replace = 0
    split = 1
    blinds = 2
    box = 3
    wipe = 4
    dissolve = 5
    glitter = 6
    fly = 7
    push = 8
    cover = 9
    uncover = 10
    fade = 11

type
  Quadrilateral00* {.pure.} = object
  Quadrilateral* = ref object
    impl*: ptr Quadrilateral00
    ignoreFinalizer*: bool

proc poppler_quadrilateral_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerQuadrilateral*(self: Quadrilateral) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_quadrilateral_get_type(), cast[ptr Quadrilateral00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Quadrilateral()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_quadrilateral_get_type(), cast[ptr Quadrilateral00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Quadrilateral) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerQuadrilateral)

proc poppler_quadrilateral_free(self: ptr Quadrilateral00) {.
    importc, libprag.}

proc free*(self: Quadrilateral) =
  poppler_quadrilateral_free(cast[ptr Quadrilateral00](self.impl))

proc finalizerfree*(self: Quadrilateral) =
  if not self.ignoreFinalizer:
    poppler_quadrilateral_free(cast[ptr Quadrilateral00](self.impl))

proc poppler_quadrilateral_copy(self: ptr Quadrilateral00): ptr Quadrilateral00 {.
    importc, libprag.}

proc copy*(self: Quadrilateral): Quadrilateral =
  fnew(result, gBoxedFreePopplerQuadrilateral)
  result.impl = poppler_quadrilateral_copy(cast[ptr Quadrilateral00](self.impl))

proc poppler_quadrilateral_new(): ptr Quadrilateral00 {.
    importc, libprag.}

proc newQuadrilateral*(): Quadrilateral =
  fnew(result, gBoxedFreePopplerQuadrilateral)
  result.impl = poppler_quadrilateral_new()

proc newQuadrilateral*(tdesc: typedesc): tdesc =
  assert(result is Quadrilateral)
  fnew(result, gBoxedFreePopplerQuadrilateral)
  result.impl = poppler_quadrilateral_new()

proc initQuadrilateral*[T](result: var T) {.deprecated.} =
  assert(result is Quadrilateral)
  fnew(result, gBoxedFreePopplerQuadrilateral)
  result.impl = poppler_quadrilateral_new()

type
  StructureBlockAlign* {.size: sizeof(cint), pure.} = enum
    before = 0
    middle = 1
    after = 2
    justify = 3

type
  StructureBorderStyle* {.size: sizeof(cint), pure.} = enum
    none = 0
    hidden = 1
    dotted = 2
    dashed = 3
    solid = 4
    double = 5
    groove = 6
    inset = 7
    outset = 8

type
  StructureElement* = ref object of gobject.Object
  StructureElement00* = object of gobject.Object00

proc poppler_structure_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StructureElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc poppler_structure_element_get_abbreviation(self: ptr StructureElement00): cstring {.
    importc, libprag.}

proc getAbbreviation*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_abbreviation(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc abbreviation*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_abbreviation(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_structure_element_get_actual_text(self: ptr StructureElement00): cstring {.
    importc, libprag.}

proc getActualText*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_actual_text(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc actualText*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_actual_text(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_structure_element_get_alt_text(self: ptr StructureElement00): cstring {.
    importc, libprag.}

proc getAltText*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_alt_text(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc altText*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_alt_text(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_structure_element_get_background_color(self: ptr StructureElement00;
    color: var Color00): gboolean {.
    importc, libprag.}

proc getBackgroundColor*(self: StructureElement;
    color: var Color00): bool =
  toBool(poppler_structure_element_get_background_color(cast[ptr StructureElement00](self.impl), color))

proc poppler_structure_element_get_baseline_shift(self: ptr StructureElement00): cdouble {.
    importc, libprag.}

proc getBaselineShift*(self: StructureElement): cdouble =
  poppler_structure_element_get_baseline_shift(cast[ptr StructureElement00](self.impl))

proc baselineShift*(self: StructureElement): cdouble =
  poppler_structure_element_get_baseline_shift(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_get_block_align(self: ptr StructureElement00): StructureBlockAlign {.
    importc, libprag.}

proc getBlockAlign*(self: StructureElement): StructureBlockAlign =
  poppler_structure_element_get_block_align(cast[ptr StructureElement00](self.impl))

proc blockAlign*(self: StructureElement): StructureBlockAlign =
  poppler_structure_element_get_block_align(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_get_border_color(self: ptr StructureElement00;
    colors: var ptr array[4, Color00]): gboolean {.
    importc, libprag.}

proc getBorderColor*(self: StructureElement; colors: var ptr array[4, Color00]): bool =
  toBool(poppler_structure_element_get_border_color(cast[ptr StructureElement00](self.impl), colors))

proc poppler_structure_element_get_border_style(self: ptr StructureElement00;
    borderStyles: var ptr array[4, StructureBorderStyle]) {.
    importc, libprag.}

proc getBorderStyle*(self: StructureElement; borderStyles: var ptr array[4, StructureBorderStyle]) =
  poppler_structure_element_get_border_style(cast[ptr StructureElement00](self.impl), borderStyles)

proc getBorderStyle*(self: StructureElement): ptr array[4, StructureBorderStyle] =
  poppler_structure_element_get_border_style(cast[ptr StructureElement00](self.impl), result)

proc poppler_structure_element_get_border_thickness(self: ptr StructureElement00;
    borderThicknesses: var ptr array[4, cdouble]): gboolean {.
    importc, libprag.}

proc getBorderThickness*(self: StructureElement;
    borderThicknesses: var ptr array[4, cdouble]): bool =
  toBool(poppler_structure_element_get_border_thickness(cast[ptr StructureElement00](self.impl), borderThicknesses))

proc poppler_structure_element_get_bounding_box(self: ptr StructureElement00;
    boundingBox: var Rectangle00): gboolean {.
    importc, libprag.}

proc getBoundingBox*(self: StructureElement; boundingBox: var Rectangle00): bool =
  toBool(poppler_structure_element_get_bounding_box(cast[ptr StructureElement00](self.impl), boundingBox))

proc poppler_structure_element_get_color(self: ptr StructureElement00; color: var Color00): gboolean {.
    importc, libprag.}

proc getColor*(self: StructureElement; color: var Color00): bool =
  toBool(poppler_structure_element_get_color(cast[ptr StructureElement00](self.impl), color))

proc poppler_structure_element_get_column_count(self: ptr StructureElement00): uint32 {.
    importc, libprag.}

proc getColumnCount*(self: StructureElement): int =
  int(poppler_structure_element_get_column_count(cast[ptr StructureElement00](self.impl)))

proc columnCount*(self: StructureElement): int =
  int(poppler_structure_element_get_column_count(cast[ptr StructureElement00](self.impl)))

proc poppler_structure_element_get_column_gaps(self: ptr StructureElement00;
    nValues: var uint32): ptr cdouble {.
    importc, libprag.}

proc getColumnGaps*(self: StructureElement; nValues: var int): ptr cdouble =
  var nValues_00: uint32
  let resul0 = poppler_structure_element_get_column_gaps(cast[ptr StructureElement00](self.impl), nValues_00)
  result = resul0
  if nValues.addr != nil:
    nValues = int(nValues_00)

proc poppler_structure_element_get_column_widths(self: ptr StructureElement00;
    nValues: var uint32): ptr cdouble {.
    importc, libprag.}

proc getColumnWidths*(self: StructureElement;
    nValues: var int): ptr cdouble =
  var nValues_00: uint32
  let resul0 = poppler_structure_element_get_column_widths(cast[ptr StructureElement00](self.impl), nValues_00)
  result = resul0
  if nValues.addr != nil:
    nValues = int(nValues_00)

proc poppler_structure_element_get_end_indent(self: ptr StructureElement00): cdouble {.
    importc, libprag.}

proc getEndIndent*(self: StructureElement): cdouble =
  poppler_structure_element_get_end_indent(cast[ptr StructureElement00](self.impl))

proc endIndent*(self: StructureElement): cdouble =
  poppler_structure_element_get_end_indent(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_get_form_description(self: ptr StructureElement00): cstring {.
    importc, libprag.}

proc getFormDescription*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_form_description(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc formDescription*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_form_description(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_structure_element_get_height(self: ptr StructureElement00): cdouble {.
    importc, libprag.}

proc getHeight*(self: StructureElement): cdouble =
  poppler_structure_element_get_height(cast[ptr StructureElement00](self.impl))

proc height*(self: StructureElement): cdouble =
  poppler_structure_element_get_height(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_get_id(self: ptr StructureElement00): cstring {.
    importc, libprag.}

proc getId*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_id(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc id*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_id(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_structure_element_get_language(self: ptr StructureElement00): cstring {.
    importc, libprag.}

proc getLanguage*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_language(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc language*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_language(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_structure_element_get_line_height(self: ptr StructureElement00): cdouble {.
    importc, libprag.}

proc getLineHeight*(self: StructureElement): cdouble =
  poppler_structure_element_get_line_height(cast[ptr StructureElement00](self.impl))

proc lineHeight*(self: StructureElement): cdouble =
  poppler_structure_element_get_line_height(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_get_padding(self: ptr StructureElement00;
    paddings: var ptr array[4, cdouble]) {.
    importc, libprag.}

proc getPadding*(self: StructureElement; paddings: var ptr array[4, cdouble]) =
  poppler_structure_element_get_padding(cast[ptr StructureElement00](self.impl), paddings)

proc getPadding*(self: StructureElement): ptr array[4, cdouble] =
  poppler_structure_element_get_padding(cast[ptr StructureElement00](self.impl), result)

proc poppler_structure_element_get_page(self: ptr StructureElement00): int32 {.
    importc, libprag.}

proc getPage*(self: StructureElement): int =
  int(poppler_structure_element_get_page(cast[ptr StructureElement00](self.impl)))

proc page*(self: StructureElement): int =
  int(poppler_structure_element_get_page(cast[ptr StructureElement00](self.impl)))

proc poppler_structure_element_get_space_after(self: ptr StructureElement00): cdouble {.
    importc, libprag.}

proc getSpaceAfter*(self: StructureElement): cdouble =
  poppler_structure_element_get_space_after(cast[ptr StructureElement00](self.impl))

proc spaceAfter*(self: StructureElement): cdouble =
  poppler_structure_element_get_space_after(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_get_space_before(self: ptr StructureElement00): cdouble {.
    importc, libprag.}

proc getSpaceBefore*(self: StructureElement): cdouble =
  poppler_structure_element_get_space_before(cast[ptr StructureElement00](self.impl))

proc spaceBefore*(self: StructureElement): cdouble =
  poppler_structure_element_get_space_before(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_get_start_indent(self: ptr StructureElement00): cdouble {.
    importc, libprag.}

proc getStartIndent*(self: StructureElement): cdouble =
  poppler_structure_element_get_start_indent(cast[ptr StructureElement00](self.impl))

proc startIndent*(self: StructureElement): cdouble =
  poppler_structure_element_get_start_indent(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_get_table_border_style(self: ptr StructureElement00;
    borderStyles: var ptr array[4, StructureBorderStyle]) {.
    importc, libprag.}

proc getTableBorderStyle*(self: StructureElement;
    borderStyles: var ptr array[4, StructureBorderStyle]) =
  poppler_structure_element_get_table_border_style(cast[ptr StructureElement00](self.impl), borderStyles)

proc getTableBorderStyle*(self: StructureElement): ptr array[4, StructureBorderStyle] =
  poppler_structure_element_get_table_border_style(cast[ptr StructureElement00](self.impl), result)

proc poppler_structure_element_get_table_column_span(self: ptr StructureElement00): uint32 {.
    importc, libprag.}

proc getTableColumnSpan*(self: StructureElement): int =
  int(poppler_structure_element_get_table_column_span(cast[ptr StructureElement00](self.impl)))

proc tableColumnSpan*(self: StructureElement): int =
  int(poppler_structure_element_get_table_column_span(cast[ptr StructureElement00](self.impl)))

proc poppler_structure_element_get_table_headers(self: ptr StructureElement00): ptr cstring {.
    importc, libprag.}

proc getTableHeaders*(self: StructureElement): seq[string] =
  let resul0 = poppler_structure_element_get_table_headers(cast[ptr StructureElement00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc tableHeaders*(self: StructureElement): seq[string] =
  let resul0 = poppler_structure_element_get_table_headers(cast[ptr StructureElement00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc poppler_structure_element_get_table_padding(self: ptr StructureElement00;
    paddings: var ptr array[4, cdouble]) {.
    importc, libprag.}

proc getTablePadding*(self: StructureElement;
    paddings: var ptr array[4, cdouble]) =
  poppler_structure_element_get_table_padding(cast[ptr StructureElement00](self.impl), paddings)

proc getTablePadding*(self: StructureElement): ptr array[4, cdouble] =
  poppler_structure_element_get_table_padding(cast[ptr StructureElement00](self.impl), result)

proc poppler_structure_element_get_table_row_span(self: ptr StructureElement00): uint32 {.
    importc, libprag.}

proc getTableRowSpan*(self: StructureElement): int =
  int(poppler_structure_element_get_table_row_span(cast[ptr StructureElement00](self.impl)))

proc tableRowSpan*(self: StructureElement): int =
  int(poppler_structure_element_get_table_row_span(cast[ptr StructureElement00](self.impl)))

proc poppler_structure_element_get_table_summary(self: ptr StructureElement00): cstring {.
    importc, libprag.}

proc getTableSummary*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_table_summary(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc tableSummary*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_table_summary(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_structure_element_get_text_decoration_color(self: ptr StructureElement00;
    color: var Color00): gboolean {.
    importc, libprag.}

proc getTextDecorationColor*(self: StructureElement;
    color: var Color00): bool =
  toBool(poppler_structure_element_get_text_decoration_color(cast[ptr StructureElement00](self.impl), color))

proc poppler_structure_element_get_text_decoration_thickness(self: ptr StructureElement00): cdouble {.
    importc, libprag.}

proc getTextDecorationThickness*(self: StructureElement): cdouble =
  poppler_structure_element_get_text_decoration_thickness(cast[ptr StructureElement00](self.impl))

proc textDecorationThickness*(self: StructureElement): cdouble =
  poppler_structure_element_get_text_decoration_thickness(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_get_text_indent(self: ptr StructureElement00): cdouble {.
    importc, libprag.}

proc getTextIndent*(self: StructureElement): cdouble =
  poppler_structure_element_get_text_indent(cast[ptr StructureElement00](self.impl))

proc textIndent*(self: StructureElement): cdouble =
  poppler_structure_element_get_text_indent(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_get_title(self: ptr StructureElement00): cstring {.
    importc, libprag.}

proc getTitle*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_title(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc title*(self: StructureElement): string =
  let resul0 = poppler_structure_element_get_title(cast[ptr StructureElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc poppler_structure_element_get_width(self: ptr StructureElement00): cdouble {.
    importc, libprag.}

proc getWidth*(self: StructureElement): cdouble =
  poppler_structure_element_get_width(cast[ptr StructureElement00](self.impl))

proc width*(self: StructureElement): cdouble =
  poppler_structure_element_get_width(cast[ptr StructureElement00](self.impl))

proc poppler_structure_element_is_block(self: ptr StructureElement00): gboolean {.
    importc, libprag.}

proc isBlock*(self: StructureElement): bool =
  toBool(poppler_structure_element_is_block(cast[ptr StructureElement00](self.impl)))

proc poppler_structure_element_is_content(self: ptr StructureElement00): gboolean {.
    importc, libprag.}

proc isContent*(self: StructureElement): bool =
  toBool(poppler_structure_element_is_content(cast[ptr StructureElement00](self.impl)))

proc poppler_structure_element_is_grouping(self: ptr StructureElement00): gboolean {.
    importc, libprag.}

proc isGrouping*(self: StructureElement): bool =
  toBool(poppler_structure_element_is_grouping(cast[ptr StructureElement00](self.impl)))

proc poppler_structure_element_is_inline(self: ptr StructureElement00): gboolean {.
    importc, libprag.}

proc isInline*(self: StructureElement): bool =
  toBool(poppler_structure_element_is_inline(cast[ptr StructureElement00](self.impl)))

type
  StructureFormRole* {.size: sizeof(cint), pure.} = enum
    undefined = 0
    radioButton = 1
    pushButton = 2
    textValue = 3
    checkbox = 4

proc poppler_structure_element_get_form_role(self: ptr StructureElement00): StructureFormRole {.
    importc, libprag.}

proc getFormRole*(self: StructureElement): StructureFormRole =
  poppler_structure_element_get_form_role(cast[ptr StructureElement00](self.impl))

proc formRole*(self: StructureElement): StructureFormRole =
  poppler_structure_element_get_form_role(cast[ptr StructureElement00](self.impl))

type
  StructureFormState* {.size: sizeof(cint), pure.} = enum
    on = 0
    off = 1
    neutral = 2

proc poppler_structure_element_get_form_state(self: ptr StructureElement00): StructureFormState {.
    importc, libprag.}

proc getFormState*(self: StructureElement): StructureFormState =
  poppler_structure_element_get_form_state(cast[ptr StructureElement00](self.impl))

proc formState*(self: StructureElement): StructureFormState =
  poppler_structure_element_get_form_state(cast[ptr StructureElement00](self.impl))

type
  StructureGlyphOrientation* {.size: sizeof(cint), pure.} = enum
    auto = 0
    enum90 = 1
    enum180 = 2
    enum270 = 3

const
  StructureGlyphOrientationEnum0* = StructureGlyphOrientation.auto

proc poppler_structure_element_get_glyph_orientation(self: ptr StructureElement00): StructureGlyphOrientation {.
    importc, libprag.}

proc getGlyphOrientation*(self: StructureElement): StructureGlyphOrientation =
  poppler_structure_element_get_glyph_orientation(cast[ptr StructureElement00](self.impl))

proc glyphOrientation*(self: StructureElement): StructureGlyphOrientation =
  poppler_structure_element_get_glyph_orientation(cast[ptr StructureElement00](self.impl))

type
  StructureInlineAlign* {.size: sizeof(cint), pure.} = enum
    start = 0
    center = 1
    `end` = 2

proc poppler_structure_element_get_inline_align(self: ptr StructureElement00): StructureInlineAlign {.
    importc, libprag.}

proc getInlineAlign*(self: StructureElement): StructureInlineAlign =
  poppler_structure_element_get_inline_align(cast[ptr StructureElement00](self.impl))

proc inlineAlign*(self: StructureElement): StructureInlineAlign =
  poppler_structure_element_get_inline_align(cast[ptr StructureElement00](self.impl))

type
  StructureElementKind* {.size: sizeof(cint), pure.} = enum
    content = 0
    objectReference = 1
    document = 2
    part = 3
    article = 4
    section = 5
    `div` = 6
    span = 7
    quote = 8
    note = 9
    reference = 10
    bibentry = 11
    code = 12
    link = 13
    annot = 14
    blockquote = 15
    caption = 16
    nonstruct = 17
    toc = 18
    tocItem = 19
    index = 20
    private = 21
    paragraph = 22
    heading = 23
    heading_1 = 24
    heading_2 = 25
    heading_3 = 26
    heading_4 = 27
    heading_5 = 28
    heading_6 = 29
    list = 30
    listItem = 31
    listLabel = 32
    listBody = 33
    table = 34
    tableRow = 35
    tableHeading = 36
    tableData = 37
    tableHeader = 38
    tableFooter = 39
    tableBody = 40
    ruby = 41
    rubyBaseText = 42
    rubyAnnotText = 43
    rubyPunctuation = 44
    warichu = 45
    warichuText = 46
    warichuPunctuation = 47
    figure = 48
    formula = 49
    form = 50

proc poppler_structure_element_get_kind(self: ptr StructureElement00): StructureElementKind {.
    importc, libprag.}

proc getKind*(self: StructureElement): StructureElementKind =
  poppler_structure_element_get_kind(cast[ptr StructureElement00](self.impl))

proc kind*(self: StructureElement): StructureElementKind =
  poppler_structure_element_get_kind(cast[ptr StructureElement00](self.impl))

type
  StructureListNumbering* {.size: sizeof(cint), pure.} = enum
    none = 0
    disc = 1
    circle = 2
    square = 3
    decimal = 4
    upperRoman = 5
    lowerRoman = 6
    upperAlpha = 7
    lowerAlpha = 8

proc poppler_structure_element_get_list_numbering(self: ptr StructureElement00): StructureListNumbering {.
    importc, libprag.}

proc getListNumbering*(self: StructureElement): StructureListNumbering =
  poppler_structure_element_get_list_numbering(cast[ptr StructureElement00](self.impl))

proc listNumbering*(self: StructureElement): StructureListNumbering =
  poppler_structure_element_get_list_numbering(cast[ptr StructureElement00](self.impl))

type
  StructurePlacement* {.size: sizeof(cint), pure.} = enum
    `block` = 0
    inline = 1
    before = 2
    start = 3
    `end` = 4

proc poppler_structure_element_get_placement(self: ptr StructureElement00): StructurePlacement {.
    importc, libprag.}

proc getPlacement*(self: StructureElement): StructurePlacement =
  poppler_structure_element_get_placement(cast[ptr StructureElement00](self.impl))

proc placement*(self: StructureElement): StructurePlacement =
  poppler_structure_element_get_placement(cast[ptr StructureElement00](self.impl))

type
  StructureRubyAlign* {.size: sizeof(cint), pure.} = enum
    start = 0
    center = 1
    `end` = 2
    justify = 3
    distribute = 4

proc poppler_structure_element_get_ruby_align(self: ptr StructureElement00): StructureRubyAlign {.
    importc, libprag.}

proc getRubyAlign*(self: StructureElement): StructureRubyAlign =
  poppler_structure_element_get_ruby_align(cast[ptr StructureElement00](self.impl))

proc rubyAlign*(self: StructureElement): StructureRubyAlign =
  poppler_structure_element_get_ruby_align(cast[ptr StructureElement00](self.impl))

type
  StructureRubyPosition* {.size: sizeof(cint), pure.} = enum
    before = 0
    after = 1
    warichu = 2
    inline = 3

proc poppler_structure_element_get_ruby_position(self: ptr StructureElement00): StructureRubyPosition {.
    importc, libprag.}

proc getRubyPosition*(self: StructureElement): StructureRubyPosition =
  poppler_structure_element_get_ruby_position(cast[ptr StructureElement00](self.impl))

proc rubyPosition*(self: StructureElement): StructureRubyPosition =
  poppler_structure_element_get_ruby_position(cast[ptr StructureElement00](self.impl))

type
  StructureTableScope* {.size: sizeof(cint), pure.} = enum
    row = 0
    column = 1
    both = 2

proc poppler_structure_element_get_table_scope(self: ptr StructureElement00): StructureTableScope {.
    importc, libprag.}

proc getTableScope*(self: StructureElement): StructureTableScope =
  poppler_structure_element_get_table_scope(cast[ptr StructureElement00](self.impl))

proc tableScope*(self: StructureElement): StructureTableScope =
  poppler_structure_element_get_table_scope(cast[ptr StructureElement00](self.impl))

type
  StructureGetTextFlag* {.size: sizeof(cint), pure.} = enum
    recursive = 0

  StructureGetTextFlags* = set[StructureGetTextFlag]

const
  StructureGetTextFlagsNone* = StructureGetTextFlags({})
proc none*(t: typedesc[StructureGetTextFlags]): StructureGetTextFlags = StructureGetTextFlags({})

proc poppler_structure_element_get_text(self: ptr StructureElement00; flags: StructureGetTextFlags): cstring {.
    importc, libprag.}

proc getText*(self: StructureElement; flags: StructureGetTextFlags): string =
  let resul0 = poppler_structure_element_get_text(cast[ptr StructureElement00](self.impl), flags)
  result = $resul0
  cogfree(resul0)

type
  StructureTextAlign* {.size: sizeof(cint), pure.} = enum
    start = 0
    center = 1
    `end` = 2
    justify = 3

proc poppler_structure_element_get_text_align(self: ptr StructureElement00): StructureTextAlign {.
    importc, libprag.}

proc getTextAlign*(self: StructureElement): StructureTextAlign =
  poppler_structure_element_get_text_align(cast[ptr StructureElement00](self.impl))

proc textAlign*(self: StructureElement): StructureTextAlign =
  poppler_structure_element_get_text_align(cast[ptr StructureElement00](self.impl))

type
  StructureTextDecoration* {.size: sizeof(cint), pure.} = enum
    none = 0
    underline = 1
    overline = 2
    linethrough = 3

proc poppler_structure_element_get_text_decoration_type(self: ptr StructureElement00): StructureTextDecoration {.
    importc, libprag.}

proc getTextDecorationType*(self: StructureElement): StructureTextDecoration =
  poppler_structure_element_get_text_decoration_type(cast[ptr StructureElement00](self.impl))

proc textDecorationType*(self: StructureElement): StructureTextDecoration =
  poppler_structure_element_get_text_decoration_type(cast[ptr StructureElement00](self.impl))

type
  TextSpan00* {.pure.} = object
  TextSpan* = ref object
    impl*: ptr TextSpan00
    ignoreFinalizer*: bool

proc poppler_text_span_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerTextSpan*(self: TextSpan) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_text_span_get_type(), cast[ptr TextSpan00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TextSpan()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_text_span_get_type(), cast[ptr TextSpan00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var TextSpan) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerTextSpan)

proc poppler_text_span_free(self: ptr TextSpan00) {.
    importc, libprag.}

proc free*(self: TextSpan) =
  poppler_text_span_free(cast[ptr TextSpan00](self.impl))

proc finalizerfree*(self: TextSpan) =
  if not self.ignoreFinalizer:
    poppler_text_span_free(cast[ptr TextSpan00](self.impl))

proc poppler_text_span_copy(self: ptr TextSpan00): ptr TextSpan00 {.
    importc, libprag.}

proc copy*(self: TextSpan): TextSpan =
  fnew(result, gBoxedFreePopplerTextSpan)
  result.impl = poppler_text_span_copy(cast[ptr TextSpan00](self.impl))

proc poppler_text_span_get_color(self: ptr TextSpan00; color: var Color00) {.
    importc, libprag.}

proc getColor*(self: TextSpan; color: var Color00) =
  poppler_text_span_get_color(cast[ptr TextSpan00](self.impl), color)

proc getColor*(self: TextSpan): Color00 =
  poppler_text_span_get_color(cast[ptr TextSpan00](self.impl), result)

proc poppler_text_span_get_font_name(self: ptr TextSpan00): cstring {.
    importc, libprag.}

proc getFontName*(self: TextSpan): string =
  result = $poppler_text_span_get_font_name(cast[ptr TextSpan00](self.impl))

proc fontName*(self: TextSpan): string =
  result = $poppler_text_span_get_font_name(cast[ptr TextSpan00](self.impl))

proc poppler_text_span_get_text(self: ptr TextSpan00): cstring {.
    importc, libprag.}

proc getText*(self: TextSpan): string =
  result = $poppler_text_span_get_text(cast[ptr TextSpan00](self.impl))

proc text*(self: TextSpan): string =
  result = $poppler_text_span_get_text(cast[ptr TextSpan00](self.impl))

proc poppler_text_span_is_bold_font(self: ptr TextSpan00): gboolean {.
    importc, libprag.}

proc isBoldFont*(self: TextSpan): bool =
  toBool(poppler_text_span_is_bold_font(cast[ptr TextSpan00](self.impl)))

proc poppler_text_span_is_fixed_width_font(self: ptr TextSpan00): gboolean {.
    importc, libprag.}

proc isFixedWidthFont*(self: TextSpan): bool =
  toBool(poppler_text_span_is_fixed_width_font(cast[ptr TextSpan00](self.impl)))

proc poppler_text_span_is_serif_font(self: ptr TextSpan00): gboolean {.
    importc, libprag.}

proc isSerifFont*(self: TextSpan): bool =
  toBool(poppler_text_span_is_serif_font(cast[ptr TextSpan00](self.impl)))

proc poppler_structure_element_get_text_spans(self: ptr StructureElement00;
    nTextSpans: var uint32): ptr TextSpan00 {.
    importc, libprag.}

proc getTextSpans*(self: StructureElement; nTextSpans: var int): ptr TextSpan00 =
  var nTextSpans_00: uint32
  let resul0 = poppler_structure_element_get_text_spans(cast[ptr StructureElement00](self.impl), nTextSpans_00)
  result = resul0
  if nTextSpans.addr != nil:
    nTextSpans = int(nTextSpans_00)

type
  StructureWritingMode* {.size: sizeof(cint), pure.} = enum
    lrTb = 0
    rlTb = 1
    tbRl = 2

proc poppler_structure_element_get_writing_mode(self: ptr StructureElement00): StructureWritingMode {.
    importc, libprag.}

proc getWritingMode*(self: StructureElement): StructureWritingMode =
  poppler_structure_element_get_writing_mode(cast[ptr StructureElement00](self.impl))

proc writingMode*(self: StructureElement): StructureWritingMode =
  poppler_structure_element_get_writing_mode(cast[ptr StructureElement00](self.impl))

type
  StructureElementIter00* {.pure.} = object
  StructureElementIter* = ref object
    impl*: ptr StructureElementIter00
    ignoreFinalizer*: bool

proc poppler_structure_element_iter_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePopplerStructureElementIter*(self: StructureElementIter) =
  if not self.ignoreFinalizer:
    boxedFree(poppler_structure_element_iter_get_type(), cast[ptr StructureElementIter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StructureElementIter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(poppler_structure_element_iter_get_type(), cast[ptr StructureElementIter00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var StructureElementIter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePopplerStructureElementIter)

proc poppler_structure_element_iter_free(self: ptr StructureElementIter00) {.
    importc, libprag.}

proc free*(self: StructureElementIter) =
  poppler_structure_element_iter_free(cast[ptr StructureElementIter00](self.impl))

proc finalizerfree*(self: StructureElementIter) =
  if not self.ignoreFinalizer:
    poppler_structure_element_iter_free(cast[ptr StructureElementIter00](self.impl))

proc poppler_structure_element_iter_copy(self: ptr StructureElementIter00): ptr StructureElementIter00 {.
    importc, libprag.}

proc copy*(self: StructureElementIter): StructureElementIter =
  fnew(result, gBoxedFreePopplerStructureElementIter)
  result.impl = poppler_structure_element_iter_copy(cast[ptr StructureElementIter00](self.impl))

proc poppler_structure_element_iter_new(popplerDocument: ptr Document00): ptr StructureElementIter00 {.
    importc, libprag.}

proc newStructureElementIter*(popplerDocument: Document): StructureElementIter =
  fnew(result, gBoxedFreePopplerStructureElementIter)
  result.impl = poppler_structure_element_iter_new(cast[ptr Document00](popplerDocument.impl))

proc newStructureElementIter*(tdesc: typedesc; popplerDocument: Document): tdesc =
  assert(result is StructureElementIter)
  fnew(result, gBoxedFreePopplerStructureElementIter)
  result.impl = poppler_structure_element_iter_new(cast[ptr Document00](popplerDocument.impl))

proc initStructureElementIter*[T](result: var T; popplerDocument: Document) {.deprecated.} =
  assert(result is StructureElementIter)
  fnew(result, gBoxedFreePopplerStructureElementIter)
  result.impl = poppler_structure_element_iter_new(cast[ptr Document00](popplerDocument.impl))

proc poppler_structure_element_iter_get_child(self: ptr StructureElementIter00): ptr StructureElementIter00 {.
    importc, libprag.}

proc getChild*(self: StructureElementIter): StructureElementIter =
  fnew(result, gBoxedFreePopplerStructureElementIter)
  result.impl = poppler_structure_element_iter_get_child(cast[ptr StructureElementIter00](self.impl))

proc child*(self: StructureElementIter): StructureElementIter =
  fnew(result, gBoxedFreePopplerStructureElementIter)
  result.impl = poppler_structure_element_iter_get_child(cast[ptr StructureElementIter00](self.impl))

proc poppler_structure_element_iter_get_element(self: ptr StructureElementIter00): ptr StructureElement00 {.
    importc, libprag.}

proc getElement*(self: StructureElementIter): StructureElement =
  let gobj = poppler_structure_element_iter_get_element(cast[ptr StructureElementIter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc element*(self: StructureElementIter): StructureElement =
  let gobj = poppler_structure_element_iter_get_element(cast[ptr StructureElementIter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, poppler.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc poppler_structure_element_iter_next(self: ptr StructureElementIter00): gboolean {.
    importc, libprag.}

proc next*(self: StructureElementIter): bool =
  toBool(poppler_structure_element_iter_next(cast[ptr StructureElementIter00](self.impl)))

type
  ViewerPreferencesFlag* {.size: sizeof(cint), pure.} = enum
    hideToolbar = 0
    hideMenubar = 1
    hideWindowui = 2
    fitWindow = 3
    centerWindow = 4
    displayDocTitle = 5
    directionRtl = 6

  ViewerPreferences* = set[ViewerPreferencesFlag]

const
  ViewerPreferencesUnset* = ViewerPreferences({})
proc unset*(t: typedesc[ViewerPreferences]): ViewerPreferences = ViewerPreferences({})

proc poppler_date_parse(date: cstring; timet: ptr int64): gboolean {.
    importc, libprag.}

proc dateParse*(date: cstring; timet: ptr int64): bool =
  toBool(poppler_date_parse(date, timet))

proc poppler_get_available_signing_certificates(): ptr glib.List {.
    importc, libprag.}

proc getAvailableSigningCertificates*(): seq[CertificateInfo] =
  let resul0 = poppler_get_available_signing_certificates()
  result = glistStructs2seq[CertificateInfo](resul0, false)
  g_list_free(resul0)

proc getBackend*(): Backend {.
    importc: "poppler_get_backend", libprag.}

proc poppler_get_certificate_info_by_id(id: cstring): ptr CertificateInfo00 {.
    importc, libprag.}

proc getCertificateInfoById*(id: cstring): CertificateInfo =
  fnew(result, gBoxedFreePopplerCertificateInfo)
  result.impl = poppler_get_certificate_info_by_id(id)

proc certificateInfoById*(id: cstring): CertificateInfo =
  fnew(result, gBoxedFreePopplerCertificateInfo)
  result.impl = poppler_get_certificate_info_by_id(id)

proc poppler_get_nss_dir(): cstring {.
    importc, libprag.}

proc getNssDir*(): string =
  let resul0 = poppler_get_nss_dir()
  result = $resul0
  cogfree(resul0)

proc poppler_get_version(): cstring {.
    importc, libprag.}

proc getVersion*(): string =
  result = $poppler_get_version()

proc poppler_named_dest_from_bytestring(data: ptr uint8; length: uint64): cstring {.
    importc, libprag.}

proc namedDestFromBytestring*(data: seq[uint8] | string): string =
  let length = uint64(data.len)
  let resul0 = poppler_named_dest_from_bytestring(cast[ptr uint8](unsafeaddr(data[0])), length)
  result = $resul0
  cogfree(resul0)

proc poppler_named_dest_to_bytestring(name: cstring; length: var uint64): ptr uint8 {.
    importc, libprag.}

proc namedDestToBytestring*(name: cstring; length: var uint64): seq[uint8] =
  let resul0 = poppler_named_dest_to_bytestring(name, length)
  if resul0.isNil:
    return
  result = uint8ArrayToSeq(resul0, length.int)
  cogfree(resul0)

proc setNssDir*(path: cstring) {.
    importc: "poppler_set_nss_dir", libprag.}

proc setNssPasswordCallback*(`func`: NssPasswordFunc) {.
    importc: "poppler_set_nss_password_callback", libprag.}
# === remaining symbols:

proc x1*(r: Rectangle): float = r.impl.x1.float

proc y1*(r: Rectangle): float = r.impl.y1.float

proc x2*(r: Rectangle): float = r.impl.x2.float

proc y2*(r: Rectangle): float = r.impl.y2.float


proc area*(im: ImageMapping): Rectangle00 = im.impl.area

proc imageId*(im: ImageMapping): int = im.impl.imageId.int


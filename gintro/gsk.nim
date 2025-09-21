# dependencies:
# PangoCairo-1.0
# freetype2-2.0
# GLib-2.0
# GdkPixbuf-2.0
# HarfBuzz-0.0
# GModule-2.0
# cairo-1.0
# Graphene-1.0
# GObject-2.0
# Pango-1.0
# Gdk-4.0
# Gio-2.0
# immediate dependencies:
# Graphene-1.0
# Gdk-4.0
# libraries:
# libgtk-4.so.1
{.warning[UnusedImport]: off.}
import pangocairo, freetype2, glib, gdkpixbuf, harfbuzz, gmodule, cairo, graphene, gobject, pango, gdk4, gio
const Lib = "libgtk-4.so.1"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  BlendMode* {.size: sizeof(cint), pure.} = enum
    default = 0
    multiply = 1
    screen = 2
    overlay = 3
    darken = 4
    lighten = 5
    colorDodge = 6
    colorBurn = 7
    hardLight = 8
    softLight = 9
    difference = 10
    exclusion = 11
    color = 12
    hue = 13
    saturation = 14
    luminosity = 15

type
  RenderNode* = ref object of RootRef
    impl*: ptr RenderNode00
    ignoreFinalizer*: bool
  RenderNode00*{.inheritable, pure.} = object

proc gsk_render_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr RenderNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: RenderNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RenderNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_render_node_draw(self: ptr RenderNode00; cr: ptr cairo.Context00) {.
    importc, libprag.}

proc draw*(self: RenderNode; cr: cairo.Context) =
  gsk_render_node_draw(cast[ptr RenderNode00](self.impl), cast[ptr cairo.Context00](cr.impl))

proc gsk_render_node_get_bounds(self: ptr RenderNode00; bounds: var graphene.Rect) {.
    importc, libprag.}

proc getBounds*(self: RenderNode; bounds: var graphene.Rect) =
  gsk_render_node_get_bounds(cast[ptr RenderNode00](self.impl), bounds)

proc getBounds*(self: RenderNode): graphene.Rect =
  gsk_render_node_get_bounds(cast[ptr RenderNode00](self.impl), result)

proc gsk_render_node_ref(self: ptr RenderNode00): ptr RenderNode00 {.
    importc, libprag.}

proc `ref`*(self: RenderNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_render_node_ref(cast[ptr RenderNode00](self.impl))

proc gsk_render_node_serialize(self: ptr RenderNode00): ptr glib.Bytes00 {.
    importc, libprag.}

proc serialize*(self: RenderNode): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gsk_render_node_serialize(cast[ptr RenderNode00](self.impl))

proc gsk_render_node_write_to_file(self: ptr RenderNode00; filename: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc writeToFile*(self: RenderNode; filename: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = gsk_render_node_write_to_file(cast[ptr RenderNode00](self.impl), filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  BlendNode* = ref object of RenderNode
  BlendNode00* = object of RenderNode00

proc gsk_blend_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr BlendNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: BlendNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BlendNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_blend_node_new(bottom: ptr RenderNode00; top: ptr RenderNode00;
    blendMode: BlendMode): ptr BlendNode00 {.
    importc, libprag.}

proc newBlendNode*(bottom: RenderNode; top: RenderNode; blendMode: BlendMode): BlendNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blend_node_new(cast[ptr RenderNode00](bottom.impl), cast[ptr RenderNode00](top.impl), blendMode)

proc newBlendNode*(tdesc: typedesc; bottom: RenderNode; top: RenderNode; blendMode: BlendMode): tdesc =
  assert(result is BlendNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blend_node_new(cast[ptr RenderNode00](bottom.impl), cast[ptr RenderNode00](top.impl), blendMode)

proc initBlendNode*[T](result: var T; bottom: RenderNode; top: RenderNode; blendMode: BlendMode) {.deprecated.} =
  assert(result is BlendNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blend_node_new(cast[ptr RenderNode00](bottom.impl), cast[ptr RenderNode00](top.impl), blendMode)

proc gsk_blend_node_get_blend_mode(self: ptr BlendNode00): BlendMode {.
    importc, libprag.}

proc getBlendMode*(self: BlendNode): BlendMode =
  gsk_blend_node_get_blend_mode(cast[ptr BlendNode00](self.impl))

proc blendMode*(self: BlendNode): BlendMode =
  gsk_blend_node_get_blend_mode(cast[ptr BlendNode00](self.impl))

proc gsk_blend_node_get_bottom_child(self: ptr BlendNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getBottomChild*(self: BlendNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blend_node_get_bottom_child(cast[ptr BlendNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc bottomChild*(self: BlendNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blend_node_get_bottom_child(cast[ptr BlendNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_blend_node_get_top_child(self: ptr BlendNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getTopChild*(self: BlendNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blend_node_get_top_child(cast[ptr BlendNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc topChild*(self: BlendNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blend_node_get_top_child(cast[ptr BlendNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

type
  RenderNodeType* {.size: sizeof(cint), pure.} = enum
    notARenderNode = 0
    containerNode = 1
    cairoNode = 2
    colorNode = 3
    linearGradientNode = 4
    repeatingLinearGradientNode = 5
    radialGradientNode = 6
    repeatingRadialGradientNode = 7
    conicGradientNode = 8
    borderNode = 9
    textureNode = 10
    insetShadowNode = 11
    outsetShadowNode = 12
    transformNode = 13
    opacityNode = 14
    colorMatrixNode = 15
    repeatNode = 16
    clipNode = 17
    roundedClipNode = 18
    shadowNode = 19
    blendNode = 20
    crossFadeNode = 21
    textNode = 22
    blurNode = 23
    debugNode = 24
    glShaderNode = 25
    textureScaleNode = 26
    maskNode = 27
    fillNode = 28
    strokeNode = 29
    subsurfaceNode = 30

proc gsk_render_node_get_node_type(self: ptr RenderNode00): RenderNodeType {.
    importc, libprag.}

proc getNodeType*(self: RenderNode): RenderNodeType =
  gsk_render_node_get_node_type(cast[ptr RenderNode00](self.impl))

proc nodeType*(self: RenderNode): RenderNodeType =
  gsk_render_node_get_node_type(cast[ptr RenderNode00](self.impl))

type
  BlurNode* = ref object of RenderNode
  BlurNode00* = object of RenderNode00

proc gsk_blur_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr BlurNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: BlurNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BlurNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_blur_node_new(child: ptr RenderNode00; radius: cfloat): ptr BlurNode00 {.
    importc, libprag.}

proc newBlurNode*(child: RenderNode; radius: cfloat): BlurNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blur_node_new(cast[ptr RenderNode00](child.impl), radius)

proc newBlurNode*(tdesc: typedesc; child: RenderNode; radius: cfloat): tdesc =
  assert(result is BlurNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blur_node_new(cast[ptr RenderNode00](child.impl), radius)

proc initBlurNode*[T](result: var T; child: RenderNode; radius: cfloat) {.deprecated.} =
  assert(result is BlurNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blur_node_new(cast[ptr RenderNode00](child.impl), radius)

proc gsk_blur_node_get_child(self: ptr BlurNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: BlurNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blur_node_get_child(cast[ptr BlurNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc child*(self: BlurNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_blur_node_get_child(cast[ptr BlurNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_blur_node_get_radius(self: ptr BlurNode00): cfloat {.
    importc, libprag.}

proc getRadius*(self: BlurNode): cfloat =
  gsk_blur_node_get_radius(cast[ptr BlurNode00](self.impl))

proc radius*(self: BlurNode): cfloat =
  gsk_blur_node_get_radius(cast[ptr BlurNode00](self.impl))

type
  BorderNode* = ref object of RenderNode
  BorderNode00* = object of RenderNode00

proc gsk_border_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr BorderNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: BorderNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BorderNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_border_node_get_colors(self: ptr BorderNode00): ptr gdk4.RGBA {.
    importc, libprag.}

proc getColors*(self: BorderNode): ptr gdk4.RGBA =
  gsk_border_node_get_colors(cast[ptr BorderNode00](self.impl))

proc colors*(self: BorderNode): ptr gdk4.RGBA =
  gsk_border_node_get_colors(cast[ptr BorderNode00](self.impl))

proc gsk_border_node_get_widths(self: ptr BorderNode00): ptr array[4, cfloat] {.
    importc, libprag.}

proc getWidths*(self: BorderNode): ptr array[4, cfloat] =
  gsk_border_node_get_widths(cast[ptr BorderNode00](self.impl))

proc widths*(self: BorderNode): ptr array[4, cfloat] =
  gsk_border_node_get_widths(cast[ptr BorderNode00](self.impl))

type
  RoundedRect* {.pure, byRef.} = object
    bounds*: graphene.Rect
    corner*: array[4, graphene.Size]

proc gsk_rounded_rect_contains_point(self: RoundedRect; point: graphene.Point): gboolean {.
    importc, libprag.}

proc containsPoint*(self: RoundedRect; point: graphene.Point): bool =
  toBool(gsk_rounded_rect_contains_point(self, point))

proc gsk_rounded_rect_contains_rect(self: RoundedRect; rect: graphene.Rect): gboolean {.
    importc, libprag.}

proc containsRect*(self: RoundedRect; rect: graphene.Rect): bool =
  toBool(gsk_rounded_rect_contains_rect(self, rect))

proc gsk_rounded_rect_init(self: RoundedRect; bounds: graphene.Rect; topLeft: graphene.Size;
    topRight: graphene.Size; bottomRight: graphene.Size; bottomLeft: graphene.Size): ptr RoundedRect {.
    importc, libprag.}

proc init*(self: RoundedRect; bounds: graphene.Rect; topLeft: graphene.Size;
    topRight: graphene.Size; bottomRight: graphene.Size; bottomLeft: graphene.Size): ptr RoundedRect =
  gsk_rounded_rect_init(self, bounds, topLeft, topRight, bottomRight, bottomLeft)

proc gsk_rounded_rect_init_copy(self: RoundedRect; src: RoundedRect): ptr RoundedRect {.
    importc, libprag.}

proc initCopy*(self: RoundedRect; src: RoundedRect): ptr RoundedRect =
  gsk_rounded_rect_init_copy(self, src)

proc gsk_rounded_rect_init_from_rect(self: RoundedRect; bounds: graphene.Rect;
    radius: cfloat): ptr RoundedRect {.
    importc, libprag.}

proc initFromRect*(self: RoundedRect; bounds: graphene.Rect;
    radius: cfloat): ptr RoundedRect =
  gsk_rounded_rect_init_from_rect(self, bounds, radius)

proc gsk_rounded_rect_intersects_rect(self: RoundedRect; rect: graphene.Rect): gboolean {.
    importc, libprag.}

proc intersectsRect*(self: RoundedRect; rect: graphene.Rect): bool =
  toBool(gsk_rounded_rect_intersects_rect(self, rect))

proc gsk_rounded_rect_is_rectilinear(self: RoundedRect): gboolean {.
    importc, libprag.}

proc isRectilinear*(self: RoundedRect): bool =
  toBool(gsk_rounded_rect_is_rectilinear(self))

proc gsk_rounded_rect_normalize(self: RoundedRect): ptr RoundedRect {.
    importc, libprag.}

proc normalize*(self: RoundedRect): ptr RoundedRect =
  gsk_rounded_rect_normalize(self)

proc gsk_rounded_rect_offset(self: RoundedRect; dx: cfloat; dy: cfloat): ptr RoundedRect {.
    importc, libprag.}

proc offset*(self: RoundedRect; dx: cfloat; dy: cfloat): ptr RoundedRect =
  gsk_rounded_rect_offset(self, dx, dy)

proc gsk_rounded_rect_shrink(self: RoundedRect; top: cfloat; right: cfloat;
    bottom: cfloat; left: cfloat): ptr RoundedRect {.
    importc, libprag.}

proc shrink*(self: RoundedRect; top: cfloat; right: cfloat;
    bottom: cfloat; left: cfloat): ptr RoundedRect =
  gsk_rounded_rect_shrink(self, top, right, bottom, left)

proc gsk_border_node_new(outline: RoundedRect; borderWidth: ptr array[4, cfloat];
    borderColor: ptr array[4, gdk4.RGBA]): ptr BorderNode00 {.
    importc, libprag.}

proc newBorderNode*(outline: RoundedRect; borderWidth: ptr array[4, cfloat];
    borderColor: ptr array[4, gdk4.RGBA]): BorderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_border_node_new(outline, borderWidth, borderColor)

proc newBorderNode*(tdesc: typedesc; outline: RoundedRect; borderWidth: ptr array[4, cfloat];
    borderColor: ptr array[4, gdk4.RGBA]): tdesc =
  assert(result is BorderNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_border_node_new(outline, borderWidth, borderColor)

proc initBorderNode*[T](result: var T; outline: RoundedRect; borderWidth: ptr array[4, cfloat];
    borderColor: ptr array[4, gdk4.RGBA]) {.deprecated.} =
  assert(result is BorderNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_border_node_new(outline, borderWidth, borderColor)

proc gsk_border_node_get_outline(self: ptr BorderNode00): ptr RoundedRect {.
    importc, libprag.}

proc getOutline*(self: BorderNode): ptr RoundedRect =
  gsk_border_node_get_outline(cast[ptr BorderNode00](self.impl))

proc outline*(self: BorderNode): ptr RoundedRect =
  gsk_border_node_get_outline(cast[ptr BorderNode00](self.impl))

type
  Renderer* = ref object of gobject.Object
  Renderer00* = object of gobject.Object00

proc gsk_renderer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Renderer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gsk_renderer_new_for_surface(surface: ptr gdk4.Surface00): ptr Renderer00 {.
    importc, libprag.}

proc newRendererForSurface*(surface: gdk4.Surface): Renderer =
  let gobj = gsk_renderer_new_for_surface(cast[ptr gdk4.Surface00](surface.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newRendererForSurface*(tdesc: typedesc; surface: gdk4.Surface): tdesc =
  assert(result is Renderer)
  let gobj = gsk_renderer_new_for_surface(cast[ptr gdk4.Surface00](surface.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initRendererForSurface*[T](result: var T; surface: gdk4.Surface) {.deprecated.} =
  assert(result is Renderer)
  let gobj = gsk_renderer_new_for_surface(cast[ptr gdk4.Surface00](surface.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gsk_renderer_get_surface(self: ptr Renderer00): ptr gdk4.Surface00 {.
    importc, libprag.}

proc getSurface*(self: Renderer): gdk4.Surface =
  let gobj = gsk_renderer_get_surface(cast[ptr Renderer00](self.impl))
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

proc surface*(self: Renderer): gdk4.Surface =
  let gobj = gsk_renderer_get_surface(cast[ptr Renderer00](self.impl))
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

proc gsk_renderer_is_realized(self: ptr Renderer00): gboolean {.
    importc, libprag.}

proc isRealized*(self: Renderer): bool =
  toBool(gsk_renderer_is_realized(cast[ptr Renderer00](self.impl)))

proc gsk_renderer_realize(self: ptr Renderer00; surface: ptr gdk4.Surface00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc realize*(self: Renderer; surface: gdk4.Surface = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = gsk_renderer_realize(cast[ptr Renderer00](self.impl), if surface.isNil: nil else: cast[ptr gdk4.Surface00](surface.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gsk_renderer_realize_for_display(self: ptr Renderer00; display: ptr gdk4.Display00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc realizeForDisplay*(self: Renderer; display: gdk4.Display): bool =
  var gerror: ptr glib.Error
  let resul0 = gsk_renderer_realize_for_display(cast[ptr Renderer00](self.impl), cast[ptr gdk4.Display00](display.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gsk_renderer_render(self: ptr Renderer00; root: ptr RenderNode00; region: ptr cairo.Region00) {.
    importc, libprag.}

proc render*(self: Renderer; root: RenderNode; region: cairo.Region = nil) =
  gsk_renderer_render(cast[ptr Renderer00](self.impl), cast[ptr RenderNode00](root.impl), if region.isNil: nil else: cast[ptr cairo.Region00](region.impl))

proc gsk_renderer_render_texture(self: ptr Renderer00; root: ptr RenderNode00;
    viewport: graphene.Rect): ptr gdk4.Texture00 {.
    importc, libprag.}

proc renderTexture*(self: Renderer; root: RenderNode; viewport: graphene.Rect = cast[var graphene.Rect](nil)): gdk4.Texture =
  let gobj = gsk_renderer_render_texture(cast[ptr Renderer00](self.impl), cast[ptr RenderNode00](root.impl), viewport)
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

proc gsk_renderer_unrealize(self: ptr Renderer00) {.
    importc, libprag.}

proc unrealize*(self: Renderer) =
  gsk_renderer_unrealize(cast[ptr Renderer00](self.impl))

type
  BroadwayRenderer* = ref object of Renderer
  BroadwayRenderer00* = object of Renderer00

proc gsk_broadway_renderer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BroadwayRenderer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gsk_broadway_renderer_new(): ptr BroadwayRenderer00 {.
    importc, libprag.}

proc newBroadwayRenderer*(): BroadwayRenderer =
  let gobj = gsk_broadway_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newBroadwayRenderer*(tdesc: typedesc): tdesc =
  assert(result is BroadwayRenderer)
  let gobj = gsk_broadway_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBroadwayRenderer*[T](result: var T) {.deprecated.} =
  assert(result is BroadwayRenderer)
  let gobj = gsk_broadway_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  CairoNode* = ref object of RenderNode
  CairoNode00* = object of RenderNode00

proc gsk_cairo_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr CairoNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: CairoNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CairoNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_cairo_node_new(bounds: graphene.Rect): ptr CairoNode00 {.
    importc, libprag.}

proc newCairoNode*(bounds: graphene.Rect): CairoNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_cairo_node_new(bounds)

proc newCairoNode*(tdesc: typedesc; bounds: graphene.Rect): tdesc =
  assert(result is CairoNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_cairo_node_new(bounds)

proc initCairoNode*[T](result: var T; bounds: graphene.Rect) {.deprecated.} =
  assert(result is CairoNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_cairo_node_new(bounds)

proc gsk_cairo_node_get_draw_context(self: ptr CairoNode00): ptr cairo.Context00 {.
    importc, libprag.}

proc getDrawContext*(self: CairoNode): cairo.Context =
  fnew(result, gBoxedFreeCairoContext)
  result.impl = gsk_cairo_node_get_draw_context(cast[ptr CairoNode00](self.impl))

proc drawContext*(self: CairoNode): cairo.Context =
  fnew(result, gBoxedFreeCairoContext)
  result.impl = gsk_cairo_node_get_draw_context(cast[ptr CairoNode00](self.impl))

proc gsk_cairo_node_get_surface(self: ptr CairoNode00): ptr cairo.Surface00 {.
    importc, libprag.}

proc getSurface*(self: CairoNode): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = gsk_cairo_node_get_surface(cast[ptr CairoNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_surface_get_type(), result.impl))

proc surface*(self: CairoNode): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = gsk_cairo_node_get_surface(cast[ptr CairoNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_surface_get_type(), result.impl))

type
  CairoRenderer* = ref object of Renderer
  CairoRenderer00* = object of Renderer00

proc gsk_cairo_renderer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CairoRenderer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gsk_cairo_renderer_new(): ptr CairoRenderer00 {.
    importc, libprag.}

proc newCairoRenderer*(): CairoRenderer =
  let gobj = gsk_cairo_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCairoRenderer*(tdesc: typedesc): tdesc =
  assert(result is CairoRenderer)
  let gobj = gsk_cairo_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCairoRenderer*[T](result: var T) {.deprecated.} =
  assert(result is CairoRenderer)
  let gobj = gsk_cairo_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ClipNode* = ref object of RenderNode
  ClipNode00* = object of RenderNode00

proc gsk_clip_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr ClipNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: ClipNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ClipNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_clip_node_new(child: ptr RenderNode00; clip: graphene.Rect): ptr ClipNode00 {.
    importc, libprag.}

proc newClipNode*(child: RenderNode; clip: graphene.Rect): ClipNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_clip_node_new(cast[ptr RenderNode00](child.impl), clip)

proc newClipNode*(tdesc: typedesc; child: RenderNode; clip: graphene.Rect): tdesc =
  assert(result is ClipNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_clip_node_new(cast[ptr RenderNode00](child.impl), clip)

proc initClipNode*[T](result: var T; child: RenderNode; clip: graphene.Rect) {.deprecated.} =
  assert(result is ClipNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_clip_node_new(cast[ptr RenderNode00](child.impl), clip)

proc gsk_clip_node_get_child(self: ptr ClipNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: ClipNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_clip_node_get_child(cast[ptr ClipNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc child*(self: ClipNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_clip_node_get_child(cast[ptr ClipNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_clip_node_get_clip(self: ptr ClipNode00): ptr graphene.Rect {.
    importc, libprag.}

proc getClip*(self: ClipNode): ptr graphene.Rect =
  gsk_clip_node_get_clip(cast[ptr ClipNode00](self.impl))

proc clip*(self: ClipNode): ptr graphene.Rect =
  gsk_clip_node_get_clip(cast[ptr ClipNode00](self.impl))

type
  ColorMatrixNode* = ref object of RenderNode
  ColorMatrixNode00* = object of RenderNode00

proc gsk_color_matrix_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr ColorMatrixNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: ColorMatrixNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ColorMatrixNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_color_matrix_node_new(child: ptr RenderNode00; colorMatrix: graphene.Matrix;
    colorOffset: graphene.Vec4): ptr ColorMatrixNode00 {.
    importc, libprag.}

proc newColorMatrixNode*(child: RenderNode; colorMatrix: graphene.Matrix;
    colorOffset: graphene.Vec4): ColorMatrixNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_color_matrix_node_new(cast[ptr RenderNode00](child.impl), colorMatrix, colorOffset)

proc newColorMatrixNode*(tdesc: typedesc; child: RenderNode; colorMatrix: graphene.Matrix;
    colorOffset: graphene.Vec4): tdesc =
  assert(result is ColorMatrixNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_color_matrix_node_new(cast[ptr RenderNode00](child.impl), colorMatrix, colorOffset)

proc initColorMatrixNode*[T](result: var T; child: RenderNode; colorMatrix: graphene.Matrix;
    colorOffset: graphene.Vec4) {.deprecated.} =
  assert(result is ColorMatrixNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_color_matrix_node_new(cast[ptr RenderNode00](child.impl), colorMatrix, colorOffset)

proc gsk_color_matrix_node_get_child(self: ptr ColorMatrixNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: ColorMatrixNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_color_matrix_node_get_child(cast[ptr ColorMatrixNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc child*(self: ColorMatrixNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_color_matrix_node_get_child(cast[ptr ColorMatrixNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_color_matrix_node_get_color_matrix(self: ptr ColorMatrixNode00): ptr graphene.Matrix {.
    importc, libprag.}

proc getColorMatrix*(self: ColorMatrixNode): ptr graphene.Matrix =
  gsk_color_matrix_node_get_color_matrix(cast[ptr ColorMatrixNode00](self.impl))

proc colorMatrix*(self: ColorMatrixNode): ptr graphene.Matrix =
  gsk_color_matrix_node_get_color_matrix(cast[ptr ColorMatrixNode00](self.impl))

proc gsk_color_matrix_node_get_color_offset(self: ptr ColorMatrixNode00): ptr graphene.Vec4 {.
    importc, libprag.}

proc getColorOffset*(self: ColorMatrixNode): ptr graphene.Vec4 =
  gsk_color_matrix_node_get_color_offset(cast[ptr ColorMatrixNode00](self.impl))

proc colorOffset*(self: ColorMatrixNode): ptr graphene.Vec4 =
  gsk_color_matrix_node_get_color_offset(cast[ptr ColorMatrixNode00](self.impl))

type
  ColorNode* = ref object of RenderNode
  ColorNode00* = object of RenderNode00

proc gsk_color_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr ColorNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: ColorNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ColorNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_color_node_new(rgba: gdk4.RGBA; bounds: graphene.Rect): ptr ColorNode00 {.
    importc, libprag.}

proc newColorNode*(rgba: gdk4.RGBA; bounds: graphene.Rect): ColorNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_color_node_new(rgba, bounds)

proc newColorNode*(tdesc: typedesc; rgba: gdk4.RGBA; bounds: graphene.Rect): tdesc =
  assert(result is ColorNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_color_node_new(rgba, bounds)

proc initColorNode*[T](result: var T; rgba: gdk4.RGBA; bounds: graphene.Rect) {.deprecated.} =
  assert(result is ColorNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_color_node_new(rgba, bounds)

proc gsk_color_node_get_color(self: ptr ColorNode00): ptr gdk4.RGBA {.
    importc, libprag.}

proc getColor*(self: ColorNode): ptr gdk4.RGBA =
  gsk_color_node_get_color(cast[ptr ColorNode00](self.impl))

proc color*(self: ColorNode): ptr gdk4.RGBA =
  gsk_color_node_get_color(cast[ptr ColorNode00](self.impl))

type
  ColorStop* {.pure, byRef.} = object
    offset*: cfloat
    color*: gdk4.RGBA

type
  ConicGradientNode* = ref object of RenderNode
  ConicGradientNode00* = object of RenderNode00

proc gsk_conic_gradient_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr ConicGradientNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: ConicGradientNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ConicGradientNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_conic_gradient_node_new(bounds: graphene.Rect; center: graphene.Point;
    rotation: cfloat; colorStops: ptr ColorStop; nColorStops: uint64): ptr ConicGradientNode00 {.
    importc, libprag.}

proc newConicGradientNode*(bounds: graphene.Rect; center: graphene.Point;
    rotation: cfloat; colorStops: ptr ColorStop; nColorStops: uint64): ConicGradientNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_conic_gradient_node_new(bounds, center, rotation, colorStops, nColorStops)

proc newConicGradientNode*(tdesc: typedesc; bounds: graphene.Rect; center: graphene.Point;
    rotation: cfloat; colorStops: ptr ColorStop; nColorStops: uint64): tdesc =
  assert(result is ConicGradientNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_conic_gradient_node_new(bounds, center, rotation, colorStops, nColorStops)

proc initConicGradientNode*[T](result: var T; bounds: graphene.Rect; center: graphene.Point;
    rotation: cfloat; colorStops: ptr ColorStop; nColorStops: uint64) {.deprecated.} =
  assert(result is ConicGradientNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_conic_gradient_node_new(bounds, center, rotation, colorStops, nColorStops)

proc gsk_conic_gradient_node_get_angle(self: ptr ConicGradientNode00): cfloat {.
    importc, libprag.}

proc getAngle*(self: ConicGradientNode): cfloat =
  gsk_conic_gradient_node_get_angle(cast[ptr ConicGradientNode00](self.impl))

proc angle*(self: ConicGradientNode): cfloat =
  gsk_conic_gradient_node_get_angle(cast[ptr ConicGradientNode00](self.impl))

proc gsk_conic_gradient_node_get_center(self: ptr ConicGradientNode00): ptr graphene.Point {.
    importc, libprag.}

proc getCenter*(self: ConicGradientNode): ptr graphene.Point =
  gsk_conic_gradient_node_get_center(cast[ptr ConicGradientNode00](self.impl))

proc center*(self: ConicGradientNode): ptr graphene.Point =
  gsk_conic_gradient_node_get_center(cast[ptr ConicGradientNode00](self.impl))

proc gsk_conic_gradient_node_get_color_stops(self: ptr ConicGradientNode00;
    nStops: var uint64): ptr ColorStop {.
    importc, libprag.}

proc getColorStops*(self: ConicGradientNode; nStops: var uint64 = cast[var uint64](nil)): ptr ColorStop =
  gsk_conic_gradient_node_get_color_stops(cast[ptr ConicGradientNode00](self.impl), nStops)

proc gsk_conic_gradient_node_get_n_color_stops(self: ptr ConicGradientNode00): uint64 {.
    importc, libprag.}

proc getNColorStops*(self: ConicGradientNode): uint64 =
  gsk_conic_gradient_node_get_n_color_stops(cast[ptr ConicGradientNode00](self.impl))

proc nColorStops*(self: ConicGradientNode): uint64 =
  gsk_conic_gradient_node_get_n_color_stops(cast[ptr ConicGradientNode00](self.impl))

proc gsk_conic_gradient_node_get_rotation(self: ptr ConicGradientNode00): cfloat {.
    importc, libprag.}

proc getRotation*(self: ConicGradientNode): cfloat =
  gsk_conic_gradient_node_get_rotation(cast[ptr ConicGradientNode00](self.impl))

proc rotation*(self: ConicGradientNode): cfloat =
  gsk_conic_gradient_node_get_rotation(cast[ptr ConicGradientNode00](self.impl))

type
  ContainerNode* = ref object of RenderNode
  ContainerNode00* = object of RenderNode00

proc gsk_container_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr ContainerNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: ContainerNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContainerNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_container_node_new(children: ptr ptr RenderNode00; nChildren: uint32): ptr ContainerNode00 {.
    importc, libprag.}

proc newContainerNode*(children: ptr ptr RenderNode00; nChildren: int): ContainerNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_container_node_new(children, uint32(nChildren))

proc newContainerNode*(tdesc: typedesc; children: ptr ptr RenderNode00; nChildren: int): tdesc =
  assert(result is ContainerNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_container_node_new(children, uint32(nChildren))

proc initContainerNode*[T](result: var T; children: ptr ptr RenderNode00; nChildren: int) {.deprecated.} =
  assert(result is ContainerNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_container_node_new(children, uint32(nChildren))

proc gsk_container_node_get_child(self: ptr ContainerNode00; idx: uint32): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: ContainerNode; idx: int): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_container_node_get_child(cast[ptr ContainerNode00](self.impl), uint32(idx))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_container_node_get_n_children(self: ptr ContainerNode00): uint32 {.
    importc, libprag.}

proc getNChildren*(self: ContainerNode): int =
  int(gsk_container_node_get_n_children(cast[ptr ContainerNode00](self.impl)))

proc nChildren*(self: ContainerNode): int =
  int(gsk_container_node_get_n_children(cast[ptr ContainerNode00](self.impl)))

type
  Corner* {.size: sizeof(cint), pure.} = enum
    topLeft = 0
    topRight = 1
    bottomRight = 2
    bottomLeft = 3

type
  CrossFadeNode* = ref object of RenderNode
  CrossFadeNode00* = object of RenderNode00

proc gsk_cross_fade_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr CrossFadeNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: CrossFadeNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CrossFadeNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_cross_fade_node_new(start: ptr RenderNode00; `end`: ptr RenderNode00;
    progress: cfloat): ptr CrossFadeNode00 {.
    importc, libprag.}

proc newCrossFadeNode*(start: RenderNode; `end`: RenderNode; progress: cfloat): CrossFadeNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_cross_fade_node_new(cast[ptr RenderNode00](start.impl), cast[ptr RenderNode00](`end`.impl), progress)

proc newCrossFadeNode*(tdesc: typedesc; start: RenderNode; `end`: RenderNode; progress: cfloat): tdesc =
  assert(result is CrossFadeNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_cross_fade_node_new(cast[ptr RenderNode00](start.impl), cast[ptr RenderNode00](`end`.impl), progress)

proc initCrossFadeNode*[T](result: var T; start: RenderNode; `end`: RenderNode; progress: cfloat) {.deprecated.} =
  assert(result is CrossFadeNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_cross_fade_node_new(cast[ptr RenderNode00](start.impl), cast[ptr RenderNode00](`end`.impl), progress)

proc gsk_cross_fade_node_get_end_child(self: ptr CrossFadeNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getEndChild*(self: CrossFadeNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_cross_fade_node_get_end_child(cast[ptr CrossFadeNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc endChild*(self: CrossFadeNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_cross_fade_node_get_end_child(cast[ptr CrossFadeNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_cross_fade_node_get_progress(self: ptr CrossFadeNode00): cfloat {.
    importc, libprag.}

proc getProgress*(self: CrossFadeNode): cfloat =
  gsk_cross_fade_node_get_progress(cast[ptr CrossFadeNode00](self.impl))

proc progress*(self: CrossFadeNode): cfloat =
  gsk_cross_fade_node_get_progress(cast[ptr CrossFadeNode00](self.impl))

proc gsk_cross_fade_node_get_start_child(self: ptr CrossFadeNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getStartChild*(self: CrossFadeNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_cross_fade_node_get_start_child(cast[ptr CrossFadeNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc startChild*(self: CrossFadeNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_cross_fade_node_get_start_child(cast[ptr CrossFadeNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

type
  DebugNode* = ref object of RenderNode
  DebugNode00* = object of RenderNode00

proc gsk_debug_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr DebugNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: DebugNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DebugNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_debug_node_new(child: ptr RenderNode00; message: cstring): ptr DebugNode00 {.
    importc, libprag.}

proc newDebugNode*(child: RenderNode; message: cstring): DebugNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_debug_node_new(cast[ptr RenderNode00](child.impl), message)

proc newDebugNode*(tdesc: typedesc; child: RenderNode; message: cstring): tdesc =
  assert(result is DebugNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_debug_node_new(cast[ptr RenderNode00](child.impl), message)

proc initDebugNode*[T](result: var T; child: RenderNode; message: cstring) {.deprecated.} =
  assert(result is DebugNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_debug_node_new(cast[ptr RenderNode00](child.impl), message)

proc gsk_debug_node_get_child(self: ptr DebugNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: DebugNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_debug_node_get_child(cast[ptr DebugNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc child*(self: DebugNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_debug_node_get_child(cast[ptr DebugNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_debug_node_get_message(self: ptr DebugNode00): cstring {.
    importc, libprag.}

proc getMessage*(self: DebugNode): string =
  result = $gsk_debug_node_get_message(cast[ptr DebugNode00](self.impl))

proc message*(self: DebugNode): string =
  result = $gsk_debug_node_get_message(cast[ptr DebugNode00](self.impl))

type
  FillNode* = ref object of RenderNode
  FillNode00* = object of RenderNode00

proc gsk_fill_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr FillNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: FillNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FillNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_fill_node_get_child(self: ptr FillNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: FillNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_fill_node_get_child(cast[ptr FillNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc child*(self: FillNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_fill_node_get_child(cast[ptr FillNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

type
  FillRule* {.size: sizeof(cint), pure.} = enum
    winding = 0
    evenOdd = 1

proc gsk_fill_node_get_fill_rule(self: ptr FillNode00): FillRule {.
    importc, libprag.}

proc getFillRule*(self: FillNode): FillRule =
  gsk_fill_node_get_fill_rule(cast[ptr FillNode00](self.impl))

proc fillRule*(self: FillNode): FillRule =
  gsk_fill_node_get_fill_rule(cast[ptr FillNode00](self.impl))

type
  Path00* {.pure.} = object
  Path* = ref object
    impl*: ptr Path00
    ignoreFinalizer*: bool

proc gsk_path_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGskPath*(self: Path) =
  if not self.ignoreFinalizer:
    boxedFree(gsk_path_get_type(), cast[ptr Path00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Path()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gsk_path_get_type(), cast[ptr Path00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Path) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGskPath)

proc gsk_path_unref(self: ptr Path00) {.
    importc, libprag.}

proc unref*(self: Path) =
  gsk_path_unref(cast[ptr Path00](self.impl))

proc finalizerunref*(self: Path) =
  if not self.ignoreFinalizer:
    gsk_path_unref(cast[ptr Path00](self.impl))

proc gsk_path_get_bounds(self: ptr Path00; bounds: var graphene.Rect): gboolean {.
    importc, libprag.}

proc getBounds*(self: Path; bounds: var graphene.Rect): bool =
  toBool(gsk_path_get_bounds(cast[ptr Path00](self.impl), bounds))

proc gsk_path_in_fill(self: ptr Path00; point: graphene.Point; fillRule: FillRule): gboolean {.
    importc, libprag.}

proc inFill*(self: Path; point: graphene.Point; fillRule: FillRule): bool =
  toBool(gsk_path_in_fill(cast[ptr Path00](self.impl), point, fillRule))

proc gsk_path_is_closed(self: ptr Path00): gboolean {.
    importc, libprag.}

proc isClosed*(self: Path): bool =
  toBool(gsk_path_is_closed(cast[ptr Path00](self.impl)))

proc gsk_path_is_empty(self: ptr Path00): gboolean {.
    importc, libprag.}

proc isEmpty*(self: Path): bool =
  toBool(gsk_path_is_empty(cast[ptr Path00](self.impl)))

proc gsk_path_print(self: ptr Path00; string: glib.String) {.
    importc, libprag.}

proc print*(self: Path; string: glib.String) =
  gsk_path_print(cast[ptr Path00](self.impl), string)

proc gsk_path_ref(self: ptr Path00): ptr Path00 {.
    importc, libprag.}

proc `ref`*(self: Path): Path =
  fnew(result, gBoxedFreeGskPath)
  result.impl = gsk_path_ref(cast[ptr Path00](self.impl))

proc gsk_path_to_cairo(self: ptr Path00; cr: ptr cairo.Context00) {.
    importc, libprag.}

proc toCairo*(self: Path; cr: cairo.Context) =
  gsk_path_to_cairo(cast[ptr Path00](self.impl), cast[ptr cairo.Context00](cr.impl))

proc gsk_path_to_string(self: ptr Path00): cstring {.
    importc, libprag.}

proc toString*(self: Path): string =
  let resul0 = gsk_path_to_string(cast[ptr Path00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gsk_path_parse(string: cstring): ptr Path00 {.
    importc, libprag.}

proc parse*(string: cstring): Path =
  let impl0 = gsk_path_parse(string)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskPath)
  result.impl = impl0

proc gsk_fill_node_new(child: ptr RenderNode00; path: ptr Path00; fillRule: FillRule): ptr FillNode00 {.
    importc, libprag.}

proc newFillNode*(child: RenderNode; path: Path; fillRule: FillRule): FillNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_fill_node_new(cast[ptr RenderNode00](child.impl), cast[ptr Path00](path.impl), fillRule)

proc newFillNode*(tdesc: typedesc; child: RenderNode; path: Path; fillRule: FillRule): tdesc =
  assert(result is FillNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_fill_node_new(cast[ptr RenderNode00](child.impl), cast[ptr Path00](path.impl), fillRule)

proc initFillNode*[T](result: var T; child: RenderNode; path: Path; fillRule: FillRule) {.deprecated.} =
  assert(result is FillNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_fill_node_new(cast[ptr RenderNode00](child.impl), cast[ptr Path00](path.impl), fillRule)

proc gsk_fill_node_get_path(self: ptr FillNode00): ptr Path00 {.
    importc, libprag.}

proc getPath*(self: FillNode): Path =
  fnew(result, gBoxedFreeGskPath)
  result.impl = gsk_fill_node_get_path(cast[ptr FillNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_path_get_type(), result.impl))

proc path*(self: FillNode): Path =
  fnew(result, gBoxedFreeGskPath)
  result.impl = gsk_fill_node_get_path(cast[ptr FillNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_path_get_type(), result.impl))

type
  PathPoint00* {.pure.} = object
  PathPoint* = ref object
    impl*: ptr PathPoint00
    ignoreFinalizer*: bool

proc gsk_path_point_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGskPathPoint*(self: PathPoint) =
  if not self.ignoreFinalizer:
    boxedFree(gsk_path_point_get_type(), cast[ptr PathPoint00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PathPoint()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gsk_path_point_get_type(), cast[ptr PathPoint00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PathPoint) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGskPathPoint)

proc gsk_path_point_free(self: ptr PathPoint00) {.
    importc, libprag.}

proc free*(self: PathPoint) =
  gsk_path_point_free(cast[ptr PathPoint00](self.impl))

proc finalizerfree*(self: PathPoint) =
  if not self.ignoreFinalizer:
    gsk_path_point_free(cast[ptr PathPoint00](self.impl))

proc gsk_path_point_copy(self: ptr PathPoint00): ptr PathPoint00 {.
    importc, libprag.}

proc copy*(self: PathPoint): PathPoint =
  fnew(result, gBoxedFreeGskPathPoint)
  result.impl = gsk_path_point_copy(cast[ptr PathPoint00](self.impl))

proc gsk_path_point_equal(self: ptr PathPoint00; point2: ptr PathPoint00): gboolean {.
    importc, libprag.}

proc equal*(self: PathPoint; point2: PathPoint): bool =
  toBool(gsk_path_point_equal(cast[ptr PathPoint00](self.impl), cast[ptr PathPoint00](point2.impl)))

proc gsk_path_point_compare(self: ptr PathPoint00; point2: ptr PathPoint00): int32 {.
    importc, libprag.}

proc compare*(self: PathPoint; point2: PathPoint): int =
  int(gsk_path_point_compare(cast[ptr PathPoint00](self.impl), cast[ptr PathPoint00](point2.impl)))

proc gsk_path_point_get_position(self: ptr PathPoint00; path: ptr Path00;
    position: var graphene.Point) {.
    importc, libprag.}

proc getPosition*(self: PathPoint; path: Path; position: var graphene.Point) =
  gsk_path_point_get_position(cast[ptr PathPoint00](self.impl), cast[ptr Path00](path.impl), position)

proc gsk_path_get_closest_point(self: ptr Path00; point: graphene.Point;
    threshold: cfloat; resu: var PathPoint00; distance: var cfloat): gboolean {.
    importc, libprag.}

proc getClosestPoint*(self: Path; point: graphene.Point; threshold: cfloat;
    resu: var PathPoint00; distance: var cfloat = cast[var cfloat](nil)): bool =
  toBool(gsk_path_get_closest_point(cast[ptr Path00](self.impl), point, threshold, resu, distance))

proc gsk_path_get_end_point(self: ptr Path00; resu: var PathPoint00): gboolean {.
    importc, libprag.}

proc getEndPoint*(self: Path; resu: var PathPoint00): bool =
  toBool(gsk_path_get_end_point(cast[ptr Path00](self.impl), resu))

proc gsk_path_get_start_point(self: ptr Path00; resu: var PathPoint00): gboolean {.
    importc, libprag.}

proc getStartPoint*(self: Path; resu: var PathPoint00): bool =
  toBool(gsk_path_get_start_point(cast[ptr Path00](self.impl), resu))

type
  PathMeasure00* {.pure.} = object
  PathMeasure* = ref object
    impl*: ptr PathMeasure00
    ignoreFinalizer*: bool

proc gsk_path_measure_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGskPathMeasure*(self: PathMeasure) =
  if not self.ignoreFinalizer:
    boxedFree(gsk_path_measure_get_type(), cast[ptr PathMeasure00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PathMeasure()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gsk_path_measure_get_type(), cast[ptr PathMeasure00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PathMeasure) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGskPathMeasure)

proc gsk_path_measure_unref(self: ptr PathMeasure00) {.
    importc, libprag.}

proc unref*(self: PathMeasure) =
  gsk_path_measure_unref(cast[ptr PathMeasure00](self.impl))

proc finalizerunref*(self: PathMeasure) =
  if not self.ignoreFinalizer:
    gsk_path_measure_unref(cast[ptr PathMeasure00](self.impl))

proc gsk_path_measure_new_with_tolerance(path: ptr Path00; tolerance: cfloat): ptr PathMeasure00 {.
    importc, libprag.}

proc newPathMeasureWithTolerance*(path: Path; tolerance: cfloat): PathMeasure =
  fnew(result, gBoxedFreeGskPathMeasure)
  result.impl = gsk_path_measure_new_with_tolerance(cast[ptr Path00](path.impl), tolerance)

proc newPathMeasureWithTolerance*(tdesc: typedesc; path: Path; tolerance: cfloat): tdesc =
  assert(result is PathMeasure)
  fnew(result, gBoxedFreeGskPathMeasure)
  result.impl = gsk_path_measure_new_with_tolerance(cast[ptr Path00](path.impl), tolerance)

proc initPathMeasureWithTolerance*[T](result: var T; path: Path; tolerance: cfloat) {.deprecated.} =
  assert(result is PathMeasure)
  fnew(result, gBoxedFreeGskPathMeasure)
  result.impl = gsk_path_measure_new_with_tolerance(cast[ptr Path00](path.impl), tolerance)

proc gsk_path_measure_get_length(self: ptr PathMeasure00): cfloat {.
    importc, libprag.}

proc getLength*(self: PathMeasure): cfloat =
  gsk_path_measure_get_length(cast[ptr PathMeasure00](self.impl))

proc length*(self: PathMeasure): cfloat =
  gsk_path_measure_get_length(cast[ptr PathMeasure00](self.impl))

proc gsk_path_measure_get_path(self: ptr PathMeasure00): ptr Path00 {.
    importc, libprag.}

proc getPath*(self: PathMeasure): Path =
  fnew(result, gBoxedFreeGskPath)
  result.impl = gsk_path_measure_get_path(cast[ptr PathMeasure00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_path_get_type(), result.impl))

proc path*(self: PathMeasure): Path =
  fnew(result, gBoxedFreeGskPath)
  result.impl = gsk_path_measure_get_path(cast[ptr PathMeasure00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_path_get_type(), result.impl))

proc gsk_path_measure_get_point(self: ptr PathMeasure00; distance: cfloat;
    resu: var PathPoint00): gboolean {.
    importc, libprag.}

proc getPoint*(self: PathMeasure; distance: cfloat; resu: var PathPoint00): bool =
  toBool(gsk_path_measure_get_point(cast[ptr PathMeasure00](self.impl), distance, resu))

proc gsk_path_measure_get_tolerance(self: ptr PathMeasure00): cfloat {.
    importc, libprag.}

proc getTolerance*(self: PathMeasure): cfloat =
  gsk_path_measure_get_tolerance(cast[ptr PathMeasure00](self.impl))

proc tolerance*(self: PathMeasure): cfloat =
  gsk_path_measure_get_tolerance(cast[ptr PathMeasure00](self.impl))

proc gsk_path_measure_ref(self: ptr PathMeasure00): ptr PathMeasure00 {.
    importc, libprag.}

proc `ref`*(self: PathMeasure): PathMeasure =
  fnew(result, gBoxedFreeGskPathMeasure)
  result.impl = gsk_path_measure_ref(cast[ptr PathMeasure00](self.impl))

proc gsk_path_measure_new(path: ptr Path00): ptr PathMeasure00 {.
    importc, libprag.}

proc newPathMeasure*(path: Path): PathMeasure =
  fnew(result, gBoxedFreeGskPathMeasure)
  result.impl = gsk_path_measure_new(cast[ptr Path00](path.impl))

proc newPathMeasure*(tdesc: typedesc; path: Path): tdesc =
  assert(result is PathMeasure)
  fnew(result, gBoxedFreeGskPathMeasure)
  result.impl = gsk_path_measure_new(cast[ptr Path00](path.impl))

proc initPathMeasure*[T](result: var T; path: Path) {.deprecated.} =
  assert(result is PathMeasure)
  fnew(result, gBoxedFreeGskPathMeasure)
  result.impl = gsk_path_measure_new(cast[ptr Path00](path.impl))

proc gsk_path_point_get_distance(self: ptr PathPoint00; measure: ptr PathMeasure00): cfloat {.
    importc, libprag.}

proc getDistance*(self: PathPoint; measure: PathMeasure): cfloat =
  gsk_path_point_get_distance(cast[ptr PathPoint00](self.impl), cast[ptr PathMeasure00](measure.impl))

type
  PathDirection* {.size: sizeof(cint), pure.} = enum
    fromStart = 0
    toStart = 1
    toEnd = 2
    fromEnd = 3

proc gsk_path_point_get_curvature(self: ptr PathPoint00; path: ptr Path00;
    direction: PathDirection; center: var graphene.Point): cfloat {.
    importc, libprag.}

proc getCurvature*(self: PathPoint; path: Path; direction: PathDirection;
    center: var graphene.Point = cast[var graphene.Point](nil)): cfloat =
  gsk_path_point_get_curvature(cast[ptr PathPoint00](self.impl), cast[ptr Path00](path.impl), direction, center)

proc gsk_path_point_get_rotation(self: ptr PathPoint00; path: ptr Path00;
    direction: PathDirection): cfloat {.
    importc, libprag.}

proc getRotation*(self: PathPoint; path: Path; direction: PathDirection): cfloat =
  gsk_path_point_get_rotation(cast[ptr PathPoint00](self.impl), cast[ptr Path00](path.impl), direction)

proc gsk_path_point_get_tangent(self: ptr PathPoint00; path: ptr Path00;
    direction: PathDirection; tangent: var graphene.Vec2) {.
    importc, libprag.}

proc getTangent*(self: PathPoint; path: Path; direction: PathDirection;
    tangent: var graphene.Vec2) =
  gsk_path_point_get_tangent(cast[ptr PathPoint00](self.impl), cast[ptr Path00](path.impl), direction, tangent)

type
  Stroke00* {.pure.} = object
  Stroke* = ref object
    impl*: ptr Stroke00
    ignoreFinalizer*: bool

proc gsk_stroke_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGskStroke*(self: Stroke) =
  if not self.ignoreFinalizer:
    boxedFree(gsk_stroke_get_type(), cast[ptr Stroke00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Stroke()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gsk_stroke_get_type(), cast[ptr Stroke00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Stroke) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGskStroke)

proc gsk_stroke_free(self: ptr Stroke00) {.
    importc, libprag.}

proc free*(self: Stroke) =
  gsk_stroke_free(cast[ptr Stroke00](self.impl))

proc finalizerfree*(self: Stroke) =
  if not self.ignoreFinalizer:
    gsk_stroke_free(cast[ptr Stroke00](self.impl))

proc gsk_stroke_copy(self: ptr Stroke00): ptr Stroke00 {.
    importc, libprag.}

proc copy*(self: Stroke): Stroke =
  fnew(result, gBoxedFreeGskStroke)
  result.impl = gsk_stroke_copy(cast[ptr Stroke00](self.impl))

proc gsk_stroke_new(lineWidth: cfloat): ptr Stroke00 {.
    importc, libprag.}

proc newStroke*(lineWidth: cfloat): Stroke =
  fnew(result, gBoxedFreeGskStroke)
  result.impl = gsk_stroke_new(lineWidth)

proc newStroke*(tdesc: typedesc; lineWidth: cfloat): tdesc =
  assert(result is Stroke)
  fnew(result, gBoxedFreeGskStroke)
  result.impl = gsk_stroke_new(lineWidth)

proc initStroke*[T](result: var T; lineWidth: cfloat) {.deprecated.} =
  assert(result is Stroke)
  fnew(result, gBoxedFreeGskStroke)
  result.impl = gsk_stroke_new(lineWidth)

proc gsk_stroke_get_dash(self: ptr Stroke00; nDash: var uint64): ptr cfloat {.
    importc, libprag.}

proc getDash*(self: Stroke; nDash: var uint64): ptr cfloat =
  gsk_stroke_get_dash(cast[ptr Stroke00](self.impl), nDash)

proc gsk_stroke_get_dash_offset(self: ptr Stroke00): cfloat {.
    importc, libprag.}

proc getDashOffset*(self: Stroke): cfloat =
  gsk_stroke_get_dash_offset(cast[ptr Stroke00](self.impl))

proc dashOffset*(self: Stroke): cfloat =
  gsk_stroke_get_dash_offset(cast[ptr Stroke00](self.impl))

proc gsk_stroke_get_line_width(self: ptr Stroke00): cfloat {.
    importc, libprag.}

proc getLineWidth*(self: Stroke): cfloat =
  gsk_stroke_get_line_width(cast[ptr Stroke00](self.impl))

proc lineWidth*(self: Stroke): cfloat =
  gsk_stroke_get_line_width(cast[ptr Stroke00](self.impl))

proc gsk_stroke_get_miter_limit(self: ptr Stroke00): cfloat {.
    importc, libprag.}

proc getMiterLimit*(self: Stroke): cfloat =
  gsk_stroke_get_miter_limit(cast[ptr Stroke00](self.impl))

proc miterLimit*(self: Stroke): cfloat =
  gsk_stroke_get_miter_limit(cast[ptr Stroke00](self.impl))

proc gsk_stroke_set_dash(self: ptr Stroke00; dash: ptr cfloat; nDash: uint64) {.
    importc, libprag.}

proc setDash*(self: Stroke; dash: ptr cfloat; nDash: uint64) =
  gsk_stroke_set_dash(cast[ptr Stroke00](self.impl), dash, nDash)

proc gsk_stroke_set_dash_offset(self: ptr Stroke00; offset: cfloat) {.
    importc, libprag.}

proc setDashOffset*(self: Stroke; offset: cfloat) =
  gsk_stroke_set_dash_offset(cast[ptr Stroke00](self.impl), offset)

proc `dashOffset=`*(self: Stroke; offset: cfloat) =
  gsk_stroke_set_dash_offset(cast[ptr Stroke00](self.impl), offset)

proc gsk_stroke_set_line_width(self: ptr Stroke00; lineWidth: cfloat) {.
    importc, libprag.}

proc setLineWidth*(self: Stroke; lineWidth: cfloat) =
  gsk_stroke_set_line_width(cast[ptr Stroke00](self.impl), lineWidth)

proc `lineWidth=`*(self: Stroke; lineWidth: cfloat) =
  gsk_stroke_set_line_width(cast[ptr Stroke00](self.impl), lineWidth)

proc gsk_stroke_set_miter_limit(self: ptr Stroke00; limit: cfloat) {.
    importc, libprag.}

proc setMiterLimit*(self: Stroke; limit: cfloat) =
  gsk_stroke_set_miter_limit(cast[ptr Stroke00](self.impl), limit)

proc `miterLimit=`*(self: Stroke; limit: cfloat) =
  gsk_stroke_set_miter_limit(cast[ptr Stroke00](self.impl), limit)

proc gsk_stroke_to_cairo(self: ptr Stroke00; cr: ptr cairo.Context00) {.
    importc, libprag.}

proc toCairo*(self: Stroke; cr: cairo.Context) =
  gsk_stroke_to_cairo(cast[ptr Stroke00](self.impl), cast[ptr cairo.Context00](cr.impl))

proc gsk_stroke_equal(stroke1: pointer; stroke2: pointer): gboolean {.
    importc, libprag.}

proc equal*(stroke1: pointer; stroke2: pointer): bool =
  toBool(gsk_stroke_equal(stroke1, stroke2))

proc gsk_path_get_stroke_bounds(self: ptr Path00; stroke: ptr Stroke00; bounds: var graphene.Rect): gboolean {.
    importc, libprag.}

proc getStrokeBounds*(self: Path; stroke: Stroke; bounds: var graphene.Rect): bool =
  toBool(gsk_path_get_stroke_bounds(cast[ptr Path00](self.impl), cast[ptr Stroke00](stroke.impl), bounds))

type
  LineCap* {.size: sizeof(cint), pure.} = enum
    butt = 0
    round = 1
    square = 2

proc gsk_stroke_get_line_cap(self: ptr Stroke00): LineCap {.
    importc, libprag.}

proc getLineCap*(self: Stroke): LineCap =
  gsk_stroke_get_line_cap(cast[ptr Stroke00](self.impl))

proc lineCap*(self: Stroke): LineCap =
  gsk_stroke_get_line_cap(cast[ptr Stroke00](self.impl))

proc gsk_stroke_set_line_cap(self: ptr Stroke00; lineCap: LineCap) {.
    importc, libprag.}

proc setLineCap*(self: Stroke; lineCap: LineCap) =
  gsk_stroke_set_line_cap(cast[ptr Stroke00](self.impl), lineCap)

proc `lineCap=`*(self: Stroke; lineCap: LineCap) =
  gsk_stroke_set_line_cap(cast[ptr Stroke00](self.impl), lineCap)

type
  LineJoin* {.size: sizeof(cint), pure.} = enum
    miter = 0
    round = 1
    bevel = 2

proc gsk_stroke_get_line_join(self: ptr Stroke00): LineJoin {.
    importc, libprag.}

proc getLineJoin*(self: Stroke): LineJoin =
  gsk_stroke_get_line_join(cast[ptr Stroke00](self.impl))

proc lineJoin*(self: Stroke): LineJoin =
  gsk_stroke_get_line_join(cast[ptr Stroke00](self.impl))

proc gsk_stroke_set_line_join(self: ptr Stroke00; lineJoin: LineJoin) {.
    importc, libprag.}

proc setLineJoin*(self: Stroke; lineJoin: LineJoin) =
  gsk_stroke_set_line_join(cast[ptr Stroke00](self.impl), lineJoin)

proc `lineJoin=`*(self: Stroke; lineJoin: LineJoin) =
  gsk_stroke_set_line_join(cast[ptr Stroke00](self.impl), lineJoin)

type
  PathForeachFlag* {.size: sizeof(cint), pure.} = enum
    quad = 0
    cubic = 1
    conic = 2

  PathForeachFlags* {.size: sizeof(cint).} = set[PathForeachFlag]

const
  PathForeachFlagsOnlyLines* = PathForeachFlags({})
proc onlyLines*(t: typedesc[PathForeachFlags]): PathForeachFlags = PathForeachFlags({})

type
  GLRenderer* = ref object of Renderer
  GLRenderer00* = object of Renderer00

proc gsk_gl_renderer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLRenderer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gsk_gl_renderer_new(): ptr GLRenderer00 {.
    importc, libprag.}

proc newGLRenderer*(): GLRenderer =
  let gobj = gsk_gl_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLRenderer*(tdesc: typedesc): tdesc =
  assert(result is GLRenderer)
  let gobj = gsk_gl_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLRenderer*[T](result: var T) {.deprecated.} =
  assert(result is GLRenderer)
  let gobj = gsk_gl_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  GLShader* = ref object of gobject.Object
  GLShader00* = object of gobject.Object00

proc gsk_gl_shader_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLShader()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gsk_gl_shader_new_from_bytes(sourcecode: ptr glib.Bytes00): ptr GLShader00 {.
    importc, libprag.}

proc newGLShaderFromBytes*(sourcecode: glib.Bytes): GLShader =
  let gobj = gsk_gl_shader_new_from_bytes(cast[ptr glib.Bytes00](sourcecode.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLShaderFromBytes*(tdesc: typedesc; sourcecode: glib.Bytes): tdesc =
  assert(result is GLShader)
  let gobj = gsk_gl_shader_new_from_bytes(cast[ptr glib.Bytes00](sourcecode.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLShaderFromBytes*[T](result: var T; sourcecode: glib.Bytes) {.deprecated.} =
  assert(result is GLShader)
  let gobj = gsk_gl_shader_new_from_bytes(cast[ptr glib.Bytes00](sourcecode.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gsk_gl_shader_new_from_resource(resourcePath: cstring): ptr GLShader00 {.
    importc, libprag.}

proc newGLShaderFromResource*(resourcePath: cstring): GLShader =
  let gobj = gsk_gl_shader_new_from_resource(resourcePath)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLShaderFromResource*(tdesc: typedesc; resourcePath: cstring): tdesc =
  assert(result is GLShader)
  let gobj = gsk_gl_shader_new_from_resource(resourcePath)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLShaderFromResource*[T](result: var T; resourcePath: cstring) {.deprecated.} =
  assert(result is GLShader)
  let gobj = gsk_gl_shader_new_from_resource(resourcePath)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gsk_gl_shader_compile(self: ptr GLShader00; renderer: ptr Renderer00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc compile*(self: GLShader; renderer: Renderer): bool =
  var gerror: ptr glib.Error
  let resul0 = gsk_gl_shader_compile(cast[ptr GLShader00](self.impl), cast[ptr Renderer00](renderer.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gsk_gl_shader_find_uniform_by_name(self: ptr GLShader00; name: cstring): int32 {.
    importc, libprag.}

proc findUniformByName*(self: GLShader; name: cstring): int =
  int(gsk_gl_shader_find_uniform_by_name(cast[ptr GLShader00](self.impl), name))

proc gsk_gl_shader_get_arg_bool(self: ptr GLShader00; args: ptr glib.Bytes00;
    idx: int32): gboolean {.
    importc, libprag.}

proc getArgBool*(self: GLShader; args: glib.Bytes; idx: int): bool =
  toBool(gsk_gl_shader_get_arg_bool(cast[ptr GLShader00](self.impl), cast[ptr glib.Bytes00](args.impl), int32(idx)))

proc gsk_gl_shader_get_arg_float(self: ptr GLShader00; args: ptr glib.Bytes00;
    idx: int32): cfloat {.
    importc, libprag.}

proc getArgFloat*(self: GLShader; args: glib.Bytes; idx: int): cfloat =
  gsk_gl_shader_get_arg_float(cast[ptr GLShader00](self.impl), cast[ptr glib.Bytes00](args.impl), int32(idx))

proc gsk_gl_shader_get_arg_int(self: ptr GLShader00; args: ptr glib.Bytes00;
    idx: int32): int32 {.
    importc, libprag.}

proc getArgInt*(self: GLShader; args: glib.Bytes; idx: int): int =
  int(gsk_gl_shader_get_arg_int(cast[ptr GLShader00](self.impl), cast[ptr glib.Bytes00](args.impl), int32(idx)))

proc gsk_gl_shader_get_arg_uint(self: ptr GLShader00; args: ptr glib.Bytes00;
    idx: int32): uint32 {.
    importc, libprag.}

proc getArgUint*(self: GLShader; args: glib.Bytes; idx: int): int =
  int(gsk_gl_shader_get_arg_uint(cast[ptr GLShader00](self.impl), cast[ptr glib.Bytes00](args.impl), int32(idx)))

proc gsk_gl_shader_get_arg_vec2(self: ptr GLShader00; args: ptr glib.Bytes00;
    idx: int32; outValue: graphene.Vec2) {.
    importc, libprag.}

proc getArgVec2*(self: GLShader; args: glib.Bytes; idx: int;
    outValue: graphene.Vec2) =
  gsk_gl_shader_get_arg_vec2(cast[ptr GLShader00](self.impl), cast[ptr glib.Bytes00](args.impl), int32(idx), outValue)

proc gsk_gl_shader_get_arg_vec3(self: ptr GLShader00; args: ptr glib.Bytes00;
    idx: int32; outValue: graphene.Vec3) {.
    importc, libprag.}

proc getArgVec3*(self: GLShader; args: glib.Bytes; idx: int;
    outValue: graphene.Vec3) =
  gsk_gl_shader_get_arg_vec3(cast[ptr GLShader00](self.impl), cast[ptr glib.Bytes00](args.impl), int32(idx), outValue)

proc gsk_gl_shader_get_arg_vec4(self: ptr GLShader00; args: ptr glib.Bytes00;
    idx: int32; outValue: graphene.Vec4) {.
    importc, libprag.}

proc getArgVec4*(self: GLShader; args: glib.Bytes; idx: int;
    outValue: graphene.Vec4) =
  gsk_gl_shader_get_arg_vec4(cast[ptr GLShader00](self.impl), cast[ptr glib.Bytes00](args.impl), int32(idx), outValue)

proc gsk_gl_shader_get_args_size(self: ptr GLShader00): uint64 {.
    importc, libprag.}

proc getArgsSize*(self: GLShader): uint64 =
  gsk_gl_shader_get_args_size(cast[ptr GLShader00](self.impl))

proc argsSize*(self: GLShader): uint64 =
  gsk_gl_shader_get_args_size(cast[ptr GLShader00](self.impl))

proc gsk_gl_shader_get_n_textures(self: ptr GLShader00): int32 {.
    importc, libprag.}

proc getNTextures*(self: GLShader): int =
  int(gsk_gl_shader_get_n_textures(cast[ptr GLShader00](self.impl)))

proc nTextures*(self: GLShader): int =
  int(gsk_gl_shader_get_n_textures(cast[ptr GLShader00](self.impl)))

proc gsk_gl_shader_get_n_uniforms(self: ptr GLShader00): int32 {.
    importc, libprag.}

proc getNUniforms*(self: GLShader): int =
  int(gsk_gl_shader_get_n_uniforms(cast[ptr GLShader00](self.impl)))

proc nUniforms*(self: GLShader): int =
  int(gsk_gl_shader_get_n_uniforms(cast[ptr GLShader00](self.impl)))

proc gsk_gl_shader_get_resource(self: ptr GLShader00): cstring {.
    importc, libprag.}

proc getResource*(self: GLShader): string =
  let resul0 = gsk_gl_shader_get_resource(cast[ptr GLShader00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc resource*(self: GLShader): string =
  let resul0 = gsk_gl_shader_get_resource(cast[ptr GLShader00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gsk_gl_shader_get_source(self: ptr GLShader00): ptr glib.Bytes00 {.
    importc, libprag.}

proc getSource*(self: GLShader): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gsk_gl_shader_get_source(cast[ptr GLShader00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_bytes_get_type(), result.impl))

proc source*(self: GLShader): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gsk_gl_shader_get_source(cast[ptr GLShader00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_bytes_get_type(), result.impl))

proc gsk_gl_shader_get_uniform_name(self: ptr GLShader00; idx: int32): cstring {.
    importc, libprag.}

proc getUniformName*(self: GLShader; idx: int): string =
  result = $gsk_gl_shader_get_uniform_name(cast[ptr GLShader00](self.impl), int32(idx))

proc gsk_gl_shader_get_uniform_offset(self: ptr GLShader00; idx: int32): int32 {.
    importc, libprag.}

proc getUniformOffset*(self: GLShader; idx: int): int =
  int(gsk_gl_shader_get_uniform_offset(cast[ptr GLShader00](self.impl), int32(idx)))

type
  GLUniformType* {.size: sizeof(cint), pure.} = enum
    none = 0
    float = 1
    int = 2
    uint = 3
    bool = 4
    vec2 = 5
    vec3 = 6
    vec4 = 7

proc gsk_gl_shader_get_uniform_type(self: ptr GLShader00; idx: int32): GLUniformType {.
    importc, libprag.}

proc getUniformType*(self: GLShader; idx: int): GLUniformType =
  gsk_gl_shader_get_uniform_type(cast[ptr GLShader00](self.impl), int32(idx))

type
  GLShaderNode* = ref object of RenderNode
  GLShaderNode00* = object of RenderNode00

proc gsk_gl_shader_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr GLShaderNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: GLShaderNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLShaderNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_gl_shader_node_new(shader: ptr GLShader00; bounds: graphene.Rect;
    args: ptr glib.Bytes00; children: ptr ptr RenderNode00; nChildren: uint32): ptr GLShaderNode00 {.
    importc, libprag.}

proc newGLShaderNode*(shader: GLShader; bounds: graphene.Rect; args: glib.Bytes;
    children: ptr ptr RenderNode00; nChildren: int): GLShaderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_gl_shader_node_new(cast[ptr GLShader00](shader.impl), bounds, cast[ptr glib.Bytes00](args.impl), children, uint32(nChildren))

proc newGLShaderNode*(tdesc: typedesc; shader: GLShader; bounds: graphene.Rect; args: glib.Bytes;
    children: ptr ptr RenderNode00; nChildren: int): tdesc =
  assert(result is GLShaderNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_gl_shader_node_new(cast[ptr GLShader00](shader.impl), bounds, cast[ptr glib.Bytes00](args.impl), children, uint32(nChildren))

proc initGLShaderNode*[T](result: var T; shader: GLShader; bounds: graphene.Rect; args: glib.Bytes;
    children: ptr ptr RenderNode00; nChildren: int) {.deprecated.} =
  assert(result is GLShaderNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_gl_shader_node_new(cast[ptr GLShader00](shader.impl), bounds, cast[ptr glib.Bytes00](args.impl), children, uint32(nChildren))

proc gsk_gl_shader_node_get_args(self: ptr GLShaderNode00): ptr glib.Bytes00 {.
    importc, libprag.}

proc getArgs*(self: GLShaderNode): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gsk_gl_shader_node_get_args(cast[ptr GLShaderNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_bytes_get_type(), result.impl))

proc args*(self: GLShaderNode): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gsk_gl_shader_node_get_args(cast[ptr GLShaderNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_bytes_get_type(), result.impl))

proc gsk_gl_shader_node_get_child(self: ptr GLShaderNode00; idx: uint32): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: GLShaderNode; idx: int): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_gl_shader_node_get_child(cast[ptr GLShaderNode00](self.impl), uint32(idx))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_gl_shader_node_get_n_children(self: ptr GLShaderNode00): uint32 {.
    importc, libprag.}

proc getNChildren*(self: GLShaderNode): int =
  int(gsk_gl_shader_node_get_n_children(cast[ptr GLShaderNode00](self.impl)))

proc nChildren*(self: GLShaderNode): int =
  int(gsk_gl_shader_node_get_n_children(cast[ptr GLShaderNode00](self.impl)))

proc gsk_gl_shader_node_get_shader(self: ptr GLShaderNode00): ptr GLShader00 {.
    importc, libprag.}

proc getShader*(self: GLShaderNode): GLShader =
  let gobj = gsk_gl_shader_node_get_shader(cast[ptr GLShaderNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc shader*(self: GLShaderNode): GLShader =
  let gobj = gsk_gl_shader_node_get_shader(cast[ptr GLShaderNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  InsetShadowNode* = ref object of RenderNode
  InsetShadowNode00* = object of RenderNode00

proc gsk_inset_shadow_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr InsetShadowNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: InsetShadowNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(InsetShadowNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_inset_shadow_node_new(outline: RoundedRect; color: gdk4.RGBA; dx: cfloat;
    dy: cfloat; spread: cfloat; blurRadius: cfloat): ptr InsetShadowNode00 {.
    importc, libprag.}

proc newInsetShadowNode*(outline: RoundedRect; color: gdk4.RGBA; dx: cfloat;
    dy: cfloat; spread: cfloat; blurRadius: cfloat): InsetShadowNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_inset_shadow_node_new(outline, color, dx, dy, spread, blurRadius)

proc newInsetShadowNode*(tdesc: typedesc; outline: RoundedRect; color: gdk4.RGBA; dx: cfloat;
    dy: cfloat; spread: cfloat; blurRadius: cfloat): tdesc =
  assert(result is InsetShadowNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_inset_shadow_node_new(outline, color, dx, dy, spread, blurRadius)

proc initInsetShadowNode*[T](result: var T; outline: RoundedRect; color: gdk4.RGBA; dx: cfloat;
    dy: cfloat; spread: cfloat; blurRadius: cfloat) {.deprecated.} =
  assert(result is InsetShadowNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_inset_shadow_node_new(outline, color, dx, dy, spread, blurRadius)

proc gsk_inset_shadow_node_get_blur_radius(self: ptr InsetShadowNode00): cfloat {.
    importc, libprag.}

proc getBlurRadius*(self: InsetShadowNode): cfloat =
  gsk_inset_shadow_node_get_blur_radius(cast[ptr InsetShadowNode00](self.impl))

proc blurRadius*(self: InsetShadowNode): cfloat =
  gsk_inset_shadow_node_get_blur_radius(cast[ptr InsetShadowNode00](self.impl))

proc gsk_inset_shadow_node_get_color(self: ptr InsetShadowNode00): ptr gdk4.RGBA {.
    importc, libprag.}

proc getColor*(self: InsetShadowNode): ptr gdk4.RGBA =
  gsk_inset_shadow_node_get_color(cast[ptr InsetShadowNode00](self.impl))

proc color*(self: InsetShadowNode): ptr gdk4.RGBA =
  gsk_inset_shadow_node_get_color(cast[ptr InsetShadowNode00](self.impl))

proc gsk_inset_shadow_node_get_dx(self: ptr InsetShadowNode00): cfloat {.
    importc, libprag.}

proc getDx*(self: InsetShadowNode): cfloat =
  gsk_inset_shadow_node_get_dx(cast[ptr InsetShadowNode00](self.impl))

proc dx*(self: InsetShadowNode): cfloat =
  gsk_inset_shadow_node_get_dx(cast[ptr InsetShadowNode00](self.impl))

proc gsk_inset_shadow_node_get_dy(self: ptr InsetShadowNode00): cfloat {.
    importc, libprag.}

proc getDy*(self: InsetShadowNode): cfloat =
  gsk_inset_shadow_node_get_dy(cast[ptr InsetShadowNode00](self.impl))

proc dy*(self: InsetShadowNode): cfloat =
  gsk_inset_shadow_node_get_dy(cast[ptr InsetShadowNode00](self.impl))

proc gsk_inset_shadow_node_get_outline(self: ptr InsetShadowNode00): ptr RoundedRect {.
    importc, libprag.}

proc getOutline*(self: InsetShadowNode): ptr RoundedRect =
  gsk_inset_shadow_node_get_outline(cast[ptr InsetShadowNode00](self.impl))

proc outline*(self: InsetShadowNode): ptr RoundedRect =
  gsk_inset_shadow_node_get_outline(cast[ptr InsetShadowNode00](self.impl))

proc gsk_inset_shadow_node_get_spread(self: ptr InsetShadowNode00): cfloat {.
    importc, libprag.}

proc getSpread*(self: InsetShadowNode): cfloat =
  gsk_inset_shadow_node_get_spread(cast[ptr InsetShadowNode00](self.impl))

proc spread*(self: InsetShadowNode): cfloat =
  gsk_inset_shadow_node_get_spread(cast[ptr InsetShadowNode00](self.impl))

type
  LinearGradientNode* = ref object of RenderNode
  LinearGradientNode00* = object of RenderNode00

proc gsk_linear_gradient_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr LinearGradientNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: LinearGradientNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LinearGradientNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_linear_gradient_node_new(bounds: graphene.Rect; start: graphene.Point;
    `end`: graphene.Point; colorStops: ptr ColorStop; nColorStops: uint64): ptr LinearGradientNode00 {.
    importc, libprag.}

proc newLinearGradientNode*(bounds: graphene.Rect; start: graphene.Point;
    `end`: graphene.Point; colorStops: ptr ColorStop; nColorStops: uint64): LinearGradientNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_linear_gradient_node_new(bounds, start, `end`, colorStops, nColorStops)

proc newLinearGradientNode*(tdesc: typedesc; bounds: graphene.Rect; start: graphene.Point;
    `end`: graphene.Point; colorStops: ptr ColorStop; nColorStops: uint64): tdesc =
  assert(result is LinearGradientNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_linear_gradient_node_new(bounds, start, `end`, colorStops, nColorStops)

proc initLinearGradientNode*[T](result: var T; bounds: graphene.Rect; start: graphene.Point;
    `end`: graphene.Point; colorStops: ptr ColorStop; nColorStops: uint64) {.deprecated.} =
  assert(result is LinearGradientNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_linear_gradient_node_new(bounds, start, `end`, colorStops, nColorStops)

proc gsk_linear_gradient_node_get_color_stops(self: ptr LinearGradientNode00;
    nStops: var uint64): ptr ColorStop {.
    importc, libprag.}

proc getColorStops*(self: LinearGradientNode; nStops: var uint64 = cast[var uint64](nil)): ptr ColorStop =
  gsk_linear_gradient_node_get_color_stops(cast[ptr LinearGradientNode00](self.impl), nStops)

proc gsk_linear_gradient_node_get_end(self: ptr LinearGradientNode00): ptr graphene.Point {.
    importc, libprag.}

proc getEnd*(self: LinearGradientNode): ptr graphene.Point =
  gsk_linear_gradient_node_get_end(cast[ptr LinearGradientNode00](self.impl))

proc gsk_linear_gradient_node_get_n_color_stops(self: ptr LinearGradientNode00): uint64 {.
    importc, libprag.}

proc getNColorStops*(self: LinearGradientNode): uint64 =
  gsk_linear_gradient_node_get_n_color_stops(cast[ptr LinearGradientNode00](self.impl))

proc nColorStops*(self: LinearGradientNode): uint64 =
  gsk_linear_gradient_node_get_n_color_stops(cast[ptr LinearGradientNode00](self.impl))

proc gsk_linear_gradient_node_get_start(self: ptr LinearGradientNode00): ptr graphene.Point {.
    importc, libprag.}

proc getStart*(self: LinearGradientNode): ptr graphene.Point =
  gsk_linear_gradient_node_get_start(cast[ptr LinearGradientNode00](self.impl))

proc start*(self: LinearGradientNode): ptr graphene.Point =
  gsk_linear_gradient_node_get_start(cast[ptr LinearGradientNode00](self.impl))

type
  MaskMode* {.size: sizeof(cint), pure.} = enum
    alpha = 0
    invertedAlpha = 1
    luminance = 2
    invertedLuminance = 3

type
  MaskNode* = ref object of RenderNode
  MaskNode00* = object of RenderNode00

proc gsk_mask_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr MaskNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: MaskNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MaskNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_mask_node_new(source: ptr RenderNode00; mask: ptr RenderNode00;
    maskMode: MaskMode): ptr MaskNode00 {.
    importc, libprag.}

proc newMaskNode*(source: RenderNode; mask: RenderNode; maskMode: MaskMode): MaskNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_mask_node_new(cast[ptr RenderNode00](source.impl), cast[ptr RenderNode00](mask.impl), maskMode)

proc newMaskNode*(tdesc: typedesc; source: RenderNode; mask: RenderNode; maskMode: MaskMode): tdesc =
  assert(result is MaskNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_mask_node_new(cast[ptr RenderNode00](source.impl), cast[ptr RenderNode00](mask.impl), maskMode)

proc initMaskNode*[T](result: var T; source: RenderNode; mask: RenderNode; maskMode: MaskMode) {.deprecated.} =
  assert(result is MaskNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_mask_node_new(cast[ptr RenderNode00](source.impl), cast[ptr RenderNode00](mask.impl), maskMode)

proc gsk_mask_node_get_mask(self: ptr MaskNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getMask*(self: MaskNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_mask_node_get_mask(cast[ptr MaskNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc mask*(self: MaskNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_mask_node_get_mask(cast[ptr MaskNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_mask_node_get_mask_mode(self: ptr MaskNode00): MaskMode {.
    importc, libprag.}

proc getMaskMode*(self: MaskNode): MaskMode =
  gsk_mask_node_get_mask_mode(cast[ptr MaskNode00](self.impl))

proc maskMode*(self: MaskNode): MaskMode =
  gsk_mask_node_get_mask_mode(cast[ptr MaskNode00](self.impl))

proc gsk_mask_node_get_source(self: ptr MaskNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getSource*(self: MaskNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_mask_node_get_source(cast[ptr MaskNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc source*(self: MaskNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_mask_node_get_source(cast[ptr MaskNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

type
  NglRenderer* = ref object of Renderer
  NglRenderer00* = object of Renderer00

proc gsk_ngl_renderer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NglRenderer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gsk_ngl_renderer_new(): ptr NglRenderer00 {.
    importc, libprag.}

proc newNglRenderer*(): NglRenderer =
  let gobj = gsk_ngl_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNglRenderer*(tdesc: typedesc): tdesc =
  assert(result is NglRenderer)
  let gobj = gsk_ngl_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNglRenderer*[T](result: var T) {.deprecated.} =
  assert(result is NglRenderer)
  let gobj = gsk_ngl_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  OpacityNode* = ref object of RenderNode
  OpacityNode00* = object of RenderNode00

proc gsk_opacity_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr OpacityNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: OpacityNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(OpacityNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_opacity_node_new(child: ptr RenderNode00; opacity: cfloat): ptr OpacityNode00 {.
    importc, libprag.}

proc newOpacityNode*(child: RenderNode; opacity: cfloat): OpacityNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_opacity_node_new(cast[ptr RenderNode00](child.impl), opacity)

proc newOpacityNode*(tdesc: typedesc; child: RenderNode; opacity: cfloat): tdesc =
  assert(result is OpacityNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_opacity_node_new(cast[ptr RenderNode00](child.impl), opacity)

proc initOpacityNode*[T](result: var T; child: RenderNode; opacity: cfloat) {.deprecated.} =
  assert(result is OpacityNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_opacity_node_new(cast[ptr RenderNode00](child.impl), opacity)

proc gsk_opacity_node_get_child(self: ptr OpacityNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: OpacityNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_opacity_node_get_child(cast[ptr OpacityNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc child*(self: OpacityNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_opacity_node_get_child(cast[ptr OpacityNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_opacity_node_get_opacity(self: ptr OpacityNode00): cfloat {.
    importc, libprag.}

proc getOpacity*(self: OpacityNode): cfloat =
  gsk_opacity_node_get_opacity(cast[ptr OpacityNode00](self.impl))

proc opacity*(self: OpacityNode): cfloat =
  gsk_opacity_node_get_opacity(cast[ptr OpacityNode00](self.impl))

type
  OutsetShadowNode* = ref object of RenderNode
  OutsetShadowNode00* = object of RenderNode00

proc gsk_outset_shadow_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr OutsetShadowNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: OutsetShadowNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(OutsetShadowNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_outset_shadow_node_new(outline: RoundedRect; color: gdk4.RGBA; dx: cfloat;
    dy: cfloat; spread: cfloat; blurRadius: cfloat): ptr OutsetShadowNode00 {.
    importc, libprag.}

proc newOutsetShadowNode*(outline: RoundedRect; color: gdk4.RGBA; dx: cfloat;
    dy: cfloat; spread: cfloat; blurRadius: cfloat): OutsetShadowNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_outset_shadow_node_new(outline, color, dx, dy, spread, blurRadius)

proc newOutsetShadowNode*(tdesc: typedesc; outline: RoundedRect; color: gdk4.RGBA; dx: cfloat;
    dy: cfloat; spread: cfloat; blurRadius: cfloat): tdesc =
  assert(result is OutsetShadowNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_outset_shadow_node_new(outline, color, dx, dy, spread, blurRadius)

proc initOutsetShadowNode*[T](result: var T; outline: RoundedRect; color: gdk4.RGBA; dx: cfloat;
    dy: cfloat; spread: cfloat; blurRadius: cfloat) {.deprecated.} =
  assert(result is OutsetShadowNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_outset_shadow_node_new(outline, color, dx, dy, spread, blurRadius)

proc gsk_outset_shadow_node_get_blur_radius(self: ptr OutsetShadowNode00): cfloat {.
    importc, libprag.}

proc getBlurRadius*(self: OutsetShadowNode): cfloat =
  gsk_outset_shadow_node_get_blur_radius(cast[ptr OutsetShadowNode00](self.impl))

proc blurRadius*(self: OutsetShadowNode): cfloat =
  gsk_outset_shadow_node_get_blur_radius(cast[ptr OutsetShadowNode00](self.impl))

proc gsk_outset_shadow_node_get_color(self: ptr OutsetShadowNode00): ptr gdk4.RGBA {.
    importc, libprag.}

proc getColor*(self: OutsetShadowNode): ptr gdk4.RGBA =
  gsk_outset_shadow_node_get_color(cast[ptr OutsetShadowNode00](self.impl))

proc color*(self: OutsetShadowNode): ptr gdk4.RGBA =
  gsk_outset_shadow_node_get_color(cast[ptr OutsetShadowNode00](self.impl))

proc gsk_outset_shadow_node_get_dx(self: ptr OutsetShadowNode00): cfloat {.
    importc, libprag.}

proc getDx*(self: OutsetShadowNode): cfloat =
  gsk_outset_shadow_node_get_dx(cast[ptr OutsetShadowNode00](self.impl))

proc dx*(self: OutsetShadowNode): cfloat =
  gsk_outset_shadow_node_get_dx(cast[ptr OutsetShadowNode00](self.impl))

proc gsk_outset_shadow_node_get_dy(self: ptr OutsetShadowNode00): cfloat {.
    importc, libprag.}

proc getDy*(self: OutsetShadowNode): cfloat =
  gsk_outset_shadow_node_get_dy(cast[ptr OutsetShadowNode00](self.impl))

proc dy*(self: OutsetShadowNode): cfloat =
  gsk_outset_shadow_node_get_dy(cast[ptr OutsetShadowNode00](self.impl))

proc gsk_outset_shadow_node_get_outline(self: ptr OutsetShadowNode00): ptr RoundedRect {.
    importc, libprag.}

proc getOutline*(self: OutsetShadowNode): ptr RoundedRect =
  gsk_outset_shadow_node_get_outline(cast[ptr OutsetShadowNode00](self.impl))

proc outline*(self: OutsetShadowNode): ptr RoundedRect =
  gsk_outset_shadow_node_get_outline(cast[ptr OutsetShadowNode00](self.impl))

proc gsk_outset_shadow_node_get_spread(self: ptr OutsetShadowNode00): cfloat {.
    importc, libprag.}

proc getSpread*(self: OutsetShadowNode): cfloat =
  gsk_outset_shadow_node_get_spread(cast[ptr OutsetShadowNode00](self.impl))

proc spread*(self: OutsetShadowNode): cfloat =
  gsk_outset_shadow_node_get_spread(cast[ptr OutsetShadowNode00](self.impl))

type
  ParseLocation00* {.pure.} = object
  ParseLocation* = ref object
    impl*: ptr ParseLocation00
    ignoreFinalizer*: bool

type
  ParseErrorFunc* = proc (start: ptr ParseLocation00; `end`: ptr ParseLocation00; error: ptr glib.Error;
    userData: pointer) {.cdecl.}

proc gsk_render_node_deserialize(bytes: ptr glib.Bytes00; errorFunc: ParseErrorFunc;
    userData: pointer): ptr RenderNode00 {.
    importc, libprag.}

proc deserialize*(bytes: glib.Bytes; errorFunc: ParseErrorFunc;
    userData: pointer): RenderNode =
  let impl0 = gsk_render_node_deserialize(cast[ptr glib.Bytes00](bytes.impl), errorFunc, userData)
  if impl0.isNil:
    return nil
  fnew(result, generic_gsk_render_node_unref)
  result.impl = impl0

type
  PathBuilder00* {.pure.} = object
  PathBuilder* = ref object
    impl*: ptr PathBuilder00
    ignoreFinalizer*: bool

proc gsk_path_builder_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGskPathBuilder*(self: PathBuilder) =
  if not self.ignoreFinalizer:
    boxedFree(gsk_path_builder_get_type(), cast[ptr PathBuilder00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PathBuilder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gsk_path_builder_get_type(), cast[ptr PathBuilder00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PathBuilder) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGskPathBuilder)

proc gsk_path_builder_unref(self: ptr PathBuilder00) {.
    importc, libprag.}

proc unref*(self: PathBuilder) =
  gsk_path_builder_unref(cast[ptr PathBuilder00](self.impl))

proc finalizerunref*(self: PathBuilder) =
  if not self.ignoreFinalizer:
    gsk_path_builder_unref(cast[ptr PathBuilder00](self.impl))

proc gsk_path_builder_add_cairo_path(self: ptr PathBuilder00; path: ptr cairo.Path00) {.
    importc, libprag.}

proc addCairoPath*(self: PathBuilder; path: cairo.Path) =
  gsk_path_builder_add_cairo_path(cast[ptr PathBuilder00](self.impl), cast[ptr cairo.Path00](path.impl))

proc gsk_path_builder_add_circle(self: ptr PathBuilder00; center: graphene.Point;
    radius: cfloat) {.
    importc, libprag.}

proc addCircle*(self: PathBuilder; center: graphene.Point;
    radius: cfloat) =
  gsk_path_builder_add_circle(cast[ptr PathBuilder00](self.impl), center, radius)

proc gsk_path_builder_add_layout(self: ptr PathBuilder00; layout: ptr pango.Layout00) {.
    importc, libprag.}

proc addLayout*(self: PathBuilder; layout: pango.Layout) =
  gsk_path_builder_add_layout(cast[ptr PathBuilder00](self.impl), cast[ptr pango.Layout00](layout.impl))

proc gsk_path_builder_add_path(self: ptr PathBuilder00; path: ptr Path00) {.
    importc, libprag.}

proc addPath*(self: PathBuilder; path: Path) =
  gsk_path_builder_add_path(cast[ptr PathBuilder00](self.impl), cast[ptr Path00](path.impl))

proc gsk_path_builder_add_rect(self: ptr PathBuilder00; rect: graphene.Rect) {.
    importc, libprag.}

proc addRect*(self: PathBuilder; rect: graphene.Rect) =
  gsk_path_builder_add_rect(cast[ptr PathBuilder00](self.impl), rect)

proc gsk_path_builder_add_reverse_path(self: ptr PathBuilder00; path: ptr Path00) {.
    importc, libprag.}

proc addReversePath*(self: PathBuilder; path: Path) =
  gsk_path_builder_add_reverse_path(cast[ptr PathBuilder00](self.impl), cast[ptr Path00](path.impl))

proc gsk_path_builder_add_rounded_rect(self: ptr PathBuilder00; rect: RoundedRect) {.
    importc, libprag.}

proc addRoundedRect*(self: PathBuilder; rect: RoundedRect) =
  gsk_path_builder_add_rounded_rect(cast[ptr PathBuilder00](self.impl), rect)

proc gsk_path_builder_add_segment(self: ptr PathBuilder00; path: ptr Path00;
    start: ptr PathPoint00; `end`: ptr PathPoint00) {.
    importc, libprag.}

proc addSegment*(self: PathBuilder; path: Path; start: PathPoint;
    `end`: PathPoint) =
  gsk_path_builder_add_segment(cast[ptr PathBuilder00](self.impl), cast[ptr Path00](path.impl), cast[ptr PathPoint00](start.impl), cast[ptr PathPoint00](`end`.impl))

proc gsk_path_builder_arc_to(self: ptr PathBuilder00; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat) {.
    importc, libprag.}

proc arcTo*(self: PathBuilder; x1: cfloat; y1: cfloat; x2: cfloat;
    y2: cfloat) =
  gsk_path_builder_arc_to(cast[ptr PathBuilder00](self.impl), x1, y1, x2, y2)

proc gsk_path_builder_close(self: ptr PathBuilder00) {.
    importc, libprag.}

proc close*(self: PathBuilder) =
  gsk_path_builder_close(cast[ptr PathBuilder00](self.impl))

proc gsk_path_builder_conic_to(self: ptr PathBuilder00; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; weight: cfloat) {.
    importc, libprag.}

proc conicTo*(self: PathBuilder; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; weight: cfloat) =
  gsk_path_builder_conic_to(cast[ptr PathBuilder00](self.impl), x1, y1, x2, y2, weight)

proc gsk_path_builder_cubic_to(self: ptr PathBuilder00; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; x3: cfloat; y3: cfloat) {.
    importc, libprag.}

proc cubicTo*(self: PathBuilder; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; x3: cfloat; y3: cfloat) =
  gsk_path_builder_cubic_to(cast[ptr PathBuilder00](self.impl), x1, y1, x2, y2, x3, y3)

proc gsk_path_builder_get_current_point(self: ptr PathBuilder00): ptr graphene.Point {.
    importc, libprag.}

proc getCurrentPoint*(self: PathBuilder): ptr graphene.Point =
  gsk_path_builder_get_current_point(cast[ptr PathBuilder00](self.impl))

proc currentPoint*(self: PathBuilder): ptr graphene.Point =
  gsk_path_builder_get_current_point(cast[ptr PathBuilder00](self.impl))

proc gsk_path_builder_html_arc_to(self: ptr PathBuilder00; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; radius: cfloat) {.
    importc, libprag.}

proc htmlArcTo*(self: PathBuilder; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; radius: cfloat) =
  gsk_path_builder_html_arc_to(cast[ptr PathBuilder00](self.impl), x1, y1, x2, y2, radius)

proc gsk_path_builder_line_to(self: ptr PathBuilder00; x: cfloat; y: cfloat) {.
    importc, libprag.}

proc lineTo*(self: PathBuilder; x: cfloat; y: cfloat) =
  gsk_path_builder_line_to(cast[ptr PathBuilder00](self.impl), x, y)

proc gsk_path_builder_move_to(self: ptr PathBuilder00; x: cfloat; y: cfloat) {.
    importc, libprag.}

proc moveTo*(self: PathBuilder; x: cfloat; y: cfloat) =
  gsk_path_builder_move_to(cast[ptr PathBuilder00](self.impl), x, y)

proc gsk_path_builder_quad_to(self: ptr PathBuilder00; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat) {.
    importc, libprag.}

proc quadTo*(self: PathBuilder; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat) =
  gsk_path_builder_quad_to(cast[ptr PathBuilder00](self.impl), x1, y1, x2, y2)

proc gsk_path_builder_ref(self: ptr PathBuilder00): ptr PathBuilder00 {.
    importc, libprag.}

proc `ref`*(self: PathBuilder): PathBuilder =
  fnew(result, gBoxedFreeGskPathBuilder)
  result.impl = gsk_path_builder_ref(cast[ptr PathBuilder00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_path_builder_get_type(), result.impl))

proc gsk_path_builder_rel_arc_to(self: ptr PathBuilder00; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat) {.
    importc, libprag.}

proc relArcTo*(self: PathBuilder; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat) =
  gsk_path_builder_rel_arc_to(cast[ptr PathBuilder00](self.impl), x1, y1, x2, y2)

proc gsk_path_builder_rel_conic_to(self: ptr PathBuilder00; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; weight: cfloat) {.
    importc, libprag.}

proc relConicTo*(self: PathBuilder; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; weight: cfloat) =
  gsk_path_builder_rel_conic_to(cast[ptr PathBuilder00](self.impl), x1, y1, x2, y2, weight)

proc gsk_path_builder_rel_cubic_to(self: ptr PathBuilder00; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; x3: cfloat; y3: cfloat) {.
    importc, libprag.}

proc relCubicTo*(self: PathBuilder; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; x3: cfloat; y3: cfloat) =
  gsk_path_builder_rel_cubic_to(cast[ptr PathBuilder00](self.impl), x1, y1, x2, y2, x3, y3)

proc gsk_path_builder_rel_html_arc_to(self: ptr PathBuilder00; x1: cfloat;
    y1: cfloat; x2: cfloat; y2: cfloat; radius: cfloat) {.
    importc, libprag.}

proc relHtmlArcTo*(self: PathBuilder; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat; radius: cfloat) =
  gsk_path_builder_rel_html_arc_to(cast[ptr PathBuilder00](self.impl), x1, y1, x2, y2, radius)

proc gsk_path_builder_rel_line_to(self: ptr PathBuilder00; x: cfloat; y: cfloat) {.
    importc, libprag.}

proc relLineTo*(self: PathBuilder; x: cfloat; y: cfloat) =
  gsk_path_builder_rel_line_to(cast[ptr PathBuilder00](self.impl), x, y)

proc gsk_path_builder_rel_move_to(self: ptr PathBuilder00; x: cfloat; y: cfloat) {.
    importc, libprag.}

proc relMoveTo*(self: PathBuilder; x: cfloat; y: cfloat) =
  gsk_path_builder_rel_move_to(cast[ptr PathBuilder00](self.impl), x, y)

proc gsk_path_builder_rel_quad_to(self: ptr PathBuilder00; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat) {.
    importc, libprag.}

proc relQuadTo*(self: PathBuilder; x1: cfloat; y1: cfloat;
    x2: cfloat; y2: cfloat) =
  gsk_path_builder_rel_quad_to(cast[ptr PathBuilder00](self.impl), x1, y1, x2, y2)

proc gsk_path_builder_rel_svg_arc_to(self: ptr PathBuilder00; rx: cfloat;
    ry: cfloat; xAxisRotation: cfloat; largeArc: gboolean; positiveSweep: gboolean;
    x: cfloat; y: cfloat) {.
    importc, libprag.}

proc relSvgArcTo*(self: PathBuilder; rx: cfloat; ry: cfloat;
    xAxisRotation: cfloat; largeArc: bool; positiveSweep: bool; x: cfloat;
    y: cfloat) =
  gsk_path_builder_rel_svg_arc_to(cast[ptr PathBuilder00](self.impl), rx, ry, xAxisRotation, gboolean(largeArc), gboolean(positiveSweep), x, y)

proc gsk_path_builder_svg_arc_to(self: ptr PathBuilder00; rx: cfloat; ry: cfloat;
    xAxisRotation: cfloat; largeArc: gboolean; positiveSweep: gboolean; x: cfloat;
    y: cfloat) {.
    importc, libprag.}

proc svgArcTo*(self: PathBuilder; rx: cfloat; ry: cfloat;
    xAxisRotation: cfloat; largeArc: bool; positiveSweep: bool; x: cfloat;
    y: cfloat) =
  gsk_path_builder_svg_arc_to(cast[ptr PathBuilder00](self.impl), rx, ry, xAxisRotation, gboolean(largeArc), gboolean(positiveSweep), x, y)

proc gsk_path_builder_to_path(self: ptr PathBuilder00): ptr Path00 {.
    importc, libprag.}

proc toPath*(self: PathBuilder): Path =
  fnew(result, gBoxedFreeGskPath)
  result.impl = gsk_path_builder_to_path(cast[ptr PathBuilder00](self.impl))

proc gsk_path_builder_new(): ptr PathBuilder00 {.
    importc, libprag.}

proc newPathBuilder*(): PathBuilder =
  fnew(result, gBoxedFreeGskPathBuilder)
  result.impl = gsk_path_builder_new()

proc newPathBuilder*(tdesc: typedesc): tdesc =
  assert(result is PathBuilder)
  fnew(result, gBoxedFreeGskPathBuilder)
  result.impl = gsk_path_builder_new()

proc initPathBuilder*[T](result: var T) {.deprecated.} =
  assert(result is PathBuilder)
  fnew(result, gBoxedFreeGskPathBuilder)
  result.impl = gsk_path_builder_new()

type
  PathOperation* {.size: sizeof(cint), pure.} = enum
    move = 0
    close = 1
    line = 2
    quad = 3
    cubic = 4
    conic = 5

type
  PathForeachFunc* = proc (op: PathOperation; pts: graphene.Point; nPts: uint64; weight: cfloat;
    userData: pointer): gboolean {.cdecl.}

proc gsk_path_foreach(self: ptr Path00; flags: PathForeachFlags; `func`: PathForeachFunc;
    userData: pointer): gboolean {.
    importc, libprag.}

proc foreach*(self: Path; flags: PathForeachFlags; `func`: PathForeachFunc;
    userData: pointer): bool =
  toBool(gsk_path_foreach(cast[ptr Path00](self.impl), flags, `func`, userData))

type
  RadialGradientNode* = ref object of RenderNode
  RadialGradientNode00* = object of RenderNode00

proc gsk_radial_gradient_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr RadialGradientNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: RadialGradientNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RadialGradientNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_radial_gradient_node_new(bounds: graphene.Rect; center: graphene.Point;
    hradius: cfloat; vradius: cfloat; start: cfloat; `end`: cfloat; colorStops: ptr ColorStop;
    nColorStops: uint64): ptr RadialGradientNode00 {.
    importc, libprag.}

proc newRadialGradientNode*(bounds: graphene.Rect; center: graphene.Point;
    hradius: cfloat; vradius: cfloat; start: cfloat; `end`: cfloat; colorStops: ptr ColorStop;
    nColorStops: uint64): RadialGradientNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_radial_gradient_node_new(bounds, center, hradius, vradius, start, `end`, colorStops, nColorStops)

proc newRadialGradientNode*(tdesc: typedesc; bounds: graphene.Rect; center: graphene.Point;
    hradius: cfloat; vradius: cfloat; start: cfloat; `end`: cfloat; colorStops: ptr ColorStop;
    nColorStops: uint64): tdesc =
  assert(result is RadialGradientNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_radial_gradient_node_new(bounds, center, hradius, vradius, start, `end`, colorStops, nColorStops)

proc initRadialGradientNode*[T](result: var T; bounds: graphene.Rect; center: graphene.Point;
    hradius: cfloat; vradius: cfloat; start: cfloat; `end`: cfloat; colorStops: ptr ColorStop;
    nColorStops: uint64) {.deprecated.} =
  assert(result is RadialGradientNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_radial_gradient_node_new(bounds, center, hradius, vradius, start, `end`, colorStops, nColorStops)

proc gsk_radial_gradient_node_get_center(self: ptr RadialGradientNode00): ptr graphene.Point {.
    importc, libprag.}

proc getCenter*(self: RadialGradientNode): ptr graphene.Point =
  gsk_radial_gradient_node_get_center(cast[ptr RadialGradientNode00](self.impl))

proc center*(self: RadialGradientNode): ptr graphene.Point =
  gsk_radial_gradient_node_get_center(cast[ptr RadialGradientNode00](self.impl))

proc gsk_radial_gradient_node_get_color_stops(self: ptr RadialGradientNode00;
    nStops: var uint64): ptr ColorStop {.
    importc, libprag.}

proc getColorStops*(self: RadialGradientNode; nStops: var uint64 = cast[var uint64](nil)): ptr ColorStop =
  gsk_radial_gradient_node_get_color_stops(cast[ptr RadialGradientNode00](self.impl), nStops)

proc gsk_radial_gradient_node_get_end(self: ptr RadialGradientNode00): cfloat {.
    importc, libprag.}

proc getEnd*(self: RadialGradientNode): cfloat =
  gsk_radial_gradient_node_get_end(cast[ptr RadialGradientNode00](self.impl))

proc gsk_radial_gradient_node_get_hradius(self: ptr RadialGradientNode00): cfloat {.
    importc, libprag.}

proc getHradius*(self: RadialGradientNode): cfloat =
  gsk_radial_gradient_node_get_hradius(cast[ptr RadialGradientNode00](self.impl))

proc hradius*(self: RadialGradientNode): cfloat =
  gsk_radial_gradient_node_get_hradius(cast[ptr RadialGradientNode00](self.impl))

proc gsk_radial_gradient_node_get_n_color_stops(self: ptr RadialGradientNode00): uint64 {.
    importc, libprag.}

proc getNColorStops*(self: RadialGradientNode): uint64 =
  gsk_radial_gradient_node_get_n_color_stops(cast[ptr RadialGradientNode00](self.impl))

proc nColorStops*(self: RadialGradientNode): uint64 =
  gsk_radial_gradient_node_get_n_color_stops(cast[ptr RadialGradientNode00](self.impl))

proc gsk_radial_gradient_node_get_start(self: ptr RadialGradientNode00): cfloat {.
    importc, libprag.}

proc getStart*(self: RadialGradientNode): cfloat =
  gsk_radial_gradient_node_get_start(cast[ptr RadialGradientNode00](self.impl))

proc start*(self: RadialGradientNode): cfloat =
  gsk_radial_gradient_node_get_start(cast[ptr RadialGradientNode00](self.impl))

proc gsk_radial_gradient_node_get_vradius(self: ptr RadialGradientNode00): cfloat {.
    importc, libprag.}

proc getVradius*(self: RadialGradientNode): cfloat =
  gsk_radial_gradient_node_get_vradius(cast[ptr RadialGradientNode00](self.impl))

proc vradius*(self: RadialGradientNode): cfloat =
  gsk_radial_gradient_node_get_vradius(cast[ptr RadialGradientNode00](self.impl))

type
  RepeatNode* = ref object of RenderNode
  RepeatNode00* = object of RenderNode00

proc gsk_repeat_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr RepeatNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: RepeatNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RepeatNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_repeat_node_new(bounds: graphene.Rect; child: ptr RenderNode00;
    childBounds: graphene.Rect): ptr RepeatNode00 {.
    importc, libprag.}

proc newRepeatNode*(bounds: graphene.Rect; child: RenderNode; childBounds: graphene.Rect = cast[var graphene.Rect](nil)): RepeatNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeat_node_new(bounds, cast[ptr RenderNode00](child.impl), childBounds)

proc newRepeatNode*(tdesc: typedesc; bounds: graphene.Rect; child: RenderNode; childBounds: graphene.Rect = cast[var graphene.Rect](nil)): tdesc =
  assert(result is RepeatNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeat_node_new(bounds, cast[ptr RenderNode00](child.impl), childBounds)

proc initRepeatNode*[T](result: var T; bounds: graphene.Rect; child: RenderNode; childBounds: graphene.Rect = cast[var graphene.Rect](nil)) {.deprecated.} =
  assert(result is RepeatNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeat_node_new(bounds, cast[ptr RenderNode00](child.impl), childBounds)

proc gsk_repeat_node_get_child(self: ptr RepeatNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: RepeatNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeat_node_get_child(cast[ptr RepeatNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc child*(self: RepeatNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeat_node_get_child(cast[ptr RepeatNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_repeat_node_get_child_bounds(self: ptr RepeatNode00): ptr graphene.Rect {.
    importc, libprag.}

proc getChildBounds*(self: RepeatNode): ptr graphene.Rect =
  gsk_repeat_node_get_child_bounds(cast[ptr RepeatNode00](self.impl))

proc childBounds*(self: RepeatNode): ptr graphene.Rect =
  gsk_repeat_node_get_child_bounds(cast[ptr RepeatNode00](self.impl))

type
  RepeatingLinearGradientNode* = ref object of RenderNode
  RepeatingLinearGradientNode00* = object of RenderNode00

proc gsk_repeating_linear_gradient_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr RepeatingLinearGradientNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: RepeatingLinearGradientNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RepeatingLinearGradientNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_repeating_linear_gradient_node_new(bounds: graphene.Rect; start: graphene.Point;
    `end`: graphene.Point; colorStops: ptr ColorStop; nColorStops: uint64): ptr RepeatingLinearGradientNode00 {.
    importc, libprag.}

proc newRepeatingLinearGradientNode*(bounds: graphene.Rect; start: graphene.Point;
    `end`: graphene.Point; colorStops: ptr ColorStop; nColorStops: uint64): RepeatingLinearGradientNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeating_linear_gradient_node_new(bounds, start, `end`, colorStops, nColorStops)

proc newRepeatingLinearGradientNode*(tdesc: typedesc; bounds: graphene.Rect; start: graphene.Point;
    `end`: graphene.Point; colorStops: ptr ColorStop; nColorStops: uint64): tdesc =
  assert(result is RepeatingLinearGradientNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeating_linear_gradient_node_new(bounds, start, `end`, colorStops, nColorStops)

proc initRepeatingLinearGradientNode*[T](result: var T; bounds: graphene.Rect; start: graphene.Point;
    `end`: graphene.Point; colorStops: ptr ColorStop; nColorStops: uint64) {.deprecated.} =
  assert(result is RepeatingLinearGradientNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeating_linear_gradient_node_new(bounds, start, `end`, colorStops, nColorStops)

type
  RepeatingRadialGradientNode* = ref object of RenderNode
  RepeatingRadialGradientNode00* = object of RenderNode00

proc gsk_repeating_radial_gradient_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr RepeatingRadialGradientNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: RepeatingRadialGradientNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RepeatingRadialGradientNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_repeating_radial_gradient_node_new(bounds: graphene.Rect; center: graphene.Point;
    hradius: cfloat; vradius: cfloat; start: cfloat; `end`: cfloat; colorStops: ptr ColorStop;
    nColorStops: uint64): ptr RepeatingRadialGradientNode00 {.
    importc, libprag.}

proc newRepeatingRadialGradientNode*(bounds: graphene.Rect; center: graphene.Point;
    hradius: cfloat; vradius: cfloat; start: cfloat; `end`: cfloat; colorStops: ptr ColorStop;
    nColorStops: uint64): RepeatingRadialGradientNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeating_radial_gradient_node_new(bounds, center, hradius, vradius, start, `end`, colorStops, nColorStops)

proc newRepeatingRadialGradientNode*(tdesc: typedesc; bounds: graphene.Rect; center: graphene.Point;
    hradius: cfloat; vradius: cfloat; start: cfloat; `end`: cfloat; colorStops: ptr ColorStop;
    nColorStops: uint64): tdesc =
  assert(result is RepeatingRadialGradientNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeating_radial_gradient_node_new(bounds, center, hradius, vradius, start, `end`, colorStops, nColorStops)

proc initRepeatingRadialGradientNode*[T](result: var T; bounds: graphene.Rect; center: graphene.Point;
    hradius: cfloat; vradius: cfloat; start: cfloat; `end`: cfloat; colorStops: ptr ColorStop;
    nColorStops: uint64) {.deprecated.} =
  assert(result is RepeatingRadialGradientNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_repeating_radial_gradient_node_new(bounds, center, hradius, vradius, start, `end`, colorStops, nColorStops)

type
  RoundedClipNode* = ref object of RenderNode
  RoundedClipNode00* = object of RenderNode00

proc gsk_rounded_clip_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr RoundedClipNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: RoundedClipNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RoundedClipNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_rounded_clip_node_new(child: ptr RenderNode00; clip: RoundedRect): ptr RoundedClipNode00 {.
    importc, libprag.}

proc newRoundedClipNode*(child: RenderNode; clip: RoundedRect): RoundedClipNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_rounded_clip_node_new(cast[ptr RenderNode00](child.impl), clip)

proc newRoundedClipNode*(tdesc: typedesc; child: RenderNode; clip: RoundedRect): tdesc =
  assert(result is RoundedClipNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_rounded_clip_node_new(cast[ptr RenderNode00](child.impl), clip)

proc initRoundedClipNode*[T](result: var T; child: RenderNode; clip: RoundedRect) {.deprecated.} =
  assert(result is RoundedClipNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_rounded_clip_node_new(cast[ptr RenderNode00](child.impl), clip)

proc gsk_rounded_clip_node_get_child(self: ptr RoundedClipNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: RoundedClipNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_rounded_clip_node_get_child(cast[ptr RoundedClipNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc child*(self: RoundedClipNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_rounded_clip_node_get_child(cast[ptr RoundedClipNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_rounded_clip_node_get_clip(self: ptr RoundedClipNode00): ptr RoundedRect {.
    importc, libprag.}

proc getClip*(self: RoundedClipNode): ptr RoundedRect =
  gsk_rounded_clip_node_get_clip(cast[ptr RoundedClipNode00](self.impl))

proc clip*(self: RoundedClipNode): ptr RoundedRect =
  gsk_rounded_clip_node_get_clip(cast[ptr RoundedClipNode00](self.impl))

type
  ScalingFilter* {.size: sizeof(cint), pure.} = enum
    linear = 0
    nearest = 1
    trilinear = 2

type
  SerializationError* {.size: sizeof(cint), pure.} = enum
    unsupportedFormat = 0
    unsupportedVersion = 1
    invalidData = 2

type
  ShaderArgsBuilder00* {.pure.} = object
  ShaderArgsBuilder* = ref object
    impl*: ptr ShaderArgsBuilder00
    ignoreFinalizer*: bool

proc gsk_shader_args_builder_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGskShaderArgsBuilder*(self: ShaderArgsBuilder) =
  if not self.ignoreFinalizer:
    boxedFree(gsk_shader_args_builder_get_type(), cast[ptr ShaderArgsBuilder00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ShaderArgsBuilder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gsk_shader_args_builder_get_type(), cast[ptr ShaderArgsBuilder00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ShaderArgsBuilder) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGskShaderArgsBuilder)

proc gsk_shader_args_builder_unref(self: ptr ShaderArgsBuilder00) {.
    importc, libprag.}

proc unref*(self: ShaderArgsBuilder) =
  gsk_shader_args_builder_unref(cast[ptr ShaderArgsBuilder00](self.impl))

proc finalizerunref*(self: ShaderArgsBuilder) =
  if not self.ignoreFinalizer:
    gsk_shader_args_builder_unref(cast[ptr ShaderArgsBuilder00](self.impl))

proc gsk_shader_args_builder_ref(self: ptr ShaderArgsBuilder00): ptr ShaderArgsBuilder00 {.
    importc, libprag.}

proc `ref`*(self: ShaderArgsBuilder): ShaderArgsBuilder =
  fnew(result, gBoxedFreeGskShaderArgsBuilder)
  result.impl = gsk_shader_args_builder_ref(cast[ptr ShaderArgsBuilder00](self.impl))

proc gsk_shader_args_builder_set_bool(self: ptr ShaderArgsBuilder00; idx: int32;
    value: gboolean) {.
    importc, libprag.}

proc setBool*(self: ShaderArgsBuilder; idx: int;
    value: bool) =
  gsk_shader_args_builder_set_bool(cast[ptr ShaderArgsBuilder00](self.impl), int32(idx), gboolean(value))

proc gsk_shader_args_builder_set_float(self: ptr ShaderArgsBuilder00; idx: int32;
    value: cfloat) {.
    importc, libprag.}

proc setFloat*(self: ShaderArgsBuilder; idx: int;
    value: cfloat) =
  gsk_shader_args_builder_set_float(cast[ptr ShaderArgsBuilder00](self.impl), int32(idx), value)

proc gsk_shader_args_builder_set_int(self: ptr ShaderArgsBuilder00; idx: int32;
    value: int32) {.
    importc, libprag.}

proc setInt*(self: ShaderArgsBuilder; idx: int; value: int) =
  gsk_shader_args_builder_set_int(cast[ptr ShaderArgsBuilder00](self.impl), int32(idx), int32(value))

proc gsk_shader_args_builder_set_uint(self: ptr ShaderArgsBuilder00; idx: int32;
    value: uint32) {.
    importc, libprag.}

proc setUint*(self: ShaderArgsBuilder; idx: int;
    value: int) =
  gsk_shader_args_builder_set_uint(cast[ptr ShaderArgsBuilder00](self.impl), int32(idx), uint32(value))

proc gsk_shader_args_builder_set_vec2(self: ptr ShaderArgsBuilder00; idx: int32;
    value: graphene.Vec2) {.
    importc, libprag.}

proc setVec2*(self: ShaderArgsBuilder; idx: int;
    value: graphene.Vec2) =
  gsk_shader_args_builder_set_vec2(cast[ptr ShaderArgsBuilder00](self.impl), int32(idx), value)

proc gsk_shader_args_builder_set_vec3(self: ptr ShaderArgsBuilder00; idx: int32;
    value: graphene.Vec3) {.
    importc, libprag.}

proc setVec3*(self: ShaderArgsBuilder; idx: int;
    value: graphene.Vec3) =
  gsk_shader_args_builder_set_vec3(cast[ptr ShaderArgsBuilder00](self.impl), int32(idx), value)

proc gsk_shader_args_builder_set_vec4(self: ptr ShaderArgsBuilder00; idx: int32;
    value: graphene.Vec4) {.
    importc, libprag.}

proc setVec4*(self: ShaderArgsBuilder; idx: int;
    value: graphene.Vec4) =
  gsk_shader_args_builder_set_vec4(cast[ptr ShaderArgsBuilder00](self.impl), int32(idx), value)

proc gsk_shader_args_builder_to_args(self: ptr ShaderArgsBuilder00): ptr glib.Bytes00 {.
    importc, libprag.}

proc toArgs*(self: ShaderArgsBuilder): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gsk_shader_args_builder_to_args(cast[ptr ShaderArgsBuilder00](self.impl))

proc gsk_shader_args_builder_new(shader: ptr GLShader00; initialValues: ptr glib.Bytes00): ptr ShaderArgsBuilder00 {.
    importc, libprag.}

proc newShaderArgsBuilder*(shader: GLShader; initialValues: glib.Bytes = nil): ShaderArgsBuilder =
  fnew(result, gBoxedFreeGskShaderArgsBuilder)
  result.impl = gsk_shader_args_builder_new(cast[ptr GLShader00](shader.impl), if initialValues.isNil: nil else: cast[ptr glib.Bytes00](initialValues.impl))

proc newShaderArgsBuilder*(tdesc: typedesc; shader: GLShader; initialValues: glib.Bytes = nil): tdesc =
  assert(result is ShaderArgsBuilder)
  fnew(result, gBoxedFreeGskShaderArgsBuilder)
  result.impl = gsk_shader_args_builder_new(cast[ptr GLShader00](shader.impl), if initialValues.isNil: nil else: cast[ptr glib.Bytes00](initialValues.impl))

proc initShaderArgsBuilder*[T](result: var T; shader: GLShader; initialValues: glib.Bytes = nil) {.deprecated.} =
  assert(result is ShaderArgsBuilder)
  fnew(result, gBoxedFreeGskShaderArgsBuilder)
  result.impl = gsk_shader_args_builder_new(cast[ptr GLShader00](shader.impl), if initialValues.isNil: nil else: cast[ptr glib.Bytes00](initialValues.impl))

type
  Shadow* {.pure, byRef.} = object
    color*: gdk4.RGBA
    dx*: cfloat
    dy*: cfloat
    radius*: cfloat

type
  ShadowNode* = ref object of RenderNode
  ShadowNode00* = object of RenderNode00

proc gsk_shadow_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr ShadowNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: ShadowNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ShadowNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_shadow_node_new(child: ptr RenderNode00; shadows: ptr Shadow; nShadows: uint64): ptr ShadowNode00 {.
    importc, libprag.}

proc newShadowNode*(child: RenderNode; shadows: ptr Shadow; nShadows: uint64): ShadowNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_shadow_node_new(cast[ptr RenderNode00](child.impl), shadows, nShadows)

proc newShadowNode*(tdesc: typedesc; child: RenderNode; shadows: ptr Shadow; nShadows: uint64): tdesc =
  assert(result is ShadowNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_shadow_node_new(cast[ptr RenderNode00](child.impl), shadows, nShadows)

proc initShadowNode*[T](result: var T; child: RenderNode; shadows: ptr Shadow; nShadows: uint64) {.deprecated.} =
  assert(result is ShadowNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_shadow_node_new(cast[ptr RenderNode00](child.impl), shadows, nShadows)

proc gsk_shadow_node_get_child(self: ptr ShadowNode00): ptr RenderNode00 {.
    importc, libprag.}

proc shadowNodeGetChild*(self: ShadowNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_shadow_node_get_child(cast[ptr ShadowNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_shadow_node_get_n_shadows(self: ptr ShadowNode00): uint64 {.
    importc, libprag.}

proc getNShadows*(self: ShadowNode): uint64 =
  gsk_shadow_node_get_n_shadows(cast[ptr ShadowNode00](self.impl))

proc nShadows*(self: ShadowNode): uint64 =
  gsk_shadow_node_get_n_shadows(cast[ptr ShadowNode00](self.impl))

proc gsk_shadow_node_get_shadow(self: ptr ShadowNode00; i: uint64): ptr Shadow {.
    importc, libprag.}

proc getShadow*(self: ShadowNode; i: uint64): ptr Shadow =
  gsk_shadow_node_get_shadow(cast[ptr ShadowNode00](self.impl), i)

type
  StrokeNode* = ref object of RenderNode
  StrokeNode00* = object of RenderNode00

proc gsk_stroke_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr StrokeNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: StrokeNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StrokeNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_stroke_node_new(child: ptr RenderNode00; path: ptr Path00; stroke: ptr Stroke00): ptr StrokeNode00 {.
    importc, libprag.}

proc newStrokeNode*(child: RenderNode; path: Path; stroke: Stroke): StrokeNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_stroke_node_new(cast[ptr RenderNode00](child.impl), cast[ptr Path00](path.impl), cast[ptr Stroke00](stroke.impl))

proc newStrokeNode*(tdesc: typedesc; child: RenderNode; path: Path; stroke: Stroke): tdesc =
  assert(result is StrokeNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_stroke_node_new(cast[ptr RenderNode00](child.impl), cast[ptr Path00](path.impl), cast[ptr Stroke00](stroke.impl))

proc initStrokeNode*[T](result: var T; child: RenderNode; path: Path; stroke: Stroke) {.deprecated.} =
  assert(result is StrokeNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_stroke_node_new(cast[ptr RenderNode00](child.impl), cast[ptr Path00](path.impl), cast[ptr Stroke00](stroke.impl))

proc gsk_stroke_node_get_child(self: ptr StrokeNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: StrokeNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_stroke_node_get_child(cast[ptr StrokeNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc child*(self: StrokeNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_stroke_node_get_child(cast[ptr StrokeNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_stroke_node_get_path(self: ptr StrokeNode00): ptr Path00 {.
    importc, libprag.}

proc getPath*(self: StrokeNode): Path =
  fnew(result, gBoxedFreeGskPath)
  result.impl = gsk_stroke_node_get_path(cast[ptr StrokeNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_path_get_type(), result.impl))

proc path*(self: StrokeNode): Path =
  fnew(result, gBoxedFreeGskPath)
  result.impl = gsk_stroke_node_get_path(cast[ptr StrokeNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_path_get_type(), result.impl))

proc gsk_stroke_node_get_stroke(self: ptr StrokeNode00): ptr Stroke00 {.
    importc, libprag.}

proc getStroke*(self: StrokeNode): Stroke =
  fnew(result, gBoxedFreeGskStroke)
  result.impl = gsk_stroke_node_get_stroke(cast[ptr StrokeNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_stroke_get_type(), result.impl))

proc stroke*(self: StrokeNode): Stroke =
  fnew(result, gBoxedFreeGskStroke)
  result.impl = gsk_stroke_node_get_stroke(cast[ptr StrokeNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_stroke_get_type(), result.impl))

type
  SubsurfaceNode* = ref object of RenderNode
  SubsurfaceNode00* = object of RenderNode00

proc gsk_subsurface_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr SubsurfaceNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: SubsurfaceNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SubsurfaceNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_subsurface_node_get_child(self: ptr SubsurfaceNode00): ptr RenderNode00 {.
    importc, libprag.}

proc getChild*(self: SubsurfaceNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_subsurface_node_get_child(cast[ptr SubsurfaceNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc child*(self: SubsurfaceNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_subsurface_node_get_child(cast[ptr SubsurfaceNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

type
  TextNode* = ref object of RenderNode
  TextNode00* = object of RenderNode00

proc gsk_text_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr TextNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: TextNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TextNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_text_node_new(font: ptr pango.Font00; glyphs: ptr pango.GlyphString00;
    color: gdk4.RGBA; offset: graphene.Point): ptr TextNode00 {.
    importc, libprag.}

proc newTextNode*(font: pango.Font; glyphs: pango.GlyphString; color: gdk4.RGBA;
    offset: graphene.Point): TextNode =
  let impl0 = gsk_text_node_new(cast[ptr pango.Font00](font.impl), cast[ptr pango.GlyphString00](glyphs.impl), color, offset)
  if impl0.isNil:
    return nil
  fnew(result, generic_gsk_render_node_unref)
  result.impl = impl0

proc newTextNode*(tdesc: typedesc; font: pango.Font; glyphs: pango.GlyphString; color: gdk4.RGBA;
    offset: graphene.Point): tdesc =
  assert(result is TextNode)
  let impl0 = gsk_text_node_new(cast[ptr pango.Font00](font.impl), cast[ptr pango.GlyphString00](glyphs.impl), color, offset)
  if impl0.isNil:
    return nil
  fnew(result, generic_gsk_render_node_unref)
  result.impl = impl0

proc initTextNode*[T](result: var T; font: pango.Font; glyphs: pango.GlyphString; color: gdk4.RGBA;
    offset: graphene.Point) {.deprecated.} =
  assert(result is TextNode)
  let impl0 = gsk_text_node_new(cast[ptr pango.Font00](font.impl), cast[ptr pango.GlyphString00](glyphs.impl), color, offset)
  if impl0.isNil:
    return nil
  fnew(result, generic_gsk_render_node_unref)
  result.impl = impl0

proc gsk_text_node_get_color(self: ptr TextNode00): ptr gdk4.RGBA {.
    importc, libprag.}

proc getColor*(self: TextNode): ptr gdk4.RGBA =
  gsk_text_node_get_color(cast[ptr TextNode00](self.impl))

proc color*(self: TextNode): ptr gdk4.RGBA =
  gsk_text_node_get_color(cast[ptr TextNode00](self.impl))

proc gsk_text_node_get_font(self: ptr TextNode00): ptr pango.Font00 {.
    importc, libprag.}

proc getFont*(self: TextNode): pango.Font =
  let gobj = gsk_text_node_get_font(cast[ptr TextNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc font*(self: TextNode): pango.Font =
  let gobj = gsk_text_node_get_font(cast[ptr TextNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gsk_text_node_get_glyphs(self: ptr TextNode00; nGlyphs: var uint32): ptr pango.GlyphInfo {.
    importc, libprag.}

proc getGlyphs*(self: TextNode; nGlyphs: var int = cast[var int](nil)): ptr pango.GlyphInfo =
  var nGlyphs_00: uint32
  result = gsk_text_node_get_glyphs(cast[ptr TextNode00](self.impl), nGlyphs_00)
  if nGlyphs.addr != nil:
    nGlyphs = int(nGlyphs_00)

proc gsk_text_node_get_num_glyphs(self: ptr TextNode00): uint32 {.
    importc, libprag.}

proc getNumGlyphs*(self: TextNode): int =
  int(gsk_text_node_get_num_glyphs(cast[ptr TextNode00](self.impl)))

proc numGlyphs*(self: TextNode): int =
  int(gsk_text_node_get_num_glyphs(cast[ptr TextNode00](self.impl)))

proc gsk_text_node_get_offset(self: ptr TextNode00): ptr graphene.Point {.
    importc, libprag.}

proc getOffset*(self: TextNode): ptr graphene.Point =
  gsk_text_node_get_offset(cast[ptr TextNode00](self.impl))

proc offset*(self: TextNode): ptr graphene.Point =
  gsk_text_node_get_offset(cast[ptr TextNode00](self.impl))

proc gsk_text_node_has_color_glyphs(self: ptr TextNode00): gboolean {.
    importc, libprag.}

proc hasColorGlyphs*(self: TextNode): bool =
  toBool(gsk_text_node_has_color_glyphs(cast[ptr TextNode00](self.impl)))

type
  TextureNode* = ref object of RenderNode
  TextureNode00* = object of RenderNode00

proc gsk_texture_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr TextureNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: TextureNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TextureNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_texture_node_new(texture: ptr gdk4.Texture00; bounds: graphene.Rect): ptr TextureNode00 {.
    importc, libprag.}

proc newTextureNode*(texture: gdk4.Texture; bounds: graphene.Rect): TextureNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_texture_node_new(cast[ptr gdk4.Texture00](texture.impl), bounds)

proc newTextureNode*(tdesc: typedesc; texture: gdk4.Texture; bounds: graphene.Rect): tdesc =
  assert(result is TextureNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_texture_node_new(cast[ptr gdk4.Texture00](texture.impl), bounds)

proc initTextureNode*[T](result: var T; texture: gdk4.Texture; bounds: graphene.Rect) {.deprecated.} =
  assert(result is TextureNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_texture_node_new(cast[ptr gdk4.Texture00](texture.impl), bounds)

proc gsk_texture_node_get_texture(self: ptr TextureNode00): ptr gdk4.Texture00 {.
    importc, libprag.}

proc getTexture*(self: TextureNode): gdk4.Texture =
  let gobj = gsk_texture_node_get_texture(cast[ptr TextureNode00](self.impl))
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

proc texture*(self: TextureNode): gdk4.Texture =
  let gobj = gsk_texture_node_get_texture(cast[ptr TextureNode00](self.impl))
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

type
  TextureScaleNode* = ref object of RenderNode
  TextureScaleNode00* = object of RenderNode00

proc gsk_texture_scale_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr TextureScaleNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: TextureScaleNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TextureScaleNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_texture_scale_node_new(texture: ptr gdk4.Texture00; bounds: graphene.Rect;
    filter: ScalingFilter): ptr TextureScaleNode00 {.
    importc, libprag.}

proc newTextureScaleNode*(texture: gdk4.Texture; bounds: graphene.Rect;
    filter: ScalingFilter): TextureScaleNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_texture_scale_node_new(cast[ptr gdk4.Texture00](texture.impl), bounds, filter)

proc newTextureScaleNode*(tdesc: typedesc; texture: gdk4.Texture; bounds: graphene.Rect;
    filter: ScalingFilter): tdesc =
  assert(result is TextureScaleNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_texture_scale_node_new(cast[ptr gdk4.Texture00](texture.impl), bounds, filter)

proc initTextureScaleNode*[T](result: var T; texture: gdk4.Texture; bounds: graphene.Rect;
    filter: ScalingFilter) {.deprecated.} =
  assert(result is TextureScaleNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_texture_scale_node_new(cast[ptr gdk4.Texture00](texture.impl), bounds, filter)

proc gsk_texture_scale_node_get_filter(self: ptr TextureScaleNode00): ScalingFilter {.
    importc, libprag.}

proc getFilter*(self: TextureScaleNode): ScalingFilter =
  gsk_texture_scale_node_get_filter(cast[ptr TextureScaleNode00](self.impl))

proc filter*(self: TextureScaleNode): ScalingFilter =
  gsk_texture_scale_node_get_filter(cast[ptr TextureScaleNode00](self.impl))

proc gsk_texture_scale_node_get_texture(self: ptr TextureScaleNode00): ptr gdk4.Texture00 {.
    importc, libprag.}

proc getTexture*(self: TextureScaleNode): gdk4.Texture =
  let gobj = gsk_texture_scale_node_get_texture(cast[ptr TextureScaleNode00](self.impl))
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

proc texture*(self: TextureScaleNode): gdk4.Texture =
  let gobj = gsk_texture_scale_node_get_texture(cast[ptr TextureScaleNode00](self.impl))
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

type
  Transform00* {.pure.} = object
  Transform* = ref object
    impl*: ptr Transform00
    ignoreFinalizer*: bool

proc gsk_transform_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGskTransform*(self: Transform) =
  if not self.ignoreFinalizer:
    boxedFree(gsk_transform_get_type(), cast[ptr Transform00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Transform()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gsk_transform_get_type(), cast[ptr Transform00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Transform) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGskTransform)

proc gsk_transform_unref(self: ptr Transform00) {.
    importc, libprag.}

proc unref*(self: Transform) =
  gsk_transform_unref(cast[ptr Transform00](self.impl))

proc finalizerunref*(self: Transform) =
  if not self.ignoreFinalizer:
    gsk_transform_unref(cast[ptr Transform00](self.impl))

proc gsk_transform_equal(self: ptr Transform00; second: ptr Transform00): gboolean {.
    importc, libprag.}

proc equal*(self: Transform; second: Transform = nil): bool =
  toBool(gsk_transform_equal(cast[ptr Transform00](self.impl), if second.isNil: nil else: cast[ptr Transform00](second.impl)))

proc gsk_transform_invert(self: ptr Transform00): ptr Transform00 {.
    importc, libprag.}

proc invert*(self: Transform): Transform =
  let impl0 = gsk_transform_invert(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskTransform)
  result.impl = impl0

proc gsk_transform_matrix(self: ptr Transform00; matrix: graphene.Matrix): ptr Transform00 {.
    importc, libprag.}

proc matrix*(self: Transform; matrix: graphene.Matrix): Transform =
  fnew(result, gBoxedFreeGskTransform)
  result.impl = gsk_transform_matrix(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)), matrix)

proc gsk_transform_perspective(self: ptr Transform00; depth: cfloat): ptr Transform00 {.
    importc, libprag.}

proc perspective*(self: Transform; depth: cfloat): Transform =
  fnew(result, gBoxedFreeGskTransform)
  result.impl = gsk_transform_perspective(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)), depth)

proc gsk_transform_print(self: ptr Transform00; string: glib.String) {.
    importc, libprag.}

proc print*(self: Transform; string: glib.String) =
  gsk_transform_print(cast[ptr Transform00](self.impl), string)

proc gsk_transform_ref(self: ptr Transform00): ptr Transform00 {.
    importc, libprag.}

proc `ref`*(self: Transform): Transform =
  let impl0 = gsk_transform_ref(cast[ptr Transform00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskTransform)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_transform_get_type(), impl0))

proc gsk_transform_rotate(self: ptr Transform00; angle: cfloat): ptr Transform00 {.
    importc, libprag.}

proc rotate*(self: Transform; angle: cfloat): Transform =
  let impl0 = gsk_transform_rotate(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)), angle)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskTransform)
  result.impl = impl0

proc gsk_transform_rotate_3d(self: ptr Transform00; angle: cfloat; axis: graphene.Vec3): ptr Transform00 {.
    importc, libprag.}

proc rotate_3d*(self: Transform; angle: cfloat; axis: graphene.Vec3): Transform =
  let impl0 = gsk_transform_rotate_3d(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)), angle, axis)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskTransform)
  result.impl = impl0

proc gsk_transform_scale(self: ptr Transform00; factorX: cfloat; factorY: cfloat): ptr Transform00 {.
    importc, libprag.}

proc scale*(self: Transform; factorX: cfloat; factorY: cfloat): Transform =
  let impl0 = gsk_transform_scale(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)), factorX, factorY)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskTransform)
  result.impl = impl0

proc gsk_transform_scale_3d(self: ptr Transform00; factorX: cfloat; factorY: cfloat;
    factorZ: cfloat): ptr Transform00 {.
    importc, libprag.}

proc scale_3d*(self: Transform; factorX: cfloat; factorY: cfloat;
    factorZ: cfloat): Transform =
  let impl0 = gsk_transform_scale_3d(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)), factorX, factorY, factorZ)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskTransform)
  result.impl = impl0

proc gsk_transform_skew(self: ptr Transform00; skewX: cfloat; skewY: cfloat): ptr Transform00 {.
    importc, libprag.}

proc skew*(self: Transform; skewX: cfloat; skewY: cfloat): Transform =
  let impl0 = gsk_transform_skew(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)), skewX, skewY)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskTransform)
  result.impl = impl0

proc gsk_transform_to_2d(self: ptr Transform00; outXx: var cfloat; outYx: var cfloat;
    outXy: var cfloat; outYy: var cfloat; outDx: var cfloat; outDy: var cfloat) {.
    importc, libprag.}

proc to_2d*(self: Transform; outXx: var cfloat; outYx: var cfloat;
    outXy: var cfloat; outYy: var cfloat; outDx: var cfloat; outDy: var cfloat) =
  gsk_transform_to_2d(cast[ptr Transform00](self.impl), outXx, outYx, outXy, outYy, outDx, outDy)

proc gsk_transform_to_2d_components(self: ptr Transform00; outSkewX: var cfloat;
    outSkewY: var cfloat; outScaleX: var cfloat; outScaleY: var cfloat; outAngle: var cfloat;
    outDx: var cfloat; outDy: var cfloat) {.
    importc, libprag.}

proc to_2dComponents*(self: Transform; outSkewX: var cfloat;
    outSkewY: var cfloat; outScaleX: var cfloat; outScaleY: var cfloat; outAngle: var cfloat;
    outDx: var cfloat; outDy: var cfloat) =
  gsk_transform_to_2d_components(cast[ptr Transform00](self.impl), outSkewX, outSkewY, outScaleX, outScaleY, outAngle, outDx, outDy)

proc gsk_transform_to_affine(self: ptr Transform00; outScaleX: var cfloat;
    outScaleY: var cfloat; outDx: var cfloat; outDy: var cfloat) {.
    importc, libprag.}

proc toAffine*(self: Transform; outScaleX: var cfloat; outScaleY: var cfloat;
    outDx: var cfloat; outDy: var cfloat) =
  gsk_transform_to_affine(cast[ptr Transform00](self.impl), outScaleX, outScaleY, outDx, outDy)

proc gsk_transform_to_matrix(self: ptr Transform00; outMatrix: var graphene.Matrix) {.
    importc, libprag.}

proc toMatrix*(self: Transform; outMatrix: var graphene.Matrix) =
  gsk_transform_to_matrix(cast[ptr Transform00](self.impl), outMatrix)

proc toMatrix*(self: Transform): graphene.Matrix =
  gsk_transform_to_matrix(cast[ptr Transform00](self.impl), result)

proc gsk_transform_to_string(self: ptr Transform00): cstring {.
    importc, libprag.}

proc toString*(self: Transform): string =
  let resul0 = gsk_transform_to_string(cast[ptr Transform00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gsk_transform_to_translate(self: ptr Transform00; outDx: var cfloat;
    outDy: var cfloat) {.
    importc, libprag.}

proc toTranslate*(self: Transform; outDx: var cfloat; outDy: var cfloat) =
  gsk_transform_to_translate(cast[ptr Transform00](self.impl), outDx, outDy)

proc gsk_transform_transform(self: ptr Transform00; other: ptr Transform00): ptr Transform00 {.
    importc, libprag.}

proc transform*(self: Transform; other: Transform = nil): Transform =
  let impl0 = gsk_transform_transform(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)), if other.isNil: nil else: cast[ptr Transform00](other.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskTransform)
  result.impl = impl0

proc gsk_transform_transform_bounds(self: ptr Transform00; rect: graphene.Rect;
    outRect: var graphene.Rect) {.
    importc, libprag.}

proc transformBounds*(self: Transform; rect: graphene.Rect;
    outRect: var graphene.Rect) =
  gsk_transform_transform_bounds(cast[ptr Transform00](self.impl), rect, outRect)

proc gsk_transform_transform_point(self: ptr Transform00; point: graphene.Point;
    outPoint: var graphene.Point) {.
    importc, libprag.}

proc transformPoint*(self: Transform; point: graphene.Point;
    outPoint: var graphene.Point) =
  gsk_transform_transform_point(cast[ptr Transform00](self.impl), point, outPoint)

proc gsk_transform_translate(self: ptr Transform00; point: graphene.Point): ptr Transform00 {.
    importc, libprag.}

proc translate*(self: Transform; point: graphene.Point): Transform =
  let impl0 = gsk_transform_translate(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)), point)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskTransform)
  result.impl = impl0

proc gsk_transform_translate_3d(self: ptr Transform00; point: graphene.Point3D): ptr Transform00 {.
    importc, libprag.}

proc translate_3d*(self: Transform; point: graphene.Point3D): Transform =
  let impl0 = gsk_transform_translate_3d(cast[ptr Transform00](g_boxed_copy(gsk_transform_get_type(), self.impl)), point)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGskTransform)
  result.impl = impl0

proc gsk_transform_new(): ptr Transform00 {.
    importc, libprag.}

proc newTransform*(): Transform =
  fnew(result, gBoxedFreeGskTransform)
  result.impl = gsk_transform_new()

proc newTransform*(tdesc: typedesc): tdesc =
  assert(result is Transform)
  fnew(result, gBoxedFreeGskTransform)
  result.impl = gsk_transform_new()

proc initTransform*[T](result: var T) {.deprecated.} =
  assert(result is Transform)
  fnew(result, gBoxedFreeGskTransform)
  result.impl = gsk_transform_new()

proc gsk_transform_parse(string: cstring; outTransform: var ptr Transform00): gboolean {.
    importc, libprag.}

proc parse*(string: cstring; outTransform: var Transform): bool =
  fnew(outTransform, gBoxedFreeGskTransform)
  toBool(gsk_transform_parse(string, cast[var ptr Transform00](addr outTransform.impl)))

type
  TransformCategory* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    any = 1
    d3 = 2
    d2 = 3
    d2Affine = 4
    d2Translate = 5
    identity = 6

proc gsk_transform_get_category(self: ptr Transform00): TransformCategory {.
    importc, libprag.}

proc getCategory*(self: Transform): TransformCategory =
  gsk_transform_get_category(cast[ptr Transform00](self.impl))

proc category*(self: Transform): TransformCategory =
  gsk_transform_get_category(cast[ptr Transform00](self.impl))

type
  TransformNode* = ref object of RenderNode
  TransformNode00* = object of RenderNode00

proc gsk_transform_node_get_type*(): GType {.importc, libprag.}

proc gsk_render_node_unref*(self: ptr TransformNode00) {.importc, libprag.}

proc generic_gsk_render_node_unref*(self: TransformNode) =
  if not self.ignoreFinalizer:
    gsk_render_node_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TransformNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gsk_render_node_unref(self.impl)
      self.impl = nil

proc gsk_transform_node_new(child: ptr RenderNode00; transform: ptr Transform00): ptr TransformNode00 {.
    importc, libprag.}

proc newTransformNode*(child: RenderNode; transform: Transform): TransformNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_transform_node_new(cast[ptr RenderNode00](child.impl), cast[ptr Transform00](transform.impl))

proc newTransformNode*(tdesc: typedesc; child: RenderNode; transform: Transform): tdesc =
  assert(result is TransformNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_transform_node_new(cast[ptr RenderNode00](child.impl), cast[ptr Transform00](transform.impl))

proc initTransformNode*[T](result: var T; child: RenderNode; transform: Transform) {.deprecated.} =
  assert(result is TransformNode)
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_transform_node_new(cast[ptr RenderNode00](child.impl), cast[ptr Transform00](transform.impl))

proc gsk_transform_node_get_child(self: ptr TransformNode00): ptr RenderNode00 {.
    importc, libprag.}

proc transformNodeGetChild*(self: TransformNode): RenderNode =
  fnew(result, generic_gsk_render_node_unref)
  result.impl = gsk_transform_node_get_child(cast[ptr TransformNode00](self.impl))
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(result.impl))

proc gsk_transform_node_get_transform(self: ptr TransformNode00): ptr Transform00 {.
    importc, libprag.}

proc getTransform*(self: TransformNode): Transform =
  fnew(result, gBoxedFreeGskTransform)
  result.impl = gsk_transform_node_get_transform(cast[ptr TransformNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_transform_get_type(), result.impl))

proc transform*(self: TransformNode): Transform =
  fnew(result, gBoxedFreeGskTransform)
  result.impl = gsk_transform_node_get_transform(cast[ptr TransformNode00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gsk_transform_get_type(), result.impl))

type
  VulkanRenderer* = ref object of Renderer
  VulkanRenderer00* = object of Renderer00

proc gsk_vulkan_renderer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VulkanRenderer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gsk_vulkan_renderer_new(): ptr VulkanRenderer00 {.
    importc, libprag.}

proc newVulkanRenderer*(): VulkanRenderer =
  let gobj = gsk_vulkan_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newVulkanRenderer*(tdesc: typedesc): tdesc =
  assert(result is VulkanRenderer)
  let gobj = gsk_vulkan_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initVulkanRenderer*[T](result: var T) {.deprecated.} =
  assert(result is VulkanRenderer)
  let gobj = gsk_vulkan_renderer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gsk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gsk_value_dup_render_node(value: gobject.Value): ptr RenderNode00 {.
    importc, libprag.}

proc valueDupRenderNode*(value: gobject.Value): RenderNode =
  let impl0 = gsk_value_dup_render_node(value)
  if impl0.isNil:
    return nil
  fnew(result, generic_gsk_render_node_unref)
  result.impl = impl0

proc gsk_value_get_render_node(value: gobject.Value): ptr RenderNode00 {.
    importc, libprag.}

proc valueGetRenderNode*(value: gobject.Value): RenderNode =
  let impl0 = gsk_value_get_render_node(value)
  if impl0.isNil:
    return nil
  fnew(result, generic_gsk_render_node_unref)
  result.impl = cast[typeof(result.impl)](gsk_render_node_ref(impl0))

proc gsk_value_set_render_node(value: gobject.Value; node: ptr RenderNode00) {.
    importc, libprag.}

proc valueSetRenderNode*(value: gobject.Value; node: RenderNode) =
  gsk_value_set_render_node(value, cast[ptr RenderNode00](node.impl))

proc gsk_value_take_render_node(value: gobject.Value; node: ptr RenderNode00) {.
    importc, libprag.}

proc valueTakeRenderNode*(value: gobject.Value; node: RenderNode = nil) =
  gsk_value_take_render_node(value, if node.isNil: nil else: cast[ptr RenderNode00](gsk_render_node_ref(node.impl)))
# === remaining symbols:

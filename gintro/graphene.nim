# dependencies:
# GObject-2.0
# GLib-2.0
# immediate dependencies:
# GObject-2.0
# libraries:
# libgraphene-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, glib
const Lib = "libgraphene-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  Simd4F00* {.pure.} = object
  Simd4F* = ref object
    impl*: ptr Simd4F00
    ignoreFinalizer*: bool

type
  Vec3* {.pure, byRef.} = object
    value*: Simd4F00

proc graphene_vec3_get_type*(): GType {.importc, libprag.}

proc graphene_vec3_free(self: Vec3) {.
    importc, libprag.}

proc free*(self: Vec3) =
  graphene_vec3_free(self)

proc graphene_vec3_add(self: Vec3; b: Vec3; res: var Vec3) {.
    importc, libprag.}

proc add*(self: Vec3; b: Vec3; res: var Vec3) =
  graphene_vec3_add(self, b, res)

proc graphene_vec3_cross(self: Vec3; b: Vec3; res: var Vec3) {.
    importc, libprag.}

proc cross*(self: Vec3; b: Vec3; res: var Vec3) =
  graphene_vec3_cross(self, b, res)

proc graphene_vec3_divide(self: Vec3; b: Vec3; res: var Vec3) {.
    importc, libprag.}

proc divide*(self: Vec3; b: Vec3; res: var Vec3) =
  graphene_vec3_divide(self, b, res)

proc graphene_vec3_dot(self: Vec3; b: Vec3): cfloat {.
    importc, libprag.}

proc dot*(self: Vec3; b: Vec3): cfloat =
  graphene_vec3_dot(self, b)

proc graphene_vec3_equal(self: Vec3; v2: Vec3): gboolean {.
    importc, libprag.}

proc equal*(self: Vec3; v2: Vec3): bool =
  toBool(graphene_vec3_equal(self, v2))

proc allocVec3*(): ptr Vec3 {.
    importc: "graphene_vec3_alloc", libprag.}

proc graphene_vec3_get_x(self: Vec3): cfloat {.
    importc, libprag.}

proc getX*(self: Vec3): cfloat =
  graphene_vec3_get_x(self)

proc x*(self: Vec3): cfloat =
  graphene_vec3_get_x(self)

proc graphene_vec3_get_xy0(self: Vec3; res: var Vec3) {.
    importc, libprag.}

proc getXy0*(self: Vec3; res: var Vec3) =
  graphene_vec3_get_xy0(self, res)

proc getXy0*(self: Vec3): Vec3 =
  graphene_vec3_get_xy0(self, result)

proc graphene_vec3_get_y(self: Vec3): cfloat {.
    importc, libprag.}

proc getY*(self: Vec3): cfloat =
  graphene_vec3_get_y(self)

proc y*(self: Vec3): cfloat =
  graphene_vec3_get_y(self)

proc graphene_vec3_get_z(self: Vec3): cfloat {.
    importc, libprag.}

proc getZ*(self: Vec3): cfloat =
  graphene_vec3_get_z(self)

proc z*(self: Vec3): cfloat =
  graphene_vec3_get_z(self)

proc graphene_vec3_init(self: Vec3; x: cfloat; y: cfloat; z: cfloat): ptr Vec3 {.
    importc, libprag.}

proc init*(self: Vec3; x: cfloat; y: cfloat; z: cfloat): ptr Vec3 =
  graphene_vec3_init(self, x, y, z)

proc graphene_vec3_init_from_float(self: Vec3; src: ptr array[3, cfloat]): ptr Vec3 {.
    importc, libprag.}

proc initFromFloat*(self: Vec3; src: ptr array[3, cfloat]): ptr Vec3 =
  graphene_vec3_init_from_float(self, src)

proc graphene_vec3_init_from_vec3(self: Vec3; src: Vec3): ptr Vec3 {.
    importc, libprag.}

proc initFromVec3*(self: Vec3; src: Vec3): ptr Vec3 =
  graphene_vec3_init_from_vec3(self, src)

proc graphene_vec3_interpolate(self: Vec3; v2: Vec3; factor: cdouble; res: var Vec3) {.
    importc, libprag.}

proc interpolate*(self: Vec3; v2: Vec3; factor: cdouble; res: var Vec3) =
  graphene_vec3_interpolate(self, v2, factor, res)

proc graphene_vec3_length(self: Vec3): cfloat {.
    importc, libprag.}

proc length*(self: Vec3): cfloat =
  graphene_vec3_length(self)

proc graphene_vec3_max(self: Vec3; b: Vec3; res: var Vec3) {.
    importc, libprag.}

proc max*(self: Vec3; b: Vec3; res: var Vec3) =
  graphene_vec3_max(self, b, res)

proc graphene_vec3_min(self: Vec3; b: Vec3; res: var Vec3) {.
    importc, libprag.}

proc min*(self: Vec3; b: Vec3; res: var Vec3) =
  graphene_vec3_min(self, b, res)

proc graphene_vec3_multiply(self: Vec3; b: Vec3; res: var Vec3) {.
    importc, libprag.}

proc multiply*(self: Vec3; b: Vec3; res: var Vec3) =
  graphene_vec3_multiply(self, b, res)

proc graphene_vec3_near(self: Vec3; v2: Vec3; epsilon: cfloat): gboolean {.
    importc, libprag.}

proc near*(self: Vec3; v2: Vec3; epsilon: cfloat): bool =
  toBool(graphene_vec3_near(self, v2, epsilon))

proc graphene_vec3_negate(self: Vec3; res: var Vec3) {.
    importc, libprag.}

proc negate*(self: Vec3; res: var Vec3) =
  graphene_vec3_negate(self, res)

proc negate*(self: Vec3): Vec3 =
  graphene_vec3_negate(self, result)

proc graphene_vec3_normalize(self: Vec3; res: var Vec3) {.
    importc, libprag.}

proc normalize*(self: Vec3; res: var Vec3) =
  graphene_vec3_normalize(self, res)

proc normalize*(self: Vec3): Vec3 =
  graphene_vec3_normalize(self, result)

proc graphene_vec3_scale(self: Vec3; factor: cfloat; res: var Vec3) {.
    importc, libprag.}

proc scale*(self: Vec3; factor: cfloat; res: var Vec3) =
  graphene_vec3_scale(self, factor, res)

proc graphene_vec3_subtract(self: Vec3; b: Vec3; res: var Vec3) {.
    importc, libprag.}

proc subtract*(self: Vec3; b: Vec3; res: var Vec3) =
  graphene_vec3_subtract(self, b, res)

proc graphene_vec3_to_float(self: Vec3; dest: var ptr array[3, cfloat]) {.
    importc, libprag.}

proc toFloat*(self: Vec3; dest: var ptr array[3, cfloat]) =
  graphene_vec3_to_float(self, dest)

proc toFloat*(self: Vec3): ptr array[3, cfloat] =
  graphene_vec3_to_float(self, result)

proc oneVec3*(): ptr Vec3 {.
    importc: "graphene_vec3_one", libprag.}

proc xAxisVec3*(): ptr Vec3 {.
    importc: "graphene_vec3_x_axis", libprag.}

proc yAxisVec3*(): ptr Vec3 {.
    importc: "graphene_vec3_y_axis", libprag.}

proc zAxisVec3*(): ptr Vec3 {.
    importc: "graphene_vec3_z_axis", libprag.}

proc zeroVec3*(): ptr Vec3 {.
    importc: "graphene_vec3_zero", libprag.}

type
  Box* {.pure, byRef.} = object
    min*: Vec3
    max*: Vec3

proc graphene_box_get_type*(): GType {.importc, libprag.}

proc graphene_box_free(self: Box) {.
    importc, libprag.}

proc free*(self: Box) =
  graphene_box_free(self)

proc graphene_box_contains_box(self: Box; b: Box): gboolean {.
    importc, libprag.}

proc containsBox*(self: Box; b: Box): bool =
  toBool(graphene_box_contains_box(self, b))

proc graphene_box_equal(self: Box; b: Box): gboolean {.
    importc, libprag.}

proc equal*(self: Box; b: Box): bool =
  toBool(graphene_box_equal(self, b))

proc graphene_box_expand_scalar(self: Box; scalar: cfloat; res: var Box) {.
    importc, libprag.}

proc expandScalar*(self: Box; scalar: cfloat; res: var Box) =
  graphene_box_expand_scalar(self, scalar, res)

proc graphene_box_expand_vec3(self: Box; vec: Vec3; res: var Box) {.
    importc, libprag.}

proc expandVec3*(self: Box; vec: Vec3; res: var Box) =
  graphene_box_expand_vec3(self, vec, res)

proc allocBox*(): ptr Box {.
    importc: "graphene_box_alloc", libprag.}

proc graphene_box_get_depth(self: Box): cfloat {.
    importc, libprag.}

proc getDepth*(self: Box): cfloat =
  graphene_box_get_depth(self)

proc depth*(self: Box): cfloat =
  graphene_box_get_depth(self)

proc graphene_box_get_height(self: Box): cfloat {.
    importc, libprag.}

proc getHeight*(self: Box): cfloat =
  graphene_box_get_height(self)

proc height*(self: Box): cfloat =
  graphene_box_get_height(self)

proc graphene_box_get_size(self: Box; size: var Vec3) {.
    importc, libprag.}

proc getSize*(self: Box; size: var Vec3) =
  graphene_box_get_size(self, size)

proc getSize*(self: Box): Vec3 =
  graphene_box_get_size(self, result)

proc graphene_box_get_vertices(self: Box; vertices: var ptr array[8, Vec3]) {.
    importc, libprag.}

proc getVertices*(self: Box; vertices: var ptr array[8, Vec3]) =
  graphene_box_get_vertices(self, vertices)

proc getVertices*(self: Box): ptr array[8, Vec3] =
  graphene_box_get_vertices(self, result)

proc graphene_box_get_width(self: Box): cfloat {.
    importc, libprag.}

proc getWidth*(self: Box): cfloat =
  graphene_box_get_width(self)

proc width*(self: Box): cfloat =
  graphene_box_get_width(self)

proc graphene_box_init_from_box(self: Box; src: Box): ptr Box {.
    importc, libprag.}

proc initFromBox*(self: Box; src: Box): ptr Box =
  graphene_box_init_from_box(self, src)

proc graphene_box_init_from_vec3(self: Box; min: Vec3; max: Vec3): ptr Box {.
    importc, libprag.}

proc initFromVec3*(self: Box; min: Vec3 = cast[var Vec3](nil);
    max: Vec3 = cast[var Vec3](nil)): ptr Box =
  graphene_box_init_from_vec3(self, min, max)

proc graphene_box_init_from_vectors(self: Box; nVectors: uint32; vectors: ptr Vec3): ptr Box {.
    importc, libprag.}

proc initFromVectors*(self: Box; nVectors: int; vectors: ptr Vec3): ptr Box =
  graphene_box_init_from_vectors(self, uint32(nVectors), vectors)

proc graphene_box_intersection(self: Box; b: Box; res: var Box): gboolean {.
    importc, libprag.}

proc intersection*(self: Box; b: Box; res: var Box = cast[var Box](nil)): bool =
  toBool(graphene_box_intersection(self, b, res))

proc graphene_box_union(self: Box; b: Box; res: var Box) {.
    importc, libprag.}

proc union*(self: Box; b: Box; res: var Box) =
  graphene_box_union(self, b, res)

proc emptyBox*(): ptr Box {.
    importc: "graphene_box_empty", libprag.}

proc infiniteBox*(): ptr Box {.
    importc: "graphene_box_infinite", libprag.}

proc minusOneBox*(): ptr Box {.
    importc: "graphene_box_minus_one", libprag.}

proc oneBox*(): ptr Box {.
    importc: "graphene_box_one", libprag.}

proc oneMinusOneBox*(): ptr Box {.
    importc: "graphene_box_one_minus_one", libprag.}

proc zeroBox*(): ptr Box {.
    importc: "graphene_box_zero", libprag.}

type
  Vec2* {.pure, byRef.} = object
    value*: Simd4F00

proc graphene_vec2_get_type*(): GType {.importc, libprag.}

proc graphene_vec2_free(self: Vec2) {.
    importc, libprag.}

proc free*(self: Vec2) =
  graphene_vec2_free(self)

proc graphene_vec2_add(self: Vec2; b: Vec2; res: var Vec2) {.
    importc, libprag.}

proc add*(self: Vec2; b: Vec2; res: var Vec2) =
  graphene_vec2_add(self, b, res)

proc graphene_vec2_divide(self: Vec2; b: Vec2; res: var Vec2) {.
    importc, libprag.}

proc divide*(self: Vec2; b: Vec2; res: var Vec2) =
  graphene_vec2_divide(self, b, res)

proc graphene_vec2_dot(self: Vec2; b: Vec2): cfloat {.
    importc, libprag.}

proc dot*(self: Vec2; b: Vec2): cfloat =
  graphene_vec2_dot(self, b)

proc graphene_vec2_equal(self: Vec2; v2: Vec2): gboolean {.
    importc, libprag.}

proc equal*(self: Vec2; v2: Vec2): bool =
  toBool(graphene_vec2_equal(self, v2))

proc allocVec2*(): ptr Vec2 {.
    importc: "graphene_vec2_alloc", libprag.}

proc graphene_vec2_get_x(self: Vec2): cfloat {.
    importc, libprag.}

proc getX*(self: Vec2): cfloat =
  graphene_vec2_get_x(self)

proc x*(self: Vec2): cfloat =
  graphene_vec2_get_x(self)

proc graphene_vec2_get_y(self: Vec2): cfloat {.
    importc, libprag.}

proc getY*(self: Vec2): cfloat =
  graphene_vec2_get_y(self)

proc y*(self: Vec2): cfloat =
  graphene_vec2_get_y(self)

proc graphene_vec2_init(self: Vec2; x: cfloat; y: cfloat): ptr Vec2 {.
    importc, libprag.}

proc init*(self: Vec2; x: cfloat; y: cfloat): ptr Vec2 =
  graphene_vec2_init(self, x, y)

proc graphene_vec2_init_from_float(self: Vec2; src: ptr array[2, cfloat]): ptr Vec2 {.
    importc, libprag.}

proc initFromFloat*(self: Vec2; src: ptr array[2, cfloat]): ptr Vec2 =
  graphene_vec2_init_from_float(self, src)

proc graphene_vec2_init_from_vec2(self: Vec2; src: Vec2): ptr Vec2 {.
    importc, libprag.}

proc initFromVec2*(self: Vec2; src: Vec2): ptr Vec2 =
  graphene_vec2_init_from_vec2(self, src)

proc graphene_vec2_interpolate(self: Vec2; v2: Vec2; factor: cdouble; res: var Vec2) {.
    importc, libprag.}

proc interpolate*(self: Vec2; v2: Vec2; factor: cdouble; res: var Vec2) =
  graphene_vec2_interpolate(self, v2, factor, res)

proc graphene_vec2_length(self: Vec2): cfloat {.
    importc, libprag.}

proc length*(self: Vec2): cfloat =
  graphene_vec2_length(self)

proc graphene_vec2_max(self: Vec2; b: Vec2; res: var Vec2) {.
    importc, libprag.}

proc max*(self: Vec2; b: Vec2; res: var Vec2) =
  graphene_vec2_max(self, b, res)

proc graphene_vec2_min(self: Vec2; b: Vec2; res: var Vec2) {.
    importc, libprag.}

proc min*(self: Vec2; b: Vec2; res: var Vec2) =
  graphene_vec2_min(self, b, res)

proc graphene_vec2_multiply(self: Vec2; b: Vec2; res: var Vec2) {.
    importc, libprag.}

proc multiply*(self: Vec2; b: Vec2; res: var Vec2) =
  graphene_vec2_multiply(self, b, res)

proc graphene_vec2_near(self: Vec2; v2: Vec2; epsilon: cfloat): gboolean {.
    importc, libprag.}

proc near*(self: Vec2; v2: Vec2; epsilon: cfloat): bool =
  toBool(graphene_vec2_near(self, v2, epsilon))

proc graphene_vec2_negate(self: Vec2; res: var Vec2) {.
    importc, libprag.}

proc negate*(self: Vec2; res: var Vec2) =
  graphene_vec2_negate(self, res)

proc negate*(self: Vec2): Vec2 =
  graphene_vec2_negate(self, result)

proc graphene_vec2_normalize(self: Vec2; res: var Vec2) {.
    importc, libprag.}

proc normalize*(self: Vec2; res: var Vec2) =
  graphene_vec2_normalize(self, res)

proc normalize*(self: Vec2): Vec2 =
  graphene_vec2_normalize(self, result)

proc graphene_vec2_scale(self: Vec2; factor: cfloat; res: var Vec2) {.
    importc, libprag.}

proc scale*(self: Vec2; factor: cfloat; res: var Vec2) =
  graphene_vec2_scale(self, factor, res)

proc graphene_vec2_subtract(self: Vec2; b: Vec2; res: var Vec2) {.
    importc, libprag.}

proc subtract*(self: Vec2; b: Vec2; res: var Vec2) =
  graphene_vec2_subtract(self, b, res)

proc graphene_vec2_to_float(self: Vec2; dest: var ptr array[2, cfloat]) {.
    importc, libprag.}

proc toFloat*(self: Vec2; dest: var ptr array[2, cfloat]) =
  graphene_vec2_to_float(self, dest)

proc toFloat*(self: Vec2): ptr array[2, cfloat] =
  graphene_vec2_to_float(self, result)

proc oneVec2*(): ptr Vec2 {.
    importc: "graphene_vec2_one", libprag.}

proc xAxisVec2*(): ptr Vec2 {.
    importc: "graphene_vec2_x_axis", libprag.}

proc yAxisVec2*(): ptr Vec2 {.
    importc: "graphene_vec2_y_axis", libprag.}

proc zeroVec2*(): ptr Vec2 {.
    importc: "graphene_vec2_zero", libprag.}

proc graphene_vec3_get_xy(self: Vec3; res: var Vec2) {.
    importc, libprag.}

proc getXy*(self: Vec3; res: var Vec2) =
  graphene_vec3_get_xy(self, res)

proc getXy*(self: Vec3): Vec2 =
  graphene_vec3_get_xy(self, result)

type
  Vec4* {.pure, byRef.} = object
    value*: Simd4F00

proc graphene_vec4_get_type*(): GType {.importc, libprag.}

proc graphene_vec4_free(self: Vec4) {.
    importc, libprag.}

proc free*(self: Vec4) =
  graphene_vec4_free(self)

proc graphene_vec4_add(self: Vec4; b: Vec4; res: var Vec4) {.
    importc, libprag.}

proc add*(self: Vec4; b: Vec4; res: var Vec4) =
  graphene_vec4_add(self, b, res)

proc graphene_vec4_divide(self: Vec4; b: Vec4; res: var Vec4) {.
    importc, libprag.}

proc divide*(self: Vec4; b: Vec4; res: var Vec4) =
  graphene_vec4_divide(self, b, res)

proc graphene_vec4_dot(self: Vec4; b: Vec4): cfloat {.
    importc, libprag.}

proc dot*(self: Vec4; b: Vec4): cfloat =
  graphene_vec4_dot(self, b)

proc graphene_vec4_equal(self: Vec4; v2: Vec4): gboolean {.
    importc, libprag.}

proc equal*(self: Vec4; v2: Vec4): bool =
  toBool(graphene_vec4_equal(self, v2))

proc allocVec4*(): ptr Vec4 {.
    importc: "graphene_vec4_alloc", libprag.}

proc graphene_vec4_get_w(self: Vec4): cfloat {.
    importc, libprag.}

proc getW*(self: Vec4): cfloat =
  graphene_vec4_get_w(self)

proc w*(self: Vec4): cfloat =
  graphene_vec4_get_w(self)

proc graphene_vec4_get_x(self: Vec4): cfloat {.
    importc, libprag.}

proc getX*(self: Vec4): cfloat =
  graphene_vec4_get_x(self)

proc x*(self: Vec4): cfloat =
  graphene_vec4_get_x(self)

proc graphene_vec4_get_xy(self: Vec4; res: var Vec2) {.
    importc, libprag.}

proc getXy*(self: Vec4; res: var Vec2) =
  graphene_vec4_get_xy(self, res)

proc getXy*(self: Vec4): Vec2 =
  graphene_vec4_get_xy(self, result)

proc graphene_vec4_get_xyz(self: Vec4; res: var Vec3) {.
    importc, libprag.}

proc getXyz*(self: Vec4; res: var Vec3) =
  graphene_vec4_get_xyz(self, res)

proc getXyz*(self: Vec4): Vec3 =
  graphene_vec4_get_xyz(self, result)

proc graphene_vec4_get_y(self: Vec4): cfloat {.
    importc, libprag.}

proc getY*(self: Vec4): cfloat =
  graphene_vec4_get_y(self)

proc y*(self: Vec4): cfloat =
  graphene_vec4_get_y(self)

proc graphene_vec4_get_z(self: Vec4): cfloat {.
    importc, libprag.}

proc getZ*(self: Vec4): cfloat =
  graphene_vec4_get_z(self)

proc z*(self: Vec4): cfloat =
  graphene_vec4_get_z(self)

proc graphene_vec4_init(self: Vec4; x: cfloat; y: cfloat; z: cfloat; w: cfloat): ptr Vec4 {.
    importc, libprag.}

proc init*(self: Vec4; x: cfloat; y: cfloat; z: cfloat; w: cfloat): ptr Vec4 =
  graphene_vec4_init(self, x, y, z, w)

proc graphene_vec4_init_from_float(self: Vec4; src: ptr array[4, cfloat]): ptr Vec4 {.
    importc, libprag.}

proc initFromFloat*(self: Vec4; src: ptr array[4, cfloat]): ptr Vec4 =
  graphene_vec4_init_from_float(self, src)

proc graphene_vec4_init_from_vec2(self: Vec4; src: Vec2; z: cfloat; w: cfloat): ptr Vec4 {.
    importc, libprag.}

proc initFromVec2*(self: Vec4; src: Vec2; z: cfloat; w: cfloat): ptr Vec4 =
  graphene_vec4_init_from_vec2(self, src, z, w)

proc graphene_vec4_init_from_vec3(self: Vec4; src: Vec3; w: cfloat): ptr Vec4 {.
    importc, libprag.}

proc initFromVec3*(self: Vec4; src: Vec3; w: cfloat): ptr Vec4 =
  graphene_vec4_init_from_vec3(self, src, w)

proc graphene_vec4_init_from_vec4(self: Vec4; src: Vec4): ptr Vec4 {.
    importc, libprag.}

proc initFromVec4*(self: Vec4; src: Vec4): ptr Vec4 =
  graphene_vec4_init_from_vec4(self, src)

proc graphene_vec4_interpolate(self: Vec4; v2: Vec4; factor: cdouble; res: var Vec4) {.
    importc, libprag.}

proc interpolate*(self: Vec4; v2: Vec4; factor: cdouble; res: var Vec4) =
  graphene_vec4_interpolate(self, v2, factor, res)

proc graphene_vec4_length(self: Vec4): cfloat {.
    importc, libprag.}

proc length*(self: Vec4): cfloat =
  graphene_vec4_length(self)

proc graphene_vec4_max(self: Vec4; b: Vec4; res: var Vec4) {.
    importc, libprag.}

proc max*(self: Vec4; b: Vec4; res: var Vec4) =
  graphene_vec4_max(self, b, res)

proc graphene_vec4_min(self: Vec4; b: Vec4; res: var Vec4) {.
    importc, libprag.}

proc min*(self: Vec4; b: Vec4; res: var Vec4) =
  graphene_vec4_min(self, b, res)

proc graphene_vec4_multiply(self: Vec4; b: Vec4; res: var Vec4) {.
    importc, libprag.}

proc multiply*(self: Vec4; b: Vec4; res: var Vec4) =
  graphene_vec4_multiply(self, b, res)

proc graphene_vec4_near(self: Vec4; v2: Vec4; epsilon: cfloat): gboolean {.
    importc, libprag.}

proc near*(self: Vec4; v2: Vec4; epsilon: cfloat): bool =
  toBool(graphene_vec4_near(self, v2, epsilon))

proc graphene_vec4_negate(self: Vec4; res: var Vec4) {.
    importc, libprag.}

proc negate*(self: Vec4; res: var Vec4) =
  graphene_vec4_negate(self, res)

proc negate*(self: Vec4): Vec4 =
  graphene_vec4_negate(self, result)

proc graphene_vec4_normalize(self: Vec4; res: var Vec4) {.
    importc, libprag.}

proc normalize*(self: Vec4; res: var Vec4) =
  graphene_vec4_normalize(self, res)

proc normalize*(self: Vec4): Vec4 =
  graphene_vec4_normalize(self, result)

proc graphene_vec4_scale(self: Vec4; factor: cfloat; res: var Vec4) {.
    importc, libprag.}

proc scale*(self: Vec4; factor: cfloat; res: var Vec4) =
  graphene_vec4_scale(self, factor, res)

proc graphene_vec4_subtract(self: Vec4; b: Vec4; res: var Vec4) {.
    importc, libprag.}

proc subtract*(self: Vec4; b: Vec4; res: var Vec4) =
  graphene_vec4_subtract(self, b, res)

proc graphene_vec4_to_float(self: Vec4; dest: var ptr array[4, cfloat]) {.
    importc, libprag.}

proc toFloat*(self: Vec4; dest: var ptr array[4, cfloat]) =
  graphene_vec4_to_float(self, dest)

proc toFloat*(self: Vec4): ptr array[4, cfloat] =
  graphene_vec4_to_float(self, result)

proc oneVec4*(): ptr Vec4 {.
    importc: "graphene_vec4_one", libprag.}

proc wAxisVec4*(): ptr Vec4 {.
    importc: "graphene_vec4_w_axis", libprag.}

proc xAxisVec4*(): ptr Vec4 {.
    importc: "graphene_vec4_x_axis", libprag.}

proc yAxisVec4*(): ptr Vec4 {.
    importc: "graphene_vec4_y_axis", libprag.}

proc zAxisVec4*(): ptr Vec4 {.
    importc: "graphene_vec4_z_axis", libprag.}

proc zeroVec4*(): ptr Vec4 {.
    importc: "graphene_vec4_zero", libprag.}

proc graphene_vec3_get_xyz0(self: Vec3; res: var Vec4) {.
    importc, libprag.}

proc getXyz0*(self: Vec3; res: var Vec4) =
  graphene_vec3_get_xyz0(self, res)

proc getXyz0*(self: Vec3): Vec4 =
  graphene_vec3_get_xyz0(self, result)

proc graphene_vec3_get_xyz1(self: Vec3; res: var Vec4) {.
    importc, libprag.}

proc getXyz1*(self: Vec3; res: var Vec4) =
  graphene_vec3_get_xyz1(self, res)

proc getXyz1*(self: Vec3): Vec4 =
  graphene_vec3_get_xyz1(self, result)

proc graphene_vec3_get_xyzw(self: Vec3; w: cfloat; res: var Vec4) {.
    importc, libprag.}

proc getXyzw*(self: Vec3; w: cfloat; res: var Vec4) =
  graphene_vec3_get_xyzw(self, w, res)

type
  Sphere* {.pure, byRef.} = object
    center*: Vec3
    radius*: cfloat

proc graphene_sphere_get_type*(): GType {.importc, libprag.}

proc graphene_sphere_free(self: Sphere) {.
    importc, libprag.}

proc free*(self: Sphere) =
  graphene_sphere_free(self)

proc graphene_sphere_equal(self: Sphere; b: Sphere): gboolean {.
    importc, libprag.}

proc equal*(self: Sphere; b: Sphere): bool =
  toBool(graphene_sphere_equal(self, b))

proc allocSphere*(): ptr Sphere {.
    importc: "graphene_sphere_alloc", libprag.}

proc graphene_sphere_get_bounding_box(self: Sphere; box: var Box) {.
    importc, libprag.}

proc getBoundingBox*(self: Sphere; box: var Box) =
  graphene_sphere_get_bounding_box(self, box)

proc getBoundingBox*(self: Sphere): Box =
  graphene_sphere_get_bounding_box(self, result)

proc graphene_sphere_get_radius(self: Sphere): cfloat {.
    importc, libprag.}

proc getRadius*(self: Sphere): cfloat =
  graphene_sphere_get_radius(self)

proc radius*(self: Sphere): cfloat =
  graphene_sphere_get_radius(self)

proc graphene_sphere_is_empty(self: Sphere): gboolean {.
    importc, libprag.}

proc isEmpty*(self: Sphere): bool =
  toBool(graphene_sphere_is_empty(self))

proc graphene_box_get_bounding_sphere(self: Box; sphere: var Sphere) {.
    importc, libprag.}

proc getBoundingSphere*(self: Box; sphere: var Sphere) =
  graphene_box_get_bounding_sphere(self, sphere)

proc getBoundingSphere*(self: Box): Sphere =
  graphene_box_get_bounding_sphere(self, result)

type
  Point3D* {.pure, byRef.} = object
    x*: cfloat
    y*: cfloat
    z*: cfloat

proc graphene_point3d_get_type*(): GType {.importc, libprag.}

proc graphene_point3d_free(self: Point3D) {.
    importc, libprag.}

proc free*(self: Point3D) =
  graphene_point3d_free(self)

proc graphene_point3d_cross(self: Point3D; b: Point3D; res: var Point3D) {.
    importc, libprag.}

proc cross*(self: Point3D; b: Point3D; res: var Point3D) =
  graphene_point3d_cross(self, b, res)

proc graphene_point3d_distance(self: Point3D; b: Point3D; delta: var Vec3): cfloat {.
    importc, libprag.}

proc distance*(self: Point3D; b: Point3D; delta: var Vec3 = cast[var Vec3](nil)): cfloat =
  graphene_point3d_distance(self, b, delta)

proc graphene_point3d_dot(self: Point3D; b: Point3D): cfloat {.
    importc, libprag.}

proc dot*(self: Point3D; b: Point3D): cfloat =
  graphene_point3d_dot(self, b)

proc graphene_point3d_equal(self: Point3D; b: Point3D): gboolean {.
    importc, libprag.}

proc equal*(self: Point3D; b: Point3D): bool =
  toBool(graphene_point3d_equal(self, b))

proc allocPoint3D*(): ptr Point3D {.
    importc: "graphene_point3d_alloc", libprag.}

proc graphene_point3d_init(self: Point3D; x: cfloat; y: cfloat; z: cfloat): ptr Point3D {.
    importc, libprag.}

proc init*(self: Point3D; x: cfloat; y: cfloat; z: cfloat): ptr Point3D =
  graphene_point3d_init(self, x, y, z)

proc graphene_point3d_init_from_point(self: Point3D; src: Point3D): ptr Point3D {.
    importc, libprag.}

proc initFromPoint*(self: Point3D; src: Point3D): ptr Point3D =
  graphene_point3d_init_from_point(self, src)

proc graphene_point3d_init_from_vec3(self: Point3D; v: Vec3): ptr Point3D {.
    importc, libprag.}

proc initFromVec3*(self: Point3D; v: Vec3): ptr Point3D =
  graphene_point3d_init_from_vec3(self, v)

proc graphene_point3d_interpolate(self: Point3D; b: Point3D; factor: cdouble;
    res: var Point3D) {.
    importc, libprag.}

proc interpolate*(self: Point3D; b: Point3D; factor: cdouble;
    res: var Point3D) =
  graphene_point3d_interpolate(self, b, factor, res)

proc graphene_point3d_length(self: Point3D): cfloat {.
    importc, libprag.}

proc length*(self: Point3D): cfloat =
  graphene_point3d_length(self)

proc graphene_point3d_near(self: Point3D; b: Point3D; epsilon: cfloat): gboolean {.
    importc, libprag.}

proc near*(self: Point3D; b: Point3D; epsilon: cfloat): bool =
  toBool(graphene_point3d_near(self, b, epsilon))

proc graphene_point3d_normalize(self: Point3D; res: var Point3D) {.
    importc, libprag.}

proc normalize*(self: Point3D; res: var Point3D) =
  graphene_point3d_normalize(self, res)

proc normalize*(self: Point3D): Point3D =
  graphene_point3d_normalize(self, result)

proc graphene_point3d_scale(self: Point3D; factor: cfloat; res: var Point3D) {.
    importc, libprag.}

proc scale*(self: Point3D; factor: cfloat; res: var Point3D) =
  graphene_point3d_scale(self, factor, res)

proc graphene_point3d_to_vec3(self: Point3D; v: var Vec3) {.
    importc, libprag.}

proc toVec3*(self: Point3D; v: var Vec3) =
  graphene_point3d_to_vec3(self, v)

proc toVec3*(self: Point3D): Vec3 =
  graphene_point3d_to_vec3(self, result)

proc zeroPoint3D*(): ptr Point3D {.
    importc: "graphene_point3d_zero", libprag.}

proc graphene_box_contains_point(self: Box; point: Point3D): gboolean {.
    importc, libprag.}

proc containsPoint*(self: Box; point: Point3D): bool =
  toBool(graphene_box_contains_point(self, point))

proc graphene_box_expand(self: Box; point: Point3D; res: var Box) {.
    importc, libprag.}

proc expand*(self: Box; point: Point3D; res: var Box) =
  graphene_box_expand(self, point, res)

proc graphene_box_get_center(self: Box; center: var Point3D) {.
    importc, libprag.}

proc getCenter*(self: Box; center: var Point3D) =
  graphene_box_get_center(self, center)

proc getCenter*(self: Box): Point3D =
  graphene_box_get_center(self, result)

proc graphene_box_get_max(self: Box; max: var Point3D) {.
    importc, libprag.}

proc getMax*(self: Box; max: var Point3D) =
  graphene_box_get_max(self, max)

proc getMax*(self: Box): Point3D =
  graphene_box_get_max(self, result)

proc graphene_box_get_min(self: Box; min: var Point3D) {.
    importc, libprag.}

proc getMin*(self: Box; min: var Point3D) =
  graphene_box_get_min(self, min)

proc getMin*(self: Box): Point3D =
  graphene_box_get_min(self, result)

proc graphene_box_init(self: Box; min: Point3D; max: Point3D): ptr Box {.
    importc, libprag.}

proc init*(self: Box; min: Point3D = cast[var Point3D](nil);
    max: Point3D = cast[var Point3D](nil)): ptr Box =
  graphene_box_init(self, min, max)

proc graphene_box_init_from_points(self: Box; nPoints: uint32; points: ptr Point3D): ptr Box {.
    importc, libprag.}

proc initFromPoints*(self: Box; nPoints: int; points: ptr Point3D): ptr Box =
  graphene_box_init_from_points(self, uint32(nPoints), points)

proc graphene_sphere_contains_point(self: Sphere; point: Point3D): gboolean {.
    importc, libprag.}

proc containsPoint*(self: Sphere; point: Point3D): bool =
  toBool(graphene_sphere_contains_point(self, point))

proc graphene_sphere_distance(self: Sphere; point: Point3D): cfloat {.
    importc, libprag.}

proc distance*(self: Sphere; point: Point3D): cfloat =
  graphene_sphere_distance(self, point)

proc graphene_sphere_get_center(self: Sphere; center: var Point3D) {.
    importc, libprag.}

proc getCenter*(self: Sphere; center: var Point3D) =
  graphene_sphere_get_center(self, center)

proc getCenter*(self: Sphere): Point3D =
  graphene_sphere_get_center(self, result)

proc graphene_sphere_init(self: Sphere; center: Point3D; radius: cfloat): ptr Sphere {.
    importc, libprag.}

proc init*(self: Sphere; center: Point3D = cast[var Point3D](nil);
    radius: cfloat): ptr Sphere =
  graphene_sphere_init(self, center, radius)

proc graphene_sphere_init_from_points(self: Sphere; nPoints: uint32; points: ptr Point3D;
    center: Point3D): ptr Sphere {.
    importc, libprag.}

proc initFromPoints*(self: Sphere; nPoints: int; points: ptr Point3D;
    center: Point3D = cast[var Point3D](nil)): ptr Sphere =
  graphene_sphere_init_from_points(self, uint32(nPoints), points, center)

proc graphene_sphere_init_from_vectors(self: Sphere; nVectors: uint32; vectors: ptr Vec3;
    center: Point3D): ptr Sphere {.
    importc, libprag.}

proc initFromVectors*(self: Sphere; nVectors: int; vectors: ptr Vec3;
    center: Point3D = cast[var Point3D](nil)): ptr Sphere =
  graphene_sphere_init_from_vectors(self, uint32(nVectors), vectors, center)

proc graphene_sphere_translate(self: Sphere; point: Point3D; res: var Sphere) {.
    importc, libprag.}

proc translate*(self: Sphere; point: Point3D; res: var Sphere) =
  graphene_sphere_translate(self, point, res)

type
  Point* {.pure, byRef.} = object
    x*: cfloat
    y*: cfloat

proc graphene_point_get_type*(): GType {.importc, libprag.}

proc graphene_point_free(self: Point) {.
    importc, libprag.}

proc free*(self: Point) =
  graphene_point_free(self)

proc graphene_point_distance(self: Point; b: Point; dX: var cfloat; dY: var cfloat): cfloat {.
    importc, libprag.}

proc distance*(self: Point; b: Point; dX: var cfloat = cast[var cfloat](nil);
    dY: var cfloat = cast[var cfloat](nil)): cfloat =
  graphene_point_distance(self, b, dX, dY)

proc graphene_point_equal(self: Point; b: Point): gboolean {.
    importc, libprag.}

proc equal*(self: Point; b: Point): bool =
  toBool(graphene_point_equal(self, b))

proc allocPoint*(): ptr Point {.
    importc: "graphene_point_alloc", libprag.}

proc graphene_point_init(self: Point; x: cfloat; y: cfloat): ptr Point {.
    importc, libprag.}

proc init*(self: Point; x: cfloat; y: cfloat): ptr Point =
  graphene_point_init(self, x, y)

proc graphene_point_init_from_point(self: Point; src: Point): ptr Point {.
    importc, libprag.}

proc initFromPoint*(self: Point; src: Point): ptr Point =
  graphene_point_init_from_point(self, src)

proc graphene_point_init_from_vec2(self: Point; src: Vec2): ptr Point {.
    importc, libprag.}

proc initFromVec2*(self: Point; src: Vec2): ptr Point =
  graphene_point_init_from_vec2(self, src)

proc graphene_point_interpolate(self: Point; b: Point; factor: cdouble; res: var Point) {.
    importc, libprag.}

proc interpolate*(self: Point; b: Point; factor: cdouble; res: var Point) =
  graphene_point_interpolate(self, b, factor, res)

proc graphene_point_near(self: Point; b: Point; epsilon: cfloat): gboolean {.
    importc, libprag.}

proc near*(self: Point; b: Point; epsilon: cfloat): bool =
  toBool(graphene_point_near(self, b, epsilon))

proc graphene_point_to_vec2(self: Point; v: var Vec2) {.
    importc, libprag.}

proc toVec2*(self: Point; v: var Vec2) =
  graphene_point_to_vec2(self, v)

proc toVec2*(self: Point): Vec2 =
  graphene_point_to_vec2(self, result)

proc zeroPoint*(): ptr Point {.
    importc: "graphene_point_zero", libprag.}

type
  Size* {.pure, byRef.} = object
    width*: cfloat
    height*: cfloat

proc graphene_size_get_type*(): GType {.importc, libprag.}

proc graphene_size_free(self: Size) {.
    importc, libprag.}

proc free*(self: Size) =
  graphene_size_free(self)

proc graphene_size_equal(self: Size; b: Size): gboolean {.
    importc, libprag.}

proc equal*(self: Size; b: Size): bool =
  toBool(graphene_size_equal(self, b))

proc allocSize*(): ptr Size {.
    importc: "graphene_size_alloc", libprag.}

proc graphene_size_init(self: Size; width: cfloat; height: cfloat): ptr Size {.
    importc, libprag.}

proc init*(self: Size; width: cfloat; height: cfloat): ptr Size =
  graphene_size_init(self, width, height)

proc graphene_size_init_from_size(self: Size; src: Size): ptr Size {.
    importc, libprag.}

proc initFromSize*(self: Size; src: Size): ptr Size =
  graphene_size_init_from_size(self, src)

proc graphene_size_interpolate(self: Size; b: Size; factor: cdouble; res: var Size) {.
    importc, libprag.}

proc interpolate*(self: Size; b: Size; factor: cdouble; res: var Size) =
  graphene_size_interpolate(self, b, factor, res)

proc graphene_size_scale(self: Size; factor: cfloat; res: var Size) {.
    importc, libprag.}

proc scale*(self: Size; factor: cfloat; res: var Size) =
  graphene_size_scale(self, factor, res)

proc zeroSize*(): ptr Size {.
    importc: "graphene_size_zero", libprag.}

type
  Rect* {.pure, byRef.} = object
    origin*: Point
    size*: Size

proc graphene_rect_get_type*(): GType {.importc, libprag.}

proc graphene_rect_free(self: Rect) {.
    importc, libprag.}

proc free*(self: Rect) =
  graphene_rect_free(self)

proc graphene_rect_contains_rect(self: Rect; b: Rect): gboolean {.
    importc, libprag.}

proc containsRect*(self: Rect; b: Rect): bool =
  toBool(graphene_rect_contains_rect(self, b))

proc graphene_rect_equal(self: Rect; b: Rect): gboolean {.
    importc, libprag.}

proc equal*(self: Rect; b: Rect): bool =
  toBool(graphene_rect_equal(self, b))

proc graphene_rect_expand(self: Rect; p: Point; res: var Rect) {.
    importc, libprag.}

proc expand*(self: Rect; p: Point; res: var Rect) =
  graphene_rect_expand(self, p, res)

proc graphene_rect_contains_point(self: Rect; p: Point): gboolean {.
    importc, libprag.}

proc containsPoint*(self: Rect; p: Point): bool =
  toBool(graphene_rect_contains_point(self, p))

proc graphene_rect_get_area(self: Rect): cfloat {.
    importc, libprag.}

proc getArea*(self: Rect): cfloat =
  graphene_rect_get_area(self)

proc area*(self: Rect): cfloat =
  graphene_rect_get_area(self)

proc graphene_rect_get_bottom_left(self: Rect; p: var Point) {.
    importc, libprag.}

proc getBottomLeft*(self: Rect; p: var Point) =
  graphene_rect_get_bottom_left(self, p)

proc getBottomLeft*(self: Rect): Point =
  graphene_rect_get_bottom_left(self, result)

proc graphene_rect_get_bottom_right(self: Rect; p: var Point) {.
    importc, libprag.}

proc getBottomRight*(self: Rect; p: var Point) =
  graphene_rect_get_bottom_right(self, p)

proc getBottomRight*(self: Rect): Point =
  graphene_rect_get_bottom_right(self, result)

proc graphene_rect_get_center(self: Rect; p: var Point) {.
    importc, libprag.}

proc getCenter*(self: Rect; p: var Point) =
  graphene_rect_get_center(self, p)

proc getCenter*(self: Rect): Point =
  graphene_rect_get_center(self, result)

proc graphene_rect_get_height(self: Rect): cfloat {.
    importc, libprag.}

proc getHeight*(self: Rect): cfloat =
  graphene_rect_get_height(self)

proc height*(self: Rect): cfloat =
  graphene_rect_get_height(self)

proc graphene_rect_get_top_left(self: Rect; p: var Point) {.
    importc, libprag.}

proc getTopLeft*(self: Rect; p: var Point) =
  graphene_rect_get_top_left(self, p)

proc getTopLeft*(self: Rect): Point =
  graphene_rect_get_top_left(self, result)

proc graphene_rect_get_top_right(self: Rect; p: var Point) {.
    importc, libprag.}

proc getTopRight*(self: Rect; p: var Point) =
  graphene_rect_get_top_right(self, p)

proc getTopRight*(self: Rect): Point =
  graphene_rect_get_top_right(self, result)

proc graphene_rect_get_vertices(self: Rect; vertices: var ptr array[4, Vec2]) {.
    importc, libprag.}

proc getVertices*(self: Rect; vertices: var ptr array[4, Vec2]) =
  graphene_rect_get_vertices(self, vertices)

proc getVertices*(self: Rect): ptr array[4, Vec2] =
  graphene_rect_get_vertices(self, result)

proc graphene_rect_get_width(self: Rect): cfloat {.
    importc, libprag.}

proc getWidth*(self: Rect): cfloat =
  graphene_rect_get_width(self)

proc width*(self: Rect): cfloat =
  graphene_rect_get_width(self)

proc graphene_rect_get_x(self: Rect): cfloat {.
    importc, libprag.}

proc getX*(self: Rect): cfloat =
  graphene_rect_get_x(self)

proc x*(self: Rect): cfloat =
  graphene_rect_get_x(self)

proc graphene_rect_get_y(self: Rect): cfloat {.
    importc, libprag.}

proc getY*(self: Rect): cfloat =
  graphene_rect_get_y(self)

proc y*(self: Rect): cfloat =
  graphene_rect_get_y(self)

proc graphene_rect_init(self: Rect; x: cfloat; y: cfloat; width: cfloat;
    height: cfloat): ptr Rect {.
    importc, libprag.}

proc init*(self: Rect; x: cfloat; y: cfloat; width: cfloat;
    height: cfloat): ptr Rect =
  graphene_rect_init(self, x, y, width, height)

proc graphene_rect_init_from_rect(self: Rect; src: Rect): ptr Rect {.
    importc, libprag.}

proc initFromRect*(self: Rect; src: Rect): ptr Rect =
  graphene_rect_init_from_rect(self, src)

proc graphene_rect_inset(self: Rect; dX: cfloat; dY: cfloat): ptr Rect {.
    importc, libprag.}

proc inset*(self: Rect; dX: cfloat; dY: cfloat): ptr Rect =
  graphene_rect_inset(self, dX, dY)

proc graphene_rect_inset_r(self: Rect; dX: cfloat; dY: cfloat; res: var Rect) {.
    importc, libprag.}

proc insetR*(self: Rect; dX: cfloat; dY: cfloat; res: var Rect) =
  graphene_rect_inset_r(self, dX, dY, res)

proc graphene_rect_interpolate(self: Rect; b: Rect; factor: cdouble; res: var Rect) {.
    importc, libprag.}

proc interpolate*(self: Rect; b: Rect; factor: cdouble; res: var Rect) =
  graphene_rect_interpolate(self, b, factor, res)

proc graphene_rect_intersection(self: Rect; b: Rect; res: var Rect): gboolean {.
    importc, libprag.}

proc intersection*(self: Rect; b: Rect; res: var Rect = cast[var Rect](nil)): bool =
  toBool(graphene_rect_intersection(self, b, res))

proc graphene_rect_normalize(self: Rect): ptr Rect {.
    importc, libprag.}

proc normalize*(self: Rect): ptr Rect =
  graphene_rect_normalize(self)

proc graphene_rect_normalize_r(self: Rect; res: var Rect) {.
    importc, libprag.}

proc normalizeR*(self: Rect; res: var Rect) =
  graphene_rect_normalize_r(self, res)

proc normalizeR*(self: Rect): Rect =
  graphene_rect_normalize_r(self, result)

proc graphene_rect_offset(self: Rect; dX: cfloat; dY: cfloat): ptr Rect {.
    importc, libprag.}

proc offset*(self: Rect; dX: cfloat; dY: cfloat): ptr Rect =
  graphene_rect_offset(self, dX, dY)

proc graphene_rect_offset_r(self: Rect; dX: cfloat; dY: cfloat; res: var Rect) {.
    importc, libprag.}

proc offsetR*(self: Rect; dX: cfloat; dY: cfloat; res: var Rect) =
  graphene_rect_offset_r(self, dX, dY, res)

proc graphene_rect_round(self: Rect; res: var Rect) {.
    importc, libprag.}

proc round*(self: Rect; res: var Rect) =
  graphene_rect_round(self, res)

proc round*(self: Rect): Rect =
  graphene_rect_round(self, result)

proc graphene_rect_round_extents(self: Rect; res: var Rect) {.
    importc, libprag.}

proc roundExtents*(self: Rect; res: var Rect) =
  graphene_rect_round_extents(self, res)

proc roundExtents*(self: Rect): Rect =
  graphene_rect_round_extents(self, result)

proc graphene_rect_round_to_pixel(self: Rect): ptr Rect {.
    importc, libprag.}

proc roundToPixel*(self: Rect): ptr Rect =
  graphene_rect_round_to_pixel(self)

proc graphene_rect_scale(self: Rect; sH: cfloat; sV: cfloat; res: var Rect) {.
    importc, libprag.}

proc scale*(self: Rect; sH: cfloat; sV: cfloat; res: var Rect) =
  graphene_rect_scale(self, sH, sV, res)

proc graphene_rect_union(self: Rect; b: Rect; res: var Rect) {.
    importc, libprag.}

proc union*(self: Rect; b: Rect; res: var Rect) =
  graphene_rect_union(self, b, res)

proc allocRect*(): ptr Rect {.
    importc: "graphene_rect_alloc", libprag.}

proc zeroRect*(): ptr Rect {.
    importc: "graphene_rect_zero", libprag.}

proc graphene_point3d_normalize_viewport(self: Point3D; viewport: Rect; zNear: cfloat;
    zFar: cfloat; res: var Point3D) {.
    importc, libprag.}

proc normalizeViewport*(self: Point3D; viewport: Rect; zNear: cfloat;
    zFar: cfloat; res: var Point3D) =
  graphene_point3d_normalize_viewport(self, viewport, zNear, zFar, res)

type
  EulerOrder* {.size: sizeof(cint), pure.} = enum
    default = -1
    xyz = 0
    yzx = 1
    zxy = 2
    xzy = 3
    yxz = 4
    zyx = 5
    sxyz = 6
    sxyx = 7
    sxzy = 8
    sxzx = 9
    syzx = 10
    syzy = 11
    syxz = 12
    syxy = 13
    szxy = 14
    szxz = 15
    szyx = 16
    szyz = 17
    rzyx = 18
    rxyx = 19
    ryzx = 20
    rxzx = 21
    rxzy = 22
    ryzy = 23
    rzxy = 24
    ryxy = 25
    ryxz = 26
    rzxz = 27
    rxyz = 28
    rzyz = 29

type
  Euler* {.pure, byRef.} = object
    angles*: Vec3
    order*: EulerOrder

proc graphene_euler_get_type*(): GType {.importc, libprag.}

proc graphene_euler_free(self: Euler) {.
    importc, libprag.}

proc free*(self: Euler) =
  graphene_euler_free(self)

proc graphene_euler_equal(self: Euler; b: Euler): gboolean {.
    importc, libprag.}

proc equal*(self: Euler; b: Euler): bool =
  toBool(graphene_euler_equal(self, b))

proc allocEuler*(): ptr Euler {.
    importc: "graphene_euler_alloc", libprag.}

proc graphene_euler_get_alpha(self: Euler): cfloat {.
    importc, libprag.}

proc getAlpha*(self: Euler): cfloat =
  graphene_euler_get_alpha(self)

proc alpha*(self: Euler): cfloat =
  graphene_euler_get_alpha(self)

proc graphene_euler_get_beta(self: Euler): cfloat {.
    importc, libprag.}

proc getBeta*(self: Euler): cfloat =
  graphene_euler_get_beta(self)

proc beta*(self: Euler): cfloat =
  graphene_euler_get_beta(self)

proc graphene_euler_get_gamma(self: Euler): cfloat {.
    importc, libprag.}

proc getGamma*(self: Euler): cfloat =
  graphene_euler_get_gamma(self)

proc gamma*(self: Euler): cfloat =
  graphene_euler_get_gamma(self)

proc graphene_euler_get_order(self: Euler): EulerOrder {.
    importc, libprag.}

proc getOrder*(self: Euler): EulerOrder =
  graphene_euler_get_order(self)

proc order*(self: Euler): EulerOrder =
  graphene_euler_get_order(self)

proc graphene_euler_get_x(self: Euler): cfloat {.
    importc, libprag.}

proc getX*(self: Euler): cfloat =
  graphene_euler_get_x(self)

proc x*(self: Euler): cfloat =
  graphene_euler_get_x(self)

proc graphene_euler_get_y(self: Euler): cfloat {.
    importc, libprag.}

proc getY*(self: Euler): cfloat =
  graphene_euler_get_y(self)

proc y*(self: Euler): cfloat =
  graphene_euler_get_y(self)

proc graphene_euler_get_z(self: Euler): cfloat {.
    importc, libprag.}

proc getZ*(self: Euler): cfloat =
  graphene_euler_get_z(self)

proc z*(self: Euler): cfloat =
  graphene_euler_get_z(self)

proc graphene_euler_init(self: Euler; x: cfloat; y: cfloat; z: cfloat): ptr Euler {.
    importc, libprag.}

proc init*(self: Euler; x: cfloat; y: cfloat; z: cfloat): ptr Euler =
  graphene_euler_init(self, x, y, z)

proc graphene_euler_init_from_euler(self: Euler; src: Euler): ptr Euler {.
    importc, libprag.}

proc initFromEuler*(self: Euler; src: Euler = cast[var Euler](nil)): ptr Euler =
  graphene_euler_init_from_euler(self, src)

proc graphene_euler_init_from_radians(self: Euler; x: cfloat; y: cfloat;
    z: cfloat; order: EulerOrder): ptr Euler {.
    importc, libprag.}

proc initFromRadians*(self: Euler; x: cfloat; y: cfloat;
    z: cfloat; order: EulerOrder): ptr Euler =
  graphene_euler_init_from_radians(self, x, y, z, order)

proc graphene_euler_init_from_vec3(self: Euler; v: Vec3; order: EulerOrder): ptr Euler {.
    importc, libprag.}

proc initFromVec3*(self: Euler; v: Vec3 = cast[var Vec3](nil);
    order: EulerOrder): ptr Euler =
  graphene_euler_init_from_vec3(self, v, order)

proc graphene_euler_init_with_order(self: Euler; x: cfloat; y: cfloat; z: cfloat;
    order: EulerOrder): ptr Euler {.
    importc, libprag.}

proc initWithOrder*(self: Euler; x: cfloat; y: cfloat; z: cfloat;
    order: EulerOrder): ptr Euler =
  graphene_euler_init_with_order(self, x, y, z, order)

proc graphene_euler_reorder(self: Euler; order: EulerOrder; res: var Euler) {.
    importc, libprag.}

proc reorder*(self: Euler; order: EulerOrder; res: var Euler) =
  graphene_euler_reorder(self, order, res)

proc graphene_euler_to_vec3(self: Euler; res: var Vec3) {.
    importc, libprag.}

proc toVec3*(self: Euler; res: var Vec3) =
  graphene_euler_to_vec3(self, res)

proc toVec3*(self: Euler): Vec3 =
  graphene_euler_to_vec3(self, result)

type
  Simd4X4F* {.pure, byRef.} = object
    x*: Simd4F00
    y*: Simd4F00
    z*: Simd4F00
    w*: Simd4F00

type
  Matrix* {.pure, byRef.} = object
    value*: Simd4X4F

proc graphene_matrix_get_type*(): GType {.importc, libprag.}

proc graphene_matrix_free(self: Matrix) {.
    importc, libprag.}

proc free*(self: Matrix) =
  graphene_matrix_free(self)

proc graphene_matrix_determinant(self: Matrix): cfloat {.
    importc, libprag.}

proc determinant*(self: Matrix): cfloat =
  graphene_matrix_determinant(self)

proc graphene_matrix_equal(self: Matrix; b: Matrix): gboolean {.
    importc, libprag.}

proc equal*(self: Matrix; b: Matrix): bool =
  toBool(graphene_matrix_equal(self, b))

proc graphene_matrix_equal_fast(self: Matrix; b: Matrix): gboolean {.
    importc, libprag.}

proc equalFast*(self: Matrix; b: Matrix): bool =
  toBool(graphene_matrix_equal_fast(self, b))

proc allocMatrix*(): ptr Matrix {.
    importc: "graphene_matrix_alloc", libprag.}

proc graphene_matrix_get_row(self: Matrix; index: uint32; res: var Vec4) {.
    importc, libprag.}

proc getRow*(self: Matrix; index: int; res: var Vec4) =
  graphene_matrix_get_row(self, uint32(index), res)

proc graphene_matrix_get_value(self: Matrix; row: uint32; col: uint32): cfloat {.
    importc, libprag.}

proc getValue*(self: Matrix; row: int; col: int): cfloat =
  graphene_matrix_get_value(self, uint32(row), uint32(col))

proc graphene_matrix_get_x_scale(self: Matrix): cfloat {.
    importc, libprag.}

proc getXScale*(self: Matrix): cfloat =
  graphene_matrix_get_x_scale(self)

proc xScale*(self: Matrix): cfloat =
  graphene_matrix_get_x_scale(self)

proc graphene_matrix_get_x_translation(self: Matrix): cfloat {.
    importc, libprag.}

proc getXTranslation*(self: Matrix): cfloat =
  graphene_matrix_get_x_translation(self)

proc xTranslation*(self: Matrix): cfloat =
  graphene_matrix_get_x_translation(self)

proc graphene_matrix_get_y_scale(self: Matrix): cfloat {.
    importc, libprag.}

proc getYScale*(self: Matrix): cfloat =
  graphene_matrix_get_y_scale(self)

proc yScale*(self: Matrix): cfloat =
  graphene_matrix_get_y_scale(self)

proc graphene_matrix_get_y_translation(self: Matrix): cfloat {.
    importc, libprag.}

proc getYTranslation*(self: Matrix): cfloat =
  graphene_matrix_get_y_translation(self)

proc yTranslation*(self: Matrix): cfloat =
  graphene_matrix_get_y_translation(self)

proc graphene_matrix_get_z_scale(self: Matrix): cfloat {.
    importc, libprag.}

proc getZScale*(self: Matrix): cfloat =
  graphene_matrix_get_z_scale(self)

proc zScale*(self: Matrix): cfloat =
  graphene_matrix_get_z_scale(self)

proc graphene_matrix_get_z_translation(self: Matrix): cfloat {.
    importc, libprag.}

proc getZTranslation*(self: Matrix): cfloat =
  graphene_matrix_get_z_translation(self)

proc zTranslation*(self: Matrix): cfloat =
  graphene_matrix_get_z_translation(self)

proc graphene_matrix_init_from_2d(self: Matrix; xx: cdouble; yx: cdouble;
    xy: cdouble; yy: cdouble; x_0: cdouble; y_0: cdouble): ptr Matrix {.
    importc, libprag.}

proc initFrom_2d*(self: Matrix; xx: cdouble; yx: cdouble;
    xy: cdouble; yy: cdouble; x_0: cdouble; y_0: cdouble): ptr Matrix =
  graphene_matrix_init_from_2d(self, xx, yx, xy, yy, x_0, y_0)

proc graphene_matrix_init_from_float(self: Matrix; v: ptr array[16, cfloat]): ptr Matrix {.
    importc, libprag.}

proc initFromFloat*(self: Matrix; v: ptr array[16, cfloat]): ptr Matrix =
  graphene_matrix_init_from_float(self, v)

proc graphene_matrix_init_from_matrix(self: Matrix; src: Matrix): ptr Matrix {.
    importc, libprag.}

proc initFromMatrix*(self: Matrix; src: Matrix): ptr Matrix =
  graphene_matrix_init_from_matrix(self, src)

proc graphene_matrix_init_from_vec4(self: Matrix; v0: Vec4; v1: Vec4; v2: Vec4;
    v3: Vec4): ptr Matrix {.
    importc, libprag.}

proc initFromVec4*(self: Matrix; v0: Vec4; v1: Vec4; v2: Vec4;
    v3: Vec4): ptr Matrix =
  graphene_matrix_init_from_vec4(self, v0, v1, v2, v3)

proc graphene_matrix_init_frustum(self: Matrix; left: cfloat; right: cfloat;
    bottom: cfloat; top: cfloat; zNear: cfloat; zFar: cfloat): ptr Matrix {.
    importc, libprag.}

proc initFrustum*(self: Matrix; left: cfloat; right: cfloat;
    bottom: cfloat; top: cfloat; zNear: cfloat; zFar: cfloat): ptr Matrix =
  graphene_matrix_init_frustum(self, left, right, bottom, top, zNear, zFar)

proc graphene_matrix_init_identity(self: Matrix): ptr Matrix {.
    importc, libprag.}

proc initIdentity*(self: Matrix): ptr Matrix =
  graphene_matrix_init_identity(self)

proc graphene_matrix_init_look_at(self: Matrix; eye: Vec3; center: Vec3;
    up: Vec3): ptr Matrix {.
    importc, libprag.}

proc initLookAt*(self: Matrix; eye: Vec3; center: Vec3;
    up: Vec3): ptr Matrix =
  graphene_matrix_init_look_at(self, eye, center, up)

proc graphene_matrix_init_ortho(self: Matrix; left: cfloat; right: cfloat;
    top: cfloat; bottom: cfloat; zNear: cfloat; zFar: cfloat): ptr Matrix {.
    importc, libprag.}

proc initOrtho*(self: Matrix; left: cfloat; right: cfloat;
    top: cfloat; bottom: cfloat; zNear: cfloat; zFar: cfloat): ptr Matrix =
  graphene_matrix_init_ortho(self, left, right, top, bottom, zNear, zFar)

proc graphene_matrix_init_perspective(self: Matrix; fovy: cfloat; aspect: cfloat;
    zNear: cfloat; zFar: cfloat): ptr Matrix {.
    importc, libprag.}

proc initPerspective*(self: Matrix; fovy: cfloat; aspect: cfloat;
    zNear: cfloat; zFar: cfloat): ptr Matrix =
  graphene_matrix_init_perspective(self, fovy, aspect, zNear, zFar)

proc graphene_matrix_init_rotate(self: Matrix; angle: cfloat; axis: Vec3): ptr Matrix {.
    importc, libprag.}

proc initRotate*(self: Matrix; angle: cfloat; axis: Vec3): ptr Matrix =
  graphene_matrix_init_rotate(self, angle, axis)

proc graphene_matrix_init_scale(self: Matrix; x: cfloat; y: cfloat; z: cfloat): ptr Matrix {.
    importc, libprag.}

proc initScale*(self: Matrix; x: cfloat; y: cfloat; z: cfloat): ptr Matrix =
  graphene_matrix_init_scale(self, x, y, z)

proc graphene_matrix_init_skew(self: Matrix; xSkew: cfloat; ySkew: cfloat): ptr Matrix {.
    importc, libprag.}

proc initSkew*(self: Matrix; xSkew: cfloat; ySkew: cfloat): ptr Matrix =
  graphene_matrix_init_skew(self, xSkew, ySkew)

proc graphene_matrix_init_translate(self: Matrix; p: Point3D): ptr Matrix {.
    importc, libprag.}

proc initTranslate*(self: Matrix; p: Point3D): ptr Matrix =
  graphene_matrix_init_translate(self, p)

proc graphene_matrix_interpolate(self: Matrix; b: Matrix; factor: cdouble;
    res: var Matrix) {.
    importc, libprag.}

proc interpolate*(self: Matrix; b: Matrix; factor: cdouble;
    res: var Matrix) =
  graphene_matrix_interpolate(self, b, factor, res)

proc graphene_matrix_inverse(self: Matrix; res: var Matrix): gboolean {.
    importc, libprag.}

proc inverse*(self: Matrix; res: var Matrix): bool =
  toBool(graphene_matrix_inverse(self, res))

proc graphene_matrix_is_2d(self: Matrix): gboolean {.
    importc, libprag.}

proc is_2d*(self: Matrix): bool =
  toBool(graphene_matrix_is_2d(self))

proc graphene_matrix_is_backface_visible(self: Matrix): gboolean {.
    importc, libprag.}

proc isBackfaceVisible*(self: Matrix): bool =
  toBool(graphene_matrix_is_backface_visible(self))

proc graphene_matrix_is_identity(self: Matrix): gboolean {.
    importc, libprag.}

proc isIdentity*(self: Matrix): bool =
  toBool(graphene_matrix_is_identity(self))

proc graphene_matrix_is_singular(self: Matrix): gboolean {.
    importc, libprag.}

proc isSingular*(self: Matrix): bool =
  toBool(graphene_matrix_is_singular(self))

proc graphene_matrix_multiply(self: Matrix; b: Matrix; res: var Matrix) {.
    importc, libprag.}

proc multiply*(self: Matrix; b: Matrix; res: var Matrix) =
  graphene_matrix_multiply(self, b, res)

proc graphene_matrix_near(self: Matrix; b: Matrix; epsilon: cfloat): gboolean {.
    importc, libprag.}

proc near*(self: Matrix; b: Matrix; epsilon: cfloat): bool =
  toBool(graphene_matrix_near(self, b, epsilon))

proc graphene_matrix_normalize(self: Matrix; res: var Matrix) {.
    importc, libprag.}

proc normalize*(self: Matrix; res: var Matrix) =
  graphene_matrix_normalize(self, res)

proc normalize*(self: Matrix): Matrix =
  graphene_matrix_normalize(self, result)

proc graphene_matrix_perspective(self: Matrix; depth: cfloat; res: var Matrix) {.
    importc, libprag.}

proc perspective*(self: Matrix; depth: cfloat; res: var Matrix) =
  graphene_matrix_perspective(self, depth, res)

proc graphene_matrix_print(self: Matrix) {.
    importc, libprag.}

proc print*(self: Matrix) =
  graphene_matrix_print(self)

proc graphene_matrix_project_point(self: Matrix; p: Point; res: var Point) {.
    importc, libprag.}

proc projectPoint*(self: Matrix; p: Point; res: var Point) =
  graphene_matrix_project_point(self, p, res)

proc graphene_matrix_project_rect_bounds(self: Matrix; r: Rect; res: var Rect) {.
    importc, libprag.}

proc projectRectBounds*(self: Matrix; r: Rect; res: var Rect) =
  graphene_matrix_project_rect_bounds(self, r, res)

proc graphene_matrix_rotate(self: Matrix; angle: cfloat; axis: Vec3) {.
    importc, libprag.}

proc rotate*(self: Matrix; angle: cfloat; axis: Vec3) =
  graphene_matrix_rotate(self, angle, axis)

proc graphene_matrix_rotate_euler(self: Matrix; e: Euler) {.
    importc, libprag.}

proc rotateEuler*(self: Matrix; e: Euler) =
  graphene_matrix_rotate_euler(self, e)

proc graphene_matrix_rotate_x(self: Matrix; angle: cfloat) {.
    importc, libprag.}

proc rotateX*(self: Matrix; angle: cfloat) =
  graphene_matrix_rotate_x(self, angle)

proc graphene_matrix_rotate_y(self: Matrix; angle: cfloat) {.
    importc, libprag.}

proc rotateY*(self: Matrix; angle: cfloat) =
  graphene_matrix_rotate_y(self, angle)

proc graphene_matrix_rotate_z(self: Matrix; angle: cfloat) {.
    importc, libprag.}

proc rotateZ*(self: Matrix; angle: cfloat) =
  graphene_matrix_rotate_z(self, angle)

proc graphene_matrix_scale(self: Matrix; factorX: cfloat; factorY: cfloat;
    factorZ: cfloat) {.
    importc, libprag.}

proc scale*(self: Matrix; factorX: cfloat; factorY: cfloat;
    factorZ: cfloat) =
  graphene_matrix_scale(self, factorX, factorY, factorZ)

proc graphene_matrix_skew_xy(self: Matrix; factor: cfloat) {.
    importc, libprag.}

proc skewXy*(self: Matrix; factor: cfloat) =
  graphene_matrix_skew_xy(self, factor)

proc graphene_matrix_skew_xz(self: Matrix; factor: cfloat) {.
    importc, libprag.}

proc skewXz*(self: Matrix; factor: cfloat) =
  graphene_matrix_skew_xz(self, factor)

proc graphene_matrix_skew_yz(self: Matrix; factor: cfloat) {.
    importc, libprag.}

proc skewYz*(self: Matrix; factor: cfloat) =
  graphene_matrix_skew_yz(self, factor)

proc graphene_matrix_to_2d(self: Matrix; xx: var cdouble; yx: var cdouble;
    xy: var cdouble; yy: var cdouble; x_0: var cdouble; y_0: var cdouble): gboolean {.
    importc, libprag.}

proc to_2d*(self: Matrix; xx: var cdouble; yx: var cdouble;
    xy: var cdouble; yy: var cdouble; x_0: var cdouble; y_0: var cdouble): bool =
  toBool(graphene_matrix_to_2d(self, xx, yx, xy, yy, x_0, y_0))

proc graphene_matrix_to_float(self: Matrix; v: var ptr array[16, cfloat]) {.
    importc, libprag.}

proc toFloat*(self: Matrix; v: var ptr array[16, cfloat]) =
  graphene_matrix_to_float(self, v)

proc toFloat*(self: Matrix): ptr array[16, cfloat] =
  graphene_matrix_to_float(self, result)

proc graphene_matrix_transform_bounds(self: Matrix; r: Rect; res: var Rect) {.
    importc, libprag.}

proc transformBounds*(self: Matrix; r: Rect; res: var Rect) =
  graphene_matrix_transform_bounds(self, r, res)

proc graphene_matrix_transform_box(self: Matrix; b: Box; res: var Box) {.
    importc, libprag.}

proc transformBox*(self: Matrix; b: Box; res: var Box) =
  graphene_matrix_transform_box(self, b, res)

proc graphene_matrix_transform_point(self: Matrix; p: Point; res: var Point) {.
    importc, libprag.}

proc transformPoint*(self: Matrix; p: Point; res: var Point) =
  graphene_matrix_transform_point(self, p, res)

proc graphene_matrix_transform_point3d(self: Matrix; p: Point3D; res: var Point3D) {.
    importc, libprag.}

proc transformPoint3d*(self: Matrix; p: Point3D; res: var Point3D) =
  graphene_matrix_transform_point3d(self, p, res)

proc graphene_matrix_transform_sphere(self: Matrix; s: Sphere; res: var Sphere) {.
    importc, libprag.}

proc transformSphere*(self: Matrix; s: Sphere; res: var Sphere) =
  graphene_matrix_transform_sphere(self, s, res)

proc graphene_matrix_transform_vec3(self: Matrix; v: Vec3; res: var Vec3) {.
    importc, libprag.}

proc transformVec3*(self: Matrix; v: Vec3; res: var Vec3) =
  graphene_matrix_transform_vec3(self, v, res)

proc graphene_matrix_transform_vec4(self: Matrix; v: Vec4; res: var Vec4) {.
    importc, libprag.}

proc transformVec4*(self: Matrix; v: Vec4; res: var Vec4) =
  graphene_matrix_transform_vec4(self, v, res)

proc graphene_matrix_translate(self: Matrix; pos: Point3D) {.
    importc, libprag.}

proc translate*(self: Matrix; pos: Point3D) =
  graphene_matrix_translate(self, pos)

proc graphene_matrix_transpose(self: Matrix; res: var Matrix) {.
    importc, libprag.}

proc transpose*(self: Matrix; res: var Matrix) =
  graphene_matrix_transpose(self, res)

proc transpose*(self: Matrix): Matrix =
  graphene_matrix_transpose(self, result)

proc graphene_matrix_unproject_point3d(self: Matrix; modelview: Matrix; point: Point3D;
    res: var Point3D) {.
    importc, libprag.}

proc unprojectPoint3d*(self: Matrix; modelview: Matrix; point: Point3D;
    res: var Point3D) =
  graphene_matrix_unproject_point3d(self, modelview, point, res)

proc graphene_matrix_untransform_bounds(self: Matrix; r: Rect; bounds: Rect;
    res: var Rect) {.
    importc, libprag.}

proc untransformBounds*(self: Matrix; r: Rect; bounds: Rect;
    res: var Rect) =
  graphene_matrix_untransform_bounds(self, r, bounds, res)

proc graphene_matrix_untransform_point(self: Matrix; p: Point; bounds: Rect;
    res: var Point): gboolean {.
    importc, libprag.}

proc untransformPoint*(self: Matrix; p: Point; bounds: Rect;
    res: var Point): bool =
  toBool(graphene_matrix_untransform_point(self, p, bounds, res))

proc graphene_euler_init_from_matrix(self: Euler; m: Matrix; order: EulerOrder): ptr Euler {.
    importc, libprag.}

proc initFromMatrix*(self: Euler; m: Matrix = cast[var Matrix](nil);
    order: EulerOrder): ptr Euler =
  graphene_euler_init_from_matrix(self, m, order)

proc graphene_euler_to_matrix(self: Euler; res: var Matrix) {.
    importc, libprag.}

proc toMatrix*(self: Euler; res: var Matrix) =
  graphene_euler_to_matrix(self, res)

proc toMatrix*(self: Euler): Matrix =
  graphene_euler_to_matrix(self, result)

type
  Ray* {.pure, byRef.} = object
    origin*: Vec3
    direction*: Vec3

proc graphene_ray_get_type*(): GType {.importc, libprag.}

proc graphene_ray_free(self: Ray) {.
    importc, libprag.}

proc free*(self: Ray) =
  graphene_ray_free(self)

proc graphene_ray_equal(self: Ray; b: Ray): gboolean {.
    importc, libprag.}

proc equal*(self: Ray; b: Ray): bool =
  toBool(graphene_ray_equal(self, b))

proc allocRay*(): ptr Ray {.
    importc: "graphene_ray_alloc", libprag.}

proc graphene_ray_get_closest_point_to_point(self: Ray; p: Point3D; res: var Point3D) {.
    importc, libprag.}

proc getClosestPointToPoint*(self: Ray; p: Point3D; res: var Point3D) =
  graphene_ray_get_closest_point_to_point(self, p, res)

proc graphene_ray_get_direction(self: Ray; direction: var Vec3) {.
    importc, libprag.}

proc getDirection*(self: Ray; direction: var Vec3) =
  graphene_ray_get_direction(self, direction)

proc getDirection*(self: Ray): Vec3 =
  graphene_ray_get_direction(self, result)

proc graphene_ray_get_distance_to_point(self: Ray; p: Point3D): cfloat {.
    importc, libprag.}

proc getDistanceToPoint*(self: Ray; p: Point3D): cfloat =
  graphene_ray_get_distance_to_point(self, p)

proc graphene_ray_get_origin(self: Ray; origin: var Point3D) {.
    importc, libprag.}

proc getOrigin*(self: Ray; origin: var Point3D) =
  graphene_ray_get_origin(self, origin)

proc getOrigin*(self: Ray): Point3D =
  graphene_ray_get_origin(self, result)

proc graphene_ray_get_position_at(self: Ray; t: cfloat; position: var Point3D) {.
    importc, libprag.}

proc getPositionAt*(self: Ray; t: cfloat; position: var Point3D) =
  graphene_ray_get_position_at(self, t, position)

proc graphene_ray_init(self: Ray; origin: Point3D; direction: Vec3): ptr Ray {.
    importc, libprag.}

proc init*(self: Ray; origin: Point3D = cast[var Point3D](nil);
    direction: Vec3 = cast[var Vec3](nil)): ptr Ray =
  graphene_ray_init(self, origin, direction)

proc graphene_ray_init_from_ray(self: Ray; src: Ray): ptr Ray {.
    importc, libprag.}

proc initFromRay*(self: Ray; src: Ray): ptr Ray =
  graphene_ray_init_from_ray(self, src)

proc graphene_ray_init_from_vec3(self: Ray; origin: Vec3; direction: Vec3): ptr Ray {.
    importc, libprag.}

proc initFromVec3*(self: Ray; origin: Vec3 = cast[var Vec3](nil);
    direction: Vec3 = cast[var Vec3](nil)): ptr Ray =
  graphene_ray_init_from_vec3(self, origin, direction)

proc graphene_ray_intersects_box(self: Ray; b: Box): gboolean {.
    importc, libprag.}

proc intersectsBox*(self: Ray; b: Box): bool =
  toBool(graphene_ray_intersects_box(self, b))

proc graphene_ray_intersects_sphere(self: Ray; s: Sphere): gboolean {.
    importc, libprag.}

proc intersectsSphere*(self: Ray; s: Sphere): bool =
  toBool(graphene_ray_intersects_sphere(self, s))

proc graphene_matrix_transform_ray(self: Matrix; r: Ray; res: var Ray) {.
    importc, libprag.}

proc transformRay*(self: Matrix; r: Ray; res: var Ray) =
  graphene_matrix_transform_ray(self, r, res)

type
  Plane* {.pure, byRef.} = object
    normal*: Vec3
    constant*: cfloat

proc graphene_plane_get_type*(): GType {.importc, libprag.}

proc graphene_plane_free(self: Plane) {.
    importc, libprag.}

proc free*(self: Plane) =
  graphene_plane_free(self)

proc graphene_plane_distance(self: Plane; point: Point3D): cfloat {.
    importc, libprag.}

proc distance*(self: Plane; point: Point3D): cfloat =
  graphene_plane_distance(self, point)

proc graphene_plane_equal(self: Plane; b: Plane): gboolean {.
    importc, libprag.}

proc equal*(self: Plane; b: Plane): bool =
  toBool(graphene_plane_equal(self, b))

proc allocPlane*(): ptr Plane {.
    importc: "graphene_plane_alloc", libprag.}

proc graphene_plane_get_constant(self: Plane): cfloat {.
    importc, libprag.}

proc getConstant*(self: Plane): cfloat =
  graphene_plane_get_constant(self)

proc constant*(self: Plane): cfloat =
  graphene_plane_get_constant(self)

proc graphene_plane_get_normal(self: Plane; normal: var Vec3) {.
    importc, libprag.}

proc getNormal*(self: Plane; normal: var Vec3) =
  graphene_plane_get_normal(self, normal)

proc getNormal*(self: Plane): Vec3 =
  graphene_plane_get_normal(self, result)

proc graphene_plane_init(self: Plane; normal: Vec3; constant: cfloat): ptr Plane {.
    importc, libprag.}

proc init*(self: Plane; normal: Vec3 = cast[var Vec3](nil);
    constant: cfloat): ptr Plane =
  graphene_plane_init(self, normal, constant)

proc graphene_plane_init_from_plane(self: Plane; src: Plane): ptr Plane {.
    importc, libprag.}

proc initFromPlane*(self: Plane; src: Plane): ptr Plane =
  graphene_plane_init_from_plane(self, src)

proc graphene_plane_init_from_point(self: Plane; normal: Vec3; point: Point3D): ptr Plane {.
    importc, libprag.}

proc initFromPoint*(self: Plane; normal: Vec3; point: Point3D): ptr Plane =
  graphene_plane_init_from_point(self, normal, point)

proc graphene_plane_init_from_points(self: Plane; a: Point3D; b: Point3D;
    c: Point3D): ptr Plane {.
    importc, libprag.}

proc initFromPoints*(self: Plane; a: Point3D; b: Point3D;
    c: Point3D): ptr Plane =
  graphene_plane_init_from_points(self, a, b, c)

proc graphene_plane_init_from_vec4(self: Plane; src: Vec4): ptr Plane {.
    importc, libprag.}

proc initFromVec4*(self: Plane; src: Vec4): ptr Plane =
  graphene_plane_init_from_vec4(self, src)

proc graphene_plane_negate(self: Plane; res: var Plane) {.
    importc, libprag.}

proc negate*(self: Plane; res: var Plane) =
  graphene_plane_negate(self, res)

proc negate*(self: Plane): Plane =
  graphene_plane_negate(self, result)

proc graphene_plane_normalize(self: Plane; res: var Plane) {.
    importc, libprag.}

proc normalize*(self: Plane; res: var Plane) =
  graphene_plane_normalize(self, res)

proc normalize*(self: Plane): Plane =
  graphene_plane_normalize(self, result)

proc graphene_plane_transform(self: Plane; matrix: Matrix; normalMatrix: Matrix;
    res: var Plane) {.
    importc, libprag.}

proc transform*(self: Plane; matrix: Matrix; normalMatrix: Matrix = cast[var Matrix](nil);
    res: var Plane) =
  graphene_plane_transform(self, matrix, normalMatrix, res)

proc graphene_ray_get_distance_to_plane(self: Ray; p: Plane): cfloat {.
    importc, libprag.}

proc getDistanceToPlane*(self: Ray; p: Plane): cfloat =
  graphene_ray_get_distance_to_plane(self, p)

type
  RayIntersectionKind* {.size: sizeof(cint), pure.} = enum
    none = 0
    enter = 1
    leave = 2

proc graphene_ray_intersect_box(self: Ray; b: Box; tOut: var cfloat): RayIntersectionKind {.
    importc, libprag.}

proc intersectBox*(self: Ray; b: Box; tOut: var cfloat): RayIntersectionKind =
  graphene_ray_intersect_box(self, b, tOut)

proc graphene_ray_intersect_sphere(self: Ray; s: Sphere; tOut: var cfloat): RayIntersectionKind {.
    importc, libprag.}

proc intersectSphere*(self: Ray; s: Sphere; tOut: var cfloat): RayIntersectionKind =
  graphene_ray_intersect_sphere(self, s, tOut)

type
  Triangle00* {.pure.} = object
  Triangle* = ref object
    impl*: ptr Triangle00
    ignoreFinalizer*: bool

proc graphene_triangle_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGrapheneTriangle*(self: Triangle) =
  if not self.ignoreFinalizer:
    boxedFree(graphene_triangle_get_type(), cast[ptr Triangle00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Triangle()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(graphene_triangle_get_type(), cast[ptr Triangle00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Triangle) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGrapheneTriangle)

proc graphene_triangle_free(self: ptr Triangle00) {.
    importc, libprag.}

proc free*(self: Triangle) =
  graphene_triangle_free(cast[ptr Triangle00](self.impl))

proc finalizerfree*(self: Triangle) =
  if not self.ignoreFinalizer:
    graphene_triangle_free(cast[ptr Triangle00](self.impl))

proc graphene_triangle_contains_point(self: ptr Triangle00; p: Point3D): gboolean {.
    importc, libprag.}

proc containsPoint*(self: Triangle; p: Point3D): bool =
  toBool(graphene_triangle_contains_point(cast[ptr Triangle00](self.impl), p))

proc graphene_triangle_equal(self: ptr Triangle00; b: ptr Triangle00): gboolean {.
    importc, libprag.}

proc equal*(self: Triangle; b: Triangle): bool =
  toBool(graphene_triangle_equal(cast[ptr Triangle00](self.impl), cast[ptr Triangle00](b.impl)))

proc graphene_triangle_alloc(): ptr Triangle00 {.
    importc, libprag.}

proc allocTriangle*(): Triangle =
  fnew(result, gBoxedFreeGrapheneTriangle)
  result.impl = graphene_triangle_alloc()

proc allocTriangle*(tdesc: typedesc): tdesc =
  assert(result is Triangle)
  fnew(result, gBoxedFreeGrapheneTriangle)
  result.impl = graphene_triangle_alloc()

proc allocTriangle*[T](result: var T) {.deprecated.} =
  assert(result is Triangle)
  fnew(result, gBoxedFreeGrapheneTriangle)
  result.impl = graphene_triangle_alloc()

proc graphene_triangle_get_area(self: ptr Triangle00): cfloat {.
    importc, libprag.}

proc getArea*(self: Triangle): cfloat =
  graphene_triangle_get_area(cast[ptr Triangle00](self.impl))

proc area*(self: Triangle): cfloat =
  graphene_triangle_get_area(cast[ptr Triangle00](self.impl))

proc graphene_triangle_get_barycoords(self: ptr Triangle00; p: Point3D; res: var Vec2): gboolean {.
    importc, libprag.}

proc getBarycoords*(self: Triangle; p: Point3D = cast[var Point3D](nil);
    res: var Vec2): bool =
  toBool(graphene_triangle_get_barycoords(cast[ptr Triangle00](self.impl), p, res))

proc graphene_triangle_get_bounding_box(self: ptr Triangle00; res: var Box) {.
    importc, libprag.}

proc getBoundingBox*(self: Triangle; res: var Box) =
  graphene_triangle_get_bounding_box(cast[ptr Triangle00](self.impl), res)

proc getBoundingBox*(self: Triangle): Box =
  graphene_triangle_get_bounding_box(cast[ptr Triangle00](self.impl), result)

proc graphene_triangle_get_midpoint(self: ptr Triangle00; res: var Point3D) {.
    importc, libprag.}

proc getMidpoint*(self: Triangle; res: var Point3D) =
  graphene_triangle_get_midpoint(cast[ptr Triangle00](self.impl), res)

proc getMidpoint*(self: Triangle): Point3D =
  graphene_triangle_get_midpoint(cast[ptr Triangle00](self.impl), result)

proc graphene_triangle_get_normal(self: ptr Triangle00; res: var Vec3) {.
    importc, libprag.}

proc getNormal*(self: Triangle; res: var Vec3) =
  graphene_triangle_get_normal(cast[ptr Triangle00](self.impl), res)

proc getNormal*(self: Triangle): Vec3 =
  graphene_triangle_get_normal(cast[ptr Triangle00](self.impl), result)

proc graphene_triangle_get_plane(self: ptr Triangle00; res: var Plane) {.
    importc, libprag.}

proc getPlane*(self: Triangle; res: var Plane) =
  graphene_triangle_get_plane(cast[ptr Triangle00](self.impl), res)

proc getPlane*(self: Triangle): Plane =
  graphene_triangle_get_plane(cast[ptr Triangle00](self.impl), result)

proc graphene_triangle_get_points(self: ptr Triangle00; a: var Point3D; b: var Point3D;
    c: var Point3D) {.
    importc, libprag.}

proc getPoints*(self: Triangle; a: var Point3D = cast[var Point3D](nil);
    b: var Point3D = cast[var Point3D](nil); c: var Point3D = cast[var Point3D](nil)) =
  graphene_triangle_get_points(cast[ptr Triangle00](self.impl), a, b, c)

proc graphene_triangle_get_uv(self: ptr Triangle00; p: Point3D; uvA: Vec2;
    uvB: Vec2; uvC: Vec2; res: var Vec2): gboolean {.
    importc, libprag.}

proc getUv*(self: Triangle; p: Point3D = cast[var Point3D](nil);
    uvA: Vec2; uvB: Vec2; uvC: Vec2; res: var Vec2): bool =
  toBool(graphene_triangle_get_uv(cast[ptr Triangle00](self.impl), p, uvA, uvB, uvC, res))

proc graphene_triangle_get_vertices(self: ptr Triangle00; a: var Vec3; b: var Vec3;
    c: var Vec3) {.
    importc, libprag.}

proc getVertices*(self: Triangle; a: var Vec3 = cast[var Vec3](nil);
    b: var Vec3 = cast[var Vec3](nil); c: var Vec3 = cast[var Vec3](nil)) =
  graphene_triangle_get_vertices(cast[ptr Triangle00](self.impl), a, b, c)

proc graphene_triangle_init_from_float(self: ptr Triangle00; a: ptr array[3, cfloat];
    b: ptr array[3, cfloat]; c: ptr array[3, cfloat]): ptr Triangle00 {.
    importc, libprag.}

proc initFromFloat*(self: Triangle; a: ptr array[3, cfloat];
    b: ptr array[3, cfloat]; c: ptr array[3, cfloat]): Triangle =
  fnew(result, gBoxedFreeGrapheneTriangle)
  result.impl = graphene_triangle_init_from_float(cast[ptr Triangle00](self.impl), a, b, c)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(graphene_triangle_get_type(), result.impl))

proc graphene_triangle_init_from_point3d(self: ptr Triangle00; a: Point3D;
    b: Point3D; c: Point3D): ptr Triangle00 {.
    importc, libprag.}

proc initFromPoint3d*(self: Triangle; a: Point3D = cast[var Point3D](nil);
    b: Point3D = cast[var Point3D](nil); c: Point3D = cast[var Point3D](nil)): Triangle =
  fnew(result, gBoxedFreeGrapheneTriangle)
  result.impl = graphene_triangle_init_from_point3d(cast[ptr Triangle00](self.impl), a, b, c)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(graphene_triangle_get_type(), result.impl))

proc graphene_triangle_init_from_vec3(self: ptr Triangle00; a: Vec3; b: Vec3;
    c: Vec3): ptr Triangle00 {.
    importc, libprag.}

proc initFromVec3*(self: Triangle; a: Vec3 = cast[var Vec3](nil);
    b: Vec3 = cast[var Vec3](nil); c: Vec3 = cast[var Vec3](nil)): Triangle =
  fnew(result, gBoxedFreeGrapheneTriangle)
  result.impl = graphene_triangle_init_from_vec3(cast[ptr Triangle00](self.impl), a, b, c)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(graphene_triangle_get_type(), result.impl))

proc graphene_ray_intersect_triangle(self: Ray; t: ptr Triangle00; tOut: var cfloat): RayIntersectionKind {.
    importc, libprag.}

proc intersectTriangle*(self: Ray; t: Triangle; tOut: var cfloat): RayIntersectionKind =
  graphene_ray_intersect_triangle(self, cast[ptr Triangle00](t.impl), tOut)

proc graphene_ray_intersects_triangle(self: Ray; t: ptr Triangle00): gboolean {.
    importc, libprag.}

proc intersectsTriangle*(self: Ray; t: Triangle): bool =
  toBool(graphene_ray_intersects_triangle(self, cast[ptr Triangle00](t.impl)))

type
  Quad* {.pure, byRef.} = object
    points*: array[4, Point]

proc graphene_quad_get_type*(): GType {.importc, libprag.}

proc graphene_quad_free(self: Quad) {.
    importc, libprag.}

proc free*(self: Quad) =
  graphene_quad_free(self)

proc graphene_quad_bounds(self: Quad; r: var Rect) {.
    importc, libprag.}

proc bounds*(self: Quad; r: var Rect) =
  graphene_quad_bounds(self, r)

proc bounds*(self: Quad): Rect =
  graphene_quad_bounds(self, result)

proc graphene_quad_contains(self: Quad; p: Point): gboolean {.
    importc, libprag.}

proc contains*(self: Quad; p: Point): bool =
  toBool(graphene_quad_contains(self, p))

proc allocQuad*(): ptr Quad {.
    importc: "graphene_quad_alloc", libprag.}

proc graphene_quad_get_point(self: Quad; index: uint32): ptr Point {.
    importc, libprag.}

proc getPoint*(self: Quad; index: int): ptr Point =
  graphene_quad_get_point(self, uint32(index))

proc graphene_quad_init(self: Quad; p1: Point; p2: Point; p3: Point; p4: Point): ptr Quad {.
    importc, libprag.}

proc init*(self: Quad; p1: Point; p2: Point; p3: Point; p4: Point): ptr Quad =
  graphene_quad_init(self, p1, p2, p3, p4)

proc graphene_quad_init_from_points(self: Quad; points: ptr array[4, Point]): ptr Quad {.
    importc, libprag.}

proc initFromPoints*(self: Quad; points: ptr array[4, Point]): ptr Quad =
  graphene_quad_init_from_points(self, points)

proc graphene_quad_init_from_rect(self: Quad; r: Rect): ptr Quad {.
    importc, libprag.}

proc initFromRect*(self: Quad; r: Rect): ptr Quad =
  graphene_quad_init_from_rect(self, r)

proc graphene_matrix_project_rect(self: Matrix; r: Rect; res: var Quad) {.
    importc, libprag.}

proc projectRect*(self: Matrix; r: Rect; res: var Quad) =
  graphene_matrix_project_rect(self, r, res)

proc graphene_matrix_transform_rect(self: Matrix; r: Rect; res: var Quad) {.
    importc, libprag.}

proc transformRect*(self: Matrix; r: Rect; res: var Quad) =
  graphene_matrix_transform_rect(self, r, res)

type
  Quaternion* {.pure, byRef.} = object
    x*: cfloat
    y*: cfloat
    z*: cfloat
    w*: cfloat

proc graphene_quaternion_get_type*(): GType {.importc, libprag.}

proc graphene_quaternion_free(self: Quaternion) {.
    importc, libprag.}

proc free*(self: Quaternion) =
  graphene_quaternion_free(self)

proc graphene_quaternion_add(self: Quaternion; b: Quaternion; res: var Quaternion) {.
    importc, libprag.}

proc add*(self: Quaternion; b: Quaternion; res: var Quaternion) =
  graphene_quaternion_add(self, b, res)

proc graphene_quaternion_dot(self: Quaternion; b: Quaternion): cfloat {.
    importc, libprag.}

proc dot*(self: Quaternion; b: Quaternion): cfloat =
  graphene_quaternion_dot(self, b)

proc graphene_quaternion_equal(self: Quaternion; b: Quaternion): gboolean {.
    importc, libprag.}

proc equal*(self: Quaternion; b: Quaternion): bool =
  toBool(graphene_quaternion_equal(self, b))

proc allocQuaternion*(): ptr Quaternion {.
    importc: "graphene_quaternion_alloc", libprag.}

proc graphene_quaternion_init(self: Quaternion; x: cfloat; y: cfloat; z: cfloat;
    w: cfloat): ptr Quaternion {.
    importc, libprag.}

proc init*(self: Quaternion; x: cfloat; y: cfloat; z: cfloat;
    w: cfloat): ptr Quaternion =
  graphene_quaternion_init(self, x, y, z, w)

proc graphene_quaternion_init_from_angle_vec3(self: Quaternion; angle: cfloat;
    axis: Vec3): ptr Quaternion {.
    importc, libprag.}

proc initFromAngleVec3*(self: Quaternion; angle: cfloat;
    axis: Vec3): ptr Quaternion =
  graphene_quaternion_init_from_angle_vec3(self, angle, axis)

proc graphene_quaternion_init_from_angles(self: Quaternion; degX: cfloat;
    degY: cfloat; degZ: cfloat): ptr Quaternion {.
    importc, libprag.}

proc initFromAngles*(self: Quaternion; degX: cfloat;
    degY: cfloat; degZ: cfloat): ptr Quaternion =
  graphene_quaternion_init_from_angles(self, degX, degY, degZ)

proc graphene_quaternion_init_from_euler(self: Quaternion; e: Euler): ptr Quaternion {.
    importc, libprag.}

proc initFromEuler*(self: Quaternion; e: Euler): ptr Quaternion =
  graphene_quaternion_init_from_euler(self, e)

proc graphene_quaternion_init_from_matrix(self: Quaternion; m: Matrix): ptr Quaternion {.
    importc, libprag.}

proc initFromMatrix*(self: Quaternion; m: Matrix): ptr Quaternion =
  graphene_quaternion_init_from_matrix(self, m)

proc graphene_quaternion_init_from_quaternion(self: Quaternion; src: Quaternion): ptr Quaternion {.
    importc, libprag.}

proc initFromQuaternion*(self: Quaternion; src: Quaternion): ptr Quaternion =
  graphene_quaternion_init_from_quaternion(self, src)

proc graphene_quaternion_init_from_radians(self: Quaternion; radX: cfloat;
    radY: cfloat; radZ: cfloat): ptr Quaternion {.
    importc, libprag.}

proc initFromRadians*(self: Quaternion; radX: cfloat;
    radY: cfloat; radZ: cfloat): ptr Quaternion =
  graphene_quaternion_init_from_radians(self, radX, radY, radZ)

proc graphene_quaternion_init_from_vec4(self: Quaternion; src: Vec4): ptr Quaternion {.
    importc, libprag.}

proc initFromVec4*(self: Quaternion; src: Vec4): ptr Quaternion =
  graphene_quaternion_init_from_vec4(self, src)

proc graphene_quaternion_init_identity(self: Quaternion): ptr Quaternion {.
    importc, libprag.}

proc initIdentity*(self: Quaternion): ptr Quaternion =
  graphene_quaternion_init_identity(self)

proc graphene_quaternion_invert(self: Quaternion; res: var Quaternion) {.
    importc, libprag.}

proc invert*(self: Quaternion; res: var Quaternion) =
  graphene_quaternion_invert(self, res)

proc invert*(self: Quaternion): Quaternion =
  graphene_quaternion_invert(self, result)

proc graphene_quaternion_multiply(self: Quaternion; b: Quaternion; res: var Quaternion) {.
    importc, libprag.}

proc multiply*(self: Quaternion; b: Quaternion; res: var Quaternion) =
  graphene_quaternion_multiply(self, b, res)

proc graphene_quaternion_normalize(self: Quaternion; res: var Quaternion) {.
    importc, libprag.}

proc normalize*(self: Quaternion; res: var Quaternion) =
  graphene_quaternion_normalize(self, res)

proc normalize*(self: Quaternion): Quaternion =
  graphene_quaternion_normalize(self, result)

proc graphene_quaternion_scale(self: Quaternion; factor: cfloat; res: var Quaternion) {.
    importc, libprag.}

proc scale*(self: Quaternion; factor: cfloat; res: var Quaternion) =
  graphene_quaternion_scale(self, factor, res)

proc graphene_quaternion_slerp(self: Quaternion; b: Quaternion; factor: cfloat;
    res: var Quaternion) {.
    importc, libprag.}

proc slerp*(self: Quaternion; b: Quaternion; factor: cfloat;
    res: var Quaternion) =
  graphene_quaternion_slerp(self, b, factor, res)

proc graphene_quaternion_to_angle_vec3(self: Quaternion; angle: var cfloat;
    axis: var Vec3) {.
    importc, libprag.}

proc toAngleVec3*(self: Quaternion; angle: var cfloat;
    axis: var Vec3) =
  graphene_quaternion_to_angle_vec3(self, angle, axis)

proc graphene_quaternion_to_angles(self: Quaternion; degX: var cfloat; degY: var cfloat;
    degZ: var cfloat) {.
    importc, libprag.}

proc toAngles*(self: Quaternion; degX: var cfloat = cast[var cfloat](nil);
    degY: var cfloat = cast[var cfloat](nil); degZ: var cfloat = cast[var cfloat](nil)) =
  graphene_quaternion_to_angles(self, degX, degY, degZ)

proc graphene_quaternion_to_matrix(self: Quaternion; m: var Matrix) {.
    importc, libprag.}

proc toMatrix*(self: Quaternion; m: var Matrix) =
  graphene_quaternion_to_matrix(self, m)

proc toMatrix*(self: Quaternion): Matrix =
  graphene_quaternion_to_matrix(self, result)

proc graphene_quaternion_to_radians(self: Quaternion; radX: var cfloat; radY: var cfloat;
    radZ: var cfloat) {.
    importc, libprag.}

proc toRadians*(self: Quaternion; radX: var cfloat = cast[var cfloat](nil);
    radY: var cfloat = cast[var cfloat](nil); radZ: var cfloat = cast[var cfloat](nil)) =
  graphene_quaternion_to_radians(self, radX, radY, radZ)

proc graphene_quaternion_to_vec4(self: Quaternion; res: var Vec4) {.
    importc, libprag.}

proc toVec4*(self: Quaternion; res: var Vec4) =
  graphene_quaternion_to_vec4(self, res)

proc toVec4*(self: Quaternion): Vec4 =
  graphene_quaternion_to_vec4(self, result)

proc graphene_euler_init_from_quaternion(self: Euler; q: Quaternion; order: EulerOrder): ptr Euler {.
    importc, libprag.}

proc initFromQuaternion*(self: Euler; q: Quaternion = cast[var Quaternion](nil);
    order: EulerOrder): ptr Euler =
  graphene_euler_init_from_quaternion(self, q, order)

proc graphene_euler_to_quaternion(self: Euler; res: var Quaternion) {.
    importc, libprag.}

proc toQuaternion*(self: Euler; res: var Quaternion) =
  graphene_euler_to_quaternion(self, res)

proc toQuaternion*(self: Euler): Quaternion =
  graphene_euler_to_quaternion(self, result)

proc graphene_matrix_decompose(self: Matrix; translate: var Vec3; scale: var Vec3;
    rotate: var Quaternion; shear: var Vec3; perspective: var Vec4): gboolean {.
    importc, libprag.}

proc decompose*(self: Matrix; translate: var Vec3; scale: var Vec3;
    rotate: var Quaternion; shear: var Vec3; perspective: var Vec4): bool =
  toBool(graphene_matrix_decompose(self, translate, scale, rotate, shear, perspective))

proc graphene_matrix_rotate_quaternion(self: Matrix; q: Quaternion) {.
    importc, libprag.}

proc rotateQuaternion*(self: Matrix; q: Quaternion) =
  graphene_matrix_rotate_quaternion(self, q)

type
  Frustum00* {.pure.} = object
  Frustum* = ref object
    impl*: ptr Frustum00
    ignoreFinalizer*: bool

proc graphene_frustum_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGrapheneFrustum*(self: Frustum) =
  if not self.ignoreFinalizer:
    boxedFree(graphene_frustum_get_type(), cast[ptr Frustum00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Frustum()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(graphene_frustum_get_type(), cast[ptr Frustum00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Frustum) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGrapheneFrustum)

proc graphene_frustum_free(self: ptr Frustum00) {.
    importc, libprag.}

proc free*(self: Frustum) =
  graphene_frustum_free(cast[ptr Frustum00](self.impl))

proc finalizerfree*(self: Frustum) =
  if not self.ignoreFinalizer:
    graphene_frustum_free(cast[ptr Frustum00](self.impl))

proc graphene_frustum_contains_point(self: ptr Frustum00; point: Point3D): gboolean {.
    importc, libprag.}

proc containsPoint*(self: Frustum; point: Point3D): bool =
  toBool(graphene_frustum_contains_point(cast[ptr Frustum00](self.impl), point))

proc graphene_frustum_equal(self: ptr Frustum00; b: ptr Frustum00): gboolean {.
    importc, libprag.}

proc equal*(self: Frustum; b: Frustum): bool =
  toBool(graphene_frustum_equal(cast[ptr Frustum00](self.impl), cast[ptr Frustum00](b.impl)))

proc graphene_frustum_alloc(): ptr Frustum00 {.
    importc, libprag.}

proc allocFrustum*(): Frustum =
  fnew(result, gBoxedFreeGrapheneFrustum)
  result.impl = graphene_frustum_alloc()

proc allocFrustum*(tdesc: typedesc): tdesc =
  assert(result is Frustum)
  fnew(result, gBoxedFreeGrapheneFrustum)
  result.impl = graphene_frustum_alloc()

proc allocFrustum*[T](result: var T) {.deprecated.} =
  assert(result is Frustum)
  fnew(result, gBoxedFreeGrapheneFrustum)
  result.impl = graphene_frustum_alloc()

proc graphene_frustum_get_planes(self: ptr Frustum00; planes: var ptr array[6, Plane]) {.
    importc, libprag.}

proc getPlanes*(self: Frustum; planes: var ptr array[6, Plane]) =
  graphene_frustum_get_planes(cast[ptr Frustum00](self.impl), planes)

proc getPlanes*(self: Frustum): ptr array[6, Plane] =
  graphene_frustum_get_planes(cast[ptr Frustum00](self.impl), result)

proc graphene_frustum_init(self: ptr Frustum00; p0: Plane; p1: Plane; p2: Plane;
    p3: Plane; p4: Plane; p5: Plane): ptr Frustum00 {.
    importc, libprag.}

proc init*(self: Frustum; p0: Plane; p1: Plane; p2: Plane;
    p3: Plane; p4: Plane; p5: Plane): Frustum =
  fnew(result, gBoxedFreeGrapheneFrustum)
  result.impl = graphene_frustum_init(cast[ptr Frustum00](self.impl), p0, p1, p2, p3, p4, p5)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(graphene_frustum_get_type(), result.impl))

proc graphene_frustum_init_from_frustum(self: ptr Frustum00; src: ptr Frustum00): ptr Frustum00 {.
    importc, libprag.}

proc initFromFrustum*(self: Frustum; src: Frustum): Frustum =
  fnew(result, gBoxedFreeGrapheneFrustum)
  result.impl = graphene_frustum_init_from_frustum(cast[ptr Frustum00](self.impl), cast[ptr Frustum00](src.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(graphene_frustum_get_type(), result.impl))

proc graphene_frustum_init_from_matrix(self: ptr Frustum00; matrix: Matrix): ptr Frustum00 {.
    importc, libprag.}

proc initFromMatrix*(self: Frustum; matrix: Matrix): Frustum =
  fnew(result, gBoxedFreeGrapheneFrustum)
  result.impl = graphene_frustum_init_from_matrix(cast[ptr Frustum00](self.impl), matrix)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(graphene_frustum_get_type(), result.impl))

proc graphene_frustum_intersects_box(self: ptr Frustum00; box: Box): gboolean {.
    importc, libprag.}

proc intersectsBox*(self: Frustum; box: Box): bool =
  toBool(graphene_frustum_intersects_box(cast[ptr Frustum00](self.impl), box))

proc graphene_frustum_intersects_sphere(self: ptr Frustum00; sphere: Sphere): gboolean {.
    importc, libprag.}

proc intersectsSphere*(self: Frustum; sphere: Sphere): bool =
  toBool(graphene_frustum_intersects_sphere(cast[ptr Frustum00](self.impl), sphere))

const PI* = 3.141593'f64

const PI_2* = 1.570796'f64

const VEC2_LEN* = 2'i32

const VEC3_LEN* = 3'i32

const VEC4_LEN* = 4'i32
# === remaining symbols:

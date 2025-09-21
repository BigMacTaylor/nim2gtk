# dependencies:
# GObject-2.0
# Gst-1.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# Gst-1.0
# libraries:
# libgstinsertbin-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gst, glib, gmodule
const Lib = "libgstinsertbin-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  InsertBin* = ref object of gst.Bin
  InsertBin00* = object of gst.Bin00

proc gst_insert_bin_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(InsertBin()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAppend*(self: InsertBin;  p: proc (self: ptr InsertBin00; callback: ptr gst.Element00; userData: pointer; userData2: pointer; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "append", cast[GCallback](p), xdata, nil, cf)

proc scInsertAfter*(self: InsertBin;  p: proc (self: ptr InsertBin00; sibling: ptr gst.Element00; callback: ptr gst.Element00; userData: pointer;
    userData2: pointer; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "insert-after", cast[GCallback](p), xdata, nil, cf)

proc scInsertBefore*(self: InsertBin;  p: proc (self: ptr InsertBin00; sibling: ptr gst.Element00; callback: ptr gst.Element00; userData: pointer;
    userData2: pointer; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "insert-before", cast[GCallback](p), xdata, nil, cf)

proc scPrepend*(self: InsertBin;  p: proc (self: ptr InsertBin00; callback: ptr gst.Element00; userData: pointer; userData2: pointer; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "prepend", cast[GCallback](p), xdata, nil, cf)

proc scRemove*(self: InsertBin;  p: proc (self: ptr InsertBin00; callback: ptr gst.Element00; userData: pointer; userData2: pointer; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "remove", cast[GCallback](p), xdata, nil, cf)

proc gst_insert_bin_new(name: cstring): ptr InsertBin00 {.
    importc, libprag.}

proc newInsertBin*(name: cstring = nil): InsertBin =
  let gobj = gst_insert_bin_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newInsertBin*(tdesc: typedesc; name: cstring = nil): tdesc =
  assert(result is InsertBin)
  let gobj = gst_insert_bin_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initInsertBin*[T](result: var T; name: cstring = nil) {.deprecated.} =
  assert(result is InsertBin)
  let gobj = gst_insert_bin_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  InsertBinCallback* = proc (insertbin: ptr InsertBin00; element: ptr gst.Element00; success: gboolean;
    userData: pointer) {.cdecl.}

proc gst_insert_bin_append(self: ptr InsertBin00; element: ptr gst.Element00;
    callback: InsertBinCallback; userData: pointer) {.
    importc, libprag.}

proc append*(self: InsertBin; element: gst.Element; callback: InsertBinCallback;
    userData: pointer) =
  gst_insert_bin_append(cast[ptr InsertBin00](self.impl), cast[ptr gst.Element00](element.impl), callback, userData)

proc gst_insert_bin_insert_after(self: ptr InsertBin00; element: ptr gst.Element00;
    sibling: ptr gst.Element00; callback: InsertBinCallback; userData: pointer) {.
    importc, libprag.}

proc insertAfter*(self: InsertBin; element: gst.Element; sibling: gst.Element;
    callback: InsertBinCallback; userData: pointer) =
  gst_insert_bin_insert_after(cast[ptr InsertBin00](self.impl), cast[ptr gst.Element00](element.impl), cast[ptr gst.Element00](sibling.impl), callback, userData)

proc gst_insert_bin_insert_before(self: ptr InsertBin00; element: ptr gst.Element00;
    sibling: ptr gst.Element00; callback: InsertBinCallback; userData: pointer) {.
    importc, libprag.}

proc insertBefore*(self: InsertBin; element: gst.Element;
    sibling: gst.Element; callback: InsertBinCallback; userData: pointer) =
  gst_insert_bin_insert_before(cast[ptr InsertBin00](self.impl), cast[ptr gst.Element00](element.impl), cast[ptr gst.Element00](sibling.impl), callback, userData)

proc gst_insert_bin_prepend(self: ptr InsertBin00; element: ptr gst.Element00;
    callback: InsertBinCallback; userData: pointer) {.
    importc, libprag.}

proc prepend*(self: InsertBin; element: gst.Element; callback: InsertBinCallback;
    userData: pointer) =
  gst_insert_bin_prepend(cast[ptr InsertBin00](self.impl), cast[ptr gst.Element00](element.impl), callback, userData)

proc gst_insert_bin_remove(self: ptr InsertBin00; element: ptr gst.Element00;
    callback: InsertBinCallback; userData: pointer) {.
    importc, libprag.}

proc remove*(self: InsertBin; element: gst.Element; callback: InsertBinCallback;
    userData: pointer) =
  gst_insert_bin_remove(cast[ptr InsertBin00](self.impl), cast[ptr gst.Element00](element.impl), callback, userData)
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc childProxy*(x: gstinsertbin.InsertBin): gst.ChildProxy = cast[gst.ChildProxy](x)

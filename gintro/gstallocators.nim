# dependencies:
# GObject-2.0
# Gst-1.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# Gst-1.0
# libraries:
# libgstallocators-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gst, glib, gmodule
const Lib = "libgstallocators-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const ALLOCATOR_DMABUF* = "dmabuf"

const ALLOCATOR_FD* = "fd"

const ALLOCATOR_SHM* = "shm"

const CAPS_FEATURE_MEMORY_DMABUF* = "memory:DMABuf"

type
  DRMDumbAllocator* = ref object of gst.Allocator
  DRMDumbAllocator00* = object of gst.Allocator00

proc gst_drm_dumb_allocator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DRMDumbAllocator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_drm_dumb_allocator_new_with_device_path(drmDevicePath: cstring): ptr DRMDumbAllocator00 {.
    importc, libprag.}

proc newDRMDumbAllocatorWithDevicePath*(drmDevicePath: cstring): DRMDumbAllocator =
  let gobj = gst_drm_dumb_allocator_new_with_device_path(drmDevicePath)
  if gobj.isNil:
    return nil
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

proc newDRMDumbAllocatorWithDevicePath*(tdesc: typedesc; drmDevicePath: cstring): tdesc =
  assert(result is DRMDumbAllocator)
  let gobj = gst_drm_dumb_allocator_new_with_device_path(drmDevicePath)
  if gobj.isNil:
    return nil
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

proc initDRMDumbAllocatorWithDevicePath*[T](result: var T; drmDevicePath: cstring) {.deprecated.} =
  assert(result is DRMDumbAllocator)
  let gobj = gst_drm_dumb_allocator_new_with_device_path(drmDevicePath)
  if gobj.isNil:
    return nil
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

proc gst_drm_dumb_allocator_new_with_fd(drmFd: int32): ptr DRMDumbAllocator00 {.
    importc, libprag.}

proc newDRMDumbAllocatorWithFd*(drmFd: int): DRMDumbAllocator =
  let gobj = gst_drm_dumb_allocator_new_with_fd(int32(drmFd))
  if gobj.isNil:
    return nil
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

proc newDRMDumbAllocatorWithFd*(tdesc: typedesc; drmFd: int): tdesc =
  assert(result is DRMDumbAllocator)
  let gobj = gst_drm_dumb_allocator_new_with_fd(int32(drmFd))
  if gobj.isNil:
    return nil
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

proc initDRMDumbAllocatorWithFd*[T](result: var T; drmFd: int) {.deprecated.} =
  assert(result is DRMDumbAllocator)
  let gobj = gst_drm_dumb_allocator_new_with_fd(int32(drmFd))
  if gobj.isNil:
    return nil
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

proc gst_drm_dumb_allocator_alloc(self: ptr DRMDumbAllocator00; drmFourcc: uint32;
    width: uint32; height: uint32; outPitch: var uint32): ptr gst.Memory00 {.
    importc, libprag.}

proc alloc*(self: DRMDumbAllocator; drmFourcc: int;
    width: int; height: int; outPitch: var int): gst.Memory =
  var outPitch_00: uint32
  fnew(result, gBoxedFreeGstMemory)
  result.impl = gst_drm_dumb_allocator_alloc(cast[ptr DRMDumbAllocator00](self.impl), uint32(drmFourcc), uint32(width), uint32(height), outPitch_00)
  if outPitch.addr != nil:
    outPitch = int(outPitch_00)

proc gst_drm_dumb_allocator_has_prime_export(self: ptr DRMDumbAllocator00): gboolean {.
    importc, libprag.}

proc hasPrimeExport*(self: DRMDumbAllocator): bool =
  toBool(gst_drm_dumb_allocator_has_prime_export(cast[ptr DRMDumbAllocator00](self.impl)))

type
  FdAllocator* = ref object of gst.Allocator
  FdAllocator00* = object of gst.Allocator00

proc gst_fd_allocator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FdAllocator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_fd_allocator_new(): ptr FdAllocator00 {.
    importc, libprag.}

proc newFdAllocator*(): FdAllocator =
  let gobj = gst_fd_allocator_new()
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

proc newFdAllocator*(tdesc: typedesc): tdesc =
  assert(result is FdAllocator)
  let gobj = gst_fd_allocator_new()
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

proc initFdAllocator*[T](result: var T) {.deprecated.} =
  assert(result is FdAllocator)
  let gobj = gst_fd_allocator_new()
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

type
  DmaBufAllocator* = ref object of FdAllocator
  DmaBufAllocator00* = object of FdAllocator00

proc gst_dmabuf_allocator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DmaBufAllocator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_dmabuf_allocator_new(): ptr DmaBufAllocator00 {.
    importc, libprag.}

proc newDmaBufAllocator*(): DmaBufAllocator =
  let gobj = gst_dmabuf_allocator_new()
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

proc newDmaBufAllocator*(tdesc: typedesc): tdesc =
  assert(result is DmaBufAllocator)
  let gobj = gst_dmabuf_allocator_new()
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

proc initDmaBufAllocator*[T](result: var T) {.deprecated.} =
  assert(result is DmaBufAllocator)
  let gobj = gst_dmabuf_allocator_new()
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

proc gst_dmabuf_allocator_alloc(allocator: ptr gst.Allocator00; fd: int32;
    size: uint64): ptr gst.Memory00 {.
    importc, libprag.}

proc alloc*(allocator: gst.Allocator; fd: int; size: uint64): gst.Memory =
  let impl0 = gst_dmabuf_allocator_alloc(cast[ptr gst.Allocator00](allocator.impl), int32(fd), size)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

type
  FdMemoryFlag* {.size: sizeof(cint), pure.} = enum
    keepMapped = 0
    mapPrivate = 1
    dontClose = 2

  FdMemoryFlags* {.size: sizeof(cint).} = set[FdMemoryFlag]

const
  FdMemoryFlagsNone* = FdMemoryFlags({})
proc none*(t: typedesc[FdMemoryFlags]): FdMemoryFlags = FdMemoryFlags({})

proc gst_fd_allocator_alloc(allocator: ptr gst.Allocator00; fd: int32; size: uint64;
    flags: FdMemoryFlags): ptr gst.Memory00 {.
    importc, libprag.}

proc alloc*(allocator: gst.Allocator; fd: int; size: uint64;
    flags: FdMemoryFlags): gst.Memory =
  let impl0 = gst_fd_allocator_alloc(cast[ptr gst.Allocator00](allocator.impl), int32(fd), size, flags)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

proc gst_dmabuf_allocator_alloc_with_flags(allocator: ptr gst.Allocator00;
    fd: int32; size: uint64; flags: FdMemoryFlags): ptr gst.Memory00 {.
    importc, libprag.}

proc allocWithFlags*(allocator: gst.Allocator; fd: int;
    size: uint64; flags: FdMemoryFlags): gst.Memory =
  let impl0 = gst_dmabuf_allocator_alloc_with_flags(cast[ptr gst.Allocator00](allocator.impl), int32(fd), size, flags)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

type
  PhysMemoryAllocator00* = object of gobject.Object00
  PhysMemoryAllocator* = ref object of gobject.Object

type
  ShmAllocator* = ref object of FdAllocator
  ShmAllocator00* = object of FdAllocator00

proc gst_shm_allocator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ShmAllocator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_shm_allocator_get(): ptr gst.Allocator00 {.
    importc, libprag.}

proc getShmAllocator*(): gst.Allocator =
  let gobj = gst_shm_allocator_get()
  if gobj.isNil:
    return nil
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

proc initOnce*() {.
    importc: "gst_shm_allocator_init_once", libprag.}

proc gst_dmabuf_memory_get_fd(mem: ptr gst.Memory00): int32 {.
    importc, libprag.}

proc dmabufMemoryGetFd*(mem: gst.Memory): int =
  int(gst_dmabuf_memory_get_fd(cast[ptr gst.Memory00](mem.impl)))

proc gst_drm_dumb_memory_export_dmabuf(mem: ptr gst.Memory00): ptr gst.Memory00 {.
    importc, libprag.}

proc drmDumbMemoryExportDmabuf*(mem: gst.Memory): gst.Memory =
  fnew(result, gBoxedFreeGstMemory)
  result.impl = gst_drm_dumb_memory_export_dmabuf(cast[ptr gst.Memory00](mem.impl))

proc gst_drm_dumb_memory_get_handle(mem: ptr gst.Memory00): uint32 {.
    importc, libprag.}

proc drmDumbMemoryGetHandle*(mem: gst.Memory): int =
  int(gst_drm_dumb_memory_get_handle(cast[ptr gst.Memory00](mem.impl)))

proc gst_fd_memory_get_fd(mem: ptr gst.Memory00): int32 {.
    importc, libprag.}

proc fdMemoryGetFd*(mem: gst.Memory): int =
  int(gst_fd_memory_get_fd(cast[ptr gst.Memory00](mem.impl)))

proc gst_is_dmabuf_memory(mem: ptr gst.Memory00): gboolean {.
    importc, libprag.}

proc isDmabufMemory*(mem: gst.Memory): bool =
  toBool(gst_is_dmabuf_memory(cast[ptr gst.Memory00](mem.impl)))

proc gst_is_drm_dumb_memory(mem: ptr gst.Memory00): gboolean {.
    importc, libprag.}

proc isDrmDumbMemory*(mem: gst.Memory): bool =
  toBool(gst_is_drm_dumb_memory(cast[ptr gst.Memory00](mem.impl)))

proc gst_is_fd_memory(mem: ptr gst.Memory00): gboolean {.
    importc, libprag.}

proc isFdMemory*(mem: gst.Memory): bool =
  toBool(gst_is_fd_memory(cast[ptr gst.Memory00](mem.impl)))

proc gst_is_phys_memory(mem: ptr gst.Memory00): gboolean {.
    importc, libprag.}

proc isPhysMemory*(mem: gst.Memory): bool =
  toBool(gst_is_phys_memory(cast[ptr gst.Memory00](mem.impl)))

proc gst_phys_memory_get_phys_addr(mem: ptr gst.Memory00): uint64 {.
    importc, libprag.}

proc physMemoryGetPhysAddr*(mem: gst.Memory): uint64 =
  gst_phys_memory_get_phys_addr(cast[ptr gst.Memory00](mem.impl))
# === remaining symbols:

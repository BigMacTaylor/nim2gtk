# dependencies:
# GLib-2.0
# immediate dependencies:
# GLib-2.0
# libraries:
# libgmodule-2.0.so.0
{.warning[UnusedImport]: off.}
import glib
const Lib = "libgmodule-2.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

const MODULE_IMPL_AR* = 7'i32

const MODULE_IMPL_DL* = 1'i32

const MODULE_IMPL_NONE* = 0'i32

const MODULE_IMPL_WIN32* = 3'i32

type
  Module00* {.pure.} = object
  Module* = ref object
    impl*: ptr Module00
    ignoreFinalizer*: bool

proc g_module_close(self: ptr Module00): gboolean {.
    importc, libprag.}

proc close*(self: Module): bool =
  toBool(g_module_close(cast[ptr Module00](self.impl)))

proc g_module_make_resident(self: ptr Module00) {.
    importc, libprag.}

proc makeResident*(self: Module) =
  g_module_make_resident(cast[ptr Module00](self.impl))

proc g_module_name(self: ptr Module00): cstring {.
    importc, libprag.}

proc name*(self: Module): string =
  result = $g_module_name(cast[ptr Module00](self.impl))

proc g_module_symbol(self: ptr Module00; symbolName: cstring; symbol: var pointer): gboolean {.
    importc, libprag.}

proc symbol*(self: Module; symbolName: cstring; symbol: var pointer): bool =
  toBool(g_module_symbol(cast[ptr Module00](self.impl), symbolName, symbol))

proc g_module_build_path(directory: cstring; moduleName: cstring): cstring {.
    importc, libprag.}

proc buildPath*(directory: cstring = nil; moduleName: cstring): string =
  let resul0 = g_module_build_path(directory, moduleName)
  result = $resul0
  cogfree(resul0)

proc g_module_error(): cstring {.
    importc, libprag.}

proc error*(): string =
  result = $g_module_error()

proc g_module_supported(): gboolean {.
    importc, libprag.}

proc supported*(): bool =
  toBool(g_module_supported())

type
  ModuleCheckInit* = proc (module: ptr Module00): cstring {.cdecl.}

type
  ModuleError* {.size: sizeof(cint), pure.} = enum
    failed = 0
    checkFailed = 1

type
  ModuleFlags* {.size: sizeof(cint), pure.} = enum
    lazy = 1
    local = 2
    mask = 3

type
  ModuleUnload* = proc (module: ptr Module00) {.cdecl.}
# === remaining symbols:

# Package

version       = "0.9.9"
author        = "Stefan Salewski"
description = "High level GObject-Introspection based GTK4/GTK3 bindings"
license       = "MIT"
skipDirs = @["examples", "tests"]

# Dependencies

requires "nim >= 1.0.0"

when defined(nimdistros):
  import distros
  if detectOs(Ubuntu) or detectOs(Debian):
    foreignDep "libgtk-3-dev"
  elif detectOs(Gentoo):
    foreignDep "gtk+" # can we specify gtk3?
  #else: we don't know the names for all the other distributions
  #  foreignDep "openssl"

import ospaths

proc prep =
  let this = thisDir()
  let td = getTempDir()
  cd(td)
  let wd = "gintrosalewski"
  if dirExists(wd):
    rmDir(wd)
    # quit("gintro: tmp directory already exists!")
  mkDir(wd)
  cd(wd)
  mkDir("ngtk3")
  cd("ngtk3")

  cpFile(this / "tests" / "gen.nim", td / wd / "gen.nim")
  cpFile(this / "tests" / "combinatorics.nim", td / wd / "combinatorics.nim")
  cpFile(this / "tests" / "maxby.nim", td / wd / "maxby.nim")

  cd(td)
  cd(wd)

  cpFile(this / "oldgtk3" / "gobject.nim", "gobject.nim")
  cpFile(this / "oldgtk3" / "glib.nim", "glib.nim")
  cpFile(this / "oldgtk3" / "gir.nim", "gir.nim")

  exec("nim c gen.nim")
  mkDir("nim_gi")
  exec(td / wd / "gen") # for latest version, generate GTK3 bindings first
  exec(td / wd / "gen 1") # and now GTK4 with libsoup3
  let mods = listFiles("nim_gi")
  for i in mods:
    let j = i[7 .. ^1]
    cpFile(i, this / "gintro" / j)
  cd(td)
  rmDir(wd) # cleanup

#task prepare, "preparing gintro":
before install:

  echo "preparing gintro"
  prep()
  


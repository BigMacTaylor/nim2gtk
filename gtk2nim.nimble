# Package

version       = "0.1.0"
author        = "Mac Taylor"
description   = "GTK bindings for Nim 2.0"
license       = "MIT"
skipDirs      = @["examples", "tests"]

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

srcDir = "gtk2nim"

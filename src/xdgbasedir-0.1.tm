# XDG Base Directory Specification handling
#
# Copyright (C) 2013 Lawrence Woodman
#
# Licensed under an MIT licence.  Please see LICENCE.md for details.
#
# For XDG Base Directory Specification
#   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
#

namespace eval XDG {

  proc DATA_HOME { {subdir ""} } {
    if {[info exists ::env(XDG_DATA_HOME)] && $::env(XDG_DATA_HOME) ne ""} {
      return [file join $::env(XDG_DATA_HOME) $subdir]
    } else {
      return [file join $::env(HOME) .local share $subdir]
    }
  }

}

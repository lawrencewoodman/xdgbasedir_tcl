# XDG Base Directory Specification handling
#
# Copyright (C) 2013 Lawrence Woodman
#
# Licensed under an MIT licence.  Please see LICENCE.md for details.
#
# For XDG Base Directory Specification
#   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
#
package require Tcl 8.5

namespace eval XDG {

  variable DEFAULTS [list \
    DATA_HOME [file join $::env(HOME) .local share] \
    CONFIG_HOME [file join $::env(HOME) .config] \
    CACHE_HOME [file join $::env(HOME) .cache] \
    DATA_DIRS  [list [file join usr local share] [file join usr share]] \
    CONFIG_DIRS  [list [file join etc xdg ]]
  ]

  proc HOME {var defaultDir {subdir ""} } {
    set dir $defaultDir

    if {[info exists ::env(XDG_$var)] && $::env(XDG_$var) ne ""} {
      set dir $::env(XDG_$var)
    }

    return [file join $dir $subdir]
  }

  proc DIRS {var defaultDirs {subdir ""} } {
    set rawDirs $defaultDirs

    if {[info exists ::env(XDG_$var)] && $::env(XDG_$var) ne ""} {
      set rawDirs [split $::env(XDG_$var) ":"]
    }

    set outDirs {}
    foreach dir $rawDirs {
      lappend outDirs [file join $dir $subdir]
    }
    return $outDirs
  }

  # Create procs to access the XDG variables using the names given in the
  # DEFAULTS list above
  dict for {var default} $DEFAULTS {
    set internalCommand [regsub {^(.*_)([^_]+)$} $var {\2}]
    proc $var { {subdir ""} } "$internalCommand $var {$default} \$subdir"
  }
}

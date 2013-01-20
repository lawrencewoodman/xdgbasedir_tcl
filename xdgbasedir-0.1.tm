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
    DATA_HOME   [file join $::env(HOME) .local share] \
    CONFIG_HOME [file join $::env(HOME) .config] \
    CACHE_HOME  [file join $::env(HOME) .cache] \
    DATA_DIRS   [list [file join usr local share] [file join usr share]] \
    CONFIG_DIRS [list [file join etc xdg ]]
  ]

  proc Home {var {subdir ""} } {
    variable DEFAULTS
    set dir [dict get $DEFAULTS $var]

    if {[info exists ::env(XDG_$var)] && $::env(XDG_$var) ne ""} {
      set dir $::env(XDG_$var)
    }

    return [file join $dir $subdir]
  }

  proc Dirs {var {subdir ""} } {
    variable DEFAULTS
    set rawDirs [dict get $DEFAULTS $var]

    if {[info exists ::env(XDG_$var)] && $::env(XDG_$var) ne ""} {
      set rawDirs [split $::env(XDG_$var) ":"]
    }

    set outDirs {}
    foreach dir $rawDirs {
      lappend outDirs [file join $dir $subdir]
    }
    return $outDirs
  }

  # The following procs reference the environmental variables XDG_
  # followed by the proc name.
  proc DATA_HOME {{subdir ""}} {Home DATA_HOME $subdir}
  proc CONFIG_HOME {{subdir ""}} {Home CONFIG_HOME $subdir}
  proc CACHE_HOME {{subdir ""}} {Home CACHE_HOME $subdir}

  # The following procs returning the directories as a list with the most
  # important first.
  proc DATA_DIRS {{subdir ""}} {Dirs DATA_DIRS $subdir}
  proc CONFIG_DIRS {{subdir ""}} {Dirs CONFIG_DIRS $subdir}

  namespace export DATA_HOME CONFIG_HOME CACHE_HOME DATA_DIRS CONFIG_DIRS
}

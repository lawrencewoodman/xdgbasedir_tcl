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

  proc XDGVarSet {var} {
    expr {[info exists ::env(XDG_$var)] && $::env(XDG_$var) ne ""}
  }

  proc Dir {var {subdir ""} } {
    variable DEFAULTS
    set dir [dict get $DEFAULTS $var]

    if {[XDGVarSet $var]} {
      set dir $::env(XDG_$var)
    }

    return [file join $dir $subdir]
  }

  proc Dirs {var {subdir ""} } {
    variable DEFAULTS
    set rawDirs [dict get $DEFAULTS $var]

    if {[XDGVarSet $var]} {
      set rawDirs [split $::env(XDG_$var) ":"]
    }

    set outDirs {}
    foreach dir $rawDirs {
      lappend outDirs [file join $dir $subdir]
    }
    return $outDirs
  }

  # The remaining procs reference the environmental variables XDG_
  # followed by the proc name.
  proc DATA_HOME {{subdir ""}} {Dir DATA_HOME $subdir}
  proc CONFIG_HOME {{subdir ""}} {Dir CONFIG_HOME $subdir}
  proc CACHE_HOME {{subdir ""}} {Dir CACHE_HOME $subdir}

  proc RUNTIME_DIR {{subdir ""}} {
    if {![XDGVarSet RUNTIME_DIR]} { return {} }
    return [file join $::env(XDG_RUNTIME_DIR) $subdir]
  }

  # The following procs returning the directories as a list with the most
  # important first.
  proc DATA_DIRS {{subdir ""}} {Dirs DATA_DIRS $subdir}
  proc CONFIG_DIRS {{subdir ""}} {Dirs CONFIG_DIRS $subdir}

  namespace export DATA_HOME CONFIG_HOME CACHE_HOME
  namespace export RUNTIME_DIR DATA_DIRS CONFIG_DIRS
}

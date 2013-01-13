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

	variable DEFAULTS [list \
		DATA_HOME [file join $::env(HOME) .local share] \
		CONFIG_HOME [file join $::env(HOME) .config]
	]

  proc DATA_HOME { {subdir ""} } {
		variable DEFAULTS
    if {[info exists ::env(XDG_DATA_HOME)] && $::env(XDG_DATA_HOME) ne ""} {
      return [file join $::env(XDG_DATA_HOME) $subdir]
    } else {
			return [file join [dict get $DEFAULTS DATA_HOME] $subdir]
    }
  }

  proc CONFIG_HOME { {subdir ""} } {
		variable DEFAULTS
    if {[info exists ::env(XDG_CONFIG_HOME)] && $::env(XDG_CONFIG_HOME) ne ""} {
      return [file join $::env(XDG_CONFIG_HOME) $subdir]
    } else {
			return [file join [dict get $DEFAULTS CONFIG_HOME] $subdir]
    }
  }

}

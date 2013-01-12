package require tcltest
namespace import tcltest::*

# Add src dir to tm paths
set ThisScriptDir [file dirname [info script]]
set SrcDir [file normalize [file join $ThisScriptDir .. src]]
::tcl::tm::path add $SrcDir

package require xdgbasedir

test DATA_HOME-1 {Returns the set XDG_DATA_HOME directory} -setup {
  if {[info exists ::env(XDG_DATA_HOME)]} {
    set old_XDG_DATA_HOME $::env(XDG_DATA_HOME)
  }
  set ::env(XDG_DATA_HOME) [file join tmp xdg_data_home]
} -body {
  XDG::DATA_HOME
} -cleanup {
  if {[info exists old_XDG_DATA_HOME]} {
    set ::env(XDG_DATA_HOME) old_XDG_DATA_HOME
  } else {
    unset ::env(XDG_DATA_HOME)
  }
} -result [file join tmp xdg_data_home]

test DATA_HOME-2 {Returns the set XDG_DATA_HOME directory with subdir} -setup {
  if {[info exists ::env(XDG_DATA_HOME)]} {
    set old_XDG_DATA_HOME $::env(XDG_DATA_HOME)
  }
  set ::env(XDG_DATA_HOME) [file join tmp xdg_data_home]
} -body {
  XDG::DATA_HOME some_dir
} -cleanup {
  if {[info exists old_XDG_DATA_HOME]} {
    set ::env(XDG_DATA_HOME) old_XDG_DATA_HOME
  } else {
    unset ::env(XDG_DATA_HOME)
  }
} -result [file join tmp xdg_data_home some_dir]

test DATA_HOME-3 {Returns default directory if XDG_DATA_HOME not set} -setup {
  if {[info exists ::env(XDG_DATA_HOME)]} {
    set old_XDG_DATA_HOME $::env(XDG_DATA_HOME)
    unset ::env(XDG_DATA_HOME)
  }
} -body {
  XDG::DATA_HOME
} -cleanup {
  if {[info exists old_XDG_DATA_HOME]} {
    set ::env(XDG_DATA_HOME) old_XDG_DATA_HOME
  }
} -result [file join $::env(HOME) .local share]

test DATA_HOME-4 {Returns default directory with subdir if XDG_DATA_HOME not\
                  set but subdir passed} -setup {
  if {[info exists ::env(XDG_DATA_HOME)]} {
    set old_XDG_DATA_HOME $::env(XDG_DATA_HOME)
    unset ::env(XDG_DATA_HOME)
  }
} -body {
  XDG::DATA_HOME some_dir
} -cleanup {
  if {[info exists old_XDG_DATA_HOME]} {
    set ::env(XDG_DATA_HOME) old_XDG_DATA_HOME
  }
} -result [file join $::env(HOME) .local share some_dir]

cleanupTests

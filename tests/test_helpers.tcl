# Helper functions for the tests

namespace eval TestHelpers {
  variable storedXDGvars

  proc storeXDGvars {} {
    variable storedXDGvars
    set storedXDGvars {XDG_DATA_HOME {0 ""}}

    dict for {var value} $storedXDGvars {
      set varExists [info exists ::env($var)]
      if {$varExists} {
        dict set storedXDGvars $var [list $varExists $::env($var)]
      }
    }
  }

  proc restoreXDGvars {} {
    variable storedXDGvars
    dict for {var value} $storedXDGvars {
      if {[lindex $var 0] == 1} {
        set ::env($var) $value
      } else {
        if {[info exists ::env($var)]} {
          unset ::env($var)
        }
      }
    }
  }

  # Clear variable in current environment
  proc clearXDGvar {var} {
    if {[info exists ::env($var)]} {
      unset ::env($var)
    }
  }
}

package require tcltest
namespace import tcltest::*

# Add src dir to tm paths
set ThisScriptDir [file dirname [info script]]
set SrcDir [file normalize [file join $ThisScriptDir .. src]]
::tcl::tm::path add $SrcDir

package require xdgbasedir

source [file join [file dirname [info script]] test_helpers.tcl]

test DATA_HOME-1 {Returns the set XDG_DATA_HOME directory} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_DATA_HOME) [file join tmp xdg_data_home]
} -body {
  XDG::DATA_HOME
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join tmp xdg_data_home]

test DATA_HOME-2 {Returns the set XDG_DATA_HOME directory with subdir} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_DATA_HOME) [file join tmp xdg_data_home]
} -body {
  XDG::DATA_HOME some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join tmp xdg_data_home some_dir]

test DATA_HOME-3 {Returns default directory if XDG_DATA_HOME not set} -setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_DATA_HOME
} -body {
  XDG::DATA_HOME
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join $::env(HOME) .local share]

test DATA_HOME-4 {Returns default directory with subdir if XDG_DATA_HOME not\
                  set but subdir passed} -setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_DATA_HOME
} -body {
  XDG::DATA_HOME some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join $::env(HOME) .local share some_dir]

test CONFIG_HOME-1 {Returns the set XDG_CONFIG_HOME directory} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_CONFIG_HOME) [file join tmp xdg_data_home]
} -body {
  XDG::CONFIG_HOME
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join tmp xdg_data_home]

test CONFIG_HOME-2 {Returns the set XDG_CONFIG_HOME directory with subdir} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_CONFIG_HOME) [file join tmp xdg_data_home]
} -body {
  XDG::CONFIG_HOME some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join tmp xdg_data_home some_dir]

test CONFIG_HOME-3 {Returns default directory if XDG_CONFIG_HOME not set} -setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_CONFIG_HOME
} -body {
  XDG::CONFIG_HOME
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join $::env(HOME) .config]

test CONFIG_HOME-4 {Returns default directory with subdir if XDG_CONFIG_HOME not\
                  set but subdir passed} -setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_CONFIG_HOME
} -body {
  XDG::CONFIG_HOME some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join $::env(HOME) .config some_dir]

test CACHE_HOME-1 {Returns the set XDG_CACHE_HOME directory} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_CACHE_HOME) [file join tmp xdg_cache_home]
} -body {
  XDG::CACHE_HOME
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join tmp xdg_cache_home]

test CACHE_HOME-2 {Returns the set XDG_CACHE_HOME directory with subdir} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_CACHE_HOME) [file join tmp xdg_cache_home]
} -body {
  XDG::CACHE_HOME some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join tmp xdg_cache_home some_dir]

test CACHE_HOME-3 {Returns default directory if XDG_CACHE_HOME not set} -setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_CACHE_HOME
} -body {
  XDG::CACHE_HOME
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join $::env(HOME) .cache]

test CACHE_HOME-4 {Returns default directory with subdir if XDG_CACHE_HOME not\
                  set but subdir passed} -setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_CACHE_HOME
} -body {
  XDG::CACHE_HOME some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join $::env(HOME) .cache some_dir]

cleanupTests

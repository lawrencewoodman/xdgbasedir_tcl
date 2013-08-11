package require tcltest
namespace import tcltest::*

# Add module dir to tm paths
set ThisScriptDir [file dirname [info script]]
set ModuleDir [file normalize [file join $ThisScriptDir ..]]
::tcl::tm::path add $ModuleDir

package require xdgbasedir

source [file join [file dirname [info script]] test_helpers.tcl]

test DATA_HOME-1 {Returns the set XDG_DATA_HOME directory} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_DATA_HOME) [file join /tmp xdg_data_home]
} -body {
  XDG::DATA_HOME
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join /tmp xdg_data_home]

test DATA_HOME-2 {Returns the set XDG_DATA_HOME directory with subdir} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_DATA_HOME) [file join /tmp xdg_data_home]
} -body {
  XDG::DATA_HOME some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join /tmp xdg_data_home some_dir]

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
  set ::env(XDG_CONFIG_HOME) [file join /tmp xdg_config_home]
} -body {
  XDG::CONFIG_HOME
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join /tmp xdg_config_home]

test CONFIG_HOME-2 {Returns the set XDG_CONFIG_HOME directory with subdir} \
-setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_CONFIG_HOME) [file join /tmp xdg_config_home]
} -body {
  XDG::CONFIG_HOME some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join /tmp xdg_config_home some_dir]

test CONFIG_HOME-3 {Returns default directory if XDG_CONFIG_HOME not set} \
-setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_CONFIG_HOME
} -body {
  XDG::CONFIG_HOME
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join $::env(HOME) .config]

test CONFIG_HOME-4 {Returns default directory with subdir if XDG_CONFIG_HOME\
                    not set but subdir passed} -setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_CONFIG_HOME
} -body {
  XDG::CONFIG_HOME some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join $::env(HOME) .config some_dir]

test CACHE_HOME-1 {Returns the set XDG_CACHE_HOME directory} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_CACHE_HOME) [file join /tmp xdg_cache_home]
} -body {
  XDG::CACHE_HOME
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join /tmp xdg_cache_home]

test CACHE_HOME-2 {Returns the set XDG_CACHE_HOME directory with subdir} \
-setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_CACHE_HOME) [file join /tmp xdg_cache_home]
} -body {
  XDG::CACHE_HOME some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join /tmp xdg_cache_home some_dir]

test CACHE_HOME-3 {Returns default directory if XDG_CACHE_HOME not set} \
-setup {
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

test DATA_DIRS-1 {Returns the set XDG_DATA_DIRS directories} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_DATA_DIRS) [file join /tmp xdg_data_dir 1]:
  append ::env(XDG_DATA_DIRS) [file join /tmp xdg_data_dir 2]
} -body {
  XDG::DATA_DIRS
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [list [file join /tmp xdg_data_dir 1] \
                [file join /tmp xdg_data_dir 2]]

test DATA_DIRS-2 {Returns the set XDG_DATA_DIRS directories with subdir} \
-setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_DATA_DIRS) [file join /tmp xdg_data_dir 1]:
  append ::env(XDG_DATA_DIRS) [file join /tmp xdg_data_dir 2]
} -body {
  XDG::DATA_DIRS some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [list [file join /tmp xdg_data_dir 1 some_dir] \
                [file join /tmp xdg_data_dir 2 some_dir]
          ]

test DATA_DIRS-3 {Returns default directories if XDG_DATA_DIRS not set} \
-setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_DATA_DIRS
} -body {
  XDG::DATA_DIRS
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [list [file join /usr local share] [file join /usr share]]

test DATA_DIRS-4 {Returns default directories with subdir if XDG_DATA_DIRS not\
                  set but subdir passed} -setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_DATA_DIRS
} -body {
  XDG::DATA_DIRS some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [list [file join /usr local share some_dir] \
                [file join /usr share some_dir]
          ]

test CONFIG_DIRS-1 {Returns the set XDG_CONFIG_DIRS directories} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_CONFIG_DIRS) [file join /tmp xdg_config_dir 1]:
  append ::env(XDG_CONFIG_DIRS) [file join /tmp xdg_config_dir 2]
} -body {
  XDG::CONFIG_DIRS
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [list [file join /tmp xdg_config_dir 1] \
                [file join /tmp xdg_config_dir 2]]

test CONFIG_DIRS-2 {Returns the set XDG_CONFIG_DIRS directories with subdir} \
-setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_CONFIG_DIRS) [file join /tmp xdg_config_dir 1]:
  append ::env(XDG_CONFIG_DIRS) [file join /tmp xdg_config_dir 2]
} -body {
  XDG::CONFIG_DIRS some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [list [file join /tmp xdg_config_dir 1 some_dir] \
                [file join /tmp xdg_config_dir 2 some_dir]]

test CONFIG_DIRS-3 {Returns default directories if XDG_CONFIG_DIRS not set} \
-setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_CONFIG_DIRS
} -body {
  XDG::CONFIG_DIRS
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [list [file join /etc xdg]]

test CONFIG_DIRS-4 {Returns default directories with subdir if XDG_CONFIG_DIRS\
                    not set but subdir passed} -setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_CONFIG_DIRS
} -body {
  XDG::CONFIG_DIRS some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [list [file join /etc xdg some_dir]]

test RUNTIME_DIR-1 {Returns the set XDG_RUNTIME_DIR directory} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_RUNTIME_DIR) [file join /tmp xdg_runtime_dir]
} -body {
  XDG::RUNTIME_DIR
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join  /tmp xdg_runtime_dir]

test RUNTIME_DIR-2 {Returns the set XDG_RUNTIME_DIR directory with subdir} -setup {
  TestHelpers::storeXDGvars
  set ::env(XDG_RUNTIME_DIR) [file join /tmp xdg_runtime_dir]
} -body {
  XDG::RUNTIME_DIR some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result [file join /tmp xdg_runtime_dir some_dir]

test RUNTIME_DIR-3 {Returns empty directory if XDG_RUNTIME_DIR not set} \
-setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_RUNTIME_DIR
} -body {
  XDG::RUNTIME_DIR
} -cleanup {
  TestHelpers::restoreXDGvars
} -result {}

test RUNTIME_DIR-4 {Returns empty directory if XDG_RUNTIME_DIR not set but\
                    subdir passed} -setup {
  TestHelpers::storeXDGvars
  TestHelpers::clearXDGvar XDG_RUNTIME_DIR
} -body {
  XDG::RUNTIME_DIR some_dir
} -cleanup {
  TestHelpers::restoreXDGvars
} -result {}

cleanupTests

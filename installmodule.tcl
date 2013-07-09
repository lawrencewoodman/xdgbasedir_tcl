#!/usr/bin/env tclsh
# Simple Tcl module install script
# Usage: installmodule <moduleFilename>
#
# Copyright (C) 2013 Lawrence Woodman <lwoodman@vlifesystems.com>
#
# Licensed under an MIT licence.  Please see LICENCE.md for details.
#
# The script will search the module path for a location where modules are
# already installed and try to pick the best location to install the module
# specified.  It must be run by a user that has permission to write to the
# directory.
#

# Get a list of directories in the module search path that are being used
proc getUsedModuleDirs {} {
  set usedModuleDirs {}
  set moduleDirs [split [::tcl::tm::path list]]
  foreach moduleDir $moduleDirs {
    set moduleNames [glob -nocomplain -directory $moduleDir/ *.tm]
    if {[llength $moduleNames] >= 1} {
      lappend usedModuleDirs $moduleDir/
    }
  }
  return $usedModuleDirs
}

# Get the best directory to put the module in
proc getBestModuleDir {moduleDirs} {
  set moduleDirs [getUsedModuleDirs]
  if {[llength $moduleDirs] == 0} {
    puts "Error: Couldn't find any suitable directories for the module"
    exit
  }
  return [lindex $moduleDirs end]
}

# Copy moduleFilename to the most suitable module location
proc installModule {moduleFilename} {
  set destModuleDir [getBestModuleDir [getUsedModuleDirs]]
  if {[catch {file copy -force $moduleFilename $destModuleDir} copyError]} {
     puts "Error: $copyError"
     exit
  }
  puts "Copied $moduleFilename to $destModuleDir"

}

# Outputs a usage suggestion if a single module in current directory
proc makeUsageSuggestion {} {
  set possibleModuleNames [glob -nocomplain *-*.*.tm]
  if {[llength $possibleModuleNames] == 1} {
    puts "Suggestion: installmodule [lindex $possibleModuleNames 0]"
  }
}

proc usageError {msg} {
  puts "Error: $msg"
  puts "Usage: installmodule <moduleFilename>"
  makeUsageSuggestion
  exit
}

if {$argc != 1} {
  usageError "wrong number of arguments"
}

set moduleFilename [lindex $argv 0]
set moduleFilenameRegexp {([[:alpha:]][:[:alnum:]]*)-([[:digit:]].*)\.tm}
if {![regexp $moduleFilenameRegexp $moduleFilename]} {
  usageError "$moduleFilename isn't a valid name for a module"
}

installModule $moduleFilename

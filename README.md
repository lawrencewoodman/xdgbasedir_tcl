xdgbasedir_tcl
==============
A Tcl module to simplify access to the XDG Base Directory Specification

[The XDG Base Directory Specification](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) aims to tidy up the files related to an application and standardize their location.

Requirements
------------
*  Tcl 8.5+

Installation
------------
Copy the file `xdgbasedir-*.tm` to a location that tcl expects to find modules.  This would typically be something like:

    /usr/share/tcltk/tcl8.5/tcl8/

To find out what directories are searched for modules, start `tclsh` and enter:

    foreach dir [split [::tcl::tm::path list]] {puts $dir}

or from the command line:

    $ echo "foreach dir [split [::tcl::tm::path list]] {puts \$dir}" | tclsh

Module Usage
------------
To access the _XDG_ directories you would typically specify the subdirectory that these directories will be relative to.  The subdirectory is normally the name of the application:

    puts "XDG_DATA_HOME: [XDG::DATA_HOME myapp]"
    puts "XDG_CACHE_HOME: [XDG::CACHE_HOME myapp]"
    puts "XDG_CONFIG_HOME: [XDG::CONFIG_HOME myapp]"

    puts "XDG_RUNTIME_DIR: [XDG::RUNTIME_DIR myapp]"
    puts "XDG_DATA_DIRS: [XDG::DATA_DIRS myapp]"
    puts "XDG_CONFIG_DIRS: [XDG::CONFIG_DIRS myapp]"

The XDG procs ending in `_DIRS` return a list of directories in order of preference.


Testing
-------
There is a testsuite in `tests/`.  To run it:

    $ tclsh tests/xdgbasedir.test.tcl

Contributions
-------------
If you want to improve this module make a pull request to the [repo](https://github.com/LawrenceWoodman/xdgbasedir_tcl) on github.  Please put any pull requests in a separate branch to ease integration and add a test to prove that it works.

Licence
-------
Copyright (C) 2013, Lawrence Woodman

This software is licensed under an MIT Licence.  Please see the file, LICENCE.md, for details.

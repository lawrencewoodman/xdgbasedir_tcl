xdgbasedir_tcl
==============
A Tcl module to simplify access to the XDG Base Directory Specification

[The XDG Base Directory Specification] (http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) aims to tidy up the files related to an application and standardize their location.

Requirements
------------
*  Tcl 8.5+

Explanation
-----------
The main advantage of using this module is that the defauls are taken care of and the module as been well tested.

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

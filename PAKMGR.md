PM support
==========

autobuild supports various package managers, which can be selected using the `$ABPM` variable.

A package manager profile should contain the following functions to work properly:

  * `pack`: Packs `$PKGDIR` into a software package, using the PKG variables.
    * Each space-seperated item in `PKGDEP` may be written as `dep|depalt1[|depalt2..]`, where `dep` can either be just a name ,`nameOPERAND[ver]` or `name_`. `genver` and `depcom` in `lib/base` can help you parse and generate the versions.
      * The second form uses the operand `[<>=]=` as the version spec while the second form omitts the version from the Dependencies list. When ver is unspecified, autobuild uses the current version. 
      * The third form defines that the version should be unspecified in the resulting package.
  * `getdep [PACKAGES...]`: Make sure that the PACKAGES are installed so we aren't missing any of the dependencies.
  * `getver PKGNAME`: returns the version of PKGNAME. Used in `genver` (base).

post/pre-inst/rm scripts can be found in `$SRCDIR/abscripts`. The `pack` function should not change the contents of `$PKGDIR`. 

The functions can be either subshell functions or regular functions. Write a subshell func if you need to change some variables like `$PKGNAME` and `$PKGVER` (this happens with RPM.) Names of custom functions should be added to `$_ab_pm_func`.

PM support in lib/base
----------------------

The `depcom` function can help you generate a comma-seperated list of dependencies. For package manager lists, it should work better than `commaprint`.

The functions use the following variables to match the syntax of of your package manager:

Name		| Type	| Default Value		| Description
----------------|-------|-----------------------|------------
OP_{EQ,LE,GE}	| string| `= `, `<= `, `>= `	| Operators for version spec in dependencies.
VER_S, VER_E	| string| ` (`, `)`		| What to start/end the version strings with.
PM_COMMA	| string| `, `			| The comma used in dependencies to seperate items.
PM_DELIM	| string| ` | `			| The deliminator used to seperate alternatives.
PM_ALT		| bool	| 1			| Whether the PM supports alternative dependencies.
VER_NONE	| bool	| 0			| Whether `genver` should autofill the version of a simple depspec. Set to 1 in `Conflicts` Listings: `VER_NONE=1 depcom ...`.

All the global ones are listed in the variable `$_ab_pm`. You can use `eval unset $_ab_pm` to reset them.

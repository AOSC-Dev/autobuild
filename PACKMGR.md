autobuild package manager support
=================================

autobuild supports various package managers, which can be selected using the `$ABPM` variable.

A package manager profile should contain the following functions to work properly:

  * `pack`: Packs `$PKGDIR` into a software package, using the PKG variables.
    * Each space-seperated item in `PKGDEP` may be written as `dep|depalt1[|depalt2..]`, where `dep` can either be just a name ,`nameOPERANDver` or `name_`. The second form uses the operand `[<>=]=` as the version spec while the second form omitts the version from the Dependencies list. In ab representation, `foo=ver` should have the same meaning as `foo==ver` or *equals to*. **This is still a TODO in dpkg, the native profile, so don't hurry to implement it.** The third form defines that the version should be unspecified in the resulting package.
  * `getdep [PACKAGES...]`: Make sure that the PACKAGES are installed so we aren't missing any of the dependencies.
  * `alternative link path priority [link2..]`: Manages a debian-style set of ALTERNATIVE symlinks.

post/pre-inst/rm scripts can be found in `$SRCDIR/abscripts`. The `pack` function should not change the contents of `$PKGDIR`.

The functions can be either subshell functions or regular functions. Write a subshell func if you need to change some variables like `$PKGNAME` and `$PKGVER` (this happens with RPM.)

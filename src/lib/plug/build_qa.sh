#!/bin/bash
# This is an experimental QA Check module for autobuild.
# Feel free to add more to it.
#
# Just yet another Developer.

# Check prefix now.
if [ -d $PKGDIR/usr/local ]; then
  echo -e "\e[31m/usr/local exists in your package tree!\e[0m"
  echo "This breaks the QA policy of AOSC OS3, please check back on your AUTOTOOLS_AFTER, CMAKE_AFTER or autobuild/build scriptlet."
  read -n 1 -p "Press any key to continue or C-c to quit..."
else
  echo -e "\e[32mDirectory tree looks good so far, proceeding...\e[0m"
fi


# Here above is all I can think of so far, feel free to add more.
#
# Well I have a TODO list here, not implemented yet:
#
# 1. Check for invalid symlinks
# 2. Check for free files in / or /usr/
# 3. ShLibDeps... Good ol' toolset.

cp --version | grep -q GNU || return

cp(){ command cp --reflink=auto; } # not doing -l; refer to scriptlets:cp-wrapper

#!/bin/bash
# bash.info 3.5.8.1 Pattern Matching
# temp func: lintdec whom  [ which-manager.. ]
lintdec(){
	declare -n whom=PKG$1
	local cnt=0
	[[ "$whom" = *([:digit:]) ]] ||
		warn "PKG$1 is not a decimal integer. This may cause problems with"
	shift;
	if [[ $# == 0 ]]; then
		echo -e "\tsome package managers.">&2
	else
		for i; do PM_COMMA=', ' mkcomma; echo $i; done;
	fi

}
lintdec EPOCH rpm pacman
lintdec REL rpm pacman
[[ "$PKGVER" =~ - ]] && warn "PKGVER contains dashes(-). It's suggested to translate
\tdashes to underlines(_)".
unset lintdec BASH_REMATCH

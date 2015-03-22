cd $PKGDIR
fileenum(){
	for i in `find .` # Well, be a bit BSD-find-friendly...
	do
		[ ! -e $i ] && continue
		eval "${1//{}/$i}"
	done
}
elfstrip(){
	if file $1 | grep -q '\: ELF'; then
		if grep -q '/s?bin/' <<< "$1"
		then strip --strip-all $1 2> /dev/null
		else strip --strip-debug $1 2> /dev/null 
		fi
	else return 0
	fi
}
elfstrip_dbg() {
  if ( file $1 | grep '\: ELF' > /dev/null )
  then strip --strip-debug $1
  else return 0
  fi
}
fltr_elffltr(){
        for i in {usr/,opt/*/,,}{lib,bin}
        do
                [ -d $i ] || continue
                pushd $i >/dev/null
                fileenum "$2 {}"
                popd >/dev/null
        done
}
if [ "$ABSTRIP" == "yes" ]; then fltr_elffltr elfstrip; else fltr_elffltr elfstrip_dbg; fi
cd $SRCDIR

# command_00_basic: basic command pack.
command_mk32(){
	local PKGNAME PKGDEP{,_32} BUILDDEP{,_32} p
	if [ "$1" == '--help' ]; then
		_command_help mk32 'generates a 32subsys package from existing one, into autobuild32.'
	fi
	cp autobuild autobuild32
	. autobuild32/defines
	grep -Ev '(PKGNAME|PKGDEP|BUILDDEP)=' autobuild32/defines > autobuild32/defines_
	for p in $PKGDEP; do PKGDEP_32+="$p+32 "; done
	for p in $BUILDDEP; do BUILDDEP_32+="$p+32 "; done
	cat - autobuild32/defines_ > autobuild32/defines <<-EOF
	# autobuild mk32
	PKGNAME=$PKGNAME+32
	PKGDEP="${PKGDEP::-1} 32subsystem"
	BUILDDEP="${BUILDDEP::-1}"
EOF
	echo "rm -rf /opt/32/share/locale" >> autobuild32/beyond
	sed -ri -e 's@\</usr@/opt/32@g' autobuild32/*
}
_command_new mk32
command_getdef(){
	local OPTIND OPTARG get32=1 REPO=os2
	if [ "$1" == '--help' ]; then
		_command_help -o 'r [REPO]=Defines which repository to use.' \
		-o 'n=Do not get 32subsys def automatically.' \
		'getdef [OPTIONS] PKGNAME' 'Gets the definitions of the given package.' 1
	fi
	while getopts "r:n"; do
		case $opt in
			r)	REPO="$OPTARG";;
			n)	get32=0;;
		esac
	done
	shift $((OPTIND-1))
	[ "$1" ] || return 2
	[[ "$1" == *+32 ]] && get32=0
	wget -nvO "$1"_def.tar.xz "https://mirrors.ustc.edu.cn/anthon/os2-repo/$REPO/$(archivedir "$1")/$1" || return $?
	mv autobuild{,_$(date -u +%s)}
	tar xf "$1"_def.tar.xz
	if ((get32)); then
		mv autobuild{,64}
		wget -nvO "$1"+32_def.tar.xz "https://mirrors.ustc.edu.cn/anthon/os2-repo/$REPO/$(archivedir "$1")/$1+32" &&
		tar xf "$1"+32_def.tar.xz &&
		mv autobuild{,32}
		mv autobuild{64,}
	fi
}
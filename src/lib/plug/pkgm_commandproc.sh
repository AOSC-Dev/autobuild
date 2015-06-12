#!/bin/bash
# Command parser invoked after lib loading
# syntax: autobuild command1 [args] [(CATCH|THEN) args]* [END] [unprocessed_args]
# This roughly provides a looks-like-promise programmable commanding.
# TODO: magic command 'catch', default actions for commands.
_command='clean init --help stop setdie '
_command_fun=''
_command_var=''
# interpreter related: mode & return val
_command_ret=0
_command_mod=then
_command_pos=0
_command_cnt=0
_command_die=0
_command_buf=()
_command_run(){
	# run buffered command
	((++_command_cnt))
	if ((_command_ret)) && [ "$_command_mod" == CATCH ]; then
		((${#command_buf[@]})) ||
			command_buf=(stop "cmd $_command_cnt (\$$_command_pos) rets $_command_ret")
		command_"${_command_buf[@]}"
		_command_ret=$?
	elif [ "$_command_mod" == THEN ]; then
		command_"${_command_buf[@]}"
		_command_ret=$?
	fi
	_command_buf=()
	_command_mod="$1"
}
# _command_new name VARS [-- tmpfuns]
# creates a new command and mark the var as to_unset.
_command_new(){
	_command+="$1 "
	shift
	local cmdinfo _IFS="$IFS" IFS=$'\n'
	local idx=($(array_divide cmdinfo '--' "$@"))
	IFS="$_IFS"
	_command_var+="${cmdinfo[@]:0:$idx} "
	_command_fun+="${cmdinfo[@]:$idx} "
}
# _command_help [OPTIONS] "USAGE-LINE" DESCRIPTION [setdie-val]
# OPTIONS:
# -o OPT=USAGE: Defines usage of option -ARG.
# -v VAR=VALUE: Defines what var in the USAGE-LINE is.
# -l LONG_HELP: Puts an extra paragraph under name: desc line.
# -t TAIL_NOTE: Puts an extra paragraph in the end.
_command_help(){
	local OPTIND OPTARG OPT _IFS="$IFS" usage IFS tmparr tmpidx
	declare -A opts vars
	declare -a longs tails
	while getopts "o:v:l:t:" OPT; do
		case $OPT in
			o|v)
				IFS='=' tmparr=($OPTARG) IFS="_$IFS" tmpidx="${tmparr[0]}"
				unset tmparr[0]
				case $OPT in
					o) opts[$tmpidx]="${tmparr[@]}";;
					v) vars[$tmpidx]="${tmparr[@]}";;
				esac;;
			l)	longs+=("$OPTARG");;
			t)	tails+=("$OPTARG");;
		esac
	done
	shift $((OPTIND-1))
	[ "$2" ] || exit 2
	tmparr=($1) tmpidx="${tmparr[0]}" # getname
	echo "$tmpidx: ${2=A weird command.}"
	[ "$3" ] && echo "Sets \$command_die to $3."
	if ((${#p[@]}>1)); then # usage line available!
		echo -e "\e[1mUSAGE:\e[0m"
		echo -e "\t$1\n"
	fi
	for tmpidx in "${!vars[@]}"; do
		echo -e "\e[1m$tmpidx\e[0m: ${vars[$tmpidx]}" | fold -s
	done
	for tmpidx in "${longs[@]}"; do
		echo -e "$tmpidx\n" | fold -s
	done
	if ((${#opts[@]})); then
		echo -e "\e[1mAvailable options:\e[0m"
		for tmpidx in "${!opts[@]}"; do
			echo -e "\e[1m-$tmpidx\e[0m: ${opts[$tmpidx]}\n" | fold -s
		done
	fi
	for tmpidx in "${tails[@]}"; do
		echo -e "$tmpidx\n" | fold -s
	done
}
# _command_list [OPTIONS] [COMMANDS]: lists seleted commands.
# OPTIONS:
# -i [INDENT-STR]
_command_list(){
	local OPTIND OPTARG indent=$'\t' cmds cmd
	while getopts 'i:'; do
		case $opt in
			i)	indent="$OPTARG";;
		esac
	done
	shift $((OPTIND-1))
	cmds=("$@")
	((${#cmds[@]})) || cmds=($_command)
	for cmd in "${cmds[@]}"; do echo -n "$indent"; "command_$cmd" --help | head -n 1; done
}
command_clean(){ rm -rf "$SRCDIR"/ab{dist,scripts,spec}; }
command_stop(){
	[ "$1" ] || set -- 'command_stop'
	die "$@"
}
command_init(){
	local i
	if [ "$1" == '--help' ]; then
		_command_help -l "This creates a defines rapidly." -t "Currently it does no verifications."
		"init PKGNAME PKGVER(EPOCH:VER-REL) PKGSEC PKGDEP 'PKGDESC' BUILDDEP" "Initializes an autobuild directory structure."
		return 0
	fi
	# TODO: Generalize verlint and call it here.
	cd $PKGDIR
	mkdir -p autobuild/patches
	for i in PKGNAME PKGVER PKGSEC PKGDEP PKGDESC BUILDDEP; do
		# good reusable form via printf
		echo "$i=$(printf %q "$1")" >> autobuild/defines
		shift || break
	done
}
command_--help(){
	_command_die=1
	if [ "$1" ]; then
		command_"$1" --help
		return _ret
	fi
	_command_help -v command="A Command to run." -l "Currently defined commands:\n$(_command_list -i $'\t\t')" \
	'autobuild <command> [args] [(CATCH|THEN) <command> args ...] [END] [unprocessed_args]' \
	'automatic source-building tool.'
}
command_setdie(){
	if [ "$1" == '--help' ]; then
		_command_help 'setdie [die=!$_command_die]<boolean>' 'Sets or flips if ab should go on after all commands are processed.'
	fi
	_command_die=${1:-$((!_command_die))}
}
abplug command
while (($#)); do
	((++_command_pos))
	case "$1" in
		THEN|CATCH)
			_command_run "$1";;
		END)	# stops the processing
			shift
			break;;
		*)
			_command_buf+=("$1");;
	esac
	shift || break
done
((${#command_buf[@]})) && _command_run THEN
((_command_die)) && die _command_die STOP $_command_ret
for _command_tmp in $_command; do unset command_$_command_tmp; done
for _command_tmp in $_command_fun $_command_var _command{,_{var,fun,pos,cnt,buf,ret,mod,tmp}}; do unset $_command_tmp; done

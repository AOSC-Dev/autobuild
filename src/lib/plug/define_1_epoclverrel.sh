#!/bin/bash
# This script rearranges PKGVER from [PKGEPOCH:]PKGVER[-PKGREL] format.
# TODO: save final results back to defines but do not add zero VER and EPOCH.

alias return='unset IFS split index; unalias return; return'

# epoch
[[ "$PKGEPOCH" ]] && return	# Wow new age guy!
IFS=:
split=($PKGVER)
case "${#split[@]}" in
	1)	PKGEPOCH=0;;
	2)	PKGEPOCH="$split" PKGVER="${split[2]}"
	*)	die "plug define_1_epoch:ver-rel: Too many :'s in PKGVER."
esac

# rel
(( PKGREL++ )) && return	# If there is one, inc.
IFS=-
split=($PKGVER)
index=${#split[@]}

case $index in
	1) PKGREL=0;;
	*) PKGREL=${split[$index]}; unset split[index]; PKGVER="${split[@]//-/_}"
esac

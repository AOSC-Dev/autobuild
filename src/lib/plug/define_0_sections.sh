#!/bin/bash
# Check sections
# 前方高能刷屏，无关人员请迅速撤离
qa_sec(){
#STARTSEC
  for qa_s in admin cli-mono comm database debian-installer debug \
  devel doc editors eletronics embedded fonts games gnome gnu-r gnustep \
  graphics hamradio haskell httpd interpreters java kde \
  kernel libdevel libs lisp localization mail math misc net news \
  ocaml oldlibs otherosfs perl php python ruby science shells \
  sound tex text utils vcs video virtual web x11 xfce zope
#ENDSEC
    do [ "$PKGSEC" == $qa_s ] && return 0; done
  return 1
}


if qa_sec
then info "\e[32mSection looks great, proceeding..." 
else warn "Section not in the stardard sections list. See https://github.com/AOSC-Dev/autobuild3/blob/master/sets/section or $ABLE/qa."
  read -n 1 -p "Press any key to continue or C-c to quit...
"
fi

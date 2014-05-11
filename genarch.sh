#!/bin/bash
# Autobuild arch generater.
# -*- vim:fenc=utf-8:shiftwidth=2::softtabstop=2
if [ "$1" == "" ] 
then
  echo -e "Please specify your target architecture.\n  Usage: ./genarch.sh <arch> <extra dpkg flags>" >&2
  exit 1
else
  [ "$1" == "amd64" ] || [ "$1" == "x86_64" ] && echo -e "Well, you are using amd64 (x86_64) and the original script is written for amd64...\nSkipping...." && exit 0
  mkdir $1
  cp -R amd64/* $1
  cd $1
  mv autobuild autobuild_old
  sed "s/amd64/$1/" autobuild_old > autobuild_mid
  sed "s/-Sextreme/$2/" autobuild_mid > autobuild
  rm -f autobuild_* && chmod +x autobuild
  echo "Complete!"
 fi


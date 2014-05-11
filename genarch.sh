#!/bin/bash
# Autobuild arch generater.
# -*- vim:fenc=utf-8:shiftwidth=2::softtabstop=2:autoindent
if [ $1 == "" ] 
then
  echo "Please specify your target architecture.\n  Usage: ./genarch.sh <arch>" >&2
  exit 1
else
  mkdir $1
  cp -R amd64/* $1
  cd $1
  mv autobuild autobuild_old
  sed "s/amd64/$1/" autobuild_old > autobuild
  rm -f autobuild_old && chmod +x autobuild
  echo "Complete!"
 fi


#!/bin/bash
forsec='for qa_s in'
echo autobuild2 QA Section updater.
p_help(){
  echo Reads Sections from the file or flow   specified.
  echo Possible usage:
  echo "  curl https://github.com/AOSC-Dev/autobuild3/raw/master/sets/section | ./updqasec.sh '&1'"
  echo "  ./updspec.sh /usr/lib/autobuild3/sets/section"
  exit 1
}
[ $1 ] || p_help
[ -e src/lib/qa ] || { echo src/lib/qa not found.; exit; }
exec 4<"${1=&1}"
while read s -u 4; do forsec+=" s" done
forsec=$(fold -s -w 74 <<< "$forsec" | while read s; do echo "  $s "'\'; done)
while read l; do
  if [ "$l" == '#STARTSEC' ]; then
    echo '#STARTSEC'
    cat <<< "$forsec"
    echo '#ENDSEC'
    while read s; do [ "$s" == '#ENDSEC' ] && break; done # Skip..
  else echo "$s"
  fi
done < src/lib/plug/define_0_sections > src/lib/.plug/define_0_sections
mv src/lib/{,_}plug/define_0_sections
mv src/lib/{.,}plug/define_0_sections
exec 4<&-

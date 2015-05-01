# pack-xtra: Illustrates how to generate an extra package with plugins.

unset pack
export ABPM=rpm ORIG=$ABPM

. $ABLE/$ABPM || die "$ABPM packing function import failed"
_ab_plug xtra_to_$ABPM

pack

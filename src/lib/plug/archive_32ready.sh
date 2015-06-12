cd $SRCDIR
if [ -d autobuild32 ]; then
	mv autobuild{,64}
	mv autobuild{32,}
fi
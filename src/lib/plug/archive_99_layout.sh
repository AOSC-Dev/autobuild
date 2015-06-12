# layout: performs autolayout on ~/ab2-built/${REPO=os2}
# $REPO: target apt repo

if ((!${#PM_PKG[@]})); then
	shopt -q nullglob || ! nullglob=0 || shopt -s nullglob
	PM_PKG=( $PKGNAME*.deb $PKGNAME*.rpm )
	((nullglob)) || shopt -u nullglob
fi
mkdir -p "~/ab2-built/${REPO=os2}/$(archivedir "$PKGNAME")"
mv ${PM_PKG[@]} ${PKGNAME}_${PKGVER//:/_}.tar.xz "~/ab2-built/$REPO/$(archivedir "$PKGNAME")"
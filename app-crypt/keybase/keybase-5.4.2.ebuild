# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator

MY_PV=$(replace_version_separator 3 '-')

DESCRIPTION="Client for keybase.io"
HOMEPAGE="https://keybase.io/"
SRC_URI="https://github.com/keybase/client/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-lang/go
	sys-apps/yarn
	net-libs/nodejs[npm]"
RDEPEND="${DEPEND}
	app-crypt/kbfs
	app-crypt/gnupg
	sys-fs/fuse
	gnome-base/gconf
	x11-libs/libXScrnSaver"

S="${WORKDIR}/src/github.com/keybase/client"

src_unpack() {
	unpack "${P}.tar.gz"
	mkdir -p "$(dirname "${S}")" || die
	mv "client-${MY_PV}" "${S}" || die
}

src_prepare() {
	eapply_user
	local inhibit_arch
	use amd64 && inhibit_arch=i386
	use x86 && inhibit_arch=amd64
	if [ -n "$inhibit_arch" ]; then
		sed -i '/debian_arch='$inhibit_arch'/,/^$/ s/^build_one/#\0/' client/packaging/linux/build_binaries.sh
	fi
}

src_compile() {
	${S}/packaging/linux/build_binaries.sh prerelease build_dir
}

src_install() {
	use amd64 && cd build_dir/binaries/amd64
	use x86 && cd build_dir/binaries/i386

	exeinto /opt/keybase
	doexe opt/keybase/Keybase
	doexe opt/keybase/libffmpeg.so
	doexe opt/keybase/libnode.so
	doexe opt/keybase/post_install.sh
	rm -f opt/keybase/{Keybase,lib*.so,post_install.sh}

	insinto /opt
	doins -r opt/keybase

	exeinto /usr/bin
	doexe usr/bin/kbfsfuse
	doexe usr/bin/kbnm
	doexe usr/bin/keybase
	doexe usr/bin/run_keybase

	for d in etc/chromium etc/opt/chrome; do
		insinto /$d/native-messaging-hosts
		doins $d/native-messaging-hosts/io.keybase.kbnm.json
	done

	domenu usr/share/applications/keybase.desktop

	cd usr/share/icons/hicolor
	local size
	for size in *; do
		doicon -s $size $size/apps/keybase.png
	done
}

pkg_postinst() {
	elog "Run the service: keybase service"
	elog "Run the client:  keybase login"
}
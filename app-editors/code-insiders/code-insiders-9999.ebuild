# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils pax-utils desktop

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
BASE_URI="https://vscode-update.azurewebsites.net/latest"
SRC_URI="
	x86? ( ${BASE_URI}/linux-ia32/insider ->  ${P}_x86.tar.gz )
	amd64? ( ${BASE_URI}/linux-x64/insider -> ${P}_amd64.tar.gz )
	"
RESTRICT="mirror strip"

LICENSE="EULA MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	sys-apps/yarn
	net-libs/nodejs[npm]
	media-libs/libpng
	x11-libs/gtk+
	x11-libs/cairo
	gnome-base/gconf
	x11-libs/libXtst
"

RDEPEND="
	${DEPEND}
	net-print/cups
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	app-crypt/libsecret[crypt]
"

QA_PRESTRIPPED="opt/${PN}/code"

pkg_setup(){
	use amd64 && S="${WORKDIR}/VSCode-linux-x64" || S="${WORKDIR}/VSCode-linux-ia32"
}

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	dosym "/opt/${PN}/bin/code-insiders" "/usr/bin/${PN}"
	make_desktop_entry "${PN}" "Visual Studio Code" "${PN}" "Development;IDE"
	doicon ${FILESDIR}/${PN}.png
	fperms +x "/opt/${PN}/code-insiders"
	fperms +x "/opt/${PN}/bin/code-insiders"
	insinto "/usr/share/licenses/${PN}"
	doins "resources/app/LICENSE.rtf"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}

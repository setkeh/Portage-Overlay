# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="Tibia is a free fantasy MMORPG."
HOMEPAGE="http://www.tibia.com/"
SRC_URI="https://static.tibia.com/download/tibia.x64.tar.gz"

LICENSE="CipSoft GmbH"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="virtual/opengl"

S=${WORKDIR}/Tibia
src_install() {

	insinto "/opt/tibia"
	doins -r *
	dosym /opt/tibia/Tibia /usr/bin/tibia
}
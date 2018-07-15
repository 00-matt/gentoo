# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_P="${P^g}"

DESCRIPTION="Kakasi binding for Gauche"
HOMEPAGE="http://gauche.sf.net/"
SRC_URI="mirror://sourceforge/${PN%-*}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-scheme/gauche
	>=app-i18n/kakasi-2.3.4"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

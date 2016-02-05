# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Generation of bin_prot readers and writers from types"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV%.*}/files/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-ml/ppx_tools:=
	dev-ml/ppx_core:=
	dev-ml/ppx_type_conv:=
	>=dev-ml/bin-prot-113.24.00:=
	"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS=( CHANGES.md )

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps systemd user tmpfiles

DESCRIPTION="Modern asynchronous DNS API"
HOMEPAGE="https://getdnsapi.net/"
SRC_URI="https://getdnsapi.net/releases/${P//./-}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +getdns-query +getdns-server-mon +idn libev libevent libuv static-libs stubby +threads +unbound"

# https://bugs.gentoo.org/661760
# https://github.com/getdnsapi/getdns/issues/407
RESTRICT="test"

DEPEND="
	dev-libs/libbsd:=
	dev-libs/libyaml:=
	idn? ( net-dns/libidn2:= )
	dev-libs/openssl:0=
	libev? ( dev-libs/libev:= )
	libevent? ( dev-libs/libevent:= )
	libuv? ( dev-libs/libuv:= )
	unbound? ( >=net-dns/unbound-1.4.16:= )
"
RDEPEND="
	${DEPEND}
	stubby? ( sys-libs/libcap:= )
"
BDEPEND="
	doc? ( app-doc/doxygen )
"

PATCHES=( "${FILESDIR}/${PN}-1.4.2-stubby.service.patch" )

src_configure() {
	econf \
		--runstatedir=/var/run \
		$(use_enable static-libs static) \
		$(use_with getdns-query getdns_query) \
		$(use_with getdns-server-mon getdns_server_mon) \
		$(use_with idn libidn2) \
		$(use_with libev) \
		$(use_with libevent) \
		$(use_with libuv) \
		$(use_with stubby) \
		$(use_with threads libpthread) \
		$(use_with unbound libunbound) \
		--without-libidn \
		--with-piddir=/var/run/stubby
}

src_install() {
	default
	if use stubby; then
		newinitd "${FILESDIR}"/stubby.initd-r1 stubby
		newconfd "${FILESDIR}"/stubby.confd-r1 stubby
		insinto /etc/logrotate.d
		newins "${FILESDIR}"/stubby.logrotate stubby
		systemd_dounit "${S}"/stubby/systemd/stubby.service
		dotmpfiles "${S}"/stubby/systemd/stubby.conf
	fi
}

pkg_postinst() {
	if use stubby; then
		enewgroup stubby
		enewuser stubby -1 -1 -1 stubby
		fcaps cap_net_bind_service=ei /usr/bin/stubby
	fi
}

#!/bin/sh

#set -x
#env >> /tmp/env.log

########################################################################

my_distdir=/usr/local/share/dist

my_confdir=/etc/squid
my_datadir=/var/cache/squid
my_logdir=/var/log/squid
my_rundir=/run/squid
my_user=squid

########################################################################

create_confdir() {
	mkdir -p "$my_confdir"
	chown -R root:"$my_user" "$my_confdir"
	chmod 2750 "$my_confdir"
}

create_conf() {
	for i in $my_distdir/*.conf $my_distdir/*.css; do
		cp -uaf "$i" "$my_confdir/"
	done

	chown -R root:"$my_user" "$my_confdir"
	find "$my_confdir" -type f -exec chmod 0640 {} \;
}

create_logdir() {
	mkdir -p "$my_logdir"
	chown -R "$my_user":adm "$my_logdir"
	chmod 2750 "$my_logdir"
}

create_datadir() {
	mkdir -p "$my_datadir"

	if [ ! -d "$my_datadir/00" ]; then
		chown "$my_user":"$my_user" "$my_datadir" && \
		/usr/sbin/squid -N -z
	fi
	chown -R "$my_user":"$my_user" "$my_datadir"
}

create_rundir() {
	mkdir -p "$my_rundir"
	chown -R "$my_user":"$my_user" "$my_rundir"
	chmod 2750 "$my_rundir"

	[ -f "$my_rundir/squid.pid" ] && rm -f "$my_rundir/squid.pid"
}

start_daemon() {
	su -s /bin/sh - "$my_user" -c "/usr/sbin/squid -NYCd 1"
}

########################################################################

create_confdir
create_conf
create_logdir
create_rundir
create_datadir

start_daemon


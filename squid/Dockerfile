
FROM		kleinf/alpine

MAINTAINER	Florian L. Klein <it@f-klein.info>

RUN		echo "### Installing Squid..." && \
		apk upgrade -U && \
		apk add --update squid && \
		echo "### ...done!"

RUN		echo "### Creating directory for dist defaults..." && \
		mkdir -p /usr/local/sbin/ && \
		mkdir -p /usr/local/share/dist && \
		mv -f /etc/squid/* /usr/local/share/dist/ && \
		echo "### ...done!"

VOLUME		[ "/etc/squid",       \
		  "/var/cache/squid", \
		  "/var/log/squid"    ]

COPY		init.sh		/usr/local/sbin/
COPY		squid.conf	/usr/local/share/dist/

RUN		echo "### Installing init script..." && \
		chmod 0755 /usr/local/sbin/init.sh && \
		chmod 1777 /run && \
		rm -rf /var/run && \
		ln -sf /run /var/run && \
		echo "### ...done!"

EXPOSE		3128
ENTRYPOINT	["/usr/local/sbin/init.sh"]


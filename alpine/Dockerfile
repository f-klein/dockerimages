########################################################################
#
# Build new Alpine Linux Docker image from scratch by bootstrapping
#

# Use stock Alpine image as base (only needs APK)
#
FROM		alpine as builder
MAINTAINER	Florian L. Klein <it@f-klein.info>

RUN		echo "### Installing Alpine base in chroot..." && \
		mkdir -p /target && \
		apk	-X `grep -v "^#" /etc/apk/repositories | head -1` \
			-U --allow-untrusted --initdb \
			--root /target/ \
			add alpine-baselayout alpine-keys apk-tools busybox libc-utils && \
		cp -f /etc/apk/repositories /target/etc/apk/repositories && \
		cp -f /etc/alpine-release /target/etc/alpine-release && \
		find /target/ -name '*.apk-new' -delete && \
		echo "### ...done!"

########################################################################

FROM		scratch as intermediate
MAINTAINER	Florian L. Klein <it@f-klein.info>

COPY		--from=builder		/target/	/

RUN		echo "### Extending repositories..." && \
		repo=`grep '^http.*main' /etc/apk/repositories | head -1 |sed 's/v[0-9].[0-9].*$//'` && \
		for i in main community testing; do \
			echo "$repo/edge/$i" >> /etc/apk/repositories ; \
		done && \
		echo "### ...done!"

RUN		echo "### Updating system..." && \
		apk -U upgrade --purge && \
		echo "### ...done!"

RUN		echo "### Cleaning up..." && \
		find /var/cache -type f -delete && \
		echo "### ...done!"

########################################################################

FROM		scratch as new
MAINTAINER	Florian L. Klein <it@f-klein.info>

COPY		--from=intermediate		/	/


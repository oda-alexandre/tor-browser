FROM debian:stretch-slim

MAINTAINER https://oda-alexandre.github.io

RUN apt-get update && apt-get install --no-install-recommends -y \
sudo \
ca-certificates \
curl \
dirmngr \
gnupg \
libasound2 \
libdbus-glib-1-2 \
libgtk-3-0 \
libxrender1 \
libx11-xcb-dev \
libx11-xcb1 \
libxt6 \
xz-utils

RUN useradd -d /home/torbrowser -m torbrowser && \
passwd -d torbrowser && \
adduser torbrowser sudo

RUN cd /tmp && \
	curl -sSOL "https://dist.torproject.org/torbrowser/8.0.4/tor-browser-linux64-8.0.4_fr.tar.xz" && \
	curl -sSOL "https://dist.torproject.org/torbrowser/8.0.4/tor-browser-linux64-8.0.4_fr.tar.xz.asc" && \
	export GNUPGHOME="$(mktemp -d)" && \
	for server in $(shuf -e \
	 ha.pool.sks-keyservers.net \
	 hkp://p80.pool.sks-keyservers.net:80 \
	 keyserver.ubuntu.com \
	 hkp://keyserver.ubuntu.com:80 \
	 pgp.mit.edu) ; do \
	gpg --no-tty --keyserver "${server}" --recv-keys 0x4E2C6E8793298290 && break || : ; \
done && \
gpg --fingerprint --keyid-format LONG 0x4E2C6E8793298290 | grep "Key fingerprint = EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290" && \
gpg --verify tor-browser-linux64-8.0.4_fr.tar.xz.asc && \
tar -vxJ --strip-components 1 -C /usr/local/bin -f tor-browser-linux64-8.0.4_fr.tar.xz && \
rm -rf tor-browser* "$GNUPGHOME" && \
chown -R torbrowser:torbrowser /usr/local/bin

COPY ./includes/local.conf /etc/fonts/local.conf

WORKDIR /home/torbrowser

USER torbrowser

ENTRYPOINT /bin/bash
CMD /usr/local/bin/Browser/start-tor-browser --log /dev/stdout

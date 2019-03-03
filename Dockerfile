FROM debian:stretch-slim

MAINTAINER https://oda-alexandre.com

# VARIABLES
ENV USER torbrowser
ENV VERSION 8.0.4
ENV KEYSERVER 0x4E2C6E8793298290
ENV FINGERPRINT EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290

# INSTALLATION DES PREREQUIS
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
xz-utils && \

# AJOUT UTILISATEUR
useradd -d /home/torbrowser -m torbrowser && \
passwd -d torbrowser && \
adduser torbrowser sudo && \

# INSTALLATION DE L'APPLICATION ET DE LA CLEF GPG
cd /tmp && \
	curl -sSOL "https://dist.torproject.org/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_fr.tar.xz" && \
	curl -sSOL "https://dist.torproject.org/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_fr.tar.xz.asc" && \
	export GNUPGHOME="$(mktemp -d)" && \
	for server in $(shuf -e \
	 ha.pool.sks-keyservers.net \
	 hkp://p80.pool.sks-keyservers.net:80 \
	 keyserver.ubuntu.com \
	 hkp://keyserver.ubuntu.com:80 \
	 pgp.mit.edu) ; do \
	gpg --no-tty --keyserver "${server}" --recv-keys ${KEYSERVER} && break || : ; \
done && \
gpg --fingerprint --keyid-format LONG ${KEYSERVER} | grep "Key fingerprint = ${FINGERPRINT}" && \
gpg --verify tor-browser-linux64-${VERSION}_fr.tar.xz.asc && \
tar -vxJ --strip-components 1 -C /usr/local/bin -f tor-browser-linux64-${VERSION}_fr.tar.xz && \
rm -rf tor-browser* "$GNUPGHOME" && \
chown -R torbrowser:torbrowser /usr/local/bin

# AJOUT INCLUDES /etc/fonts/local.conf
COPY ./includes/local.conf /etc/fonts/local.conf

# SELECTION ESPACE DE TRAVAIL
WORKDIR /home/torbrowser

# SELECTION UTILISATEUR
USER torbrowser

# COMMANDE AU DEMARRAGE DU CONTENEUR
CMD /bin/bash /usr/local/bin/Browser/start-tor-browser --log /dev/stdout

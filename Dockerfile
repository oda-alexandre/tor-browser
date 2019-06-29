# IMAGE TO USE
FROM debian:stretch-slim

# MAINTAINER
MAINTAINER https://www.oda-alexandre.com/

# VARIABLES
ENV USER torbrowser
ENV VERSION 8.5.3
ENV KEYSERVER 0x4E2C6E8793298290
ENV FINGERPRINT EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290

# INSTALL PACKAGES
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

# ADD USER
useradd -d /home/${USER} -m ${USER} && \
passwd -d ${USER} && \
adduser ${USER} sudo && \

# INSTALL APP AND OF THE KEY GPG
curl -sSOL "https://dist.torproject.org/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_fr.tar.xz" && \
curl -sSOL "https://dist.torproject.org/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_fr.tar.xz.asc" && \
gpg --keyserver ha.pool.sks-keyservers.net --recv-keys ${KEYSERVER} && \
gpg --verify tor-browser-linux64-${VERSION}_fr.tar.xz.asc && \
tar -vxJ --strip-components 1 -C /usr/local/bin -f tor-browser-linux64-${VERSION}_fr.tar.xz && \
rm -rf tor-browser* "$GNUPGHOME" && \
chown -R ${USER}:${USER} /usr/local/bin && \

# CLEANING
apt-get --purge autoremove -y \
wget \
curl && \
apt-get autoclean -y && \
rm /etc/apt/sources.list && \
rm -rf /var/cache/apt/archives/* && \
rm -rf /var/lib/apt/lists/*

# SELECT USER
USER ${USER}

# SELECT WORKING SPACE
WORKDIR /home/${USER}

# START THE CONTAINER
CMD /bin/bash /usr/local/bin/Browser/start-tor-browser --log /dev/stdout \

FROM debian:buster-slim

LABEL authors https://www.oda-alexandre.com/

ENV USER torbrowser
ENV VERSION 8.5.3
ENV FINGERPRINT 0x4E2C6E8793298290
ENV KEYSERVER EF6E 286D DA85 EA2A 4BA7 DE68 4E2C 6E87 9329 8290

RUN echo -e '\033[36;1m ******* INSTALL PACKAGES ******** \033[0m' && \
  apt update && apt install --no-install-recommends -y \
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
  rm -rf /var/lib/apt/lists/*

RUN echo -e '\033[36;1m ******* ADD USER ******** \033[0m' && \
  useradd -d /home/${USER} -m ${USER} && \
  passwd -d ${USER} && \
  adduser ${USER} sudo

RUN echo -e '\033[36;1m ******* SELECT USER ******** \033[0m'
USER ${USER}

RUN echo -e '\033[36;1m ******* SELECT WORKING SPACE ******** \033[0m'
WORKDIR /home/${USER}

RUN echo -e '\033[36;1m ******* INSTALL APP AND KEY GPG ******** \033[0m' && \
  curl -sSOL -v https://dist.torproject.org/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_fr.tar.xz && \
  curl -sSOL -v https://dist.torproject.org/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_fr.tar.xz.asc && \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys ${FINGERPRINT} && \
  gpg --fingerprint --keyid-format LONG ${FINGERPRINT} | grep "Key fingerprint = ${KEYSERVER}" && \
  gpg --verify tor-browser-linux64-${VERSION}_fr.tar.xz.asc && \
  sudo tar -vxJ --strip-components 1 -C /usr/local/bin -f tor-browser-linux64-${VERSION}_fr.tar.xz && \
  rm -rf tor-browser* && \
  sudo chown -R ${USER}:${USER} /usr/local/bin && \
  sudo apt-get --purge autoremove -y wget curl

RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'
CMD /bin/bash /usr/local/bin/Browser/start-tor-browser --log /dev/stdout \
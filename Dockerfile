FROM debian:stretch-slim

LABEL authors https://www.oda-alexandre.com/

ENV USER torbrowser
ENV HOME /home/${USER}
ENV LOCALES fr_FR.UTF-8
ENV VERSION 9.0.2
ENV FINGERPRINT 0x4E2C6E8793298290

RUN echo -e '\033[36;1m ******* INSTALL PACKAGES ******** \033[0m'; \
  apt-get update && apt-get install --no-install-recommends -y \
  sudo \
  ca-certificates \
  curl \
  locales \
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

RUN echo -e '\033[36;1m ******* CHANGE LOCALES ******** \033[0m'; \
  locale-gen ${LOCALES}

RUN echo -e '\033[36;1m ******* ADD USER ******** \033[0m'; \
  useradd -d ${HOME} -m ${USER}; \
  passwd -d ${USER}; \
  adduser ${USER} sudo

RUN echo -e '\033[36;1m ******* SELECT USER ******** \033[0m'
USER ${USER}

RUN echo -e '\033[36;1m ******* SELECT WORKING SPACE ******** \033[0m'
WORKDIR ${HOME}

RUN echo -e '\033[36;1m ******* INSTALL APP AND KEY GPG ******** \033[0m'; \
  curl -sSOL https://dist.torproject.org/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_fr.tar.xz; \
  curl -sSOL -v https://www.torproject.org/dist/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_fr.tar.xz.asc; \
  for server in $(shuf -e \
  ha.pool.sks-keyservers.net \
  hkp://p80.pool.sks-keyservers.net:80 \
  pgp.mit.edu) ; \
  do \
  gpg --no-tty --keyserver ha.pool.sks-keyservers.net hkp://p80.pool.sks-keyservers.net:80 --recv-keys ${FINGERPRINT}; break || : ; done; \
  gpg --fingerprint --keyid-format LONG ${FINGERPRINT} | grep "Key fingerprint = EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290"; \
  gpg --verify tor-browser-linux64-${VERSION}_fr.tar.xz.asc; \
  sudo tar -vxJ --strip-components 1 -C /usr/local/bin -f tor-browser-linux64-${VERSION}_fr.tar.xz; \
  rm -rf tor-browser*; \
  do \
  sudo chown -R ${USER}:${USER} /usr/local/bin

RUN echo -e '\033[36;1m ******* CLEANING ******** \033[0m'; \
  sudo apt-get --purge autoremove -y \
  curl; \
  sudo apt-get autoclean -y; \
  sudo rm /etc/apt/sources.list; \
  sudo rm -rf /var/cache/apt/archives/*; \
  sudo rm -rf /var/lib/apt/lists/*

RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'

CMD /bin/bash /usr/local/bin/Browser/start-tor-browser --log /dev/stdout \
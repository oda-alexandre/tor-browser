FROM debian:stretch-slim

MAINTAINER https://oda-alexandre.github.io

RUN apt-get update && apt-get install --no-install-recommends -y \
sudo \
ca-certificates \
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

RUN echo 'deb http://deb.debian.org/debian stretch-backports main contrib' >> /etc/apt/sources.list

RUN useradd -d /home/torbrowser -m torbrowser && \
passwd -d torbrowser && \
adduser torbrowser sudo

RUN apt-get --purge autoremove -y

COPY ./includes/torbrowser.sh  /home/torbrowser/torbrowser.sh

WORKDIR /home/torbrowser/

RUN chmod +x torbrowser.sh

USER torbrowser

ENTRYPOINT /bin/bash

CMD ./torbrowser.sh

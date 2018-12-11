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
xz-utils \
wget

RUN useradd -d /home/torbrowser -m torbrowser && \
passwd -d torbrowser && \
adduser torbrowser sudo

USER torbrowser

WORKDIR /home/torbrowser/

RUN wget https://dist.torproject.org/torbrowser/8.0.3/tor-browser-linux64-8.0.3_fr.tar.xz
RUN sudo tar -xvJf tor-browser-linux64-8.0.3_fr.tar.xz
RUN rm -rf tor-browser-linux64-8.0.3_fr.tar.xz
RUN sudo chown -R torbrowser:torbrowser tor-browser_fr/
RUN chmod +x tor-browser_fr/Browser/start-tor-browser

RUN sudo apt-get --purge autoremove -y \
wget && \
sudo apt-get autoclean -y && \
sudo rm /etc/apt/sources.list && \
sudo rm -rf /var/cache/apt/archives/* && \
sudo rm -rf /var/lib/apt/lists/*

CMD cd tor-browser_fr/Browser/ && ./start-tor-browser

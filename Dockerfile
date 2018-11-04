FROM debian:latest

MAINTAINER https://oda-alexandre.github.io

RUN apt-get update

RUN apt-get install -y --no-install-recommends sudo ca-certificates wget xz-utils dirmngr libasound2 libdbus-glib-1-2 libgtk2.0-0 libgl1-mesa-dri libgl1-mesa-glx libxrender1 libx11-xcb-dev libx11-xcb1 libxt6 libpulse0 libcanberra-gtk-module

RUN useradd -d /home/torbrowser -m torbrowser
RUN passwd -d torbrowser
RUN adduser torbrowser sudo

RUN wget https://www.torproject.org/dist/torbrowser//8.0.3/tor-browser-linux64-8.0.3_fr.tar.xz
RUN tar -xvJf tor-browser-linux64-8.0.3_fr.tar.xz
RUN rm -rf tor-browser-linux64-8.0.3_fr.tar.xz
RUN chown -R torbrowser:torbrowser tor-browser_fr/
RUN cd tor-browser_fr/Browser/ && chmod +x start-tor-browser

RUN apt-get --purge autoremove -y wget xz-utils

USER torbrowser

ENTRYPOINT tor-browser_fr/Browser/start-tor-browser

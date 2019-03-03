# TOR BROWSER

[![dockeri.co](https://dockeri.co/image/alexandreoda/tor-browser)](https://hub.docker.com/r/alexandreoda/tor-browser)


## INDEX

- [Badges](#BADGES)
- [Introduction](#INTRODUCTION)
- [Prerequis](#PREREQUIS)
- [Installation](#INSTALLATION)
- [License](#LICENSE)


## BADGES

[![version](https://images.microbadger.com/badges/version/alexandreoda/tor-browser.svg)](https://microbadger.com/images/alexandreoda/tor-browser)
[![size](https://images.microbadger.com/badges/image/alexandreoda/tor-browser.svg)](https://microbadger.com/images/alexandreoda/tor-browser")
[![build](https://img.shields.io/docker/build/alexandreoda/tor-browser.svg)](https://hub.docker.com/r/alexandreoda/tor-browser)
[![automated](https://img.shields.io/docker/automated/alexandreoda/tor-browser.svg)](https://hub.docker.com/r/alexandreoda/tor-browser)


## INTRODUCTION

Ce repository contient le fichier Dockerfile de

- [Tor Browser](https://www.torproject.org/projects/torbrowser.html.en) en francais

Mis à jour automatiquement dans le [docker hub public](https://hub.docker.com/r/alexandreoda/tor-browser/)


## PREREQUIS

Installer [docker](https://www.docker.com)


## INSTALLATION

```
docker run -d --name tor-browser -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev/snd:/dev/snd -v /dev/shm:/dev/shm -v /etc/machine-id:/etc/machine-id:ro -e DISPLAY -v ${HOME}:/home/torbrowser alexandreoda/tor-browser
```

## LICENSE

[![GPLv3+](http://gplv3.fsf.org/gplv3-127x51.png)](https://github.com/oda-alexandre/tor-browser/blob/master/LICENSE)

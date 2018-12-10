# TOR BROWSER

![tor-browser](https://raw.githubusercontent.com/oda-alexandre/tor-browser/master/img/logo-tor-browser.png) ![docker](https://raw.githubusercontent.com/oda-alexandre/tor-browser/master/img/logo-docker.png)


## INDEX

- [Build Docker](#BUILD)
- [Introduction](#INTRODUCTION)
- [Prerequis](#PREREQUIS)
- [Installation](#INSTALLATION)
- [License](#LICENSE)


## BUILD DOCKER

[![tor-browser docker build](https://img.shields.io/docker/build/alexandreoda/tor-browser.svg)](https://hub.docker.com/r/alexandreoda/tor-browser)


## INTRODUCTION

Ce repository contient le fichier Dockerfile de [Tor Browser](https://www.torproject.org/projects/torbrowser.html.en) pour [Docker](https://www.docker.com), mis à jour automatiquement dans le [Docker Hub](https://hub.docker.com/r/alexandreoda/tor-browser/) public.


## PREREQUIS

Installer [Docker](https://www.docker.com)


## INSTALLATION

```
docker run -d --name tor-browser -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev/snd:/dev/snd -v /dev/shm:/dev/shm -v /etc/machine-id:/etc/machine-id:ro -e DISPLAY=unix$DISPLAY -v ${HOME}:/home/torbrowser alexandreoda/tor-browser
```

## LICENSE

[![GPLv3+](http://gplv3.fsf.org/gplv3-127x51.png)](https://github.com/oda-alexandre/tor-browser/blob/master/LICENSE)

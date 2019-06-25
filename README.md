# TOR BROWSER

<img src="https://img.generation-nt.com/tor-browser_0096006401660498.png" />  


## INDEX

- [Badges](#BADGES)
- [Introduction](#INTRODUCTION)
- [Prerequis](#PREREQUIS)
- [Installation](#INSTALLATION)
- [License](#LICENSE)


## BADGES

[![pipeline status](https://gitlab.com/oda-alexandre/tor-browser/badges/master/pipeline.svg)](https://gitlab.com/oda-alexandre/tor-browser/commits/master)


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

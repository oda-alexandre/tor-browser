# TOR BROWSER

<img src="https://img.generation-nt.com/tor-browser_0096006401660498.png" width="200" height="200"/>

## INDEX

- [TOR BROWSER](#tor-browser)
  - [INDEX](#index)
  - [BADGES](#badges)
  - [INTRODUCTION](#introduction)
  - [PREREQUISITES](#prerequisites)
  - [INSTALL](#install)
  - [LICENSE](#license)

## BADGES

[![pipeline status](https://gitlab.com/oda-alexandre/tor-browser/badges/master/pipeline.svg)](https://gitlab.com/oda-alexandre/tor-browser/commits/master)

## INTRODUCTION

Docker image of :

- [Tor Browser](https://www.torproject.org/projects/torbrowser.html.en) in french

Continuous integration on :

- [gitlab](https://gitlab.com/oda-alexandre/tor-browser/pipelines)

Automatically updated on :

- [docker hub public](https://hub.docker.com/r/alexandreoda/tor-browser/)

## PREREQUISITES

Use [docker](https://www.docker.com)

## INSTALL

```docker run -d --name tor-browser -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev/snd:/dev/snd -v /dev/shm:/dev/shm -v /etc/machine-id:/etc/machine-id:ro -e DISPLAY -v ${HOME}:/home/torbrowser alexandreoda/tor-browser```

## LICENSE

[![GPLv3+](http://gplv3.fsf.org/gplv3-127x51.png)](https://gitlab.com/oda-alexandre/tor-browser/blob/master/LICENSE)

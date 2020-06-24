# TOR BROWSER

![logo](https://assets.gitlab-static.net/uploads/-/system/project/avatar/12904482/Tor_Browser_logo.png)

- [TOR BROWSER](#tor-browser)
  - [INDEX](#index)
  - [BADGES](#badges)
  - [INTRODUCTION](#introduction)
  - [PREREQUISITES](#prerequisites)
  - [INSTALL](#install)
    - [DOCKER RUN](#docker-run)
    - [DOCKER COMPOSE](#docker-compose)
  - [LICENSE](#license)

## BADGES

[![pipeline status](https://gitlab.com/oda-alexandre/tor-browser/badges/master/pipeline.svg)](https://gitlab.com/oda-alexandre/tor-browser/commits/master)

## INTRODUCTION

Docker image of :

- [Tor Browser](https://www.torproject.org/projects/torbrowser.html.en) in french

Continuous integration on :

- [gitlab pipelines](https://gitlab.com/oda-alexandre/tor-browser/pipelines)

Automatically updated on :

- [docker hub public](https://hub.docker.com/r/alexandreoda/tor-browser/)

## PREREQUISITES

Use [docker](https://www.docker.com)

## BUILD

### DOCKER RUN

```\
docker run -d \
--name tor-browser \
-e DISPLAY \
-v ${HOME}:/home/torbrowser \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/shm:/dev/shm \
-v /etc/machine-id:/etc/machine-id:ro \
alexandreoda/tor-browser
```

### DOCKER COMPOSE

```yml
version: "2.0"

services:
  tor-browser:
    container_name: tor-browser
    image: alexandreoda/tor-browser
    restart: "no"
    privileged: false
    environment:
      - DISPLAY
    volumes:
      - "${HOME}:/home/torbrowser"
      - "/tmp/.X11-unix:/tmp/.X11-unix"
      - "/dev/shm:/dev/shm"
      - "/etc/machine-id:/etc/machine-id:ro"
    ports:
      - "80"
      - "443"
      - "9050"
```

## LICENSE

[![GPLv3+](http://gplv3.fsf.org/gplv3-127x51.png)](https://gitlab.com/oda-alexandre/tor-browser/blob/master/LICENSE)

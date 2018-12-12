#!/bin/sh

if [ -e /usr/bin/torbrowser-launcher ]
then
  torbrowser-launcher
else
  apt-get update && apt-get install -y torbrowser-launcher -t stretch-backports && torbrowser-launcher
fi

#!/bin/sh

if [ -e /etc/snort/snort.conf ]
then
  torbrowser-launcher
else
  apt-get update && apt-get install -y torbrowser-launcher -t stretch-backports && torbrowser-launcher
fi

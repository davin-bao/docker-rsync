#!/usr/bin/env bash

while true
do
    sleep $INTERVAL;
    rsync -avz --progress --delete --password-file=/tmp/rsyncd.secrets root@$SERVER::bind /tmp >> /var/rsync.log 2>&1;
done
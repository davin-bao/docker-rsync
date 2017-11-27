#!/usr/bin/env bash

while true
do
    sleep $INTERVAL;
    rsync -avz --progress --delete --password-file=/etc/client.secrets root@$SERVER::data /data >> /var/rsync.log 2>&1;
done
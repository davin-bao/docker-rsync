#!/usr/bin/env bash

touch /var/rsync.log;

if [ "$TYPE"x = "client"x ]; then
 chown root.root /etc/rsync/client.secrets;
 chmod 600 /etc/rsync/client.secrets;
 ./client_run.sh &
else
 chown root.root /etc/rsync/rsyncd.secrets;
 chmod 600 /etc/rsync/rsyncd.secrets;
 rsync --daemon --config=/etc/rsync/rsyncd.conf --log-file=/var/rsync.log;
fi

tail -f /var/rsync.log;
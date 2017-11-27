#!/usr/bin/env bash

touch /var/rsync.log;

if [ "$TYPE"x = "client"x ]; then
 chown root.root /etc/client.secrets;
 chmod 600 /etc/client.secrets;
 ./client_run.sh &
else
 chown root.root /etc/rsyncd.secrets;
 chmod 600 /etc/rsyncd.secrets;
 rsync --daemon --config=/etc/rsyncd.conf --log-file=/var/rsync.log;
fi

tail -f /var/rsync.log;
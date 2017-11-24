#!/usr/bin/env bash

chown root.root /etc/rsyncd.secrets
chmod 600 /etc/rsyncd.secrets

touch /var/rsync.log

rsync --daemon --config=/etc/rsyncd.conf --log-file=/var/rsync.log

tail -f /var/rsync.log


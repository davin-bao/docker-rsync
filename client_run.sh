#!/usr/bin/env bash

while true
do
    sleep $INTERVAL;
	
	var=`rsync -avz --stats --delete --password-file=/etc/rsync/client.secrets root@$SERVER::data /data | grep "Number of files transferred:"`;

	if [ "$var"x = "Number of files transferred: 0"x ]; then
	  echo $var >> /var/rsync.log;
	else
	  if [ ! -f /etc/rsync/update.lock ] ; then
		touch /etc/rsync/update.lock
	  fi
	  echo $var >> /var/rsync.log;
	fi
done
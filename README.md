# docker-bind
bind for docker


### In SERVER

```
docker run -it -v /tmp/bind/etc:/data -v /tmp/rsync/conf:/etc/rsync --name rsync -p 873:873 -e TYPE=master davinbao/rsync
```

### In Client

```
docker run -it -v /tmp:/data -v /tmp/rsync/conf:/etc/rsync --name rsynci_client -e TYPE=client -e SERVER=192.168.188.208 -e INTERVAL=1s  -e PORT=873 davinbao/rsync
OR
rsync -avz --progress --delete root@192.168.188.208::bind /tmp
```

### Compose File
``` yaml
version: '3.3'
services:
  rsync-server:
    image: davinbao/rsync:latest
    deploy:
      replicas: 1
      endpoint_mode: vip
      resources:
        limits:
          memory: 512M
    environment:
      TYPE: master
    volumes:
    - /xmisp/docker/rsync/conf:/etc/rsync
    - /xmisp/docker/bind/conf:/data:rw
    ports:
    - 873:873/tcp
    networks:
      - backend
  rsync-client:
    image: davinbao/rsync:latest
    deploy:
      replicas: 1
      endpoint_mode: vip
      resources:
        limits:
          memory: 512M
    environment:
      TYPE: client
      SERVER: 192.168.188.208
	  PORT: 873
      INTERVAL: 10s
    volumes:
    - /xmisp/docker/rsync/conf:/etc
    - /xmisp/docker/bind/conf:/data:rw
    ports:
    - 873:873/tcp
    networks:
      - backend
```
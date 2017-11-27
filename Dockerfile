FROM alpine:latest

MAINTAINER Davin Bao <davin.bao@gmail.com>

RUN set -x \
    && apk add --update bash openssh rsync

ENV TYPE "master"
ENV SERVER "127.0.0.1"
ENV INTERVAL 1m

RUN set -x \
    && mkdir /data \
    && mkdir /etc/rsync

COPY conf/rsyncd.conf /etc/rsync/
COPY conf/rsyncd.secrets /etc/rsync/
COPY conf/client.secrets /etc/rsync/

RUN set -x \
    && chown root.root /etc/rsync/rsyncd.secrets \
    && chmod 600 /etc/rsync/rsyncd.secrets \
    && chown root.root /etc/rsync/client.secrets \
    && chmod 600 /etc/rsync/client.secrets \
    && mkdir -p ~root/.ssh \
    && chmod 700 ~root/.ssh/

COPY entrypoint.sh /
COPY client_run.sh /
RUN set -x \
    && chmod +x /entrypoint.sh
RUN set -x \
    && chmod +x /client_run.sh

VOLUME ["/data", "/etc/rsync"]

EXPOSE 873

ENTRYPOINT ["/entrypoint.sh"]

# CMD ["rsync", "--daemon", "--config=/etc/rsync/rsyncd.conf", "--log-file=/var/rsync.log"]
FROM alpine:latest

MAINTAINER Davin Bao <davin.bao@gmail.com>

RUN set -x \
    && apk add --update bash openssh rsync

ENV TYPE "master"
ENV SERVER "127.0.0.1"
ENV INTERVAL 1m

COPY conf/rsyncd.conf /etc/
COPY conf/rsyncd.secrets /etc/
COPY conf/client.secrets /etc/

RUN set -x \
    && chown root.root /etc/rsyncd.secrets \
    && chmod 600 /etc/rsyncd.secrets \
    && chown root.root /etc/client.secrets \
    && chmod 600 /etc/client.secrets \
    && mkdir -p ~root/.ssh \
    && chmod 700 ~root/.ssh/

COPY entrypoint.sh /
COPY client_run.sh /
RUN set -x \
    && chmod +x /entrypoint.sh
RUN set -x \
    && chmod +x /client_run.sh

VOLUME ["/etc"]

EXPOSE 873

ENTRYPOINT ["/entrypoint.sh"]

# CMD ["rsync", "--daemon", "--config=/etc/rsyncd.conf", "--log-file=/var/rsync.log"]
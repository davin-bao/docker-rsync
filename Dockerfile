FROM alpine:latest

MAINTAINER Davin Bao <davin.bao@gmail.com>

RUN set -x \
    && apk add --update bash openssh rsync

VOLUME ["/etc"]

EXPOSE 22

ENV TYPE master

COPY conf/rsyncd.conf /etc/
COPY conf/rsyncd.secrets /etc/

RUN set -x \
    && chown root.root /etc/rsyncd.secrets \
    && chmod 600 /etc/rsyncd.secrets \
    && mkdir -p ~root/.ssh \
    && chmod 700 ~root/.ssh/

COPY entrypoint.sh /
RUN set -x \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["rsync", "--daemon", "--config=/etc/rsyncd.conf", "--log-file=/var/rsync.log"]

FROM alpine:3.16

RUN apk add bash frr

COPY frr_daemons.conf /etc/frr/daemons

ENTRYPOINT [ "/usr/lib/frr/docker-start" ]

FROM alpine:3.16

RUN apk add bash util-linux

ENTRYPOINT [ "script", "-qfc", "while true; do TERM=xterm-256color busybox sh; sleep 1; done" ]

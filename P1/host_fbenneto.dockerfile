FROM alpine:3.16

RUN apk add bash util-linux

RUN echo "PS1='\h\$ '" >> /etc/profile
ENV BASH_ENV=/etc/profile

ENTRYPOINT [ "script", "-qfc", "while true; do TERM=xterm-256color busybox sh; sleep 1; done" ]

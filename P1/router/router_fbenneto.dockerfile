FROM frrouting/frr:v8.2.2

RUN apk add bash

WORKDIR /usr/lib/frr

COPY daemons.conf /etc/frr/daemons
COPY start.sh /frr/start.sh

ENTRYPOINT [ "/frr/start.sh" ]

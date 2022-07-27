FROM frrouting/frr:v8.2.2

RUN apk add bash util-linux

RUN echo "PS1='\h\\$ '" >> /etc/profile
ENV BASH_ENV=/etc/profile

WORKDIR /usr/lib/frr

COPY daemons.conf /etc/frr/daemons

ENTRYPOINT [ "/usr/lib/frr/docker-start" ]

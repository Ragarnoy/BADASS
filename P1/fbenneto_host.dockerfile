FROM alpine:3.16

RUN apk add bash

ENTRYPOINT [ "/bin/bash" ]

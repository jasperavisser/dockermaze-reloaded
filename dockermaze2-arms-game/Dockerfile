FROM alpine:3.2
RUN apk update
RUN apk add bash sed
RUN rm -rf /var/cache/apk/*
COPY *.sh /opt/
ENTRYPOINT /opt/engage.sh

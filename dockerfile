FROM alpine:3.14.2

LABEL maintainer "gecko-developer@oxide.one"

RUN apk --no-cache add dnsmasq

VOLUME /etc/dnsmasq

EXPOSE 53 53/udp
EXPOSE 69 69/udp

ENTRYPOINT ["dnsmasq", "-k"]

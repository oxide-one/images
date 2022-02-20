FROM alpine:3.15

LABEL maintainer "gecko-developer@oxide.one"

RUN apk --no-cache add dnsmasq syslinux

COPY ./init.sh  /usr/bin

# DNS
EXPOSE 53 53/udp
# UDP
EXPOSE 69 69/udp

ENTRYPOINT ["init.sh"]

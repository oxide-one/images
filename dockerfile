FROM alpine:3.14.2

LABEL maintainer "gecko-developer@oxide.one"

RUN apk --no-cache add dnsmasq syslinux

RUN mkdir -p /config /tftp/boot /tftp/config /data

VOLUME /config /tftp/config /data

COPY ./init.sh      /usr/bin

RUN cp /usr/share/syslinux/lpxelinux.0 /usr/share/syslinux/efi64/syslinux.efi /tftp/boot

# DNS
EXPOSE 53 53/udp
# UDP
EXPOSE 69 69/udp

ENTRYPOINT ["init.sh"]

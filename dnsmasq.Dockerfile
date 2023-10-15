FROM ubuntu:impish-20220531 AS build

# Download dependencies
RUN dpkg --add-architecture i386
RUN apt update
RUN apt -y install -o Acquire::Retries=50 \
    git mtools syslinux isolinux \
    build-essential \
    libc6-dev-i386 libc6-dbg:i386 \
    libc6-dev-arm64-cross gcc-11-aarch64-linux-gnu gcc-aarch64-linux-gnu \
    liblzma-dev

# Clone the IPXE tree
RUN git clone https://github.com/ipxe/ipxe /ipxe

# Move to /ipxe 
WORKDIR /ipxe

# Enable HTTPS
RUN sed -i 's/#undef	DOWNLOAD_PROTO_HTTPS/#define	DOWNLOAD_PROTO_HTTPS/g' /ipxe/src/config/general.h

RUN grep "DOWNLOAD_PROTO_HTTPS" /ipxe/src/config/general.h
# Compile for x86_64
RUN make -j$(nproc) -C src \
    bin-x86_64-pcbios/undionly.kpxe \
    bin-x86_64-efi/ipxe.efi \
    bin/undionly.kpxe \
    bin-i386-efi/ipxe.efi

# Compile for ARM64 (aarch64)
RUN make -j 4 -C src CROSS=aarch64-linux-gnu- \
    bin-arm64-efi/ipxe.efi 

RUN mkdir -p /output/x86_64
RUN cp src/bin-x86_64-pcbios/undionly.kpxe src/bin-x86_64-efi/ipxe.efi /output/x86_64

RUN mkdir -p /output/i386
RUN cp src/bin/undionly.kpxe src/bin-i386-efi/ipxe.efi /output/i386

RUN mkdir -p /output/aarch64
RUN cp src/bin-arm64-efi/ipxe.efi /output/aarch64

FROM alpine:3.16
LABEL maintainer "gecko-developer@oxide.one"
RUN apk --no-cache add dnsmasq
COPY --from=build  /output /var/lib/tftproot
COPY ./init.sh  /usr/bin
# DNS
EXPOSE 53 53/udp
# UDP
EXPOSE 69 69/udp
ENTRYPOINT ["init.sh"]

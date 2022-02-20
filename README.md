# General Purpose DNSMASQ Docker image

# About
I tried looking for general purpose DNSMASQ Docker images to use, and couldn't find any. 

I made this one. 

It's DNSMSAQ, that's it. The only changes I have made are to add a basic test to check the configuration at startup, although it's not smart enough to really do anything beyond /etc/dnsmasq.conf and /etc/dnsmasq.d.

Commandline arguments are passed in normally.

Image is rebuilt weekly so I don't have to care about updates that much.

Feel free to base your images off of this one, and file any issues if things don't work!

# Quick Start

```bash
docker run \\ 
  --name dnsmasq \\
  --cap-add NET_ADMIN \\
  -v $(pwd)/dnsmasq.conf:/etc/dnsmasq.conf \\
  ghcr.io/oxide-one/dnsmasq:main
```

# tinc for Docker

Dockerfile (c) 2015 Jens Erat, email@jenserat.de  
Licensed under BSD license

> [tinc](http://www.tinc-vpn.org) is a Virtual Private Network (VPN) daemon that uses tunnelling and encryption to create a secure private network between hosts on the Internet.

This Dockerfile provides an image for running tinc 1.1 (pre release, as packaged by Debian).

## Usage

The default entrypoint of the container is tinc, so you can directly issue commands to tinc, for example `docker run jenserat/tinc init` (which will run `tinc init` inside the container) to have tinc create the basic configuration for you. Tinc's configuration is persisted as a volume, you can also share a host folder in `/etc/tinc`.

To make the VPN available to the host, and not only (linked) containers, use `--net=host`.

A reasonable basic run command loading persisted configuratino from `/srv/tinc` and creating the VPN on the host network would be

    docker run -d \
        --name tinc \
        --net=host \
        --volume /srv/tinc:/etc/tinc \
        jenserat/tinc start

## Administration and Maintenance

Instead of passing `start` as tinc command, you can also execute arbitrary other tinc commands. Run `help` for getting a list, of read the [tinc documentation](http://www.tinc-vpn.org/documentation-1.1/).

To enter the container for various reasons, use `docker exec`, for example as `docker exec -ti [container-name] /bin/bash`.

## Image Updates

The image is linked to the official Debian images, and automatically rebuild whenever the base image is updated. [tinc is fetched from the Debian experimental repositories](https://packages.debian.org/experimental/tinc) (where tinc 1.1 pre release versions are available).

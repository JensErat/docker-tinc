FROM debian
MAINTAINER Jean-Christophe Hoelt <hoelt@fovea.cc>

ENV TINC_VERSION=1.1~pre17-1.2

# Remove SUID programs
RUN for i in `find / -perm +6000 -type f 2>/dev/null`; do chmod a-s $i; done

RUN \
    export DEBIAN_FRONTEND=noninteractive && \
    mkdir -p /etc/tinc/nets.boot && \
    echo "deb-src http://httpredir.debian.org/debian/ experimental main contrib non-free"  >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y net-tools && \
    apt-get build-dep -y tinc=${TINC_VERSION} && \
    apt-get source --compile tinc=${TINC_VERSION} && \
    dpkg -i tinc_${TINC_VERSION}_amd64.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 655/tcp 655/udp
VOLUME /etc/tinc

ENTRYPOINT [ "/usr/sbin/tinc" ]
CMD [ "start", "-D", "-U", "nobody" ]

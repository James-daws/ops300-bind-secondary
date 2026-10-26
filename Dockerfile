FROM docker.io/library/ubuntu:24.04
RUN apt-get update && \
    apt-get install -y --no-install-recommends bind9 bind9-utils && \
    rm -rf /var/lib/apt/lists/*
COPY named.conf.options /etc/bind/
COPY named.conf.local /etc/bind/
RUN chown root:bind /etc/bind/named.conf.local && \
    chmod 640 /etc/bind/named.conf.local
EXPOSE 53/tcp 53/udp
VOLUME /var/cache/bind
STOPSIGNAL SIGKILL
CMD ["/usr/sbin/named", "-g", "-u", "bind", "-c", "/etc/bind/named.conf"]

FROM ubuntu:jammy

WORKDIR /build
RUN apt update && \
    apt install -y wget
RUN echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | tee /etc/apt/sources.list.d/resilio-sync.list && \
    wget -qO- https://linux-packages.resilio.com/resilio-sync/key.asc | tee /etc/apt/trusted.gpg.d/resilio-sync.asc > /dev/null 2>&1 && \
    apt update && \
    apt install -y resilio-sync

CMD rslsync --dump-sample-config > ./rslsync.conf

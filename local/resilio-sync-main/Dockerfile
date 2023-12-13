FROM ubuntu:jammy
WORKDIR /app
COPY ./app.sh ./
RUN apt update && \
    apt install -y wget
RUN echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | tee /etc/apt/sources.list.d/resilio-sync.list && \
    wget -qO- https://linux-packages.resilio.com/resilio-sync/key.asc | tee /etc/apt/trusted.gpg.d/resilio-sync.asc > /dev/null 2>&1 && \
    apt update && \
    apt install -y resilio-sync && \
    chmod +x ./* && \
    mkdir -p /app/config && \
    mkdir -p /resilio-sync
CMD ./app.sh

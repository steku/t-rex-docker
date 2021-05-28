#FROM ubuntu:20.04
FROM ubuntu

ARG ver

# Install default apps
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get upgrade -yq; \
    apt-get clean all
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -yq tzdata curl nvidia-driver-460-server; \
    apt-get clean all

RUN ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime; \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN useradd miner -u 6666 -d /home/miner -m

#RUN curl -L "https://github.com/trexminer/T-Rex/releases/download/${ver}/t-rex-${ver}-linux.tar.gz" -o t-rex.tar.gz
RUN curl -L https://trex-miner.com/download/t-rex-${ver}-linux.tar.gz -o t-rex.tar.gz
RUN tar xvzf t-rex.tar.gz -C /home/miner; \
    chmod +x /home/miner/t-rex

EXPOSE 4067
EXPOSE 4068

# Define working directory.
WORKDIR /home/miner/
USER miner

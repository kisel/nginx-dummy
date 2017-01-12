FROM  ubuntu:xenial
MAINTAINER Anton Kiselev <anton.kisel@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial main universe" > /etc/apt/sources.list
RUN apt-get update && apt-get install -y nginx openssl sudo && apt-get clean
ADD run.sh /root/run.sh
ADD network-tweaks.sh /root/network-tweaks.sh
WORKDIR /root

ENV HTTP_PORT=80
ENV HTTPS_PORT=443
CMD sh /root/run.sh


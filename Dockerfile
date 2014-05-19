FROM  ubuntu:12.04
MAINTAINER Anton Kiselev <anton.kisel@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nginx openssl curl && apt-get clean
ADD run.sh /root/run.sh
WORKDIR /root
CMD sh /root/run.sh


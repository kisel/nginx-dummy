FROM  ubuntu:12.04
MAINTAINER Anton Kiselev <anton.kisel@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nginx && apt-get clean
ADD nginx.conf /root/nginx.conf
WORKDIR /root
ENTRYPOINT ["nginx", "-c", "/root/nginx.conf"]


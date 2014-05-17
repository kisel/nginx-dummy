#!/bin/sh

curl -L https://gist.github.com/kisel/77d2bcafdf32f059f0a0/raw/tune_network.sh | sudo bash

openssl genrsa -out ssl.key 2048
openssl req -new -x509 -key ssl.key -out ssl.cert -days 3650 -subj /CN=localhost

sudo nginx -c `pwd`/nginx.conf


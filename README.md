Runs nginx dummy for performance testing
Default port is 7000

# Apply network tweaks

    curl -L https://gist.github.com/kisel/77d2bcafdf32f059f0a0/raw/tune_network.sh | sudo bash

# You can also run nginx in-place

    sudo nginx -c `pwd`/nginx.conf

# Dockerfile for dummy nginx server

    docker build -t kisel/nginx-dummy .
    docker run -p 7000:7000 kisel/nginx-dummy


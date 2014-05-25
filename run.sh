#!/bin/sh
# applies network tweaks
# generates nginx configuration in /tmp/nginx-dummy.<http_port>/
# and runs nginx
# vars:
# HTTP_PORT, HTTPS_PORT ( defaults 7080, 7443 )


[ -z "$HTTP_PORT" ] && HTTP_PORT=7080
[ -z "$HTTPS_PORT" ] && HTTPS_PORT=7443
[ -z "$WORKERS" ] && WORKERS=4

[ -z "$LOGGING" ] && LOGGING=error

CFG_DIR=/tmp/nginx-dummy.$HTTP_PORT
NGINX_CONF=$CFG_DIR/nginx.conf
ACCESS_LOG=off
[ -n "$ACCESS" ] && ACCESS_LOG=$CFG_DIR/access.log

main() {
  sudo sh network-tweaks.sh

  mkdir -p $CFG_DIR


  openssl genrsa -out $CFG_DIR/ssl.key 2048
  openssl req -new -x509 -key $CFG_DIR/ssl.key -out $CFG_DIR/ssl.cert -days 3650 -subj /CN=localhost

  gen_nginx_cfg
  sudo nginx -c $NGINX_CONF
}

gen_nginx_cfg() {
cat <<END > $NGINX_CONF
worker_processes $WORKERS;
daemon off;

events {
    worker_connections 200000;
    multi_accept on;
    use epoll;
}

worker_rlimit_nofile 200000;
error_log stderr $LOGGING;

http {
    # cache informations about FDs, frequently accessed files
    # can boost performance, but you need to test those values
    open_file_cache max=200000 inactive=20s;
    open_file_cache_valid 30s;
    open_file_cache_min_uses 2;
    open_file_cache_errors on;

    access_log $ACCESS_LOG;

    # copies data between one FD and other from within the kernel
    # faster then read() + write()
    sendfile on;

    # send headers in one peace, its better then sending them one by one
    tcp_nopush on;

    # don't buffer data sent, good for small data bursts in real time
    tcp_nodelay on;

    # number of requests client can make over keep-alive
    keepalive_requests 100000;

    # if client stop responding, free up memory -- default 60
    send_timeout 60;

    types_hash_max_size 2048;

    server {
        listen $HTTP_PORT default_server;
        listen $HTTPS_PORT ssl;

	ssl_certificate $CFG_DIR/ssl.cert;
	ssl_certificate_key $CFG_DIR/ssl.key;
	ssl_session_timeout 5m;

        location / {
            return 200 "42";
        }
    }


}
END

}

main


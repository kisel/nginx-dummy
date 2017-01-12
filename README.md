Runs nginx dummy for performance testing.

### Run in Docker
default ports are 80(http) and 443(https)

simple mode
    docker run -d --name nginx-dummy kisel/nginx-dummy

getting container internal ip
    docker inspect --format '{{ .NetworkSettings.IPAddress }}' nginx-dummy

privileged mode, no bridge. will use 80 and 443 ports
    docker run -d --name nginx-dummy --net="host" kisel/nginx-dummy

### To run w/o docker
Root access is required (via sudo) to perform kernel tweaking, extending `ulimit -n`
default ports are defined by follwing env variables:

    sudo apt-get install -y nginx
    git clone https://github.com/kisel/nginx-dummy.git
    cd nginx-dummy
    # run nginx. to use defaults just run sh run.sh
    env WORKERS=4 HTTP_PORT=7080 HTTPS_PORT=7443 sh run.sh

### Additional options
can be specified as env vars

- LOGGING=error|warn|info|debug  - sets nginx error_log filter
- ACCESS=<empty>|1 - enables access logs to /tmp/nginx-dummy.<http-port>/access.log
- WORKERS=<num> | auto - sets worker_processes. 4 by default


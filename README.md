Runs nginx dummy for performance testing.

### Ports:
- http  7080
- https 7443

### Run in Docker
Build the image:

    docker build -t kisel/nginx-dummy github.com/kisel/nginx-dummy

Run inside Docker using native network interface(requires Docker >= 0.11)
to avoid performance drop.
Privileged option is required to increase ulimit and apply kernel settings

    docker run -e HTTP_PORT=7080 -e HTTPS_PORT=7443 -d --name nginx-dummy --privileged --net="bridge" kisel/nginx-dummy

Run inside Docker network. (lower performance)

    docker run -d --privileged -p 7080:7080 -p 7443:7443 kisel/nginx-dummy

### To run w/o docker
Root access is required (via sudo) to perform kernel tweaking, extending `ulimit -n`

    sudo apt-get install -y nginx
    git clone https://github.com/kisel/nginx-dummy.git
    cd nginx-dummy
    # run nginx. to use defaults just run sh run.sh
    env HTTP_PORT=7080 HTTPS_PORT=7443 sh run.sh

### Additional options
can be specified as env vars

- LOGGING=error|warn|info|debug  - sets nginx error_log filter
- ACCESS=<empty>|1 - enables access logs to /tmp/nginx-dummy.<http-port>/access.log


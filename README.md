Runs nginx dummy for performance testing.

### Ports:
- http  7080
- https 7443

### Run in Docker
requires Docker >= 0.11

```
docker build -t kisel/nginx-dummy github.com/kisel/nginx-dummy
docker run -d --name nginx-dummy --privileged --net="host" kisel/nginx-dummy
```

This will run nginx using host adapter. privileged is required for increasing ulimit
and to apply *global* kernel settings

for custom ports
`-e HTTP_PORT=7080 -e HTTPS_PORT=7443`
can be added to docker parameters

Run inside Docker network. (but with bridge overhead)

```
docker run -d --privileged -p 7080:7080 -p 7443:7443 kisel/nginx-dummy
```

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


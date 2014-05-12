Runs nginx dummy for performance testing.

### Ports:
- http  7080
- https 7443

### To run w/o docker
Root access is required (via sudo) to perform kernel tweaking, extending `ulimit -n`

    sudo apt-get install -y nginx
    git clone https://github.com/kisel/nginx-dummy.git
    cd nginx-dummy
    sh run.sh

### Dockerfile for dummy nginx server
Run inside Docker. This will have lower performance

    docker build -t kisel/nginx-dummy github.com/kisel/nginx-dummy
    docker run -p 7080:7080 -p 7443:7443 kisel/nginx-dummy


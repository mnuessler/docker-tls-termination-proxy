# TLS Termination Proxy

A docker image that provides a simple TLS/SSL termination proxy to be
used in front of another running docker container with a web server.

It is using [pound][1] for TLS/SSL termination. Pound is a small
reverse proxy, load balancer and HTTPS front-end for Web server(s). Of
course there various other good pieces of software out there, that can
do the same job just as well, for instance [HAProxy][2] and
[nginx][3].

## Usage

### Run the container

When started, this container will listen on port 443 for incoming
HTTPS requests. Requests will then be forwarded via HTTP to another
container, the actual web server. Address/hostname and port of the
upstream server have to configured using environment variables.

The easiest way is to simply link the two containers together and
configure the name of the web server container as upstream server
address. A file containing the SSL certificate(s) and the private key
must be mounted as a volume. It is expected to be found at the
location /cert.pem by the container.

```
docker run \
    -e HTTPS_UPSTREAM_SERVER_ADDRESS=othercontainer \
    -e HTTPS_UPSTREAM_SERVER_PORT=80 \
    -v /path/to/cert.pem:/cert.pem:ro \
    --link othercontainer:othercontainer \
    mnuessler/docker-tls-termination-proxy
```

### Build the image

```
docker build -t mnuessler/docker-tls-termination-proxy .
```

Or just pull it from [Docker Hub][4]:

```
docker pull mnuessler/docker-tls-termination-proxy
```

[1]: http://www.apsis.ch/pound
[2]: http://www.haproxy.org/
[3]: http://nginx.org/
[4]: https://registry.hub.docker.com/u/mnuessler/docker-tls-termination-proxy/

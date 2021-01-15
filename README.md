# Docker Proxy client

A handy ubuntu based client container to connect/debug already deployed containers in a host.

To reduce the risk of unintended exposure of ports to
outside world, the internal docker services, that are consumed only by local containers will never expose any ports outside/even to the host network.

When debugging any issue in a specific internal container, such as sending a request/check a value of specific api, user may wanted to connect to the internal docker service. However its impossible to do from host network as no ports are exposed outside.

The solution for this requirement is to use a proxy client container that can connect to internal docker network. Using this client , a user can do all sort of debugging on every other container in the given network.

## How to use

The docker container is also provided with handy script to run them as below.

```
$ ./run-proxy.sh 
Wrapper script to run a client system to reach other containers

Syntax: run-proxy.sh [-b|r|n|h]
options:
-h|--help     Print this Help.
-b|--build    Build the application.
-r|--run      Run the application
-n|--network  docker network to connect(only single existing)

```

1. Build the container, feel free to add relevant tools and components as needed.

```
$ ./run-proxy.sh -b
```

2. Run the container connecting to existing docker network as

```
./run-proxy.sh -r -n q-a-web-app_qaNetwork
```

Now we will get a interactive ubuntu container that connected to the docker network. The directory './volume' is mounted inside the container as '/volume'.
This volume can be used for file transfer between host and container.
# Docker Proxy client

A handy ubuntu based client container to connect/debug already deployed containers in a host.

To reduce the risk of unintended exposure of ports to
outside world, the internal docker services, that are consumed only by local containers will never expose any ports outside/even to the host network.

When debugging any issue in a specific internal container, such as sending a request/check a value of specific api, user may wanted to connect to the internal docker service. However its impossible to do from host network as no ports are exposed outside.

The solution for this requirement is to use a proxy client container that can connect to internal docker network. Using this client , a user can do all sort of debugging on every other container in the given network.

We are using the proxy container as a report-generator.

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

2. Clone the Q-A-Web-App repo to the docker volume(https://github.com/sugchand/Q-A-Web-App.git)

```
$ cd volumes; git clone https://github.com/sugchand/Q-A-Web-App.git
```

3. After cloning the repo, copy the Q-A-Web-Appp configuration file. This step is very important
to make sure report generator will have same configuration as original Q-A-Web-App system.
User may have to to copy '.env' and './config' directory to newely cloned repo.

4. Run the container connecting to existing docker network as

```
./run-proxy.sh -r -n q-a-web-app_qaNetwork
```

Please make sure the Q-A-Web-App services are up before running the command , so that the script
can reach the services to collect the data.

The script will produce the csv report and send to the configured users.

The script can be added to a cron job to run it specific interval.
For eg: copy the 'cron-report-gen' to cron.daily or cron.hourly to run them in specific interval.


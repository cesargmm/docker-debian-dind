# docker-debian-runner

This Dockerfile creates a Docker image based in [Debian:bookworm](https://hub.docker.com/_/debian). It contains [Docker in Docker](https://github.com/docker-library/docker/blob/master/27/dind/Dockerfile) and deploys a [GitHub self-hosted runner](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners).

### Prerequisites

In order to run this container you'll need the following applications installed:

* `Docker 27.2.0` or superior

### Usage

#### Container Parameters

In order to start `DinD` you will need to enable the following parameters:

* --privileged true
* --tty true

```shell
docker run docker-debian-runner:1.0 --privileged true --tty true
```

You can also start the container via [docker-compose](https://docs.docker.com/compose/):

```yaml
services:

  runner_debian:
    image: docker-debian-runner:1.0
    privileged: true
    tty: true
    container_name: runner_debian
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      - TAGS=dind,debian
```

#### Environment Variables

* `USERNAME` - Repository owner username
* `REPO` - Repository name
* `GH_TOKEN` - GitHub Personal Access Token value

You can either define these variables from your repository `Secrets and Variables`, or create an `.env` file and add it to your docker-compose.
We strongly recommend the former option.

#### Useful File Locations

* `/usr/local/bin` - Additional configuration and .sh files.
  
* `/etc/supervisor` - Supervisor services configuration.

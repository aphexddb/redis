## Redis Dockerfile for Mesos/Marathon


This repository contains **Dockerfile** of [Redis](http://redis.io/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/dockerfile/redis/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

_Forked from [https://github.com/dockerfile/redis](https://github.com/dockerfile/redis)_


## Mesos

By default Mesos will apply `$PORT`, `$PORT0` and `$PORTS` environment variables. This docker file will try and use those (in that order) to launch redis.

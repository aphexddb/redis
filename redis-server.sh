#!/bin/bash

# Mesos friendly port detection

if [[ -z "$PORT0" ]]; then
  echo "Expected a primary Redis port to be set, exiting"
  exit 1
fi

if [[ -z "$PORT1" ]]; then
  echo "Expected a second port for clustering to be set, exiting"
  exit 1
fi

exec redis-server /etc/redis/redis.conf --port $1

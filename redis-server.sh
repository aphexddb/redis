#!/bin/bash

function redis_server()
{
  redis-server /etc/redis/redis.conf --port $1
}

# Mesos friendly port detection
# Try and use all available PORT environment values

if [[ -z "$PORT" ]]; then
  echo "Mesos environment variable for PORT not set, trying PORT0"
  if [[ -z "$PORT0" ]]; then
    echo "Mesos environment variable for PORT0 not set, trying PORTS"
    if [[ -z "$PORTS" ]]; then
      echo "Mesos environment variable for PORTS not set, defaulting to 6379"
      exit 1
    else
      redis_server $PORTS
    fi
  else
    redis_server $PORT0
  fi
else
  redis_server $PORT
fi

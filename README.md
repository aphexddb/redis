## Clustered Redis Dockerfile for Mesos/Marathon

**TODO - clustering won't work currently as I [can't figure out](https://twitter.com/aphexddb/status/515528068660596736) how to force Redis to use a specific cluster port**

## Launching Redis

Redis in clustered mode expects two ports to be open, the main port and that port + 10000. This JSON will have Marathon create a container:

    {
      "container": {
        "type": "DOCKER",
        "docker": {
          "image": "aphexddb/redis:latest"
        }
      },
      "id": "redis",
      "instances": "1",
      "cpus": "0.5",
      "mem": "512",
      "ports": [6379,16379]
    }

    curl -X POST -H "Content-Type: application/json" http://marathon-master:8080/v2/apps -d@redis.json

When launching the container Marathon will apply `$PORT0` and `$PORT1` environment variables to your the container with the random ports it chose. The startup script uses those values to launch Redis.

### Use with haproxy

If you use the super cool [haproxy-marathon-bridge](https://github.com/mesosphere/marathon/blob/master/bin/haproxy-marathon-bridge) haproxy will automagically know about all the Redis nodes. Ex:

    listen redis
      bind 0.0.0.0:6379
      mode tcp
      option tcplog
      balance leastconn
      server redis-1 server.host.com:31864 check

    listen redis
      bind 0.0.0.0:16379
      mode tcp
      option tcplog
      balance leastconn
      server redis-1 server.host.com:31865 check

## Redis config

The following are the config changes made from the default:

    cluster-enabled yes
    cluster-config-file nodes.conf
    cluster-node-timeout 5000
    appendonly yes
    dir /data

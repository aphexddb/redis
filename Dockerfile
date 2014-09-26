#
# Redis Dockerfile
#
# https://github.com/dockerfile/redis
#

# Pull base image.
FROM dockerfile/ubuntu

# Install system dependencies
RUN apt-get install -y gcc make g++ build-essential libc6-dev git

# checkout the 3.0 (Cluster support) branch from official repo
RUN (cd / && git clone -b 3.0 https://github.com/antirez/redis.git)

# Build redis from source and install
RUN (cd /redis && make && make install)

# Add config
RUN mkdir -p /data
RUN mkdir -p /etc/redis
ADD redis.conf /etc/redis/redis.conf

# Define mountable directories.
VOLUME ["/data"]

# Redis clsuter MUST have it's port plus port+10,000 exposed for clustering
# ex: EXPOSE [3679,13679]

# Define working directory.
WORKDIR /data

# Define default command.
ADD redis-server.sh /
CMD ["/redis-server.sh"]

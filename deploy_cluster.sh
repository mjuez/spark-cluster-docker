#!/bin/bash

HOST_DATA_DIR=$1
MASTER_CPUS=$2

docker build ./base -t spark-base:2.4.3
docker build ./master -t spark-master:2.4.3
docker build ./worker -t spark-worker:2.4.3

docker run -dP --mount type=bind,source="$HOST_DATA_DIR",target=/mnt/data --name spark-master -h spark-master --cpus $MASTER_CPUS spark-master:2.4.3

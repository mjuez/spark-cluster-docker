#!/bin/bash

# arguments
HOST_DATA_DIR=$1
MASTER_CPUS=$2
NUM_WORKERS=$3
WORKER_CPUS=$4
WORKER_MEMORY=$3

# building images
docker build ./base -t spark-base:2.4.3
docker build ./master -t spark-master:2.4.3
docker build ./worker -t spark-worker:2.4.3

# master node
docker rm -f spark-master &> /dev/null
docker run -dP --mount type=bind,source="$HOST_DATA_DIR",target=/mnt/data \
  --name spark-master \
  -h spark-master \
  --cpus $MASTER_CPUS \
  spark-master:2.4.3

i=1
while [ $i -le $NUM_WORKERS ]
do
	docker rm -f spark-worker-$i &> /dev/null

  docker run -dP --mount type=bind,source="$HOST_DATA_DIR",target=/mnt/data \
    --name spark-worker-$i -h spark-worker-$i --cpus $WORKER_CPUS \
    -m $WORKER_MEMORY \
    --link spark-master:spark-master \
    spark-worker:2.4.3

	i=$(( $i + 1 ))
done 
#!/bin/bash
#
# Author: Mario Juez-Gil <mariojg@ubu.es>
# Spark master node init script.
#
# source: https://github.com/big-data-europe/docker-spark/blob/master/worker/worker.sh

set -eu pipefail

export SPARK_HOME=/spark

# configuring and loading spark environment.
#. "/spark/sbin/spark-config.sh"
#. "/spark/bin/load-spark-env.sh"

mkdir -p $SPARK_WORKER_LOGS

ln -sf /dev/stdout $SPARK_WORKER_LOGS/spark-master.out

/spark/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker \
--webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_WORKER_LOGS/spark-worker.out

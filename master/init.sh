#!/bin/bash
#
# Author: Mario Juez-Gil <mariojg@ubu.es>
# Spark master node init script.
#
# source: https://github.com/big-data-europe/docker-spark/blob/master/master/master.sh

set -eu pipefail

export SPARK_MASTER_HOST=$(hostname)
export SPARK_HOME=/spark

# configuring and loading spark environment.
#. $SPARK_HOME/sbin/start-master.sh

mkdir -p $SPARK_MASTER_LOGS

ln -sf /dev/stdout $SPARK_MASTER_LOGS/spark-master.out

/spark/sbin/../bin/spark-class org.apache.spark.deploy.master.Master \
--ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >> $SPARK_MASTER_LOGS/spark-master.out

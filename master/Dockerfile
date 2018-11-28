# Author: Mario Juez-Gil <mariojg@ubu.es>
# Spark master node Dockerfile
#
# source: https://github.com/HariSekhon/Dockerfiles/blob/master/spark/Dockerfile

FROM alpine:latest
MAINTAINER Mario Juez-Gil <mariojg@ubu.es>

# https://archive.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
ARG SPARK_VERSION=2.4.0
ARG HADOOP_VERSION=2.7
ARG TAR=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# environment variables
ENV PATH $PATH:/spark/bin
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_REST_PORT 6066
ENV SPARK_MASTER_LOGS /spark/logs

LABEL Description="Apache Spark" \
      "Spark Version"="$SPARK_VERSION"

WORKDIR /

RUN set -euxo pipefail && \
    apk add --no-cache bash openjdk8-jre-base

RUN set -euxo pipefail && \
    apk add --no-cache wget tar && \
    wget -t 100 --retry-connrefused -O "${TAR}" "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${TAR}" && \
    tar zxf "${TAR}" && \
    rm -fv "${TAR}" && \
    ln -s "spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION" spark && \
    apk del wget tar

COPY init.sh /

RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd && \
cp -v /spark/conf/spark-env.sh.template /spark/conf/spark-env.sh

EXPOSE 7077 8080 6066

CMD ["/bin/bash","/init.sh"]

#!/bin/bash

docker build ./base -t admirable/spark-base:2.4.3
docker build ./master -t admirable/spark-master:2.4.3
docker build ./worker -t admirable/spark-worker:2.4.3
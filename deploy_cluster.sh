#!/bin/bash

docker build ./base -t spark-base:2.4.3
docker build ./master -t spark-master:2.4.3
docker build ./worker -t spark-worker:2.4.3
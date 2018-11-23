# Spark cluster test environment

Docker setup for a local spark cluster environment deployment.

## Guide and useful tips

As this repository has been created by a novel user of both, docker and spark, this section aims to be a logbook of everything discovered and learned.

### Spark master and worker

In spark there are two types of nodes, master and worker. Since the spark distribution is the same for both, docker image for master and worker will be slightly different.

The master node needs to expose up to three ports (web ui, spark master, and REST api), since the worker node only need to expose one (web ui).

### Building docker images

The dockerfiles inside `/master` and `/worker` are for building docker images with a running instance of spark framework. For start using them as docker containers, the first thing we need to do is to build the images through the command `docker build`

#### Spark Master

For building the spark master node image, we are specifying the folder containing the master node image Dockerfile. Then, with the -t parameter we are specifying the image name (spark-master) and the tag (2.4.0). I used the same tag as spark version, but docker image tag and spark version do not need to match.

```bash
(sudo) docker build ./master -t spark-master:2.4.0
```

#### Spark Worker

Analogously, spark worker image can be built with the following command:

```bash
(sudo) docker build ./worker -t spark-worker:2.4.0
```

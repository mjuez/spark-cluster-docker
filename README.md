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

```shell
[sudo] docker build ./master -t spark-master:2.4.0
```

#### Spark Worker

Analogously, spark worker image can be built with the following command:

``` shell
[sudo] docker build ./worker -t spark-worker:2.4.0
```

### Listing docker images

For obtaining the list of images we have to run the following:

```shell
[sudo] docker images
```

The output will be somethink like:

```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
spark-worker        2.4.0               cd095ff645ba        29 minutes ago      338MB
spark-master        2.4.0               8c293e566e90        16 hours ago        338MB
alpine              latest              196d12cf6ab1        2 months ago        4.41MB
```

### Removing docker images

For removing an image we will use `docker rmi` followed the `IMAGE ID`:

For example, if we want to remove the spark-worker image of the previous example, we need to run:

```shell
[sudo] docker rmi cd095ff645ba
```

If we want to remove all docker images:

```shell
[sudo] docker rmi $([sudo] docker images -q)
```

(The `-q` parameter of `docker images` command returns a list of IDs)

**NOTE**: If a docker container is using a image, that image could not be removed until the docker container is removed.

### Running docker containers

When a image is build, the next step is to run it. The command `docker run` will be used.

#### Spark Master

The command we are using for running the spark master docker container is the following:

``` shell
[sudo] docker run -dtP --name spark-master -h spark-master --cpus 1 spark-master:2.4.0
```

The explanation of the arguments used is:

* `-dtP`: `d` means detached, the container will run in background. `t` is for allocating a TTY. `P` is for exposing publicly all ports.
* `--name`: TODO

#### Spark Worker

Analogously, a spark worker can be runned like this:

``` shell                                                                                                                                              
[sudo] docker run -dt --name spark-worker-01 -h spark-worker-1 --cpus 1 --link spark-master:spark-master spark-worker:2.4.0
```

The main difference is that this time we are not exposing the ports because, although it can be done, is not needed to access the workers UI (`-P` argument). Also, a new parameter `--link` was set, this is to link the worker to the master network.

### Listing docker containers

If we want to list all running docker containers, we have to use:

``` shell
[sudo] docker ps
```

For the list of running and stopped docker containers the parameter `-a` is needed:

``` shell
[sudo] docker ps -a
```

### Stopping docker containers

For stopping (killing) a docker container, the command `docker kill` will be used.

For example, if we want to kill the docker container named `spark-master`, we have to execute:

``` shell
[sudo] docker kill spark-master
```

Instead of the container name, it can be used the container id.



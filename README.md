# mldonkey-docker

> based on @carlonluca  [docker-mldonkey](https://github.com/carlonluca/docker-mldonkey/blob/master/entrypoint.sh)

This repository hosts the Dockerfile for building the mldonkey docker image.


## Available versions

Versions tagged just with a software versions are builds of mldonkey from official mldonkey releases. The mldonkey code is currently taken from https://github.com/ygrek/mldonkey.

## Owner and permissions

The mldonkey daemon running inside the container must be able to read and modify
data inside the volume. You'll also probably want to properly share data with a
user available in your host. The mldonkey daemon always use the **mldonkey** user and
group, but you can setup the environment so that the container assignes the desired
uid and gid to the mldonkey user and group inside the container. This will allow you
to see those files with the proper permissions in your host.

### Example

Let's assume your user is named _luca_ and has the uid 1001, and that you want your
data to be assigned group _luca_, which has the same gid 1001. In this case you
can ask the container to assign the value 1001 to uid and gid _mldonkey_ in the container
by using the env variables:

```
MLDONKEY_UID=1001
MLDONKEY_GID=1001
```

This will establish a mapping between user _luca_ in the host to user _mldonkey_ in the
container, and group _luca_ in the host with group _mldonkey_ in the container.

## Ports

|Network|Type|MLDonkey default|Configuration file|
|---|---|---|---|
|http_port|HTTP|4080|downloads.ini|
|telnet_port|TCP|4000|downloads.ini|
|eDonkey2000|TCP|20562|donkey.ini|
|eDonkey2000|UDP|20566|donkey.ini|
|Kad|TCP|16965|donkey.ini, Kademlia section|
|Kad1|UDP|16965|donkey.ini, Kademlia section|
|Overnet|TCP|6209|donkey.ini, Overnet section|
|Overnet|UDP|6209|donkey.ini, Overnet section|

## Running the Container

To run mldonkey using this image:

```
$ docker compose up -d
```
# docker-go-ora

Docker Image with Oracle Instant Client installed and Golang' mattn/go-oci8 Oracle driver.

Find it here: https://hub.docker.com/r/schmooser/go-oci8

## Preparation

Download Oracle Instant Client for Linux: https://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html

- Basic Package
- SQL\*Plus Package
- SDK Package

Copy Instant Client to `distrib/` folder:

```bash
rm distrib/*.zip
cp ~/Downloads/instantclient-*.zip distrib/

# there should be the following files
$ ls -al distrib
total 75464
drwxr-xr-x  5 pavel  staff       160 May 30 22:32 .
drwxr-xr-x  7 pavel  staff       224 May 30 22:01 ..
-rw-r--r--@ 1 pavel  staff  36789541 May 30 22:32 instantclient-basic-linux.x64-19.3.0.0.0dbru.zip
-rw-r--r--@ 1 pavel  staff    932294 May 30 22:32 instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip
-rw-r--r--@ 1 pavel  staff    910409 May 30 22:32 instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip
```

Update version in `Dockerfile` and `oci8.pc`.

## Build

```bash

docker build -t schmooser/go-oci8:1.20 .

```


## Login and push to Docker Hub

```bash
docker login --username=schmooser

docker push schmooser/go-oci8:1.20
```


## Usage

Use the image in `FROM` clause in Dockerfile, then add dependency on go-oci8:

```Dockerfile
FROM schmooser/go-oci8:1.20

# ...


RUN go get github.com/mattn/go-oci8

```

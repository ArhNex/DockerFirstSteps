#! /bin/bash

docker kill ngs
docker rmi ngserver:jothosge
docker build -t ngserver:jothosge .
# docker run --rm -d -p 80:81 --name ngs ngserver:jothosge 
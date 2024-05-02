#! /bin/bash

docker pull nginx
docker run --rm -d --name ngjothosge -p 81:81 nginx
docker cp ./nginx/nginx.conf ngjothosge:/etc/nginx/nginx.conf
docker cp ./server.c ngjothosge:/etc/nginx/server.c
docker exec ngjothosge apt-get update
docker exec ngjothosge apt-get upgrade
docker exec ngjothosge apt-get install -y gcc spawn-fcgi libfcgi-dev
docker exec ngjothosge gcc -o /etc/nginx/server /etc/nginx/server.c -l fcgi
docker exec ngjothosge spawn-fcgi -p 8080 /etc/nginx/server
docker exec ngjothosge nginx -s reload
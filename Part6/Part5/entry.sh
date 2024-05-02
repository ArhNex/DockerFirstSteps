#! /bin/bash

spawn-fcgi -p 8080 /etc/nginx/server
# nginx -s reload
nginx -g 'daemon off;'
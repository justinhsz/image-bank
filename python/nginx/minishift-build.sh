#!/bin/bash

echo "switch to minishift's docker environment..."
eval $(minishift docker-env)

echo "login to minishift's docker registry..."
docker login -u developer -p developer $(minishift openshift registry)


echo "grant access permission for specified files"
chmod +x root/opt/app-root/etc/*

echo "start to build the image..."
# docker image prune -a -f
make build

docker image ls
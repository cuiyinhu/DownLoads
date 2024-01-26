#!/bin/bash

mkdir -p ~/docker/code-server/.local
mkdir -p ~/docker/code-server/.config
mkdir -p ~/docker/code-server/project
mkdir -p ~/docker/code-server/certs
mkdir -p ~/docker/code-server/.ssh
chmod 700 ~/docker/code-server/.ssh

docker run -it --name code-server -p 8080:8080 \
  -v ~/docker/code-server/.local:/home/coder/.local \
  -v ~/docker/code-server/.config:/home/coder/.config \
  -v ~/docker/code-server/project/:/home/coder/project \
  -v ~/docker/code-server/certs/:/home/coder/certs \
  -u "$(id -u):$(id -g)" \
  -e "DOCKER_USER=$USER" \
  codercom/code-server:latest

  docker cp -a .ssh code-server:/home/coder/

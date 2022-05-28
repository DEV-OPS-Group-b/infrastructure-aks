#!/bin/bash
 mkdir /deployment
 cd /deployment
 curl -L "https://github.com/DEV-OPS-Group-b/deployment/releases/latest/download/docker-compose.yml" -o ./docker-compose.yml
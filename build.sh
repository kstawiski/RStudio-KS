#!/bin/bash

docker builder prune
docker image prune -a

docker build --rm --force-rm -f ../Dockerfile -t rstudio-ks
docker tag rstudio-ks:latest kstawiski/rstudio-ks:latest
docker push kstawiski/rstudio-ks
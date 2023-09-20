#!/bin/bash

docker build . --build-arg USER_ID=$(id -u) -t 611
docker run -v $(pwd):/home/rstudio/work -p 8991:8787 -it 611


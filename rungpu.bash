#!/bin/bash

docker run \
    --rm \
    --name dental-xray-gan-seg \
    --gpus all \
    --net host \
    -p 8888:8888 \
    --runtime nvidia \
    -v /home/chris/Documents/Uni/CV/Project/Dental_X-Ray_Generation:/workspace \
    dental-xray-gan-seg:latest


#!/bin/bash

# Ensure to map the current directory or the specific path correctly
# Ensure the volume (-v) maps to /workspace, which matches the Dockerfile WORKDIR
docker run \
    --rm \
    -it \
    --name dental-xray-gan-seg \
    --gpus all \
    --net host \
    --ipc=host \
    --user $(id -u):$(id -g) \
    -v /home/chris/Documents/Uni/CV/ProjectV2/Dental_X-Ray_Generation:/workspace \
    dental-xray-gan-seg:latest


#!/bin/bash
# See https://skandhurkat.com/post/x-forwarding-on-docker/

XAUTH=$HOME/.Xauthority
touch $XAUTH

docker run \
       --rm \
       --interactive \
       --tty \
       --gpus all \
       --network=host\
       --env DISPLAY=$DISPLAY \
       --volume $XAUTH:/home/jovyan/.Xauthority \
       rholbrook/datascience:full \
       start.sh "$@"

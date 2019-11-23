#!/bin/bash
# launch the containter with X support
# See https://skandhurkat.com/post/x-forwarding-on-docker/

# separate keyword and positional arguments
KEYWORD=()
POSITIONAL=()
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --*|-*)
            KEYWORD+=("${1} ${2}")
            shift 2
            ;;
        *)
            POSITIONAL+=("${1}")
            shift
            ;;
    esac
done

docker run \
       --name datascience \
       --rm \
       --interactive \
       --tty \
       --gpus all \
       --network=host\
       --env DISPLAY=$DISPLAY \
       --volume $XAUTHORITY:/home/jovyan/.Xauthority \
       $KEYWORD \
       rholbrook/datascience:full \
       start.sh \
       ${POSITIONAL}

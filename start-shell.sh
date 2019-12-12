#!/bin/bash
# launch the containter with X support
# See https://skandhurkat.com/post/x-forwarding-on-docker/

# separate keyword and positional arguments
DOTS=()
KEYWORD=()
POSITIONAL=()
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --dot|-d)
            DOTS+=("--volume ${2}:/home/jovyan/${2}")
            shift 2
            ;;
        --project|-p)
            PROJECT="${2}"
            shift 2
            ;;
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

XAUTH="/run/user/Xauthority"

echo "Running"
echo "Project: ${PROJECT}"

docker run \
       --rm \
       --interactive \
       --tty \
       --gpus all \
       --network=host\
       --env DISPLAY=$DISPLAY \
       --env XAUTHORITY=$XAUTH \
       --volume $XAUTHORITY:$XAUTH \
       --volume $PROJECT:"/home/jovyan/project" \
       $DOTS \
       $KEYWORD \
       rholbrook/r-gpu-notebook \
       $POSITIONAL \
       start.sh

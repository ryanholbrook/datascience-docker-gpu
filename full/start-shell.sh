#!/bin/bash
# launch the containter with X support
# See https://skandhurkat.com/post/x-forwarding-on-docker/

# separate keyword and positional arguments
USER=$(id -u)
UNAME=$(id -un)
KEYWORD=()
POSITIONAL=()
while [[ "$#" -gt 0 ]]; do
    case $1 in
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

echo "User Name: ${UNAME}"
echo "UID: ${USER}"
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
       --env NB_USER=$UNAME \
       --workdir "/home/$NB_USER" \
       --volume $PROJECT:"/home/project" \
       --user root \
       $KEYWORD \
       rholbrook/datascience:full \
       $POSITIONAL \
       start.sh


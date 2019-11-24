#!/bin/bash
# launch the containter with X support
# See https://skandhurkat.com/post/x-forwarding-on-docker/

# separate keyword and positional arguments
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

docker run \
       --name datascience \
       --rm \
       --interactive \
       --tty \
       --gpus all \
       --network=host\
       --env DISPLAY=$DISPLAY \
       --volume $XAUTHORITY:/home/jovyan/.Xauthority \
       --volume $PROJECT:/home/jovyan/work/ \
       -e CHOWN_HOME=yes \
       -e CHOWN_HOME_OPTS='-R' \
       # Changing to root here is necessary to set file permissions
       # for the working directory. The startup script will change
       # the user back to '1000(jovyan)' or whatever is declared
       # via option. See here for more about the options available:
       # https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html
       -u root \
       $KEYWORD \
       rholbrook/datascience:full \
       start.sh \
       $POSITIONAL

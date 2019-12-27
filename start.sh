#!/bin/bash
# launch the containter with X support
# See https://skandhurkat.com/post/x-forwarding-on-docker/

# separate keyword and positional arguments
DOTS=()
KEYWORD=()
POSITIONAL=()
COMMAND="start.sh"
while [[ "$#" -gt 0 ]]; do
    case $1 in
        notebook)
            COMMAND="start-notebook.sh"
            shift
            ;;
        --dot)
            DOTS+=("--volume ${2}:/home/jovyan/${2}")
            shift 2
            ;;
        --work)
            WORK="${2}"
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
echo "Work Directory: ${WORK}"
echo "Config Files: ${DOTS[@]}"
echo "Keyword Args: ${KEYWORD[@]}"
echo "Positional Args: ${POSITIONAL[@]}"

docker run \
       --rm \
       --interactive \
       --tty \
       --gpus all \
       --network=host\
       --env DISPLAY=$DISPLAY \
       --env XAUTHORITY=$XAUTH \
       --volume $XAUTHORITY:$XAUTH \
       --volume $WORK:"/home/jovyan/work" \
       --workdir "/home/jovyan/work" \
       ${DOTS[@]} \
       ${KEYWORD[@]} \
       rholbrook/datascience-gpu-notebook \
       ${POSITIONAL[@]} \
       ${COMMAND}

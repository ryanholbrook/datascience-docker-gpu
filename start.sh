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
            filename=$(basename "${2}")
            DOTS+=("--volume ${2}:/home/jovyan/${filename}")
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
       --env DISPLAY=$DISPLAY \
       --ipc=host \
       --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
       --volume $WORK:"/home/jovyan/work" \
       --workdir "/home/jovyan/work" \
       ${DOTS[@]} \
       ${KEYWORD[@]} \
       rholbrook/datascience-gpu-notebook \
       ${POSITIONAL[@]} \
       ${COMMAND}

#!/bin/bash
xhost +si:localuser:$(whoami) >/dev/null
docker run \
    -e LIBGL_DEBUG=verbose \
    --privileged \
    --rm \
    -ti \
    -e DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /opt/docker-data/wine:/home/docker/wine/ \
    -v $(pwd)/examples:/home/docker/templates:ro \
    -v /dev:/dev \
    -v /opt/pr:/opt/pr \
    -u docker \
    yantis/wine /bin/bash -c "sudo initialize-graphics >/dev/null 2>/dev/null; vglrun /home/docker/templates/h3.template;"

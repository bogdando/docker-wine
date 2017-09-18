#!/bin/bash
# Build the image 1st with:
# docker build -f Dockerfile_alt -t bogando/nvidia-virtualgl:2.5.2 .
xhost +si:localuser:$(whoami) >/dev/null
xhost +local:root
docker run \
    --rm \
    -ti \
    -u root \
    -e DISPLAY \
    -e WINEPREFIX=/home/h3/wine \
    -v /usr/lib/x86_64-linux-gnu/libXv.so.1:/usr/lib/x86_64-linux-gnu/libXv.so.1:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /opt/docker-data/wine/.cache:/home/h3/.cache \
    -v /opt/docker-data/wine:/home/h3/wine \
    -v $(pwd)/examples:/templates:ro \
    -v /opt/pr:/opt/pr \
    bogdando/nvidia-virtualgl:2.5.2 /bin/bash -c \
    "useradd -u 1000 h3 -G root -s /bin/bash -d /home/h3; su h3 -s /bin/bash -c 'vglrun /templates/h3.template'"
#    "useradd -u 1000 h3 -G root -s /bin/bash -d /home/h3; su h3 -c 'vglrun glxgears'"
xhost -local:root
sudo chown bogdando:bogdando ~/.Xauthority

#!/bin/bash
# Firstly, install on a host: nvidia-docker and docker-ce, and nvidia drivers.
# Build the image 1st with:
# docker build -f Dockerfile_alt -t bogdando/nvidia-virtualgl:2.5.2 .
# These are specific to the host, like nvidia-304 driver installed
nver=340.104
DOCKER_VISUAL_NVIDIA="-v /usr/lib/x86_64-linux-gnu/libXau.so.6.0.0:/usr/lib/x86_64-linux-gnu/libXau.so.6.0.0:ro -v /usr/lib/x86_64-linux-gnu/libXdmcp.so.6:/usr/lib/x86_64-linux-gnu/libXdmcp.so.6:ro -v /usr/lib/x86_64-linux-gnu/libXext.so.6:/usr/lib/x86_64-linux-gnu/libXext.so.6:ro -v /usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0:/usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0:ro -v /usr/lib/x86_64-linux-gnu/libX11.so.6.3.0:/usr/lib/x86_64-linux-gnu/libX11.so.6.3.0:ro -v /usr/lib/x86_64-linux-gnu/libxcb.so.1:/usr/lib/x86_64-linux-gnu/libxcb.so.1:ro -v /usr/lib/nvidia-${nver%.*}:/usr/lib/nvidia-${nver%.*}:ro -v /usr/lib32/nvidia-${nver%.*}:/usr/lib32/nvidia-${nver%.*}:ro"

xhost +si:localuser:$(whoami) >/dev/null
xhost +local:root
docker run \
    --runtime=nvidia \
    -e LIBGL_DEBUG="verbose glxgears" \
    --privileged \
    --rm \
    -ti \
    -u root \
    -e DISPLAY \
    -e WINEPREFIX=/home/h3/wine \
    -e LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib/nvidia-${nver%.*}:/usr/lib32/nvidia-${nver%.*}" \
    -v /usr/lib/x86_64-linux-gnu/libXv.so.1:/usr/lib/x86_64-linux-gnu/libXv.so.1:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /opt/docker-data/wine/.cache:/home/h3/.cache \
    -v /opt/docker-data/wine:/home/h3/wine \
    -v /lib/modules:/lib/modules:ro \
    ${DOCKER_VISUAL_NVIDIA} \
    -v $(pwd)/examples:/templates:ro \
    -v /opt/pr:/opt/pr \
    bogdando/nvidia-virtualgl:2.5.2 /bin/bash -c \
    "useradd -u 1000 h3 -G root -s /bin/bash -d /home/h3; su h3 -s /bin/bash -c 'vglrun /templates/h3.template'"
#    "useradd -u 1000 h3 -G root -s /bin/bash -d /home/h3; su h3 -c 'vglrun glxgears'"
xhost -local:root
sudo chown bogdando:bogdando ~/.Xauthority

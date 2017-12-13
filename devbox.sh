#!/bin/bash                                                                                                                                                                       
# These are specific to the host, like nvidia-304 driver installed
DOCKER_VISUAL_NVIDIA="-v /usr/lib/x86_64-linux-gnu/libXau.so.6.0.0:/external_libs/libXau.so.6.0.0 -v /usr/lib/x86_64-linux-gnu/libXdmcp.so.6:/external_libs/libXdmcp.so.6 -v /usr/lib/x86_64-linux-gnu/libXext.so.6:/external_libs/libXext.so.6 -v /usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0:/external_libs/libXdmcp.so.6.0.0 -v /usr/lib/x86_64-linux-gnu/libX11.so.6.3.0:/external_libs/libX11.so.6.3.0 -v /usr/lib/x86_64-linux-gnu/libxcb.so.1:/external_libs/libxcb.so.1 -v /usr/lib/nvidia-304/libGL.so.304.137:/external_libs/libGL.so.304.137 -v /usr/lib/nvidia-304/libnvidia-glcore.so.304.137:/external_libs/libnvidia-glcore.so.304.137 -v /usr/lib/nvidia-304/libGL.so.1:/external_libs/libGL.so.1 -v /usr/lib/x86_64-linux-gnu/libXext.so.6.4.0:/external_libs/libXext.so.6.4.0 -v /usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0:/external_libs/libxcb.so.1.1.0 -v /usr/lib/x86_64-linux-gnu/libX11.so.6:/external_libs/libX11.so.6 -v /usr/lib/x86_64-linux-gnu/libXau.so.6:/external_libs/libXau.so.6 -v /usr/lib/nvidia-304/tls/libnvidia-tls.so.304.137:/external_libs/libnvidia-tls.so.304.137 -v /usr/lib/x86_64-linux-gnu/libXv.so.1:/external_libs/libXv.so.1 --env=LD_LIBRARY_PATH=/external_libs"
docker run \
    -u $(id -u $USER):$(id -g $USER) \
    --group-add video \
    --group-add audio \
    --group-add sudo \
    --group-add $(getent group libvirtd | awk -F':' '{print $3}') \
    --group-add $(getent group docker | awk -F':' '{print $3}') \
    -itd \
    --privileged \
    --cap-add=ALL \
    --net=host --uts=host --pid=host --ipc=host \
    -e DISPLAY=:0 \
    -e VGL_DISPLAY=:0 \
    ${DOCKER_VISUAL_NVIDIA} \
    -e XAUTHORITY=/tmp/.Xauthority \
    -e LC_ALL=en_US.UTF-8 \
    -e LANG=en_US.UTF-8 \
    -e WINEPREFIX=/home/devbox/wine \
    -v $(pwd)/resolv.conf:/etc/resolv.conf:ro \
    -v /etc/NetworkManager/dnsmasq.d:/etc/NetworkManager/dnsmasq.d:ro \
    -v /etc/dbus-1:/etc/dbus-1 \
    -v /etc/default/keyboard:/etc/default/keyboard:ro \
    -v /run:/run \
    -v /usr/bin/docker:/usr/bin/docker:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -v /etc/shadow:/etc/shadow:ro \
    -v /etc/sudoers:/etc/sudoers:ro \
    -v /dev:/dev \
    -v /sys/fs/cgroup:/sys/fs/cgroup \
    -v /var/lib/libvirt:/var/lib/libvirt \
    -v /lib/modules:/lib/modules:ro \
    -v /etc/apt/:/etc/apt/ \
    -v /var/cache/apt:/var/cache/apt \
    -v $(pwd)/examples:/templates:ro \
    -v /opt/pr:/opt/pr \
    -v /opt/Projects:/opt/Projects \
    -v /opt/oooq:/opt/oooq \
    -v /opt/cache:/opt/cache \
    -v /opt/bluejeans:/opt/bluejeans \
    -v /opt/docker-data:/opt/docker-data \
    -v /opt/google:/opt/google \
    -v /opt/sublime_text_2:/opt/sublime_text_2 \
    -v /opt/vagrant:/opt/vagrant \
    -v /opt/zoom:/opt/zoom \
    -v /opt/.virtualenvs:/opt/.virtualenvs \
    -v /usr/bin/p4merge:/usr/bin/p4merge:ro \
    -v /usr/bin/p4merge.bin:/usr/bin/p4merge.bin:ro \
    -v /usr/lib/p4v:/usr/lib/p4v:ro \
    -v /usr/local/sbin/git_edit.sh:/usr/local/sbin/git_edit.sh:ro \
    -v /usr/local/bin/virtualenvwrapper.sh:/usr/local/bin/virtualenvwrapper.sh:ro \
    -v $HOME:/home/$USER \
    --name devbox \
    bogdando/devbox:v0.1 sudo vglrun /templates/devbox.template
    
#-v /opt/docker-data/wine/.cache:/home/devbox/.cache \
#-v /opt/docker-data/wine:/home/devbox/wine \

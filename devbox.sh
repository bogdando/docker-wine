#!/bin/bash
# $USER must be a member of the host's sudo,docker,libvirtd,audio,video groups
docker run \
    --runtime=nvidia \
    -u $(id -u $USER):$(id -g $USER) \
    -itd \
    --privileged \
    --cap-add=ALL \
    --net=host --uts=host --pid=host --ipc=host \
    -e DISPLAY=:0 \
    -e XAUTHORITY=/tmp/.Xauthority \
    -e LC_ALL=en_US.UTF-8 \
    -e LANG=en_US.UTF-8 \
    -e WINEPREFIX=/home/devbox/wine \
    -v $(pwd)/resolv.conf:/etc/resolv.conf:ro \
    -v $(pwd)/20-intel.conf:/usr/share/X11/xorg.conf.d/20-intel.conf:ro \
    -v $(pwd)/30-nvidia.conf:/usr/share/X11/xorg.conf.d/30-nvidia.conf:ro \
    -v $(pwd)/10-xorg.conf:/usr/share/X11/xorg.conf.d/10-xorg.conf:ro \
    -v /etc/NetworkManager/dnsmasq.d:/etc/NetworkManager/dnsmasq.d:ro \
    -v /etc/dbus-1:/etc/dbus-1 \
    -v /etc/default/keyboard:/etc/default/keyboard:ro \
    -v /run/user/1000:/run/user/1000 \
    -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
    -v /run/libvirt:/run/libvirt \
    -v /run/docker:/run/docker:ro \
    -v /run/docker.pid:/run/docker.pid:ro \
    -v /run/docker.sock:/run/docker.sock:ro \
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
    -v /var/log/devbox:/var/log \
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
    bogdando/devbox /templates/devbox.template

#-v /opt/docker-data/wine/.cache:/home/devbox/.cache \
#-v /opt/docker-data/wine:/home/devbox/wine \

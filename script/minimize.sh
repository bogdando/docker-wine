#!/bin/bash -eux

# Remove some packages to get a minimal install
echo "==> Removing linux source"
dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y purge

# Clean up the apt cache
apt-get -y autoremove --purge
apt-get -y autoclean
apt-get -y clean

# Clean up orphaned packages with deborphan
#apt-get -y install deborphan
#while [ -n "$(deborphan --guess-all --libdevel)" ]; do
#  deborphan --guess-all --libdevel | xargs apt-get -y purge
#done
#apt-get -y purge deborphan dialog

echo "==> Removing anything in /usr/src"
rm -rf /usr/src/*
echo "==> Removing caches"
find /var/cache -type f -exec rm -rf {} \;
echo "==> Removing APT files"
find /var/lib/apt -type f | xargs rm -f
sync

#!/bin/sh -x

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`

# Install unzip to unzip packages installed in containers
microdnf -y install unzip

# Install rclone
curl https://rclone.org/install.sh | bash

# Copy local config file to requried path '/root/.config/rclone/rclone.conf' to set up the remote connection
#cp ${scriptdir}/rclone.conf /root/.config/rclone/rclone.conf

# Install FUSE to allow rclone to mount the remote bucket within the container
microdnf install -y fuse 
#fuse-devel

# Make user-home folder that will be the mount for the remote minIO server
mkdir /user-home
# we need a non-root user to be able to fuse mount it here
chmod 777 /user-home

# for rclone vfs to use (as non root)
mkdir /vfs-cache
chmod 777 /vfs-cache


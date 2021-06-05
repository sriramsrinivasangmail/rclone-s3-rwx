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
mkdir /root/user-home
chmod 777 /root/user-home


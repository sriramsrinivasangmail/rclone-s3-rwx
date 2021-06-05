#!/bin/sh



scriptdir=`dirname $0`
docker_file_name=${scriptdir}/Dockerfile


docker_image_name=rclone-s3-mounter
docker_image_tag=v1

docker build -f ${docker_file_name} -t ${docker_image_name}:${docker_image_tag} .

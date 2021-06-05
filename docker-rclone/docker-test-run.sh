#!/bin/sh

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`

docker_image_name=rclone-s3-mounter
docker_image_tag=v1

container_name=test-rclone-s3-mounter
s3secretfile=${scriptdir}/../s3_secret.dat 

if [ -f ${s3secretfile} ];
then
 echo loading s3 details from ${s3secretfile};
else
 echo ERROR missing s3 details file:  ${s3secretfile};
 exit 1;
fi
 

docker rm --force ${container_name}
docker run --name ${container_name} --privileged --user=root --env-file ${s3secretfile}  -d ${docker_image_name}:${docker_image_tag}



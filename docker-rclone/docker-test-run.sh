#!/bin/sh


docker_image_name=rclone-s3-mounter
docker_image_tag=v1

container_name=test-rclone-s3-mounter

docker rm --force ${container_name}
docker run --name ${container_name} --privileged --user 20001 -p 8080:8080 -v `pwd`:/src -d ${docker_image_name}:${docker_image_tag}


#printf "to check on things:- \n docker exec -ti ${container_name} sh   \n   curl -kiv http://localhost:8080/test \n"

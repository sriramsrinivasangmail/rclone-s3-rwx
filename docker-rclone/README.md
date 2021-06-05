
Example of using rclone with FUSE to mount an S3 bucket inside a container


## To build the docker image

`./build.sh`

## Create the `s3_secret.dat` env file 

This file should have the S3 connection details

for example

```

s3_access_key_id=minio
s3_secret_access_key=minio123
s3_endpoint=http://cpd-dev-lisa-master.fyre.ibm.com:9001
s3_bucket_name=sample-1

```

Note - the bucket should already exist.


## Test out with docker 

### Spin up a container

`./docker-test-run.sh`

- this picks up the S3 details from the `s3_secret.dat` environment file

**Note**: It is important that we run processes inside the container as a non-root user. Conveniently the base docker image we have includes a "daemon" username already & we leverage that

### exec into the container

`docker exec -it test-rclone-s3-mounter  bash`

and check out the `/user-home` directory. Any content in the bucket would show up here. Its a read-write mount, so you should be able to create files or edit existing files.

## Permissions issues

While we have been able to run as a non-root user and avoid the full `--privileged` flag, we needed  `--device /dev/fuse --cap-add SYS_ADMIN` for FUSE to work. 

In kubernetes, this would translate to additional linux capabilities (and in Openshift - SCC customizations). 

However - https://github.com/wunderio/csi-rclone/blob/master/example/kubernetes/nginx-example.yaml#L40 indicates that the csi-rclone driver can help avoid having _every_ pod needing such capabilities. (We will try this out in a separate kube/openshift experiment)

## rclone options

see [./scripts/startup.sh](./scripts/startup.sh) for rclone options

specifically how the vfs cache directory is set  - the [./scripts/imagesetup.sh](./scripts/imagesetup.sh) script is run during docker build and sets it up. This is important since the usual '/sbin' location will not be writable by a non-root user.

the vfs cache settings are important as well to make sure you can do all POSIX operations. For example try appending to an existing file ( example - `date >> dummy.txt` )  and make sure that works. 


## Sync issues to be aware of

1). deleting a file in the bucket:

 a direct delete a file took a while to be replicated in the rclone mount  - perhaps a few seconds. May need to see if there are tunables for this. Otherwise - consumers need to be aware that (unlike NFS etc.) there will be slight delays in file syncs and account for that.

- it might be that the `--no-modtime` option (added for performance reasons) might be the cause here.  **  needs further experimentation **

## Troubleshooting

docker logs - `docker logs test-rclone-s3-mounter`

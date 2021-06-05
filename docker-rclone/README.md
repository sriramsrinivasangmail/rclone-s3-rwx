
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

`./docker-test-run.sh`

- this picks up the S3 details from the `s3_secret.dat` environment file


## Troubleshooting

docker logs - `docker logs test-rclone-s3-mounter`

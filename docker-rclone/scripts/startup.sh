#!/bin/sh

# Mount the remote on the container - Refer to issues.txt in rclone_notes
# RUN rclone mount --daemon --dir-cache-time 1m0s --poll-interval 0m30s minio:/bucket /root/user-home --log-level DEBUG


RCLONE_CONFIG=/tmp/rclone.conf
export RCLONE_CONFIG

## use the s3 conn details and credentials from environment variables
eval "cat <<EOF
$(<scripts/rclone.conf.tmpl)
EOF
" > ${RCLONE_CONFIG}

#cat ${RCLONE_CONFIG}

date
echo " mounting ${s3_bucket_name} from ${s3_endpoint} "
rclone mount --dir-cache-time 1m0s --poll-interval 0m30s -vv --vfs-cache-mode full --cache-dir /vfs-cache --no-modtime minio:${s3_bucket_name} /user-home 

#--log-level DEBUG

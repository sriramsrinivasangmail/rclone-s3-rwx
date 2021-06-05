#!/bin/sh

# Mount the remote on the container - Refer to issues.txt in rclone_notes
# RUN rclone mount --daemon --dir-cache-time 1m0s --poll-interval 0m30s minio:/bucket /root/user-home --log-level DEBUG

RCLONE_CONFIG=/scripts/rclone.conf
export RCLONE_CONFIG
rclone mount --dir-cache-time 1m0s --poll-interval 0m30s minio:/bucket /root/user-home --log-level DEBUG

#!/usr/bin/env bash

set -e

if [ ! -z "$FTP_USER" -a ! -z "$FTP_PASSWORD" ]; then
    echo "Adding virtual user '$FTP_USER'"
    /add-virtual-user.sh -d "$FTP_USER" "$FTP_PASSWORD"
fi

function set_s3fs_passwd_file {
  echo "$AWS_ACCESS_KEY_ID:$AWS_SECRET_ACCESS_KEY" > /etc/passwd-s3fs
  chmod 640 /etc/passwd-s3fs
}

function mount_s3_bucket {
    echo "Mounting s3 bucket '"$S3_BUCKET"' to /srv"
    s3fs -d -o passwd_file=/etc/passwd-s3fs,use_cache=/tmp,umask=000,allow_other "$1":/ /srv
}

function vsftpd_stop {
  echo "Received SIGINT or SIGTERM. Shutting down vsftpd"
  # Get PID
  pid=$(cat /var/run/vsftpd/vsftpd.pid)
  # Set TERM
  kill -SIGTERM "${pid}"
  # Wait for exit
  wait "${pid}"
  # All done.
  echo "Done"
}

set_s3fs_passwd_file
mount_s3_bucket "$S3_BUCKET"
vsftpd -v

trap vsftpd_stop SIGINT SIGTERM

echo "Running $@"
$@ &
pid="$!"
echo "${pid}" > /var/run/vsftpd/vsftpd.pid
wait "${pid}" && exit $?

# TODO: Fix this process exec
#tail -f /var/log/vsftpd.log
#exec "$@"

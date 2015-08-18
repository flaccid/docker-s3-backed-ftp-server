## docker-s3-backed-ftp-server

Work in progress.

## Usage

### Build

    $ docker build -t s3-backed-ftp-server .

### Run

```
$ docker run -itd \
  --cap-add mknod \
  --cap-add sys_admin \
  --device=/dev/fuse \
  -p 21:21 \
  -p 15393-15592:15393-15592 \
  -e S3_BUCKET=starbug-tandoori \
  -e AWS_ACCESS_KEY_ID=AKIA...I4Q \
  -e 'AWS_SECRET_ACCESS_KEY=X3p...lK1' \
  -e FTP_USER=vftp \
  -e FTP_PASSWORD='$1$qSvGek8Y$r4xPYlK5lCWhuVxdfKvf7.' \
    s3-backed-ftp-server
```

Use `openssl -1` to generate hashed plain password for `FTP_PASSWORD`.

### Tag and Push

    $ docker tag s3-backed-ftp-server flaccid/s3-backed-ftp-server
    $ docker push flaccid/s3-backed-ftp-server

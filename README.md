## docker-s3-backed-ftp-server

Docker image for an S3-backed FTP server powered by vsftpd and s3fs-fuse.

## Usage

### Build

    $ docker build -t s3-backed-ftp-server .

### Run

```
$ docker run -itd \
  --cap-add MKNOD \
  --cap-add SYS_ADMIN \
  --device /dev/fuse \
  -p 21:21 \
  -p 15393-15592:15393-15592 \
  -e S3_BUCKET=starbug-tandoori \
  -e AWS_ACCESS_KEY_ID=AKIA...I4Q \
  -e 'AWS_SECRET_ACCESS_KEY=X3p...lK1' \
  -e FTP_USER=vftp \
  -e FTP_PASSWORD='$1$qSvGek8Y$r4xPYlK5lCWhuVxdfKvf7.' \
    flaccid/s3-backed-ftp-server
```

Use `openssl -1` to generate hashed plain password for `FTP_PASSWORD`.

### Tag and Push

    $ docker tag s3-backed-ftp-server flaccid/s3-backed-ftp-server
    $ docker push flaccid/s3-backed-ftp-server

### Known Issues

On Debian/Ubuntu hosts, `fuse: mount failed: Permission denied` is observed when trying to mount the s3 bucket. It is unclear which docker capability is missing for this distribution (using `--privileged` is the workaround).


License and Authors
-------------------
- Author: Chris Fordham (<chris@fordham-nagy.id.au>)

```text
Copyright 2015, Chris Fordham

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

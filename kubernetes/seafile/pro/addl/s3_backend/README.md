# Enable S3 backend
## Edit seafile.conf
```sh
vi /shared/seafile/conf/seafile.conf
```
## Add bucket entries
```sh
[commit_object_backend]
name = s3
bucket = seafile-commit-objects
key_id = your-key-id
key = your-secret-key
## minio backend
# host = 192.168.1.123:9000
# path_style_request = true
use_https = true
memcached_options = --SERVER=localhost --POOL-MIN=10 --POOL-MAX=100

[fs_object_backend]
name = s3
bucket = seafile-fs-objects
key_id = your-key-id
key = your-secret-key
use_https = true
memcached_options = --SERVER=localhost --POOL-MIN=10 --POOL-MAX=100

[block_backend]
name = s3
bucket = seafile-block-objects
key_id = your-key-id
key = your-secret-key
use_https = true
memcached_options = --SERVER=localhost --POOL-MIN=10 --POOL-MAX=100
```

## Restart services in seafile container ( or restart deployment )
```sh
/opt/seafile/seafile-pro-server-9.0.16/seafile.sh restart
/opt/seafile/seafile-pro-server-9.0.16/seahub.sh restart

```

*Note: I will create job resource in the future to automate this process*
# Velero

Velero (formerly Heptio Ark) gives you tools to back up and restore your Kubernetes cluster resources and persistent volumes. You can run Velero with a public cloud platform or on-premises.

[GitHub Page](https://github.com/vmware-tanzu/velero)

## Notes
- Install client
```
wget https://github.com/vmware-tanzu/velero/releases/download/v1.12.2/velero-v1.12.2-linux-amd64.tar.gz
tar -zxvf velero-v1.12.2-linux-amd64.tar.gz
sudo mv velero-v1.12.2-linux-amd64/velero /usr/local/bin/
sudo rm -rf ./velero-v1.12.2-linux-amd64
```
- CLI install for RESTIC
```
# vars
S3TARGET=http://192.168.5.146:9000

# ./credentials-velero
[default]
aws_access_key_id = MYACCESSKEY
aws_secret_access_key = CHANGEME

# Install Server
velero install \
    --default-volumes-to-fs-backup \
	--use-node-agent \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.2.1 \
    --bucket velero \
    --secret-file ./credentials-velero \
    --use-volume-snapshots=false \
    --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=$S3TARGET
```
- helm folder contains value file for installation with CSI support
- Install scripts for fsb and csi deployments are available inside the addl directory (you need to apply the locations_snap_bak.yml after install.sh)
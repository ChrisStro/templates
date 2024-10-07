#!/bin/bash
velero install --default-volumes-to-fs-backup \
	--features=EnableCSI \
	--use-node-agent \
    --provider aws \
	--plugins velero/velero-plugin-for-aws:v1.2.1,velero/velero-plugin-for-csi:v0.6.0 \
	--no-default-backup-location \
	--no-secret
	# --bucket $BUCKETNAME \
	# --no-secret
	# --secret-file ./credentials-velero \
	# --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=$S3TARGET \
	# --use-volume-snapshots=false

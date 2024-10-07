#!/bin/bash

S3TARGET=http://192.168.5.146:9000

velero install --default-volumes-to-fs-backup \
	--use-node-agent \
        --provider aws \
	--plugins velero/velero-plugin-for-aws:v1.2.1 \
	--bucket migration \
	--secret-file ./credentials-velero \
	--backup-location-config region=minio,s3ForcePathStyle="true",s3Url=$S3TARGET \
	--use-volume-snapshots=false \
	--restore-only

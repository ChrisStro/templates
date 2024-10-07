#!/bin/bash
velero install --default-volumes-to-fs-backup \
	--use-node-agent \
    --provider aws \
	--plugins velero/velero-plugin-for-aws:v1.2.1 \
	--no-default-backup-location \
	--no-secret \
	--use-volume-snapshots=false

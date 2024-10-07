#!/bin/bash

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# enable CSI snapshot support
VERSION='6.2.1'
REPO="https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v$VERSION"
## install snapshot CRDs
kubectl apply -f $REPO/client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml
kubectl apply -f $REPO/client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml
kubectl apply -f $REPO/client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml

## install snapshot controller
kubectl apply -f $REPO/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml
kubectl apply -f $REPO/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml

# create volume snapshot class
kubectl apply -f $SCRIPT_FOLDER/snapshot_class.yml
#!/bin/bash
CHART_NAME="csi-driver-smb"
REPO_NAME="csi-driver-smb"
REPO_URL="https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
FILE="values.yml"

# add repo
helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

# create values file
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    # using helm
    helm show values $REPO_NAME/$CHART_NAME | tee $SCRIPT_FOLDER/$FILE
}
#!/bin/bash
CHART_NAME="velero"
REPO_NAME="vmware-tanzu"
REPO_URL="https://vmware-tanzu.github.io/helm-charts"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
# FILE="$CHART_NAME-values.yml"
FILE="values.yml"

# using helm
helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

# create values file
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    helm show values $REPO_NAME/$CHART_NAME | tee $SCRIPT_FOLDER/$FILE
}
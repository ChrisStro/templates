#!/bin/bash

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
ZITADEL_FILE="zit_values.yml"

# create zitadel values file
CHART_NAME="zitadel"
REPO_NAME="zitadel"
REPO_URL="https://charts.zitadel.com"

helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

test -f "$SCRIPT_FOLDER/$ZITADEL_FILE" && echo "$ZITADEL_FILE already exists" || {
    helm show values $REPO_NAME/$CHART_NAME | tee $SCRIPT_FOLDER/$ZITADEL_FILE 1> /dev/null
}
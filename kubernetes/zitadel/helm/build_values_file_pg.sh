#!/bin/bash

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
CRB_FILE="pg_values.yml"

# create postgresql values file
CHART_NAME="postgresql"
REPO_NAME="bitnami"
REPO_URL="https://charts.bitnami.com/bitnami"

helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

test -f "$SCRIPT_FOLDER/$CRB_FILE" && echo "$CRB_FILE already exists" || {
    helm show values $REPO_NAME/$CHART_NAME | tee $SCRIPT_FOLDER/$CRB_FILE 1> /dev/null
}
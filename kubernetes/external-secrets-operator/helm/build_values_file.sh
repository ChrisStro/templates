#!/bin/bash
CHART_NAME="external-secrets"
REPO_NAME="external-secrets"
REPO_URL="https://charts.external-secrets.io"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
FILE="values.yaml"

# using helm
helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

# create values file
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}

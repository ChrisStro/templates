#!/bin/bash
CHART_NAME="cert-manager"
REPO_NAME="jetstack"
REPO_URL="https://charts.jetstack.io"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
FILE="values.yml"

helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    # using helm
    helm show values jetstack/cert-manager > $SCRIPT_FOLDER/$FILE
}

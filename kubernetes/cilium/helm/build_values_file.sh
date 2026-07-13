#!/bin/bash
CHART_NAME="cilium"
REPO_NAME="cilium"
REPO_URL="https://helm.cilium.io"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
FILE="values.yml"

helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    # using helm
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}

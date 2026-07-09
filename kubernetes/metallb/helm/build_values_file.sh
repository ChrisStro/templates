#!/bin/bash
CHART_NAME="metallb"
REPO_NAME="metallb"
REPO_URL="https://metallb.github.io/metallb"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
FILE="values.yml"

# using helm
helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

# create values file
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    helm show values $REPO_NAME/$CHART_NAME | tee $SCRIPT_FOLDER/$FILE 1> /dev/null
}
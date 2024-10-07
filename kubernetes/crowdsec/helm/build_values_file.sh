#!/bin/bash
CHART_NAME="crowdsec"
REPO_NAME="crowdsec"
REPO_URL="https://crowdsecurity.github.io/helm-charts"

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
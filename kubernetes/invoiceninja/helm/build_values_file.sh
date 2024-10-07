#!/bin/bash
CHART_NAME="invoiceninja"
REPO_NAME="invoiceninja"
REPO_URL="https://invoiceninja.github.io/dockerfiles"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
FILE="values.yml"

helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

# create values file
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    # using helm
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}
#!/bin/bash
CHART_NAME="openebs"
REPO_NAME="openebs"
REPO_URL="https://openebs.github.io/charts"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
# FILE="$CHART_NAME-values.yml"
FILE="values.yml"

# using helm
helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAM

# create values file
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {E
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}
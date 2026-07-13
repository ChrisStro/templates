#!/bin/bash
CHART_NAME="kubernetes-operator"
REPO_NAME="netbirdio"
NAMESPACE="netbird"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# apply helmchart with value file
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'

echo "Running helm for $CHART_NAME in $M mode"
helm $M netbird-operator $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/values.yaml \
 -n $NAMESPACE

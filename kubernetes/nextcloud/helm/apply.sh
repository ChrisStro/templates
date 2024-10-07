#!/bin/bash
CHART_NAME="nextcloud"
REPO_NAME="nextcloud"
NAMESPACE="my-nextcloud"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# apply helmchart with value file
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'

echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/values.yml \
 -n $NAMESPACE --create-namespace

# apply middleware for ingress
kubectl apply -f $SCRIPT_FOLDER/addl/middlewares.yml
#!/bin/bash
CHART_NAME="postgresql"
REPO_NAME="bitnami"
NAMESPACE="my-zitadel"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# apply postgresql
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'

[ $M == 'install' ] && {
    echo "Create certs for secure auth"
    kubectl create ns $NAMESPACE
    kubectl apply -f $SCRIPT_FOLDER/certs-creator.yml
    kubectl -n $NAMESPACE wait --for=condition=complete job/create-certs
}

echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/pg_values.yml \
 -n $NAMESPACE --create-namespace
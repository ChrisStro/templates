#!/bin/bash
CHART_NAME="zitadel"
REPO_NAME="zitadel"
NAMESPACE="my-zitadel"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# apply zitadel
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'

echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/zit_values.yml \
 -n $NAMESPACE --create-namespace

[ $M == 'install' ] && echo "Default Login: zitadel-admin@zitadel.<ExternalDomain>/Password1!"
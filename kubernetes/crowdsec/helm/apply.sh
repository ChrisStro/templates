#!/bin/bash
CHART_NAME="crowdsec"
REPO_NAME="crowdsec"
NAMESPACE="my-crowdsec"

# scriptvars
set -e
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# apply helmchart with value file
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'

echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/values.yml \
 -n $NAMESPACE --create-namespace

echo -e "\nRun nikto -host http://myhostname.local to create alerts\n"

echo -e "\nOnline API is disable, change when go live!!!!\n"

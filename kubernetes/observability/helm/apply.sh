#!/bin/bash

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

REPO_NAME="grafana"
NAMESPACE="observability"

kubectl apply -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: $NAMESPACE
  labels:
    pod-security.kubernetes.io/enforce: privileged
    pod-security.kubernetes.io/audit: privileged
    pod-security.kubernetes.io/warn: privileged
EOF

# grafana
CHART_NAME="grafana"
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'
echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/$CHART_NAME-values.yaml \
 -n $NAMESPACE 

# loki
CHART_NAME="loki"
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'
echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/$CHART_NAME-values.yaml \
 -n $NAMESPACE

# prometheus
REPO_NAME="prometheus-community"
CHART_NAME="prometheus"
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'
echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/$CHART_NAME-values.yaml \
 -n $NAMESPACE

# opentelemetry
REPO_NAME="open-telemetry"
CHART_NAME="opentelemetry-collector"
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'
echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/$CHART_NAME-values.yaml \
 -n $NAMESPACE

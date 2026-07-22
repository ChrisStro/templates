#!/bin/bash
CHART_NAME="csi-driver-smb"
REPO_NAME="csi-driver-smb"
NAMESPACE="smb-csi"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# apply helmchart with value file
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

RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'

echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/values.yml \
 -n $NAMESPACE

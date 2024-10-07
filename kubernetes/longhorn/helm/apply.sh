#!/bin/bash
CHART_NAME="longhorn"
REPO_NAME="longhorn"
NAMESPACE="my-longhorn"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# apply helmchart with value file
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'

# requirements
[ "$M" == 'install' ] && {
    echo "Check dependencies on all nodes"
    kubectl get nodes | awk 'NR>1 {print $1}' | xargs -n1 -P3 bash -c 'ssh -T -q root@$0 <<EOF
        dpkg -l | grep open-iscsi || apt install open-iscsi -y
        dpkg -l | grep nfs-common || apt install nfs-common -y
    EOF'
}

echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/values.yml \
 -n $NAMESPACE --create-namespace

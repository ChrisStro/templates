#!/bin/bash

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# repo update grafana
REPO_NAME="grafana"
REPO_URL="https://grafana.github.io/helm-charts"
helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME


# grafana
CHART_NAME="grafana"
FILE="$CHART_NAME-values.yaml"
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}

# loki
CHART_NAME="loki"
FILE="$CHART_NAME-values.yaml"
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}


# repo update prometheus
REPO_NAME="prometheus-community"
REPO_URL="https://prometheus-community.github.io/helm-charts"
helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

# prometheus 
CHART_NAME="prometheus"
FILE="$CHART_NAME-values.yaml"
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}


# repo update opentelemetry
REPO_NAME="open-telemetry"
REPO_URL="https://open-telemetry.github.io/opentelemetry-helm-charts"
helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

# opentelemetry 
CHART_NAME="opentelemetry-collector"
FILE="$CHART_NAME-values.yaml"
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}

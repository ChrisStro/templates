#!/bin/bash

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# main
read -p "Enter Ingress SAN:" SAN
sed  -i "s/local.127.0.0.1.sslip.io/$SAN/g" $SCRIPT_FOLDER/expose_ui/ingressroute.yml
sed  -i "s/local.127.0.0.1.sslip.io/$SAN/g" $SCRIPT_FOLDER/expose_ui/ingress.yml

echo "apply Ingress for Traefik Proxy"
kubectl apply -f $SCRIPT_FOLDER/resources/IngressClass.yml
kubectl apply -f $SCRIPT_FOLDER/expose_ui/ingressroute.yml
kubectl apply -f $SCRIPT_FOLDER/expose_ui/ingress.yml
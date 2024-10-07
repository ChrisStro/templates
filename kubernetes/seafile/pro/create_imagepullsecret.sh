#!/bin/bash
SECRET_NAME=seafile-pro-repo
DOCKER_REGISTRY_SERVER=docker.seadrive.org
DOCKER_USER=seafile
NAMESPACE=my-seafile

echo "Create secret to pull seafile pro image from seafile private repository"
echo "DOCKER_REGISTRY_SERVER: $DOCKER_REGISTRY_SERVER"
echo "DOCKER_USER: $DOCKER_USER"
echo "Enter your password from https://customer.seafile.com/downloads"
read -p 'DOCKER_PASSWORD: ' DOCKER_PASSWORD
echo
echo "
DOCKER_REGISTRY_SERVER  :     $DOCKER_REGISTRY_SERVER
DOCKER_USER             :     $DOCKER_USER
DOCKER_PASSWORD         :     $DOCKER_PASSWORD
"
read -p 'Check your input (y to contiune): ' SUBMIT

[ "$SUBMIT" == "y" ] && {
    kubectl create secret docker-registry $SECRET_NAME \
        --docker-server=$DOCKER_REGISTRY_SERVER \
        --docker-username=$DOCKER_USER \
        --docker-password=$DOCKER_PASSWORD \
        -n $NAMESPACE
    echo
    echo "Secret created..."
} || echo "Canceled"

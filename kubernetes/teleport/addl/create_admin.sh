#!/bin/bash
read -p "Enter username of new admin-user : " USERNAME
kubectl -n my-teleport exec -ti deployment/teleport-cluster-auth -- tctl users add $USERNAME --roles=editor,access
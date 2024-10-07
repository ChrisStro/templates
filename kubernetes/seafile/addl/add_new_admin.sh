#!/bin/bash
kubectl exec -it deploy/seafile-app -c seafile -- /opt/seafile/seafile-server-latest/reset-admin.sh
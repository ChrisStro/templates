#! /usr/local/bin/env bash
kubectl apply -n cilium -f https://raw.githubusercontent.com/cilium/connectivity-check/main/connectivity-check.yaml

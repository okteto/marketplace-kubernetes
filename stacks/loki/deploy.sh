#!/bin/sh

set -e

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: monitoring
EOF

kubectl config set-context --current --namespace=monitoring

kubectl apply -f https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/loki/manifest.yaml

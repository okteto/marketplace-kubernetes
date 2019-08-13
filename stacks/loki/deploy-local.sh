#!/bin/sh

set -e

ROOT_DIR=$(git rev-parse --show-toplevel)

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: monitoring
EOF

kubectl config set-context --current --namespace=monitoring

kubectl apply -f "$ROOT_DIR"/stacks/loki/manifest.yaml

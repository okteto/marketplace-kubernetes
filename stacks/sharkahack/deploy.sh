#!/bin/sh

set -e

sh -c "curl --location --silent --show-error https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/metrics-server/deploy.sh | sh"
sh -c "curl --location --silent --show-error https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/prometheus-operator/deploy.sh | sh"
sh -c "curl --location --silent --show-error https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/nginx-ingress/deploy.sh | sh"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

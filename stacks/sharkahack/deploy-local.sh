#!/bin/sh

set -e

ROOT_DIR=$(git rev-parse --show-toplevel)

#sh "$ROOT_DIR"/stacks/metrics-server/deploy-local.sh
#sh "$ROOT_DIR"/stacks/prometheus-operator/deploy-local.sh
# sh "$ROOT_DIR"/stacks/nginx-ingress/deploy-local.sh
#sh "$ROOT_DIR"/stacks/openfaas/deploy-local.sh

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

kubectl --kubeconfig=dev-kubeconfig.yaml cluster-info | head -n 1 > url.txt
# egrep -o 'https?://[^ ]+' url.txt
export UUID=`cat url.txt | cut -c59-94`
rm url.txt

echo $UUID
# create prometheus-operator namespace
cat <<EOF | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  rules:
  - host: grafana.${UUID}.dohackafun.com
    http:
      paths:
      - path: /
        backend:
          serviceName: prometheus-operator-grafana
          servicePort: 80
  - host: openfaas.${UUID}.dohackafun.com
    http:
      paths:
      - path: /
        backend:
          serviceName: gateway-external
          servicePort: 8080
EOF

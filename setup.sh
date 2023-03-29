#!/usr/bin/bash

set -x

CWDIR=$(pwd)

source "${CWDIR}/.env"
gcloud container clusters get-credentials "${CLUSTER_NAME}"  --region="${REGION}" --project="${PROJECT}"
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.11.0 --set installCRDs=true
kubectl create namespace nginx-ingress-controller 
kubectl apply -f "${CWDIR}/helm/cert-manager/clusterissuer.yaml" -n nginx-ingress-controller

helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace nginx-ingress-controller --create-namespace --set controller.service.loadBalancerIP="${LOAD_BALANCER_IP}" --set controller.extraArgs.default-ssl-certificate="nginx-ingress-controller/tls-cert" 

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm upgrade --install grafana grafana/grafana -n monitoring --create-namespace -f "${CWDIR}/helm/grafana/values.yaml"
helm upgrade --install loki grafana/loki -n monitoring --create-namespace
helm upgrade --install prometheus prometheus-community/prometheus -n monitoring --create-namespace


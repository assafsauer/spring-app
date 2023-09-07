#!/bin/sh

script_path=$(dirname "$0")
output_path=$script_path/../k8s/deploy/base

helm template prometheus bitnami/kube-prometheus \
  --namespace prometheus \
  --version 8.3.11 \
  --include-crds \
  -f $script_path/prometheus-helm-values.yaml \
  > $output_path/prometheus.yaml

helm template kube-state-metrics bitnami/kube-state-metrics \
  --namespace prometheus \
  --version 3.3.3 \
  --include-crds \
  -f $script_path/kube-state-metrics-helm-values.yaml \
  > $output_path/kube-state-metrics.yaml

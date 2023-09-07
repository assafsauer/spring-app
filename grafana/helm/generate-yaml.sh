#!/bin/sh

script_path=$(dirname "$0")
output_path=$script_path/../k8s/deploy/base

helm template grafana bitnami/grafana \
  --namespace grafana \
  --version 8.2.28 \
  --include-crds \
  -f $script_path/helm-values.yaml \
  > $output_path/grafana.yaml

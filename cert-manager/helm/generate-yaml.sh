#!/bin/sh

script_path=$(dirname "$0")
output_path=$script_path/../k8s/deploy/base

helm template cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.11.0 \
  --include-crds \
  --debug \
  -f $script_path/helm-values.yaml \
  > $output_path/cert-manager.yaml

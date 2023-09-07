#!/bin/sh

script_path=$(dirname "$0")
output_path=$script_path/../k8s/deploy/base

helm template postgresql bitnami/postgresql \
  --namespace postgresql \
  --version 12.2.6 \
  --include-crds \
  -f $script_path/helm-values.yaml \
  > $output_path/postgresql.yaml

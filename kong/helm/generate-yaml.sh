#!/bin/sh

script_path=$(dirname "$0")
output_path=$script_path/../k8s/deploy/base

helm template kong oci://registry-1.docker.io/bitnamicharts/kong \
  --namespace kong \
  --version 9.4.0 \
  --include-crds \
  -f $script_path/helm-values.yaml \
  > $output_path/kong.yaml

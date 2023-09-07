#!/bin/sh

script_path=$(dirname "$0")
output_path=$script_path/../k8s/deploy/base
# output_path=$script_path/../../k8s/deploy/base/keycloak

helm template keycloak oci://registry-1.docker.io/bitnamicharts/keycloak \
  --namespace keycloak \
  --version 16.1.0 \
  --include-crds \
  -f $script_path/helm-values.yaml \
  > $output_path/keycloak.yaml

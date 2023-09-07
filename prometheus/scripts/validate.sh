#!/bin/bash

NAMESPACE="prometheus"
RELEASE_NAME="prometheus-kube-prometheus-prometheus"

echo "Checking Prometheus CRDs..."
if ! kubectl get crd prometheuses.monitoring.coreos.com >/dev/null 2>&1; then
  echo "Prometheus CRDs are not installed. Exiting..."
  exit 1
fi
echo "All Prometheus CRDs are installed."

echo "Checking Prometheus pods..."
if ! kubectl get pods -n $NAMESPACE -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=$RELEASE_NAME" >/dev/null 2>&1; then
  echo "Prometheus pods are not running. Exiting..."
  exit 1
fi
echo "All Prometheus pods are running."

echo "Checking Prometheus service..."
if ! kubectl get svc -n $NAMESPACE -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=$RELEASE_NAME" >/dev/null 2>&1; then
  echo "Prometheus service is not available. Exiting..."
  exit 1
fi
echo "Prometheus service is available."

echo "Checking Prometheus pod readiness..."
POD_NAME=$(kubectl get pods -n $NAMESPACE -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=$RELEASE_NAME" -o jsonpath="{.items[0].metadata.name}")
if ! kubectl wait --for=condition=ready pod -n $NAMESPACE $POD_NAME --timeout=60s >/dev/null 2>&1; then
  echo "Prometheus pod is not ready. Exiting..."
  exit 1
fi
echo "Prometheus pod is ready."

# Start kubectl port-forward command in the background
kubectl port-forward pods/${POD_NAME} 9090:9090 -n ${NAMESPACE} &

# Save the PID of the kubectl port-forward command
PORT_FORWARD_PID=$!

# Give it some time to establish the connection
sleep 5

# Check Prometheus health
HEALTH_RESPONSE=$(curl -s http://localhost:9090/-/healthy)

echo "Health check response: ${HEALTH_RESPONSE}"

if echo "${HEALTH_RESPONSE}" | grep -q "Prometheus Server is Healthy"; then
    echo "Prometheus is healthy."
else
    echo "Prometheus is not healthy. Exiting..."
    # Stop the kubectl port-forward command
    kill ${PORT_FORWARD_PID}
    exit 1
fi

# Stop the kubectl port-forward command
kill ${PORT_FORWARD_PID}

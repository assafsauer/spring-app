#!/bin/bash

NAMESPACE="kong"
SERVICE_NAME="kong"
KONG_ADMIN_API="http://$SERVICE_NAME:8001"

# Check the status of the Kong service
SERVICE_STATUS=$(kubectl get svc -n $NAMESPACE $SERVICE_NAME -o jsonpath="{.status.loadBalancer.ingress[*].ip}")
if [ -n "$SERVICE_STATUS" ]; then
    echo "Kong service is available at IP: $SERVICE_STATUS"
else
    echo "Kong service is not available"
fi

# Check the status of the Kong pods
POD_STATUS=$(kubectl get pods -n $NAMESPACE -l app.kubernetes.io/name=kong -o jsonpath="{.items[*].status.phase}")
if [ "$POD_STATUS" == "Running" ]; then
    echo "Kong pods are running"
else
    echo "Kong pods are not running"
fi

# Check the Kong Admin API
ADMIN_API_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $KONG_ADMIN_API)
if [ "$ADMIN_API_STATUS" -eq 200 ]; then
    echo "Kong Admin API is up and running"
else
    echo "Kong Admin API is not available"
fi

# Check the Kong Ingress Controller logs
echo "Checking Kong Ingress Controller logs..."
kubectl logs -n $NAMESPACE -l app.kubernetes.io/name=kong

#!/bin/bash

# Set the namespace
NAMESPACE="kong"

# Set the names of the pod and service
POD_NAME="my-kong-postgresql-0"
SERVICE_NAME="my-kong-postgresql"

# Check if the PostgreSQL pod exists
if kubectl get pod $POD_NAME -n $NAMESPACE > /dev/null 2>&1; then
    echo "The PostgreSQL pod exists."

    # Check the status of the pod
    POD_STATUS=$(kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath="{.status.phase}")

    if [ "$POD_STATUS" == "Running" ]; then
        echo "The PostgreSQL pod is running."

        # Check if the database is up and running
        if kubectl exec -n $NAMESPACE $POD_NAME -- bash -c 'pg_isready -U "kong" -d "dbname=kong" -h 127.0.0.1 -p 5432' > /dev/null 2>&1; then
            echo "The PostgreSQL database is up and running."
        else
            echo "The PostgreSQL database is not running."
        fi
    else
        echo "The PostgreSQL pod is not running. Current status: $POD_STATUS"
    fi
else
    echo "The PostgreSQL pod does not exist."
fi

# Check the status of the service
SERVICE_STATUS=$(kubectl get svc $SERVICE_NAME -n $NAMESPACE -o jsonpath="{.status.loadBalancer.ingress[*].ip}")

if [ -z "$SERVICE_STATUS" ]; then
    echo "The PostgreSQL service does not have an external IP. It may not be accessible from outside the cluster."
else
    echo "The PostgreSQL service is accessible at IP: $SERVICE_STATUS"
fi

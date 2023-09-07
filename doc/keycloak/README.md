### Deployment

```bash
# Deploy
kubectl apply -k $STACKTIC_OUTPUT/k8s/deploy/overlays/dev/keycloak

# Check the status
kubectl get all --namespace keycloak
```

### Usage

>💡 By default, the admin user is `user` and the password is the one you filled in Stacktic.

```bash

# To access Keycloak from outside the cluster with ClusterIP execute the following commands:
echo "Browse to http://127.0.0.1:8080"
kubectl port-forward --namespace keycloak svc/keycloak 8080:80


```


### Resources

* https://bitnami.com/stack/keycloak/helm
* https://github.com/bitnami/containers/issues/1046#issuecomment-1544184668
* https://www.keycloak.org/server/importExport#_importing_a_realm_during_startup
* https://www.keycloak.org/server/reverseproxy
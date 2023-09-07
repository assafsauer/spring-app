# System documentation

This is the documentation for your system.

## First deployment

### Build

In order to build your components, you'll have to prepare the build namespace.
This namespace is common for all your builds, and is configured to integrate with your Git and Registry.

Configure build namespace

```bash
# Deploy
kubectl apply -k $STACKTIC_OUTPUT/k8s/build/overlays/dev/stacktic

# Check
kubectl get secret registry-credential -n build
kubectl get secret git-credential -n build
```

You can now run your builds.

### Deploy

If you want to benefit from our debug and test tooling, you'll have to deploy the `Stacktic` system.

```bash
# Deploy
kubectl apply -k $STACKTIC_OUTPUT/k8s/deploy/overlays/dev/stacktic --server-side=true --force-conflicts=true
```

## Deploy all components

```bash
kubectl apply -k $STACKTIC_OUTPUT/k8s/deploy/overlays/dev/ --server-side=true --force-conflicts=true
```

>💡You may encounter this kind of error `no matches for kind "XXX" in version "xxx.com/v1"`, reapply the deployment and the error won't appear anymore. 


## Components

- [kong](kong/README.md)
- [cert-manager](cert-manager/README.md)
- [spring](spring/README.md)
- [keycloak](keycloak/README.md)
- [postgresql](postgresql/README.md)
- [prometheus](prometheus/README.md)
- [grafana](grafana/README.md)


## Tips

* Do not use `"` for your variables in`*.env` secret files`
* Use Kustomize `namespace` functionality carefully, there may be component deployed in different namespace. You may want to use `NamespaceTransformer` to manage that. Exemple is the usage of Service Monitor which are deployed in the prometheus namespace, not the component one.

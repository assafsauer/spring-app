### Usage

```bash
# Deploy
kubectl apply -k $STACKTIC_OUTPUT/k8s/deploy/overlays/dev/kong

# Check deployment
kubectl get all -n kong
```

### Access

Create a DNS A record for the ingress is the external controller IP

```sh
kubectl get services -n kong

```

### Debug

```bash
sh $STACKTIC_OUTPUT/kong/scripts/validate.sh
```

### Resources



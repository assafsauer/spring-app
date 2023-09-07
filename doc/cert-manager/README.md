### Usage

```bash
# Deploy
kubectl apply -k $STACKTIC_OUTPUT/k8s/deploy/overlays/dev/cert-manager

# Check deployment
kubectl get all -n cert-manager
```

### Debug

```sh
kubectl logs -lapp=cert-manager  -n cert-manager
```

### Tips

* Do not use Kustomize namespace because there is stuff deployed in the namespace `kube-system` and in your specified namespace.
* You may encounter the message `no matches for kind "ClusterIssuer" in version "cert-manager.io/v1` during the first deployment. This error will solve automatically, if you apply it again after a couple of seconds, the message won't appear again.

### Resources

* https://cert-manager.io/docs/tutorials/acme/nginx-ingress/


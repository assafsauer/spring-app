### Deployment

```bash
# Deploy
kubectl apply -k $STACKTIC_OUTPUT/k8s/deploy/overlays/dev/grafana

# Check the status
kubectl get all --namespace grafana
```

### Usage

>💡 By default, the user is `admin` and the password is the one you filled in Stacktic.

```bash

# To access Grafana from outside the cluster with ClusterIP execute the following commands:
echo "Browse to http://127.0.0.1:8080"
kubectl port-forward --namespace grafana svc/grafana 8080:3000


```

### Customization

If you want to add a new dashboard
* Create your `json` file
* Add the enty in your `kustomization.yaml`
* Add the entry in the `helm-values.yaml`

### Resources

* https://bitnami.com/stack/grafana/helm
* https://github.com/bitnami/charts/tree/main/bitnami/grafana
* https://github.com/bitnami/charts/blob/main/bitnami/grafana/values.yaml
* https://tanzu.vmware.com/developer/guides/observability-prometheus-grafana-p1/
* https://grafana.com/docs/grafana/latest/administration/provisioning/#data-sources

### Annexes

#### Dashboards
* https://grafana.com/grafana/dashboards/10000-kubernetes-cluster-monitoring-via-prometheus/
* https://github.com/prometheus-operator/kube-prometheus/issues/1695
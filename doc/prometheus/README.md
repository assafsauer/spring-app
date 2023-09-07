### Deployment

```bash
# Deploy - Do not forget the  --force-conflicts=true --server-side=true
# to fix - CustomResourceDefinition.apiextensions.k8s.io "prometheuses.monitoring.coreos.com" is invalid: metadata.annotations: Too long: must have at most 262144 bytes
kubectl apply -k $STACKTIC_OUTPUT/k8s/deploy/overlays/dev/prometheus --force-conflicts=true --server-side=true

# Check the status
kubectl get all --namespace prometheus
```

### Usage

```bash
# Prometheus can be accessed via port "9090" on the following DNS name from within your cluster:
prometheus-kube-prometheus-prometheus.prometheus.svc.cluster.local

# To access Prometheus from outside the cluster execute the following commands:
echo "Prometheus URL: http://127.0.0.1:9090/"
kubectl port-forward --namespace prometheus svc/prometheus-kube-prometheus-prometheus 9090:9090

# Alertmanager can be accessed via port "9093" on the following DNS name from within your cluster:
prometheus-kube-prometheus-alertmanager.prometheus.svc.cluster.local

# To access Alertmanager from outside the cluster execute the following commands:
echo "Alertmanager URL: http://127.0.0.1:9093/"
kubectl port-forward --namespace prometheus svc/prometheus-kube-prometheus-alertmanager 9093:9093
```

### Debug

```bash
# Check connectivity
kubectl run busybox --image=busybox -n stacktic --rm -it --restart=Never \
--overrides='{ "spec": { "serviceAccount": "stacktic" }}' \
-- wget -qO- http://prometheus-kube-prometheus-prometheus.prometheus.svc.cluster.local:9090

# Prometheus logs
kubectl logs -n prometheus -l app.kubernetes.io/name=kube-prometheus,app.kubernetes.io/instance=prometheus,app.kubernetes.io/component=operator --tail -1
```

> ℹ️ You can check the scrap status through the GUI, on Status > Target

### Resources

* https://bitnami.com/stack/prometheus-operator/helm
* https://github.com/bitnami/charts/tree/main/bitnami/kube-prometheus/
* https://github.com/prometheus-operator/prometheus-operator
* https://tanzu.vmware.com/developer/guides/observability-prometheus-grafana-p1/

#### Known issues

* https://grafana.com/blog/2023/01/19/how-to-monitor-kubernetes-clusters-with-the-prometheus-operator/

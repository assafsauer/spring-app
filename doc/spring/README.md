### Run locally

```bash
cd $STACKTIC_OUTPUT/spring
docker-compose up --detach
./mvnw spring-boot:run

curl http://localhost:8080
```

### Build

```bash
# Deploy
kubectl apply -k $STACKTIC_OUTPUT/k8s/build/overlays/dev/spring

# Check the status
kubectl get job spring-kaniko -n build

# Check the logs
kubectl logs jobs/spring-kaniko -n build -f
```

### Deploy

```bash
# Deploy
kubectl apply -k $STACKTIC_OUTPUT/k8s/deploy/overlays/dev/spring

# Check the status
kubectl get all -n spring
```

### Access

#### Load Balancer

```bash
# External IP
export SERVICE_IP=$(kubectl get svc --namespace spring spring -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo http://$SERVICE_IP:8080

# Health endpoints
curl http://$SERVICE_IP:8080/actuator/health/liveness
curl http://$SERVICE_IP:8080/actuator/health/readiness

# App endpoints
curl http://$SERVICE_IP:8080/greeting
curl http://$SERVICE_IP:8080/greeting?name=Stacktic
curl http://$SERVICE_IP:8080/greeting-sql/1
```
#### Ingress

##### Endpoints

```bash
# App endpoints
curl https://spring.stacktic.beenotice.eu/greeting
curl https://spring.stacktic.beenotice.eu/greeting?name=Stacktic
curl https://spring.stacktic.beenotice.eu/greeting-sql/1
```

### Debug

```bash
# Check connectivity
kubectl run busybox --image=busybox -n spring --rm -it --restart=Never \
--overrides='{ "spec": { "serviceAccount": "spring" }}' \
-- wget -qO- http://spring.spring.svc.cluster.local:8080
```

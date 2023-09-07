### Usage

```bash
# Deploy
kubectl apply -k $STACKTIC_OUTPUT/k8s/deploy/overlays/dev/postgresql

# Check deployment
kubectl get all -n postgresql
```

### Debug

```bash
# Connect to Pod
kubectl exec -it postgresql-0 -n postgresql -- /bin/sh

# Connect as admin
psql -U postgres

# Connect as a custom users
psql spring_db -U spring


# PostgreSQL can be accessed via port 5432 on the following DNS names from within your cluster:
postgresql.postgresql.svc.cluster.local

# Check connectivity - Fill the <password>
kubectl run pgsql-client --image docker.io/bitnami/postgresql --rm -it --restart=Never -n stacktic \
--overrides='{ "spec": { "serviceAccount": "stacktic" }}' \
--env="PGPASSWORD=change_me" --command -- psql  \
--host postgresql.postgresql.svc.cluster.local \
-U postgres -p 5432
```

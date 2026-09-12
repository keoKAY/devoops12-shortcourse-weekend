## Working with argocd services 

```bash 
kubectl get all -n argocd 
```
## NOTE 


```bash 
kubectl get svc -n argocd
kubectl get svc -n argocd argocd-server  
kubectl get svc argocd-server -n argocd -o yaml

# Checking if the argocd running on secure or insecure mode

```
- Result from the command 
```
k describe svc argocd-server -n argocd            
Name:                     argocd-server
Namespace:                argocd
Labels:                   app.kubernetes.io/component=server
                          app.kubernetes.io/name=argocd-server
                          app.kubernetes.io/part-of=argocd
Annotations:              <none>
Selector:                 app.kubernetes.io/name=argocd-server
Type:                     ClusterIP
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.233.34.67
IPs:                      10.233.34.67
Port:                     http  80/TCP
TargetPort:               8080/TCP
Endpoints:                10.233.69.27:8080
Port:                     https  443/TCP
TargetPort:               8080/TCP
Endpoints:                10.233.69.27:8080
Session Affinity:         None
Internal Traffic Policy:  Cluster
Events:                   <none>

```

- Port forward to the argocd service
```bash
kubectl port-forward svc/argocd-server \
    -n argocd 8443:80

kubectl logs -n traefik deployment/traefik --tail=100
```


## Problem with ARGOCD 
```bash
-14T13:41:18Z INF Starting provider *acme.ChallengeTLSALPN
2026-06-14T13:51:20Z WRN A new release of Traefik has been found: 3.7.5. Please consider updating.
2026-06-14T14:02:06Z ERR 500 Internal Server Error error="tls: failed to verify certificate: x509: cannot validate certificate for 10.233.69.7 because it doesn't contain any IP SANs"
2026-06-14T14:02:06Z ERR 500 Internal Server Error error="tls: failed to verify certificate: x509: cannot valid
```
Traefik connecting to the Argocd using its cluster IP , but argocd certificates was not issued for that IP address, so TLS verifications filaed. 

This means that the Traefik is not using `ServersTransport` with `insecureSkipVerify:true`, or it not finding it 

```bash 
kubectl get serverstransport -n argocd 

# Checking if the traefik installation comes with the CRD Provider enable 
kubectl get deployment -n traefik traefik -o yaml | grep providers -A5 -B5


kubectl edit svc argocd-server -n argocd 
```

## Solutions 
> Solution from Traefik side 
We only need to services that be used from traefik to allow the communication for the argocd server: 
1. **ServerTransport**: in order to skip SSL verification when argocd talk to its own services (internally )
2. **IngressRoute** : same as kubernetes ingress, but it is a traefik object for `ingress + server transport` option 


The anntoation must sometimes be placed on Service , not on the ingress 
Depends on the traefik version v2.x and v3.x , 
the `servertransport` annotation **must be attached direclty to kubernetes Service resource** rather than the Ingress resource, because Traefik treats the backend transport properties as part of the Service object logic. 

```yaml 
apiVersion: v1
kind: Service
metadata:
  name: argocd-server
  namespace: argocd
  annotations:
    # Move these here:
    traefik.ingress.kubernetes.io/service.serversscheme: https
    traefik.ingress.kubernetes.io/service.serverstransport: argocd-argocd-transport@kubernetescrd
spec:
  # ... rest of the service stays the same
```


### Solution: 
  - patch argocd `server.insecure=true` inside the argocd configmap 

> Set Argo CD to insecure mode internally:
```bash

kubectl patch configmap argocd-cmd-params-cm \
-n argocd \
--type merge \
-p '{"data":{"server.insecure":"true"}}'
## Find the argocd's password
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d && echo
```

### Changing the password 
```bash

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

```



## configure webhook: 
- To allow the immediate update when there is changes push to the gitops , unlike default hat need to wait around 3 mins to detect or pull the new update 
```bash
kubectl edit secret argocd-secret -n argocd

# below the data: 

echo -n "your-secret-pass" | base64 
# github.webhook.secret: <base54-data>

# to save and quit after we add the update 
:wq
```
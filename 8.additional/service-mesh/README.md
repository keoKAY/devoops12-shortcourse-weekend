## NOTE RELATED TO THE SERVICE MESH 


Service mesh is an extra networking layer for k8s that manage service-to-service communication inside the cluster. 
K8s (service) give you discovery and loadbalancing; a servicemesh adds things like **mTLS, retries , traffic splitting, observability, access control , and failure handlings**. 

![illustration for when using istio for the service mesh](image-1.png)
- installing the istio with helm 
```bash
helm repo add istio https://blob.istio.io/istio-release/charts
helm repo update


helm install istio-base \
    istio/base -n istio-system \
    --set defaultRevision=default --create-namespace


helm status istio-base -n istio-system
helm get all istio-base -n istio-system

helm install istiod istio/istiod -n istio-system --wait


# Optional , ingress gateway 
kubectl create namespace istio-ingress
helm install istio-ingress istio/gateway -n istio-ingress --wait

```
- installing the cli 
```bash
curl -L https://istio.io/downloadIstio | sh
cd istio-*
export PATH=$PWD/bin:$PATH

istioctl version 
```

- Install 
```bash
istioctl install --set profile=demo -y
# to verify the installations 
kubectl get pods -n istio-system
```
```bash
NAME                                    READY   STATUS    RESTARTS   AGE
istio-egressgateway-86c9d87669-mwvp5    1/1     Running   0          51s
istio-ingressgateway-6cf56f985f-5zml6   1/1     Running   0          51s
istiod-5dd4b9f85b-prptl                 1/1     Running   0          28s
istiod-5dd4b9f85b-slfv9                 1/1     Running   0          63s
```

```bash 
# create the namespace 
kubectl create namespace mesh-demo

# to enable the auto sidecar injection 
kubectl label namespace mesh-demo istio-injection=enabled
# checkings 
kubectl get namespace mesh-demo --show-labels
```
![each pod have side car ](image.png)


- When we apply the `product-svc.yaml` 
Both deployment have 
```yaml 
app: product
```
k8s service see both 
`product-v1` 
`product-v2` 
kubenetes may distributes the request to both deployments. 

- after applying the test-client.yaml 

```bash
kubectl exec -it -n mesh-demo deploy/client -c client -- sh
```
```bash
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 1
~ $ curl product
PRODUCT VERSION 1
~ $ curl product
PRODUCT VERSION 1
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 1
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 1
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 2
~ $ curl product
PRODUCT VERSION 2
```
- Let the ISTIO adding the rule (DestinationRule)
> destinationrule define a group of pod called subset. 
```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: product
  namespace: mesh-demo
spec:
  host: product

  subsets:
    - name: v1
      labels:
        version: v1

    - name: v2
      labels:
        version: v2
```
the important path: 

v1 -> pods labeled version=v1
v2 -> pods labeled version=v2

- ISTIO VIRTUALSERVICE 
this is related to controlling the services traffic 

Initially send the request 100% -> V1 
```bash
kubectl exec -it -n mesh-demo deploy/client -c client -- sh

# Inside the container , run this to test 
for i in $(seq 1 10); do curl product; echo; done
```
- We should see the same output:
```bash
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
```

### Canary Deployments
```bash
90% users -> v1
10% users -> v2
```
Change the weight to the version1 = 90% , change weight to version2 = 10% 

Go through the same process of testing again 
```bash
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 1
PRODUCT VERSION 2
PRODUCT VERSION 1
```
### Blue/Green Deployment 
change 100 -> v1 
Change 0 -> v2 

change  0 -> V1 
Change 100 -> v2 

### RETRY
Suppose our backend sometimes, we can do this from the frontend side. 
```bash
try request
if failure
    retry
```
Istio can handle : 
```yaml 
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: product
  namespace: mesh-demo
spec:
  hosts:
    - product

  http:
    - retries:
        attempts: 3
        perTryTimeout: 2s

      route:
        - destination:
            host: product
            subset: v1
```
Meaning: 
```bash
Frontend
   |
request
   |
Envoy
   |
   +--> product
          |
        failure
          |
          retry
          |
          retry
```
> Application doens't need to retries itself. 

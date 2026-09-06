## NOTE related to helm 

```bash 
helm create nginx-chart
helm install nginx-release nginx-chart 
helm uninstall nginx-release # uninstall 
# list all of your release 
helm list 
kubectl get svc 
kubectl get pod ,deploy, ... 


# values.yaml inside the nginx-chart directory
helm upgrade nginx-release nginx-chart 
# prefer command 
helm upgrade nginx-release nginx-chart --install

helm history nginx-release 
helm rollback nginx-release <revision-id>
```

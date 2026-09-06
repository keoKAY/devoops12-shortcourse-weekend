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

# render the manifest values of the  chart 
helm template nginx-chart 
helm template nginx-chart --values=prod-values.yaml 



# release service for specific env 
helm install reactjs-release nginx-chart \
    --values=prod-values.yaml

# if you put the prod-values.yaml file inside the nginx-chart     
helm install reactjs-release nginx-chart \
    --values=nginx-chart/prod-values.yaml 
```

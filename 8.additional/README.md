## ADDITIONAL TOPICS FOR KUBERNETES 


Security, Access Control, Networking, Reliability, Production Operations. 

- ServiceAccount
- RBAC 
- NetworkPolicy 
- SecurityContext 
- Pod Security
- ResourceQuota/LimitRange 
- HPA/PDB 
- Admission Control 


### 1. **Network Policy**: 
Control which pods can communicates 
By default, K8S networking is generally very open: if the CNI allows it, Pods can communicate with other Pods. 
![alt text](image.png)
![alt text](image-1.png)
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy 
metadata: 
  name: postgres-policy 
  namespace: default 

spec: 
  podSelector:
    matchLabels:
      app: postgres 
  policyTypes: 
    - Ingress 
  ingress: 
    - from : 
      - podSelector:
          matchLabels:
            app: backend 
      ports: 
        - protocol: TCP 
          port: 5432 
```
> One Important Default: CNI must support NetworkPolicy enforcement. K8s defines the API, but network plugin enforce it. 

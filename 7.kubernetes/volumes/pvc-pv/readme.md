## NOTE related to PVC and PV 


- NFS DYNAMIC PROVISIONER 
```bash
helm repo list 
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm repo update 
# Install nfs subdir external provisioner 
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=10.148.0.2 \
    --set nfs.path=/srv/nfs_shared
```
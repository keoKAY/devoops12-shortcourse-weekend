## NOTE 

Requirements 
1. VsCode 
2. VirtualBox 
3. Vagrant 
```bash
vagrant version 


# macos 
# box = os 
vagrant init <box-name> 
vagrant init bento/ubuntu-24.04
# to turn on the machine 
# first try -> it will download the image from cloud
vagrant up 
vagrant status 
vagrant ssh # remote to the VM (using ssh )


# inside your vm machine 
sudo apt update && sudo apt upgrade -y 
sudo apt install neofetch -y 


vagrant halt # turn off 
vagrant destroy -f # delete the machine inside virtualbox

# after changing the configuration inside VagrantFile 
vagrant reload 
vagrant reload --provision
# ssh user@ip 

# window / ubuntu 
vagrant init ubuntu/jammy64
```
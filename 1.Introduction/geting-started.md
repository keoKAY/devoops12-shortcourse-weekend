## NOTE 
for the basic command 


remote 
command 1 
command 2

cd locationA 
    config .... 



```bash 

sudo apt install tree -y 
pwd 
cd / # go into root directory 


sudo apt install nginx -y 
# for bettter command experience 
# omz , fish 


# too long don't read 
#npm install -G tdlr 
sudo apt install tdlr -y 
tldr --update 
tldr docker 
tdlr tree 

man # manual 

```


## For reading and writing file s

```bash 
cd # change directory 
mkdir demo-folder 
cd demo-folder 
touch demo.conf # create a file 
more demo.conf # read file in progress mode 
cat demo.conf # read all content 
less demo.conf 
head demo.conf 
tail demo.conf 


vim demo.conf 
# press "i" -> insert ( for writing the data )
# press "esc" -> type " :wq " + enter ( save and exit )


nano demo.conf 
# Control + O : write 
# Control + X : exit 
```



### SETUP OMZ 
> Goals: userfriedly terminal setup 
- syntax hightlighting 
- autosuggestion 

```bash 
sudo apt install zsh -y
# installing the omz for the ubuntu
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting


# when working with shell 
# .bashrc -> configuration for bash shell 
# .zshrc -> configuration for z shell 
vim ~/.zshrc
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)


```

### basic 

```bash 
sudo snap install tldr 
cd folder_name 
cd .. # move out from the folder 
cd # move to the user's home directory 

mkdir folder_name
touch config.conf
vim filename.md 

# read file 
cat 
more 
less 
head 
tail 

# list all users 
sudo cat /etc/passwd 
sudo more /etc/passwd

# views logs / errors 
sudo head /etc/passwd 
sudo tail /etc/passwd
sudo head -n 5 /etc/passwd 
# sudo awk , sed 

# sudo apt install vim -y 
vim 
sudo vim filename.txt 
# when you forgot the sudo prefix after edit the content
:w !sudo tee %


nano 
# Ctrl + O + Enter key = WRite 
# Ctrl + X = Exit 



mv <source> <dest> 
rm -rf [folder|file]
rmdir # delete directory 
rm # delete file 
rm -f # force delete file 

cp <source> <dest> 
# copy the whole folder , and store it inside dest 
cp -r <folder> <dest> 
cp -r --verbose <folder> <dest> 


curl wttr.in 
sudo apt install nginx -y 
curl localhost:80 


df -h # disk usage 
free -h # to view ram 
htop # view process / resource (cpu, ram, running tasks)
ps aux 
```


## Service related command 
```bash 
service service-name <verb> 
service nginx status 


systemctl <verb> service-name 
systemctl status nginx 
systemctl restart nginx 
systemctl start nginx 
systemctl stop nginx 
systemctl enable nginx # auto-start the service 

# to stoop nginx service 
sudo systemctl disable nginx 
sudo systemctl stop nginx 
curl localhost 
sudo systemctl start nginx 
curl localhost 
```



### User Management 
1. Creating and switching the users 
```bash 
useradd # normaly used in script 
sudo useradd batman 
# customize user a little bit more 
sudo useradd --create-home --shell /bin/bash batman


adduser # utilities command: provide more user-friendly usage 
sudo adduser superman 


# Switch account to perform different tasks 
su 

# keep the current directory , only change user account
su username 
# fresh , full logoin ( start the user dir )
su - username 
whoami # show the current login user 

# sudoer change the password for other user 
sudo passwd username 
# if user need to change thier own pass 
passwd 
```
2. Deleting user and backing up data 
```bash 
sudo deluser <username> 

# deep clean 
sudo deluser --remove-all-files username 
sudo deluser --remove-home username # /home/username

# delete the user , but also backup their data 
sudo deluser \
    --backup-to /home/vagrant \
    --remove-home superman



# User Modification 
# can be use to change id , username 

# add user to specific group 
usermod -aG <group> <user> 

sudo usermod -aG sudo superman 
sudo usermod -aG docker vagrant 
sudo usermod -aG docker $(USER)




# for working with group 
groupadd 
groupmod 
delgroup 

# list to see permission and ownership 
ls -lrt 
ll 
# link 


~ = /home/vagrant 
cd ~/folderA   = cd /home/vagrant/folderA 

.
├── folderA
│   ├── configuration.txt
│   ├── getting-started.md
│   └── sample.conf
├── folderB
│   ├── configuration.txt
│   ├── getting-started.md
│   └── sample.conf -> /home/vagrant/1.basic-server/folderA/sample.conf
└── getting-started.md

ln -s  ~/1.basic-server/folderA/sample.conf ~/1.basic-server/folderB



# script-demo.sh
# 7=rwx -> user 
# 6=rw- -> group
# 4=r-- -> other
echo "hello world" 
chmod 777 script-demo.sh
chmod 764 script-demo.sh 
chmod u=rwx,g-x,o=r script-demo.sh 


# change ownership 
# change user ownship 
sudo chown user: script-demo.sh 
# change group ownership 
sudo chown :group script-demo.sh 
# change user and group 
sudo chown user:group script-demo.sh 
sudo chown -R user:group folder/ 
```

RBAC -> kubernetes  

## Next session 
- Cusotmize the privilege of sudoers user 
- for specific script required sudo , for userA , no need to ask for sudo password 


```bash 
sudo useradd --create-home \
    --shell /bin/bash superman

# change password for user superman 
sudo passwd superman 
sudo su - superman
su - superman # need to type password

# add user to specfic group 
sudo usermod -aG sudo superman 
# id , group ->  superman will sudo member 

sudo command # system will projmt for password to run command

sudo usermod -aG <group> <username> 
sudo usermod -aG group $USER 



# user : vagrant 
sudo visudo # to open the sudo configuration file 
# to save the documents 
# Ctrl+ O + Enter 
# Ctrl + x 

superman ALL=(ALL:ALL) NOPASSWD:ALL
# superman can run as all user and all group 
# and able to run any command without any password
 ```
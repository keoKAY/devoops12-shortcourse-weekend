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
```bash 
useradd # normaly used in script 
sudo useradd batman 
# customize user a little bit more 
sudo adduser --create-home --shell /bin/bash batman


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
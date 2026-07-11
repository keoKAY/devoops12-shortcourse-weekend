


Automate tasks on linux server 
1. Shellscripts 
    - collection of commands
    - programming language features 
        - condition , variables, functions , loop...
2. Ansible ( playbook )



echo "hello world" > file-demo.txt 

> overwrite file 
>> append file 

```bash
# overwrite 
echo "Hello World " > file-demo.txt 
more file-demo.txt 

# append the text 
echo "Testing Testing" >> file-demo.txt 
more file-demo.txt 

# if the command success , output will be sore inside succes.log 

# if the command failed, output store inside error.log
date 1>succes.log 2>error.log 
date &> app.log 

date 
echo $? # check the status code of program or command
```

+ Chaining commands 

```bash
neofetch; nginx -v ; docker -v; curl localhost:80;  
nginx -v ; docker -v # all commands will run and are not related to each other 

nginx -v && docker -v
docker -v && nginx -v  
# if the first command work, the second command will be executed

# blackhole = /dev/null 
# &>/dev/null used to ignore the output (hide it)
date &> /dev/null

# ensure that the nginx exist before running nginx-v 
which nginx &>/dev/null && nginx -v 
# second command will work , if first command failed
which docker &>/dev/null || nginx -v  
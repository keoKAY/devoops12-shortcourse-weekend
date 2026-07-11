


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



File Descriptor 

Chaining Commands 
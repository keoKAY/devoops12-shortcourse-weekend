#!/bin/bash 

baseDir="/home/vagrant/shellscripts"

echo "1. generate text block " 
echo """ 
this iss the sample configuration 
for your application 
config 

""" | tee -a ${baseDir}/sample-config.conf



echo "2. Writing text block version 2 " 
cat << EOF > ${baseDir}/sample-config2.conf

this is another confniguration 
this the application directory 
EOF



tee ${baseDir}/sample-config3.conf > /dev/null << EOF
This is first line.
This is second line.
This is third line.
Lastest updates 
EOF

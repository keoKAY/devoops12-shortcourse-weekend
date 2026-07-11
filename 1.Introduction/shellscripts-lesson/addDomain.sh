#!/bin/bash 

# bash addDomain.sh "reactjs.dev" 3000 

domainName="$1"
portNumber=$2

# validate the value of domain name and port 

# 10th parameter ${10}
echo "Filename is : $0" 
baseDir="/home/vagrant/shellscripts/nginx-config"

echo "1. Generating config at ${baseDir}..." 

tee ${baseDir}/${domainName}.conf > /dev/null << EOF
server {
    listen 80;
    server_name ${domainName}; # Your public domain or IP address

    location / {
        # The internal backend application server (NodeJS, Python, Go, Docker container, etc.)
        proxy_pass http://127.0.0.1:${portNumber}; 

        # Pass essential headers so the backend knows the real client details
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}

EOF
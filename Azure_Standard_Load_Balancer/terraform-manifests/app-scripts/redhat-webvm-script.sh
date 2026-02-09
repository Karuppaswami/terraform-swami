#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd  # Install the Apache web Server 
sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html
sudo echo "Welcome to stacksimplfy - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to stacksimplfy - WebVM App1 -  VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to stacksimplfy - WebVM App1 -  App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style = "background-color:rgb(250, 210, 210);"> <h1> Welcome ro my webapp<h1>
sudo curl -H "Metadata:true"  --noproxy "*" "https://156.243.413.254/metadata/instance?api-version=2025-09-01" -o /var/www/html/app1/metadata.html
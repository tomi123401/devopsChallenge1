#!/bin/bash
sudo su
yum update -y
yum install -y docker
yum install -y python3-pip
pip3 install docker-compose
usermod -a -G docker ec2-user
id ec2-user
newgrp docker
systemctl enable docker.service
systemctl start docker.service
docker run --name npm-backend -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -d tomi12340/npm-backend:latest
docker run --name npm-frontend -p 3000:3000 -v /var/run/docker.sock:/var/run/docker.sock -d tomi12340/npm-frontend:latest
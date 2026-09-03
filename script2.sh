#!/bin/bash

set -e

echo "=============================="
echo " Jenkins WAR Auto Setup Script"
echo "=============================="

# Update system
sudo apt update -y

# Install Java 21, wget, curl
sudo apt install -y openjdk-21-jdk wget curl

# Verify Java
java -version

# Create Jenkins directory
sudo mkdir -p /opt/jenkins
cd /opt/jenkins

# Download Jenkins WAR
if [ ! -f jenkins.war ]; then
  echo "Downloading Jenkins WAR..."
  wget https://get.jenkins.io/war/2.552/jenkins.war
else
  echo "Jenkins WAR already exists"
fi

# Permissions
sudo chmod 755 jenkins.war

# Run Jenkins in background
echo "Starting Jenkins in background..."
nohup java -Djava.net.preferIPv4Stack=true -jar /opt/jenkins/jenkins.war \
> /opt/jenkins/jenkins.log 2>&1 &

sleep 5

# Show status
echo "Jenkins process:"
ps -ef | grep jenkins.war | grep -v grep

echo "=============================="
echo " Jenkins started successfully "
echo " URL: http://<SERVER-IP>:8080"
echo " Log: /opt/jenkins/jenkins.log"
echo "=============================="

#install docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker ubuntu
newgrp docker

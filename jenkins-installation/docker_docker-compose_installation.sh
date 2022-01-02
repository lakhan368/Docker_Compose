#!/bin/bash

printf  "\n\n*******Docker and Docker-Compose installation started.***********\n\n"

if which docker
    then
    printf "\n\nDocker already installed...Skipping\n\n"
else
    #Docker installation process begin
    sudo apt-get remove docker docker-engine docker.io containerd runc -y
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates  curl gnupg-agent software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
fi

#start and enable docker daemon
systemctl start docker
systemctl enable docker
docker version


printf  "\n\n********Docker installation Completed********\n\n"
printf "\n\n********Docker-Compose installation********\n\n"

if which docker-compose
  then
    printf "\n\n  Docker-compose already installed\n\n"
else
  curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

printf  "\n\n*******Docker and Docker-Compose installation completed.***********\n\n"

mkdir jenkins-data


export Jenkins_IMAGE=jenkins/jenkins:lts

VOLUME="$PWD/jenkins_data"
export VOLUME
echo $VOLUME


docker-compose up -d

sleep 10
printf  "\n\n"

docker exec jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword

printf  "\n\n*******Unlock jenkins with above password on http://ip:8080***********\n\n"

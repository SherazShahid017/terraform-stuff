#!/bin/bash

# install ansible
git clone install scripts
cd installscripts/
./ansible-install
rm -rf installscripts/

#install my ansible files and run them
git clone ansible-files
cd ansible-files/
ansible-playbook -i inventory.conf playbook.yaml

# install nginx
#apt-get update
#apt-get -y install nginx

# make sure nginx is started
#service nginx start
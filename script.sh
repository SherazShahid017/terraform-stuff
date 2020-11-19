#!/bin/bash

#Installing pip and ansible
sudo apt-get update
sudo apt install python3-pip -y
sudo apt install python-pip -y
sudo apt install ansible -y

# install ansible
#git clone https://github.com/LukeBenson/install-scripts.git
#cd install-scripts/
#./ansible-install.sh
#cd ~
#rm -rf install-scripts/

#install my ansible files
git clone https://github.com/SherazShahid017/ansible-files.git
cd ansible-files/

#set the local-ip variable to the ec2-ip output
#export localip=${terraform output ec2-ip}
ansible-playbook -i inventory.conf playbook.yaml



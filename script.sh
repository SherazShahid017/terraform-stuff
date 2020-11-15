#!/bin/bash

# install ansible
git clone https://github.com/LukeBenson/install-scripts.git
cd install-scripts/
./ansible-install
rm -rf install-scripts/

#install my ansible files
git clone https://github.com/SherazShahid017/ansible-files.git
cd ansible-files/

#set the local-ip variable to the ec2-ip output
local-ip=${terraform output ec2-ip}
ansible-playbook -i inventory.conf playbook.yaml

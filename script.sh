#!/bin/bash

#Installing pip and python
sudo apt-get update
sudo apt install python3
sudo apt install python3-pip
sudo apt install pip

# install ansible
#git clone https://github.com/LukeBenson/install-scripts.git
#cd install-scripts/
#./ansible-install.sh
#cd ~
#rm -rf install-scripts/

mkdir -p ~/.local/bin
echo 'PATH=$PATH:~/.local/bin' >> ~/.bashrc
source ~/.bashrc
pip install --user ansible -y

#install my ansible files
git clone https://github.com/SherazShahid017/ansible-files.git
cd ansible-files/

#set the local-ip variable to the ec2-ip output
export localip=${terraform output ec2-ip}
ansible-playbook -i inventory.conf playbook.yaml

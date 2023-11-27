#!/bin/bash

sudo apt update

#install docker
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose unzip

sudo usermod -aG docker ubuntu

#ansible conf pour ne pas check les clés ssh ( known_hosts ) plus besoin car clés ssh ok
#echo "[defaults]
#host_key_checking = False" > ./ansible-conf/ansible.cfg

#création des key pour les communications ssh entre ansbile et les autres conteneurs 
ssh-keygen -t rsa -b 4096 -C "ansiblelab" -f ./ansible-img/ubuntu_22_04_ansible/ssh_key/id_rsa -q -N ""
sleep 3s
cp ./ansible-img/ubuntu_22_04_ansible/ssh_key/id_rsa.pub ./ansible-img/ubuntu_22_04_custom/ssh_key/id_rsa.pub

chmod 400 ./ansible-img/ubuntu_22_04_ansible/ssh_key/id_rsa
chmod 400 ./ansible-img/ubuntu_22_04_custom/ssh_key/id_rsa.pub

sudo docker build -t lab_ubuntu_22_04:1.0 ./ansible-img/ubuntu_22_04_custom
sudo docker build -t lab_ubuntu_22_04_ansible:1.0 ./ansible-img/ubuntu_22_04_ansible

sudo docker-compose up -d

sudo docker ps -a

# docker_inventory.sh
echo '{"all": {"hosts": {'$(docker ps --format '{{.Names}}' | xargs -I {} docker inspect --format '"{}": {"ansible_host": "{{.NetworkSettings.Networks.ubuntu_default.IPAddress}}", "ansible_user": "root"}' {} | sed ':a;N;$!ba;s/\n/, /g')'}}, "children": {"ungrouped": {"hosts": {}}}}' > ./ansible-conf/hosts/inventory.yml



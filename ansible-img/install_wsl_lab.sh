sudo apt update

#install docker
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose

sudo usermod -aG docker ubuntu

mkdir -p ansible-img/ubuntu_22_04_custom/ssh_key
mkdir -p ansible-img/ubuntu_22_04_ansible/ssh_key

mkdir ansible-conf

#ansible conf pour ne pas check les clés ssh ( known_hosts )
#echo "[defaults]
#host_key_checking = False" > ./ansible-conf/ansible.cfg

#création des key pour les communications ssh entre ansbile et les autres conteneurs 
ssh-keygen -t rsa -b 4096 -C "ansiblelab" -f ./ansible-img/ubuntu_22_04_ansible/ssh_key/id_rsa -q -N ""
cp ./ansible-img/ubuntu_22_04_ansible/ssh_key/id_rsa.pud ./ubuntu_22_04_custom/ssh_key/id_rsa.pud && rm ./ansible-img/ubuntu_22_04_ansible/ssh_key/id_rsa.pud

chmod 400 ./ansible-img/ubuntu_22_04_ansible/ssh_key/id_rsa
chmod 400 ./ansible-img/ubuntu_22_04_custom/ssh_key/id_rsa.pud

sudo docker build -t lab_ubuntu_22_04:1.0 ./ansible-img/ubuntu_22_04_custom
sudo docker build -t lab_ubuntu_22_04_ansible:1.0 ./ansible-img/ubuntu_22_04_ansible

docker-compose up -d
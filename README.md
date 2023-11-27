# Labs Ansible

Labs utilisant Ansible, Nginx sur Docker dans WSL ubuntu 22.04.

## PowerShell

### Installation WSL

```bash
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
wsl.exe --update
wsl --install --distribution Ubuntu-22.04
```

### Réinitialisation de l'instance Ubuntu dans WSL
```bash
wsl -l
wsl --terminate Ubuntu-22.04
wsl --unregister Ubuntu-22.04
wsl --install --distribution Ubuntu-22.04
#Créer un utilisateur "ubuntu"
```

## Ubuntu
### Lancement du script d'installation
```bash
sudo apt-get update || true
sudo apt-get install -y unzip
curl -L "https://github.com/UnknownAtoms/labs-ansible/archive/master.zip" -o "/home/ubuntu/labs-ansible.zip" && unzip "/home/ubuntu/labs-ansible.zip" -d /home/ubuntu/
rm "/home/ubuntu/labs-ansible.zip"
cp -r ./labs-ansible-main/* ./
rm -rf ./labs-ansible-main/
chmod 755 ./install_wsl_lab.sh
./install_wsl_lab.sh
```

### Connexions au conteneurs
```bash
docker exec -it ubuntu_ansible_1 bash
docker exec -it ubuntu_ubuntu_1 bash
docker exec -it ubuntu_lb_1 bash
```

## Conteneur ubuntu_ansible_1
```bash
ansible all -i 172.19.0.3, -m ping

ansible-playbook -i inventory.yml ping.yml

```
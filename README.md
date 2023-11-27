# Labs Ansible

Ce projet vise à fournir des scripts pour la configuration d'environnements de laboratoire utilisant Ansible, Nginx, et Rancher 2 sur Docker.

## PowerShell
### Réinitialisation de l'instance Ubuntu dans WSL
```bash
wsl -l
wsl --terminate Ubuntu-22.04
wsl --unregister Ubuntu-22.04
wsl --install --distribution Ubuntu-22.04
```
## Ubuntu
### lancer le script
```bash
chmod 755 ./install_wsl_lab.sh
./install_wsl_lab.sh
```
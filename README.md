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
```

## Ubuntu
### Copiez le script dans le /home/ubuntu de votre user ubuntu & lancer le script
```bash
chmod 755 ./install_wsl_lab.sh
./install_wsl_lab.sh
```
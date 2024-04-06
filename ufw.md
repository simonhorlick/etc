# ufw configuration

```bash
sudo apt install ufw
```

```bash
sudo ufw default allow incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
```

```bash
sudo ufw logging medium
sudo ufw status verbose
```

## samba

```bash
sudo ufw allow from 192.168.0.0/24 to any app Samba comment 'passing samba from local'
#sudo ufw allow from fe80::/64 to any app Samba comment 'passing samba from link-local'
sudo ufw allow from fd7a:115c:a1e0:ab12:4843:cd96:625f:8431 to any app Samba comment 'passing samba from tailscale'
sudo ufw deny to any app Samba comment 'fallthrough to deny samba'
```

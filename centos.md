# Installation CentOs 7

## <a name="sudo"></a> sudo

```bash
sudo pip install ;
```

## <a name="Fail2Ban"></a> Fail2Ban

### Settings for Fail2Ban
```bash
yum install epel-release ;
yum install fail2ban fail2ban-systemd ;
yum update -y selinux-policy* ;
cp -pf /etc/fail2ban/jail.conf /etc/fail2ban/jail.local ;
vi /etc/fail2ban/jail.local ;
```

### Protection SSH
```bash
/etc/fail2ban/jail.d/sshd.local ;
```

> [sshd] \
  enabled = true \
  port = ssh \
  #action = firewallcmd-ipset \
  logpath = %(sshd_log)s \
  maxretry = 5 \
  bantime = 86400 \

### Activation
```bash
systemctl enable firewalld ;
systemctl start firewalld ;
systemctl enable fail2ban ;
systemctl start fail2ban ;
```

### Commandes utiles
#### Voir les tentatives d'accès
```bash
cat /var/log/secure | grep 'Failed password'
```
#### Voir les IP bannies
```bash
iptables -L -n
fail2ban-client status
```
#### Status de Fail2ban
```bash
fail2ban-client status
```
#### Réhabiliter une IP
```bash
fail2ban-client set sshd unbanip IPADDRESS
```
***
#### Sources
https://www.howtoforge.com/tutorial/how-to-install-fail2ban-on-centos/


## <a name="Docker"></a> Docker

### Settings for Fail2Ban
```bash
sudo yum check-update ;
curl -fsSL https://get.docker.com/ | sh ;
sudo systemctl start docker ;
sudo systemctl status docker ;
sudo systemctl enable docker ;
sudo usermod -aG docker $(whoami) ;
sudo service docker restart ;

sudo yum install epel-release ;
sudo yum install -y python-pip ;
sudo pip install docker-compose ;
sudo yum upgrade python* ;
```
#### Sources
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-centos-7
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-centos-7

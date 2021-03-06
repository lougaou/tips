# Installation CentOs 7

## SSH
```bash
ssh-keygen -t rsa -b 4096 -C "email@gmail.com"
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | ssh USER@SERVER_IP "cat - >> ~/.ssh/authorized_keys"
```
### /etc/ssh/sshd_config
> PermitRootLogin no

```bash
service sshd restart
```
#### Sources
https://wiki.centos.org/HowTos/Network/SecuringSSH

## <a name="sudo"></a> sudo

```bash
sudo visudo
```

> USER ALL=(ALL) NOPASSWD:ALL


## <a name="Fail2Ban"></a> fail2Ban

### Settings for fail2Ban
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
#### Sources
https://www.howtoforge.com/tutorial/how-to-install-fail2ban-on-centos/


## <a name="Docker"></a> Docker

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

mkdir -p /home/lougaou/dockers/scripts ;
mkdir -p /home/lougaou/dockers/data ;
```
#### Sources
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-centos-7
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-centos-7

## <a name="Owncloud"></a> Owncloud

```bash
mkdir -p /home/lougaou/dockers/scripts/owncloud
mkdir -p /home/lougaou/dockers/data/owncloud/data/certs
```

### docker-compose.yml
```bash
cd /home/lougaou/dockers/scripts/owncloud
vi docker-compose.yml
```
```yaml
  db: 
    image: webhippie/mariadb
    labels:
      - traefik.enable=false
    environment:
      - MARIADB_ROOT_PASSWORD=owncloud
      - MARIADB_USERNAME=<CHANGE>
      - MARIADB_PASSWORD=<CHANGE>
      - MARIADB_DATABASE=owncloud
    volumes:
      - ../../data/owncloud/mysql:/var/lib/mysql:z

  redis:
    image: webhippie/redis
    labels:
      - traefik.enable=false

  owncloud:
    image: owncloud/server:10.0.0
    ports:
      - 443:443
      - 80:80
    links:
      - db
      - redis
    labels:
      - traefik.port=80
      - traefik.frontend.passHostHeader=true
    environment:
      - OWNCLOUD_DOMAIN=cloud.gainsbourg.net
      - OWNCLOUD_DB_TYPE=mysql
      - OWNCLOUD_DB_NAME=owncloud
      - OWNCLOUD_DB_USERNAME=<CHANGE>
      - OWNCLOUD_DB_PASSWORD=<CHANGE>
      - OWNCLOUD_DB_HOST=db
      - OWNCLOUD_ADMIN_USERNAME=<CHANGE>
      - OWNCLOUD_ADMIN_PASSWORD=<CHANGE>
      - OWNCLOUD_REDIS_ENABLED=true
      - OWNCLOUD_REDIS_HOST=redis
    volumes:
      - ../../data/owncloud/data:/mnt/data:z
```

https://hub.docker.com/r/owncloud/server/

## <a name="Certificats"></a> Certificats

### Firewall
```bash
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
sudo firewall-cmd --reload
```

### Installation
```bash
sudo yum install git ;
sudo git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt ;
sudo cd /opt/letsencrypt ;
sudo ./letsencrypt-auto --agree-tos --renew-by-default --standalone --preferred-challenges http-01 --http-01-port 80 certonly -d gainsbourg.net -d www.gainsbourg.net -d images.gainsbourg.net -d api.gainsbourg.net -d genealogie.gainsbourg.net -d cloud.gainsbourg.net --email letsencrypt@gainsbourg.net ;
sudo cp /etc/letsencrypt/live/gainsbourg.net/cert.pem /home/xav/docker/confs/traefik/certificates/traefik.crt ;
sudo cp /etc/letsencrypt/live/gainsbourg.net/privkey.pem /home/xav/docker/confs/traefik/certificates/traefik.key ;
```
https://www.ssllabs.com/ssltest/

#### Sources
https://www.linode.com/docs/security/ssl/install-lets-encrypt-to-create-ssl-certificates

## Maltrail
```bash
sudo yum install git
sudo yum install pcapy
git clone https://github.com/stamparm/maltrail.git
cd maltrail
sudo python sensor.py
```

### maltrail.conf
http://www.xorbin.com/tools/sha256-hash-calculator

> USERS \
    xav:9C85FE7B3420A3B56B2CCD02C4B874F1B71DA6BC092EBE32CDCBC73A6F8179CB:0:0.0.0.0/0 \
  \#   admin:9ab3cd9d67bf49d01f6a2e33d0bd9bc804ddbe6ce1ff5d219c42624851db5dbc:0:0.0.0.0/0  \

```bash
sudo firewall-cmd --zone=public --add-port=8338/tcp --permanent
sudo firewall-cmd --reload
```

### Start
```bash
sudo python sensor.py & ;
nohup python server.py &
```
http://163.172.36.115:8338/

### Stop
```bash
sudo pkill -f sensor.py
pkill -f server.py
```

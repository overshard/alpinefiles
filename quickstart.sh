#!/bin/sh
#
# quickstart.sh
# v. 2022.07.27
#
# I don't recommend running this script on your server without modifying it to
# suit your needs.

# Install dependencies
apk update
apk upgrade
apk add \
    neovim \
    curl \
    rsync \
    git \
    ip6tables \
    iptables \
    ufw \
    borgbackup \
    docker\
    docker-compose \
    caddy

# Configure firewall
ufw allow from 192.230.176.0/20 proto tcp to any port 22
ufw allow 80/tcp
ufw allow 80/udp  # for http3
ufw allow 443/tcp
ufw allow 443/udp  # for http3
ufw --force enable

# Download configuration files
curl -o- https://raw.githubusercontent.com/overshard/alpinefiles/master/etc/apk/repositories \
    | tee /etc/apk/repositories && chmod 644 /etc/apk/repositories
curl -o- https://raw.githubusercontent.com/overshard/alpinefiles/master/etc/periodic/daily/apk-autoupgrade \
    | tee /etc/periodic/daily/apk-autoupgrade && chmod 700 /etc/periodic/daily/apk-autoupgrade
curl -o- https://raw.githubusercontent.com/overshard/alpinefiles/master/etc/periodic/daily/borg-autobackup \
    | tee /etc/periodic/daily/borg-autobackup && chmod 700 /etc/periodic/daily/borg-autobackup
curl -o- https://raw.githubusercontent.com/overshard/alpinefiles/master/root/server-health-check.sh \
    | tee /root/server-health-check.sh && chmod 700 /root/server-health-check.sh

# Create important directories
mkdir /srv/git && mkdir /srv/docker && mkdir /srv/data && mkdir /srv/backup

# Initiate borg backups
borg init -e none /srv/backup

# Start services and add to startup
rc-update add ufw boot && rc-service ufw start
rc-update add docker boot && rc-service docker start
rc-update add caddy boot && rc-service caddy start

#!/bin/sh

echo -e "\napk upgrades ------------------------------------------------------------------"
tail /var/log/apk-autoupgrade.log

echo -e "\nborg backups ------------------------------------------------------------------"
borg info /srv/backup/ | tail -n5 | head -n3
borg list /srv/backup

echo -e "\nfree memory  ------------------------------------------------------------------"
free -h | head -n2

echo -e "\nfree space   ------------------------------------------------------------------"
df -h | head -n1 && df -h | grep "/dev/sda" | head -n1

echo -e "\ncontainer stats ---------------------------------------------------------------"
docker ps -q | xargs docker stats --no-stream

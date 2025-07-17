#!/bin/sh
set -x

mkdir -p /var/run/vsftpd/empty
chown root:root /var/run/vsftpd/empty

useradd -u 33 -o -m $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

exec /usr/sbin/vsftpd /etc/vsftpd.conf

#!/bin/sh
set -x

mkdir -p /var/run/vsftpd/empty
chown root:root /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

useradd -m $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

mkdir -p /home/$FTP_USER/ftp
chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp
chmod 755 /home/$FTP_USER/ftp

mkdir -p /home/$FTP_USER/ftp/wordpress
mount --bind /var/www/html /home/$FTP_USER/ftp/wordpress
chown -R $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/wordpress

exec /usr/sbin/vsftpd /etc/vsftpd.conf

#!/bin/sh
echo ApacheHTTPD----------------------------------------------------------------------

yum install -y apr-devel apr-util-devel pcre-devel
cp /vagrant_data/httpd-2.4.35.tar.gz ~/

export VHTTPD_PKG=httpd-2.4.35
export VHTTPD_HOME=/usr/local/apache2
#export VHTTPD_PREFIX=

#useradd -s /sbin/nologin apache

cd ~/
tar -xzvf ~/$VHTTPD_PKG.tar.gz
cd $VHTTPD_PKG
./configure
make
make install
cd ~/
#chown -R apache:apache $VHTTPD_HOME

cat <<HTTPDSERVICE > /etc/systemd/system/httpd.service
[Unit]
Description=Apache httpd
After=network.target

[Service]
#User=apache
#Group=apache
Type=forking
#PIDFile=$VHTTPD_HOME/httpd.pid
#RemainAfterExit=yes

ExecStart=$VHTTPD_HOME/bin/apachectl -k start
ExecStop=$VHTTPD_HOME/bin/apachectl -k stop
ExecReStart=$VHTTPD_HOME/bin/apachectl graceful

[Install]
WantedBy=multi-user.target
HTTPDSERVICE

chmod 755 /etc/systemd/system/httpd.service
systemctl enable httpd

rm -rf ~/$VHTTPD_PKG
echo End!
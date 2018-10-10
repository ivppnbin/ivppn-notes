#!/bin/sh
echo OracleXE----------------------------------------------------------------------

yum install -y glibc make gcc binutils libaio libaio-devel bc unzip
cp /vagrant_data/oracle-xe-11.2.0-1.0.x86_64.rpm.zip ~/

export VORACLE_PKG=oracle-xe-11.2.0-1.0.x86_64
export VORACLE_HOME=

cd ~/
tar -xzvf ~/$VHTTPD_PKG.tar.gz
cd $VHTTPD_PKG
./configure
make
make install
cd ~/


chmod 755 /etc/systemd/system/httpd.service
systemctl enable httpd

rm -rf ~/$VHTTPD_PKG
echo End!
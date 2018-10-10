#!/bin/sh
echo Tomcat----------------------------------------------------------------------

yum install -y java-1.8.0-openjdk
cp /vagrant_data/apache-tomcat-8.0.53.tar.gz ~/

export VTOMCAT_PKG=apache-tomcat-8.0.53
export VTOMCAT_HOME=/opt/$VTOMCAT_PKG

useradd -s /sbin/nologin tomcat
cd ~/
tar -xzvf ~/$VTOMCAT_PKG.tar.gz
mv ~/$VTOMCAT_PKG /opt
chown -R tomcat:tomcat $VTOMCAT_HOME

cat <<TOMCATSERVICE > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat 8
After=network.target

[Service]
User=tomcat
Group=tomcat
Type=oneshot
PIDFile=$VTOMCAT_HOME/tomcat.pid
RemainAfterExit=yes

ExecStart=$VTOMCAT_HOME/bin/startup.sh
ExecStop=$VTOMCAT_HOME/bin/shutdown.sh
ExecReStart=$VTOMCAT_HOME/bin/shutdown.sh;$VTOMCAT_HOME/bin/startup.sh

[Install]
WantedBy=multi-user.target
TOMCATSERVICE

chmod 755 /etc/systemd/system/tomcat.service
systemctl enable tomcat

echo End!
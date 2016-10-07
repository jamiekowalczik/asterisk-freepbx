#!/bin/bash
sudo setenforce 0
sudo yum update -y
sudo yum -y groupinstall core base "Development Tools"
sudo yum -y install lynx mariadb-server mariadb install mysql-connector-odbc php php-mysql php-mbstring tftp-server httpd ncurses-devel sendmail sendmail-cf sox newt-devel libxml2-devel libtiff-devel audiofile-devel gtk2-devel subversion kernel-devel git php-process crontabs cronie cronie-anacron wget vim php-xml uuid-devel sqlite-devel net-tools gnutls-devel php-pear
sudo pear install Console_Getopt
sudo yum -y install epel-release
sudo rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
sudo yum -y install ffmpeg ffmpeg-devel sox-devel lame lame-devel gstreamer* texinfo
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --reload
sudo systemctl enable mariadb.service
sudo systemctl start mariadb
sudo wget http://www.pjsip.org/release/2.4/pjproject-2.4.tar.bz2
cd /usr/src
sudo tar -xjvf pjproject-2.4.tar.bz2
sudo rm -f pjproject-2.4.tar.bz2
cd pjproject-2.4
sudo CFLAGS='-DPJ_HAS_IPV6=1' ./configure --prefix=/usr --enable-shared --disable-sound --disable-resample --disable-video --disable-opencore-amr --libdir=/usr/lib64
sudo make dep
sudo make
sudo make install
sudo ldconfig
cd /usr/src
sudo wget -O iksemel-1.4.zip https://github.com/meduketto/iksemel/archive/master.zip
sudo unzip iksemel-1.4.zip
sudo rm -rf iksemel-1.4.zip
cd iksemel*
sudo ./autogen.sh
sudo ./configure
sudo make
sudo make all
sudo make install
sudo adduser asterisk -M -c "Asterisk User"
cd /usr/src
sudo wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz
sudo wget -O jansson.tar.gz https://github.com/akheron/jansson/archive/v2.7.tar.gz
sudo tar vxfz jansson.tar.gz
sudo rm -f jansson.tar.gz
cd jansson-*
sudo autoreconf -i
sudo ./configure --libdir=/usr/lib64
sudo make
sudo make install
cd /usr/src
sudo tar xvfz asterisk-13-current.tar.gz
sudo rm -f asterisk-13-current.tar.gz
cd asterisk-*
sudo contrib/scripts/install_prereq install
sudo ./configure --libdir=/usr/lib64
sudo contrib/scripts/get_mp3_source.sh
sudo make menuselect.makeopts
sudo menuselect/menuselect --enable format_mp3
sudo sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/sysconfig/selinux
sudo sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/selinux/config
sudo make
sudo make install
sudo make config
sudo ldconfig
sudo chkconfig asterisk off
cd /var/lib/asterisk/sounds
sudo wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-wav-current.tar.gz
sudo wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-wav-current.tar.gz
sudo tar xvf asterisk-core-sounds-en-wav-current.tar.gz
sudo rm -f asterisk-core-sounds-en-wav-current.tar.gz
sudo tar xfz asterisk-extra-sounds-en-wav-current.tar.gz
sudo rm -f asterisk-extra-sounds-en-wav-current.tar.gz
sudo wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-g722-current.tar.gz
sudo wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-g722-current.tar.gz
sudo tar xfz asterisk-extra-sounds-en-g722-current.tar.gz
sudo rm -f asterisk-extra-sounds-en-g722-current.tar.gz
sudo tar xfz asterisk-core-sounds-en-g722-current.tar.gz
sudo rm -f asterisk-core-sounds-en-g722-current.tar.gz
sudo chown asterisk. /var/run/asterisk
sudo chown -R asterisk. /etc/asterisk
sudo chown -R asterisk. /var/{lib,log,spool}/asterisk
sudo chown -R asterisk. /usr/lib64/asterisk
sudo chown -R asterisk. /var/www/
cd /usr/src
sudo wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-13.0-latest.tgz
sudo tar xfz freepbx-13.0-latest.tgz
sudo rm -f freepbx-13.0-latest.tgz
cd freepbx
sudo systemctl enable asterisk.service
sudo cp /etc/init.d/asterisk /etc/init.d/asterisk.orig
sudo cp start_asterisk /etc/init.d/asterisk
sudo echo "load = cdr_adaptive_odbc.so" >> /etc/asterisk/modules.conf
sudo systemctl enable asterisk
sudo systemctl start asterisk
cd freepbx
sudo ./start_asterisk start
sudo ./install -n
sudo sed -i 's/^\(upload_max_filesize\).*/\1 = 120M/' /etc/php.ini
sudo sed -i 's/^\(post_max_size\).*/\1 = 120M/' /etc/php.ini
sudo sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/httpd/conf/httpd.conf
sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
sudo reboot

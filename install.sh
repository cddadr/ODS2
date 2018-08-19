#!/bin/sh

##################################
# ODS/2 Post-Install Procedure   #
#                                #
# https://github.com/cddadr/ODS2 #
##################################

### *** VARIABLE SECTION ***

CURRENT_PATH=`pwd`
export CURRENT_PATH

PKG_PATH=http://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`machine -a`
export PKG_PATH



### *** USER INPUT SECTION ***
echo ""
echo "********************************"
echo "* ODS/2 Post-Install Procedure *"
echo "********************************"
echo ""

echo -n "Do you also want to retrieve the ports tree? [y/n] "
read INSTALL_PORTS



### *** PACKAGE INSTALLATION SECTION ***

## First, retrieve packages requiring specific versions:
pkg_add python-2.7.14p1 rsync-3.1.3 sudo-1.8.22-gettext


## Next, prepare some package groups:

# CDE build dependencies:
CDE_DEPS="git ksh93 motif"

# System net additions:
NET_DEPS="curl"

# Media applications:
MEDIA_APPS="ffmpeg mplayer"

# Web browsers:
WEB_BROWSERS="chromium firefox-esr"


## Now, install all the package groups:
pkg_add -i $CDE_DEPS $NET_DEPS $MEDIA_APPS $WEB_BROWSERS


## Multimedia extras:
echo ""
echo "Retrieving youtube-dl:"
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl



### *** PACKAGE CONFIGURATION SECTION ***

## Post-installation configuration:

# Create symlinks to set python2.7.x as system default:
ln -sf /usr/local/bin/python2.7 /usr/local/bin/python
ln -sf /usr/local/bin/python2.7-2to3 /usr/local/bin/2to3
ln -sf /usr/local/bin/python2.7-config /usr/local/bin/python-config
ln -sf /usr/local/bin/pydoc2.7 /usr/local/bin/pydoc

# Give chromium and firefox DT-friendly symlinks:
echo '#!/bin/sh

exec chrome -incognito' > /usr/local/bin/chromium-browser
chmod +x /usr/local/bin/chromium-browser

ln -sf /usr/local/bin/firefox-esr /usr/local/bin/firefox



### *** PORTS MANAGEMENT SECTION ***

## Retrieve and unpack the ports tree:
if [ $INSTALL_PORTS = "y" ];
then
    echo ""
    echo "Retrieving the ports tree:"
    cd /usr/
    curl http://ftp.openbsd.org/pub/OpenBSD/`uname -r`/ports.tar.gz > ports.tar.gz
    echo ""
    echo "Unpacking the ports tree, this may take some time..."
    tar -zxf ports.tar.gz
    rm ports.tar.gz
    #cd $CURRENT_PATH
fi



### *** CDE MANAGEMENT SECTION ***

## Retrieve and build CDE:
mkdir -p /usr/local/src
cd /usr/local/src
git clone https://github.com/cddadr/CDE.git
cd CDE
make World
(
    cd admin/IntegTools/dbTools
    ./installCDE -s /usr/local/src/CDE
)
cd $CURRENT_PATH
cp fs/etc/rc.conf.local /etc/rc.conf.local
cp fs/etc/inetd.conf /etc/inetd.conf
cp fs/etc/rc.d/dtlogin /etc/rc.d/dtlogin

mkdir /var/spool/calendar
ln -sf /var/spool /usr/spool



###  SYSTEM FILE MANAGEMENT SECTION 

## Skeletion file management:

# Modify the defaults for new users:
cp fs/etc/skel/.profile /etc/skel/
cp fs/etc/skel/.exrc /etc/skel/
cp fs/etc/skel/.tmux.conf /etc/skel/
cp -R fs/etc/skel/.dt /etc/skel/
cp -R fs/etc/skel/.emacs.d /etc/skel/

# Modify the defaults for root:
cp fs/root/.profile /root/
cp fs/etc/skel/.exrc /root/
cp fs/etc/skel/.tmux.conf /root/
sed -i "s/6/1/g" /root/.tmux.conf


## Configuration file management:

# Increase memory limits for users:
sed -i "s/datasize-cur=512M/datasize-cur=1024M/g" /etc/login.conf
sed -i "s/datasize-max=512M/datasize-max=2048M/g" /etc/login.conf

# Add MOTD and embed the hostname:
cp fs/etc/motd /etc/motd
sed -i "s/ODS\\/2/ODS\\/2: `hostname -s`/g" /etc/motd

# Generate a configuration for adduser:
mkdir -p /export
mv /home /export
ln -sf /export/home /home
adduser -silent -config_create
sed -i "s/home = \"\/home\"/home = \"\/export\/home\"/g" /etc/adduser.conf
sed -i "s/uid_start = 1000/uid_start = 10000/g" /etc/adduser.conf


## sudo defaults management:

# Allow wheel group to admin via sudo:
echo "%wheel  ALL=(ALL) SETENV: ALL" >> /etc/sudoers


## hostname management:

# Set a hostname without the domain string:
echo `hostname -s` > /etc/myname



### *** END OF SYSTEM DEPLOYMENT PROCEDURE ***
echo "******************************************"
echo "* ODS/2 Post-Install Procedure complete. *"
echo "*                                        *"
echo "* Please reboot to activate all changes. *"
echo "******************************************"

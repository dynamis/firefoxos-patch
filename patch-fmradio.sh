#!/bin/bash

BASEDIR=$(pwd)
ADB=$BASEDIR/adb
FASTBOOT=$BASEDIR/fastboot
PATCHDIR=$BASEDIR
TEMPDIR=$BASEDIR/temp

# Gaia path for eng build
#GAIA_APP_INSTALL_PATH=/data/local/webapps
# Gaia path for user build
GAIA_APP_INSTALL_PATH=/system/b2g/webapps
SETTINGS_APP_INSTALL_PATH=$GAIA_APP_INSTALL_PATH/settings.gaiamobile.org

# temporary directory
rm -rf $TEMPDIR
mkdir -p $TEMPDIR
cd $TEMPDIR

# pull and edit config file
$ADB pull /data/local/user.js
echo "/* FM Radio band: 76M~108MHz */" >> user.js
echo "pref(\"dom.fmradio.band\", 2);" >> user.js

# Remount file systems and push to the device
$ADB shell mount -o remount rw /data
$ADB push user.js /data/local/user.js

# Reboot
echo "Please reboot the device and enjoy radio!"

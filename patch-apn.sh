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

# pull, extract and edit apn.json file
$ADB pull $SETTINGS_APP_INSTALL_PATH/application.zip
unzip application.zip shared/resources/apn.json
patch shared/resources/apn.json $PATCHDIR/apn.json.diff
zip -u application.zip shared/resources/apn.json

# Remount file systems and push to the device
$ADB shell mount -o remount rw /system
$ADB push application.zip $SETTINGS_APP_INSTALL_PATH/application.zip

# Reboot
echo "Please restart Setting apps (or reboot the device) and set up apn for your SIM!"

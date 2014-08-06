set BASEDIR=%CD%
set PATCHDIR=%BASEDIR%

rem Gaia path for eng build
rem GAIA_APP_INSTALL_PATH=/data/local/webapps
rem Gaia path for user build
set GAIA_APP_INSTALL_PATH=/system/b2g/webapps


rem pull and edit config file
adb pull /data/local/user.js
echo /* FM Radio band: 76M~108MHz */ >> user.js
echo pref("dom.fmradio.band", 2); >> user.js

rem Remount file systems and push to the device
adb shell mount -o remount rw /data
adb push user.js /data/local/user.js

rem Reboot
echo "Please reboot the device and enjoy radio!"

set BASEDIR=%CD%
set PATCHDIR=%BASEDIR%

rem Gaia path for eng build
rem GAIA_APP_INSTALL_PATH=/data/local/webapps
rem Gaia path for user build
set GAIA_APP_INSTALL_PATH=/system/b2g/webapps
set SETTINGS_APP_INSTALL_PATH=%GAIA_APP_INSTALL_PATH%/settings.gaiamobile.org

rem pull, extract and edit apn.json file
adb pull %SETTINGS_APP_INSTALL_PATH%/application.zip
unzip application.zip shared/resources/apn.json
patch shared/resources/apn.json %PATCHDIR%/apn.json.diff
copy application.zip application-updated.zip
zip -u application-updated.zip shared/resources/apn.json

rem Remount file systems and push to the device
adb shell mount -o remount rw /system
adb push application-updated.zip %SETTINGS_APP_INSTALL_PATH%/application.zip

rem Reboot
echo "Please restart Setting apps (or reboot the device) and set up apn for your SIM!"

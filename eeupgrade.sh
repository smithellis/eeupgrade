#! /bin/bash
# Automate some of the chores that go with an EE upgrade
# I'll probably use this once and then throw it away.
# Thanks, Obama.

# Got root?
if [[ $EUID -ne 0 ]]; then
	echo "This script needs to be run as root." 1>&2
	exit 1
fi

# Set the root directory - where the system folder lives
echo "Where is your installation of EE?  Give me the full file path to the directory that contains the system folder then press ENTER: "
read INSTALL_DIR

echo "Where did you put the new EE source material?  Same thing, the new EE folder that contains the new system folder...then press ENTER: "
read NEW_EE_DIR

echo "Preparing backup...."
echo $INSTALL_DIR

mv $INSTALL_DIR/admin.php $INSTALL_DIR/admin.php.script
echo "Moved admin.php to admin.php.script"

mv $INSTALL_DIR/index.php $INSTALL_DIR/index.php.script
echo "Moved index.php to index.php.script"

mv $INSTALL_DIR/system $INSTALL_DIR/system.script
echo "Moved system folder to system.script"

mv $INSTALL_DIR/themes $INSTALL_DIR/themes.script
echo "Moved themes folder to themes.script"

echo "Moving all the new stuff over from $NEW_EE_DIR"
mv $NEW_EE_DIR/admin.php $INSTALL_DIR/admin.php
echo "Installed new admin.php"

mv $NEW_EE_DIR/index.php $INSTALL_DIR/index.php
echo "Installed new index.php"

mv $NEW_EE_DIR/system $INSTALL_DIR/system
echo "Installed new system directory."

mv $NEW_EE_DIR/themes $INSTALL_DIR/themes
echo "Installed new themes directory."


echo "Ok, let's move stuff back from backup...If you were doing all this yourself, you'd want to kick a baby."
cp $INSTALL_DIR/system.script/expressionengine/config/config.php $INSTALL_DIR/system/expressionengine/config/
echo "Moved old config.php back over..."

cp $INSTALL_DIR/system.script/expressionengine/config/database.php $INSTALL_DIR/system/expressionengine/config/
echo "Moved old database.php over...."

cp -r $INSTALL_DIR/system.script/expressionengine/third_party/* $INSTALL_DIR/system/expressionengine/third_party/
echo "Moved all your third_party stuff back over..."

cp -r $INSTALL_DIR/system.script/expressionengine/templates/* $INSTALL_DIR/system/expressionengine/templates/
echo "Got your templates back over...shwew...this is exhausting."

cp -r $INSTALL_DIR/themes.script/third_party/* $INSTALL_DIR/themes/third_party/
echo "Got your third_party themes moved.  I'm so helpful!"

echo "Ok, if you have any fancy business in admin.php or index.php, you need to restore that yourself."

echo "I'm going to chmod the tarnation out of a thousand things now.  A human doing this by hand would just install Wordpress."
chmod 666 $INSTALL_DIR/system/expressionengine/config/config.php
chmod 666 $INSTALL_DIR/system/expressionengine/config/database.php
chmod 777 $INSTALL_DIR/system/expressionengine/cache
chmod 777 $INSTALL_DIR/system/expressionengine/templates
chmod 777 $INSTALL_DIR/images/avatars/uploads
chmod 777 $INSTALL_DIR/images/captchas
chmod 777 $INSTALL_DIR/images/member_photos
chmod 777 $INSTALL_DIR/images/pm_attachments
chmod 777 $INSTALL_DIR/images/signature_attachments
chmod 777 $INSTALL_DIR/images/uploads

echo "I've done what I can do, homie. Now you have to log in to the control panel and run the updater.  After that you have to delete the installer directory.  That's much easier than all this chmod and copy paste crap I just did for you.  I hope your life is better now."



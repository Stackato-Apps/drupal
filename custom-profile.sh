#!/bin/bash

# PROFILE URL (no core)
PROFILE_URL=http://ftp.drupal.org/files/projects/commerce_kickstart-7.x-1.11-no-core.tar.gz

# Then we get drupal distro files (no-core) from drupal.org
curl -sfS $PROFILE_URL | tar xzf - -C profiles
#cp -r profiles/commerce_kickstart/modules/* sites/all/modules/
#rm -rf profiles/commerce_kickstart/modules/*

if ! [ -e $STACKATO_FILESYSTEM/INSTALLED ]
  then
    echo "Installing Commerce Kickstart Drupal..."

    $STACKATO_APP_ROOT/drush/drush -r $HOME site-install commerce_kickstart -y --db-url=$DATABASE_URL --account-name=admin --account-pass=passwd --site-name=Stackato --locale=en-US

    # Drupal successfully installed
    touch $STACKATO_FILESYSTEM/INSTALLED
fi

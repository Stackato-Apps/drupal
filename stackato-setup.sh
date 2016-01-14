#!/bin/bash
#echo "This script does HPE Helion Stackato setup related to filesystem."
#echo "This script also handles Drupal Setup."

FS=$STACKATO_FILESYSTEM
SAR=$STACKATO_APP_ROOT
DRUSH=http://ftp.drupal.org/files/projects/drush-7.x-5.9.tar.gz
SMTP_MODULE=http://ftp.drupal.org/files/projects/smtp-7.x-1.2.tar.gz

if ! [ -s $HOME/index.php ]
  then
    # create folders in the shared filesystem 
    mkdir -p $FS/sites
    mkdir -p $FS/modules

    # download required files
    echo "Downloading Drush and Drupal..."
    curl -LsS $DRUSH | tar xzf -
    mv drush $SAR

    $SAR/drush/drush dl drupal --drupal-project-rename=drupal --yes
    mv drupal/* drupal/.??* .
    rmdir drupal

    echo "Downloading SMPT module..."
    curl -LsS $SMTP_MODULE | tar xzf -
    mv smtp $SAR/app/modules/smtp
fi

echo "Migrating data to shared filesystem..."
cp -r sites/* $FS/sites
cp -r modules/* $FS/modules

echo "Symlink to folders in shared filesystem..."
rm -fr sites
ln -s $FS/sites sites
rm -fr modules
ln -s $FS/modules modules

# allow custom profile installations (if exist)
if [ -s custom-profile.sh ]
  then
    bash custom-profile.sh
fi

if ! [ -e $FS/INSTALLED ]
  then
    echo "Installing Drupal..."
    $SAR/drush/drush -r $HOME site-install -y --db-url=$DATABASE_URL --account-name=admin --account-pass=passwd --site-name=MySite --locale=en-US

    echo "Installing Drupal modules..."
    $SAR/drush/drush -r $HOME dl pathauto,views --yes
    $SAR/drush/drush -r $HOME en pathauto,views_ui --yes

    # Drupal successfully installed
    touch $FS/INSTALLED
fi

echo "All Done!"

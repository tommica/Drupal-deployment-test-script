#!/bin/bash
if ! type "drush" &> /dev/null; then
  echo "$(tput setb 0) $(tput setaf 1) PLEASE INSTALL DRUSH 5+ $(tput sgr0)"
  exit 0
fi

if ! type "git" &> /dev/null; then
  echo "$(tput setb 0) $(tput setaf 1) PLEASE INSTALL GIT $(tput sgr0)"
  exit 0
fi

echo "$(tput setb 1) Grab an energy drink, this might take a while $(tput sgr0)"

wget https://raw.github.com/tommica/Drupal-deployment-test-script/master/tommi.make &&
drush make -y tommi.make &&
git clone git@github.com:tommica/Drupal-deployment-test-theme.git sites/all/themes/tommi &&
wget https://github.com/tommica/Drupal-deployment-test-features/raw/master/everything_tommidep.tar -O sites/all/modules/everything_tommidep.tar &&
tar -xvf sites/all/modules/everything_tommidep.tar &&
drush si -y standard --db-url="$1" --account-name="$2" --account-pass="$3" --site-name="$4" &&
drush dl ckeditor &&
drush dl imce &&
drush en -y ckeditor imce &&
drush ckeditor-download &&
drush pm-enable -y tommi &&
drush vset theme_default tommi &&
drush en -y everything_tommidep &&
rm -rf tommi.make profiles/tommidep sites/all/modules/everything_tommidep.tar &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/bunny-1.jpg &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/bunny-2.jpg &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/dog-1.png &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/dog-2.png &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/cat-1.jpg &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/cat-2.jpg &&
wget http://lorempixel.com/900/900/nature/ -O sites/default/files/random-1.jpg &&
wget http://lorempixel.com/900/900/nature/ -O sites/default/files/random-2.jpg

echo "$(tput setb 1) DONE $(tput sgr0)"
exit 0

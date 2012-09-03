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

git clone git@github.com:tommica/Drupal-deployment-test-features.git IMPORTDATA &&
drush make -y IMPORTDATA/tommi.make &&
git clone git@github.com:tommica/Drupal-deployment-test-theme.git sites/all/themes/tommi

FILES=IMPORTDATA/*.tar
for f in $FILES
do
  echo "$(tput setb 1) Extracting features $(tput sgr0)"
  tar -xvf $f -C sites/all/modules/ 
done


drush si -y standard --db-url="$1" --account-name="$2" --account-pass="$3" --site-name="$4" --site-mail="$5" &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/bunny-1.jpg &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/bunny-2.jpg &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/dog-1.png &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/dog-2.png &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/cat-1.jpg &&
wget http://lorempixel.com/900/900/animals/ -O sites/default/files/cat-2.jpg &&
wget http://lorempixel.com/900/900/nature/ -O sites/default/files/random-1.jpg &&
wget http://lorempixel.com/900/900/nature/ -O sites/default/files/random-2.jpg &&
drush en -y ckeditor features imce node_export &&
drush ckeditor-download &&
drush pm-enable -y tommi &&
drush en -y basic_page animal_page_taxonomies google_font image_styles ckeditor_settings animal_list_view animal_panels blocks &&
drush en -y strongarm_settings &&
drush en -y main_menu &&
drush ne-import --file=IMPORTDATA/export.xml &&
drush vset theme_default tommi &&
rm -rf IMPORTDATA

echo "$(tput setb 1) DONE $(tput sgr0)"
exit 0

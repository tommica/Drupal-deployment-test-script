Drupal-deployment-test-script
=============================

Script for deployment + makefile

Run this from the Drupal root folder (where you want to install drupal)

Please check that you have installed:

Drush 5+
Git

Usage:

wget https://raw.github.com/tommica/Drupal-deployment-test-script/master/tommidep.sh && chmod +x tommidep.sh && ./tommidep.sh "mysql://user:pass/server:port/dbname" "drupal_username" "drupal_password" "sitename" && rm tommidep.sh

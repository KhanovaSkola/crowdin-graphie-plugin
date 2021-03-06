#!/bin/bash

# Creates a zip archive that can be published in chrome:
# https://chrome.google.com/webstore/developer/dashboard

# Don't forget to bump version in manifest.json before each official publish!
version=$(grep '"version"' manifest.json | awk -F'"' '{print $4}')
browser="chrome"
REPO_NAME=crowdin-graphie-plugin
PACKAGE_NAME=${REPO_NAME}-${version}-${browser}

cd ../

rm -rf $PACKAGE_NAME.zip

if [[ -e $PACKAGE_NAME ]];then
  rm -r $PACKAGE_NAME
fi

if [[ ! -d $REPO_NAME ]];then
   echo "ERROR: Directory $REPO_NAME does not exist!"
   exit 1
fi

cp -r $REPO_NAME $PACKAGE_NAME

cd $PACKAGE_NAME
if [[ $? -ne 0 ]];then
   echo "ERROR: Could not enter dir ../$PACKAGE_NAME"
   exit 1
fi

rm -rf node_modules/ package.json package-lock.json .eslintrc .git/ *.md pack_plugin.sh LICENSE screenshot.png
zip -r $PACKAGE_NAME.zip *
mv $PACKAGE_NAME.zip ../
cd ..

rm -rf $PACKAGE_NAME

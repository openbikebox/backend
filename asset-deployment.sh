#!/usr/bin/env bash
# IMPORTANT NOTICES: Do not run this script as root. If TARGET_STATIC is misconfigured, it can try to delete your "/lib" folder.

set -e

source asset-deployment-config.sh

curl -u $GITLAB_ASSET_USER:$GITLAB_ASSET_PASSWORD $URL --output $FILE_NAME
unzip -o $FILE_NAME -d $ARTIFACT_FOLDER
rm -rf $TARGET_STATIC/js
cp -rf $ARTIFACT_FOLDER/static/js $TARGET_STATIC
rm -rf $TARGET_STATIC/css
cp -rf $ARTIFACT_FOLDER/static/css $TARGET_STATIC
rm -f $TARGET_STATIC/webpack-assets.json
cp $ARTIFACT_FOLDER/static/webpack-assets.json $TARGET_STATIC
rm -rf $ARTIFACT_FOLDER
rm $FILE_NAME
echo "Successfully updated js-folder, lib-folder and css-folder in $TARGET_STATIC directory"

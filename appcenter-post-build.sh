#!/usr/bin/env bash

# Post Build Script

set -e # Exit immediately if a command exits with a non-zero status (failure)

echo "**************************************************************************************************"
echo "Post Build Script"
echo "**************************************************************************************************"

##################################################
# Start UI Tests
##################################################

# variables
appCenterLoginApiToken=$AppCenterLoginForAutomatedUITests # this comes from the build environment variables
appName="Events"
appCenterName="dylanberry/$appName"
deviceSetName=953b7f67
testSeriesName="mytests"

cd $APPCENTER_SOURCE_DIRECTORY

xcodebuild build-for-testing \
  -configuration Debug \
  -sdk iphoneos \
  -scheme Events \
  -derivedDataPath DerivedData

echo ""
echo "Start Xamarin.UITest run"
echo "App Center Name: $appCenterName"
echo "     Device Set: $deviceSetName"
echo "    Test Series: $testSeriesName"
echo ""

echo "> Run UI test command"
# Note: must put a space after each parameter/value pair

appcenter test run xcuitest \
    --app $appCenterName \
    --devices $deviceSetName \
    --test-series $testSeriesName \
    --locale "en_US" \
    --build-dir $APPCENTER_SOURCE_DIRECTORY/DerivedData/Build/Products/Debug-iphoneos
    --token $appCenterLoginApiToken 

echo ""
echo "**************************************************************************************************"
echo "Post Build Script complete"
echo "**************************************************************************************************"
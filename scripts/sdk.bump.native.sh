#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
ROOT_DIR=$(dirname "$SCRIPT_DIR")

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {ios|android}"
    exit 1
fi

PLATFORM=$1

ANDROID_REPO_URL="https://api.github.com/repos/Giphy/giphy-android-sdk/releases/latest"
IOS_REPO_URL="https://api.github.com/repos/Giphy/giphy-ios-sdk/releases/latest"

GRADLE_FILE_PATH="$ROOT_DIR/android/build.gradle"
PODSPEC_PATH="$ROOT_DIR/ios/giphy_flutter_sdk.podspec"

get_latest_release() {
    curl -s $1 | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/' | sed 's/^[^0-9]*//' | head -1
}

update_gradle_file() {
    sed -i '' "s/implementation 'com.giphy.sdk:ui:[^']*'/implementation 'com.giphy.sdk:ui:$1'/" $GRADLE_FILE_PATH
    echo "Updated Android SDK to version $1 in build.gradle"
}

update_podspec() {
    sed -i '' -e "s/s.dependency \"Giphy\", \".*\"/s.dependency \"Giphy\", \"$1\"/" $PODSPEC_PATH
    echo "Updated iOS SDK to version $1 in Podspec"
}

case "$PLATFORM" in
    android)
        VERSION=$(get_latest_release $ANDROID_REPO_URL)
        update_gradle_file $VERSION
        ;;
    ios)
        VERSION=$(get_latest_release $IOS_REPO_URL)
        update_podspec $VERSION
        ;;
    *)
        echo "Unsupported platform: $PLATFORM"
        echo "Supported platforms: ios, android"
        exit 1
        ;;
esac

#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
ROOT_DIR=$(dirname "$SCRIPT_DIR")

CLEAN_LOCKFILES=false

usage() {
    echo "Usage: $0 [--with-lockfiles]"
    echo
    echo "Cleans generated Flutter, Gradle, CocoaPods, SwiftPM, and iOS build artifacts"
    echo "from the SDK package and example app."
    echo
    echo "Options:"
    echo "  --with-lockfiles  Also remove pubspec.lock, Podfile.lock, and Package.resolved files."
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --with-lockfiles)
            CLEAN_LOCKFILES=true
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unsupported option: $1"
            usage
            exit 1
            ;;
    esac
    shift
done

remove_path() {
    local path=$1

    if [ -e "$path" ] || [ -L "$path" ]; then
        rm -rf "$path"
        echo "Removed ${path#$ROOT_DIR/}"
    fi
}

run_flutter_clean() {
    local project_dir=$1

    if ! command -v flutter >/dev/null 2>&1; then
        echo "Skipping flutter clean in ${project_dir#$ROOT_DIR/}: flutter is not on PATH"
        return
    fi

    echo "Running flutter clean in ${project_dir#$ROOT_DIR/}"
    if ! (cd "$project_dir" && flutter clean); then
        echo "flutter clean failed in ${project_dir#$ROOT_DIR/}; continuing with manual cleanup"
    fi
}

run_gradle_clean() {
    local project_dir=$1

    if [ ! -x "$project_dir/gradlew" ]; then
        echo "Skipping Gradle clean in ${project_dir#$ROOT_DIR/}: gradlew is not executable"
        return
    fi

    echo "Running ./gradlew clean in ${project_dir#$ROOT_DIR/}"
    if ! (cd "$project_dir" && ./gradlew clean); then
        echo "./gradlew clean failed in ${project_dir#$ROOT_DIR/}; continuing with manual cleanup"
    fi
}

clean_lockfiles() {
    if [ "$CLEAN_LOCKFILES" = false ]; then
        return
    fi

    remove_path "$ROOT_DIR/pubspec.lock"
    remove_path "$ROOT_DIR/example/pubspec.lock"
    remove_path "$ROOT_DIR/example/ios/Podfile.lock"
    remove_path "$ROOT_DIR/ios/giphy_flutter_sdk/Package.resolved"
    remove_path "$ROOT_DIR/example/ios/Package.resolved"
    remove_path "$ROOT_DIR/example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved"
    remove_path "$ROOT_DIR/example/ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved"
}

echo "Cleaning SDK package and example app from $ROOT_DIR"

run_flutter_clean "$ROOT_DIR"
run_flutter_clean "$ROOT_DIR/example"

run_gradle_clean "$ROOT_DIR/example/android"

remove_path "$ROOT_DIR/.dart_tool"
remove_path "$ROOT_DIR/.flutter-plugins"
remove_path "$ROOT_DIR/.flutter-plugins-dependencies"
remove_path "$ROOT_DIR/build"
remove_path "$ROOT_DIR/android/.gradle"
remove_path "$ROOT_DIR/android/build"

remove_path "$ROOT_DIR/example/.dart_tool"
remove_path "$ROOT_DIR/example/.flutter-plugins"
remove_path "$ROOT_DIR/example/.flutter-plugins-dependencies"
remove_path "$ROOT_DIR/example/build"
remove_path "$ROOT_DIR/example/android/.gradle"
remove_path "$ROOT_DIR/example/android/build"
remove_path "$ROOT_DIR/example/android/app/build"

remove_path "$ROOT_DIR/example/ios/.symlinks"
remove_path "$ROOT_DIR/example/ios/build"
remove_path "$ROOT_DIR/example/ios/DerivedData"
remove_path "$ROOT_DIR/example/ios/Pods"
remove_path "$ROOT_DIR/example/ios/Flutter/ephemeral"
remove_path "$ROOT_DIR/example/ios/Flutter/Generated.xcconfig"
remove_path "$ROOT_DIR/example/ios/Flutter/flutter_export_environment.sh"
remove_path "$ROOT_DIR/example/ios/Flutter/App.framework"
remove_path "$ROOT_DIR/example/ios/Flutter/Flutter.framework"
remove_path "$ROOT_DIR/example/ios/Flutter/.last_build_id"

remove_path "$ROOT_DIR/ios/giphy_flutter_sdk/.build"
remove_path "$ROOT_DIR/ios/giphy_flutter_sdk/.swiftpm"
remove_path "$ROOT_DIR/example/ios/.build"
remove_path "$ROOT_DIR/example/ios/.swiftpm"
remove_path "$ROOT_DIR/example/ios/SourcePackages"

clean_lockfiles

echo "Clean complete."

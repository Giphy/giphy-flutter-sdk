#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
ROOT_DIR=$(dirname "$SCRIPT_DIR")
PUBSPEC_PATH="$ROOT_DIR/pubspec.yaml"

usage() {
    echo "Usage: $0 {patch|minor|major|x.y.z}"
}

if [ "$#" -ne 1 ]; then
    usage
    exit 1
fi

VERSION_ARG=$1
CURRENT_VERSION=$(sed -n -E 's/^version:[[:space:]]*([0-9]+\.[0-9]+\.[0-9]+)$/\1/p' "$PUBSPEC_PATH")

if [ -z "$CURRENT_VERSION" ]; then
    echo "Unable to find a semantic version in $PUBSPEC_PATH"
    exit 1
fi

IFS=. read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

case "$VERSION_ARG" in
    patch)
        PATCH=$((PATCH + 1))
        NEW_VERSION="$MAJOR.$MINOR.$PATCH"
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        NEW_VERSION="$MAJOR.$MINOR.$PATCH"
        ;;
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        NEW_VERSION="$MAJOR.$MINOR.$PATCH"
        ;;
    *)
        if [[ ! "$VERSION_ARG" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            echo "Unsupported version bump: $VERSION_ARG"
            usage
            exit 1
        fi
        NEW_VERSION="$VERSION_ARG"
        ;;
esac

sed -i '' -E "s/^version:[[:space:]]*[0-9]+\.[0-9]+\.[0-9]+$/version: $NEW_VERSION/" "$PUBSPEC_PATH"
echo "Updated Flutter package version from $CURRENT_VERSION to $NEW_VERSION"

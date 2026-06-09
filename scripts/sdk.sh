#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 {command} [additional arguments]"
    exit 1
fi

COMMAND=$1

case "$COMMAND" in
    bump)        
        if [ "$#" -gt 3 ]; then
            echo "Usage: $0 bump [ios|android|patch|minor|major|x.y.z] or $0 bump version {patch|minor|major|x.y.z}"
            exit 1
        fi

        if [ "$#" -eq 1 ]; then
            "$SCRIPT_DIR/sdk.bump.version.sh" patch
            exit 0
        fi
        
        TARGET=$2

        case "$TARGET" in
            ios|android)
                if [ "$#" -ne 2 ]; then
                    echo "Usage: $0 bump {ios|android}"
                    exit 1
                fi

                PLATFORM=$TARGET
                "$SCRIPT_DIR/sdk.bump.native.sh" "$PLATFORM"
                ;;
            version)
                if [ "$#" -ne 3 ]; then
                    echo "Usage: $0 bump version {patch|minor|major|x.y.z}"
                    exit 1
                fi

                "$SCRIPT_DIR/sdk.bump.version.sh" "$3"
                ;;
            *)
                if [ "$#" -ne 2 ]; then
                    echo "Usage: $0 bump {patch|minor|major|x.y.z}"
                    exit 1
                fi

                "$SCRIPT_DIR/sdk.bump.version.sh" "$TARGET"
                ;;
        esac
        ;;
    clean)
        shift
        "$SCRIPT_DIR/sdk.clean.sh" "$@"
        ;;
    publish)
        if [ "$#" -ne 1 ]; then
            echo "Usage: $0 publish"
            exit 1
        fi

        "$SCRIPT_DIR/sdk.publish.sh" publish
        ;;
    publish-dry-run|dry-run)
        if [ "$#" -ne 1 ]; then
            echo "Usage: $0 publish-dry-run"
            exit 1
        fi

        "$SCRIPT_DIR/sdk.publish.sh" dry-run
        ;;
    *)
        echo "Unsupported command: $COMMAND"
        echo "Available commands: bump, clean, publish-dry-run, publish"
        exit 1
        ;;
esac

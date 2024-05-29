#!/bin/bash

SCRIPT_DIR=$(dirname "$0")

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 {command} [additional arguments]"
    exit 1
fi

COMMAND=$1

case "$COMMAND" in
    bump)        
        if [ "$#" -ne 2 ]; then
            echo "Usage: $0 bump {ios|android}"
            exit 1
        fi
        
        PLATFORM=$2

        "$SCRIPT_DIR/sdk.bump.native.sh" $PLATFORM
        ;;
    *)
        echo "Unsupported command: $COMMAND"
        echo "Available commands: bump"
        exit 1
        ;;
esac

#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
ROOT_DIR=$(dirname "$SCRIPT_DIR")

usage() {
    echo "Usage: $0 {dry-run|publish}"
}

if [ "$#" -ne 1 ]; then
    usage
    exit 1
fi

COMMAND=$1

case "$COMMAND" in
    dry-run)
        (cd "$ROOT_DIR" && flutter pub publish --dry-run)
        ;;
    publish)
        (cd "$ROOT_DIR" && flutter pub publish)
        ;;
    *)
        echo "Unsupported publish command: $COMMAND"
        usage
        exit 1
        ;;
esac

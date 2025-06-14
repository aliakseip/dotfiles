#!/usr/bin/env zsh

set -euo pipefail

DOT_FILES_DIR=$(dirname $(realpath "${(%):-%x}"))

synlinkFile() {
    filename="$DOT_FILES_DIR/$1"
    destination="$HOME/$2/$1"

    mkdir -p $(dirname "$destination")

    if [ -L "$destination" ]; then
        echo "[WARN] $filename already symlinked"
        return
    fi

    if [ -e "$destination" ]; then
        echo "[FAIL] $destination exists but it's not a symlink. Please fix that manually"
        exit 1
    fi

    ln -sf "$filename" "$destination"
    echo "[ OK ] $filename -> $destination"
}

deployManifest() {
    for row in $(cat $DOT_FILES_DIR/$1); do
        if [[ "$row" =~ ^#.* ]]; then
            continue
        fi

        filename=$(echo $row | cut -d \| -f 1)
        operation=$(echo $row | cut -d \| -f 2)
        destination=$(echo $row | cut -d \| -f 3)

        case $operation in
            symlink)
                synlinkFile $filename $destination
                ;;
            *)
                echo "[WARN] Unknown operation $operation. Skipping ..."
                ;;
        esac
    done
}

if [ -z "$@" ]; then
    echo "Usage: $0 <MANIFEST>"
    echo "ERROR: no MANIFEST file is provided"
    exit 1
fi

deployManifest $1


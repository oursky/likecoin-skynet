#!/bin/bash -e
LIKED_HOME="$1"
SNAPSHOT="$2"

if [ -z "$LIKED_BINARY" ]; then
    echo "Please specify liked binary location"
    exit 1
fi

if [ -z "$LIKED_HOME" ]; then
    LIKED_HOME="$HOME/.liked"
fi

if [ -z "$SNAPSHOT" ]; then
    SNAPSHOT="$PWD/snapshot.tar.gz"
fi

if [ ! -f "$SNAPSHOT" ]; then
    echo "Snapshot not found"
    exit 1
fi

if [ -z "$SKIP_CONFIRM" ]; then
    echo "Reset current state to snapshot?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) break;;
            No ) exit;;
        esac
    done
fi

$LIKED_BINARY unsafe-reset-all
tar -xvPf $SNAPSHOT -C $LIKED_HOME


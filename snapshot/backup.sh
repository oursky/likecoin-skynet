#!/bin/bash -e
LIKED_HOME="$1"
OUTPUT="$2"

if [ -z "$LIKED_HOME"]; then
    LIKED_HOME="$HOME/.liked"
fi

if [ -z "$OUTPUT"]; then
    OUTPUT="$PWD/snapshots/snapshot.tar.gz"
elif [ -d "$OUTPUT" ]; then
    OUTPUT="$OUTPUT/snapshot.tar.gz"
fi

if [ -f "$OUTPUT" ]; then
    if [ -z "$SKIP_CONFIRM" ]; then
        echo "Snapshot already exists, overwrite?"
        select yn in "Yes" "No"; do
            case $yn in
                Yes ) rm -rf "$OUTPUT"; break;;
                No ) exit;;
            esac
        done
    fi 
fi

if [ ! -d "$LIKED_HOME/data/application.db" ] || [ ! -d "$LIKED_HOME/data/blockstore.db" ] || \
    [ ! -d "$LIKED_HOME/data/state.db" ] || [ ! -d "$LIKED_HOME/data/tx_index.db" ]; then
    echo "Data not found, is the chain initialized?"
    exit 1
fi

cd $LIKED_HOME
tar -czPf $OUTPUT --exclude=./data/priv_validator_state.json --exclude=./data/snapshots ./data/
cd -

echo "Created $OUTPUT"


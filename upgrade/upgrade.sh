#!/bin/bash -e

LIKED_REPOSITORY=oursky/likecoin-chain
COSMOVISOR_BINARY=~/cosmovisor

if [ -z "$DAEMON_NAME" ]; then
    echo "DAEMON_NAME is not set, is cosmovisor initialized?"
    exit 1
fi

if [ -z "$DAEMON_HOME" ]; then
    echo "DAEMON_HOME is not set, is cosmovisor initialized?"
    exit 1
fi

CURRENT_VERSION=`$COSMOVISOR_BINARY version 2>&1 | grep -Eo '^([0-9].[0-9].[0-9])(.*)$'`
BASE_VERSION=`echo $CURRENT_VERSION | grep -Eo '([0-9].[0-9].[0-9])'`
LATEST_VERSION=`
git -c 'versionsort.suffix=-' ls-remote \
        --exit-code --refs --sort='version:refname' \
        --tags https://github.com/$LIKED_REPOSITORY.git | \
        sed -E 's|.*refs/tags/v(.+)|\1|' | \
        grep $BASE_VERSION | \
        grep -v $CURRENT_VERSION | \
        sort -rV | \
        head -n1
`

if [ -z "$LATEST_VERSION" ]; then
    echo "No new subversion found, current: $CURRENT_VERSION, latest: $CURRENT_VERSION"
        exit 0
fi

if [[ "$LATEST_VERSION" != "$BASE_VERSION"* ]]; then
        echo "No new subversion found, current: $CURRENT_VERSION, latest: $LATEST_VERSION"
        exit 0
fi

echo "New subversion found, upgrading to $LATEST_VERSION from $CURRENT_VERSION"
BINARY_URL=https://github.com/$LIKED_REPOSITORY/releases/download/v$LATEST_VERSION/likecoin-chain_$LATEST_VERSION_$(uname -s)_$(uname -m).tar.gz

curl -sL $BINARY_URL | tar xz -C /tmp

sudo systemctl stop liked
rm $LIKED_HOME/cosmovisor/current/bin/liked
cp /tmp/bin/liked $LIKED_HOME/cosmovisor/current/bin/liked
sudo systemctl start liked

UPGRADED_VERSION=`$COSMOVISOR_BINARY version 2>&1 | grep -Eo '^([0-9].[0-9].[0-9])(.*)$'`

echo "Upgrade complete, current version: $UPGRADED_VERSION"
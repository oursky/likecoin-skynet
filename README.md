# Oursky LikeCoin Skynet

Chain ID: `likecoin-skynet-1`

## Software Version

latest release from the [Oursky repo](https://github.com/oursky/likecoin-chain/releases)

Currently skynet is set to check for minor updates every Wednesday 00:00AM HKT using cronjob, in which a new binary will be swapped when a new update is downloaded.

The script is executed with the following cron command
```
0 0 * * 3 DAEMON_NAME=liked DAEMON_HOME=~/.liked /home/likecoin/upgrade/upgrade.sh > ~/upgrade/upgrade.log 2>&1
```

The script can be located at [upgrade.sh](./upgrade/upgrade.sh)

## Backup

Prior to updates checks, a snapshot will be taken and uploaded to an azure storage managed by Oursky every Tuesday 23:00PM HKT. This is in case of any unexpected errors yieled from the binary swap so that we can rollback to the latest snapshot.

The script is executed with the following cron command
```
0 23 * * 2 make -f ~/snapshot/Makefile -C ~/snapshot backup SKIP_CONFIRM=1 > ~/snapshot/backup.log 2>&1;make -f ~/snapshot/Makefile -C ~/snapshot upload-snapshot
```

The script can be located at [backup.sh](./snapshot/backup.sh)

## Genesis

`00477f298090207c4d385919ebd4ca06755c4934893c5b57e55c5dd76bd154a5`
[`genesis.json`](./genesis.json)

https://raw.githubusercontent.com/oursky/likecoin-skynet/master/genesis.json

## Seed Nodes

```
76a756b05f8566ea3522a3e3859b962426469288@52.187.27.20:26656 // Azure
8b888351e851146140e0be98626e8f9ada805733@34.124.211.150:26656 // GCP
```

## Keplr

Navigate to the our dedicated [site](https://ipfs.io/ipfs/Qme95TC2um4cxqrS1CLxBRWA5R5snftUHEwyWNMBFrVTkb) hosted on ipfs on Google Chrome with Keplr installed

Click `Click to Add` button to add the chain via the Suggest Chain API

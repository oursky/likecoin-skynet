# Skynet Upgrade Script 

This script provides the ability to check for new liked releases from the oursky/likecoin-chain repo and proceeds to perform a quick swap 

## Automation

The following command is added to the crontab of `node-vm-skynet-azure` and `node-vm-skynet-gcp`

```
0 0 * * 3 DAEMON_NAME=liked DAEMON_HOME=~/.liked /home/likecoin/upgrade/upgrade.sh > ~/upgrade/upgrade.log 2>&1
```

The backup script runs on every Tuesday 23:00 to take a snapshot and upload to azure storage before checking for binary update 
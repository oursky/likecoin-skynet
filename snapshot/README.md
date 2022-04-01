# Skynet Snapshot Script 

This script provides the ability to take and restore snapshots, as well as the ability to upload the snapshot to the azure storage from skynet virtual machines

## Automation

The following command is added to the crontab of `node-vm-skynet-azure`

```
0 23 * * 2 make -f ~/snapshot/Makefile -C ~/snapshot backup SKIP_CONFIRM=1 > ~/snapshot/backup.log 2>&1;make -f ~/snapshot/Makefile -C ~/snapshot upload-snapshot
```

The backup script runs on every Tuesday 23:00 to take a snapshot and upload to azure storage before checking for binary update 
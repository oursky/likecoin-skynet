CWD := $(shell cd -P -- '$(shell dirname -- "$0")' && pwd -P)
SNAPSHOT_DIR ?= $(CWD)/snapshots
SNAPSHOT_FILENAME ?= snapshot.tar.gz
AZURE_STORAGE_ACCOUNT ?= likecoinskynet
AZURE_SNAPSHOT_CONTAINER ?= snapshot
SNAPSHOT_BLOB_URL ?= https://${AZURE_STORAGE_ACCOUNT}.blob.core.windows.net/${AZURE_SNAPSHOT_CONTAINER}/${SNAPSHOT_FILENAME}

LIKED_BINARY ?= liked

.PHONY: backup
backup:
	sudo systemctl stop liked
	./backup.sh "${HOME}/.liked" "${SNAPSHOT_DIR}/${SNAPSHOT_FILENAME}"
	sudo systemctl start liked

.PHONY: restore
restore:
	sudo systemctl stop liked
	${LIKED_BINARY} unsafe-reset-all
	./restore.sh "${HOME}/.liked" "${SNAPSHOT_DIR}/${SNAPSHOT_FILENAME}"
	sudo systemctl start liked


.PHONY: azcopy-login
azcopy-login:
	azcopy login --identity

.PHONY: upload-snapshot
upload-snapshot: azcopy-login
	azcopy sync "${SNAPSHOT_DIR}/${SNAPSHOT_FILENAME}" ${SNAPSHOT_BLOB_URL}

.PHONY: download-snapshot
download-snapshot: azcopy-login
	azcopy sync ${SNAPSHOT_BLOB_URL} "${SNAPSHOT_DIR}/${SNAPSHOT_FILENAME}"
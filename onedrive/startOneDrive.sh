#!/bin/bash
set -e

exec /usr/local/bin/onedrive --monitor --confdir "${CONFIG_DIR}" --syncdir "${DOCUMENT_DIR}"

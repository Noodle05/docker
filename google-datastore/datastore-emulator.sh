#!/bin/sh

exec /google-cloud-sdk/bin/gcloud beta emulators datastore start --data-dir="${DATA_DIR}" --project="${PROJECT_NAME}" --host-port "${LISTEN_HOST}":"${LISTEN_PORT}"

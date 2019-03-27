#!/bin/sh

if [[ "${WINDSCRIBE_HOSTNAME}" == "**None**" ]] || [[ -z "${WINDSCRIBE_HOSTNAME-}" ]]; then
  echo "Winscribe host not set. Exiting."
  exit 1
fi

# add Windscribe user/pass
if [[ "${WINDSCRIBE_USERNAME}" == "**None**" ]] || [[ "${WINDSCRIBE_PASSWD}" == "**None**" ]] ; then
  if [[ ! -f /config/windscribe-credentials.txt ]] ; then
    echo "Windscribe credentials not set. Exiting."
    exit 1
  fi
  echo "Found existing Windscribe credentials..."
else
  echo "Setting Windscfribe credentials..."
  mkdir -p /config
  echo "${WINDSCRIBE_USERNAME}" > /config/windscribe-credentials.txt
  echo "${WINDSCRIBE_PASSWD}" >> /config/windscribe-credentials.txt
  chmod 600 /config/windscribe-credentials.txt
fi

# add transmission credentials from env vars
echo "${TRANSMISSION_RPC_USERNAME}" > /config/transmission-credentials.txt
echo "${TRANSMISSION_RPC_PASSWORD}" >> /config/transmission-credentials.txt

dockerize -template /etc/strongswan/ipsec.conf.tmpl:/etc/ipsec.conf
dockerize -template /etc/strongswan/ipsec.secrets.tmpl:/etc/ipsec.secrets

# Persist transmission settings for use by transmission-daemon
dockerize -template /etc/transmission/environment-variables.tmpl:/etc/transmission/environment-variables.sh

TRANSMISSION_CONTROL_OPTS="--script-security 2 --up-delay --up /etc/strongswan/tunnelUp.sh --down /etc/strongswan/tunnelDown.sh"

exec ipsec start --nofork

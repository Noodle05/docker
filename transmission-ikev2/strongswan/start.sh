#!/bin/sh

if [[ "${VPN_HOSTNAME}" == "**None**" ]] || [[ -z "${VPN_HOSTNAME-}" ]]; then
  echo "VPN host not set. Exiting."
  exit 1
fi

# add vpn user/pass
if [[ "${VPN_USERNAME}" == "**None**" ]] || [[ "${VPN_PASSWD}" == "**None**" ]] ; then
  if [[ ! -f /config/vpn-credentials.txt ]] ; then
    echo "VPN credentials not set. Exiting."
    exit 1
  fi
  echo "Found existing VPN credentials..."
else
  echo "Setting VPN credentials..."
  mkdir -p /config
  echo "${VPN_USERNAME}" > /config/vpn-credentials.txt
  echo "${VPN_PASSWD}" >> /config/vpn-credentials.txt
  chmod 600 /config/vpn-credentials.txt
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

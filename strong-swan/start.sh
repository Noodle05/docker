#!/bin/bash

set -x

sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.ip_no_pmtu_disc=1

if [[ ! -f /etc/ipsec.conf ]]; then
  /usr/local/bin/dockerize -template /templates/ipsec.conf.tmpl:/etc/ipsec.conf
fi
if [[ ! -f /etc/ipsec.secrets ]]; then
  /usr/local/bin/dockerize -template /templates/ipsec.secrets.tmpl:/etc/ipsec.secrets
  chmod 600 /etc/ipsec.secrets
fi

ln -s /etc/letsencrypt/live/${VPN_DOMAIN}/chain.pem /etc/ipsec.d/cacerts/ca.pem
ln -s /etc/letsencrypt/live/${VPN_DOMAIN}/cert.pem /etc/ipsec.d/certs/certificate.pem
ln -s /etc/letsencrypt/live/${VPN_DOMAIN}/privkey.pem /etc/ipsec.d/private/key.pem

ipsec start --nofork

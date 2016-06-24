#!/bin/sh

sysctl -w net.ipv4.conf.all.rp_filter=2

iptables --table nat --append POSTROUTING --jump MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
for each in /proc/sys/net/ipv4/conf/*
do
    echo 0 > $each/accept_redirects
    echo 0 > $each/send_redirects
done

if [ ! -f /etc/ipsec.secret ]; then
    if [ "$VPN_PASSWORD" = "password" ] || [ "$VPN_PASSWORD" = "" ]; then
        # Generate a random password
        P1=`cat /dev/urandom | tr -cd abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789 | head -c 3`
        P2=`cat /dev/urandom | tr -cd abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789 | head -c 3`
        P3=`cat /dev/urandom | tr -cd abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789 | head -c 3`
        VPN_PASSWORD="$P1$P2$P3"
        echo "No VPN_PASSWORD set! Generated a random password: $VPN_PASSWORD"
    fi

    if [ "$VPN_PSK" = "password" ] || [ "$VPN_PSK" = "" ]; then
        # Generate a random password
        P1=`cat /dev/urandom | tr -cd abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789 | head -c 3`
        P2=`cat /dev/urandom | tr -cd abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789 | head -c 3`
        P3=`cat /dev/urandom | tr -cd abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789 | head -c 3`
        VPN_PSK="$P1$P2$P3"
        echo "No VPN_PSK set! Generated a random PSK key: $VPN_PSK"
    fi

    if [ "$VPN_PASSWORD" = "$VPN_PSK" ]; then
        echo "It is not recommended to use the same secret as password and PSK key!"
    fi

    cat > /etc/ipsec.secrets <<EOF
# This file holds shared secrets or RSA private keys for authentication.
# RSA private key for this host, authenticating it to any other host
# which knows the public part.  Suitable public keys, for ipsec.conf, DNS,
# or configuration of other implementations, can be extracted conveniently
# with "ipsec showhostkey".

: PSK "$VPN_PSK"

$VPN_USER : EAP "$VPN_PASSWORD"
$VPN_USER : XAUTH "$VPN_PASSWORD"
EOF
fi

if [ -f "/conf/ipsec.secrets" ]; then
    echo "Overwriting standard /etc/ipsec.secrets with /conf/ipsec.secrets"
    cp -f /conf/ipsec.secrets /etc/ipsec.secrets
fi

if [ -f "/conf/ipsec.conf" ]; then
    echo "Overwriting standard /etc/ipsec.conf with /conf/ipsec.conf"
    cp -f /conf/ipsec.conf /etc/ipsec.conf
fi

if [ -f "/conf/strongswan.conf" ]; then
    echo "Overwriting standard /etc/strongswan.conf with /conf/strongswan.conf"
    cp -f /conf/strongswan.conf /etc/strongswan.conf
fi

ipsec start --nofork\

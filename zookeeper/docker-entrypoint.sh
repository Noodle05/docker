#!/bin/bash
set -e

if [ $ZK_ID -gt 0 -a "$ZK_SERVER_LIST" == "" ]; then
    echo "No server list defined when specify zk_id."
    exit 1
fi

if [ $ZK_ID -gt 0 ]; then
    if [ ! -f "/var/lib/zookeeper/myid" ]; then
        echo "ZK_ID defined, but myid file not exists, need to initial myid"
        echo "$ZK_ID" > /var/lib/zookeeper/myid
    fi
fi
if [ ! -e "/opt/zookeeper/conf/zoo.cfg" ]; then
    echo "This zookeeper instance not configure yet, configure it"
    cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg
    sed -i 's/dataDir=\/tmp\/zookeeper/dataDir=\/var\/lib\/zookeeper/' /opt/zookeeper/conf/zoo.cfg
    if [ "$ZK_SERVER_LIST" != "" ]; then
        IFS=',' read -ra SERVERS <<< "$ZK_SERVER_LIST"
        index=1
        for server in "${SERVERS[@]}"; do
            echo "server.$index=$server" >> /opt/zookeeper/conf/zoo.cfg
            index=$((index+1))
        done
    fi
fi

exec /opt/zookeeper/bin/zkServer.sh $@

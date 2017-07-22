#!/bin/bash

    command=$1
    case "$command" in
        namenode)
            exec /scripts/start-namenode.sh
            ;;  
        sec-namenode)
            exec /scripts/start-secnamenode.sh
            ;;  
        datanode)
            exec /scripts/start-datanode.sh
            ;;  
        resmgr)
            exec /scripts/start-yarn-resmgr.sh
            ;;  
        nodemgr)
            exec /scripts/start-yarn-nodemgr.sh
            ;;  
        proxy)
            exec /scripts/start-yarn-proxy.sh
            ;;  
        mapre-hiserver)
            exec /scripts/start-mapred-history.sh
            ;;  
        *)  
            exit 1
    esac


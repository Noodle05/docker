SUB_COMMAND=namenode

if [ "${SECONDARY_NAMENODE}" == "true" ]; then
    SUB_COMMAND=secondarynamenode
fi

"${HADOOP_HOME}/bin/hdfs" --config /etc/hadoop "${SUB_COMMAND}"

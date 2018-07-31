if [ ! -f "${HADOOP_DATA_DIR}/.initialized" ]; then
    "${HADOOP_HOME}/bin/hdfs" --config /etc/hadoop namenode -format
    touch "${HADOOP_DATA_DIR}/.initialized"
fi

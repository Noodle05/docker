if [ ! -f "${HADOOP_CONF_DIR}/hdfs-site.xml" ]; then
    /bin/sed -e 's|\$HADOOP_DATANODE_ADDRESS|'"${HADOOP_DATANODE_ADDRESS}"'|g' "${HADOOP_CONF_TEMP_DIR}/hdfs-site.xml.tmpl" > "${HADOOP_CONF_DIR}/hdfs-site.xml"
fi

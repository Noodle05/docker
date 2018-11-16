if [ ! -f "${HADOOP_CONF_DIR}/hdfs-site.xml" ]; then
    cp "${HADOOP_CONF_TEMP_DIR}/hdfs-site.xml.tmpl" "${HADOOP_CONF_DIR}/hdfs-site.xml"
fi

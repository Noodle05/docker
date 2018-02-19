if [ ! -f "${HADOOP_CONFIG_DIR}/hdfs-site.xml" ]; then
    cp "${HADOOP_CONFIG_TEMP_DIR}/hdfs-site.xml.tmpl" "${HADOOP_CONFIG_DIR}/hdfs-site.xml"
fi

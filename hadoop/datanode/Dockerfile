FROM noodle05/hadoop-base:3.1.1

ADD create_config.sh "${ROOT_ADDITION_SCRIPTS_DIR}/"

ADD hdfs-site.xml.tmpl "${HADOOP_CONF_TEMP_DIR}/"
ADD start_datanode.sh "${SCRIPTS_DIR}/"

CMD [ "/scripts/start_datanode.sh" ]

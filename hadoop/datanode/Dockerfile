FROM noodle05/hadoop-base:3.1.1

ENV HADOOP_DATANODE_ADDRESS=0.0.0.0:9866

ADD create_config.sh "${ROOT_ADDITION_SCRIPTS_DIR}/"

ADD hdfs-site.xml.tmpl "${HADOOP_CONF_TEMP_DIR}/"
ADD start_datanode.sh "${SCRIPTS_DIR}/"

EXPOSE 9864 9866

CMD [ "/scripts/start_datanode.sh" ]

FROM noodle05/hadoop-base:3.1.1

ENV SECONDARY_NAMENODE=false

ADD format_namenode.sh "${USER_ADDITION_SCRIPTS_DIR}/"
ADD create_config.sh "${ROOT_ADDITION_SCRIPTS_DIR}/"

ADD hdfs-site.xml.tmpl "${HADOOP_CONF_TEMP_DIR}/"
ADD start_namenode.sh "${SCRIPTS_DIR}/"

CMD [ "/scripts/start_namenode.sh" ]

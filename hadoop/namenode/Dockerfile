FROM hadoop:base

ENV SECONDARY_NAMENODE=false

ADD format_namenode.sh "${USER_ADDITION_SCRIPTS_DIR}/"
ADD create_config.sh "${ROOT_ADDITION_SCRIPTS_DIR}/"

ADD hdfs-site.xml.tmpl "${HADOOP_CONFIG_TEMP_DIR}/"
ADD start_namenode.sh "${SCRIPTS_DIR}/"

CMD [ "/scripts/start_namenode.sh" ]

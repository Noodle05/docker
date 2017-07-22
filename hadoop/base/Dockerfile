FROM noodle05/centos-jre:7.3.1611-8_141-b15

ARG HADOOP_VERSION=2.8.0
ARG DOWNLOAD_URL=http://apache.mirrors.tds.net/hadoop/common
ARG HADOOP_URL="${DOWNLOAD_URL}/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"

ENV HADOOP_HOME=/opt/hadoop \
    HADOOP_USER=hadoop \
    HADOOP_CONF_DIR=/etc/hadoop \
    HADOOP_PID_DIR=/var/run/hadoop \
    HADOOP_DATA_DIR=/var/lib/hadoop \
    HADOOP_LOG_DIR=/var/log/hadoop

ENV HADOOP_NAMENODE_OPTS="" \
    HADOOP_DATANODE_OPTS="" \
    HADOOP_SECONDARYNAMENODE_OPTS="" \
    YARN_RESOURCEMANAGER_OPTS="" \
    YARN_NODEMANAGER_OPTS="" \
    YARN_PROXYSERVER_OPTS="" \
    HADOOP_JOB_HISTORYSERVER_OPTS=""

ENV JAVA_HEAPSIZE="1g" \
    JAVA_GC_OPTS="-XX:+UseG1GC" \
    JAVA_GC_LOG_OPTS=""

ENV CUSTOMIZE_SCRIPT_FOLDER=/custom_scripts

RUN yum install -y -q snappy which openssh-server openssh-clients \
 && ln -snf /usr/lib64/libcrypto.so.1.0.1e /usr/lib64/libcrypto.so \
 && /usr/bin/ssh-keygen -A \
 && sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd \
 && echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config \
 && echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config \
 && groupadd -r -g 150 "${HADOOP_USER}" \
 && useradd -r -g "${HADOOP_USER}" -M -u 151 -d "${HADOOP_HOME}" "${HADOOP_USER}" \
 && curl -sL "${HADOOP_URL}" \
  | tar --no-same-owner -C /opt -zx \
 && mv "/opt/hadoop-${HADOOP_VERSION}" "${HADOOP_HOME}" \
 && rm -fr "${HADOOP_HOME}/include" "${HADOOP_HOME}/lib/native/examples" \
    "${HADOOP_HOME}/share/doc" \
 && find "${HADOOP_HOME}/share/hadoop" -name sources -type d -prune -exec rm -fr {} \; \
 && find "${HADOOP_HOME}/share/hadoop" -name templates -type d -prune -exec rm -fr {} \; \
 && find "${HADOOP_HOME}/share/hadoop" -name jdiff -type d -prune -exec rm -fr {} \; \
 && find "${HADOOP_HOME}/share/hadoop" -name test -type d -prune -exec rm -fr {} \; \
 && find "${HADOOP_HOME}/share/hadoop" -name "lib-examples" -type d -prune -exec rm -fr {} \; \
 && find "${HADOOP_HOME}/share/hadoop" -name "*-tests.jar" -type f -exec rm -f {} \; \
 && mv "${HADOOP_HOME}/etc" /hadoop_etc_orig \
 && mkdir -p "${HADOOP_DATA_DIR}" "${HADOOP_LOG_DIR}" "${HADOOP_CONF_DIR}" \
 && chown -R "${HADOOP_USER}":"${HADOOP_USER}" "${HADOOP_DATA_DIR}" "${HADOOP_LOG_DIR}" "${HADOOP_CONF_DIR}" \
 && mkdir -p "${HADOOP_HOME}/.ssh" \
 && chmod 700 "${HADOOP_HOME}/.ssh" \
 && ssh-keygen -q -N "" -t rsa -b 4096 -f "${HADOOP_HOME}/.ssh/id_rsa" \
 && cp "${HADOOP_HOME}/.ssh/id_rsa.pub" "${HADOOP_HOME}/.ssh/authorized_keys" \
 && chown -R "${HADOOP_USER}":"${HADOOP_USER}" "${HADOOP_HOME}/.ssh" \
 && mkdir -p /scripts "${CUSTOMIZE_SCRIPT_FOLDER}" \
 && yum clean all \
 && rm -fr /tmp/yum_save*.yumtx /var/cache/yum/*

ADD docker-entrypoint.sh /
ADD start-server.sh /

VOLUME "${HADOOP_DATA_DIR}" "${HADOOP_LOG_DIR}"

USER "${HADOOP_USER}"

WORKDIR "${HADOOP_HOME}"

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090
# Mapred ports
EXPOSE 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 22

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "namenode" ]

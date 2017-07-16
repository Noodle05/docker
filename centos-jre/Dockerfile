FROM centos:7.3.1611

ARG JAVA_VERSION=8
ARG JAVA_UPD=131
ARG JAVA_BUILD=b11
ARG JED="${JAVA_VERSION}u${JAVA_UPD}"
ARG JRE="jdk1.${JAVA_VERSION}.0_${JAVA_UPD}"

RUN yum install -y -q unzip \
 && curl -kL -H 'Cookie: oraclelicense=accept-securebackup-cookie' \
    "http://download.oracle.com/otn-pub/java/jdk/${JED}-${JAVA_BUILD}/d54c1d3a095b4ff2b6607d096fa80163/server-jre-${JED}-linux-x64.tar.gz" \
    | tar --no-same-owner -C /opt -zxf - \
 && curl -kL -o /tmp/jce_policy.zip -H 'Cookie: oraclelicense=accept-securebackup-cookie' \
    "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" \
 && unzip -q -d /tmp /tmp/jce_policy.zip \
 && rm -f /tmp/jce_policy.zip \
 && chmod -R 644 /tmp/UnlimitedJCEPolicyJDK8 \
 && mv /tmp/UnlimitedJCEPolicyJDK8/local_policy.jar "/opt/${JRE}/jre/lib/security/" \
 && mv /tmp/UnlimitedJCEPolicyJDK8/US_export_policy.jar "/opt/${JRE}/jre/lib/security/" \
 && rm -fr /tmp/UnlimitedJCEPolicyJDK8 \
 && rm -fr "/opt/${JRE}/man" "/opt/${JRE}/include" \
 && yum remove -q -y unzip \
 && yum clean all -q \
 && rm -fr /var/cache/yum/* /tmp/yum_save*.yumtx /root/.pki \
 && alternatives --install /usr/bin/java java "/opt/${JRE}/bin/java" 1

LABEL java.version="${JED}"

ENV JAVA_HOME="/opt/${JRE}"

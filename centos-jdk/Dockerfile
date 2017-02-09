FROM centos:7
MAINTAINER Wei Gao<wei@gaofamily.org>

ARG JAVA_VERSION=8
ARG JAVA_UPD=121
ARG JAVA_BUILD=b13
ARG JED=${JAVA_VERSION}u${JAVA_UPD}
ARG JDK=jdk1.${JAVA_VERSION}.0_${JAVA_UPD}

RUN (yum update || yum -y upgrade) \
 && yum install -y unzip \
 && curl -kL -H 'Cookie: oraclelicense=accept-securebackup-cookie' \
    "http://download.oracle.com/otn-pub/java/jdk/${JED}-${JAVA_BUILD}/e9e7ea248e2c4826b92b3f075a80e441//jdk-${JED}-linux-x64.tar.gz" \
    | tar -C /opt -zxf - \
 && curl -kL -o /tmp/jce_policy.zip -H 'Cookie: oraclelicense=accept-securebackup-cookie' \
    "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" \
 && unzip -d /tmp /tmp/jce_policy.zip \
 && rm -f /tmp/jce_policy.zip \
 && chmod 644 -R /tmp/UnlimitedJCEPolicyJDK8 \
 && mv /tmp/UnlimitedJCEPolicyJDK8/local_policy.jar /opt/${JDK}/jre/lib/security/ \
 && mv /tmp/UnlimitedJCEPolicyJDK8/US_export_policy.jar /opt/${JDK}/jre/lib/security/ \
 && rm -fr /tmp/UnlimitedJCEPolicyJDK8 \
 && yum remove -y unzip \
 && yum clean all \
 && rm -fr /var/cache/yum/* /tmp/yum_save*.yumtx /root/.pki \
 && chown -R root: /opt/${JDK} \
 && alternatives --install /usr/bin/java java /opt/${JDK}/bin/java 1 \
 && alternatives --install /usr/bin/javac javac /opt/${JDK}/bin/javac 1 \
 && alternatives --install /usr/bin/jar jar /opt/${JDK}/bin/jar 1

ENV JAVA_HOME=/opt/${JDK}

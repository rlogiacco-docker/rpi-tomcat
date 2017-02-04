FROM armhf/alpine

LABEL maintainer "Roberto Lo Giacco <rlogiacco@gmail.com>"

ENV PATH=$PATH:$CATALINA_HOME/bin \
    JAVA_HOME=/usr/lib/jvm/default-jvm \
    TOMCAT_VERSION=7.0.75 \
    TOMCAT_MIRROR=http://mirror.nohup.it/apache/tomcat/tomcat-7 \
    TOMCAT_PARENT=/usr/share \
    CATALINA_HOME=/usr/share/tomcat \
    ADMIN_USERNAME=admin

# install binaries
RUN apk add --no-cache openjdk7
RUN ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/" \
 && wget "${TOMCAT_MIRROR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" -O /tmp/tomcat.tgz \
 && tar xzvf /tmp/tomcat.tgz -C ${TOMCAT_PARENT} \
 && mv /usr/share/apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME} \
# cleanup
 && rm /tmp/tomcat.tgz \
 && rm -rf ${CATALINA_HOME}/webapps/examples \
 && rm -rf ${CATALINA_HOME}/webapps/docs \
 && rm -rf ${CATALINA_HOME}/webapps/ROOT

# add admin user
COPY tomcat-users.xml ${CATALINA_HOME}/conf/
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

EXPOSE 8080 8009

VOLUME ${CATALINA_HOME}/webapps
WORKDIR ${CATALINA_HOME}

CMD /entrypoint.sh
FROM rlogiacco/rpi-java

MAINTAINER Roberto Lo Giacco <rlogiacco@gmail.com>

ENV TOMCAT_VERSION 7.0.73
ENV TOMCAT_PARENT /usr/share
ENV CATALINA_HOME /usr/share/tomcat

# Get binaries
RUN \
  wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz

# Uncompress
RUN \
  tar xzvf /tmp/tomcat.tgz -C ${TOMCAT_PARENT} && \
  mv /usr/share/apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME} && \
  rm /tmp/tomcat.tgz && \
  rm -rf ${CATALINA_HOME}/webapps/examples && \
  rm -rf ${CATALINA_HOME}/webapps/docs && \
  rm -rf ${CATALINA_HOME}/webapps/ROOT

# Add admin/admin user
ADD tomcat-users.xml ${CATALINA_HOME}/conf/
ADD entrypoint.sh /
RUN chmod a+x /entrypoint.sh
  
ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8080 8009
VOLUME ${CATALINA_HOME}/webapps
WORKDIR ${CATALINA_HOME}

CMD /entrypoint.sh

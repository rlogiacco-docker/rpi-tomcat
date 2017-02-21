FROM multiarch/alpine:armhf-v3.5

LABEL maintainer "Roberto Lo Giacco <rlogiacco@gmail.com>"
LABEL org.label-schema.vcs-url "https://github.com/rlogiacco-docker/rpi-tomcat"

ARG TOMCAT_VERSION=8.5.11
ARG TOMCAT_MIRROR=http://mirror.nohup.it/apache/tomcat/tomcat-8

ENV PATH=$PATH:$CATALINA_HOME/bin \
    JAVA_HOME=/usr/lib/jvm/default-jvm \
    TOMCAT_PARENT=/usr/share \
    CATALINA_HOME=/usr/share/tomcat \
    ADMIN_USERNAME=admin \
    ALPINE_REPO=http://dl-cdn.alpinelinux.org/alpine/v3.5

# install openjdk binaries
RUN echo "${ALPINE_REPO}/main" >> /etc/apk/repositories \
 && echo "${ALPINE_REPO}/community" >> /etc/apk/repositories \
 && apk add --no-cache openjdk7 \
 && ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/"

ENV TOMCAT_VERSION=$TOMCAT_VERSION

# install tomcat binaries
RUN wget "${TOMCAT_MIRROR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" -O /tmp/tomcat.tgz \
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
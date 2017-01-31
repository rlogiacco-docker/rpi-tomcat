if [ -z "${MANAGER_PASSWORD}" ]; then
  echo "MANAGER_PASSWORD undefined: default value is \`admin\`"
fi
if [ -z "${CATALINA_HOME}/conf/tomcat-users.xml.bak" ]; then
  mv ${CATALINA_HOME}/conf/tomcat-users.xml.bak ${CATALINA_HOME}/conf/tomcat-users.xml
fi
sed -i.bak s/\$\{MANAGER_PASSWORD\}/${MANAGER_PASSWORD}/g ${CATALINA_HOME}/conf/tomcat-users.xml

echo "Manager console credentials are \`admin/${MANAGER_PASSWORD}\`"

${CATALINA_HOME}/bin/catalina.sh run
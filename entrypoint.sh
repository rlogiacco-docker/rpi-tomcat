if [ -z "${ADMIN_PASSWORD}" ]; then
  ADMIN_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
  echo "Generating random admin password: set env ADMIN_PASSWORD to provide a fixed value"
fi

sed -i "s|\${ADMIN_USERNAME}|${ADMIN_USERNAME}|g" ${CATALINA_HOME}/conf/tomcat-users.xml
sed -i "s|\${ADMIN_PASSWORD}|${ADMIN_PASSWORD}|g" ${CATALINA_HOME}/conf/tomcat-users.xml

echo "Tomcat administrator credentials are \`${ADMIN_USERNAME}/${ADMIN_PASSWORD}\`"

${CATALINA_HOME}/bin/catalina.sh run
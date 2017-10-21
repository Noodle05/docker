#!/bin/sh
set -e

set_gerrit_config() {
    su-exec ${GERRIT_USER} git config -f "${GERRIT_SITE}/etc/gerrit.config" "$@"
}

set_secure_config() {
    su-exec ${GERRIT_USER} git config -f "${GERRIT_SITE}/etc/secure.config" "$@"
}

customize_config() {
    #Customize gerrit.config

    #Section gerrit
    [ "x${WEBURL}" = "x" ] || set_gerrit_config gerrit.canonicalWebUrl "${WEBURL}"

    #Section database
    if [ "${DATABASE_TYPE}" = 'postgresql' ]; then
        set_gerrit_config database.type "${DATABASE_TYPE}"
        [ "x${DB_PORT_5432_TCP_ADDR}" = "x" ]    || set_gerrit_config database.hostname "${DB_PORT_5432_TCP_ADDR}"
        [ "x${DB_PORT_5432_TCP_PORT}" = "x" ]    || set_gerrit_config database.port "${DB_PORT_5432_TCP_PORT}"
        [ "x${DB_ENV_POSTGRES_DB}" = "x" ]       || set_gerrit_config database.database "${DB_ENV_POSTGRES_DB}"
        [ "x${DB_ENV_POSTGRES_USER}" = "x" ]     || set_gerrit_config database.username "${DB_ENV_POSTGRES_USER}"
        [ "x${DB_ENV_POSTGRES_PASSWORD}" = "x" ] || set_secure_config database.password "${DB_ENV_POSTGRES_PASSWORD}"
    fi

    #Section database
    if [ "${DATABASE_TYPE}" = 'mysql' ]; then
        set_gerrit_config database.type "${DATABASE_TYPE}"
        [ "x${DB_PORT_3306_TCP_ADDR}" = "x" ] || set_gerrit_config database.hostname "${DB_PORT_3306_TCP_ADDR}"
        [ "x${DB_PORT_3306_TCP_PORT}" = "x" ] || set_gerrit_config database.port "${DB_PORT_3306_TCP_PORT}"
        [ "x${DB_ENV_MYSQL_DB}" = "x" ]       || set_gerrit_config database.database "${DB_ENV_MYSQL_DB}"
        [ "x${DB_ENV_MYSQL_USER}" = "x" ]     || set_gerrit_config database.username "${DB_ENV_MYSQL_USER}"
        [ "x${DB_ENV_MYSQL_PASSWORD}" = "x" ] || set_secure_config database.password "${DB_ENV_MYSQL_PASSWORD}"
    fi

    #Section auth
    [ "x${AUTH_TYPE}" = "x" ]           || set_gerrit_config auth.type "${AUTH_TYPE}"
    [ "x${AUTH_HTTP_HEADER}" = "x" ]    || set_gerrit_config auth.httpHeader "${AUTH_HTTP_HEADER}"
    [ "x${AUTH_EMAIL_FORMAT}" = "x" ]   || set_gerrit_config auth.emailFormat "${AUTH_EMAIL_FORMAT}"
    [ "x${AUTH_GIT_BASIC_AUTH}" = "x" ] || set_gerrit_config auth.gitBasicAuth "${AUTH_GIT_BASIC_AUTH}"

    #Section ldap
    if [ "${AUTH_TYPE}" = 'LDAP' ] || [ "${AUTH_TYPE}" = 'LDAP_BIND' ] ; then
        set_gerrit_config auth.type "${AUTH_TYPE}"
        set_gerrit_config auth.gitBasicAuth true
        [ "x${LDAP_SERVER}" = "x" ]                   || set_gerrit_config ldap.server "ldap://${LDAP_SERVER}"
        [ "x${LDAP_SSLVERIFY}" = "x" ]                || set_gerrit_config ldap.sslVerify "${LDAP_SSLVERIFY}"
        [ "x${LDAP_GROUPSVISIBLETOALL}" = "x" ]       || set_gerrit_config ldap.groupsVisibleToAll "${LDAP_GROUPSVISIBLETOALL}"
        [ "x${LDAP_USERNAME}" = "x" ]                 || set_gerrit_config ldap.username "${LDAP_USERNAME}"
        [ "x${LDAP_PASSWORD}" = "x" ]                 || set_secure_config ldap.password "${LDAP_PASSWORD}"
        [ "x${LDAP_REFERRAL}" = "x" ]                 || set_gerrit_config ldap.referral "${LDAP_REFERRAL}"
        [ "x${LDAP_READTIMEOUT}" = "x" ]              || set_gerrit_config ldap.readTimeout "${LDAP_READTIMEOUT}"
        [ "x${LDAP_ACCOUNTBASE}" = "x" ]              || set_gerrit_config ldap.accountBase "${LDAP_ACCOUNTBASE}"
        [ "x${LDAP_ACCOUNTSCOPE}" = "x" ]             || set_gerrit_config ldap.accountScope "${LDAP_ACCOUNTSCOPE}"
        [ "x${LDAP_ACCOUNTPATTERN}" = "x" ]           || set_gerrit_config ldap.accountPattern "${LDAP_ACCOUNTPATTERN}"
        [ "x${LDAP_ACCOUNTFULLNAME}" = "x" ]          || set_gerrit_config ldap.accountFullName "${LDAP_ACCOUNTFULLNAME}"
        [ "x${LDAP_ACCOUNTEMAILADDRESS}" = "x" ]      || set_gerrit_config ldap.accountEmailAddress "${LDAP_ACCOUNTEMAILADDRESS}"
        [ "x${LDAP_ACCOUNTSSHUSERNAME}" = "x" ]       || set_gerrit_config ldap.accountSshUserName "${LDAP_ACCOUNTSSHUSERNAME}"
        [ "x${LDAP_ACCOUNTMEMBERFIELD}" = "x" ]       || set_gerrit_config ldap.accountMemberField "${LDAP_ACCOUNTMEMBERFIELD}"
        [ "x${LDAP_FETCHMEMBEROFEAGERLY}" = "x" ]     || set_gerrit_config ldap.fetchMemberOfEagerly "${LDAP_FETCHMEMBEROFEAGERLY}"
        [ "x${LDAP_GROUPBASE}" = "x" ]                || set_gerrit_config ldap.groupBase "${LDAP_GROUPBASE}"
        [ "x${LDAP_GROUPSCOPE}" = "x" ]               || set_gerrit_config ldap.groupScope "${LDAP_GROUPSCOPE}"
        [ "x${LDAP_GROUPPATTERN}" = "x" ]             || set_gerrit_config ldap.groupPattern "${LDAP_GROUPPATTERN}"
        [ "x${LDAP_GROUPMEMBERPATTERN}" = "x" ]       || set_gerrit_config ldap.groupMemberPattern "${LDAP_GROUPMEMBERPATTERN}"
        [ "x${LDAP_GROUPNAME}" = "x" ]                || set_gerrit_config ldap.groupName "${LDAP_GROUPNAME}"
        [ "x${LDAP_LOCALUSERNAMETOLOWERCASE}" = "x" ] || set_gerrit_config ldap.localUsernameToLowerCase "${LDAP_LOCALUSERNAMETOLOWERCASE}"
        [ "x${LDAP_AUTHENTICATION}" = "x" ]           || set_gerrit_config ldap.authentication "${LDAP_AUTHENTICATION}"
        [ "x${LDAP_USECONNECTIONPOOLING}" = "x" ]     || set_gerrit_config ldap.useConnectionPooling "${LDAP_USECONNECTIONPOOLING}"
        [ "x${LDAP_CONNECTTIMEOUT}" = "x" ]           || set_gerrit_config ldap.connectTimeout "${LDAP_CONNECTTIMEOUT}"
    fi

    # section OAUTH general
    if [ "${AUTH_TYPE}" = 'OAUTH' ]  ; then
        cp -f ${GERRIT_HOME}/oauth.jar ${GERRIT_SITE}/plugins/oauth.jar
        set_gerrit_config auth.type "${AUTH_TYPE}"
        [ "x${OAUTH_ALLOW_EDIT_FULL_NAME}" = "x" ]     || set_gerrit_config oauth.allowEditFullName "${OAUTH_ALLOW_EDIT_FULL_NAME}"
        [ "x${OAUTH_ALLOW_REGISTER_NEW_EMAIL}" = "x" ] || set_gerrit_config oauth.allowRegisterNewEmail "${OAUTH_ALLOW_REGISTER_NEW_EMAIL}"

        # Google
        [ "x${OAUTH_GOOGLE_RESTRICT_DOMAIN}" = "x" ]   || set_gerrit_config plugin.gerrit-oauth-provider-google-oauth.domain "${OAUTH_GOOGLE_RESTRICT_DOMAIN}"
        [ "x${OAUTH_GOOGLE_CLIENT_ID}" = "x" ]         || set_gerrit_config plugin.gerrit-oauth-provider-google-oauth.client-id "${OAUTH_GOOGLE_CLIENT_ID}"
        [ "x${OAUTH_GOOGLE_CLIENT_SECRET}" = "x" ]     || set_gerrit_config plugin.gerrit-oauth-provider-google-oauth.client-secret "${OAUTH_GOOGLE_CLIENT_SECRET}"
        [ "x${OAUTH_GOOGLE_LINK_OPENID}" = "x" ]       || set_gerrit_config plugin.gerrit-oauth-provider-google-oauth.link-to-existing-openid-accounts "${OAUTH_GOOGLE_LINK_OPENID}"

        # Github
        [ "x${OAUTH_GITHUB_CLIENT_ID}" = "x" ]         || set_gerrit_config plugin.gerrit-oauth-provider-github-oauth.client-id "${OAUTH_GITHUB_CLIENT_ID}"
        [ "x${OAUTH_GITHUB_CLIENT_SECRET}" = "x" ]     || set_gerrit_config plugin.gerrit-oauth-provider-github-oauth.client-secret "${OAUTH_GITHUB_CLIENT_SECRET}"
    fi

    # section container
    [ "x${JAVA_HEAPLIMIT}" = "x" ] || set_gerrit_config container.heapLimit "${JAVA_HEAPLIMIT}"
    [ "x${JAVA_OPTIONS}" = "x" ]   || set_gerrit_config container.javaOptions "${JAVA_OPTIONS}"
    [ "x${JAVA_SLAVE}" = "x" ]     || set_gerrit_config container.slave "${JAVA_SLAVE}"

    #Section sendemail
    if [ "x${SMTP_SERVER}" = "x" ]; then
        set_gerrit_config sendemail.enable false
    else
        set_gerrit_config sendemail.enable true
        set_gerrit_config sendemail.smtpServer "${SMTP_SERVER}"
        if [ "smtp.gmail.com" = "${SMTP_SERVER}" ]; then
            echo "gmail detected, using default port and encryption"
            set_gerrit_config sendemail.smtpServerPort 587
            set_gerrit_config sendemail.smtpEncryption tls
        fi
        [ "x${SMTP_SERVER_PORT}" = "x" ] || set_gerrit_config sendemail.smtpServerPort "${SMTP_SERVER_PORT}"
        [ "x${SMTP_USER}" = "x" ]        || set_gerrit_config sendemail.smtpUser "${SMTP_USER}"
        [ "x${SMTP_PASS}" = "x" ]        || set_secure_config sendemail.smtpPass "${SMTP_PASS}"
        [ "x${SMTP_ENCRYPTION}" = "x" ]      || set_gerrit_config sendemail.sendemail.smtpEncryption "${SMTP_ENCRYPTION}"
        [ "x${SMTP_CONNECT_TIMEOUT}" = "x" ] || set_gerrit_config sendemail.connectTimeout "${SMTP_CONNECT_TIMEOUT}"
        [ "x${SMTP_FROM}" = "x" ]            || set_gerrit_config sendemail.from "${SMTP_FROM}"
    fi

    #Section user
    [ "x${USER_NAME}" = "x" ]             || set_gerrit_config user.name "${USER_NAME}"
    [ "x${USER_EMAIL}" = "x" ]            || set_gerrit_config user.email "${USER_EMAIL}"
    [ "x${USER_ANONYMOUS_COWARD}" = "x" ] || set_gerrit_config user.anonymousCoward "${USER_ANONYMOUS_COWARD}"

    #Section plugins
    set_gerrit_config plugins.allowRemoteAdmin true

    #Section httpd
    [ "x${HTTPD_LISTENURL}" = "x" ] || set_gerrit_config httpd.listenUrl "${HTTPD_LISTENURL}"

    #Section gitweb
    set_gerrit_config gitweb.cgi "/usr/share/gitweb/gitweb.cgi"

    #Section cache
    [ "x${GERRIT_CACHE_DIR}" = "x" ] || set_gerrit_config cache.directory "${GERRIT_CACHE_DIR}"
}

install_jars() {
    # Install external plugins
    cp -f ${GERRIT_HOME}/delete-project.jar ${GERRIT_SITE}/plugins/delete-project.jar
    cp -f ${GERRIT_HOME}/events-log.jar ${GERRIT_SITE}/plugins/events-log.jar

    # Install the Bouncy Castle
    cp -f ${GERRIT_HOME}/bcprov-jdk15on-${BOUNCY_CASTLE_VERSION}.jar ${GERRIT_SITE}/lib/bcprov-jdk15on-${BOUNCY_CASTLE_VERSION}.jar
    cp -f ${GERRIT_HOME}/bcpkix-jdk15on-${BOUNCY_CASTLE_VERSION}.jar ${GERRIT_SITE}/lib/bcpkix-jdk15on-${BOUNCY_CASTLE_VERSION}.jar
}

customize_scripts() {
    # Provide a way to customise this image
    echo
    for f in /docker-entrypoint-init.d/*; do
        case "$f" in
            *.sh)  echo "$0: running $f"; . "$f" ;;
            *)     echo "$0: ignoring $f" ;;
        esac
        echo
    done
}

upgrade_gerrit() {
    echo "Upgrading gerrit..."
    su-exec ${GERRIT_USER} java -jar "${GERRIT_WAR}" init --batch -d "${GERRIT_SITE}" ${GERRIT_INIT_ARGS}
    ret=$?
    if [ $ret -eq 0 ]; then
        echo "Upgrading is OK."
        exit $ret
    else
        echo "Something wrong..."
        cat "${GERRIT_SITE}/logs/error_log"
        exit $ret
    fi
}

if [ "$1" = "start" ]; then
    # If you're mounting ${GERRIT_SITE} to your host, you this will default to root.
    # This obviously ensures the permissions are set correctly for when gerrit starts.
    chown -R ${GERRIT_USER} "${GERRIT_SITE}"
    chown -R ${GERRIT_USER} "${GERRIT_CACHE_DIR}"
    
    # clean up cache
    rm -fr "${GERRIT_CACHE_DIR}/*"

    if ! ls -1A "$GERRIT_SITE" | grep -q .
    then
        echo "First time initialize gerrit..."
        su-exec ${GERRIT_USER} java -jar "${GERRIT_WAR}" init --batch --no-auto-start -d "${GERRIT_SITE}" ${GERRIT_INIT_ARGS}
        #All git repositories must be removed when database is set as postgres or mysql
        #in order to be recreated at the secondary init below.
        #Or an execption will be thrown on secondary init.
        [ ${#DATABASE_TYPE} -gt 0 ] && rm -rf "${GERRIT_SITE}/git"
        
        install_jars

        customize_scripts

        customize_config
    fi
    exec "/gerrit-start.sh"
elif [ "$1" = "upgrade" ]; then
    upgrade_gerrit
fi

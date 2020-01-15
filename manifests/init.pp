# This class installs the wso2 identity server using docker
#
# @summary This class installs the wso2 identity server using docker
#
# @example
#   include dockerapp_wso2is
#
# @param [String] service_name 
#   The name of the container
#
# @param [String] version 
#   The version of the docker image do download
#
# @param [Array] ports 
#   The port mapping in array format
#
# @param [Array] dropins 
#   A list of download urls to get extra dopins needed they must be jar files and 
#   use the format http(s)://url.com/dir1/dir2/filename-0.1.1.jar
#
# @param [String] db_type 
#   Determines if the database is embeded, external
#   embeded is the default
#
# @param [String] db_dbms 
#   Choosed the database management system to use
#   Supported options are mssql and mysql 
#
# @param [String] db_jdbc_driver 
#   The url to download the jdbc driver of the dbms choosen. It must be a jar file
#
# @param [String] db_hostname 
#   The database server fqdn or ip address.
#
# @param [Integer] db_port 
#   The database server port.
#
# @param [String] db_name 
#   The shema of the database 
#
# @param [Boolean] db_create_db 
#   If puppet should create the database or not
#
# @param [Boolean] use_ccm
#   If you use ccm to store database passwords
#
# @param [String] ccm_srvc 
#   The srvc record to locate the ccm server
#
# @param [String] ccm_app_key 
#   The app key to be used on the ccm server
#
# @param [String] ccm_environment 
#   The ccm environment to call the values
#
# @param [String] db_db_owner_login 
#   The login of the database owner user
#
# @param [String] db_db_owner_password 
#   The password of the database owner user
#
# @param [String] db_db_owner_pwd_ccm_key 
#   The ccm key to the db ower password
#
# @param [String] db_db_user_login 
#   A login for a database user (not owner)
#
# @param [String] db_db_user_password 
#   A password for a database user (not owner)
#
# @param [String] db_db_user_pwd_ccm_key 
#   The ccm key for the db user password
#
# @param [String] create_super_admin
#   If we are goind to create an admin account
#
# @param [String] adm_user 
#   The initial system admin account  
#
# @param [String] adm_pwd 
#   The initial system admin account password 
#
# @param [String] adm_role 
#   The initial system admin role  
#
# @param [Boolean] use_external_auth_app 
#   If wso2is should use an external auth app to display the login page
#
# @param [String] external_auth_endpoint 
#   The url to the external auth endpoint
#
# @param [String] external_auth_endpoint_retry 
#   The url to the external auth endpoint retry page
#
# @param [String] external_auth_endpoint_claims 
#   The url to the external auth endpoint claims page
#
# @param [Boolean] enable_ha 
#   This paramenter allows the changes needed to enable a high avaliability setup
#
# @param [String] ha_cluster_name 
#   The name of the ha cluster
#
# @param [String] alternate_deployment_dir 
#   An alternate deployment dir to be mounted in case of need
#
# @param [String] alternate_tenants_dir 
#   An alternate tenants dir to be mounted in case of need
#
# @param [Boolean] use_alternate_dirs 
#   Enable or disable the use of alternate dirs
#
# @param [Boolean] use_active_directory 
#   If we are using Active Directory as our primary user store
#
# @param [String] ad_server 
#   The active directory server (PDC is prefered)
#
# @param [Boolean] ad_use_secundary 
#   If there is a secundary active directory server (for fail over)
#
# @param [String] ad_secundary_server 
#   The secundary active directory server
#
# @param [String] ad_secundary_port 
#   The secundary active directory port (636)
#
# @param [String] ad_port 
#   The active directory port (636)
#
# @param [Boolean] ad_use_ssl 
#   If the connection to active directory uses ssl
#
# @param [String] ad_service_user 
#   The CN of the active directory service user
#
# @param [String] ad_service_pwd 
#   The password of the active directory service user 
#
# @param [String] ad_user_search_base 
#   The base OU to search the users
#
# @param [String] ad_group_search_base 
#   The base OU to search the groups 
#
# @param [String] ad_user_name_search_filter 
#   The search filter for users on AD
#
# @param [String] ad_user_name_list_filter 
#   The list filter for users on AD
#
# @param [String] ad_group_name_search_filter 
#   The search filter for groups on AD
#
# @param [String] ad_group_name_list_filter 
#   The list filter for groups on AD
#
# @param [String] master_log_level 
#   The wso2 master log level default = INFO
#
# @param [String] authentication_log_level 
#   The wso2 authentication log level default = INFO
#
# @param [String] identity_log_level 
#   The wso2 identity log level default = INFO
#
# @param [String] scim_log_level 
#   The wso2 SCIM log level default = INFO
#
# @param [String] oauth_log_level 
#   The wso2 OAUTH log level default = INFO
#
# @param [String] identity_mgmt_log_level 
#   The wso2 identity management log level default = INFO
#
# @param [String] pwd_java_regex 
#   The java regex to validate passwords
#
# @param [String] pwd_java_script_regex 
#   The java script regex to validate passwords
#
# @param [String] pwd_violation_msg 
#   The error message to be shown when the validaton fails
#
# @param [Array] extra_trust_certs 
#   Extra certificates urls to download and trust
#
# @param [Array] cors_domains
#   List of domains to accept in cors
#
# @param [Boolean] enable_scim
#   Enables or disables scim api
#
# @param [String] timezone 
#   The container timezone
#
# @param [Boolean] send_mail
#   If the server is to send e-mails
#
# @param [Boolean] mail_authenticate
#   If the email server needs authentication
#
# @param [Boolean] mail_use_tls
#   If the email server users tls on the transport
#
# @param [String] mail_user 
#   The email server authentication user
#
# @param [String] ad_user_entry_object_class 
#   The user class in active directory
#
# @param [String] mail_password 
#   The email server authentication password
#
# @param [String] mail_from 
#   The from of the sent email
#
# @param [String] mail_host 
#   The email server host
#
# @param [Integer] pwd_min_lenght 
#   The minimum lenght of the password (used in scim)
#
# @param [Integer] pwd_max_lenght 
#   The maximum lenght of the password (used in scim)
#
# @param [String] mail_port 
#   The email service port
#
# @param [Boolean] auth_password_recovery
#   If the rest api to auth_password_recovery should be authenticated
#
# @param [String] oauth_endpoint_oidc_consent_page (optional)
#   The page to redirect the consent request
#
# @param [String] oauth_endpoint_oauth2_consent_page (optional)
#   The page to redirect the oauth2 consent request
#
# @param [String] oauth_endpoint_oauth2_error_page (optional)
#   The page to redirect in case of errors 
#
# @param [String] oauth_endpoint_oidc_logout_consent_page (optional)
#   The page to redirect to do the logout
#
# @param [String] oauth_endpoint_oidc_logout_page (optional)
#   The page to redirect to do the logout
#
# @param [Array] ha_members (optional)
#   The list of ha members in the cluster
#
# @param [String] is_fqdn (optional)
#   The identity server FQDN
#
# @param [String] ad_service_ccm_key (optional)
#   The ccm key used for active directory service account
#
# @param [Boolean] enable_soap
#   If the soap services should be enabled
#
class dockerapp_wso2is (
  String $service_name = 'wso2is',
  String $version = '5.8.0',
  Array $ports = ['9443:9443','9763:9763', '9999:9999', '4000:4000', '7612:7612', '7712:7712', '9612:9612', '9712:9712'],
  Array $dropins = [],
  String $db_type = 'embeded',
  String $db_dbms = 'mssql',
  String $db_jdbc_driver = '',
  String $db_hostname = '',
  Integer $db_port = 1433,
  String $db_name = '',
  Boolean $db_create_db = false,
  Boolean $use_ccm = false,
  String $ccm_srvc = '',
  String $ccm_app_key = '',
  String $ccm_environment = '',
  String $db_db_owner_login = '',
  String $db_db_owner_password = '',
  String $db_db_owner_pwd_ccm_key = '',
  String $db_db_user_login = '',
  String $db_db_user_password = '',
  String $db_db_user_pwd_ccm_key = '',
  Boolean $create_super_admin = false,
  String $adm_user = 'admin',
  String $adm_pwd = 'secret',
  String $adm_role = 'wso2isadmin',
  Boolean $use_external_auth_app = false,
  String $external_auth_endpoint = '',
  String $external_auth_endpoint_retry = '',
  String $external_auth_endpoint_claims = '',
  Boolean $enable_ha = false,
  String $ha_cluster_name = 'wso2cluster',
  Array $ha_members = ['127.0.0.1'],
  String $is_fqdn = $fqdn,
  String $alternate_deployment_dir = '',
  String $alternate_tenants_dir = '',
  Boolean $use_alternate_dirs = false,
  Boolean $use_active_directory = false,
  String $ad_server = '',
  String $ad_port = '636',
  Boolean $ad_use_secundary = false,
  String $ad_secundary_server = '',
  String $ad_secundary_port = '636',
  Boolean $ad_use_ssl = true,
  String $ad_service_user = '',
  String $ad_service_pwd = '',
  String $ad_service_ccm_key = '',
  String $ad_user_search_base = '',
  String $ad_group_search_base = '',
  String $ad_user_name_search_filter = '(sAMAccountName=?)',
  String $ad_user_name_list_filter = '(&amp;(objectClass=user)(!(sn=Service)))',
  String $ad_group_name_search_filter = '(&amp;(objectClass=group)(cn=?))',
  String $ad_user_entry_object_class = 'user',
  String $ad_group_name_list_filter = '(objectcategory=group)',
  String $master_log_level = 'INFO',
  String $authentication_log_level = 'INFO',
  String $identity_log_level = 'INFO',
  String $scim_log_level = 'INFO',
  String $oauth_log_level = 'INFO',
  String $identity_mgmt_log_level = 'INFO',
  String $pwd_java_regex = '[a-zA-Z0-9._\-|//]{3,30}$',
  String $pwd_java_script_regex = '^[\S]{5,30}$',
  String $pwd_violation_msg = 'Password length should be within 5 to 30 characters',
  Integer $pwd_min_lenght = 5,
  Integer $pwd_max_lenght = 30,
  Array $extra_trust_certs = [],
  Array $cors_domains = [],
  Boolean $enable_scim = false,
  String $timezone = 'America/Sao_Paulo',
  Boolean $send_mail = false,
  Boolean $mail_authenticate = false,
  String $mail_user = 'user',
  String $mail_password = 'password',
  String $mail_from = 'no@mail.com',
  String $mail_host = 'smtp.mail.com',
  String $mail_port = '587',
  Boolean $mail_use_tls = true,
  Boolean $auth_password_recovery = true,
  String $oauth_endpoint_oidc_consent_page = '',
  String $oauth_endpoint_oauth2_consent_page = '',
  String $oauth_endpoint_oauth2_error_page = '',
  String $oauth_endpoint_oidc_logout_consent_page = '',
  String $oauth_endpoint_oidc_logout_page = '',
  Boolean $enable_soap = true,
){

  include 'dockerapp'

  $image = "wso2/wso2is:${version}"

  $dir_owner = 802
  $dir_group = 802

  $data_dir = $::dockerapp::params::data_dir
  $config_dir = $::dockerapp::params::config_dir
  $scripts_dir = $::dockerapp::params::scripts_dir
  $lib_dir = $::dockerapp::params::lib_dir
  $log_dir = $::dockerapp::params::log_dir

  $conf_datadir = "${data_dir}/${service_name}"
  $conf_configdir = "${config_dir}/${service_name}"
  $conf_scriptsdir = "${scripts_dir}/${service_name}"
  $conf_libdir = "${lib_dir}/${service_name}"
  $conf_logdir = "${log_dir}/${service_name}"

  file{ "${conf_libdir}/dropins":
    ensure => directory,
    owner  => $dir_owner,
    group  => $dir_group,
  }

  file{ "${conf_libdir}/lib":
    ensure => directory,
    owner  => $dir_owner,
    group  => $dir_group,
  }

  file{ "${conf_libdir}/libs":
    ensure => directory,
    owner  => $dir_owner,
    group  => $dir_group,
  }

  file{ "${conf_datadir}/db-scripts":
    ensure => directory,
    owner  => $dir_owner,
    group  => $dir_group,
  }

  file{ "${conf_datadir}/solr-data":
    ensure => directory,
    owner  => $dir_owner,
    group  => $dir_group,
  }

  file{ "${conf_datadir}/certs":
    ensure => directory,
    owner  => $dir_owner,
    group  => $dir_group,
  }

  file{ "${conf_datadir}/database":
    ensure => directory,
    owner  => $dir_owner,
    group  => $dir_group,
  }

  file{ "${conf_datadir}/directory":
    ensure => directory,
    owner  => $dir_owner,
    group  => $dir_group,
  }

  file{ "${conf_datadir}/repository-resources-security":
    ensure => directory,
    owner  => $dir_owner,
    group  => $dir_group,
  }

  exec { "${service_name}-copy-dbscripts":
    command => "/usr/bin/docker run --rm --name=${service_name}_tmp -v ${conf_datadir}/db-scripts:/db_scripts --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/dbscripts/* /db_scripts\"",
    creates => "${conf_datadir}/db-scripts/mssql.sql",
    require => File["${conf_datadir}/db-scripts"],
  }

if( $version == '5.9.0') {

  exec { "${service_name}-copy-configs":
    command => "/usr/bin/docker run --rm --name=${service_name}_tmp -v ${conf_configdir}:/conf_dest --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/conf/* /conf_dest\"",
    creates => "${conf_configdir}/metrics.xml",
    require => File[$conf_configdir],
  }

  exec { "${service_name}-copy-libs":
    command => "/usr/bin/docker run --rm --name=${service_name}_cp_libs -v ${conf_libdir}/libs:/conf_dest --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/lib/* /conf_dest\"",
    creates => "${conf_libdir}/libs/README.txt",
    require => File["${conf_libdir}/libs"],
  }

  exec { "${service_name}-copy-dropins":
    command => "/usr/bin/docker run --rm --name=${service_name}_cp_dropins -v ${conf_libdir}/dropins:/conf_dest --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/components/dropins/* /conf_dest\"",
    creates => "${conf_libdir}/dropins/kubernetes-membership-scheme-1.0.5.jar",
    require => File["${conf_libdir}/dropins"],
  }

} else {

  exec { "${service_name}-copy-configs":
    command => "/usr/bin/docker run --rm --name=${service_name}_tmp -v ${conf_configdir}:/conf_dest --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/conf/* /conf_dest\"",
    creates => "${conf_configdir}/log4j.properties",
    require => File[$conf_configdir],
  }

  exec { "${service_name}-copy-dropins":
    command => "/usr/bin/docker run --rm --name=${service_name}_cp_dropins -v ${conf_libdir}/dropins:/conf_dest --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/components/dropins/* /conf_dest\"",
    creates => "${conf_libdir}/dropins/org.wso2.carbon.logging.propfile_1.0.0.jar",
    require => File["${conf_libdir}/dropins"],
  }

}



  exec { "${service_name}-copy-security":
    command => "/usr/bin/docker run --rm --name=${service_name}_cp_dropins -v ${conf_datadir}/repository-resources-security:/conf_dest --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/resources/security/* /conf_dest\"",
    creates => "${conf_datadir}/repository-resources-security/wso2carbon.jks",
    require => File["${conf_datadir}/repository-resources-security"],
  }

  $dropins.each |String $dropin| {
    if $dropin =~ /(.*\/)(.*)[-_].*\.jar/ {
      $base_path = $1
      $jar_file = $2

      remote_file {"${conf_libdir}/dropins/${jar_file}.jar":
        ensure      => present,
        source      => $dropin,
        verify_peer => false,
        owner       => $dir_owner,
        group       => $dir_group,
        notify      => Docker::Run[$service_name],
        require     => File["${conf_libdir}/dropins"],
      }
    }
  }

  if !defined( Class['java'] ) {
    class { 'java':
      distribution => 'jre',
    }
  }

  $extra_trust_certs.each |String $cert| {
    if $cert=~ /(.*\/)(.*).crt/ {
      $cert_base_path = $1
      $cert_file = $2

      remote_file { "${conf_datadir}/certs/${cert_file}.crt":
        ensure      => present,
        source      => $cert,
        verify_peer => false,
        notify      => Docker::Run[$service_name],
        require     => File["${conf_datadir}/certs"],
      }

      java_ks { "${cert_file}:trust-${cert_file}":
        ensure       => latest,
        certificate  => "${conf_datadir}/certs/${cert_file}.crt",
        target       => "${conf_datadir}/repository-resources-security/client-truststore.jks",
        password     => 'wso2carbon',
        trustcacerts => true,
        require      => [Class['java'], Remote_file["${conf_datadir}/certs/${cert_file}.crt"]],
      }
    }
  }

  exec { "${service_name}-copy-lib":
    command => "/usr/bin/docker run --rm --name=${service_name}_cp_lib -v ${conf_libdir}/lib:/conf_dest --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/components/lib/* /conf_dest\"",
    creates => "${conf_libdir}/lib/dnsjava-2.1.8.jar",
    require => File["${conf_libdir}/lib"],
  }
  if $use_ccm {
    $dbconn_owner = {
      'db_type'     => $db_dbms,
      'db_user'     => $db_db_owner_login,
      'db_pwd'      => '',
      'db_hostname' => $db_hostname,
      'db_port'     => $db_port,
      'db_name'     => $db_name,
      'ccm_srvc'    => $ccm_srvc,
      'ccm_key'     => $db_db_owner_pwd_ccm_key,
      'ccm_env'     => $ccm_environment,
      'ccm_api_key' => $ccm_app_key,
    }

    $dbconn = {
      'db_type'     => $db_dbms,
      'db_user'     => $db_db_user_login,
      'db_pwd'      => '',
      'db_hostname' => $db_hostname,
      'db_port'     => $db_port,
      'db_name'     => $db_name,
      'ccm_srvc'    => $ccm_srvc,
      'ccm_key'     => $db_db_owner_pwd_ccm_key,
      'ccm_env'     => $ccm_environment,
      'ccm_api_key' => $ccm_app_key,
    }
  }else{
    $dbconn_owner = {
      'db_type'     => $db_dbms,
      'db_user'     => $db_db_owner_login,
      'db_pwd'      => $db_db_owner_password,
      'db_hostname' => $db_hostname,
      'db_port'     => $db_port,
      'db_name'     => $db_name,
    }

    $dbconn = {
      'db_type'     => $db_dbms,
      'db_user'     => $db_db_user_login,
      'db_pwd'      => $db_db_user_password,
      'db_hostname' => $db_hostname,
      'db_port'     => $db_port,
      'db_name'     => $db_name,
    }
  }

  case $db_type {
    'external': {
      if $db_create_db {
        class{ 'sqlcli':}
        sqlcli::script { "${conf_datadir}/db-scripts/${db_dbms}.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
        sqlcli::script { "${conf_datadir}/db-scripts/metrics/${db_dbms}.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
        sqlcli::script { "${conf_datadir}/db-scripts/consent/${db_dbms}.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
        sqlcli::script { "${conf_datadir}/db-scripts/identity/${db_dbms}.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
        sqlcli::script { "${conf_datadir}/db-scripts/identity/uma/${db_dbms}.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
        sqlcli::script { "${conf_datadir}/db-scripts/bps/bpel/create/${db_dbms}.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
        sqlcli::script { "${conf_datadir}/db-scripts/identity/stored-procedures/${db_dbms}-2012-x/mssql-tokencleanup.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
        sqlcli::script { "${conf_datadir}/db-scripts/identity/stored-procedures/${db_dbms}-2012-x/mssql-tokencleanup-restore.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
      }

      if !$use_ccm {
        if( $version == '5.8.0') {
          file {"${conf_configdir}/datasources/master-datasources.xml":
            content => epp('dockerapp_wso2is/master-datasources.xml.epp', { 'db_conn' => $dbconn, 'use_ccm' => $use_ccm, }),
            notify  => Docker::Run[$service_name],
            require => File[$conf_configdir],
          }
          file {"${conf_configdir}/datasources/metrics-datasources.xml":
            content => epp('dockerapp_wso2is/metrics-datasources.xml.epp', { 'db_conn' => $dbconn, 'use_ccm' => $use_ccm, }),
            notify  => Docker::Run[$service_name],
            require => File[$conf_configdir],
          }
          file {"${conf_configdir}/datasources/bps-datasources.xml":
            content => epp('dockerapp_wso2is/bps-datasources.xml.epp', { 'db_conn' => $dbconn, 'use_ccm' => $use_ccm, }),
            notify  => Docker::Run[$service_name],
            require => File[$conf_configdir],
          }
          file {"${conf_configdir}/user-mgt.xml":
            content => epp('dockerapp_wso2is/user-mgt.xml.epp', {
              'adm_user'                    => $adm_user,
              'adm_pwd'                     => $adm_pwd,
              'adm_role'                    => $adm_role,
              'use_ccm'                     => $use_ccm,
              'use_active_directory'        => $use_active_directory,
              'ad_server'                   => $ad_server,
              'ad_port'                     => $ad_port,
              'ad_use_ssl'                  => $ad_use_ssl,
              'ad_service_user'             => $ad_service_user,
              'ad_service_pwd'              => $ad_service_pwd,
              'ad_user_search_base'         => $ad_user_search_base,
              'ad_group_search_base'        => $ad_group_search_base,
              'ad_user_name_search_filter'  => $ad_user_name_search_filter,
              'ad_user_name_list_filter'    => $ad_user_name_list_filter,
              'ad_group_name_search_filter' => $ad_group_name_search_filter,
              'ad_group_name_list_filter'   => $ad_group_name_list_filter,
              'pwd_java_regex'              => $pwd_java_regex,
              'pwd_java_script_regex'       => $pwd_java_script_regex,
              'pwd_violation_msg'           => $pwd_violation_msg,
              'enable_scim'                 => $enable_scim,
              }),
            notify  => Docker::Run[$service_name],
            require => File[$conf_configdir],
          }
        } else {
            file {"${conf_configdir}/deployment.toml":
              content => epp('dockerapp_wso2is/deployment.toml.epp', {
                  'auth_endpoint'                           => $external_auth_endpoint,
                  'auth_endpoint_retry'                     => $external_auth_endpoint_retry,
                  'auth_endpoint_claims'                    => $external_auth_endpoint_claims,
                  'enable_ha'                               => $enable_ha,
                  'cluster_name'                            => $ha_cluster_name,
                  'ha_members'                              => $ha_members,
                  'ip_address'                              => $::networking['interfaces']['eth0']['ip'],
                  'hostname'                                => $is_fqdn,
                  'db_conn'                                 => $dbconn,
                  'use_ccm'                                 => $use_ccm,
                  'create_super_admin'                      => $create_super_admin,
                  'adm_user'                                => $adm_user,
                  'adm_pwd'                                 => $adm_pwd,
                  'adm_role'                                => $adm_role,
                  'use_active_directory'                    => $use_active_directory,
                  'ad_server'                               => $ad_server,
                  'ad_port'                                 => $ad_port,
                  'ad_use_secundary'                        => $ad_use_secundary,
                  'ad_secundary_server'                     => $ad_secundary_server,
                  'ad_secundary_port'                       => $ad_secundary_port,
                  'ad_use_ssl'                              => $ad_use_ssl,
                  'ad_service_user'                         => $ad_service_user,
                  'ad_service_pwd'                          => $ad_service_pwd,
                  'ad_user_search_base'                     => $ad_user_search_base,
                  'ad_group_search_base'                    => $ad_group_search_base,
                  'ad_user_name_search_filter'              => $ad_user_name_search_filter,
                  'ad_user_name_list_filter'                => $ad_user_name_list_filter,
                  'ad_user_entry_object_class'              => $ad_user_entry_object_class,
                  'ad_group_name_search_filter'             => $ad_group_name_search_filter,
                  'ad_group_name_list_filter'               => $ad_group_name_list_filter,
                  'pwd_java_regex'                          => $pwd_java_regex,
                  'pwd_java_script_regex'                   => $pwd_java_script_regex,
                  'pwd_violation_msg'                       => $pwd_violation_msg,
                  'enable_scim'                             => $enable_scim,
                  'send_mail'                               => $send_mail,
                  'mail_authenticate'                       => $mail_authenticate,
                  'mail_user'                               => $mail_user,
                  'mail_password'                           => $mail_password,
                  'mail_from'                               => $mail_from,
                  'mail_host'                               => $mail_host,
                  'mail_port'                               => $mail_port,
                  'mail_use_tls'                            => $mail_use_tls,
                  'auth_password_recovery'                  => $auth_password_recovery,
                  'oauth_endpoint_oidc_consent_page'        => $oauth_endpoint_oidc_consent_page,
                  'oauth_endpoint_oauth2_consent_page'      => $oauth_endpoint_oauth2_consent_page,
                  'oauth_endpoint_oauth2_error_page'        => $oauth_endpoint_oauth2_error_page,
                  'oauth_endpoint_oidc_logout_consent_page' => $oauth_endpoint_oidc_logout_consent_page,
                  'oauth_endpoint_oidc_logout_page'         => $oauth_endpoint_oidc_logout_page,
                  'enable_soap'                             => $enable_soap,

                }),
              notify  => Docker::Run[$service_name],
              require => File[$conf_configdir],
            }
        }
      }else{
        if( $version == '5.8.0') {
          ccm_cli::scheduled { 'template-master-datasources.xml':
            template_content    => base64('encode', epp('dockerapp_wso2is/master-datasources.xml.epp',
            { 'db_conn' => $dbconn, 'use_ccm' => $use_ccm, })),
            authorization_token => $dbconn['ccm_api_key'],
            credentials         => [$dbconn['ccm_key']],
            configurations      => [],
            ccm_srv_record      => $ccm_srvc,
            destination_file    => "${conf_configdir}/datasources/master-datasources.xml",
            environment         => $ccm_environment,
            notify              => Docker::Run[$service_name],
          }
          ccm_cli::scheduled { 'template-metrics-datasources.xml':
            template_content    => base64('encode', epp('dockerapp_wso2is/metrics-datasources.xml.epp',
            { 'db_conn' => $dbconn, 'use_ccm' => $use_ccm, })),
            authorization_token => $dbconn['ccm_api_key'],
            credentials         => [$dbconn['ccm_key']],
            configurations      => [],
            ccm_srv_record      => $ccm_srvc,
            destination_file    => "${conf_configdir}/datasources/metrics-datasources.xml",
            environment         => $ccm_environment,
            notify              => Docker::Run[$service_name],
          }
          ccm_cli::scheduled { 'template-bps-datasources.xml':
            template_content    => base64('encode', epp('dockerapp_wso2is/bps-datasources.xml.epp',
            { 'db_conn' => $dbconn, 'use_ccm' => $use_ccm, })),
            authorization_token => $dbconn['ccm_api_key'],
            credentials         => [$dbconn['ccm_key']],
            configurations      => [],
            ccm_srv_record      => $ccm_srvc,
            destination_file    => "${conf_configdir}/datasources/bps-datasources.xml",
            environment         => $ccm_environment,
            notify              => Docker::Run[$service_name],
          }
          ccm_cli::scheduled { 'user-mgt.xml':
            template_content    => base64('encode', epp('dockerapp_wso2is/user-mgt.xml.epp', {
              'adm_user'                    => $adm_user,
              'adm_pwd'                     => $adm_pwd,
              'adm_role'                    => $adm_role,
              'use_ccm'                     => $use_ccm,
              'use_active_directory'        => $use_active_directory,
              'ad_server'                   => $ad_server,
              'ad_port'                     => $ad_port,
              'ad_use_ssl'                  => $ad_use_ssl,
              'ad_service_user'             => $ad_service_user,
              'ad_service_pwd'              => $ad_service_pwd,
              'ad_user_search_base'         => $ad_user_search_base,
              'ad_group_search_base'        => $ad_group_search_base,
              'ad_user_name_search_filter'  => $ad_user_name_search_filter,
              'ad_user_name_list_filter'    => $ad_user_name_list_filter,
              'ad_group_name_search_filter' => $ad_group_name_search_filter,
              'ad_group_name_list_filter'   => $ad_group_name_list_filter,
              'pwd_java_regex'              => $pwd_java_regex,
              'pwd_java_script_regex'       => $pwd_java_script_regex,
              'pwd_violation_msg'           => $pwd_violation_msg,
              'enable_scim'                 => $enable_scim,
              })),
            authorization_token => $dbconn['ccm_api_key'],
            credentials         => [$ad_service_ccm_key],
            configurations      => [],
            ccm_srv_record      => $ccm_srvc,
            destination_file    => "${conf_configdir}/user-mgt.xml",
            environment         => $ccm_environment,
            notify              => Docker::Run[$service_name],
          }
        } else {
            ccm_cli::scheduled { "deployment.toml":
              template_content    => base64('encode', epp('dockerapp_wso2is/deployment.toml.epp', {
                  'auth_endpoint'                           => $external_auth_endpoint,
                  'auth_endpoint_retry'                     => $external_auth_endpoint_retry,
                  'auth_endpoint_claims'                    => $external_auth_endpoint_claims,
                  'enable_ha'                               => $enable_ha,
                  'cluster_name'                            => $ha_cluster_name,
                  'ha_members'                              => $ha_members,
                  'ip_address'                              => $::networking['interfaces']['eth0']['ip'],
                  'hostname'                                => $is_fqdn,
                  'db_conn'                                 => $dbconn,
                  'use_ccm'                                 => $use_ccm,
                  'create_super_admin'                      => $create_super_admin,
                  'adm_user'                                => $adm_user,
                  'adm_pwd'                                 => $adm_pwd,
                  'adm_role'                                => $adm_role,
                  'use_active_directory'                    => $use_active_directory,
                  'ad_server'                               => $ad_server,
                  'ad_port'                                 => $ad_port,
                  'ad_use_secundary'                        => $ad_use_secundary,
                  'ad_secundary_server'                     => $ad_secundary_server,
                  'ad_secundary_port'                       => $ad_secundary_port,
                  'ad_use_ssl'                              => $ad_use_ssl,
                  'ad_service_user'                         => $ad_service_user,
                  'ad_service_pwd'                          => $ad_service_pwd,
                  'ad_user_search_base'                     => $ad_user_search_base,
                  'ad_group_search_base'                    => $ad_group_search_base,
                  'ad_user_name_search_filter'              => $ad_user_name_search_filter,
                  'ad_user_name_list_filter'                => $ad_user_name_list_filter,
                  'ad_user_entry_object_class'              => $ad_user_entry_object_class,
                  'ad_group_name_search_filter'             => $ad_group_name_search_filter,
                  'ad_group_name_list_filter'               => $ad_group_name_list_filter,
                  'pwd_java_regex'                          => $pwd_java_regex,
                  'pwd_java_script_regex'                   => $pwd_java_script_regex,
                  'pwd_violation_msg'                       => $pwd_violation_msg,
                  'enable_scim'                             => $enable_scim,
                  'send_mail'                               => $send_mail,
                  'mail_authenticate'                       => $mail_authenticate,
                  'mail_user'                               => $mail_user,
                  'mail_password'                           => $mail_password,
                  'mail_from'                               => $mail_from,
                  'mail_host'                               => $mail_host,
                  'mail_port'                               => $mail_port,
                  'mail_use_tls'                            => $mail_use_tls,
                  'auth_password_recovery'                  => $auth_password_recovery,
                  'oauth_endpoint_oidc_consent_page'        => $oauth_endpoint_oidc_consent_page,
                  'oauth_endpoint_oauth2_consent_page'      => $oauth_endpoint_oauth2_consent_page,
                  'oauth_endpoint_oauth2_error_page'        => $oauth_endpoint_oauth2_error_page,
                  'oauth_endpoint_oidc_logout_consent_page' => $oauth_endpoint_oidc_logout_consent_page,
                  'oauth_endpoint_oidc_logout_page'         => $oauth_endpoint_oidc_logout_page,
                  'enable_soap'                             => $enable_soap,
              })),
              authorization_token => $dbconn['ccm_api_key'],
              credentials         => [$ad_service_ccm_key, $dbconn['ccm_key']],
              configurations      => [],
              ccm_srv_record      => $ccm_srvc,
              destination_file    => "${conf_configdir}/deployment.toml",
              environment         => $ccm_environment,
              notify              => Docker::Run[$service_name],
            }
        }
      }

      ######

      if( $version == '5.8.0') {
        file {"${conf_configdir}/axis2/axis2.xml":
          content => epp('dockerapp_wso2is/axis2.xml.epp', {
            'enable_ha'    => $enable_ha,
            'cluster_name' => $ha_cluster_name,
            'ha_members'   => $ha_members,
            'ip_address'   => $::networking['interfaces']['eth0']['ip'],
            }),
          replace => true,
          notify  => Docker::Run[$service_name],
          require => File[$conf_configdir],
        }

        file {"${conf_configdir}/carbon.xml":
          content => epp('dockerapp_wso2is/carbon.xml.epp', {
            'is_fqdn' => $is_fqdn,
            'version' => $version
            }),
          notify  => Docker::Run[$service_name],
          require => File[$conf_configdir],
        }

        file {"${conf_configdir}/output-event-adapters.xml":
          content => epp('dockerapp_wso2is/output-event-adapters.xml.epp', {
            'send_mail'         => $send_mail,
            'mail_authenticate' => $mail_authenticate,
            'mail_user'         => $mail_user,
            'mail_password'     => $mail_password,
            'mail_from'         => $mail_from,
            'mail_host'         => $mail_host,
            'mail_port'         => $mail_port,
            'mail_use_tls'      => $mail_use_tls,
            }),
          notify  => Docker::Run[$service_name],
          require => File[$conf_configdir],
        }

        file {"${conf_configdir}/identity/embedded-ldap.xml":
          content => epp('dockerapp_wso2is/embedded-ldap.xml.epp', {
            'enable_ldap' => !$use_active_directory,
            }),
          notify  => Docker::Run[$service_name],
          require => File[$conf_configdir],
        }

        if $use_active_directory == true {
          file {"${conf_configdir}/identity/service-providers/sp_dashboard.xml":
            ensure => file,
            source => 'puppet:///modules/dockerapp_wso2is/sp_dashboard_ad.xml',
            owner  => $dir_owner,
            group  => $dir_group,
          }
        }

        file {"${conf_configdir}/registry.xml":
          content => epp('dockerapp_wso2is/registry.xml.epp', {
            'use_ha'  => $enable_ha,
            'db_conn' => $dbconn,
            }),
          notify  => Docker::Run[$service_name],
          require => File[$conf_configdir],
        }

        file {"${conf_configdir}/tomcat/catalina-server.xml":
          content => epp('dockerapp_wso2is/catalina-server.xml.epp', {
            'enable_ha'  => $enable_ha,
          }),
          notify  => Docker::Run[$service_name],
          require => File[$conf_configdir],
        }

        file {"${conf_configdir}/log4j.properties":
          content => epp('dockerapp_wso2is/log4j.properties.epp', {
            'master_log_level'         => $master_log_level,
            'authentication_log_level' => $authentication_log_level,
            'identity_log_level'       => $identity_log_level,
            }),
          notify  => Docker::Run[$service_name],
          require => File[$conf_configdir],
        }
      } else {
        file {"${conf_configdir}/log4j2.properties":
          content => epp('dockerapp_wso2is/log4j2.properties.epp', {
            'master_log_level'         => $master_log_level,
            'authentication_log_level' => $authentication_log_level,
            'identity_log_level'       => $identity_log_level,
            'scim_log_level'           => $scim_log_level,
            'oauth_log_level'          => $oauth_log_level,
            'identity_mgmt_log_level'  => $identity_mgmt_log_level,
            }),
          notify  => Docker::Run[$service_name],
          require => File[$conf_configdir],
        }
      }

      if $db_jdbc_driver =~ /(.*\/)(.*)[-_].*\.jar/ {
        $jdbc_base_path = $1
        $jdbc_jar_file = $2

        remote_file {"${conf_libdir}/lib/${jdbc_jar_file}.jar":
          ensure      => present,
          source      => $db_jdbc_driver,
          verify_peer => false,
          owner       => $dir_owner,
          group       => $dir_group,
          notify      => Docker::Run[$service_name],
        }
      }

    }
    default: {

    }
  }


  if( $version == '5.8.0') {
    file {"${conf_configdir}/identity/identity.xml":
      content => epp('dockerapp_wso2is/identity.xml.epp',
        { 'auth_password_recovery' => $auth_password_recovery,
      }),
      notify  => Docker::Run[$service_name],
      require => File[$conf_configdir],
    }
    if $use_external_auth_app {
      file {"${conf_configdir}/identity/application-authentication.xml":
        content => epp('dockerapp_wso2is/application-authentication.xml.epp',
          { 'auth_endpoint'        => $external_auth_endpoint,
            'auth_endpoint_retry'  => $external_auth_endpoint_retry,
            'auth_endpoint_claims' => $external_auth_endpoint_claims,
        }),
        notify  => Docker::Run[$service_name],
        require => File[$conf_configdir],
      }
    }
  }

  file {"${conf_configdir}/identity/identity-mgt.properties":
    content => epp('dockerapp_wso2is/identity/identity-mgt.properties.epp', {
      'temp_password'     => true,
      'pwd_min_lenght'    => $pwd_min_lenght,
      'pwd_max_lenght'    => $pwd_max_lenght,
      'pwd_java_regex'    => $pwd_java_regex,
      'pwd_violation_msg' => $pwd_violation_msg,
      }),
    notify  => Docker::Run[$service_name],
    require => File[$conf_configdir],
  }

  if ( $use_alternate_dirs == true ) {
    file{ "${alternate_deployment_dir}/server":
      ensure => directory,
      owner  => $dir_owner,
      group  => $dir_group,
    }
    file{ "${alternate_deployment_dir}/client":
      ensure => directory,
      owner  => $dir_owner,
      group  => $dir_group,
    }
    if ($version == '5.8.0') {
      file{ "${alternate_deployment_dir}/server/webapps":
        ensure => directory,
        owner  => $dir_owner,
        group  => $dir_group,
        require => File["${alternate_deployment_dir}/server"],
      }
      ->file{ "${alternate_deployment_dir}/server/webapps/oauth2":
        ensure => directory,
        owner  => $dir_owner,
        group  => $dir_group,
      }
      ->file{ "${alternate_deployment_dir}/server/webapps/oauth2/WEB-INF":
        ensure => directory,
        owner  => $dir_owner,
        group  => $dir_group,
      }
      ->file{ "${alternate_deployment_dir}/server/webapps/oauth2/WEB-INF/web.xml":
        owner   => $dir_owner,
        group   => $dir_group,
        content => epp('dockerapp_wso2is/oauth/web.xml.epp', {
            'cors_domains' => $cors_domains,
          }),
      }
    }else{
      exec { "${service_name}-copy-deployment-server-data":
        command => "/usr/bin/docker run --rm --name=${service_name}_tmp -v${alternate_deployment_dir}/server:/dest_dir --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/deployment/server/* /dest_dir\"",
        creates => "${alternate_deployment_dir}/server/webapps/wso2.war",
        require => File["${alternate_deployment_dir}/server"],
      }
      exec { "${service_name}-copy-deployment-client-data":
        command => "/usr/bin/docker run --rm --name=${service_name}_tmp -v${alternate_deployment_dir}/client:/dest_dir --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/deployment/client/* /dest_dir\"",
        creates => "${alternate_deployment_dir}/client/modules/rampart-1.6.1-wso2v36.mar",
        require => File["${alternate_deployment_dir}/client"],
      }
    }
    $volumes = [
      "${alternate_deployment_dir}:/home/wso2carbon/wso2is-${version}/repository/deployment",
      "${alternate_tenants_dir}:/home/wso2carbon/wso2is-${version}/repository/tenants",
      "${conf_libdir}/libs:/home/wso2carbon/wso2is-${version}/lib",
      "${conf_datadir}/directory:/home/wso2carbon/wso2is-${version}/repository/data/org.wso2.carbon.directory",
      "${conf_datadir}/database:/home/wso2carbon/wso2is-${version}/repository/database",
      "${conf_datadir}/repository-resources-security:/home/wso2carbon/wso2is-${version}/repository/resources/security",
      "${conf_datadir}/solr-data:/home/wso2carbon/wso2is-${version}/solr/data",
      "${conf_configdir}:/home/wso2carbon/wso2is-${version}/repository/conf",
      "${conf_logdir}:/home/wso2carbon/wso2is-${version}/repository/logs",
      "${conf_libdir}/dropins:/home/wso2carbon/wso2is-${version}/repository/components/dropins",
      "${conf_libdir}/lib:/home/wso2carbon/wso2is-${version}/repository/components/lib",
      '/etc/hosts:/etc/hosts:ro',
    ]
  }else{
    file{ "${conf_datadir}/deployment":
      ensure => directory,
      owner  => $dir_owner,
      group  => $dir_group,
    }
    ->file{ "${conf_datadir}/client":
      ensure => directory,
      owner  => $dir_owner,
      group  => $dir_group,
    }
    ->file{ "${conf_datadir}/deployment/server":
      ensure  => directory,
      owner   => $dir_owner,
      group   => $dir_group,
      require => File["${conf_datadir}/deployment"],
    }
    ->file{ "${conf_datadir}/deployment/server":
      ensure => directory,
      owner  => $dir_owner,
      group  => $dir_group,
    }
    if($version == '5.8.0') {
      file{ "${conf_datadir}/deployment/server/webapps":
        ensure  => directory,
        owner   => $dir_owner,
        group   => $dir_group,
        require => File["${conf_datadir}/deployment/server"]
      }
      ->file{ "${conf_datadir}/deployment/server/webapps/oauth2":
        ensure => directory,
        owner  => $dir_owner,
        group  => $dir_group,
      }
      ->file{ "${conf_datadir}/deployment/server/webapps/oauth2/WEB-INF":
        ensure => directory,
        owner  => $dir_owner,
        group  => $dir_group,
      }
      ->file{ "${conf_datadir}/deployment/server/webapps/oauth2/WEB-INF/web.xml":
        owner   => $dir_owner,
        group   => $dir_group,
        content => epp('dockerapp_wso2is/oauth/web.xml.epp', {
            'cors_domains' => $cors_domains,
          }),
      }
    }else{
      exec { "${service_name}-copy-deployment-server-data":
        command => "/usr/bin/docker run --rm --name=${service_name}_tmp -v${conf_datadir}/deployment/server:/dest_dir --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/deployment/server/* /dest_dir\"",
        creates => "${conf_datadir}/deployment/server/wso2.war",
        require => File["${conf_datadir}/deployment/server"],
      }
      exec { "${service_name}-copy-deployment-client-data":
        command => "/usr/bin/docker run --rm --name=${service_name}_tmp -v${conf_datadir}/deployment/client:/dest_dir --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/deployment/client/* /dest_dir\"",
        creates => "${conf_datadir}/deployment/client/modules/wso2.war",
        require => File["${conf_datadir}/deployment/client"],
      }
    }
    $volumes = [
      "${conf_libdir}/libs:/home/wso2carbon/wso2is-${version}/lib",
      "${conf_datadir}/deployment:/home/wso2carbon/wso2is-${version}/repository/deployment",
      "${conf_datadir}/directory:/home/wso2carbon/wso2is-${version}/repository/data/org.wso2.carbon.directory",
      "${conf_datadir}/database:/home/wso2carbon/wso2is-${version}/repository/database",
      "${conf_datadir}/repository-resources-security:/home/wso2carbon/wso2is-${version}/repository/resources/security",
      "${conf_datadir}/solr-data:/home/wso2carbon/wso2is-${version}/solr/data",
      "${conf_configdir}:/home/wso2carbon/wso2is-${version}/repository/conf",
      "${conf_logdir}:/home/wso2carbon/wso2is-${version}/repository/logs",
      "${conf_libdir}/dropins:/home/wso2carbon/wso2is-${version}/repository/components/dropins",
      "${conf_libdir}/lib:/home/wso2carbon/wso2is-${version}/repository/components/lib",
      '/etc/hosts:/etc/hosts:ro',
    ]
  }

  if $enable_ha {
    $envs = ['JAVA_OPTS=-Dorg.opensaml.httpclient.https.disableHostnameVerification=true -Djava.util.prefs.systemRoot=/home/wso2carbon/.java -Djava.util.prefs.userRoot=/home/wso2carbon/.java/.userPrefs',
    "-e TZ=${timezone}"]
  }else{
    $envs = ["-e TZ=${timezone}"]
  }

  dockerapp::run {$service_name:
    image        => $image,
    ports        => $ports,
    volumes      => $volumes,
    environments => $envs,
    dir_group    => $dir_group,
    dir_owner    => $dir_owner,
  }

}

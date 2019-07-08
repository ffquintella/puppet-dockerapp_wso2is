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
# @param [String] adm_user 
#   The initial system admin account  
#
# @param [String] adm_pwd 
#   The initial system admin account password 
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
class dockerapp_wso2is (
  String $service_name = 'wso2is',
  String $version = '5.8.0',
  Array $ports = ['9443:9443','9763:9763', '4000:4000'],
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
  String $adm_user = 'admin',
  String $adm_pwd = 'secret',
  Boolean $use_external_auth_app = false,
  String $external_auth_endpoint = '',
  String $external_auth_endpoint_retry = '',
  String $external_auth_endpoint_claims = '',
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

  file{ "${conf_datadir}/respository-resources-security":
    ensure => directory,
    owner  => $dir_owner,
    group  => $dir_group,
  }

  exec { "${service_name}-copy-dbscripts":
    command => "/usr/bin/docker run --rm --name=${service_name}_tmp -v ${conf_datadir}/db-scripts:/db_scripts --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/dbscripts/* /db_scripts\"",
    creates => "${conf_datadir}/db-scripts/mssql.sql",
    require => File["${conf_datadir}/db-scripts"],
  }

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

  exec { "${service_name}-copy-security":
    command => "/usr/bin/docker run --rm --name=${service_name}_cp_dropins -v ${conf_datadir}/respository-resources-security:/conf_dest --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/resources/security/* /conf_dest\"",
    creates => "${conf_datadir}/respository-resources-security/wso2carbon.jks",
    require => File["${conf_datadir}/respository-resources-security"],
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
      'ccm_api_key' => $ccm_api_key,
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
      'ccm_api_key' => $ccm_api_key,
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
        sqlcli::script { "${conf_datadir}/db-scripts/identity/${db_dbms}.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
        sqlcli::script { "${conf_datadir}/db-scripts/identity/stored-procedures/${db_dbms}-2012/mssql-tokencleanup.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
        sqlcli::script { "${conf_datadir}/db-scripts/identity/stored-procedures/${db_dbms}-2012/mssql-tokencleanup-restore.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
          use_ccm_integration => $use_ccm,
        }
      }

      file {"${conf_configdir}/datasources/master-datasources.xml":
        content => epp('dockerapp_wso2is/master-datasources.xml.epp', { 'db_conn' => $dbconn, }),
        notify  => Docker::Run[$service_name],
        require => File[$conf_configdir],
      }

      file {"${conf_configdir}/user-mgt.xml":
        content => epp('dockerapp_wso2is/user-mgt.xml.epp', {
          'adm_user' => $adm_user,
          'adm_pwd'  => $adm_pwd,
          }),
        notify  => Docker::Run[$service_name],
        require => File[$conf_configdir],
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

  $volumes = [
    "${conf_datadir}/directory:/home/wso2carbon/wso2is-${version}/repository/data/org.wso2.carbon.directory",
    "${conf_datadir}/database:/home/wso2carbon/wso2is-${version}/repository/database",
    "${conf_datadir}/respository-resources-security:/home/wso2carbon/wso2is-${version}/repository/resources/security",
    "${conf_datadir}/solr-data:/home/wso2carbon/wso2is-${version}/solr/data",
    "${conf_configdir}:/home/wso2carbon/wso2is-${version}/repository/conf",
    "${conf_logdir}:/home/wso2carbon/wso2is-${version}/repository/logs",
    "${conf_libdir}/dropins:/home/wso2carbon/wso2is-${version}/repository/components/dropins",
    "${conf_libdir}/lib:/home/wso2carbon/wso2is-${version}/repository/components/lib",
  ]

  $envs = []

  dockerapp::run {$service_name:
    image        => $image,
    ports        => $ports,
    volumes      => $volumes,
    environments => $envs,
    dir_group    => $dir_group,
    dir_owner    => $dir_owner,
  }

}

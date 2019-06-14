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
# @param [String] db_schema 
#   The shema of the database 
#
# @param [Boolean] db_create_db 
#   If puppet should create the database or not
#
# @param [String] db_db_owner_login 
#   The login of the database owner user
#
# @param [String] db_db_owner_password 
#   The password of the database owner user
#
# @param [String] db_db_user_login 
#   A login for a database user (not owner)
#
# @param [String] db_db_user_password 
#   A password for a database user (not owner)
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
  String $db_schema = '',
  Boolean $db_create_db = false,
  String $db_db_owner_login = '',
  String $db_db_owner_password = '',
  String $db_db_user_login = '',
  String $db_db_user_password = '',
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
      }
    }
  }

  exec { "${service_name}-copy-lib":
    command => "/usr/bin/docker run --rm --name=${service_name}_cp_lib -v ${conf_libdir}/lib:/conf_dest --entrypoint=\"\" -t ${image} /bin/bash -c \"cp -a /home/wso2carbon/wso2is-${version}/repository/components/lib/* /conf_dest\"",
    creates => "${conf_libdir}/lib/dnsjava-2.1.8.jar",
    require => File["${conf_libdir}/lib"],
  }

  $dbconn_owner = {
    'db_type'     => $db_dbms,
    'db_user'     => $db_db_owner_login,
    'db_pwd'      => $db_db_owner_password,
    'db_hostname' => $db_hostname,
    'db_port'     => $db_port,
    'db_schema'   => $db_schema,
  }

  $dbconn = {
    'db_type'     => $db_dbms,
    'db_user'     => $db_db_user_login,
    'db_pwd'      => $db_db_user_password,
    'db_hostname' => $db_hostname,
    'db_port'     => $db_port,
    'db_schema'   => $db_schema,
  }

  case $db_type {
    'external': {
      if $db_create_db {
        class{ 'sqlcli':}
        sqlcli::script { "${conf_datadir}/db-scripts/${db_dbms}.sql":
          run_once            => true,
          database_connection => $dbconn_owner,
        }
      }

      file {"${conf_configdir}/datasources/master-datasources.xml":
        content => epp('dockerapp_wso2is/master-datasources.xml.epp', { 'db_conn' => $dbconn, }),
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

  $volumes = [
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

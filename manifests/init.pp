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
class dockerapp_wso2is (
  $service_name = 'wso2is',
  $version = '5.8.0',
  $ports = ['9443:9443','9763:9763', '4000:4000'],
  $dropins = [],
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

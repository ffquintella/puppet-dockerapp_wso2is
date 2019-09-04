
# dockerapp_wso2is

This module installs the WSO2 Identity Server using docker and the folder structure defined on the dockerapp modules series.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with dockerapp_wso2is](#setup)
    * [What dockerapp_wso2is affects](#what-dockerapp_wso2is-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with dockerapp_wso2is](#beginning-with-dockerapp_wso2is)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Parameters]($parameters)
6. [Development - Guide for contributing to the module](#development)

## Description

This module installs the WSO2 Identity Server using docker and the folder structure defined on the dockerapp modules series.

The advantage of this strucure is standarization between your apps and security.

## Setup


### Setup Requirements 

This module depends of the following other modules:

* ffquintella-dockerapp 
* puppetlabs-stdblib
* lwf-remote_file
* ffquintella-sqlcli 
* puppetlabs-java
* puppetlabs-docker
* ffquintella-ccm_cli

## Usage

Basicaly includes dockerapp_wso2is and adjust the parameters needed

All the parameters are described in [doc/REFERENCES.md](https://github.com/ffquintella/puppet-dockerapp_wso2is/blob/master/doc/REFERENCES.md)

## Limitations

In the Limitations section, list any incompatibilities, known issues, or other warnings.

## Parameters

* service_name - The name of the service (app) to be used on the folders
* version - WSO2 version

## Development

We try to make our modules as tested as possible so if you make any changes pelase use pdk test unit and pdk validate before submitting a pull request.


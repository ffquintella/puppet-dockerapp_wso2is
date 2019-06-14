require 'spec_helper'

describe 'dockerapp_wso2is' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:params) do
        {
          version: '1.4.1',
          service_name: 'wso2_test',
          db_type: 'external',
          db_create_db: true,
          db_jdbc_driver: 'https://repo.srvc.fgv.br/repository/webstorage/libs/mssql-jdbc-7.2.2.jre8.jar',
        }
      end

      it { is_expected.to compile }
      it { is_expected.to contain_class('dockerapp') }
      it { is_expected.to contain_class('docker') }
      it { is_expected.to contain_class('sqlcli') }
      it { is_expected.to contain_file('/srv/application-data/wso2_test') }
      it { is_expected.to contain_file('/srv/application-config/wso2_test') }
      it { is_expected.to contain_file('/srv/application-lib/wso2_test') }
      it { is_expected.to contain_file('/srv/application-lib/wso2_test/dropins') }
      it { is_expected.to contain_file('/srv/application-lib/wso2_test/lib') }
      it { is_expected.to contain_file('/srv/application-log/wso2_test') }
      it { is_expected.to contain_file('/srv/scripts/wso2_test') }
    end
  end
end

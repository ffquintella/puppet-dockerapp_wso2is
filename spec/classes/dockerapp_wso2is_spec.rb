require 'spec_helper'

describe 'dockerapp_wso2is' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:params) do
        {
          version: '1.4.1',
          service_name: 'wso2_test',
        }
      end

      it { is_expected.to compile }
      it { is_expected.to contain_class('dockerapp') }
      it { is_expected.to contain_class('docker') }
      it { is_expected.to contain_file('/srv/application-data/wso2_test') }
      it { is_expected.to contain_file('/srv/application-config/wso2_test') }
      it { is_expected.to contain_file('/srv/application-lib/wso2_test') }
      it { is_expected.to contain_file('/srv/application-log/wso2_test') }
      it { is_expected.to contain_file('/srv/scripts/wso2_test') }
    end
  end
end

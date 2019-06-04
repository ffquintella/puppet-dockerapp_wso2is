require 'spec_helper'

describe 'dockerapp_wso2is' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('dockerapp') }
    end
  end
end

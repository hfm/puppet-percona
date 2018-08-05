require 'spec_helper'
describe 'percona::xtrabackup' do
  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('percona::xtrabackup') }

    it { is_expected.to contain_package('percona-xtrabackup').with_ensure('installed') }
  end

  context 'with absent' do
    let(:params) do
      { ensure: 'absent' }
    end

    it { is_expected.to contain_package('percona-xtrabackup').with_ensure('absent') }
  end
end

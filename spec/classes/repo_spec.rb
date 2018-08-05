require 'spec_helper'
describe 'percona::repo' do
  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('percona::repo') }
  end
end

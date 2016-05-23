require 'spec_helper'
describe 'percona::repo' do

  context 'with default values for all parameters' do
    it { should compile }
    it { should compile.with_all_deps }
    it { should contain_class('percona::repo') }
  end
end

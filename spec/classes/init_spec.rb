require 'spec_helper'
describe 'percona' do
  context 'with default values for all parameters' do
    it { is_expected.to contain_class('percona') }
  end
end

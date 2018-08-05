require 'spec_helper_acceptance'

describe 'percona class' do
  let(:manifest) do
    <<-EOS
      class { '::percona::xtrabackup':
        version => '2.4',
      }
    EOS
  end

  it 'works without errors' do
    result = apply_manifest(manifest, acceptable_exit_codes: [0, 2], catch_failures: true)

    expect(result.exit_code).not_to eq 4
    expect(result.exit_code).not_to eq 6
  end

  it 'runs a second time without changes' do
    result = apply_manifest(manifest)
    expect(result.exit_code).to eq 0
  end

  describe package('percona-xtrabackup-24') do
    it { is_expected.to be_installed }
  end
end

require 'spec_helper_acceptance'

describe 'percona class' do
  let(:manifest) do
    <<-EOS
      include ::percona::repo
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

  context 'RedHat', if: os[:family] == 'redhat' do
    describe file('/etc/pki/rpm-gpg/RPM-GPG-KEY-Percona') do
      it { is_expected.to be_file }
    end

    [
      "percona-release-#{os[:arch]}",
      'percona-release-noarch',
    ].each do |repo|
      describe yumrepo(repo) do
        it { is_expected.to be_enabled }
      end
    end

    [
      'percona-release-source',
      "percona-testing-#{os[:arch]}",
      'percona-testing-noarch',
      'percona-testing-source',
      "percona-experimental-#{os[:arch]}",
      'percona-experimental-noarch',
      'percona-experimental-source',
    ].each do |repo|
      describe yumrepo(repo) do
        it { is_expected.to exist }
        it { is_expected.not_to be_enabled }
      end
    end
  end

  context 'Debian', if: os[:family] == 'debian' do
    describe file('/etc/apt/sources.list.d/percona-release.list') do
      it { is_expected.to be_file }
      its(:content) { is_expected.to match %r{^deb http://repo.percona.com/apt jessie main$} }
      its(:content) { is_expected.to match %r{^deb-src http://repo.percona.com/apt jessie main$} }
    end
  end

  context 'Ubuntu', if: os[:family] == 'ubuntu' do
    describe file('/etc/apt/sources.list.d/percona-release.list') do
      it { is_expected.to be_file }
      its(:content) { is_expected.to match %r{^deb http://repo.percona.com/apt xenial main$} }
      its(:content) { is_expected.to match %r{^deb-src http://repo.percona.com/apt xenial main$} }
    end
  end
end

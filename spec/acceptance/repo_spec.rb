require 'spec_helper_acceptance'

describe 'percona class' do
  let(:manifest) {
    <<-EOS
      include ::percona::repo
    EOS
  }

  it "should work without errors" do
    result = apply_manifest(manifest, :acceptable_exit_codes => [0, 2], :catch_failures => true)

    expect(result.exit_code).not_to eq 4
    expect(result.exit_code).not_to eq 6
  end

  it "should run a second time without changes" do
    result = apply_manifest(manifest)
    expect(result.exit_code).to eq 0
  end

  context 'RedHat', :if => os[:family] == 'redhat' do
    describe file('/etc/pki/rpm-gpg/RPM-GPG-KEY-Percona') do
      it { should be_file }
    end

    %W(
      percona-release-#{os[:arch]}
      percona-release-noarch
    ).each do |repo|
      describe yumrepo(repo) do
        it { should be_enabled }
      end
    end

    %W(
      percona-release-source
      percona-testing-#{os[:arch]}
      percona-testing-noarch
      percona-testing-source
      percona-experimental-#{os[:arch]}
      percona-experimental-noarch
      percona-experimental-source
    ).each do |repo|
      describe yumrepo(repo) do
        it { should exist }
        it { should_not be_enabled }
      end
    end
  end

  context 'Debian', :if => os[:family] == 'debian' do
    describe file('/etc/apt/sources.list.d/percona-release.list') do
      it { should be_file }
      its(:content) { should match %r|^deb http://repo.percona.com/apt jessie main$| }
      its(:content) { should match %r|^deb-src http://repo.percona.com/apt jessie main$| }
    end
  end

  context 'Ubuntu', :if => os[:family] == 'ubuntu' do
    describe file('/etc/apt/sources.list.d/percona-release.list') do
      it { should be_file }
      its(:content) { should match %r|^deb http://repo.percona.com/apt xenial main$| }
      its(:content) { should match %r|^deb-src http://repo.percona.com/apt xenial main$| }
    end
  end
end

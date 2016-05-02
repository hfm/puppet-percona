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
      percona-release-$basearch
      percona-release-noarch
    ).each do |repo|
      describe yumrepo(repo) do
        it { should be_enabled }
      end
    end

    %W(
      percona-release-source
      percona-testing-$basearch
      percona-testing-noarch
      percona-testing-source
      percona-experimental-$basearch
      percona-experimental-noarch
      percona-experimental-source
    ).each do |repo|
      describe yumrepo(repo) do
        it { should exist }
        it { should_not be_enabled }
      end
    end
  end
end

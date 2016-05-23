require 'spec_helper_acceptance'

describe 'percona class' do
  let(:manifest) {
    <<-EOS
      include ::percona::toolkit
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

  describe package('percona-toolkit') do
    it { should be_installed }
  end
end

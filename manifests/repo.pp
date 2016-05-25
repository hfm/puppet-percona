# Class: percona::repo
# ===========================
#
# percona::repo is to setup repository.
class percona::repo (
  $ensure                                = present,

  $percona_release_basearch_enabled      = 1,
  $percona_release_noarch_enabled        = 1,
  $percona_release_source_enabled        = 0,
  $percona_testing_basearch_enabled      = 0,
  $percona_testing_noarch_enabled        = 0,
  $percona_testing_source_enabled        = 0,
  $percona_experimental_basearch_enabled = 0,
  $percona_experimental_noarch_enabled   = 0,
  $percona_experimental_source_enabled   = 0,
) {

  case $::osfamily {
    'RedHat': {
      require percona::rpm_gpg_key

      Yumrepo {
        ensure   => $ensure,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Percona',
      }

      yumrepo {
        'percona-release-$basearch':
          descr   => 'Percona-Release YUM repository - $basearch',
          baseurl => 'http://repo.percona.com/release/$releasever/RPMS/$basearch',
          enabled => $percona_release_basearch_enabled;

        'percona-release-noarch':
          descr   => 'Percona-Release YUM repository - noarch',
          baseurl => 'http://repo.percona.com/release/$releasever/RPMS/noarch',
          enabled => $percona_release_noarch_enabled;

        'percona-release-source':
          descr   => 'Percona-Release YUM repository - Source packages',
          baseurl => 'http://repo.percona.com/release/$releasever/SRPMS',
          enabled => $percona_release_source_enabled;

        'percona-testing-$basearch':
          descr   => 'Percona-Testing YUM repository - $basearch',
          baseurl => 'http://repo.percona.com/testing/$releasever/RPMS/$basearch',
          enabled => $percona_testing_basearch_enabled;

        'percona-testing-noarch':
          descr   => 'Percona-Testing YUM repository - noarch',
          baseurl => 'http://repo.percona.com/testing/$releasever/RPMS/noarch',
          enabled => $percona_testing_noarch_enabled;

        'percona-testing-source':
          descr   => 'Percona-Testing YUM repository - Source packages',
          baseurl => 'http://repo.percona.com/testing/$releasever/SRPMS',
          enabled => $percona_testing_source_enabled;

        'percona-experimental-$basearch':
          descr   => 'Percona-Experimental YUM repository - $basearch',
          baseurl => 'http://repo.percona.com/experimental/$releasever/RPMS/$basearch',
          enabled => $percona_experimental_basearch_enabled;

        'percona-experimental-noarch':
          descr   => 'Percona-Experimental YUM repository - noarch',
          baseurl => 'http://repo.percona.com/experimental/$releasever/RPMS/noarch',
          enabled => $percona_experimental_noarch_enabled;

        'percona-experimental-source':
          descr   => 'Percona-Experimental YUM repository - Source packages',
          baseurl => 'http://repo.percona.com/experimental/$releasever/SRPMS',
          enabled => $percona_experimental_source_enabled;
      }
    }
    'Debian': {
      apt::source { 'percona-release':
        ensure   => $ensure,
        location => 'http://repo.percona.com/apt',
        repos    => 'main',
        key      => {
          id      => '430BDF5C56E7C94E848EE60C1C4CBDCDCD2EFD2A',
          content => file('percona/GPG-key-percona'),
        },
        include  => {
          'src' => true,
          'deb' => true,
        },
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }

}

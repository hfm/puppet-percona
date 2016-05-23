# Class: percona::repo
# ===========================
#
# percona::repo is to setup repository.
class percona::repo {

  case $::osfamily {
    'RedHat': {
      require percona::rpm_gpg_key

      Yumrepo {
        ensure   => present,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Percona',
      }

      yumrepo {
        'percona-release-$basearch':
          descr   => 'Percona-Release YUM repository - $basearch',
          baseurl => 'http://repo.percona.com/release/$releasever/RPMS/$basearch',
          enabled => 1;

        'percona-release-noarch':
          descr   => 'Percona-Release YUM repository - noarch',
          baseurl => 'http://repo.percona.com/release/$releasever/RPMS/noarch',
          enabled => 1;

        'percona-release-source':
          descr   => 'Percona-Release YUM repository - Source packages',
          baseurl => 'http://repo.percona.com/release/$releasever/SRPMS',
          enabled => 0;

        'percona-testing-$basearch':
          descr   => 'Percona-Testing YUM repository - $basearch',
          baseurl => 'http://repo.percona.com/testing/$releasever/RPMS/$basearch',
          enabled => 0;

        'percona-testing-noarch':
          descr   => 'Percona-Testing YUM repository - noarch',
          baseurl => 'http://repo.percona.com/testing/$releasever/RPMS/noarch',
          enabled => 0;

        'percona-testing-source':
          descr   => 'Percona-Testing YUM repository - Source packages',
          baseurl => 'http://repo.percona.com/testing/$releasever/SRPMS',
          enabled => 0;

        'percona-experimental-$basearch':
          descr   => 'Percona-Experimental YUM repository - $basearch',
          baseurl => 'http://repo.percona.com/experimental/$releasever/RPMS/$basearch',
          enabled => 0;

        'percona-experimental-noarch':
          descr   => 'Percona-Experimental YUM repository - noarch',
          baseurl => 'http://repo.percona.com/experimental/$releasever/RPMS/noarch',
          enabled => 0;

        'percona-experimental-source':
          descr   => 'Percona-Experimental YUM repository - Source packages',
          baseurl => 'http://repo.percona.com/experimental/$releasever/SRPMS',
          enabled => 0;
      }
    }
    'Debian': {
      apt::source { 'percona-release':
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

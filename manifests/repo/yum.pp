# Class: percona::repo::yum
# ===========================
#
# percona::repo::yum is to setup yum repository.
class percona::repo::yum (
  $ensure                                = $percona::repo::ensure,
  $percona_release_basearch_enabled      = $percona::repo::percona_release_basearch_enabled,
  $percona_release_noarch_enabled        = $percona::repo::percona_release_noarch_enabled,
  $percona_release_source_enabled        = $percona::repo::percona_release_source_enabled,
  $percona_testing_basearch_enabled      = $percona::repo::percona_testing_basearch_enabled,
  $percona_testing_noarch_enabled        = $percona::repo::percona_testing_noarch_enabled,
  $percona_testing_source_enabled        = $percona::repo::percona_testing_source_enabled,
  $percona_experimental_basearch_enabled = $percona::repo::percona_experimental_basearch_enabled,
  $percona_experimental_noarch_enabled   = $percona::repo::percona_experimental_noarch_enabled,
  $percona_experimental_source_enabled   = $percona::repo::percona_experimental_source_enabled,
) {

  require percona::rpm_gpg_key

  yumrepo {
    default:
      ensure   => $ensure,
      gpgcheck => 1,
      gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Percona';

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

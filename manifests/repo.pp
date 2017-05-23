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
    'RedHat': { include percona::repo::yum }
    'Debian': {
      include ::apt
      require ::apt::update

      include percona::repo::apt
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }

}

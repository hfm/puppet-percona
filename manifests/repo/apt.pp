# Class: percona::repo::apt
# ===========================
#
# percona::repo::apt is to setup apt repository.
class percona::repo::apt (
  $ensure = $percona::repo::ensure,
) {

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

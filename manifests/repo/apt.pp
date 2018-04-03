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
      id     => '4D1BB29D63D98E422B2113B19334A25F8507EFA5',
      server => 'keyserver.ubuntu.com',
    },
    include  => {
      'src' => true,
      'deb' => true,
    },
  }

}

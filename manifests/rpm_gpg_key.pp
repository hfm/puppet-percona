# Class: percona::rpm_gpg_key
# ===========================
#
# Import the RPM GPG key for the Percona release.
#
# Parameters
# ----------
#
# * `ensure`
# Whether the RPM-GPG-KEY-Percona file should exist.
#
# * `path`
# The path to the RPM-GPG-KEY-percona file to manage. Must be an absolute path.
#
class percona::rpm_gpg_key (
  $ensure = present,
  $path   = '/etc/pki/rpm-gpg/RPM-GPG-KEY-Percona',
){

  file { $path:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => file('percona/GPG-key-percona'),
    before  => Exec['import-percona'],
  }

  exec { 'import-percona':
    command => "rpm --import ${path}",
    path    => ['/bin', '/usr/bin'],
    unless  => "rpm -q gpg-pubkey-$(gpg --throw-keyids ${path} | grep pub | cut -c 12-19 | tr '[A-Z]' '[a-z]')",
  }

}

# Class: percona::toolkit
# ===========================
#
# percona::toolkit is to install percona-toolkit.
#
# Parameters
# ----------
#
# * `ensure`
# What state the package should be in. Default to installed.
#
class percona::toolkit (
  $ensure = installed,
){

  require 'percona::repo'

  case $facts['osfamily'] {
    'Debian': {
      package { 'percona-toolkit':
        ensure => $ensure,
      }
    }
    default: {
      package { 'percona-toolkit':
        ensure => $ensure,
      }
    }
  }

}

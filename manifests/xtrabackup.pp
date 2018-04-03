# Class: percona::xtrabackup
# ===========================
#
# percona::xtrabackup is to install percona-xtrabackup.
#
# Parameters
# ----------
#
# * `ensure`
# What state the package should be in. Default to installed.
#
# * `version`
# Specify package version. Valid options: a string. Default to undef.
#
class percona::xtrabackup (
  $ensure  = installed,
  $version = undef,
){

  if $version {
    $suffix = regsubst($version, '^(\d)\.(\d)$','\1\2')

    $package_name = "percona-xtrabackup-${suffix}"
  } else {
    $package_name = 'percona-xtrabackup'
  }

  require 'percona::repo'

  case $facts['osfamily'] {
    'Debian': {
      package { $package_name:
        ensure => $ensure,
      }
    }
    default: {
      package { $package_name:
        ensure => $ensure,
      }
    }
  }

}

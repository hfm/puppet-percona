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
    validate_re($version, '^\d\.\d$')
    $suffix = regsubst($version, '^(\d)\.(\d)$','\1\2')

    $package_name = "percona-xtrabackup-${suffix}"
  } else {
    $package_name = 'percona-xtrabackup'
  }

  require 'percona::repo'

  package { $package_name:
    ensure => $ensure,
  }

}

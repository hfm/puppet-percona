# Class: percona
# ===========================
#
# Full description of class percona here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
class percona::toolkit (
  $ensure = installed,
){

  require 'percona::repo'

  package { 'percona-toolkit':
    ensure => $ensure,
  }

}

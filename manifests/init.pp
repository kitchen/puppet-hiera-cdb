# == Class: hiera_cdb
#
# installs dependencies required for hiera_cdb
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class hiera_cdb {

  case $::osfamily {
    Debian: {
      package { 'libcdb-dev':
        ensure => installed,
        before => Package['libcdb-ruby'],
      }
    }
    RedHat: {
      package { 'tinycdb-devel':
        ensure => installed,
        before => Package['libcdb-ruby'],
      }
    }
      
  }

  package { 'libcdb-ruby':
    provider => 'gem',
    ensure   => installed,
  }

}

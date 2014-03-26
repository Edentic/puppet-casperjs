# Class: casperjs
#
# This module installs the latest version of CasperJS on your UbuntuBox
#
# Parameters:
#
# Actions:
#
# Requires:
#   Ubuntu Box
#   puppetlabs/apt
#   edentic PhantomJS module
# Sample Usage:
#   include CasperJS

class casperjs::ppa-add {
  class { 'apt': }
  package { 'software-properties-common':
    ensure => present
  }

  apt::ppa{ 'ppa:chris-lea/node.js':
    require => Package['software-properties-common'],
  }
}

class casperjs::install {
  class {'phantomjs': }
  class {'casperjs::ppa-add':}

  package { 'python' :
    ensure => present
  }

  package { 'g++' :
    ensure => present
  }

  package { 'make' :
    ensure => present
  }

  package { 'python-software-properties' :
    ensure => present,
    require => Package['python']
  }

  package { 'nodejs' :
    ensure => '0.10.26-1chl1~precise1',
    require => [Class['casperjs::ppa-add'], Package['python'], Package['g++'], Package['make'], Package['python-software-properties']]
  }

  exec { 'casperjs-install' :
    command => 'npm install -g casperjs',
    logoutput => on_failure,
    require => [Package['nodejs'], Class['phantomjs']]
  }
}


class casperjs {
  include casperjs::install
}
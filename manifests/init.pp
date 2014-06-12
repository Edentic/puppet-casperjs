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
#   puppetlabs/nodejs
#   edentic PhantomJS module
# Sample Usage:
#   include CasperJS

class casperjs::install {
  class {'phantomjs': }

  package { 'casperjs':
    ensure   => present,
    provider => 'npm',
    require => [Class['nodejs'], Class['phantomjs']]
  }
}

class casperjs {
  include casperjs::install
}
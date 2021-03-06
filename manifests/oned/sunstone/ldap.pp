# == Class one::oned::sunstone::ldap
#
# Installation and Configuration of OpenNebula
# http://opennebula.org/
#
# === Author
# ePost Development GmbH
# (c) 2013
#
# Contributors:
# - Martin Alfke
# - Achim Ledermueller (Netways GmbH)
# - Sebastian Saemann (Netways GmbH)
#
# === License
# Apache License Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0.html
#
class one::oned::sunstone::ldap (
  $oned_sunstone_ldap_pkg = $one::oned_sunstone_ldap_pkg
) {
  package { $oned_sunstone_ldap_pkg:
    ensure => 'latest',
  } ->
  file { '/var/lib/one/remotes/auth/default':
    ensure => link,
    owner  => 'oneadmin',
    group  => 'oneadmin',
    target => '/var/lib/one/remotes/auth/ldap',
  } ->
  file { '/etc/one/auth/ldap_auth.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'oneadmin',
    mode    => '0640',
    content => template('one/ldap_auth.conf.erb'),
    notify  => Service['opennebula'],
  }
}

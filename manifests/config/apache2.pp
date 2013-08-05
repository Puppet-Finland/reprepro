#
# == Class: reprepro::config::apache2
#
# Configure Apache2 for serving reprepro repositories
#
class reprepro::config::apache2($documentroot) {

    file { 'reprepro-reprepro-apache2':
        name => '/etc/apache2/conf.d/reprepro',
        ensure => present,
        content => template('reprepro/reprepro-apache2.erb'),
        owner => root,
        group => root,
        mode => 644,
        require => Class['apache2::install'],
        notify => Class['apache2::service'],
    }
}

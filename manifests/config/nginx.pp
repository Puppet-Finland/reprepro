#
# == Class: reprepro::config::nginx
#
# Configure reprepro to serve reprepro repositories
#
# WARNING: this may break other nginx sites on the same server, as nginx assumes 
# one configuration file is used.
#
class reprepro::config::nginx($documentroot) {

    file { 'reprepro-reprepro-nginx':
        name => '/etc/nginx/sites-enabled/reprepro',
        ensure => present,
        content => template('reprepro/reprepro-nginx.erb'),
        owner => root,
        group => root,
        mode => 644,
        require => Class['nginx::install'],
        notify => Class['nginx::service'],
    }
}

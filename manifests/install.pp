#
# == Class: reprepro::install
#
# Install reprepro
#
class reprepro::install {

    package { 'reprepro':
        name => 'reprepro',
        ensure => installed,
    }

    package { 'dpkg-sig':
        name => 'dpkg-sig',
        ensure => installed,
    }
}

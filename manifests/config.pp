#
# == Class: reprepro::config
#
# Prepare repository base directories
#
class reprepro::config {

    file { [ '/var/www/repos/apt', '/var/www/repos/apt/conf' ]:
        ensure => directory,
    }
}

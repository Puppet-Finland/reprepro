#
# == Class: reprepro::config
#
# Prepare repository base directories
#
class reprepro::config($documentroot) {

    file { [ "${documentroot}/repos/apt", "${documentroot}/repos/apt/conf" ]:
        ensure => directory,
    }
}

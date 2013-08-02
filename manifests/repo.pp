#
# == Define: reprepro::repo
#
# Setup a reprepro repository
#
# NOTE: you will need to add a file 'override' to Puppet's main file server 
# directory (usually /etc/puppet/files) or this module will fail. You will also 
# need to update that file whenever you add new packages (not new versions of 
# old packages) to the repository. You can use templates/override.sample as a 
# starting point.
#
# == Parameters
#
# [*reponame*]
#   Name of the repository. This must be unique, as it's used for the name of 
#   the repository directory. Defaults to $title, i.e. name of the resources.
# [*codename*]
#   Distribution codename for this repository. Must match a valid codename for 
#   overrides won't work. For example 'wheezy' or 'precise'.
# [*architectures*]
#   A space-separated list of supported architectures. Defaults to 'i386 amd64'. 
# [*description*]
#   Description of this repository. Defaults to 'no description'.
# [*gpg_key_id*]
#   ID of the GPG key used for signing the packages. Defaults to top-scope 
#   variable $::apt_gpg_key_id.
#
# == Examples
#
# reprepro::repo { 'wheezy-stable':
#   codename => 'wheezy',
#   architectures => 'i386 amd64',
#   description => 'Wheezy repo for Acme Inc.'
#   gpg_key_id => 'E933A251',
# }
#
define reprepro::repo
(
    $reponame=$title,
    $codename,
    $architectures='i386 amd64',
    $description=$title,
    $gpg_key_id = $::apt_gpg_key_id
)
{
    file { "reprepro-${reponame}":
        name => "/var/www/repos/apt/${reponame}",
        ensure => directory,
        owner => root,
        group => root,
        mode => 755,
        require => Class['reprepro::config'],
    }

    file { "reprepro-${reponame}-conf":
        name => "/var/www/repos/apt/${reponame}/conf",
        ensure => directory,
        owner => root,
        group => root,
        mode => 755,
        require => File["reprepro-${reponame}"],
    }

    file { "reprepro-${reponame}-distributions":
        name => "/var/www/repos/apt/${reponame}/conf/distributions",
        ensure => present,
        content => template('reprepro/distributions.erb'),
        owner => root,
        group => root,
        mode => 644,
        require => File["reprepro-${reponame}-conf"],
    }

    file { "reprepro-override.${reponame}":
        name => "/var/www/repos/apt/${reponame}/conf/override.${codename}",
        ensure => present,
        source => 'puppet:///files/override',
        owner => root,
        group => root,
        mode => 644,
        require => File["reprepro-${reponame}-conf"],
    }

    file { "reprepro-${reponame}-options":
        name => "/var/www/repos/apt/${reponame}/conf/options",
        ensure => present,
        content => template('reprepro/options.erb'),
        owner => root,
        group => root,
        mode => 644,
        require => File["reprepro-${reponame}-conf"],
    }

    file { "reprepro-${reponame}.list":
        name => "/var/www/repos/apt/conf/${fqdn}-${reponame}.list",
        ensure => present,
        content => template('reprepro/codename.list.erb'),
        owner => root,
        group => root,
        mode => 644,
        require => Class['reprepro::config'],
    }

    file { "reprepro-${reponame}.txt":
        name => "/var/www/repos/apt/conf/${fqdn}-${reponame}.txt",
        ensure => present,
        content => template('reprepro/codename.txt.erb'),
        owner => root,
        group => root,
        mode => 644,
        require => Class['reprepro::config'],
    }
}

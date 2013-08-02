#
# == Class: reprepro
#
# Manage reprepro repositories.
#
# == Parameters
#
# [*configure_webserver*]
#   Select which webserver to configure. Valid values 'apache2', 'nginx' and 
#   'false' (don't configure). Defaults to 'false'.
#
#   WARNING: The 'nginx' configuration parameter can be dangerous if nginx is 
#   hosting other things besides these apt repos.
#
# == Examples
#
# class { 'reprepro':
#   configure_webserver => 'apache2',
# }
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-lisence
# See file LICENSE for details
#
class reprepro
(
    $configure_webserver='false'
)
{
    include reprepro::install
    include reprepro::config

    if $configure_webserver == 'nginx' {
        include reprepro::config::nginx
    } elsif $configure_webserver == 'apache2' {
        include reprepro::config::apache2
    }
}

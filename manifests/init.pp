#
# == Class: reprepro
#
# Manage reprepro repositories.
#
# == Parameters
# [*documentroot*]
#   Web server's document root directory. Defaults to
#   $::softwarerepo::config::documentroot, which defaults to
#   $::webserver::config::documentroot, which is '/var/www' by default.
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
    $documentroot=$::softwarerepo::config::documentroot,
    $configure_webserver='false'
)
{

# Rationale for this is explained in init.pp of the sshd module
if hiera('manage_reprepro', 'true') != 'false' {

    include reprepro::install

    class { 'reprepro::config':
        documentroot => $documentroot,
    }

    if $configure_webserver == 'nginx' {
        class { 'reprepro::config::nginx':
            documentroot => $documentroot,
        }
    } elsif $configure_webserver == 'apache2' {
        class { 'reprepro::config::apache2':
            documentroot => $documentroot,
        }
    }
}
}

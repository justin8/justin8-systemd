#
class systemd {

  include systemd::params

  if ( str2bool($::systemd_available) ) {
    exec { 'systemd-daemon-reload':
      path        => '/bin:/usr/bin:/sbin:/usr/sbin',
      command     => 'systemctl daemon-reload',
      refreshonly => true
    }
  }

}

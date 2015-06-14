class systemd {

  exec { 'systemd-daemon-reload':
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    command     => 'systemctl daemon-reload',
    refreshonly => true,
  }

  case $::osfamily {
    'Archlinux': {
      $unit_path = '/usr/lib/systemd/system'
    }
    'Debian': {
      $unit_path = '/lib/systemd/system'
    }
    'RedHat': {
      $unit_path = '/usr/lib/systemd/system'
    }
    default: {
      $unit_path = undef
    }
  }


}

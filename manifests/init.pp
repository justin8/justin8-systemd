class systemd {

  if ( str2bool("$::systemd_available") ) {
    exec { 'systemd-daemon-reload':
      path        => '/bin:/usr/bin:/sbin:/usr/sbin',
      command     => 'systemctl daemon-reload',
      refreshonly => true
    }

    # refresh systemd before every service
    Exec['systemd-daemon-reload'] -> Service<| |>
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
      $unit_path = '/usr/lib/systemd/system'
    }
  }


}

#
class systemd::params {
  case $::osfamily {
    'Archlinux': {
      $unit_path = '/etc/systemd/system'
    }
    'Debian': {
      $unit_path = '/etc/systemd/system'
    }
    'RedHat': {
      $unit_path = '/etc/systemd/system'
    }
    default: {
      $unit_path = '/etc/systemd/system'
    }
  }
}

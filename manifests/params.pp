#
class systemd::params {
  case $::osfamily {
    'Archlinux': {
      $unit_path    = '/etc/systemd/system'
      $package_name = 'systemd'
    }
    'Debian': {
      $unit_path    = '/etc/systemd/system'
      $package_name = 'systemd'
    }
    'RedHat': {
      $unit_path    = '/etc/systemd/system'
      $package_name = 'systemd'
    }
    default: {
      $unit_path    = '/etc/systemd/system'
      $package_name = 'systemd'
    }
  }
}

class systemd(
  $ensure  = present,
) {
  include ::systemd::params

  package { $::systemd::params::package_name:
    ensure => $ensure,
  }

  exec { 'systemd-daemon-reload':
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    command     => 'systemctl daemon-reload',
    refreshonly => true,
    require     => Package[$::systemd::params::package_name],
  }

  # # refresh systemd before every service
  # Exec['systemd-daemon-reload'] -> Service<| provider="systemd" |>
}

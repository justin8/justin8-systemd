define systemd::service (
  $ensure          = present,
  $execstart,
  $execstartpre    = undef,
  $execstartpost   = undef,
  $servicename     = $name,
  $description     = '',
  $execstop        = undef,
  $execstoppost    = undef,
  $execreload      = undef,
  $workingdir      = undef,
  $restart         = 'always',
  $restartsec      = undef,
  $remainafterexit = false,
  $user            = 'root',
  $group           = 'root',
  $type            = 'simple',
  $defaultdeps     = true,
  $requires        = [],
  $conflicts       = [],
  $wants           = [],
  $after           = [],
  $wantedby        = ['multi-user.target'],
  $unit_path       = undef,
) {
  include ::systemd

  $real_unit_path = $unit_path ? {
    undef   => $::systemd::params::unit_path,
    default => $unit_path,
  }

  validate_re( $restart, ['^always$', '^no$', '^on-(success|failure|abnormal|abort|watchdog)$'], "Not a supported restart type: ${restart}" )
  validate_bool( $remainafterexit )
  validate_re( $type, ['^simple$', '^forking$', '^oneshot$', '^dbus$', '^notify$', '^idle$'], "Not a supported type: ${type}" )
  validate_bool( $defaultdeps )
  validate_array( $requires )
  validate_array( $conflicts )
  validate_array( $wants )
  validate_array( $after )
  validate_array( $wantedby )

  file { "${real_unit_path}/${servicename}.service":
    ensure  => $ensure,
    content => template("${module_name}/service.erb"),
    group   => 'root',
    owner   => 'root',
    mode    => '0644',
    notify  => Exec['systemd-daemon-reload'],
    require => Package[$::systemd::params::package_name],
  }
}

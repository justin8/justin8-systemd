#
define systemd::service (
    $execstart,
    $servicename     = $name,
    $description     = '',
    $execstop        = undef,
    $execreload      = undef,
    $workingdir      = undef,
    $restart         = 'always',
    $restartsec      = undef,
    $remainafterexit = false,
    $user            = 'root',
    $group           = 'root',
    $type            = 'simple',
    $defaultdeps     = true,
    $syslog          = true,
    $requires        = [],
    $conflicts       = [],
    $wants           = [],
    $after           = [],
    $wantedby        = ['multi-user.target'],
    $unit_path       = $systemd::params::unit_path,
) {

    include systemd

    validate_re($restart, ['^always$', '^no$', '^on-(success|failure|abnormal|abort|watchdog)$'], "Not a supported restart type: ${restart}")
    validate_bool($remainafterexit)
    validate_re($type, ['^simple$', '^forking$', '^oneshot$', '^dbus$', '^notify$', '^idle$'], "Not a supported type: ${type}")
    validate_bool($defaultdeps)
    validate_array($requires)
    validate_array($conflicts)
    validate_array($wants)
    validate_array($after)
    validate_array($wantedby)
    validate_bool($syslog)

    file { "${unit_path}/${servicename}.service":
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/service.erb"),
        notify  => Exec['systemd-daemon-reload'],
    }
}

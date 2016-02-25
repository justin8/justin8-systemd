#
define systemd::service (
    $execstart,
    $servicename    = $name,
    $description    = '',
    $execstop       = undef,
    $execreload     = undef,
    $workingdir     = undef,
    $restart        = 'always',
    $restartsec     = undef,
    $user           = 'root',
    $group          = 'root',
    $type           = undef,
    $defaultdeps    = true,
    $requires       = [],
    $conflicts      = [],
    $wants          = ['syslog.target'],
    $after          = ['syslog.target'],
    $wantedby       = ['multi-user.target'],
) {

    include systemd

    validate_re($restart, ['^always$', '^no$', '^on-(success|failure|abnormal|abort|watchdog)$'], "Not a supported restart type: ${restart}")

    file { "${::systemd::unit_path}/${servicename}.service":
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/service.erb"),
        notify  => Exec['systemd-daemon-reload'],
    }
}

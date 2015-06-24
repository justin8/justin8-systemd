[![Build Status](https://travis-ci.org/justin8/justin8-systemd.svg)](https://travis-ci.org/justin8/justin8-systemd)

# Justin8-Systemd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup - The basics of getting started with systemd](#setup)
    * [What systemd affects](#what-systemd-affects)
    * [Beginning with systemd](#beginning-with-systemd)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module provides some basic functionality around systemd within puppet to better allow modules to support both systemd and legacy init systems within the same module.

## Module Description

This module provides a fact to identify systemd-enabled systems and an exec that can be called to reload systemd daemon configurations.

## Setup

### What systemd affects

* Nothing

### Beginning with systemd

The module will do nothing by itself. It is only to be used as support for other modules.

Check the usage section for details.



The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

The most basic usage is as follows (within another module):

```
include systemd
```
This will give you access to $::systemd::unit_path which is usually /usr/lib/systemd/system or /lib/systemd/system depending on distro.

It will also give you access to the systemd_available fact, which evaluates to 'true' if systemd is available.

There is an exec called 'systemd-daemon-reload' that can be called to refresh configurations when they are changed so it isn't required seperately in each module.

Hopefully this will be unecessary in future puppet releases, but currently there is no way to tell the init system, and no way to auto-reload systemd daemons when they change.

An example usage is below:

```
if $::systemd_available == 'true' {
    file {"${::systemd::unit_path}/foo.service":
        content => template('foo/foo.service.erb'),
        before  => Service['foo'],
        notify  => Exec['systemd-daemon-reload'],
    }
}

service { 'foo:
    ensure => running,
    after  => Exec['systemd-daemon-reload'],
```

## Limitations

Works with all Linux distributions! (Untested on most ;))
On non-systemd distributions it will provide the systemd_available fact as 'false', but nothing else (as intended).

## Development

Pull requests welcome via github.

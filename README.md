# puppet-percona

[![Build Status](https://img.shields.io/travis/hfm/puppet-percona/master.svg?style=flat-square)](https://travis-ci.org/hfm/puppet-percona)
[![Puppet Forge](https://img.shields.io/puppetforge/v/hfm/percona.svg?style=flat-square)](https://forge.puppet.com/hfm/percona)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with percona](#setup)
    * [Beginning with percona](#beginning-with-percona)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
  - [Public Classes](#public-classes)
  - [Private Classes](#private-classes)
  - [Parameters](#parameters)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module installs, configures, and manages the [Percona](https://www.percona.com) products.

## Setup

### Beginning with percona

To configure the percona::repo with default parameters, declare the `percona::repo` class.

```puppet
include 'percona::repo'
```

## Usage

### Configuring modules

```puppet
class { 'percona::repo':
  percona_release_basearch_enabled => 0,
  percona_release_noarch_enabled   => 0,
}
```

### Configuring modules from Hiera

```yaml
---
# default off
percona::repo::percona_release_basearch_enabled: 0
percona::repo::percona_release_noarch_enabled: 0
```

## Reference

### Public Classes

- `percona::repo`: Configure the Percona repository and import the GPG keys.
- [`percona::toolkit`](#class-perconatoolkit): Install and configures [percona-toolkit](https://www.percona.com/doc/percona-toolkit).
- [`percona::xtrabackup`](#class-perconaxtrabackup): Install and configures [percona-xtrabackup](https://www.percona.com/doc/percona-xtrabackup).

### Private Classes

- `percona::rpm_gpg_key`: Import the RPM GPG key for the Percona.

### Parameters

#### Class: percona::toolkit

- `ensure`: What state the package should be in. Default to installed.

#### Class: percona::xtrabackup

- `ensure`: What state the package should be in. Default to installed.
-  `version`: Specify package version. Valid options: a string. Default to undef.

## Limitations

This module has been tested on:

- RedHat Enterprise Linux 5, 6, 7
- CentOS 5, 6, 7
- Scientific Linux 5, 6, 7
- Ubuntu 12.04, 14.04, 16.04
- Debian 6, 7, 8

## Development

### Running tests

The STNS puppet module contains tests for both [rspec-puppet](http://rspec-puppet.com/) (unit tests) and [beaker-rspec](https://github.com/puppetlabs/beaker-rspec) (acceptance tests) to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart

- Unit tests:

```console
$ bundle install
$ bundle exec rake all
```

- Acceptance tests:

```console
# Set your DOCKER_HOST variable
$ eval "$(docker-machine env default)"

# Run beaker acceptance tests
$ BEAKER_set=centos7 bundle exec rake beaker
```

# site.pp with node definitions for a two-node wordpress config

# global default -- all packages need our local source
if $osfamily == 'Debian' {
  Package { require => Apt::Source['puppet'] }
}

node 'webnode' {

  include common

  include apache
  include apache::mod::php

  package { 'php5-mysql':
    ensure => latest,
    require => Class['apache::mod::php'],
    notify  => Service['httpd'],
  }

  apache::vhost { 'default':
    port    => '80',
    docroot => '/opt/wordpress',
  }

  # this is like 'include wordpress' with parameters
  class { 'wordpress':
    install_url    => 'http://puppet/wordpress',
    create_db      => false,
    create_db_user => false,
    db_host        => 'dbnode',
    db_password    => 'puppetr0x',
    require        => Host['dbnode']
  }

  host { 'dbnode':
    ensure => present,
    ip     => '192.168.23.21'
  }

}

node 'dbnode' {
  include common

  class { 'mysql::server':
    config_hash => { 
      'root_password' => 'puppetr0x',  
      'bind_address'  => '*'
    }
  }

  # this is a defined type that looks like a resource
  mysql::db { 'wordpress':
    ensure   => present,
    user     => 'wordpress',
    password => 'puppetr0x',
    host     => 'webnode',
    grant    => ['all'],
  }

  host { 'webnode':
    ensure => present,
    ip     => '192.168.23.20'
  }

}

node 'glitched' {
  include common::master
}

node 'default' {
  include common
}


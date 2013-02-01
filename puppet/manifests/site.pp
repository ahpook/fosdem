# site.pp with node definitions for a two-node wordpress config

# global default -- all packages need our local source
Package { require => Apt::Source['puppet'] }

node 'webnode' {

  include common

  include apache

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
    ensure   => absent,
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

node 'default' {
  include common
}


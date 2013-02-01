# site.pp with node definitions for a two-node config

node 'webnode' {
  include common

  include apache

  # this is like 'include wordpress' with parameters
  class { 'wordpress':
    install_url    => 'http://puppet/wordpress.tar.gz',
    create_db      => 'false',
    create_db_user => 'false',
    db_host        => 'dbnode',
    db_password    => 'puppetr0x',
  }

}

node 'dbnode' {
  include common

  class { 'mysql::server':
    config_hash => { 'root_password' => 'puppetr0x' }
  }

  mysql::db { 'wordpress':
    user     => 'wordpress',
    password => 'puppetr0x',
    host     => 'localhost',
    grant    => ['all']
  }

}

class common::dbnode {

  class { 'mysql::server':
    config_hash => { 
      'root_password' => 'puppetr0x',  
      'bind_address'  => '*'
    }
  }

  # this is a defined type that looks like a resource
  mysql::db { 'wordpress':
    user     => 'wordpress',
    password => 'puppetr0x',
    host     => 'webnode',
    grant    => ['all'],
  }

}

class common {

  class { 'apt':
    always_apt_update  => true,
    disable_keys       => true,
    purge_sources_list => true,
  }

  apt::source { 'puppet':
    location   => 'http://puppet/ubuntu/',
    release    => 'precise',
    repos      => 'main',
    key        => '4BD6EC30',
    key_server => 'pgp.mit.edu',
  }

  package { 'puppet':
    ensure => latest,
  }

}

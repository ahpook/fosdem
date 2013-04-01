
# sets up a puppet master to serve the ubuntu repos needed to bootstrap the 
# other nodes

class common::master {

  include apache

  apache::vhost { 'puppet':
    port    => '80',
    docroot => '/Sandbox',
    configure_firewall => true,
  }

}

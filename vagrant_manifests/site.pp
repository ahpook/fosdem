
node default {

  include common

  # set up name resolution so we can get to the master
  host { 'puppet':
    ensure       => present,
    host_aliases => [ 'glitched','glitched.local' ],
    ip           => '192.168.23.10',
  }

  $keydir = "/var/lib/puppet/ssl/private_keys"

  exec { "make_keydir":
    command => "/bin/mkdir -p ${keydir}":
    creates => $keydir
  }

  file { "${keydir}/${fqdn}.pem":
    owner => 0, group => 0, mode => 0600,
    content => file("/tmp/vagrant-puppet/manifests/${fqdn}.pem"),
    require => Exec["make_keydir"],
  }

}

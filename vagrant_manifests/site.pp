
node default {

  # set up name resolution so we can get to the master
  host { "puppet":
    ensure => present,
    host_aliases => [ "glitched","glitched.local" ],
    ip => "192.168.23.10",
  }

}

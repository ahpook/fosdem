class common {
  include apt

  apt::source { 'puppet':
      location => 'http://puppet/ubuntu/',
      release  => 'precise',
      repos    => 'main',
  }

}

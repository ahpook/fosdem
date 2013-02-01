class common {
  include apt

  apt::source { "local_cache":
      location          => "http://puppet/ubuntu/",
      release           => "precise",
      repos             => "main",
  }

}

class memcachephp::apache::packages {
  package {[
      'apache2'
    ]:
    ensure => present
  }
}

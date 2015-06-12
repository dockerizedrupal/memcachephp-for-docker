class memcachephp::httpd::packages {
  package {[
      'apache2'
    ]:
    ensure => present
  }
}

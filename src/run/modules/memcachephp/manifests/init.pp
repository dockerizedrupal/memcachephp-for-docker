class memcachephp {
  if ! file_exists('/memcachephp/ssl/certs/memcachephp.crt') {
    require memcachephp::httpd::ssl
  }

  file { '/memcachephp/data/index.php':
    ensure => present,
    content => template('memcachephp/memcache.php.erb')
  }
}

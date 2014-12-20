class memcachephp {
  if ! file_exists('/memcachephp/ssl/certs/memcachephp.crt') {
    require memcachephp::httpd::ssl
  }

  file { '/memcachephp/data/etc/config.local.php':
    ensure => present,
    content => template('memcachephp/config.local.php.erb')
  }
}

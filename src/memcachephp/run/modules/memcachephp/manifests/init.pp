class memcachephp {
  include memcachephp::httpd

  file { '/var/www/index.php':
    ensure => present,
    content => template('memcachephp/memcache.php.erb')
  }
}

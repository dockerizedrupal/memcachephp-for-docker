class memcachephp {
  include memcachephp::apache

  file { '/var/www/index.php':
    ensure => present,
    content => template('memcachephp/memcache.php.erb')
  }
}

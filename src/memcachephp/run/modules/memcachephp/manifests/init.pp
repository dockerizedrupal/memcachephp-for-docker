class memcachephp {
  include memcachephp::apache
  include memcachephp::timezone

  file { '/var/www/index.php':
    ensure => present,
    content => template('memcachephp/memcache.php.erb')
  }
}

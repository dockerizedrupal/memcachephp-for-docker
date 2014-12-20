class memcachephp::php {
  require memcachephp::php::packages

  file { '/etc/php5/apache2/php.ini':
    ensure => present,
    source => 'puppet:///modules/memcachephp/etc/php5/apache2/php.ini',
    mode => 644
  }
}

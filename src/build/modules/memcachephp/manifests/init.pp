class memcachephp {
  require memcachephp::php
  require memcachephp::httpd

  file { '/tmp/memcache.php-master.zip':
    ensure => present,
    source => 'puppet:///modules/memcachephp/tmp/memcache.php-master.zip'
  }

  exec { 'unzip memcache.php-master.zip':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => File['/tmp/memcache.php-master.zip']
  }

  exec { 'rsync -avz memcache.php-master/ /memcachephp/data':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => Exec['unzip memcache.php-master.zip']
  }

  exec { 'mv /memcachephp/data/memcache.php /memcachephp/data/index.php':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['rsync -avz memcache.php-master/ /memcachephp/data']
  }
}

class memcachephp::apache::supervisor {
  file { '/etc/supervisor/conf.d/apache.conf':
    ensure => present,
    source => 'puppet:///modules/memcachephp/etc/supervisor/conf.d/apache.conf',
    mode => 644
  }

  file { '/etc/supervisor/conf.d/apache_stdout.conf':
    ensure => present,
    source => 'puppet:///modules/memcachephp/etc/supervisor/conf.d/apache_stdout.conf',
    mode => 644
  }

  file { '/etc/supervisor/conf.d/apache_stderr.conf':
    ensure => present,
    source => 'puppet:///modules/memcachephp/etc/supervisor/conf.d/apache_stderr.conf',
    mode => 644
  }
}

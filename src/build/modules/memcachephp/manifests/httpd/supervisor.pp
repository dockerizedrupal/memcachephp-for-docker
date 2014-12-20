class memcachephp::httpd::supervisor {
  file { '/etc/supervisor/conf.d/httpd.conf':
    ensure => present,
    source => 'puppet:///modules/memcachephp/etc/supervisor/conf.d/httpd.conf',
    mode => 644
  }
}

class memcachephp::httpd::ssl {
  exec { 'mkdir -p /memcachephp/ssl':
    path => ['/bin']
  }

  exec { 'mkdir -p /memcachephp/ssl/private':
    path => ['/bin'],
    require => Exec['mkdir -p /memcachephp/ssl']
  }

  exec { 'mkdir -p /memcachephp/ssl/certs':
    path => ['/bin'],
    require => Exec['mkdir -p /memcachephp/ssl/private']
  }

  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('memcachephp/opensslCA.cnf.erb'),
    require => Exec['mkdir -p /memcachephp/ssl/certs']
  }

  exec { 'openssl genrsa -out /memcachephp/ssl/private/memcachephpCA.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/opensslCA.cnf']
  }

  exec { "openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /memcachephp/ssl/private/memcachephpCA.key -out /memcachephp/ssl/certs/memcachephpCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /memcachephp/ssl/private/memcachephpCA.key 4096']
  }

  exec { 'openssl genrsa -out /memcachephp/ssl/private/memcachephp.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /memcachephp/ssl/private/memcachephpCA.key -out /memcachephp/ssl/certs/memcachephpCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('memcachephp/openssl.cnf.erb'),
    require => Exec['openssl genrsa -out /memcachephp/ssl/private/memcachephp.key 4096']
  }

  exec { "openssl req -sha256 -new -config /root/openssl.cnf -key /memcachephp/ssl/private/memcachephp.key -out /memcachephp/ssl/certs/memcachephp.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/openssl.cnf']
  }

  exec { "openssl x509 -req -sha256 -CAcreateserial -days 3650 -extensions v3_req -extfile /root/opensslCA.cnf -in /memcachephp/ssl/certs/memcachephp.csr -CA /memcachephp/ssl/certs/memcachephpCA.crt -CAkey /memcachephp/ssl/private/memcachephpCA.key -out /memcachephp/ssl/certs/memcachephp.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -new -config /root/openssl.cnf -key /memcachephp/ssl/private/memcachephp.key -out /memcachephp/ssl/certs/memcachephp.csr"]
  }
}

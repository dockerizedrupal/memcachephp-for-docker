class memcachedphp::memcachedphp::ssl {
  exec { 'mkdir -p /memcachedphp/ssl':
    path => ['/bin']
  }

  exec { 'mkdir -p /memcachedphp/ssl/private':
    path => ['/bin'],
    require => Exec['mkdir -p /memcachedphp/ssl']
  }

  exec { 'mkdir -p /memcachedphp/ssl/certs':
    path => ['/bin'],
    require => Exec['mkdir -p /memcachedphp/ssl/private']
  }

  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('memcachedphp/opensslCA.cnf.erb'),
    require => Exec['mkdir -p /memcachedphp/ssl/certs']
  }

  exec { 'openssl genrsa -out /memcachedphp/ssl/private/memcachedphpCA.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/opensslCA.cnf']
  }

  exec { "openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /memcachedphp/ssl/private/memcachedphpCA.key -out /memcachedphp/ssl/certs/memcachedphpCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /memcachedphp/ssl/private/memcachedphpCA.key 4096']
  }

  exec { 'openssl genrsa -out /memcachedphp/ssl/private/memcachedphp.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /memcachedphp/ssl/private/memcachedphpCA.key -out /memcachedphp/ssl/certs/memcachedphpCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('memcachedphp/openssl.cnf.erb'),
    require => Exec['openssl genrsa -out /memcachedphp/ssl/private/memcachedphp.key 4096']
  }

  exec { "openssl req -sha256 -new -config /root/openssl.cnf -key /memcachedphp/ssl/private/memcachedphp.key -out /memcachedphp/ssl/certs/memcachedphp.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/openssl.cnf']
  }

  exec { "openssl x509 -req -sha256 -CAcreateserial -days 3650 -extensions v3_req -extfile /root/opensslCA.cnf -in /memcachedphp/ssl/certs/memcachedphp.csr -CA /memcachedphp/ssl/certs/memcachedphpCA.crt -CAkey /memcachedphp/ssl/private/memcachedphpCA.key -out /memcachedphp/ssl/certs/memcachedphp.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -new -config /root/openssl.cnf -key /memcachedphp/ssl/private/memcachedphp.key -out /memcachedphp/ssl/certs/memcachedphp.csr"]
  }
}

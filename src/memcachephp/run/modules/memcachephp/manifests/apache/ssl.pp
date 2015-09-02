class memcachephp::apache::ssl {
  bash_exec { 'mkdir -p /memcachephp/ssl': }

  bash_exec { 'mkdir -p /memcachephp/ssl/private':
    require => Bash_exec['mkdir -p /memcachephp/ssl']
  }

  bash_exec { 'mkdir -p /memcachephp/ssl/certs':
    require => Bash_exec['mkdir -p /memcachephp/ssl/private']
  }

  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('memcachephp/opensslCA.cnf.erb'),
    require => Bash_exec['mkdir -p /memcachephp/ssl/certs']
  }

  bash_exec { 'openssl genrsa -out /memcachephp/ssl/private/memcachephpCA.key 4096':
    timeout => 0,
    require => File['/root/opensslCA.cnf']
  }

  bash_exec { "openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /memcachephp/ssl/private/memcachephpCA.key -out /memcachephp/ssl/certs/memcachephpCA.crt":
    timeout => 0,
    require => Bash_exec['openssl genrsa -out /memcachephp/ssl/private/memcachephpCA.key 4096']
  }

  bash_exec { 'openssl genrsa -out /memcachephp/ssl/private/memcachephp.key 4096':
    timeout => 0,
    require => Bash_exec["openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /memcachephp/ssl/private/memcachephpCA.key -out /memcachephp/ssl/certs/memcachephpCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('memcachephp/openssl.cnf.erb'),
    require => Bash_exec['openssl genrsa -out /memcachephp/ssl/private/memcachephp.key 4096']
  }

  bash_exec { "openssl req -sha256 -new -config /root/openssl.cnf -key /memcachephp/ssl/private/memcachephp.key -out /memcachephp/ssl/certs/memcachephp.csr":
    timeout => 0,
    require => File['/root/openssl.cnf']
  }

  bash_exec { "openssl x509 -req -sha256 -CAcreateserial -days 3650 -extensions v3_req -extfile /root/opensslCA.cnf -in /memcachephp/ssl/certs/memcachephp.csr -CA /memcachephp/ssl/certs/memcachephpCA.crt -CAkey /memcachephp/ssl/private/memcachephpCA.key -out /memcachephp/ssl/certs/memcachephp.crt":
    timeout => 0,
    require => Bash_exec["openssl req -sha256 -new -config /root/openssl.cnf -key /memcachephp/ssl/private/memcachephp.key -out /memcachephp/ssl/certs/memcachephp.csr"]
  }
}

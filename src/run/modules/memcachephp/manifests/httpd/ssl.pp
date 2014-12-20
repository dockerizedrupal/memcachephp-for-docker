class memcachephp::httpd::ssl {
  exec { 'openssl genrsa -out /memcachephp/ssl/private/memcachephpCA.key 4096':
    timeout => 0,
    path => ['/usr/bin']
  }

  exec { "openssl req -x509 -new -nodes -key /memcachephp/ssl/private/memcachephpCA.key -days 365 -subj /C=/ST=/L=/O=/CN=memcachephp -out /memcachephp/ssl/certs/memcachephpCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /memcachephp/ssl/private/memcachephpCA.key 4096']
  }

  exec { 'openssl genrsa -out /memcachephp/ssl/private/memcachephp.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -x509 -new -nodes -key /memcachephp/ssl/private/memcachephpCA.key -days 365 -subj /C=/ST=/L=/O=/CN=memcachephp -out /memcachephp/ssl/certs/memcachephpCA.crt"]
  }

  $subj = "/C=/ST=/L=/O=/CN=$server_name"

  exec { "openssl req -sha256 -new -key /memcachephp/ssl/private/memcachephp.key -subj $subj -out /memcachephp/ssl/certs/memcachephp.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /memcachephp/ssl/private/memcachephp.key 4096']
  }

  exec { "openssl x509 -req -in /memcachephp/ssl/certs/memcachephp.csr -CA /memcachephp/ssl/certs/memcachephpCA.crt -CAkey /memcachephp/ssl/private/memcachephpCA.key -CAcreateserial -out /memcachephp/ssl/certs/memcachephp.crt -days 365":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -new -key /memcachephp/ssl/private/memcachephp.key -subj $subj -out /memcachephp/ssl/certs/memcachephp.csr"]
  }
}

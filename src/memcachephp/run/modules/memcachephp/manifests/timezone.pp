class memcachephp::timezone {
  bash_exec { "timedatectl set-timezone $timezone": }
}

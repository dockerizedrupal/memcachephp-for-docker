#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/memcachephp/build.sh && /src/memcachephp/clean.sh"
    ;;
  run)
    /bin/su - root -mc "source /src/memcachephp/variables.sh && /src/memcachephp/run.sh"
    ;;
esac

#!/usr/bin/env bash

MEMCACHED_PORT="$(echo "${MEMCACHED_PORT}" | sed 's/tcp:\/\///')"

export FACTER_MEMCACHED_HOST="$(echo "${MEMCACHED_PORT}" | cut -d ":" -f1)"
export FACTER_MEMCACHED_PORT="$(echo "${MEMCACHED_PORT}" | cut -d ":" -f2)"

if [ -z "${SERVER_NAME}" ]; then
  SERVER_NAME="localhost"
fi

export FACTER_SERVER_NAME="${SERVER_NAME}"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord

#!/usr/bin/env bash

puppet apply --modulepath=/src/memcachephp/run/modules /src/memcachephp/run/run.pp

supervisord -c /etc/supervisor/supervisord.conf

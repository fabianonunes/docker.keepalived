#!/bin/sh
set -e

gomplate --file keepalived.conf.tpl --out keepalived.conf
exec keepalived --dont-fork --log-console --no-syslog --use-file /etc/keepalived/keepalived.conf "$@"

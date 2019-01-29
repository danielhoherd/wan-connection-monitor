#!/usr/bin/env bash
while true ; do
  result="$(fping -t 1000 -q 4.2.2.1 && echo "alive $(dig +short myip.opendns.com @resolver1.opendns.com)" || echo FAILURE)"
  printf "%s %s\n" "$(date "+%F %T%z")" "${result}" | tee -a "wan_connection-$(date +%F).log"
  sleep 10
done

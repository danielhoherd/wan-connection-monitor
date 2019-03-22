#!/usr/bin/env bash

log_message() {
  printf "%s %s\n" "$(date "+%F %T%z")" "$*" | tee -a "wan_connection-$(date +%F).log"
}

log_message "Starting up logger"

while true ; do
  this_result="$(fping -t 1000 -q 4.2.2.1 && echo "alive $(dig +short myip.opendns.com @resolver1.opendns.com)" || echo FAILURE)"
  if [ "${last_result}" != "${this_result}" ] ; then
    [[ ! -z "${count}" ]] && flap_message=" (last_result: ${last_result} ${count})"
    count=0
  fi
  last_result="${this_result}"
  (( count+=1 ))
  info_message="${this_result} ${count}${flap_message}"
  log_message "${info_message}"
  sleep 10
done

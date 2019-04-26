#!/usr/bin/env bash

log_message() {
  printf "%s %s\n" "$(date "+%F %T%z")" "$*" | tee -a "log/wan_connection-$(date +%F).log"
}

get_public_ip_address() {
  timeout 5 fping -t 1000 -q 4.2.2.1 >/dev/null 2>&1 && dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null || echo FAILURE
}
export -f get_public_ip_address

log_message "Starting $(get_public_ip_address)"

while sleep 10 ; do
  this_result="$(get_public_ip_address)"
  if [ "${last_result}" != "${this_result}" ] ; then
    [[ ! -z "${count}" ]] && flap_message=" (last_result: ${last_result} ${count})"
    count=0
  else
    unset flap_message
  fi
  last_result="${this_result}"
  (( count+=1 ))
  info_message="${this_result} ${count}${flap_message}"
  log_message "${info_message}"
done

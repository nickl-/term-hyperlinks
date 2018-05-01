#!/usr/bin/env bash
[[ ! $1 ]] && echo -e "Usage:\n\t${0##*/} <url>" && exit 1

! /usr/bin/which socat >/dev/null && echo -e "socat not found\nplease install socat and ensure it is in your path" && exit 1

scheme=${1%://*}
msg=${1#*://}
soc=${msg%\?*}

while [[ -n $soc && ! -S $soc ]]; do
  soc=${soc%/*}
done

[[ -n $soc ]] && echo "${msg#$soc}" | `/usr/bin/which socat` -u - UNIX-CLIENT:$soc || (
    echo -e "\nError for $scheme socket URL:\n$1"
    echo -e "\nSocket @ '$soc' with message part:\n${msg/$soc/}" 
    exit 1
)


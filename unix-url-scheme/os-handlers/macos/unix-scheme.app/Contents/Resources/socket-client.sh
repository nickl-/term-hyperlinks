#!/usr/bin/env bash

scheme=${1%://*}
msg=${1#*://}
soc=${msg%\?*}

while [[ -n $soc && ! -S $soc ]]; do
  soc=${soc%/*}
done

[[ -n $soc ]] && echo "${msg/$soc/}" | /usr/bin/nc -U $soc || (
    echo -e "\nError for $scheme socket URL:\n$1"
    echo -e "\nSocket @ '$soc' with message part:\n${msg/$soc/}" 
    exit 1
)


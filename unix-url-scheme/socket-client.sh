#!/usr/bin/env bash
[[ ! $1 ]] && echo -e "Usage:\n\t${0##*/} <url>" && exit 1

! /usr/bin/which socat >/dev/null && echo -e "socat not found\nplease install socat and ensure it is in your path" && exit 1

# based off https://stackoverflow.com/questions/6174220/parse-url-in-shell-script#answer-45977232
# with some corrections
pattern='^(([^:/?#]+):?)(//((([^:/?#]*):?([^:/?#]*))@)?([^:/?#]*)(:([0-9]*))?)?(/([^?#]*))(\?([^#]*))?(#(.*))?'
#         ↑↑            ↑  ↑↑↑           ↑             ↑         ↑ ↑           ↑ ↑        ↑  ↑        ↑ ↑
#         |2 scheme     |  ||6 user      7 pass        8 host    | 10 port     | 12 rpath |  14 query | 16 fragment
#         1 scheme:     |  |5 userinfo                           9 :…          11 path    13 ?…       15 #…
#                       |  4 userinfo@
#                       3 authority

if [[ "$1" =~ $pattern ]]; then
    scheme=${BASH_REMATCH[2]}
    soc=${BASH_REMATCH[11]}
    msg=$soc${BASH_REMATCH[13]}
else
    echo "url in the form scheme://[host]/path" && exit 1 
fi

while [[ -n $soc && ! -S $soc ]]; do
  soc=${soc%/*}
done

[[ -n $soc ]] && echo "${msg#$soc}" | `/usr/bin/which socat` -u - UNIX-CLIENT:$soc || (
    echo -e "\nError for $scheme socket URL:\n$1"
    echo -e "\nSocket @ '$soc' with message part:\n${msg/$soc/}" 
    exit 1
)


#!/usr/bin/env bash

h='Some unix://tmp/test.sock terminal hyperlinks we are listening for:'
echo "$h"
printf '=%.0s' `eval echo "{1..${#h}}"`
echo
echo -e '\e]8;;unix:///tmp/test.sock/with/some/test/data\apath sent to socket\e]8;;\a'
echo -e '\e]8;;unix:///tmp/test.sock/?with-some-test-data\aslash args on socket\e]8;;\a'
echo -e '\e]8;;unix:///tmp/test.sock?with-some-test-data\aonly args on socket\e]8;;\a'
echo -e '\e]8;;unix:///no/where.to/test\abroken link\e]8;;\a'

a="`printf ' %.0s' {1..25}`"
in='y'
while [ "$in" == 'y' ] ; do
    echo -e "\n${a}Listening for unix:///tmp/test.sock links"
    `/usr/bin/which socat` -u UNIX-LISTEN:/tmp/test.sock -
    read -p "${a}Listen for another link? y: " -N 1 -t 5 in
done
echo


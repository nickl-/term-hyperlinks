#!/usr/bin/env bash
apt -y install socat
cp unix-handler.desktop /usr/share/applications/unix-handler.desktop
cp socket-client.sh /usr/local/bin/socket-client.sh
update-desktop-database

echo "you can start ./socket-server.sh and test some unix:// terminal hypertext links"


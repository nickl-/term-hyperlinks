# unix://

Unix domain socket url scheme in the form:

    unix://[host:port]/path/to/socket.file/additional/data?sent=to&socket=listener

We may have perhaps taken some liberties with the url with regards to the additional path sequence. The current implimentation walks backwards on the path looking for the existance of a socket file. Any additional path definition is sent as a message to the socket. 

if host is omitted localhost is assumed, with host and port specified it should be possible to ssh bind with a remote socket. The current implimentation ignores host and assumes local sockets only.

The use of abstract namespace sockets have not been defined.

For the purposes of an OS uri scheme handler and use through terminal hypertext links without any special assitance from the terminal emulators it does not make sense to retain a socket connection or to read from the socket response as this process is spawned outside of the current terminal session. For this reason the scheme handler only sends a message to the listening socket and disconnects without reading a response.

### Proof of concept:

The poc simply uses `socat` to deal with the unix sockets, this can of course be implemented in many other ways. 

**socket-client.sh** - parses unix:// uri, attempts to find socket file, sends remaining part of uri to socket if found and exits.

**socket-server.sh** - Outputs some terminal hypertext links and proceeds to listen in a loop for messages at /tmp/test.sock. When a message is received it simply echos the message to stdout before closing. User is prompted wether to listen for another message.

Sample output:

    Some unix://tmp/test.sock terminal hyperlinks we are listening for:
    ===================================================================
    path sent to socket
    slash args on socket
    only args on socket
    broken link

                             Listening for unix:///tmp/test.sock links
    /with/some/test/data
                             Listen for another link? y: y
                             Listening for unix:///tmp/test.sock links
    /?with-some-test-data
                             Listen for another link? y: y
                             Listening for unix:///tmp/test.sock links
    ?with-some-test-data
                             Listen for another link? y: n


## Contents:

 * [os-handlers](/unix-url-scheme/os-handlers) - poc implementations for os specific unix:// uri scheme handlers
 * [consensus](/unix-url-scheme/consensus) - community consensus of a specification definition





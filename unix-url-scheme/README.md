# unix://

Unix domain socket url scheme in the form

    unix://[host]/path/to/socket.file/additional/data?sent=to&socket=listener

if host is omitted localhost is assumed

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
 * [consensus](/unix-url-scheme/consensus) - community concensus of a specification definition





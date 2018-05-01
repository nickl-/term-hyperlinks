# unix://

Unix domain socket url scheme in the form:

    unix://[host:port]/path/to/socket.file/additional/data?sent=to&socket=listener

We may have perhaps taken some liberties with the url with regards to the additional path sequence. The current implimentation walks backwards on the path looking for the existance of a socket file. Any additional path definition is sent as a message to the socket. 

if host is omitted localhost is assumed, with host and port specified it should be possible to ssh bind with a remote socket. The current implimentation ignores host and assumes local sockets only.

After parsing the example URL we will have

```
scheme = unix
path = /path/to/socket.file/additional/data
message = /path/to/socket.file/additional/data?sent=to&socket=listener
```

We then step backwards through path looking for a sockeh file and once located subtract the socket file path from the message which is sent to the listening socket.

```
path = /path/to/socket.file/additional/data - fail
path = /path/to/socket.file/additional - fail
path = /path/to/socket.file - success
message = /additional/data?sent=to&socket=listener
```

For the purposes of an OS uri scheme handler and use through terminal hypertext links without any special assitance from the terminal emulators it does not make sense to retain a socket connection or to read from the socket response as this process is spawned outside of the current terminal session. For this reason the scheme handler only sends a message to the listening socket and disconnects without reading a response. This should not impact the scheme definition per se as we would be focusing on defining the url and location of unix domain sockets with no need to go into protocol details which may be left up to the implimentation to decide.

Query part of the url `?` is implimented but the fragment part `#` did not seem applicable and was left out. Open an issue for further discussion should you disagree.

The use of abstract namespace sockets have not been defined. A well formed URL has a path starting with `/` which may not be applicable to these types of sockets even if we attempt to utilize the normal `\0` indicator. Is host name of any relevance to these type of sockets either? Perhaps defining a URN for this purpose is more appropriate. Further discussion required.

    unix:abstract-namespace-nane:/additional/data?sent=to&socket=listener

### Proof of concept:

The poc simply uses `socat` to deal with the unix sockets, this can of course be implemented in many other ways. Additional contributions are welcomed.

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

Without any OS handlers installed for the unix scheme, clicking on the links will not have the desired result.

## Contents:

 * [os-handlers](/unix-url-scheme/os-handlers) - poc implementations for os specific unix:// uri scheme handlers
 * [consensus](/unix-url-scheme/consensus) - community consensus of a specification definition


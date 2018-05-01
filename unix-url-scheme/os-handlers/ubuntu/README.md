# ubuntu unix:// uri scheme handler

By providing a `unix-scheme.desktop` definition we can use `socket-client.sh` directly as the url scheme handler.

```ini
[Desktop Entry]
Type=Application
Name=UnixScheme
Exec=socket-client.sh %u
MimeType=x-scheme-handler/unix;
```

We provide convenient installation bundle [unix-scheme-installer.tar.gz](https://github.com/nickl-/term-hyperlinks/raw/master/unix-url-scheme/os-handlers/ubuntu/unix-scheme-installer.tar.gz),
simply download and extract the files then execute `./install-ubuntu.sh` as root.

Example:
```
curl -Lo unix-scheme-installer.tar.gz https://github.com/nickl-/term-hyperlinks/raw/master/unix-url-scheme/os-handlers/ubuntu/unix-scheme-installer.tar.gz
tar zxvf unix-scheme-installer.tar.gz
sudo ./install-ubuntu.sh
```

Run `socket-server.sh` and test the links.

# macOS unix:// uri scheme handler

The magic required to register a custom scheme handler is by adding the `CFBundleURLTypes` key to the `Info.plist` of the macOS application:

```xml
      <key>CFBundleURLTypes</key>
      <array>
              <dict>
                      <key>CFBundleURLName</key>
                      <string>unix socket scheme handler</string>
                      <key>CFBundleURLSchemes</key>
                      <array>
                              <string>unix</string>
                      </array>
              </dict>
      </array>
```

The application needs to handel Apple Event GetURL to obtain the requested url, by wrapping `socket-client.sh` in a simple AppleScript implimentation we can easily get the url passed as an argument to the shell environment.

```AppleScript
# based on http://hublog.hubmed.org/archives/001154.html
on open location sURL
	try
		set shScript to path to resource "macos-env.sh"
		set pshScript to POSIX path of shScript
		do shell script pshScript & " '" & sURL & "'"
	on error errorMessage
		display dialog errorMessage
	end try
end open location
```

We provide an installable dmg file [unix-scheme-installer.dmg](https://github.com/nickl-/term-hyperlinks/raw/master/unix-url-scheme/os-handlers/macos/unix-scheme-installer.dmg), simply drag the app to Applications folder and you should be set to handle unix sheme urls.

Run `socket-server.sh` in iTerm2 to test some links.

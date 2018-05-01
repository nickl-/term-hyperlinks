# macOS unix:// uri scheme handler

This is an AppleScript implementation, built with Script Editor to handle unix:// urls and pass them to the socket-client.sh.
Seems rather hackish, I don't know enough about AppleScript or macos applications to know any better.

Based on suggestions by [Alf Eaton](http://hublog.hubmed.org/archives/001154.html), here is the source since there are no txt based
variants in the actual source:

```AppleScript

on open location unxURL
	try
		set socClient to path to resource "socket-client.sh" # as text
		do shell script "p='" & socClient & "';p=\"/${p//://}\";[[ -x \"$p\" ]] || p=\"/Volumes$p\" && \"$p\" '" & unxURL & "'"
	on error errorMessage
		display dialog errorMessage
	end try
end open location

```

Perhaps someone can improve on this.

The goal was to get back to the shell as soon as possible so passing the url to our socket-client.sh script for the url parsing. This seems
like the most logical approach which provides reusability with other OS implimentations. If we could skip the need for AppleScript and
wrap the shell script as a macos app directly it would probably be better. Looking forward to hearing your thoughts on this.

We provide an installable dmg, simply drag the app to Applications folder and you should be set.


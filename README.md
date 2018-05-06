# Terminal emulation ansi escape hypertext link descriptor definition

No it's not what this project is about, but it is the definitive reason for it coming about. Lets have a quick look at what's been happenning.

Exactly a year ago, now... @egmontkob published a paper [Hyperlinks_in_Terminal_Emulators.md](https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda)
and everyone thought this was a great idea. What he invisioned was to utilize the OSC - Operating System Command escape sequence (OSC 8) to enable the definition
of hypertext link descriptors and for the first time since OSC 0 (changing the terminal window title) everyone seems to be in agreement and  on board with its implementation.
The OSC ansi category has been notoriously uncooperative with many bright ideas and implementations, from clipboard access to command execution (could be thumbsucking need
references), seldom finding widespread adaptation. Great work everyone. job well done!

The defenition utilizes 2 OSC escape sequences to produce a link descriptor, one for the url definiton and the other to mark the close  which leaves the title unescaped and 
thus non breaking in legacy compliant implementations which should ignore the uncommon specification as de facto:

    OSC 8 ; params ; url ST # 1st OSC opens anchor, specifies url

        title # unescaped text as link title

    OSC 8 ; ; ST # 2nd OSC no data, closes anchor description

All your favourite terminal emulators are already on board, and hat off to the devs for strides in collaboration to ensure a standard implementation, will recognise the
sequence and render a familiar underlined and hover sensitive hyperlink. It should come as no surprise to anyone, what will happen when one clicks on this do-dab, the terminal
passes the link to the operating system which will decide how best to service your requirements. 

**http** or **https** [RFC7230](http://www.iana.org/go/rfc7230) url schemes will fire up old faithful, aka the default web browser and bobs your uncle. Nice! If you clicked
a **mailto** [RFC6068](http://www.iana.org/go/rfc6068) link something will happen... it tries to find an email client, probably launches one that is pre-installed by defaulti and
never used before because I use webmail and uhm... there's no default app for that duh... do I hear someone say pine?... anyway... no surprise there anyhow. When you happen upon
a **file** [RFC8089](http://www.iana.org/go/rfc8089) uri oh boy something is bound to happen, not intirely clear what exactly nor whether it will succeed. One thing is for
certain though it will guaranteed and definitely, 100% sure, with no doubts have something or other to do with a file and probably an attempt to locate and inevitably attempt
to relocate such file somewheres, also not entirely sure exactly where, but confidently asuredly in the general vacinity and much much closer than where it was before. Nice!
Unless it didn't work exactly as unexpected for many many many many reasons, so what!

What doesn't work for me is being prompted to choose an application or go find a solution I wasn't aware I needed until now, with many bright ideas and expert suggestions on
where I should go and look only to hide the fact that it doesn't have a cooking clue what the hell to do with that link I just clicked on. But the truth is having hypertext
links in the terminal is not just a new cool way to start the browser. This opens up many new doors previously unexplored and the fact of the matter is we actually have more
than a clue, arguably much more than those so called standards but it is just that... as it turns out we don't have any standards so what can we do?

# The home of uri schemes and standards for hypertext command shell integration

As it turns out there are already many well thought out "standard" schemes in use as we speak. Their use, application and implementation is arguably intuitive with little to no 
need for design we already know what they do. When I started on this discovery I could've sworn these schemes were already specified at [IANA uri schemes](https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml)
but to my surprise I found none. It obviously can't take much effort to get listed if there are things like **tool** and **content** listed, huh? Unfortunately 
intuition is not enough... off-spec remains a good and valid reason for these designs no remain unadopted and therefor unimplimented. The sheer risk involved in implementing
something that is not cast in stone outweighs any other designs or desires.

Perhaps they are currently missing specification because these schemes aren't specifically "internet" related which is the core focus of IETF. With hypertext links in the
terminal the scope has now widened and uri's are not just internet related, we have a need to keep the functionality within process or at least have a means to return to the
session. 

This project aims to identify needs and requirements for proof of concept, standards and reference implementations of terminal and command shell uri schemes. The goal is for
rapid adoption and thus requires vested interest from the community to have any impact or success. A call to arms, lets just do this.


## Currently identified standards schemes

 1. [unix](/unix-url-scheme) - unix domain socket uri scheme
 1. fd - filedescriptor uri scheme
 1. exec - shell command execution uri scheme
 1. system - system command execution uri scheme
 1. tty - teletypewriter uri scheme
 1. http+unix - http over unix domain sockets uri scheme







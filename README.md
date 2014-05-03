autobuild
=========
A tool for building a .deb (maybe more when forked) from source, it supports autotools (./configure stuff) and
cmake internally. After putting autobuild/define file in the source tree, use the autobuild command to see how
the source code is built into binaries, then a .deb package. It's cool. 

An external build script is available when you need some special paramenters after build, or when the sources
are not formed in autotools or cmake architecutures, of which we called "Unique Source". A good example of it 
is the Boost cpp libraries sources, which uses the b2 toolkit.

There are actually a lot more features that is provided by this tool. Currently under heavy development and 
used in production by Anthon :Next DevTeam (who is called TheNextProject here...), and we use this all the time
to build a new, independent dpkg distro!

What's the point?
* It works like the dpkg-buildpackage command for Debian and its sons and grandsons... but ours is easier at times.
* Maybe we can develop a structer similar to AUR from ArchLinux (which is cool & awesome).
...

We need your help to imagine and code!

Pull requests are welcomed.

Installation
----
First, the mainline of autobuild now only supports dpkg.

You need have at least bash, dpkg installed.

Then copy autobuild executable file to /usr/bin , and copy the libexec directory as /usr/lib/autobuild .

```
cp autobuild /usr/bin && rm -rf /usr/lib/autobuild && cp -r libexec /usr/lib/autobuild
```

Git
----
The latest version of autobuild can be checked out using `git`, `svn` or `GitHub Zip`.
```
git clone https://github.com/AOSC-Dev/autobuild
svn co https://github.com/AOSC-Dev/autobuild
wget https://github.com/AOSC-Dev/autobuild/archive/master.zip
```
Developers
----
EasternHeart <heartldev@gmail.com>	Main developer.


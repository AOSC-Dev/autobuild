autobuild
=========
**The mainline support for autobuild has ended. Use [autobuild3](https://github.com/AOSC-Dev/autobuild3) instead.**
Now most of the new commits are bugfixes, and sometimes you can see some rare backports from ab3. 

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
Simply run `autobuild` if you have a copy of autobuild installed. Try `amd64/autobuild` if you don't have
one and you are using amd64.

First, the mainline of autobuild now only supports dpkg. There are ab2 branches for rpm support already, but the
one that works best in the autobulid family is [autobuild3](https://github.com/AOSC-Dev/autobuild3), which is
actually a rewritten one. 

You need have at least bash, dpkg installed. The ELF stripping plugin in `$ARCH/libexec/elf` requires 
binutils, but you can delete it if you want to.

Then copy autobuild executable file to `/usr/bin` , and copy the libexec directory as `/usr/lib/autobuild` .

```Bash
ARCH="`uname -m`" && [ "$ARCH" == "x86_64" ] && ARCH="amd64" # dpkg-friendly conversion, only for amd64
[ "$ARCH" != "amd64" ] && ./genarch $ARCH # Generate autobuild for your arch...
cd $ARCH && cp autobuild /usr/bin && rm -rf /usr/lib/autobuild && cp -r libexec /usr/lib/autobuild
```

Source
----
You can get the latest version of autobuild using `git`, `svn` or GitHub Zip.
```Bash
git clone https://github.com/AOSC-Dev/autobuild
svn co https://github.com/AOSC-Dev/autobuild
wget https://github.com/AOSC-Dev/autobuild/archive/master.zip
```

Developers
----
EasternHeart <heartldev@gmail.com>	Main developer.

Read [Contributors](https://github.com/AOSC-Dev/autobuild/graphs/contributors) for a full list.

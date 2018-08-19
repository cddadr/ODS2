# ODS/2
OpenBSD Desktop System/2

For hassle-free deployments of CDE/Motif and some common staples, such as:

- curl
- git
- rsync
- sudo
- python-2.7
- ffmpeg
- mplayer
- youtube-dl
- chromium
- firefox

Installation instructions:

Please note: This is intended for being run right after a new install of OpenBSD.
It is currently targeted for OpenBSD 6.3, and has been tested on i386 and amd64.

Proceed with the usual OpenBSD install, following these suggestions:

- Do not create any users. Users will be added after the script is run.

- Create an /export partition rather than a /home partition. 

- For all else, just stick to the defaults.

- Reboot when finished.

On to the script:

- Log in as root.

- Install git:

    export PKG_PATH=http://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`machine -a`
    pkg_add -i git

- Clone from the repository:

    git clone https://github.com/cddadr/ODS2.git

- Change to the directory and run the script:

    cd ODS2
    sh install.sh

- Wait... Eventually, it will finish.

Enjoy!

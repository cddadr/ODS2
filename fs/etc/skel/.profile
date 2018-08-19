# $OpenBSD: dot.profile,v 1.5 2018/02/02 02:29:54 yasuoka Exp $
#
# sh/ksh initialization
#######################

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/dt/bin
export PATH HOME TERM

PKG_PATH=http://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`machine -a`
export PKG_PATH

MANPATH=$MANPATH:/usr/dt/share/man
export MANPATH

#######################
#
# set prompt variables
#######################

# Non-color PS1 variable:
#PS1='\u@\h:\w \$ '

# Color PS1 variable:
PS1='[36m \u@\h [35m \w [0m\n[1m\$[0m '
export PS1

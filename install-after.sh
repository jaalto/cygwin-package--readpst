#!/bin/sh
# Copyright (C) 2008-2011 Jari Aalto; Licenced under GPL v2 or later
#
# install-after.sh -- Custom installation
#
# The script will receive one argument: relative path to
# installation root directory. Script is called like:
#
#    $ install-after.sh .inst
#
# This script is run after [install] command. NOTE: Echo all messages
# with ">> " prefix".

PATH="/sbin:/usr/sbin/:/bin:/usr/bin:/usr/X11R6/bin"
LC_ALL="C"

set -e

Cmd()
{
    echo "$@"
    [ "$test" ] && return
    "$@"
}

Main()
{
    root=${1:-".inst"}

    if [ ! "$root"  ] || [ ! -d "$root" ]; then
        echo "$0: [ERROR] In $(pwd) no such directory: '$root'" >&2
        return 1
    fi

    root=$(echo $root | sed 's,/$,,')  # Delete trailing slash
    bindir=$root/usr/bin
    sharedir=$root/usr/share

    echo ">> Moving doc/libpst to doc/readpst"
    Cmd mv $sharedir/doc/libpst/* $sharedir/doc/readpst/
    Cmd rm -rf $sharedir/doc/libpst
}

Main "$@"

# End of file

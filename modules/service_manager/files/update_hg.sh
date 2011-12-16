#!/bin/sh
# usage:
# update_hg.sh <directory>
# returns 0 if something changed
# returns non-zero otherwise
d=$1
cd $d
if (! hg pull | grep -q 'no changes found'); then
    hg update -C
    exit 0
fi
exit 1

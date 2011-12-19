#!/bin/sh
# usage:
# update_hg_wc.sh <directory>
# Does 'hg pull; hg update -C' inside directory
# Returns 0 if new changesets were applied
cd $1
if (! hg pull | grep -q 'no changes found'); then
    hg update -C
    exit 0
fi
exit 1

#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh


VER=4.19.87

TMPDIR=$(mktemp -d)

mkdir -p ${TMPDIR}/patch

git cherry m${VER} | cut -f 2 -d " " > ${TMPDIR}/cherry

n=1

for p in $(< ${TMPDIR}/cherry)
do
    git format-patch --quiet --no-numbered \
        --signature="https://clearlinux.org" \
        --start-number=$n \
        -o ${TMPDIR}/patch -1 $p
    let "n++"
done

#rm -rf ${TMPDIR}


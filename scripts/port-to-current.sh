#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

tmpdir=$(mktemp -d)
rejf=${tmpdir}/rej

for p in $*
do
    if ! git am --quiet $p 2> /dev/null
    then
        rm -rf ${rejf}
        if ! patch --quiet --reject-file=${rejf} --forward -p1 < $p
        then
            if [ -f ${rejf} ]
            then
                if [ -n "${DISPLAY}" ]
                then
                    gvim -f ${rejf}
                else
                    vim ${rejf}
                fi
            fi
        fi
        echo sleep 3
        sleep 3
        git add --all
        git am --quiet --continue
    fi
done
rm -rf ${tmpdir}

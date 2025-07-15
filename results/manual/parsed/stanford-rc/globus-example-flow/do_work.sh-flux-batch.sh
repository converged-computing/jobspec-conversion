#!/bin/bash
#FLUX: --job-name=gloopy-earthworm-6735
#FLUX: -t=3600
#FLUX: --urgency=16

if [ $# -ne 2 ]; then
    echo 'ERROR!  The number of arguments should be only 2.'
    exit 1
fi
for arg in $1 $2; do
    if [ ! -d ${arg} ]; then
        echo 'ERROR!  ${arg} is not a directory.'
        exit 1
    fi
done
cd $1
exec find . -depth -not -type d -exec sha1sum --binary {} \; > $2/checksums

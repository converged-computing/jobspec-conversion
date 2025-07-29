#!/bin/bash
#FLUX: --job-name=ACES_CS21_analysis
#FLUX: -n=64
#FLUX: -t=345600
#FLUX: --urgency=16

export USE_DASK='True'

date
. ~/.gh_token
echo $GITHUB_TOKEN
cd /blue/adamginsburg/adamginsburg/ACES/workdir/
pwd
export USE_DASK=True
if [ -e /orange/adamginsburg/ACES/mosaics/cubes/CS21_CubeMosaic.fits ]; then
    echo "test import"
    /orange/adamginsburg/miniconda3/envs/python39/bin/python -c "import zipfile" || exit 1
    echo "Giant CS 21 cube"
    /orange/adamginsburg/miniconda3/envs/python39/bin/python /orange/adamginsburg/ACES/reduction_ACES/aces/analysis/giantcube_cuts.py || exit 1
else
    echo "CS21_CubeMosaic.fits does not exist"
    ls -lh CS*fits
fi

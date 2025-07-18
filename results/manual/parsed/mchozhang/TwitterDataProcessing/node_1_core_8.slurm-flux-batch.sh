#!/bin/bash
#FLUX: --job-name=blue-cherry-6313
#FLUX: -n=8
#FLUX: --urgency=16

TWITTER=$1
MELB_GRID=$2
if [[ "$1" == "" ]];
then
    TWITTER="bigTwitter.json"
    MELB_GRID="melbGrid.json"
elif [[ "$2" == "" ]];
then
    MELB_GRID="melbGrid.json"
fi
module load Python/3.5.2-intel-2017.u2
time mpiexec -n 8 python main.py -t "$TWITTER" -m "$MELB_GRID"
module unload Python/3.5.2-intel-2017.u2

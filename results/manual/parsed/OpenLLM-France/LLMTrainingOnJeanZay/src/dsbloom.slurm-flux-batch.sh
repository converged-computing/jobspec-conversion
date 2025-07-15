#!/bin/bash
#FLUX: --job-name=ds_bloom
#FLUX: -c=8
#FLUX: -t=3000
#FLUX: --priority=16

export HOME='$WORK"/home/'

export HOME=$WORK"/home/"
. $HOME/envs/ds/bin/activate
module load cpuarch/amd
module load pytorch-gpu/py3/2.2.0
set -x
echo "DATEDEBUT"
date
srun python dsbloom.py

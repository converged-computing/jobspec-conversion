#!/bin/bash
#FLUX: --job-name=megatrondetok
#FLUX: -c=8
#FLUX: -t=3000
#FLUX: --priority=16

export HOME='$WORK"/home/'

export HOME=$WORK"/home/"
module load anaconda-py3/2023.09
conda activate megatron
module load cpuarch/amd
set -x
echo "DATEDEBUT"
date
srun python mdetok.py

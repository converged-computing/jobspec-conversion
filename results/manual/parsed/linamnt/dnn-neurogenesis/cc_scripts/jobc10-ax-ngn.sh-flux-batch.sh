#!/bin/bash
#FLUX: --job-name=c10ngn
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --urgency=16

SOURCEDIR=~/ndl/cc_scripts
VENV=~/pytorch_gpu
module load python/3.6
source $VENV/bin/activate # virtual environment for project
mkdir $SLURM_TMPDIR/data
tar -xf ~/data/cifar10.tar -C $SLURM_TMPDIR/data
SCRIPT=c10-neurogenesis-hpt.py # script should take as an argument the data path
python $SOURCEDIR/$SCRIPT -d $SLURM_TMPDIR -s $SOURCEDIR -n 250 -t 5

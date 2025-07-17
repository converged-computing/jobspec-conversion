#!/bin/bash
#FLUX: --job-name=c10-noise
#FLUX: -c=16
#FLUX: -t=570
#FLUX: --urgency=16

SOURCEDIR=~/ndl/cc_scripts
VENV_DIR=~/pytorch_gpu
module load python/3.6
source $VENV_DIR/bin/activate # virtual environment for project
mkdir $SLURM_TMPDIR/data
tar -xf ~/data/cifar10.tar -C $SLURM_TMPDIR/data
SCRIPT=c10-neural_noise.py # script should take as an argument the data path
python $SOURCEDIR/$SCRIPT -d $SLURM_TMPDIR/data -s $SOURCEDIR 

#!/bin/bash
#FLUX: --job-name=faux-lemon-3174
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export SINGULARITY_BINDPATH='/gpfs/scratch,/gpfs/data'

echo Master process running on `hostname`
echo Directory is `pwd`
echo Starting execution at `date`
echo Current PATH is $PATH
export SINGULARITY_BINDPATH="/gpfs/scratch,/gpfs/data"
CONTAINER=/gpfs/rt/7.2/opt/tensorflow/22.05-tf2-py3/bin/tf2_22.05-tf2-py3.simg
SCRIPT=/gpfs/data/ccvstaff/psaluja/ccv_bootcamp/bootcamp_talk/pinn_laplace_TF2.py
singularity exec --nv $CONTAINER python $SCRIPT 

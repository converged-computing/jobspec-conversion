#!/bin/bash
#FLUX: --job-name=stanky-staircase-8612
#FLUX: -t=18000
#FLUX: --urgency=16

cp -a data/. $SLURM_TMPDIR/data
module purge
module load python/3.10 scipy-stack
source ~/py310/bin/activate
python exp3/train/resnet18.py

#!/bin/bash
#FLUX: --job-name=persnickety-lemon-3733
#FLUX: -t=18000
#FLUX: --priority=16

cp -a data/. $SLURM_TMPDIR/data
module purge
module load python/3.10 scipy-stack
source ~/py310/bin/activate
python exp3/train/resnet18.py

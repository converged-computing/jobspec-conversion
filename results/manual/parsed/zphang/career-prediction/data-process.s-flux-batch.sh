#!/bin/bash
#FLUX: --job-name=rainbow-banana-8022
#FLUX: -t=36600
#FLUX: --priority=16

module load pytorch/python3.6/0.2.0_3
source activate nlpclass
RUNDIR=/home/zp489/scratch/data/jobembeddings
python $RUNDIR/career-prediction/data-process.py

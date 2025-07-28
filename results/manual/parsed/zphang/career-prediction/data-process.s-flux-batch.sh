#!/bin/bash
#FLUX: --job-name=dirty-lettuce-8288
#FLUX: -t=36600
#FLUX: --urgency=16

module load pytorch/python3.6/0.2.0_3
source activate nlpclass
RUNDIR=/home/zp489/scratch/data/jobembeddings
python $RUNDIR/career-prediction/data-process.py

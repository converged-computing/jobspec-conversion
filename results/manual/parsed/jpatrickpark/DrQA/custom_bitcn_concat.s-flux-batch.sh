#!/bin/bash
#FLUX: --job-name=DrQA_train
#FLUX: -t=36000
#FLUX: --priority=16

export CLASSPATH='$CLASSPATH:$SCRATCH/data/corenlp/*'

module purge
module load cuda/9.0.176
module load cudnn/9.0v7.0.5 
module load gcc/6.3.0
RUNDIR=$SCRATCH/my_project/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
SRCDIR=$SCRATCH/DrQA/scripts/reader/
cd $RUNDIR
export CLASSPATH=$CLASSPATH:$SCRATCH/data/corenlp/*
$HOME/anaconda3/bin/python $SRCDIR/train.py --model-dir=$SCRATCH/DrQA/models --rnn-type='tcn' --concat-rnn-layers=False --bidirectional=True --tcn-filter-size=3 --doc-layers=5 --question-layers=5 --num-epochs=60 --batch-size=128 --dropout-rnn=0.2 --concat-rnn-layers=True

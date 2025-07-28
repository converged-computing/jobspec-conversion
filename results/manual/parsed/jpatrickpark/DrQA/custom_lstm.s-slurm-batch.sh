#!/bin/bash
#FLUX: --job-name=DrQA_train
#FLUX: -t=21600
#FLUX: --urgency=16

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
$HOME/anaconda3/bin/python $SRCDIR/train.py --model-dir=$SCRATCH/DrQA/models --rnn-type='custom_lstm' --concat-rnn-layers=False --bidirectional=False

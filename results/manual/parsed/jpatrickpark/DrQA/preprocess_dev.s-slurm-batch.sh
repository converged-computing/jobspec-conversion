#!/bin/bash
#FLUX: --job-name=DrQA_preprocess
#FLUX: -c=4
#FLUX: -t=14400
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
$HOME/anaconda3/bin/python $SRCDIR/preprocess.py $SCRATCH/DrQA/data/datasets/ $SCRATCH/DrQA/data/processed --split="SQuAD-v1.1-dev"

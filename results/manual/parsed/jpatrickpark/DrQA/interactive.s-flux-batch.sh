#!/bin/bash
#FLUX: --job-name=myDrQA
#FLUX: -t=7200
#FLUX: --urgency=16

export CLASSPATH='$CLASSPATH:$SCRATCH/data/corenlp/*'

module purge
module load cuda/9.0.176
module load cudnn/9.0v7.0.5 
module load gcc/6.3.0
RUNDIR=$SCRATCH/my_project/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
SRCDIR=$SCRATCH/DrQA/scripts/pipeline/
cd $RUNDIR
export CLASSPATH=$CLASSPATH:$SCRATCH/data/corenlp/*
$HOME/anaconda3/bin/python $SRCDIR/interactive.py < $SCRATCH/DrQA/input.txt 

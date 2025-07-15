#!/bin/bash
#FLUX: --job-name=fuzzy-train-4539
#FLUX: -t=28800
#FLUX: --priority=16

LOGDIR=logs/
DIRPATH_EXP=logs/$SLURM_JOB_NAME/
mkdir -p $DIRPATH_EXP
LOG=$DIRPATH_EXP/$SLURM_JOB_ID.log
ERR=$DIRPATH_EXP/$SLURM_JOB_ID.err
echo -e "JobID: $SLURM_JOB_ID\n======" > $LOG
echo "Time: `date`" >> $LOG
echo "Running on master node: `hostname`" >> $LOG
echo "python `which python`": >> $LOG
python scripts/cache_datasets/cache_mls.py >> $LOG 2> $ERR
echo "Time: `date`" >> $LOG

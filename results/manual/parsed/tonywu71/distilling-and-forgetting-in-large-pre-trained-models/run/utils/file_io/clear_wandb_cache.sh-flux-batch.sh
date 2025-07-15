#!/bin/bash
#FLUX: --job-name=loopy-lamp-5565
#FLUX: -t=3600
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
rm -rf /home/tw581/.local/share/wandb/artifacts
echo "Time: `date`" >> $LOG

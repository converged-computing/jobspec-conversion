#!/bin/bash
#FLUX: --job-name=reclusive-poo-9205
#FLUX: -t=14400
#FLUX: --urgency=16

LOGDIR=logs/
DIRPATH_EXP=logs/$SLURM_JOB_NAME/
mkdir -p $DIRPATH_EXP
LOG=$DIRPATH_EXP/$SLURM_JOB_ID.log
ERR=$DIRPATH_EXP/$SLURM_JOB_ID.err
echo -e "JobID: $SLURM_JOB_ID\n======" > $LOG
echo "Time: `date`" >> $LOG
echo "Running on master node: `hostname`" >> $LOG
echo "python `which python`": >> $LOG
rsync -a --update /home/tw581/rds/hpc-work/cache/huggingface/datasets /home/tw581/rds/rds-altaslp-8YSp2LXTlkY/data/cache/huggingface/datasets
echo "Time: `date`" >> $LOG

#!/bin/bash
#FLUX: --job-name=finetune_ewc_ami_100h
#FLUX: --queue=ampere
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
python scripts/finetune_whisper.py \
    configs/finetune_ewc_configs/preserve_french/finetune_ewc_tiny-ami_100h-preserve_french-lambda_1e-4-full.yaml \
    --ewc \
    >> $LOG 2> $ERR
echo "Time: `date`" >> $LOG

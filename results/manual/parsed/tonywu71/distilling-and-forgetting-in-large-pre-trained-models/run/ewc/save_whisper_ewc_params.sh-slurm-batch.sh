#!/bin/bash
#FLUX: --job-name=save_whisper_ewc_params
#FLUX: --queue=ampere
#FLUX: -t=25200
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
python scripts/save_whisper_ewc_params.py \
    openai/whisper-tiny \
    --language french \
    --task transcribe \
    --dataset-name mls_french_diagnostic \
    --split train \
    >> $LOG 2> $ERR
echo "Time: `date`" >> $LOG

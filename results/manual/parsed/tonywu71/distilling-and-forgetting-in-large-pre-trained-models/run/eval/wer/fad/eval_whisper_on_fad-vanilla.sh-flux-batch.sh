#!/bin/bash
#FLUX: --job-name=eval_whisper_on_fad-vanilla
#FLUX: --queue=ampere
#FLUX: -t=2400
#FLUX: --urgency=16

LOGDIR=logs/
DIRPATH_EXP=logs/$SLURM_JOB_NAME/
mkdir -p $DIRPATH_EXP
LOG=$DIRPATH_EXP/$SLURM_JOB_ID.log
ERR=$DIRPATH_EXP/$SLURM_JOB_ID.err
echo -e "JobID: $JOBID\n======" > $LOG
echo "Time: `date`" >> $LOG
echo "Running on master node: `hostname`" >> $LOG
echo "python `which python`": >> $LOG
python scripts/eval_whisper.py \
    openai/whisper-tiny \
    --dataset-name fad \
    --batch-size 1024 \
    >> $LOG 2> $ERR
echo "Time: `date`" >> $LOG

#!/bin/bash
#FLUX: --job-name=cache_9b_idefics
#FLUX: --queue=ampere
#FLUX: -t=3600
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
python scripts/cache_model.py \
    --idefics-config-path configs/idefics_config-9b_vanilla.yaml \
    >> $LOG 2> $ERR
echo "Time: `date`" >> $LOG

#!/bin/bash
#FLUX: --job-name=boopy-peanut-1297
#FLUX: -t=900
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
python scripts/evaluate_idefics.py \
    --idefics-config-path configs/idefics_config-9b_vanilla.yaml \
    --inference-config-path configs/9b_idefics_lora/9b_idefics_lora-inference.yaml \
    --dataset-name newyorker_caption \
    --prompt-template "{image}\nQuestion: How is this picture uncanny? Answer: "
    >> $LOG 2> $ERR
echo "Time: `date`" >> $LOG

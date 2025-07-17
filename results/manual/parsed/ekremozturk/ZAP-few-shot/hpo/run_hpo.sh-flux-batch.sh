#!/bin/bash
#FLUX: --job-name=v2_54_ws
#FLUX: --queue=bosch_gpu-rtx2080
#FLUX: --urgency=16

source /home/ozturk/anaconda3/bin/activate metadl
pwd
ARGS_FILE=hpo/hpo_warmstart.args
TASK_SPECIFIC_ARGS=$(sed "${SLURM_ARRAY_TASK_ID}q;d" $ARGS_FILE)
echo $TASK_SPECIFIC_ARGS
python -m hpo.optimizer $TASK_SPECIFIC_ARGS

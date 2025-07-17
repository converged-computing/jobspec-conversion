#!/bin/bash
#FLUX: --job-name=loopy-punk-8792
#FLUX: -c=4
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --urgency=16

CONST=0
source activate rs_fl
nvidia-smi
echo $HOSTNAME
python certify.py \
--dataset $DATASET \
--model $MODEL \
--base_classifier $CHECKPOINT \
--experiment_name $EXP_NAME \
--certify_method $AUG_METHOD \
--sigma $SIGMA \
--num_clients $NUM_CLIENTS \
--client_idx ${SLURM_ARRAY_TASK_ID} \
--skip $SKIP --max $MAX

#!/bin/bash
#FLUX: --job-name=butterscotch-soup-2646
#FLUX: -c=4
#FLUX: --queue=batch
#FLUX: -t=600
#FLUX: --urgency=16

source activate rs_fl
nvidia-smi
python initialize_models_for_clients.py \
--dataset $DATASET \
--model $MODEL \
--experiment_name $EXP_NAME \
--aug_method $AUG_METHOD \
--sigma $SIGMA \
--lr $LR \
--step_sz $STEP_SZ \
--num-clients $NUM_CLIENTS
COUNTER=0
TRAINING_JOB_NAME=TRAIN-$EXP_NAME-COMMUNICATION-ROUND-$COUNTER
sbatch --job-name=${TRAINING_JOB_NAME} --array=[1-$NUM_CLIENTS] \
--export=ALL,MODEL=$MODEL,DATASET=$DATASET,TOTALEPOCHS=${TOTALEPOCHS},LOCALEPOCHS=${LOCALEPOCHS},AUG_METHOD=$AUG_METHOD,SIGMA=$SIGMA,EXP_NAME=$EXP_NAME,CHECKPOINT=$CHECKPOINT,NUM_CLIENTS=$NUM_CLIENTS,LR=$LR,STEP_SZ=$STEP_SZ,BATCH_SZ=$BATCH_SZ,COUNTER=$COUNTER,SKIP=$SKIP,MAX=$MAX \
train_fl.sh

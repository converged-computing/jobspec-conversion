#!/bin/bash
#SBATCH --output=logs/%x.%J.out
#SBATCH --error=logs/%x.%J.err
#SBATCH --mail-user=alfarrm@kaust.edu.sa
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=00:10:00
#SBATCH --array=[1]

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

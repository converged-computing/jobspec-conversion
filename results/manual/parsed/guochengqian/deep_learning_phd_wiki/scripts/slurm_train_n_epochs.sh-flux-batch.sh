#!/bin/bash
#FLUX: --job-name=outstanding-bits-6713
#FLUX: --urgency=16

export PRETRAIN='$OUTPUT_DIR/$JOB_NAME/checkpoint/$JOB_NAME_${CURRENT_EPOCH}.pth'

set -ex
hostname
nvidia-smi
env
echo "##########################################"
conda activate deepgcn
module load cuda/10.0.130
module load gcc
python train.py --multi_gpus --phase train \
--data_dir $DATA_DIR \
--block $BLOCK \
--conv $CONV \
--n_blocks $N_BLOCKS \
--n_filters $N_FILTERS \
--norm $NORM \
--batch_size $BATCH_SIZE \
--lr $LR \
--total_epochs $EPOCHS \
--exp_name $EXP_NAME \
--job_name $JOB_NAME \
--pretrained_model "$PRETRAIN"
export PRETRAIN=$OUTPUT_DIR/$JOB_NAME/checkpoint/$JOB_NAME_${CURRENT_EPOCH}.pth
if [ $CURRENT_EPOCH -lt $((MAX_EPOCHS - 1)) ]
then
    export CURRENT_EPOCH=$((CURRENT_EPOCH + $EPOCHS))
    sbatch --gres=gpu:$NUM_GPUS --job-name=${EXP_NAME}-T${CURRENT_EPOCH} --export=ALL slurm_train_n_epochs.sh
fi

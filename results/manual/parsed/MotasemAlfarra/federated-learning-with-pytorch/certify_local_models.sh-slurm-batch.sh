#!/bin/bash
#SBATCH --output=logs/%x.%J.out
#SBATCH --error=logs/%x.%J.err
#SBATCH --mail-user=alfarrm@kaust.edu.sa
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --partition=batch
#SBATCH --exclude=gpu211-14,gpu213-06

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

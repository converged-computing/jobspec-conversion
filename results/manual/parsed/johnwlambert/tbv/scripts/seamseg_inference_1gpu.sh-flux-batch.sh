#!/bin/bash
#FLUX: --job-name=ornery-toaster-8495
#FLUX: --queue=overcap
#FLUX: --urgency=16

log_id=$1
echo "On node ${HOSTNAME}"
echo "Running model on log ${log_id}"
echo "CUDA VISIBLE DEVICES ${CUDA_VISIBLE_DEVICES}"
nvidia-smi
conda activate tbv-v0
source activate tbv-v0
cd /srv/scratch/jlambert30/seamseg/scripts
srun python -u ../../tbv-staging/scripts/run_seamseg_over_logs.py \
    --tbv-dataroot /srv/scratch/jlambert30/tbv_dataset/logs \
    --seamseg_output_dataroot /srv/scratch/jlambert30/tbv_dataset/seamseg_output \
    --num-processes 1 \
    --split test \
    --seamseg_model_dirpath /srv/scratch/jlambert30/seamseg_pretrained_models \
    --log-id $log_id

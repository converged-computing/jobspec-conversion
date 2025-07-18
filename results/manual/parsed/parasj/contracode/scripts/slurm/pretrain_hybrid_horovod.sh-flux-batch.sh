#!/bin/bash
#FLUX: --job-name=contrastive_pretrain_dist_hybrid
#FLUX: -t=900000
#FLUX: --urgency=16

export PATH='/data/paras/miniconda3/bin:$PATH'
export DATA_CACHE='/data/paras/data_cache'
export FREE_PORT='$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')";'
export BATCHSIZE='${BATCHSIZE:-64}'
export LR='${LR:-"4e-4"}'

set -x
date;hostname;pwd
free -mh
df -h
gpustat -cup
nvidia-smi
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' 
chmod 755 -R ~/slurm
export PATH="/data/paras/miniconda3/bin:$PATH"
export DATA_CACHE="/data/paras/data_cache"
export FREE_PORT="$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')";
export BATCHSIZE=${BATCHSIZE:-64}
export LR=${LR:-"4e-4"}
[ -z "$RUNNAME" ] && { echo "Need to set RUNNAME"; exit 1; }
[ -z "$BATCHSIZE" ] && { echo "Need to set BATCHSIZE"; exit 1; }
[ -z "$LR" ] && { echo "Need to set LR"; exit 1; }
echo "LR = $LR"
echo "BATCHSIZE = $BATCHSIZE"
echo "CUDA_VISIBLE_DEVICES = $CUDA_VISIBLE_DEVICES"
echo "CUDA_DEVICE_ORDER = $CUDA_DEVICE_ORDER"
echo "SLURM_JOB_ID = $SLURM_JOB_ID"
echo "FREE_PORT = $FREE_PORT"
mkdir -p $DATA_CACHE
chmod 755 $DATA_CACHE
cd /work/paras/code/contracode
pip install torch
pip install -e .
HOROVOD_WITH_PYTORCH=1 pip install horovod[pytorch]
npm install
horovodrun -np $NUMGPU python representjs/pretrain_horovod.py $RUNNAME --num_epochs=200 --batch_size=$BATCHSIZE --lr=$LR --num_workers=16 \
    --subword_regularization_alpha $SW_REG_ALPHA --program_mode contrastive --loss_mode hybrid --save_every 5000 \
    --train_filepath="$DATA_CACHE/codesearchnet_javascript/javascript_augmented.pickle" \
    --spm_filepath="$DATA_CACHE/codesearchnet_javascript/csnjs_8k_9995p_unigram_url.model" \
    --min_alternatives 1 --n_encoder_layers $N_ENCODER_LAYERS --d_model $D_MODEL --n_head $N_HEAD --max_length $MAX_LENGTH

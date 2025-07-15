#!/bin/bash
#FLUX: --job-name=SegVolContextP
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3540
#FLUX: --priority=16

export HF_DATASETS_CACHE='/scratch-shared/zfulop/hf_cache_dir'

date
export HF_DATASETS_CACHE=/scratch-shared/zfulop/hf_cache_dir
WORK_DIR=$HOME/adapt_med_seg
cd $WORK_DIR
module purge
module load 2023
source $WORK_DIR/.venv/bin/activate
python -m adapt_med_seg.eval \
    --model_name "segvol_context_prior" \
    --dataset_path /scratch-shared/zfulop/CHAOS \
    --modalities CT MRI unknown \
    --lora_r 16 \
    --lora_alpha 16 \
    --ckpt_path /home/zfulop/adapt_med_seg/logs/lightning_logs/version_1/checkpoints/epoch=1-step=24580.ckpt
    #--ckpt_path /home/zfulop/adapt_med_seg/logs/lightning_logs/version_0/checkpoints/epoch=0-step=1560.ckpt

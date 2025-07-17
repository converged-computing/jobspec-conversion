#!/bin/bash
#FLUX: --job-name=SegVolContextP
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3540
#FLUX: --urgency=16

export HF_DATASETS_CACHE='/scratch-shared/zfulop/hf_cache_dir'

date
export HF_DATASETS_CACHE=/scratch-shared/zfulop/hf_cache_dir
WORK_DIR=$HOME/adapt_med_seg
cd $WORK_DIR
module purge
module load 2023
source $WORK_DIR/.venv/bin/activate
CHECKPOINT_ARRAY=("--epochs 1"
"--ckpt_path /home/zfulop/adapt_med_seg/lightning_logs/version_$SLURM_ARRAY_JOB_ID/checkpoints/epoch=0-step=23.ckpt --epochs 2")
echo "These checkpoints will be passed to Lightning: "
echo "${CHECKPOINT_ARRAY[@]}"
python -m adapt_med_seg.train \
    --model_name "segvol_context_prior" \
    --dataset_path /scratch-shared/scur0402 \
    --modalities CT MRI \
    --max_train_samples 1 \
    --max_val_samples 1 \
    --max_test_samples 1 \
    --lora_r 16 \
    --lora_alpha 16 \
    --version_id $SLURM_ARRAY_JOB_ID \
    $CHECKPOINT_ARRAY

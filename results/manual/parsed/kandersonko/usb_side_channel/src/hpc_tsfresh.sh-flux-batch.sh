#!/bin/bash
#FLUX: --job-name=outstanding-house-9452
#FLUX: -t=43200
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
echo "JOB timestamp: $(date)"
echo "JOB ID: $SLURM_JOB_ID"
hostname
source ~/.bashrc
conda activate usb
python --version
which python
srun python tsfresh_feature_engineering.py \
    --target_label=category --dataset_subset=test \
    --workers=92 --memory='2GB' --chunk_size=10

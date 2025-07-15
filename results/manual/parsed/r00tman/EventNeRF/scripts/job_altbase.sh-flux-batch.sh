#!/bin/bash
#FLUX: --job-name=psycho-destiny-2443
#FLUX: --priority=16

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
python ddp_train_nerf.py --config configs/altbase.txt
echo Finished

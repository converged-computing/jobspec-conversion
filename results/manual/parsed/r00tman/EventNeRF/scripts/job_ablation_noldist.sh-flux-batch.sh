#!/bin/bash
#FLUX: --job-name=fuzzy-caramel-3460
#FLUX: --priority=16

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
python ddp_train_nerf.py --config configs/ablation/noldist.txt
echo Finished

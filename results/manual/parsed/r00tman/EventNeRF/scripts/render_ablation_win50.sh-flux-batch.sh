#!/bin/bash
#FLUX: --job-name=blank-lettuce-7248
#FLUX: --priority=16

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
python ddp_test_nerf.py --config configs/ablation/win50.txt --render_split train --testskip 10
python ddp_test_nerf.py --config configs/ablation/win50.txt --render_split drunk1 --testskip 10
echo Finished

#!/bin/bash
#FLUX: --job-name=expensive-chip-9284
#FLUX: --queue=gpu22
#FLUX: -t=3600
#FLUX: --urgency=16

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
python ddp_test_nerf.py --config configs/ablation/win50.txt --render_split train --testskip 10
python ddp_test_nerf.py --config configs/ablation/win50.txt --render_split drunk1 --testskip 10
echo Finished

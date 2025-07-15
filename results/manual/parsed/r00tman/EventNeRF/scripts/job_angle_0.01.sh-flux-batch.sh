#!/bin/bash
#FLUX: --job-name=pusheena-omelette-2044
#FLUX: --urgency=16

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
python ddp_train_nerf.py --config configs/angle/0.01.txt
echo Finished

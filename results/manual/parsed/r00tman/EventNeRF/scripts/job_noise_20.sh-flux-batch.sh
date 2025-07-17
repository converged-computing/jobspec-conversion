#!/bin/bash
#FLUX: --job-name=bloated-malarkey-1465
#FLUX: --queue=gpu20
#FLUX: -t=21600
#FLUX: --urgency=16

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
python ddp_train_nerf.py --config configs/noise/20.txt
echo Finished

#!/bin/bash
#FLUX: --job-name=tart-earthworm-6677
#FLUX: --queue=gpu22
#FLUX: -t=21600
#FLUX: --urgency=16

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
python ddp_train_nerf.py --config configs/e2vid/chair.txt
echo Finished

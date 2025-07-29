#!/bin/bash
#FLUX --job-name=hello-spoon-8588
#FLUX --queue=gpu22
#FLUX -t=21600
#FLUX --urgency=16

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
python ddp_train_nerf.py --config configs/real/sewing.txt
echo Finished

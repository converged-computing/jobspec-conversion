#!/bin/bash
#FLUX: --job-name=loopy-pot-7439
#FLUX: --priority=16

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
python ddp_train_nerf.py --config configs/nextnextgen/tapes.txt
echo Finished

#!/bin/bash
#FLUX: --job-name=LrgSklCNN
#FLUX: -N=2
#FLUX: -c=10
#FLUX: --priority=16

export MASTER_PORT='12349'
export WORLD_SIZE='2'
export MASTER_ADDR='$master_addr'

module purge
module load pytorch-gpu/py3/1.5.0
export MASTER_PORT=12349
export WORLD_SIZE=2
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
source ~/.bashrc
conda activate plifs
srun python -u trial_main_final.py --net cnn

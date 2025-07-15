#!/bin/bash
#FLUX: --job-name=predehaze
#FLUX: -c=40
#FLUX: -t=86400
#FLUX: --priority=16

export MASTER_PORT='12340'
export MASTER_ADDR='$master_addr'
export TORCH_DISTRIBUTED_DEBUG='INFO'

export MASTER_PORT=12340
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "Parent IP="$MASTER_ADDR
echo "Parent Port="$MASTER_PORT
module add gcc
export TORCH_DISTRIBUTED_DEBUG=INFO
srun python main.py --slurm_env_var --template Pre_Dehaze_revidereduced

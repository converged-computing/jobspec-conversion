#!/bin/bash
#FLUX: --job-name=nerdy-lettuce-7635
#FLUX: -N=8
#FLUX: -c=16
#FLUX: --priority=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source project_venv/bin/activate
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
module load cuda
srun -v python -u src/project_lightning.py --num_nodes=1 --num_devices=8

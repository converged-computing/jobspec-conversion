#!/bin/bash
#FLUX: --job-name=creamy-poo-7160
#FLUX: --queue=2080ti-long
#FLUX: --priority=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

conda activate embedding
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python3 train.py --gpus 4 --distributed_backend ddp --data_root /home/mprinzler/storage/iMaterialist --batch_size 16 $@

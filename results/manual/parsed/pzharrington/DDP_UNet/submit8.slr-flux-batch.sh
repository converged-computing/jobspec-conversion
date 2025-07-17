#!/bin/bash
#FLUX: --job-name=multi8
#FLUX: -c=80
#FLUX: --exclusive
#FLUX: -t=28800
#FLUX: --urgency=16

export HDF5_USE_FILE_LOCKING='FALSE'

module load pytorch/v1.4.0-gpu
export HDF5_USE_FILE_LOCKING=FALSE
srun python -m torch.distributed.launch --nproc_per_node=8 train.py --run_num=14 --config=multi8
date

#!/bin/bash
#FLUX: --job-name=single
#FLUX: -c=80
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

export HDF5_USE_FILE_LOCKING='FALSE'

module load pytorch/v1.4.0-gpu
module list
export HDF5_USE_FILE_LOCKING=FALSE
srun python -m torch.distributed.launch --nproc_per_node=1 train.py --run_num=09
date

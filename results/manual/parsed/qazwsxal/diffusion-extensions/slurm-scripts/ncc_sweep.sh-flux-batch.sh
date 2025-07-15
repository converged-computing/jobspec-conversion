#!/bin/bash
#FLUX: --job-name=tart-peas-7894
#FLUX: --priority=16

export HDF5_USE_FILE_LOCKING='FALSE'

source /etc/profile
module unload cuda
module load cuda/11.1
source .venv/bin/activate
export HDF5_USE_FILE_LOCKING=FALSE
wandb agent --count 1 "$@"

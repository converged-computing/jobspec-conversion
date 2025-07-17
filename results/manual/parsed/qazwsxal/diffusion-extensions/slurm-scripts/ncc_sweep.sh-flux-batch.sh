#!/bin/bash
#FLUX: --job-name=butterscotch-platanos-0352
#FLUX: -c=4
#FLUX: --queue=res-gpu-small
#FLUX: -t=43200
#FLUX: --urgency=16

export HDF5_USE_FILE_LOCKING='FALSE'

source /etc/profile
module unload cuda
module load cuda/11.1
source .venv/bin/activate
export HDF5_USE_FILE_LOCKING=FALSE
wandb agent --count 1 "$@"

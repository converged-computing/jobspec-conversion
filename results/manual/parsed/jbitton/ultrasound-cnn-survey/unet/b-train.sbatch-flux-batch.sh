#!/bin/bash
#FLUX: --job-name=unet-nerve
#FLUX: -t=36000
#FLUX: --priority=16

module purge
unset XDG_RUNTIME_DIR
if [ "$SLURM_JOBTMP" != "" ]; then
    export XDG_RUNTIME_DIR=$SLURM_JOBTMP
fi
module load python3/intel/3.6.3
module load cuda/9.0.176
module load cudnn/9.0v7.3.0.29
source env/bin/activate
python batch_norm_train.py

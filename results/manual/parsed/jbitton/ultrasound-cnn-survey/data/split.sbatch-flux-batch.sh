#!/bin/bash
#FLUX: --job-name=tf-unet-nerve
#FLUX: -t=36000
#FLUX: --priority=16

module purge
unset XDG_RUNTIME_DIR
if [ "$SLURM_JOBTMP" != "" ]; then
    export XDG_RUNTIME_DIR=$SLURM_JOBTMP
fi
module load python3/intel/3.6.3
source env/bin/activate
python split_train_test.py --data /scratch/jtb470/nerve_data/train --save /scratch/jtb470/nerve_split_data --split 10

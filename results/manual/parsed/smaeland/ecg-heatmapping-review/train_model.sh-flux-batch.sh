#!/bin/bash
#FLUX: --job-name=train-ecg
#FLUX: -c=8
#FLUX: --queue=dgx2q
#FLUX: -t=28800
#FLUX: --urgency=16

echo "Loading modules"
module use /cm/shared/ex3-modules/latest/modulefiles
module load slurm/20.02.7
module load pytorch-py37-cuda11.2-gcc8/1.9.1
if [ ! -f /usr/lib/x86_64-linux-gnu/libevent_core-2.1.so.6 ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/lib
fi
srun python train_medians.py -t qt -o stevennet_take5_x

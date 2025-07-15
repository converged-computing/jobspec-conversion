#!/bin/bash
#FLUX: --job-name=cnn-cifar100
#FLUX: -t=7200
#FLUX: --urgency=16

                                    # %x=job-name, %A=job ID, %a=array value, %n=node rank, %t=task rank, %N=hostname
                                    # Note: You must manually create output directory "logs" before launching job.
GPUS_PER_NODE=1
module load python/3.10.2
srun python ./cnn-cifar100.py \
        --gpus $GPUS_PER_NODE \
        --name "cnn-cifar100"
